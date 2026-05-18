---
status: active
created: 2026-05-04
updated: 2026-05-04
---
# Utopia — Memory Map & Data Model
> Every per-game variable Utopia uses, what it means, the per-player parallel-array convention, and the CP1610 idioms for storing 16-bit values in 8-bit memory. Until you have this, none of the later subsystems make sense.

**Links:** [Utopia README](./README.md), source: [`source/utopia.asm`](./source/utopia.asm)

## The platform constraint

The Intellivision CPU is the GI **CP1610** — a 16-bit ISA with eight 16-bit registers (R0–R7; R6 is stack, R7 is PC) and a 10-bit decode width. Memory comes in two widths depending on the segment: **System RAM** (`$0102`–`$01EF`, 240 words of 8-bit-wide RAM in the original Master Component) and **Graphics RAM (GRAM)** (`$3800`–`$39FF`, 512 cards of 8×8 graphics, half of it usable for sprites). There's also EXEC ROM at `$1000`–`$1FFF` and STIC registers at `$0000`–`$00FF`.

Utopia's per-game variables sit in the **8-bit System RAM** range, packed from `$15D` upward. Because the registers are 16-bit but main RAM is 8-bit, **every multi-byte value (population, gold, score) requires the SWAP idiom** to write the high byte separately. This is the dominant unfamiliar pattern for a 6502 reader.

The cartridge ROM lives at `$5000` and up. The header at `$5000`–`$5023` is a fixed Mattel-defined struct that the EXEC ROM reads on boot.

## How Utopia organizes state

Three layers:

1. **Per-player parallel arrays.** Almost every gameplay variable comes in a `_0` / `_1` pair (`SCOR_0` / `SCOR_1`, `POPU_0` / `POPU_1`, `GOLD_0` / `GOLD_1`, `FORT_0` / `FORT_1`, etc.). Player 0 is at the lower address; player 1 is one byte higher. This pattern recurs across **every game-state variable** — the game has no asymmetry between sides, so the data layout has none either.
2. **A single packed 9-building × 2-player array** at `$16F`–`$180`. Building counts (forts, factories, crops, schools, hospitals, houses, rebels, PT boats, fishing boats — exactly the keypad numbers 1–9) are stored as `address = $16D + item_type*2 + player`. One indexed access serves both per-type and per-player lookups.
3. **Scratch reuse for scoring.** When the per-round score is calculated for a player, three bytes (`H_SCOR`, `G_SCOR`, `F_SCOR`) and one helper (`N_FTRY`) get reused for whichever player is currently being scored. `CURPLR` flags which one. This is RAM-frugal in classic 8-bit fashion — no need to store both players' breakdowns simultaneously when you only ever compute one at a time.

## The two-byte-in-8-bit-memory idiom

The most surprising-to-a-6502-reader pattern in Utopia is how a 16-bit value is stored. Population is 16-bit (0–65,535) but RAM is 8-bit. From the boot init at line 285:

```asm
        ; Initialize population for both players
        MVII    #$03E8, R0              ; Initial population = 1000 ($03E8)
        MVO     R0,     POPU_0          ;   write low byte ($E8) to POPU_0
        SWAP    R0,     1               ;   swap byte halves: R0 now $E803
        MVO     R0,     POPU_0 + 1      ;   write low byte ($03) to POPU_0+1
        SWAP    R0,     1               ;   swap back so R0 is $03E8 again
        MVO     R0,     POPU_1          ;   repeat for player 1
        SWAP    R0,     1
        MVO     R0,     POPU_1 + 1
```

`MVO` always writes only the low 8 bits of the source register to memory. To store the high byte of a 16-bit value, you `SWAP` the register (rotate by one byte) so what *was* the high byte is now the low byte, then `MVO` again. The second `SWAP` restores the register so the next operation (writing player 1) starts from the original 16-bit value. **This four-instruction "store one 16-bit value to two consecutive bytes" pattern is the CP1610's equivalent of the 6502's `STA addr; LDA #hi; STA addr+1`.** Once you see it, you see it everywhere score and gold are touched.

## Variable map — `$15D`–`$1A4`

Grouped by subsystem so the gameplay structure is visible at a glance. Two-byte values are marked.

### Score & resources (`$15D`–`$16E`)

