---
status: active
created: 2026-05-05
updated: 2026-05-05
---
# M.U.L.E. — Input & Cursor Dispatch
> Brief Atari 800 input reference, then the cursor mechanic that drives both player movement AND auction bidding. The famous "walk up to set your bid" interaction. Difficulty-scaled cursor latency (`cursorWait` per level — Beginner/Standard/Tournament). Bringerp's CTU (Cursor Time Unit) is the abstraction over this layer.

**Links:** [M.U.L.E. README](./README.md), [Memory Map](./01-memory-map.md), [Display System](./02-display-system.md), [bringerp's CTU section](http://bringerp.free.fr/RE/Mule/mule_document.html#CursorTimeUnit), source: [`source/mule.asm`](./source/mule.asm)

## Atari 800 input architecture

The Atari 8-bit's input system spans two chips:

- **PIA** (the original Atari 400/800 controller chip) — provides 4 joystick ports with 4-direction sticks (`STICK0`-`3` shadow registers at `$0278`-`$027B`) and triggers (`STRIG0`-`3` at `$0284`-`$0287`).
- **POKEY** — provides up to 8 paddle inputs (`POT0`-`7` at `$D200`-`$D207`) returning analog 0-228 values. POKEY also handles keyboard scanning and the serial bus.

The POKEY registers are **dual-purpose**: write to `$D200` = AUDIO FREQUENCY channel 1 (`AUDF1`); read from `$D200` = paddle 0 position (`POT0`). The disassembler labels these as `OS_AUDF1_POT1` etc. to reflect both roles. Most of the writes we see in the source are *audio* output (sound effects, music); the paddle input is read from the same addresses.

## What M.U.L.E. uses

The Kroah annotations in zero page point at **paddles, not joysticks**:

```asm
00B2 byte_B2:.BYTE 1, 1, 1, 1      ; // [PLAYERS] paddle
00BB nbPaddles:.BYTE 0             ; // number of paddles connected
00E7 byte_E7:.BYTE 0               ; // paddle qui sera actif pour bouger
                                   ; ("paddle that will be active for movement")
```

Reading these literally, M.U.L.E. supports paddle input — analog precision for cursor control. **However**, the actual gameplay (per emulator-tested sources) uses joysticks. The most likely interpretation: "paddle" here is **the French/European generic term for "controller"**, and the per-player slots track joystick port assignments (1-4) rather than paddle position reads. The byte_B2 values `1, 1, 1, 1` look like port assignments rather than analog positions.

This is a reading gap worth flagging: **without running the game in an emulator and watching which registers it reads during input handling, we can't verify with certainty whether M.U.L.E. polls STICK0-3 or POT0-7**. Bringerp's CTU section likely clarifies; we'll defer to his documentation for the algorithmic layer.

## The cursor mechanic — input abstraction

M.U.L.E.'s gameplay is unified around a **cursor**: the on-screen marker the player moves to navigate the map, place MULEs, walk up to the auction line, and bid. The same cursor mechanism handles every player interaction. From the source:

```asm
B36D cursorWait:.BYTE 3            ; cursor speed (ticks between moves)
4721                               ; "Latencies times of the cursor according to the level"
```

`cursorWait` is the **per-tick latency between cursor steps**. At the start of the game, level (Beginner/Standard/Tournament — chapter 1) determines this value:

| Level | `cursorWait` (inferred) | Cursor speed |
|---|---|---|
| Beginner | high (slow movement, longer reaction time) | forgiving |
| Standard | medium | tuned |
| Tournament | low (fast movement, less reaction time) | demanding |

This is **difficulty as cursor reflex pressure**, not as game-state difficulty. Bunten's design choice: the underlying economic engine doesn't change between difficulties; only how much time the player has to react. Higher level = the cursor's thresholds (auction price clamping, MULE installation timing, Wampus catching) become tighter because the cursor moves faster relative to the action.

**This is genuinely elegant.** Most games scale difficulty by changing AI strength, resource availability, or enemy aggression. M.U.L.E. scales it by changing **how fast the cursor reacts to your input**, which means a Tournament player needs faster reflexes but the game's strategic decisions are identical. **The skill layer is purely physical reaction time, not strategic depth.**

## CTU — Cursor Time Unit

Bringerp's document identifies four nested time scales (Chapter 4 will cover them in detail):

- BTU = Base Time Unit (the underlying clock)
- PTU = Player Time Unit (per-player turn time)
- ATU = Auction Time Unit (the auction phase pacing)
- **CTU = Cursor Time Unit** (the rate at which the cursor advances per tick)

CTU is what `cursorWait` configures. It's the lowest-level time scale, used in the inner loops of:

- **Map navigation** (CTU sets how fast the player walks across tiles)
- **Auction bidding** (CTU sets how fast your bid line moves up/down — chapter 7)
- **Wampus pursuit** (CTU sets how fast the cursor advances when chasing)
- **Lands grant** (CTU sets cursor speed during the round-1 land selection)

**The cursor IS the player input.** There's no "press a key to do X" interface — every action is "move the cursor to where you want X to happen, then commit (button press)." This is fundamentally different from Utopia's keypad-driven build menu (Chapter 3 of Utopia: "press item number, press Enter"). In M.U.L.E., positioning the cursor *is* the choice; pressing the button is just the timing.

## Compare to Utopia's input model

| Aspect | Utopia | M.U.L.E. |
|---|---|---|
| Player count | 2 | 4 |
| Input device | Keypad + disc per player | Joystick (paddle?) per player |
| Action selection | Press number for item, then Enter | Walk cursor to target, press button |
| Build placement | Cursor-position-when-Enter-pressed | Cursor-position-when-button-pressed |
| Difficulty scaling | None at input layer | Cursor speed (CTU/cursorWait) |
| Auction bidding | N/A (no auctions) | Cursor up/down to set bid level |

**Utopia's input is symbolic; M.U.L.E.'s is positional.** Utopia separates *what* (item number) from *where* (cursor position); M.U.L.E. fuses them — your cursor's location *is* both the what and where. This is a more demanding input model (you have to navigate before committing) but it makes the auction system possible — the bid mechanic IS cursor positioning.

## Two action contexts the cursor serves

The cursor's behavior changes by game phase. From the byte-meaning-by-context idiom (Chapter 1), the same cursor variables drive different game-state machines depending on `typeAuction` and the current player turn state:

1. **Map mode** (player turn): cursor is the player's avatar walking the map. CTU scales how fast they cross tiles. Button = "do the action this tile allows" (install MULE, sell land, gamble at Pub).
2. **Auction mode** (`typeAuction = 0` for goods, `5` for lands): cursor is your bid level on a vertical price scale. CTU scales how fast the bid moves. Button = "commit at this price."

**Same cursor mechanism, two completely different game systems.** The auction chapter (Ch 7) will show this in detail; for now, the takeaway is that the cursor abstraction unifies what would be two completely separate interactions in most games.

## What this clarifies for later chapters

- **Chapter 4 (time scales)**: CTU is the lowest-level clock. Built on BTU. The cursor loop is what CTU clocks at.
- **Chapter 7 (auction)**: the bid mechanic IS the cursor running on CTU with bid-level as the position. Cursor speed = bid speed = how fast prices move.
- **Cursor latency = difficulty.** Tournament-level players have tighter timing windows for everything because their cursor moves faster. Worth mentioning in the synthesis chapter as a design pattern.

## Curiosities

**The "paddle/joystick" terminology gap.** Source says "paddle" but most M.U.L.E. documentation describes joystick play. Likely Kroah used French/European generic terminology. Worth verifying against Bringerp's English text; not a chapter blocker.

**CTU as the lowest time unit is unusual.** Most games' lowest time scale is the frame (60 Hz NTSC, 50 Hz PAL). M.U.L.E. introduces a sub-frame "cursor tick" abstraction that's slower than the frame rate but faster than the game-state tick. This is the analog-feel layer: the cursor moves smoothly, not in discrete jumps, even though the game state is discrete underneath.

**`cursorWait = 3` at the captured runtime state.** Defaults to Standard difficulty? Or this byte holds the *current* wait counter (counting down to 0 before next move)? Worth verifying in the cursor-update routine; for now treat as either initial config or running counter.

## LLM-interpretation log

| Source of understanding | Where it carried |
|---|---|
| **Source labels alone** | `cursorWait`, `nbPaddles`, `playersButtonPushed`. The cursor naming was pulled from a few labels; most of the cursor-handling code is at addresses without semantic names. |
| **Source comments (French)** | "vitesse du curseur" (cursor speed), "paddle qui sera actif pour bouger" (paddle that will be active for movement), the per-level latency comment. |
| **6502 / Atari ISA knowledge** | Standard memory-mapped I/O for STICK0-3 and POT0-7. Nothing new beyond Chapter 2's Atari refs. |
| **External knowledge required** | Atari 8-bit PIA + POKEY input architecture. The paddle/joystick distinction. The CTU concept came from bringerp's TOC, not source. |
| **Disagreements with source** | The "paddle" terminology in zero-page comments doesn't necessarily mean Atari paddle hardware — likely European "paddle" = "controller." Flagged as ambiguity. |

Net: this chapter is **mostly setting up the cursor abstraction for later chapters** (especially 7's auction). The actual input handler routines are short and live among un-labeled `byte_X` regions; bringerp's algorithmic doc is the better reference for what cursor positions mean in each game phase. **Source provides the addresses; bringerp provides the semantics.**

## Tags

[games](../../../tags/games.md) · [strategy](../../../tags/strategy.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [llm-limitations](../../../tags/llm-limitations.md)
