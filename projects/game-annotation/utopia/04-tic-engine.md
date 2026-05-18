---
status: active
created: 2026-05-04
updated: 2026-05-04
---
# Utopia — The Tic Engine
> What runs every 1/20th of a second. The probability budget of the world (rain 1%, fish 5%, pirates 1%, the 1-in-12 hurricane). The 4-MOB collision loop with look-ahead-by-one. A bug that the original author flagged but never fixed. How a 20 Hz tic clock collapses into a 1 Hz game clock and an end-of-round transition.

**Links:** [Utopia README](./README.md), [Memory Map](./01-memory-map.md), [Display & Tile System](./02-display-and-tiles.md), [Input & Control Dispatch](./03-input-and-dispatch.md), source: [`source/utopia.asm`](./source/utopia.asm)

## TICTSK is the world

The Intellivision EXEC ROM fires `TICTSK` every 1/20 of a second (20 Hz, confirmed by the source comment: `;; TIMER TIC TASK -- called once per tic (20Hz)`). This is the *only* time-based loop in Utopia — input handlers from Chapter 3 fire reactively, but anything that happens "on its own" (weather drifts, fish appear, pirates show up, time runs out) flows through TICTSK.

The structure of one tic:

```
TICTSK:
  if TICINH set: return
  ── Per-tic weather (1% spawn, otherwise update) ──
  ── Per-tic fish (5% spawn, otherwise update) ──
  ── Per-tic pirates (1% spawn, otherwise update) ──
  ── Island-collision check for all 4 movable MOBs ──
  → STAT_TIC
        increment TICSEC (0..19)
        if not second boundary: STAT_UPD_FULL; return
        decrement REMSEC
        if REMSEC > 0: STAT_UPD_FULL; return
        ── End of round ──
        play tone; score; increment CURTRN
        if CURTRN >= NUMTRN: end of game
        else: REMSEC = TRNLEN (start next round)
```

Most ticks (95% of them) are "spin the random dials, maybe update a velocity, run collision checks, refresh the display." The interesting structural work — second tick, end-of-round scoring, end-of-game — happens at 1 Hz frequencies inside that 20 Hz loop.

## The probability budget of the world

The single most useful artifact to extract from TICTSK is the **per-tic probability table**. Every world event is gated by a `JSR X_RAND2` call asking for a random number in some range, then branching on the result. Translating these into per-second and per-minute frequencies:

| Event | Probability source | Per tic | Per sec | Per minute |
|---|---|---|---|---|
| New weather spawns | `rand(0..99) == 0` | 1% | 20% | ~12 |
| Spawned weather is hurricane | `rand(0..11) == 0` | (of those) 8.3% | — | ~1 |
| Spawned weather is rain | `rand(0..11) in 4..11` | (of those) 66.7% | — | ~8 |
| Spawned weather is tropical storm | `rand(0..11) in 1..3` | (of those) 25% | — | ~3 |
| Existing weather changes velocity | `rand(0..9) == 0`, per MOB | 10% | 200% | many |
| New fish spawns | `rand(0..19) == 0` | 5% | 100% | ~60 |
| New pirates spawn | `rand(0..99) == 0` | 1% | 20% | ~12 |
| Pirate changes velocity | `rand(0..9) == 0`, per MOB | 10% | 200% | many |

(Per-minute counts assume the world is empty enough to actually accept new spawns; in practice the spawn loops bail early when MOB slots are full — only 2 of each entity type can exist at once.)

Two design takeaways:

1. **Fish are 5× more common than weather or pirates.** Fish are the safe, beneficial event; weather and pirates are threats. The world rolls hits *against* the player one-fifth as often as it rolls neutral content. This is what makes Utopia feel less hostile than its mechanics suggest — most rolls produce things that *help* you (fishing → gold).
2. **Hurricane is genuinely rare.** 8.3% of weather events × 1% per tic = 0.083% per tic = roughly **one hurricane every 1200 tics = once every minute**. Combined with the bounded-by-MOB-availability constraint, you might see 2–3 hurricanes per round of 60–120 seconds. Memorable, threatening, but not common enough to feel oppressive.

## How weather actually spawns

The weather block:

```asm
L_51AA: MVII    #$0064, R0          ; rand(0..99)
        JSR     R5,     X_RAND2
        TSTR    R0
        BEQ     L_51C6              ; if 0, try to spawn new weather
        B       L_51F8              ; else, update existing weather

L_51C6: MVII    #$031D, R1          ; point to weather MOB 0
L_51C8: JSR     R5,     X_MOB_ACT   ; is it allocated?
        BEQ     L_51D5              ; no: this slot's free, spawn here
        ADDI    #$0008, R1          ; \_ check MOB 1
        CMPI    #$0325, R1          ;  |
        BEQ     L_51C8              ; /
        B       L_51F8              ; both busy: skip spawn
```

When the dice say "spawn weather," the engine walks the two weather MOB slots (0 and 1) looking for an inactive one. Found one → fall through to the spawn code. Both busy → skip silently. **No queueing of pending weather events.** If both slots are occupied when the 1% trigger fires, that weather event is just lost. This caps the world's hostility: at most 2 active weather systems, no matter how many 1% rolls land while both are running.

The weather-type roll (rain vs tropical storm vs hurricane) happens *after* a slot is found:

```asm
L_51D5: ...                          ; init MOB skeleton
        MVII    #$000C, R0           ; rand(0..11)
        JSR     R5,     X_RAND2
        TSTR    R0
        BNEQ    L_51B4               ; non-zero: rain or tropical storm
        ; fall through: hurricane (R0 == 0)
        MVII    #$5D11, R1           ; hurricane ROM data
```

```asm
L_51B4: MVII    #$5D08, R1           ; rain ROM data
        MVI@    R2,     R3
        CMPI    #$0004, R0           ; \_ R0 in 1..3? tropical storm
        BLT     L_51C2               ; /  R0 in 4..11? rain
        XORI    #$0117, R3           ; tropical storm: grey color
        ...
L_51C2: XORI    #$0107, R3           ; rain: black color
```

So one `rand(0..11)` call partitions into three weather types via uneven slicing — **0 = hurricane (1 outcome), 1–3 = tropical storm (3 outcomes), 4–11 = rain (8 outcomes)**. Probabilities 8.3% / 25% / 66.7% are the result of the table layout, not separate calls. Cheaper than three separate dice rolls and reads cleanly in code (`BLT $0004` after the first compare).

## The fish spawn — corner-of-the-screen pattern

Fish work the same way (1-in-20 trigger, walk MOB slots 6 and 7 for a free one). When a fish does spawn, the placement code (`L_526A`) does something memorable:

```asm
L_526A: PSHR    R5
        PSHR    R1
        MOVR    R1,     R2
        MVII    #$0008, R0          ; rand(0..7) → save on stack
        JSR     R5,     X_RAND2
        PSHR    R0

        MVII    #$0002, R0          ; rand(0/1) → top or bottom?
        JSR     R5,     X_RAND2
        TSTR    R0
        BEQ     L_5284              ; bottom edge

        PULR    R0                  ; top edge: Y in 8..15
        ADDI    #$0008, R0
L_5280: SWAP    R0,     1
        MVO@    R0,     R2          ; set Y coord

L_528B: ...                          ; X side: rand(0/1) → left or right
```

Fish always spawn **at one of four corners** (top-left, top-right, bottom-left, bottom-right), with random Y jitter (8 pixels) within the corner band, and a slow horizontal velocity (±3) that drifts them across the map. The same `L_526A` routine is reused to spawn pirates (`JSR R5, L_526A` at line 695 — `B L_5236` after pirate setup jumps right back into the fish update code, then falls through). **One spawn-at-corners utility serves both fish and pirates** — the only difference between them is the MOB attribute setup that happens before calling it.