| Addr | Symbol | Meaning |
|---|---|---|
| `$15D`–`$15E` | `SCOR_0` | Player 0 total score (2 bytes) |
| `$15F`–`$160` | `SCOR_1` | Player 1 total score (2 bytes) |
| `$161` | `RSCO_0` | Player 0 round score (1 byte) |
| `$162` | `RSCO_1` | Player 1 round score (1 byte) |
| `$163` | `PRSC_0` | Player 0 previous-round score (1 byte) |
| `$164` | `PRSC_1` | Player 1 previous-round score (1 byte) |
| `$165`–`$166` | `POPU_0` | Player 0 population (2 bytes) |
| `$167`–`$168` | `POPU_1` | Player 1 population (2 bytes) |
| `$169` | `RGLD_0` | Player 0 gold acquired this round (1 byte) |
| `$16A` | `RGLD_1` | Player 1 gold acquired this round (1 byte) |
| `$16B`–`$16C` | `GOLD_0` | Player 0 current gold (2 bytes per equate; init writes only 1 — see Curiosities) |
| `$16D`–`$16E` | `GOLD_1` | Player 1 current gold |

### The 9-building × 2-player array (`$16F`–`$180`)

Indexed as `$16D + item_type*2 + player`. Item types are keypad numbers 1–9.

| Addr | Symbol | Item type |
|---|---|---|
| `$16F`–`$170` | `FORT_0` / `FORT_1` | 1: Fort |
| `$171`–`$172` | `FTRY_0` / `FTRY_1` | 2: Factory |
| `$173`–`$174` | `CROP_0` / `CROP_1` | 3: Crop |
| `$175`–`$176` | `SCHL_0` / `SCHL_1` | 4: School |
| `$177`–`$178` | `HOSP_0` / `HOSP_1` | 5: Hospital |
| `$179`–`$17A` | `HOUS_0` / `HOUS_1` | 6: House |
| `$17B`–`$17C` | `REBL_0` / `REBL_1` | 7: Rebel — *count never used (per source comment)* |
| `$17D`–`$17E` | `PTBO_0` / `PTBO_1` | 8: PT Boat — *count not accurately maintained, never consulted* |
| `$17F`–`$180` | `F_BO_0` / `F_BO_1` | 9: Fishing boat |

The fact that **rebels and PT boats have allocated slots but the counts are never read** is a tell about the design: rebels are gameplay events whose state lives elsewhere (probably as MOBs); PT boats are the same. The counters were either vestigial or kept for a debug/UI feature that didn't ship. Source comments call this out explicitly — a rare pre-existing acknowledgment of unused state.

### Per-round scoring scratch (`$181`–`$184`)

Reused per player during scoring; not parallel-arrayed because only one player is scored at a time.

| Addr | Symbol | Meaning |
|---|---|---|
| `$181` | `H_SCOR` | Housing score (current scored player) |
| `$182` | `G_SCOR` | GDP score (current scored player) |
| `$183` | `F_SCOR` | Food score (current scored player) |
| `$184` | `N_FTRY` | Number of factories (current scored player) |

The per-round score breaks down into three components — Housing, GDP, Food — implying the design intended players to optimize across **multiple resource axes** rather than a single score number. Building decisions trade off across these axes (more factories = more GDP but also more pollution / less food?). Chapter 5 will make the formulas explicit.

### Rebel system (`$185`–`$186`)

| Addr | Symbol | Meaning |
|---|---|---|
| `$185` | `RBLTRY` | Counter: try placing rebel up to 250 times |
| `$186` | `RBLTYP` | Mercenary or computer-generated rebel? |

