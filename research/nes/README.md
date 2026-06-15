---
status: reference
created: 2026-04-26
published: true
layout: layouts/page.njk
title: "NES — Reference Material"
permalink: /research/nes/
---
# NES — Reference Material
> Chip-level facts about the Nintendo Entertainment System / Famicom (Ricoh 2A03 + 2C02 + cartridge mapper). Curated from nesdev.org/wiki for use across the [Game Annotation Series](../../projects/game-annotation/README.md).

**Links:** [PPU Reference](./ppu-reference.md), [APU Reference](./apu-reference.md), [Mappers Reference](./mappers-reference.md), [TIA Reference (comparison)](../atari-2600/tia-reference.md), [Game Annotation Series](../../projects/game-annotation/README.md)

## The NES platform

| Component | Detail |
|---|---|
| CPU | **Ricoh 2A03** — 6502 core with integrated APU; 1.79 MHz NTSC |
| Picture | **Ricoh 2C02 PPU** — separate chip; 5.37 MHz (3× CPU) |
| Audio | **APU** (inside the 2A03) — 5 channels |
| Internal RAM | 2 KiB ($0000–$07FF, mirrored to $0800–$1FFF) |
| Pattern/name table RAM | 2 KiB on PPU bus |
| Cartridge | PRG ROM + CHR ROM/RAM + optional mapper logic |

## Comparison to the Atari 2600 family

The NES uses a **different 6502 variant** than the 2600. Both are 6502-derivatives; the differences matter for source reading:

| Aspect | Atari 2600 (6507) | NES (2A03) |
|---|---|---|
| 6502 core | Yes | Yes |
| Address lines | 13 (8 KiB max) | 16 (full 64 KiB) |
| Decimal mode (BCD) | Present | **Removed** (Ricoh disabled the BCD circuitry to dodge MOS's patent) |
| IRQ / NMI | **Neither exposed** | Both available; NMI from PPU VBlank, IRQ from APU/mapper |
| Stack | Mirrors to RIOT RAM via partial decode | Standard $0100–$01FF |
| RAM | 128 bytes (RIOT) | 2 KiB internal + cartridge expansion |
| Audio | TIA (2 channels, 32 pitches) | APU (5 channels, real envelopes, samples) |
| Graphics | TIA (no frame buffer, beam-racing required) | PPU (own memory, frame-driven via NMI) |

The 2A03's "no decimal mode" is the famous Ricoh amputation — relevant because if you `SED` (set decimal flag) on the NES, **arithmetic does not switch to BCD**. Code ported from full 6502 systems can break in subtle ways. Most NES games never `SED` for this reason.

## The storytelling-vs-logic axis

A throughline of the [Game Annotation Series](../../projects/game-annotation/README.md):

- **2600 era**: TIA forces the CPU to spend most cycles racing the beam. Game logic gets ~5,000 cycles per frame. Engines have to encode meaning structurally — Adventure's design IS the story; there's no spare cycles for runtime narrative state.
- **NES era**: PPU does the rendering autonomously. CPU gets ~27,000 cycles per frame for game logic. Programmers spend that on richer state machines, scripted events, level scripting, music engines. **Stories can be told in code, not just in design.**
- **Mappers extend the canvas**: not just bigger ROMs but enabling things like granular CHR swapping (MMC3 → animated tiles, parallax), scanline IRQs (status bars without sprite 0 hit), expanded audio (VRC6, MMC5).

Each NES game we cover should be asked: *what does this code do that Adventure couldn't have?* The answer is the design lesson.

## Reading order for someone new to NES code

1. Start here (this README) for the big picture.
2. [PPU Reference](./ppu-reference.md) — the rendering system that frees the CPU.
3. [APU Reference](./apu-reference.md) — the music/sound capability that enables soundtracks.
4. [Mappers Reference](./mappers-reference.md) — the cartridge logic that scales the platform.

## Tags

[6502](../../tags/6502.md) · [reverse-engineering](../../tags/reverse-engineering.md)