Why corners? Probably visual clarity (always entering from off-screen, never popping into the middle) and gameplay fairness (equal chance of approaching each player's island).

## The 4-MOB collision check — what keeps boats off islands

Every tic, the engine walks four MOBs (player 0, player 1, pirate 0, pirate 1) and asks "is this MOB about to sail into land?" The cursor MOBs are skipped — they fly over everything. Fish are skipped too — they pass through islands. Just the boats (player and pirate) get the land check.

```asm
        ; Island / (Boat, Fish) collision checks
        MVII    #$032D, R1          ; player 0 MOB data
L_52FC: MOVR    R1,     R2
        ADDI    #$0001, R2
        MVI@    R2,     R4
        SDBD
        CMPI    #$5CB5, R4          ; \_ is it a cursor?
        BEQ     L_530B              ; /  yes: skip
        PSHR    R1
        JSR     R5,     L_5320      ; collision check
        PULR    R1
L_530B: ADDI    #$0008, R1
        CMPI    #$0335, R1          ; check player 1
        BEQ     L_52FC

        MVII    #$033D, R1          ; pirate 0 MOB data
L_5313: PSHR    R1
        JSR     R5,     L_5320      ; collision check
        PULR    R1
        ADDI    #$0008, R1
        CMPI    #$0355, R1          ; check pirate 1, fish 0, fish 1
        BLE     L_5313
        B       STAT_TIC
```

Wait — the second loop runs from `$033D` to `$0355` inclusive (`BLE`), which covers pirates AND fish. Did fish actually get checked? Looking at L_5320 in detail — it does an early-out check whether the MOB has zero velocity, which fish *do* have (they always drift), so they're checked too. **The "boat-vs-land" enforcer accidentally enforces "fish-vs-land" too.** This is why fish swim *around* islands instead of through them.

## L_5320 — look-ahead by one card, plus a confessed bug

The collision routine itself is the meatiest single subroutine in the tic engine. The architecture:

1. Unpack the MOB's X/Y velocity
2. Get the BACKTAB card under the MOB's center (via `MOB_TO_CARD`)
3. **Look one tile ahead in the direction of travel** (left/right/up/down based on velocity sign and current axis)
4. Read that look-ahead card via `GRAM_OR_GROM` → if GROM, it's "open seas" or status bar; if GRAM, it's something physical
5. If it's a building/island tile (and not a friendly boat), **nudge the MOB one pixel back** and zero its velocity on that axis
6. Update X-mirror flag (which way the sprite faces) based on velocity sign
7. Loop for the other axis (X then Y)

The "look-ahead by one" is what enables the source's most evocative comment:

```asm
        ; Look ahead of direction boat is traveling by one card.
        ; Note, this look-ahead is the reason you can't sail dead-on
        ; toward an island, but you can get close to the shore if you
        ; come in from the side.
```

A boat heading east checks the tile to its east; if that's land, it stops. But a boat heading southeast checks both east *and* south — it gets stopped on whichever axis hits land first, then continues sliding along the other. This produces the characteristic "boats glide along coastlines" feel without any explicit shoreline pathfinding.

And — best of all — the source author flagged a real bug they didn't fix:

```asm
        ; Negative velocity tests:
        CMPI    #$00A0, R2          ; Greater than or equal to 160?
        BGE     L_53AA              ; Yes: No update.
                                    ; Bug here: Shouldn't this be 96
                                    ; when testing Y axis?
```

`$00A0` = 160 = the screen width. The check is "if the boat is past the right edge of the screen, don't bother nudging." Reasonable for the X axis. But the **same constant is used for the Y check** — and the Intellivision screen is only 96 pixels tall, not 160. So **boats moving north can't run off the top correctly**, and the "off-screen no-nudge" guard fires 64 pixels later than it should on the Y axis. The author noticed this in an annotation pass but it shipped uncorrected. Forty-five years later, it's an artifact of "good enough for 1981" — a real game would have caught this in QA, but Utopia's scale and pacing made it not matter.

## STAT_TIC — collapsing 20 Hz into 1 Hz

After all the world updates, control reaches `STAT_TIC`:

```asm
STAT_TIC:
        MVI     TICSEC, R0
        INCR    R0
        CMPI    #$0014, R0          ; 20?
        BNEQ    L_53E5
        CLRR    R0                  ; roll back to 0
L_53E5: MVO     R0,     TICSEC

        TSTR    R0
        BNEQ    STAT_UPD_FULL       ; not at second boundary: just refresh display

        ; Once per second: count down REMSEC
        MVI     REMSEC, R0
        DECR    R0
        TSTR    R0
        BNEQ    L_5403              ; more time: save and refresh

        ; End of round!
        JSR     R5,     L_5FEF      ; end of round tone
        JSR     R5,     L_59CD      ; score end of round
        MVI     CURTRN, R1
        INCR    R1                  ; advance turn counter
        MVO     R1,     CURTRN
        B       L_5429              ; round-display flow

L_53FD: CMP     NUMTRN, R1          ; end of game?
        BGE     L_547E              ; → final score, return to EXEC
        MVI     TRNLEN, R0
L_5403: MVO     R0,     REMSEC      ; reset round timer
```

The structure is **three nested clocks**:

| Clock | Period | What it does |
|---|---|---|
| **Tic** | 1/20 sec | World update (weather, fish, pirates, collision) |
| **Second** | 1 sec | Decrement REMSEC; refresh status bar timer display |
| **Round** | TRNLEN sec | Tone, score round, increment CURTRN, reset REMSEC |

Game-over check fires when `CURTRN >= NUMTRN` — the player picked both at game start (Chapter 1's `TERM OF OFFICE` and `TURN LENGTH` prompts). Total game duration = `NUMTRN × TRNLEN` seconds. **The player tunes the entire game length explicitly.** A 5-turn × 30-second game is 2.5 minutes; a 50-turn × 120-second game is 100 minutes. Same engine, ten orders of magnitude of pacing flexibility.

## STAT_UPD_FULL — the 20 Hz display refresh

`STAT_UPD_FULL` is what runs every tic that *doesn't* cross a second boundary:

```asm
STAT_UPD_FULL:
        JSR     R5, STAT_UPD_TIME   ; turns/seconds remaining
        JSR     R5, STAT_UPD_GOLD   ; gold bars
        J       L_54E8              ; sinking ship animation
```

Three jobs: time display, gold display, and the **sinking-ship animation** — an explicit bit of work that runs *outside* the MOB system. When a fishing boat gets destroyed by a pirate or hurricane, the engine sets `SNKACT = 1` and uses the per-tic `L_54E8` path to advance a frame counter and update the BACKTAB tile to the next sink-animation card.

```asm
L_54E8: MVI     SNKACT, R2
        TSTR    R2
        BNEQ    L_5555              ; if active: advance animation
        PULR    R7                  ; otherwise: nothing to do
```

This is the **only non-MOB animation in the game**. Everything else moves via MOB hardware (sprites with their own velocity registers). The sinking ship draws directly into BACKTAB because it's destroying a tile-grid object — there's no MOB to animate, so the engine pokes the next graphic in by hand each tic until the ship is gone.

## INC_GOLD — what awards gold every fish catch

When a parked fishing boat reaches its 50-tic interaction threshold (Chapter 6 will detail the parking mechanics), it calls `INC_GOLD`:

```asm
INC_GOLD:
        PSHR    R5
        MVII    #GOLD_0,R4
        JSR     R5,     L_5A29      ; resolve player offset
        SDBD
        MVI@    R4,     R1
        INCR    R1                  ; +1 gold
        SUBI    #$0002, R4
        MVO@    R1,     R4          ; \_ store 16-bit GOLD with the
        SWAP    R1,     1           ;  |  Chapter-1 SWAP idiom
        MVO@    R1,     R4          ; /
        MVII    #RGLD_0,R1
        ADD     CURPLR, R1
        MVI@    R1,     R2
        INCR    R2
        MVO@    R2,     R1          ; +1 to round-gold counter (1-byte)
        PULR    R7
```

This **answers the open question from Chapter 1**: gold IS 16-bit. The init wrote only the low byte because the high byte was already zero (from the system-RAM clear at boot). `INC_GOLD` uses the full SWAP idiom for the increment — so when gold rolls past 255, the high byte starts incrementing properly. **Players can accumulate up to 65,535 gold bars.** With one bar awarded every 50 fish-tics (= 2.5 seconds of parked fishing), that's a theoretical ceiling far above what any realistic game would reach.

`RGLD_0`/`RGLD_1` (round-gold) is 1-byte and gets reset each round. Round-gold appears to feed into round scoring (Chapter 5).

## Curiosities

**The cursor is checked-against-cursor in the collision loop.** The check `CMPI #$5CB5, R4` matches the cursor MOB's ROM data pointer — if the MOB is using cursor graphics, skip collision. This means **boats are distinguished from cursors by which graphics table they reference**, not by a flag bit. Same MOB slot can become a cursor or a boat depending on the ROM pointer field. Chapter 6 will make this explicit.

**Fish accidentally get land collision.** The pirate-loop continues through MOB 6/7 (the fish slots) because it uses `BLE` instead of `BEQ` against the boundary. Since L_5320 doesn't bail on fish specifically, fish *do* get the same boat-collision treatment — which produces the "fish swim around islands" behavior. Designed accident or accidental design? The source has no comment either way.

**SDBD prefix everywhere now feels like punctuation.** After three chapters, the SDBD-MVII pattern is so frequent it almost reads like English. Pattern recognition compounds.

**The `MVII #$0064, R0; JSR X_RAND2; TSTR R0; BEQ ...` idiom appears 4 times in TICTSK alone.** "Roll a percent and branch on success" is Utopia's universal probabilistic-event grammar. A modern language would express this as `if (random() < 0.01) { ... }`. The CP1610 needs four instructions but the structure is identical.

## What this clarifies for later chapters

- **Chapter 5 (building economy)**: scoring runs at end of round (CURTRN advance), driven by `L_59CD`. Round-gold (`RGLD_n`) feeds into the score formula. Building counts (`FORT_n`, `FTRY_n`, etc.) become the score inputs at that boundary.
- **Chapter 6 (MOBs / world)**: the corner-spawn pattern, the "MOB ROM pointer determines which tables drive behavior" idea, and the fish/pirate parallel are all from L_526A and the per-tic update loops.
- **Chapter 7 (rebels)**: rebels presumably use the same MOB infrastructure but are gated by `RBLTRY` (250 placement attempts) instead of the simpler corner-spawn. Their probability gate (we haven't seen yet) connects here.
- **Chapter 8 (round/scoring)**: `L_59CD` (end-of-round scoring) and `L_5429` (round-display flow) are the two routines that drive the round transition. End-of-game (`L_547E`) closes by disabling controllers and returning to EXEC.

## LLM-interpretation log

| Source of understanding | Where it carried |
|---|---|
| **Source labels alone** | The TICTSK structure, STAT_TIC's three-nested-clocks role, INC_GOLD, the four-MOB collision loop. The label naming carries 80% of the meaning. |
| **Source comments** | The four-corner spawn pattern, the look-ahead-by-one collision logic, the 1-in-12 hurricane chance, the **explicit bug annotation** (the `$00A0` vs `$0060` Y-axis confession). The author's own comments delivered the most interesting findings. |
| **CP1610 ISA knowledge required** | `BLE` for `<=` (signed). `INCR R; CMPI #N; BNEQ` as the canonical "increment-and-wrap counter" idiom. `X_RAND2`, `X_MOB_ACT`, `X_INIT_MOB`, `X_PACKBYTES`, `X_UNPKBYTES` are EXEC ROM utilities — their interfaces (R0 = arg, R0 = return) are convention, not docs. |
| **External hardware knowledge required** | EXEC ROM timer task interface (the `.TIMER` block in the cartridge header registers `TICTSK` for 20 Hz callbacks). MOB record layout (8 bytes per MOB, fields at offsets 0/1/2/3/4/5 = attributes/ROM-ptr/X/Y/velocity/animation). The `X_MOB_ACT` / `X_INIT_MOB` semantics. ~30 lines of Intellivision dev-ref total. |
| **Disagreements with source** | None this chapter — the comments were either accurate or self-correcting (the bug confession). One omission: the two-byte boundary value `$0355` in the second collision loop covers fish slots 6/7, but the source comment says only "Pirate 1 and both fish" without explicitly noting that **fish therefore get collision-checked too**. The behavioral consequence (fish swimming around islands) was ours to deduce. |

Net: the per-tic engine is the most behaviorally rich chapter so far, and the source labels + author comments did the heaviest lifting. The probability budget table is the most useful artifact for understanding game balance — and falls out trivially once you grep for `JSR R5, X_RAND2`. **Source quality continues to make the project hypothesis hold: this game can be read at the engine level without learning the CP1610 ISA in depth.**

## Tags

[games](../../../tags/games.md) · [strategy](../../../tags/strategy.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [llm-limitations](../../../tags/llm-limitations.md)