`RBLTRY = 250` is a Monte-Carlo placement budget. Rebels need to land somewhere valid (probably on the opposing player's island, not in the water, not on top of an existing structure); the engine retries up to 250 random placements before giving up. This is the same probabilistic-with-rejection pattern that classic roguelikes use for room placement. Worth examining in Chapter 7.

### Per-player state (`$187`–`$18C`)

| Addr | Symbol | Meaning |
|---|---|---|
| `$187` | `CURPLR` | Player currently being processed / scored |
| `$188` | `CURSEL` | Current selection being processed |
| `$189` | `SLCT_0` | Player 0 current input selection |
| `$18A` | `SLCT_1` | Player 1 current input selection |
| `$18B` | `BARINH` | Inhibit gold-bar display if non-zero |
| `$18C` | `TICSEC` | Tic number within second (0..19) |

`TICSEC` confirms the **20 Hz tic rate** later seen at `TICTSK` — there are 20 tics per second.

### Round structure (`$18D`–`$192`)

| Addr | Symbol | Meaning |
|---|---|---|
| `$18D` | `REMSEC` | Remaining seconds this round |
| `$18E` | `CURTRN` | Current turn number |
| `$18F` | `NUMTRN` | Number of turns in the game (1–50, set at game start) |
| `$190` | `TRNLEN` | Length of each turn in seconds (30–120, set at game start) |
| `$191` | `TICINH` | Flag to inhibit timer-tick task |
| `$192` | `SC_TOT` | Display SCORES or TOTALS? |

The player chooses both **how many turns the game is** and **how long each turn is** at startup. The product determines total game length — design decision: the game self-tunes to player time budget rather than enforcing a fixed length.

### Fishing & weather (`$193`–`$1A1`)

| Addr | Symbol | Meaning |
|---|---|---|
| `$193` | `FISH_0` | Player 0 fishing time counter |
| `$194` | `FISH_1` | Player 1 fishing time counter |
| `$197` | `SNKFRM` | Animation frame # of sinking-ship animation |
| `$198` | `SNK_AT` | Offset into BACKTAB of sinking ship |
| `$199` | `SNKACT` | Is a "sinking ship" animation active? |
| `$19A` | `SNKCNT` | Frame-to-frame delay counter |
| `$19B` | `CURS_0` | Player 0 cursor mode (0=rectangle, 8=PT boat, 9=fishing boat) |
| `$19C` | `CURS_1` | Player 1 cursor mode |
| `$19D` | `TDMG_0` | Total weather damage accumulated for player 0 |
| `$19E` | `TDMG_1` | Total weather damage accumulated for player 1 |
| `$19F` | `DMG_RT` | Damage rate for the active storm |
| `$1A0` | `RCRP_0` | Rain-on-crop counter for player 0 |
| `$1A1` | `RCRP_1` | Rain-on-crop counter for player 1 |

Cursor mode 8/9 = "the player is placing a PT boat / fishing boat" — the cursor visually shows what's being placed. Modes 1–7 (the building items) presumably share the rectangle cursor (mode 0). One byte does double duty: state machine + sprite selector.

### Collision detection (`$1A3`–`$1A4`)

| Addr | Symbol | Meaning |
|---|---|---|
| `$1A3` | `CKAXIS` | Current axis for island/boat collision detection |
| `$1A4` | `SHPLOC` | Offset into BACKTAB that a boat overlaps |

Last variables before code starts at `$5000`. Total per-game state: **~70 bytes** out of the Master Component's 240 bytes of System RAM. Plenty of headroom.

## ROM header (`$5000`–`$5023`)

The Mattel-defined cartridge boot block. EXEC ROM jumps here on power-up.

```asm
.HEADER:
        BIDECLE .GFX_ANIM_5D1A  ; Ptr: MOB graphic images
        BIDECLE .TIMER          ; Ptr: EXEC timer table
        BIDECLE .START          ; Ptr: Start of game
        BIDECLE .GFX_LIST_5E4A  ; Ptr: Background graphics list
        BIDECLE .GRAM_INIT_5024 ; Ptr: GRAM init sequence
        BIDECLE .TITLE          ; Ptr: Date/Title block
        DECLE   $007E           ; Key-click / flags
        DECLE   $0000           ; Border extension
        DECLE   $0000           ; Color Stack / FGBG
        DECLE   $0001,  $0003   ; Color Stack init (0, 1)
        DECLE   $0001,  $0003   ; Color Stack init (2, 3)
        DECLE   $0001           ; Border color init

        ; Allocation of MOBs to GRAM slots
        DECLE   $01F0,  $01E0,  $01D0,  $01C0
        DECLE   $01B0,  $01A0,  $0190,  $0180
```

The MOB-to-GRAM allocation is **the key data structure for understanding what's on screen**. The Intellivision STIC has 8 hardware sprites (MOBs); each MOB needs a GRAM card slot to display from. The header reserves slots `$01F0` down to `$0180` for the 8 MOBs (16 bytes each = 8 cards × 2 bytes). The earlier source comment maps the MOB indices to game roles:

| MOB | Role |
|---|---|
| 0, 1 | Weather (storm graphics over each island) |
| 2, 3 | Player cursors / placement marks |
| 4, 5 | Pirates |
| 6, 7 | Fish |

So **two of each entity type, one per player side**. The symmetric layout extends from RAM all the way into hardware allocation.

`.TIMER` at `$501C` registers `TICTSK` (at `$51A3`) as the 20 Hz timer task. Interval = `$0001, $0000` = run on every timer tick. This is how the per-tic game logic gets called by the EXEC ROM — there's no main loop in the conventional sense; the EXEC schedules `TICTSK`.

## Game-start initialization

Player startup screens prompt for `NUMTRN` (1–50) and `TRNLEN` (30–120 seconds), then the game state initializes:

```asm
        ; Population starts at 1000 for each player
        MVII    #$03E8, R0              ; 1000
        MVO     R0,     POPU_0          ; write low byte
        SWAP    R0,     1               ; rotate
        MVO     R0,     POPU_0 + 1      ; write high byte
        SWAP    R0,     1               ; restore
        MVO     R0,     POPU_1          ; player 1
        SWAP    R0,     1
        MVO     R0,     POPU_1 + 1

        ; Turn timer set to TRNLEN
        MVI     TRNLEN, R1
        MVO     R1,     REMSEC

        ; Gold starts at 100 for each player
        MVII    #$0064, R0              ; 100 ($64)
        MVO     R0,     GOLD_0
        MVO     R0,     GOLD_1

        ; Initial selection cursor = $14 (= 20 decimal)
        MVII    #$0014, R0
        MVO     R0,     SLCT_0
        MVO     R0,     SLCT_1
```

Initial state per player: **1000 population, 100 gold, 0 of every building, selection cursor = 20**. The game is fully symmetric — no first-player advantage by data.

## Curiosities

**Gold is "two bytes" by equate but initialized as one byte.** The equate block says `GOLD_0 EQU $16B ; Current gold for player 0 (two bytes)`, but the init writes `MVII #$0064; MVO R0, GOLD_0` only — no `SWAP` and second `MVO` for the high byte. Either:

1. The high byte is assumed zero from the prior `CLRSCR`-equivalent zeroing (not seen yet — needs verification in chapter 4)
2. Gold is actually 8-bit and the comment is wishful documentation
3. Gold becomes 2-byte only after an increment that overflows the low byte

The increment routine `INC_GOLD` (label spotted in survey) will resolve this. Worth flagging now because it affects whether the player can ever *see* gold > 255 — a gameplay-relevant question that the source comment doesn't actually answer.

**`SLCT_0` initialized to `$14` (= 20 decimal) doesn't match item numbers 1–9.** Possibly an "off-menu" / no-selection sentinel value, or an internal index into a wider input table. Resolved in chapter 3 when the input dispatch is read.

**Rebel and PT-boat counters allocated but unused.** Source comments are explicit: `; The count for # rebels doesn't appear to be used.` and `; The count for PT boats isn't accurately maintained and never consulted.` Two `_0`/`_1` pairs of RAM that were never reclaimed when the corresponding game logic moved elsewhere. This is the kind of "maintenance debt as artifact" that a clean reverse-engineering exposes.

## LLM-interpretation log

| Source of understanding | Where it carried |
|---|---|
| **Source labels alone** | All variable names, the per-player `_0`/`_1` convention, the 9-building array layout, the 20 Hz tic rate, the round structure, the cursor-mode / item-number distinction. Source quality is exceptional — the equate block is essentially a memory-map document already. |
| **Source comments** | Item-number-to-keypad mapping, the `address = $16D + item_type*2 + player` formula, the "rebels never used" / "PT boats not maintained" discoveries, MOB allocation roles. The pre-existing commenter did most of the system-level documentation work; this chapter mostly organizes and presents it. |
| **CP1610 ISA knowledge required** | The `MVO` + `SWAP` two-byte-store idiom. `MVO` only writes 8 bits to memory regardless of register width; `SWAP R0, 1` rotates the register by one byte. Without knowing this, the population-init looks like nonsense (writing the same value twice, then swapping for no reason). Once seen, the pattern is unambiguous. |
| **External hardware knowledge required** | STIC MOB hardware (8 sprites, GRAM card backing). Mattel cartridge header format ($5000 boot struct). Both are documented in any Intellivision dev reference; minimal time-cost. |
| **Disagreements with source** | The "gold is two bytes" comment vs the one-byte init. Flagged as a chapter-4-or-5 resolution. |

Net: this chapter required almost no spelunking of the CP1610 ISA — the SWAP idiom is the only mechanical knowledge needed beyond what register names provide. **Hypothesis from the project README — that the source quality lets us read this game as a strategic engine without learning the 16-bit ISA in depth — is holding so far.**

## Tags

[games](../../../tags/games.md) · [strategy](../../../tags/strategy.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [llm-limitations](../../../tags/llm-limitations.md)
