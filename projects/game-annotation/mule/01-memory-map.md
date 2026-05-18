---
status: active
created: 2026-05-05
updated: 2026-05-05
---
# M.U.L.E. — Memory Map & Data Model
> The zero-page game state, the 4-player parallel-array convention (stride = 1 byte), the 4 goods encoding (Food/Energy/Smithore/Crystite = 0/1/2/3), and the **byte-meaning-by-context squeeze** that fits multiple game-phase state machines into the same 256 bytes. Where Utopia could afford bytes (240 of System RAM, ~70 used), M.U.L.E. punishes them — 4 players, 4 goods, multiple game phases, all sharing zero page.

**Links:** [M.U.L.E. README](./README.md), [Bringerp's M.U.L.E. document](http://bringerp.free.fr/RE/Mule/mule_document.html), source: [`source/mule.asm`](./source/mule.asm)

## The Atari 800 memory constraint

The 6502 has 256 bytes of fast-access zero-page memory (`$00`–`$FF`). The Atari OS reserves much of it: page 0 below ~`$80` is shared between the OS shadow registers (`OS_POKMSK` at `$10`, `OS_RTCLOK` at `$14`, etc.) and the game's working storage. M.U.L.E. uses zero page for **all** high-frequency game state — currentPlayer, current auction state, time-remaining counters, per-player flags. **Bigger structures live in the cartridge ROM area or in `$0400-$07FF` free RAM.**

The disassembly in `mule.asm` is a memory-dump style capture — every address from `$0001` through `$FFFF` has at least an annotation row. Most labels are auto-generated (`byte_X:`, `word_X:`, `unk_X:`); the ones with semantic names are either Atari OS shadows (`OS_*`) or Kroah's reverse-engineering work (the French RE researcher whose [public document](http://bringerp.free.fr/RE/Mule/mule_document.html) we use as the algorithm-layer reference).

**~72 game-specific semantic labels exist in the entire 50K-line file.** That's our starting backbone. The rest of the byte_X variables get inferred from how the code uses them (and Kroah's French annotations on individual addresses).

## The 4-player parallel-array convention

M.U.L.E. is fundamentally a 4-player game (1-4 humans + computer-controlled fillers). The data layout reflects this everywhere:

```asm
00B2 byte_B2:.BYTE 1, 1, 1, 1      ; [PLAYERS] paddle (one per player)
00B6 playersButtonPushed:.BYTE 0, 0, 0, 0
                                    ; 1: No, pas encore appuyé (not yet pressed)
                                    ; 0: Yes, déjà appuyé (already pressed)
00CC playersGoodReq:.BYTE 0, 0, 0, 0
                                    ; good required for current auction
00E8 byte_E8:.BYTE 0, 0, 0, 0      ; (purpose unclear, 4 bytes per player)
```

**Stride = 1 byte per player.** With 4 players, each parallel array is exactly 4 bytes — convenient, compact, accessible via `LDA arrayBase, X` indexed by `currentPlayer`. This is much tighter than Utopia's per-player 1-byte stride (which only had 2 players); M.U.L.E. just doubles the array length without changing the access pattern.

**Compare to Utopia:**
- Utopia: per-player stride of 1 byte for 1-byte values, 2 bytes for 2-byte values, with 2 players → arrays are 2 or 4 bytes
- M.U.L.E.: per-player stride of 1 byte for the common 1-byte values, with 4 players → arrays are 4 bytes
- Both: index = `LDX currentPlayer; LDA array, X` access pattern

The convention scales cleanly with player count. **Bunten kept Utopia-era data discipline; just changed the constants.**

## The 4 goods encoding

The economic model centers on four goods. From the byte_91 annotation:

```
00 = Food         (consumed every round; mandatory buyer-side load)
01 = Energy       (consumed for production; mandatory)
02 = Smithore     (used to make MULEs; speculative)
03 = Crystite     (purely speculative; only worth market value)
```

This is the **fundamental economic asymmetry** Bunten built in: two goods (Food/Energy) have *forced demand* every round; two (Smithore/Crystite) have *only speculative demand* via market price. A specialist on Food has guaranteed buyers; a specialist on Crystite has only price-bet against other Crystite players. **The strategic-frontier question — is the auction frontier flat or peaked? — is hardwired by this 0/1/2/3 ordering.**

The encoding is small enough (2 bits) to fit anywhere a byte is shared; the `playersGoodReq` array uses one byte per player, so each player's "what good am I bidding on?" state takes one slot from the 4-byte array.

## currentPlayer + the global game state vars

The Kroah-named vars at `$00AC`–`$00D3` are the **structural backbone** of the game state. These aren't per-player arrays — they're game-wide singletons that drive the global state machine.

