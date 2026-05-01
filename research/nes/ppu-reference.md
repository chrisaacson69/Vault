---
status: reference
created: 2026-04-26
---
# PPU Reference (NES)
> Load-bearing facts about the Picture Processing Unit (Ricoh 2C02) for reading NES source code. Curated from nesdev.org/wiki.

**Links:** [NES Research](./README.md), [APU Reference](./apu-reference.md), [Mappers Reference](./mappers-reference.md), [TIA Reference (comparison)](../atari-2600/tia-reference.md), [6502 Annotation Series](../../projects/6502-annotation/README.md)

## The big picture — PPU is *not* a frame buffer (but kinda)

Unlike the TIA, the NES PPU has its own memory: pattern tables (tile bitmaps), name tables (which tile goes where), attribute tables (palette assignment per region), and OAM (sprite list). The CPU writes into this memory through the PPU's register interface; the PPU then renders 60 fps without further CPU intervention.

But it's not a true frame buffer either. The CPU **cannot freely write to PPU memory while rendering** — VRAM access is gated to vertical blank (~20 scanlines per frame, ~2,273 CPU cycles). And clever programmers learned to write to PPU registers *during* the visible region to get effects the basic mode can't produce: mid-frame palette changes, scroll splits (status bar separate from playable area), MMC3 IRQ-triggered raster effects. **The beam-racing returns**, but as an option for tricks rather than a fundamental requirement.

## The chip and its clocks

- **Ricoh 2C02 (NTSC).** Separate from the CPU; runs at 3× the CPU clock (1 CPU cycle = 3 PPU cycles).
- **CPU**: 1.79 MHz NTSC (Ricoh 2A03).
- **341 PPU dots per scanline = 113.667 CPU cycles per scanline.**

## NTSC frame structure

| Region | Scanlines | Notes |
|---|---|---|
| Pre-render | 1 (line 261) | Dummy line; preps first two tiles |
| Visible | 240 (lines 0–239) | Picture; PPU is busy |
| Post-render | 1 (line 240) | Idle |
| **VBlank** | **20 (lines 241–260)** | **CPU's window for VRAM updates** |
| Total | 262 | 60 fps NTSC |

VBlank ≈ 20 × 113.667 = 2,273 CPU cycles per frame for VRAM writes, OAM updates, scroll setup, and game logic. Compare Adventure's ~5,000 cycles for *all* game logic — NES has less off-screen time but the PPU does the hard work the TIA didn't.

## Synchronization — the NMI

Unlike the 2600's 6507, the NES's 2A03 **has interrupts**. The PPU asserts NMI at the start of VBlank (scanline 241, dot 1) **if** PPUCTRL bit 7 is set. The standard pattern:

- Main loop runs game logic indefinitely.
- NMI handler fires at VBlank, does everything that needs frame-perfect timing: OAM DMA, VRAM updates, scroll register writes, then RTI.

This is why most NES code structure is "infinite main loop + NMI handler that does the per-frame work." Compare Adventure's manually-counted frame structure (chapter 2) — the NMI is doing the bookkeeping the 6507 had to do by hand.

**Polling PPUSTATUS for VBlank is unreliable** — you can miss it. Always use NMI for frame timing.

## PPU registers (CPU-mapped, $2000–$2007 + $4014)

| Addr | Name | R/W | Purpose |
|---|---|---|---|
| `$2000` | PPUCTRL | W | NMI enable, sprite size, pattern table select, VRAM increment, base name table |
| `$2001` | PPUMASK | W | Background/sprite enable, leftmost-8-pixel masks, color emphasis, greyscale |
| `$2002` | PPUSTATUS | R | VBlank flag (cleared on read), sprite 0 hit, sprite overflow |
| `$2003` | OAMADDR | W | OAM byte index for next OAMDATA access |
| `$2004` | OAMDATA | R/W | Read/write OAM byte at OAMADDR (use OAMDMA in practice) |
| `$2005` | PPUSCROLL | W ×2 | X scroll then Y scroll (twice-write latch) |
| `$2006` | PPUADDR | W ×2 | High byte then low byte of VRAM address (twice-write latch) |
| `$2007` | PPUDATA | R/W | Read/write VRAM at current address; auto-increments |
| `$4014` | OAMDMA | W | Source page (high byte) for fast 256-byte OAM upload |

### PPUCTRL ($2000) bit layout — `VPHB SINN`

- **V** (bit 7): VBlank NMI enable
- **P** (bit 6): Master/slave (never set on stock consoles)
- **H** (bit 5): Sprite height (0=8×8, 1=8×16)
- **B** (bit 4): Background pattern table address (0=$0000, 1=$1000)
- **S** (bit 3): Sprite pattern table address (0=$0000, 1=$1000) — ignored in 8×16 mode
- **I** (bit 2): VRAM increment (0=+1 horizontal, 1=+32 vertical)
- **NN** (bits 1–0): Base name table (0=$2000, 1=$2400, 2=$2800, 3=$2C00)

### PPUMASK ($2001) bit layout — `BGRs bMmG`

- **BGR** (bits 7–5): Color emphasis (PAL swaps R/G)
- **s** (bit 4): Sprite enable
- **b** (bit 3): Background enable
- **M** (bit 2): Show sprites in leftmost 8 pixels
- **m** (bit 1): Show background in leftmost 8 pixels
- **G** (bit 0): Greyscale

Common idiom: write `$00` to disable rendering during long VRAM transfers; write `$1E` (`0001 1110`) to re-enable both sprites and background with no leftmost mask, no color emphasis, no greyscale.

### PPUSTATUS ($2002) bit layout — `VSO- ----`

- **V** (bit 7): VBlank flag — **cleared on read**
- **S** (bit 6): Sprite 0 hit
- **O** (bit 5): Sprite overflow

