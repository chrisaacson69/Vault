---
status: reference
created: 2026-04-26
---
# TIA Reference (Atari 2600)
> Load-bearing facts about the Television Interface Adaptor for reading 2600 source code. Curated from Stella Programmer's Guide and TIA hardware notes.

**Links:** [6502 Annotation Series](../../projects/6502-annotation/README.md), [Adventure Display Kernel](../../projects/6502-annotation/adventure/02-display-kernel.md)

## The big picture

The TIA has **no frame buffer**. It has registers describing "what's on the screen *right now*" — playfield bits, sprite graphics bytes, sprite X positions, colors. The CPU updates these registers as the electron beam moves across the picture. The picture is generated *by* the CPU keeping pace with the CRT.

The 6507 CPU runs at **1.19 MHz** (NTSC). Each scan line is **76 CPU cycles** = **228 color clocks** (3:1 ratio). Of that, **68 color clocks ≈ 22.6 CPU cycles is HBLANK** (beam off-screen), and **160 color clocks ≈ 53.3 CPU cycles is visible**.

## NTSC frame structure

| Region | Lines | Notes |
|---|---|---|
| VSYNC | 3 | Tells CRT to retrace to top |
| VBLANK | 37 | Beam off-screen at top; safe for game logic |
| Visible | 192 | Picture; CPU must feed TIA every line |
| Overscan | 30 | Beam off-screen at bottom; safe for game logic |
| **Total** | **262** | 60 fps NTSC |

## Synchronization

### `WSYNC` — Wait for Sync

Write any value to `$02`. CPU halts until the **next HBLANK begins** (start of next scan line). This is the cheapest sync primitive: no clock, no interrupt, just a register write that suspends the CPU.

### `INTIM` / `TIM64T` (RIOT, technically)

`TIM64T` (`$0296`) starts a countdown that decrements `INTIM` (`$0284`) once every 64 CPU cycles. Write `N` to `TIM64T` → get `N × 64` cycles of countdown. Polling `INTIM` for zero is how Adventure budgets game logic during off-screen regions.

## Sprite positioning — `RESPx` and `HMxx`

The TIA has **no "set sprite X" register.** Position is set by *when* you write to `RESP0`/`RESP1`/`RESM0`/`RESM1`/`RESBL` — the write latches the sprite's X position to wherever the beam currently is.

- `RESP0`/`RESP1` take **5 color clocks of latency** to take effect (4 CLK reset + 1 CLK latch). The sprite appears **5 pixels right** of the actual reset point.
- The CPU runs at 1 cycle per 3 color clocks, so **5 CPU cycles ≈ 15 pixels of beam travel**. This is the minimum granularity of coarse positioning.

### Fine adjustment via `HMOVE`

`HMP0`/`HMP1`/`HMM0`/`HMM1`/`HMBL` hold a **signed nybble in the high 4 bits** (range −8 to +7 pixels). Writing to `HMOVE` (`$2A`) applies all five offsets at once.

- `HMOVE` **extends the next HBLANK by 8 color clocks** (so 76 visible cycles become 68).
- After `HMOVE`, the `HMxx` registers must not be modified for **~24 CPU cycles** or behavior is undefined.
- `HMCLR` (`$2B`) zeros all five offsets.

### The classic positioning idiom

To put a sprite at column N:
1. Burn (N / 15) cycles in a counted loop after `WSYNC`.
2. Write `RESPx` — sprite latches at coarse position (multiple of 15 pixels).
3. Put (N mod 15) into the high nybble of `HMxx`.
4. `STA HMOVE` next line — fine offset (±7 pixels) commits.

Five sprite types share the same indexing pattern: `STA RESP0,X` with X = 0/1/2/3/4 hits `RESP0`, `RESP1`, `RESM0`, `RESM1`, `RESBL`. One routine positions everything.

## Sprite graphics — `GRP0`, `GRP1`, `VDEL01`

Each player sprite is **8 pixels wide, 1 byte at a time**. Writing `GRP0` ($1B) sets the *current* sprite pattern; the TIA repeats it on every scan line until you change it.

### Vertical delay (the double-buffer trick)