| Addr | Symbol | Meaning |
|---|---|---|
| `$00AC` | `currentPlayer` | The player currently taking their turn (0-3) |
| `$00AF` | `byte_AF` | "good de la mule" — the good the current MULE is configured for |
| `$00B0` | `level` | 0 = Beginner, 1 = Standard, 2 = Tournament |
| `$00B1` | `numRound` | Round number (1-12) |
| `$00B2` | `byte_B2[4]` | Per-player paddle assignment |
| `$00B6` | `playersButtonPushed[4]` | Per-player auction-button state |
| `$00BB` | `nbPaddles` | Number of paddles connected (input config) |
| `$00BC` | `byte_BC` | `typeAuction` — 0 = good auction, 5 = land auction |
| `$00CA` | `nbLandsToSellByPlayers` | Lands offered for sale this auction round |
| `$00CC` | `playersGoodReq[4]` | Per-player required good for current auction |
| `$00D0` | `byte_D0` | Number of rounds remaining |
| `$00D1` | `byte_D1` | Initial number of rounds (game length config) |
| `$00D2` | `maxIndexCpu` | Index of highest CPU player (`-1` = all human) |
| `$00D3` | `byte_D3` | Time remaining for current player turn [0..101], min 10 at turn start |
| `$00E0` | `byte_E0` | 0 = alone without mule, 1 = carrying a mule |
| `$00E7` | `byte_E7` | Paddle that controls movement this turn |
| `$00F0` | `byte_F0` | Seller of the current land (`-1` = nobody) |

Two structural observations:

1. **The auction-mode flag (`typeAuction = 0|5`) is a single byte that switches the whole control flow.** The "5" for land auction (vs "0" for good auction) is meaningful — bits set vs cleared, easy to test with `BIT` instruction. Same byte, two different game-phase state machines hung off it.

