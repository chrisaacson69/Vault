---
status: active
created: 2026-05-05
updated: 2026-05-05
---
# M.U.L.E. — ANTIC/GTIA Display System
> Brief Atari 800 hardware reference, then identify the display list and screen-rendering pattern in `mule.asm`. Goal is **enough to read the game-logic chapters without spelunking display details** — not a deep tour of ANTIC. The Atari 8-bit display is more programmable than Intellivision's STIC and more flexible than NES's PPU; the cost is ~80 bytes of display list and a custom character set the cartridge brings along.

**Links:** [M.U.L.E. README](./README.md), [Memory Map](./01-memory-map.md), source: [`source/mule.asm`](./source/mule.asm)

## ANTIC + GTIA — what's different

The Atari 8-bit graphics architecture is **two chips with division of labor:**

- **ANTIC** = the *programmable* display processor. It reads a "display list" (a small program in RAM) every frame and tells GTIA what to render row-by-row. ANTIC supports 6 character modes and 8 bitmap modes; the display list can mix modes within a single screen (e.g., 1 row of mode 1 text + 20 rows of mode 6 characters + 4 rows of mode 0 status text). It also handles horizontal/vertical scrolling and triggers per-line interrupts (DLIs).
- **GTIA** = the *color* generator. It takes ANTIC's pixel stream and applies color via 8 color registers (4 playfield, 4 player/missile). It also handles the player/missile graphics (Atari's sprites) and collision detection.

**Compare:**
- **STIC** (Intellivision): one display mode, 240 BACKTAB cards, 8 MOBs. Simple but inflexible.
- **PPU** (NES): fixed nametable + sprite OAM, no programmable display list. Hardware scrolling but mode-locked.
- **ANTIC + GTIA** (Atari 8-bit): mode-mixed display list + 4 player sprites + 4 missile sprites + collision. **Most programmable of the three; also most setup-code per game.**