Each player has two register copies: "new" (just written) and "old" (previous). `VDEL0` ($26 bit 0) and `VDEL1` ($26 bit 1) select which copy is displayed.

Critically, **the "old" copy of GRP1 updates only when GRP0 is written** (and vice versa). With `VDEL1 = 1`:
- Write `GRP1` — buffered into the "new" copy, not displayed yet.
- Write `GRP0` — commits both: GRP0's new value AND GRP1's previously-buffered value.
- Both sprites change atomically on the same scan line.

Adventure relies on this. The kernel writes GRP1 on one scan line (buffered), then writes GRP0 on the next (commits both). Without VDEL01, mid-line writes to GRP1 would smear.

## Playfield — `PF0`, `PF1`, `PF2`, `CTRLPF`

The playfield is **20 bits wide per half-screen**: PF0 contributes 4 visible bits, PF1 contributes 8, PF2 contributes 8. Each bit displays as **4 color clocks ≈ 4 NTSC pixels wide**, giving 80 color clocks per half = 160 color clocks = full visible width.

### `CTRLPF` ($0A)

| Bit | Name | Effect |
|---|---|---|
| 0 | REF | If 1, right half is **mirrored** copy of left. If 0, right half is **repeated** copy. |
| 1 | SCORE | Left half uses P0 color, right half uses P1 color (used for score displays). |
| 2 | PFP | Playfield priority over players (1) or under (0). |
| 4–5 | BALL | Ball width: 1, 2, 4, or 8 color clocks. |

Adventure rooms set REF=1 → walls are symmetric (left mirrors to right). This is *why* every Adventure room is left-right symmetric.

### Bit ordering (gotcha)

PF0 displays its **upper 4 bits**, ordered **left-to-right starting with bit 4** (so bit 4 is leftmost). PF1 displays all 8 bits, **left-to-right starting with bit 7** (MSB first). PF2 displays all 8 bits, **left-to-right starting with bit 0** (LSB first — *opposite* of PF1). Reading raw `.byte` data of room graphics requires knowing this.

## Ball, missiles — `ENABL`, `ENAM0`, `ENAM1`

- `ENABL` ($1F) bit 1 enables/disables the ball.
- `ENAM0` ($1D), `ENAM1` ($1E) bit 1 enable/disable missiles 0 and 1.
- Ball uses playfield color (`COLUPF`); missiles use their player's color.

In Adventure, the **ball renders the man** (the player avatar). The two TIA player sprites are reused for whatever room contents are visible.

## Sprite copies — `NUSIZ0`, `NUSIZ1`

`NUSIZ0` ($04), `NUSIZ1` ($05) configure number of player copies (1, 2, or 3) and their spacing (close = 17 pixels, medium = 33, far = 65), plus missile width.

## Collision detection

TIA hardware tracks all 15 pairwise collisions between Player0/1, Missile0/1, Ball, and Playfield. Read via `CXP0FB`, `CXP1FB`, `CXM0FB`, `CXM1FB`, `CXBLPF`, `CXPPMM` ($30–$37). `CXCLR` ($2C) resets all collision latches — Adventure does this every frame at line 70.

## Console & input — `SWCHA`, `SWCHB` (RIOT)

- `SWCHA` ($0280) — joystick directions for both players in one byte. Bits are **active-low** (pressed = 0).
- `SWCHB` ($0282) — console switches: reset, select, B&W (bit 3), difficulty L/R.
- `INPT4`, `INPT5` ($3C, $3D) — joystick fire buttons.

## Cycle budget per scan line

```
76 CPU cycles total per line
├─ 22.66 cycles HBLANK (covers beam retrace)
└─ 53.33 cycles visible

After HMOVE: HBLANK extended by 8 CLK → 25.33 cycles HBLANK, 50.66 visible
```

The kernel's job: between two `WSYNC`s (= one scan line), do all required register writes such that they take effect at the right beam positions. Playfield writes can be done during HBLANK; sprite resets must be at the precise beam column where the sprite should appear.

## Tags

[atari-2600](../../tags/atari-2600.md) · [6502](../../tags/6502.md) · [reverse-engineering](../../tags/reverse-engineering.md)