**Reading PPUSTATUS clears the internal `w` write-latch** (shared with PPUSCROLL and PPUADDR). Standard NMI-handler opening is `LDA $2002` to reset the latch.

## The twice-write latch (PPUSCROLL / PPUADDR)

Both share an internal flip-flop **w**. First write goes to one latch, second to the other; the latch toggles. Any read of PPUSTATUS resets w to 0. This is *the* PPU footgun:

- Forgetting to clear the latch → scroll/address writes go to wrong half.
- Reading PPUSTATUS in the middle of a sequence resets the latch mid-write.
- Mid-frame writes for scroll splits require precise w-state management.

## Scrolling (the v/t/x/w internal model)

The PPU has internal registers **v** (current VRAM address, 15 bits), **t** (temporary VRAM address), **x** (fine X scroll, 3 bits), **w** (write-toggle, 1 bit). Writes to PPUSCROLL/PPUADDR/PPUCTRL update t and x; certain events copy t into v.

Scrolling is "set t for next-frame target, let v get copied at the right moment." Mid-frame scroll splits (e.g., status bar that doesn't scroll) work by carefully writing PPUSCROLL or PPUADDR mid-frame to override v. **The famous `v <- t` copy at dot 257 of pre-render lets you split the screen.**

## OAM and OAMDMA

- 256 bytes of internal Object Attribute Memory holds 64 sprites × 4 bytes (Y, tile, attributes, X).
- **OAMDATA writes are too slow** for whole-OAM updates during VBlank.
- **OAMDMA ($4014)** copies a 256-byte CPU page to OAM in **513–514 CPU cycles**. Standard pattern: maintain a "shadow OAM" in CPU RAM at page $0200 (or any aligned page); during NMI, write `$02` to $4014 to upload it.
- Write `$00` to OAMADDR before OAMDMA to avoid the 2C02G's OAMADDR-write corruption bug.

### Sprite limits

- 64 total sprites in OAM.
- **8 sprites per scanline.** A 9th sprite on the same line is dropped (or causes flicker if the game cycles which 8 are eligible — the same inter-frame rotation idea Adventure uses, applied to sprites).
- 8×8 or 8×16 modes (PPUCTRL bit 5).

## Pattern tables and name tables

- **Pattern tables** at PPU $0000 and $1000 — the tile bitmaps. 256 tiles × 16 bytes each = 4 KiB per table, 8 KiB total. For NROM, this is read-only CHR-ROM.
- **Name tables** at PPU $2000, $2400, $2800, $2C00 — 32×30 grid of tile indices = 960 bytes per name table, plus 64 bytes of attribute data.
- **Attribute tables** at +$3C0 of each name table — 2-bit palette select per 16×16 region.
- **Palettes** at PPU $3F00–$3F1F — 4 background palettes + 4 sprite palettes, 4 colors each.

The **pattern tables are CHR-ROM (or CHR-RAM)** — for simple mappers like NROM, this is an 8 KiB chip on the cartridge. Mappers add bank-switching to swap tile sets mid-game.

## Sprite 0 hit — the timing primitive

PPUSTATUS bit 6 sets when a non-transparent pixel of sprite 0 overlaps a non-transparent background pixel. This is detectable by the CPU and is the standard way to **trigger a mid-frame event at a specific scanline** without needing a mapper IRQ. Status-bar games place a small invisible sprite at the boundary; the CPU spins reading PPUSTATUS until bit 6 sets, then writes new scroll values for the post-status-bar region.

## VRAM access window (the actual constraint)

Direct PPUDATA writes work cleanly **only when rendering is off** (PPUMASK bits 3–4 cleared) **or during VBlank**. Writing during the visible region produces garbage and "glitchy increments" of OAMADDR.

So the practical pattern:
1. NMI fires at start of VBlank.
2. NMI handler does OAMDMA, then PPUDATA writes (palette updates, name table patches), then scroll setup.
3. RTI before VBlank ends (~2,273 cycles total budget).
4. Main loop runs game logic until next NMI.

## Cycle budget per frame (NTSC)

- Total frame: ~29,780 CPU cycles (1.79 MHz / 60 Hz).
- VBlank window: ~2,273 cycles for VRAM/OAM/scroll work.
- Visible region: ~27,507 cycles for game logic (AI, physics, input, music, etc.).

Compare Adventure: ~5,000 cycles for game logic per frame. NES has **5–6× more CPU time for game logic** because the PPU does the rendering work the TIA forced the CPU to do by hand. This is the capability shift that lets NES games carry richer state machines, scripted events, and longer sequences — the storytelling-vs-logic axis.

## Comparison to TIA at a glance

| Aspect | TIA (2600) | PPU (NES) |
|---|---|---|
| Memory | None — CPU writes registers in real time | 8 KiB CHR-ROM/RAM + 2 KiB name table RAM + 256 B OAM |
| Sprites | 2 player + 2 missile + 1 ball | 64 sprites OAM, 8 per scanline |
| Sprite size | 8 wide × variable | 8×8 or 8×16, configurable |
| Color | 1 per sprite + playfield | 4 palettes × 4 colors per sprite, configurable per 16×16 region |
| Scrolling | None — every pixel is hand-drawn | Hardware scrolling with v/t/x/w |
| Frame sync | WSYNC + manual cycle counting | NMI at VBlank |
| Mid-frame tricks | Required for any non-trivial graphics | Optional, for scroll splits / palette tricks |

The TIA forces beam-racing; the PPU rewards it (when used by experts). Same chip family, totally different relationship between CPU and graphics hardware.

## Tags

[6502](../../tags/6502.md) · [reverse-engineering](../../tags/reverse-engineering.md)