For M.U.L.E., this means the display chapter has to identify:
1. The display list (where ANTIC's program lives)
2. The character set (the custom font/tile graphics)
3. The screen-data area (the actual on-screen content ANTIC reads)
4. The DLI / VBI handlers (per-line and per-frame interrupts)

## OS shadow registers — what M.U.L.E. configures

From the captured zero-page state and OS area we mapped in Chapter 1:

| Addr | Symbol | Value | Meaning |
|---|---|---|---|
| `$022F` | `OS_SDMCTL` | `$3E` | DMA control: standard playfield + missile DMA + player single-line DMA + ANTIC DMA enable |
| `$0230` | `OS_SDLSTL` | `$1E75` | Display list start address |
| `$02C0`-`$02C3` | `OS_PCOLR0`-`3` | varies | Player/missile colors (one per Atari sprite) |
| `$02C4`-`$02C8` | `OS_COLOR0`-`4` | varies | Playfield colors (one per character-mode color) |
| `$02F4` | `OS_CHBAS` | `$18` | Character set base = `$1800` |

**The display list is at `$1E75`. The character set is at `$1800`.** These are both in the cartridge ROM area — M.U.L.E. ships its own font and screen layout, doesn't use the Atari OS character set.

## The display list at $1E75

Display list bytes from the source dump (decoded):

```asm
1E72   .BYTE $41        ; LMS + mode 1: 8-line blank with screen-load
1E73   .BYTE $50, $1E   ; → address $1E50 (start of screen data)
1E74   ...
1E75   .BYTE $00        ; (display list starts here per OS_SDLSTL)
1E76   .BYTE $60        ; mode 0 + DLI: 8 blank lines with display-list interrupt
1E77   .BYTE $70        ; VS bit + mode 0: vertical-scroll-enabled blank
1E78   .BYTE $70        ; (continued)
1E79   .BYTE $42        ; LMS + mode 2: 16-line text with screen-load
1E7A-7B .BYTE $00, $B5  ; → address $B500
1E7C   .BYTE $80        ; DLI on next blank
1E7D-7F .BYTE $20, $86, $86  ; (transition into main playfield mode 6)
1E80-90 .BYTE $86, $86, ...  ; mode 6 rows (4-color character mode) — the playfield
1E91   .BYTE $06        ; mode 6 (last playfield row before status area)
1E92   .BYTE $80        ; DLI
1E93-94 .BYTE $20, $70  ; (transition to status bar)
1E95-98 byte_1E95-1E98  ; (varies — status bar mode bytes)
```

Decoded structure:

| Region | Mode | Purpose |
|---|---|---|
| Top blank | mode 0 | 8 blank lines + DLI for color-change |
| Header text | mode 2 | 16-line text mode (the title/round-info bar) |
| Main playfield | mode 6 (×~20 rows) | 4-color character mode for the map and player sprites |
| Bottom status | mode 2 / 6 mix | Score/info display |

**Mode 6 is the workhorse** — character mode with 4-color tiles, used for the planet-surface map. Each on-screen tile is one byte in the screen-data area; ANTIC fetches the byte, looks it up in the character set at `$1800`, and produces an 8×8 pixel block.

The display list itself is **only ~30 bytes** — much smaller than the 60+ bytes you'd expect for a full game screen. ANTIC's instruction format is dense (one byte = one row's mode + flags), and screen-data loads only happen once per region (the LMS = "Load Memory Scan" instruction). After an LMS, ANTIC auto-increments through the screen-data area row by row.

The DLI bits (`$80` flag on bytes `$1E76`, `$1E7C`, `$1E92`) trigger interrupts at the boundaries between display regions — typically used to change colors mid-screen. M.U.L.E. uses these to give each display region a different palette without burning extra colors.

## The character set at $1800

The custom font occupies `$1800`-`$1FFF` (2 KB = 256 characters × 8 bytes). From the source:

```asm
1800 FONT:.BYTE 00000000b
1828 FONT_CHAR1:.BYTE 00000000b
1870 FONT_CHAR2:.BYTE 00000000b
1883 FONT_CHAR9A:.BYTE 01100110b
1884 FONT_CHAR9B:.BYTE 01100110b
1C48 FONT_CHAR5:.BYTE 00111100b
4282 FONT_CHAR8:.BYTE 00000000b
```

Most font bytes are auto-labeled (`.BYTE` rows with bit-pattern values). The `FONT_CHAR*` semantic labels mark glyphs that have specific game meaning (digits, presumably 0-9 for score display, plus a few special characters). The sprawling label addresses (`$1828`, `$1870`, `$1883`, etc.) suggest the character set isn't strictly sequential — the cartridge packed character glyphs into available slots wherever they fit.

## Screen data — the playfield comes from $B500

The display list's mode-2 LMS pointed at `$B500`. That's the **screen data** — the byte stream ANTIC reads to know which character to render in each tile position.

Looking at the M.U.L.E. screen layout: the planet map is roughly 21 wide × 17 tall = ~357 tiles. At 1 byte per tile, that's ~360 bytes of screen data. Plus the header text rows (40 wide × 1-2 rows = 40-80 bytes) and the bottom status (40 wide × 2-3 rows = 80-120 bytes). Total screen data: roughly 480-560 bytes, well within the 2 KB free RAM region (`$0400`-`$07FF`) — but actually living in cartridge ROM at `$B500` makes more sense for the static map.

**This is a significant architectural difference from Utopia.** Utopia's BACKTAB at `$0200`-`$02EF` was *runtime-mutable* — the game wrote tiles to BACKTAB to display buildings, ships, weather. M.U.L.E.'s screen data at `$B500` is *cartridge ROM* (or at least the base map is); changes to the display happen by:

1. **Player/missile graphics** (sprites) for moving entities (players, MULE in tow)
2. **Per-tile color/character changes** for terrain modifications (when a player builds a structure on a tile, the *character* doesn't change because it's ROM — only the *color* changes via per-tile color table)

This means **M.U.L.E.'s "build a thing on this tile" mechanic is implemented via color overlay, not character replacement.** The map tile graphics stay constant; the color machine signals ownership. Same insight as Utopia's bit-14-as-ownership trick, just expressed via Atari's color-stack architecture instead of Intellivision's display-word bits.

We'll verify this assumption when we read the build-a-MULE code in Chapter 5; for now it's the working hypothesis.

## What carries forward to later chapters

- **The display list at `$1E75` is glue** — it sets up ANTIC's screen layout once. Game logic doesn't reach into it during normal play.
- **The character set at `$1800` is glue** — defines the tile graphics. Game logic doesn't write here either.
- **The screen data at `$B500` is mostly static** (cartridge ROM) — the base planet map. Per-tile state changes happen via:
  - Player/missile sprites (Chapter 3 — the cursor/players, all 4 sprites used for the 4 players)
  - Per-tile color overlays (Chapter 5/7 — when buildings are placed)
- **DLI handlers** are wherever the display interrupts vector — `OS_VDSLST` at `$0200` was `$2D43`, so the DLI handler lives at `$2D43` in cartridge ROM. We won't read it in detail; bringerp's doc treats display rendering as implementation detail.

This chapter is enough background to understand "the game shows a tile at position X" without spelunking ANTIC's per-instruction execution. **The display layer is solved; chapters 4-8 can focus on the economic engine without revisiting ANTIC.**

## Curiosities

**ANTIC display lists are programmable in a way no other 8-bit console graphics chip is.** STIC and PPU lock you into one display mode for the whole frame; ANTIC lets you mix modes per row. M.U.L.E.'s display list takes advantage with a header text bar (mode 2), main playfield (mode 6), and footer status (mode 2 again) — three different rendering modes in one screen. **Don Daglow on Intellivision had to fit everything in BACKTAB tiles; Bunten on Atari got to choose render modes per region.**

**The character set is in cartridge ROM, not RAM.** This means M.U.L.E. cannot animate characters by editing the font — only by swapping which character index gets displayed. NES's CHR-ROM had similar limitation; CHR-RAM games could animate by writing to the character data, but cartridge cost limited this. Bunten chose the cheaper option.

**Player/missile graphics handle the moving entities.** The 4 Atari sprites (`PCOLR0`-`3`) map directly to the 4 game players — same architectural symmetry Utopia had with its 8 MOBs (2 weather + 2 players + 2 pirates + 2 fish). **One sprite per player is the natural design choice on a 4-sprite system for a 4-player game.**

**The DLI handler at `$2D43`** is presumably ~20-50 lines of color-register-changing code. Modern descendants of this trick: the famous "rainbow" effects in classic Atari demos work by having a DLI on every scan line that changes a color register. M.U.L.E. uses DLIs more sparingly — just at region boundaries to give each display section a different palette.

## LLM-interpretation log

| Source of understanding | Where it carried |
|---|---|
| **Source labels alone** | `OS_SDLSTL` = `$1E75` told us where the display list lives. `OS_CHBAS` = `$18` told us the character set is at `$1800`. The `FONT_CHAR*` labels marked semantic glyphs. |
| **Source comments** | Almost none for this chapter — display setup is glue and Kroah didn't annotate it. |
| **6502 / Atari ISA knowledge** | None new beyond Chapter 1. |
| **External hardware knowledge required** | **The bulk of the chapter.** Need to know what ANTIC display-list opcodes mean (LMS = `$01`, mode 0-15 in low nibble, DLI bit `$80`, VS bit `$10`, HS bit `$20`). Need to know GTIA color register layout. Need to know player/missile graphics architecture. ~30 lines of Atari hardware reference, all from De Re Atari or Atari Hardware Manual. |
| **Disagreements with source** | None — the source is just data here, no algorithmic claims to disagree with. |

Net: this is a **reference chapter**, not an analysis chapter. The point is to establish enough Atari display vocabulary that later chapters don't need to revisit. **Most of the content came from external Atari docs**, which is the expected pattern for "foreign system" chapters where the source has glue code and the hardware needs explanation.

## Tags

[games](../../../tags/games.md) · [strategy](../../../tags/strategy.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [llm-limitations](../../../tags/llm-limitations.md)