2. **The time-remaining variable has minimum 10 at turn start.** Player gets at least 10 ticks of action before the timer can pressure them out. This is the **anti-tilt floor for individual turns** — same instinct Bunten/Daglow had for round-level recovery (Utopia's `+10 stipend`), now applied to per-turn pacing.

## Byte-meaning-by-context — the zero-page squeeze

The most striking design choice in M.U.L.E.'s memory layout is **how aggressively the same zero-page bytes serve different game phases.** From the source annotations:

- **`byte_91` is multipurpose.** Comments document at least two roles: "good in current auction (good à acheter/vendre)" AND "nb de terres restant a vendre dans land auction" (lands remaining to sell in land auction). The byte means *which good* during goods auctions and *how many lands left* during land auctions. **Same byte, mode-switched by `typeAuction`.**
- **`byte_9F` is multipurpose.** Comments: "tableau de 4 octets contenant les plots à choisir pour chaque joueurs" (4-byte array of plots to choose per player) AND "aussi playerX" (also playerX coordinate). Different game phases reuse the same memory.
- **`byte_A3` is multipurpose.** Comments: "playersOrder [PLAYERS]" (sorted player order: -1 not sorted, 0..3 first..last) AND "aussi playerY" (also playerY).
- **`byte_94` = "prodMax"** (production max for some computation).

This is **the same idiom we saw in Mappy** ("byte-meaning-by-context") taken to a much greater extreme. M.U.L.E. has 4 players × 4 goods × multiple game phases (lands grant / lands auction / player turn / production / round events / goods auction) all competing for 256 bytes of zero page. The compromise: **bytes serve one role *during a phase* and switch roles *between phases*.** Reading the code requires knowing which phase you're in to know which interpretation of a given byte applies.

Kroah's annotations expose this via the multi-line comments per address. Without those, the same byte_91 reference would be impenetrable — the bare `LDA byte_91; CMP #$04` in code could mean "is the current-auction good Crystite?" or "are there more than 4 lands left to sell?" depending on `typeAuction`. Same instructions, different meaning.

**This is the source-quality cost of M.U.L.E.'s ambition.** Utopia had ~70 bytes of game state and could afford clean naming. M.U.L.E. has 4 players + 4 goods + a richer game flow and squeezes meaning out of every zero-page byte through context-dependent reuse.

## Larger structures live outside zero page

Because zero page can't fit M.U.L.E.'s full state, the game pushes bigger structures up:

- **`$0400` `BUFFER_CONVERT_NUMBER`** — display-formatting buffer (number-to-glyph conversion). 1 KB free RAM region.
- **`$7B6B` `ROUND_EVENT_ADDR_L/H`** — random round-event dispatch table (in cartridge ROM). Maps directly to bringerp's "Random round event" section.
- **`$8308` `EVENTS_PLAYER_TEXT_ADDR_L/H`** — player-event text strings (in cartridge ROM).
- **`$B900` `GAME_SPR_MOUNT`, `$BA00` `GAME_SPR_RIVER`** — map sprites (terrain).
- **The 4×4 player×good inventory matrix** is somewhere we haven't located yet — almost certainly in the `$0400`-`$07FF` free RAM region or in cartridge work area. Will surface in chapter 5 when we read production code.

The OS area (`$0200`-`$03FF`) has many shadow registers used both by the OS interrupt handlers and the game (e.g., `OS_VDSLST`, `OS_SDMCTL`, `OS_PCOLR0`-`3` for player-graphics colors, `OS_COLOR0`-`4` for playfield colors). These are Atari-specific and part of the ANTIC/GTIA setup — covered in Chapter 2.

## Atari OS shadows — what zero page shares

Some `OS_*` labels in zero page are Atari OS shadow registers that the game reads/writes alongside the OS:

| Addr | Symbol | OS purpose |
|---|---|---|
| `$0010` | `OS_POKMSK` | POKEY interrupt mask shadow |
| `$0014` | `OS_RTCLOK` | Real-time clock (incremented every VBI) |

`OS_RTCLOK` is the most important — it's a 24-bit (3-byte) counter incremented at 60 Hz by the vertical-blank interrupt. **The game's time-remaining countdown almost certainly derives from this.** When we hit chapter 4 (the four nested time scales), this is one of the underlying clocks.

Compare to Utopia: Intellivision EXEC's TICTSK was the engine's only timer — the game-side code never read a free-running clock; it just got called back at 20 Hz. M.U.L.E. on Atari can either install its own VBI handler or just read `OS_RTCLOK` directly. We'll see which in chapter 4.

## What this chapter establishes for later ones

- **The 4-player × 4-good matrix is fundamental.** Every later chapter will reference per-player or per-good arrays. Stride is always 1 byte; goods are always 0=Food, 1=Energy, 2=Smithore, 3=Crystite.
- **The byte-meaning-by-context idiom is pervasive.** When chapter 5 or 7 reads `byte_91`, it could be either "good index" or "lands count" — context (`typeAuction`) determines which.
- **Kroah's annotations are the bridge.** The bare `byte_X` labels carry no semantic content; the French comments on individual addresses are what tell us a byte's role. This is the source's biggest quality-difference from Utopia — there, every variable had a real label; here, only the structurally-important ones do, and the rest emerge from comments scattered through the 50K lines.

## Curiosities

**The disassembly is a runtime memory snapshot, not just a ROM dump.** The values in zero page (e.g., `$00B0 level: 2` = Tournament mode, `$00B1 numRound: 0` = before round 1) are the *initial* state captured at boot or at some specific game moment. The disassembler chose to show address-by-address values rather than as separate code/data sections.

**The OS stack ($0100-$01FF) is captured with real return-address values** (line 310-311 of source: `$F7, $5C, $B5, ...`). This is forensic data — the dump was taken with the CPU mid-execution. Not chapter-relevant for game logic but a tell about how the disassembly was made.

**Kroah's annotations are bilingual.** Most are French (`nb de terres restantes`, `paddle qui sera actif pour bouger`); a few are English (`The number of the player taking his turn`). Interpreting the file requires light French — `nb` = "number of", `terres` = "lands", `tour` = "turn", `bouger` = "move". Not a barrier with translation help.

**`maxIndexCpu = -1` means "all human players."** A common 6502 idiom: signed -1 = unsigned 255. The Kroah annotation explicitly notes "[0; 3]: index max des cpus, -1: aucun cpus" — so the byte is interpreted as signed for this comparison. Worth remembering: M.U.L.E. variables are sometimes signed, sometimes unsigned, depending on context.

## LLM-interpretation log

| Source of understanding | Where it carried |
|---|---|
| **Source labels alone** | The Kroah-named structural variables (currentPlayer, level, numRound, typeAuction). |
| **Source comments (French)** | Every multi-purpose-byte finding (byte_91, byte_9F, byte_A3), the 4-good encoding, the typeAuction values, the playersOrder semantics, the time-remaining floor. **80%+ of the chapter's value comes from these comments.** |
| **CP1610 / 6502 ISA knowledge** | `BIT` for testing `typeAuction`. `LDA array, X` indexed addressing for parallel arrays. Signed-vs-unsigned interpretation (`-1` = `$FF`). All standard 6502 idioms — no Atari-specific ISA needed for this chapter. |
| **External hardware knowledge required** | Atari 800 zero-page convention (OS owns the lower portion; game uses upper). `OS_RTCLOK` as the 60 Hz VBI counter. ANTIC/GTIA color shadow register names (`OS_PCOLR0`-`3`, `OS_COLOR0`-`4`) — won't matter until chapter 2. |
| **Disagreements with source** | None. Where Kroah's annotations exist, they're consistent and accurate. The vast number of un-annotated `byte_X` slots is the gap, but those bytes are mostly scratch/work and not chapter-relevant. |

Net for the project hypothesis: **the M.U.L.E. source-quality story is different from Utopia's.** Utopia gave us comprehensive labels and we curated; M.U.L.E. gives us *focused* annotations on the structural bytes (the 50-or-so that drive the game) plus an external high-level document (Kroah's), and the rest of the bytes are mostly opaque. **The chapters get scaffolded by Kroah's algorithm doc; the source provides the address pinning and verification.**

## Tags

[games](../../../tags/games.md) · [strategy](../../../tags/strategy.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [llm-limitations](../../../tags/llm-limitations.md)
