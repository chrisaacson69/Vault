---
status: reference
created: 2026-04-26
published: true
layout: layouts/page.njk
title: "NES Mappers Reference"
---
# NES Mappers Reference
> The cartridge logic that extends the NES beyond its base 32 KiB PRG / 8 KiB CHR address space. Curated from nesdev.org/wiki — currently covering NROM (Mappy's mapper). Will grow as we cover more games.

**Links:** [NES Research](./README.md), [PPU Reference](./ppu-reference.md), [APU Reference](./apu-reference.md), [Game Annotation Series](../../projects/game-annotation/README.md)

## Why mappers exist

The NES's 6502-derived 2A03 has the same 16-bit address space as any 6502 (64 KiB). The cartridge connector exposes:
- **PRG** (program ROM) at CPU `$8000–$FFFF` — 32 KiB max without help.
- **CHR** (character/pattern ROM) at PPU `$0000–$1FFF` — 8 KiB.

To ship a game bigger than 32 KiB code or 8 KiB graphics, the cartridge needs hardware to swap banks of ROM into the addressable window. That hardware is the **mapper** — extra logic on the cartridge PCB. NES games are categorized by which mapper their cartridge uses.

Mappers range from "no extra logic" (NROM) to "30+ KiB SRAM with battery, IRQ generator, expanded audio, and PPU snooping" (MMC5).

## NROM — the simplest cartridge

**The mapper that isn't.** No bank-switching logic at all. The cartridge is just ROM chips wired straight to the bus.

### NROM-128 (16 KiB PRG)

- CPU `$8000–$BFFF`: 16 KiB PRG-ROM
- CPU `$C000–$FFFF`: same 16 KiB PRG-ROM, mirrored
- PPU `$0000–$1FFF`: 8 KiB CHR-ROM (fixed)
- Mirroring (nametables): horizontal or vertical, set by board
- **No registers, no IRQs, no audio expansion.**

### NROM-256 (32 KiB PRG)

- CPU `$8000–$FFFF`: 32 KiB PRG-ROM (no mirroring; whole space)
- PPU `$0000–$1FFF`: 8 KiB CHR-ROM
- Otherwise identical to NROM-128.

### Reset/IRQ vectors

The 6502 reads its reset and interrupt vectors from the top of memory:
- `$FFFA–$FFFB`: NMI vector (PPU VBlank handler)
- `$FFFC–$FFFD`: Reset vector
- `$FFFE–$FFFF`: IRQ/BRK vector

For NROM-128, these are physically the last 6 bytes of the 16 KiB PRG. For NROM-256, they're the last 6 bytes of the 32 KiB PRG.

### Notable NROM games

- **Super Mario Bros.** — NROM-256
- **Donkey Kong** — NROM-128
- **Excitebike** — NROM-128
- **Galaxian** — NROM (8 KiB, smallest)
- **Mappy** — NROM-128 (Namco arcade port to Famicom; 16 KiB PRG + 8 KiB CHR)
- **Ice Climber, Balloon Fight, Wrecking Crew, Clu Clu Land** — all early Nintendo first-party NROM titles

The NROM era is essentially "first 18 months of NES" — anything before MMC1 took over for bigger games.

### What you can fit in NROM-128

- 16 KiB code budget — comparable to ~4× Adventure (4 KiB).
- 8 KiB CHR — 256 background tiles + 256 sprite tiles (each 16 bytes, 8×8).
- 2 KiB internal NES RAM ($0000–$07FF, mirrored).
- 256 bytes of OAM for sprites.
- 2 KiB of name table RAM (one nametable + mirror, depending on mirror mode).

The NES still forces you to be efficient at NROM scale, but it's a different scale — "tight enough to require care" instead of Adventure's "tight enough to require ingenuity in every byte." The capability budget moved from "every cycle counts" to "every kilobyte counts."

## Bank-switching mappers (to be expanded)

Larger games use mappers that put a register at some address in the cartridge's CPU window. Writing to that register selects which 8/16/32 KiB ROM bank appears in the addressable window.

**Common mappers we'll cover later in the series:**

- **MMC1 (mapper 1)** — Zelda, Metroid, Final Fantasy. 5-bit serial-write register; banks PRG and CHR; configurable mirroring.
- **UNROM (mapper 2)** — Mega Man, Castlevania, Contra. PRG-only banking; 16 KiB swappable + 16 KiB fixed.
- **CNROM (mapper 3)** — small CHR-only banking.
- **MMC3 (mapper 4)** — Super Mario Bros. 3, Mega Man 3+, Kirby's Adventure. Granular CHR + PRG banking, **scanline IRQ counter** (the big one — enables status bars and parallax without sprite 0 hit).
- **MMC5 (mapper 5)** — Castlevania III. Most complex stock mapper; expanded audio, scanline IRQs, vertical split, ExRAM.

Each mapper extends what's possible — but the **fundamental NES limits don't change**. Same CPU clock, same PPU rendering, same 240-line frame, same OAM constraints, same audio. Mappers add ROM/RAM/IRQ; they don't change the chip relationship the programmer is working with.

## How mapper choice constrains game design

Worth keeping in mind across the series:

- **NROM (Mappy, SMB, Donkey Kong)**: ~16 KiB code, fixed CHR. Engine has to be tight; level data has to be compressed; all art is loaded at game start.
- **UNROM (Castlevania)**: PRG can be 256 KiB (16 banks × 16 KiB). Tons of code/level-data space. CHR is RAM, dynamically updated — gives flexibility but eats CPU during transfers.
- **MMC1 (Zelda)**: PRG and CHR both bankable. Save data via WRAM with battery. Enables RPG-scale games.
- **MMC3 (SMB3)**: scanline IRQ → status bar that doesn't scroll; small CHR banks → animated tiles by swapping pattern bytes. The mapper enables the *style* of game.

Mappers are part of game design, not just delivery infrastructure.

## Tags

[6502](../../tags/6502.md) · [reverse-engineering](../../tags/reverse-engineering.md)
