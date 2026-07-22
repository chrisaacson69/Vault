---
published: true
layout: layouts/page.njk
title: "Tag: snes"
permalink: /tags/snes/
---
# snes
> Super Nintendo (SNES / Super Famicom) hardware and reverse-engineering — 65C816, LoROM/HiROM, PPU modes, SPC700.

- [Breaking Down an SNES Cart — the teardown method](../research/gaming/snes-cartridge-teardown.md) — read the header, detect the mapping, lay the memory map, peel the subsystems; the architecture break vs. the NES 6502 work
- [SNES teardown — `snes-decompiler`](../projects/game-annotation/snes/README.md) — process-table pointer for the target-agnostic SNES teardown substrate (verified header/mapper tools)
- [KOEI's portable VM (SNES ROTK2 reversal)](../research/gaming/koei-snes-portable-vm.md) — first KOEI SNES title reversed; byte-for-byte portable bytecode VM, faithful port + facelift (NES↔SNES comparison)
- [Gemfire (SNES) fully decompiled](../research/gaming/gemfire-snes-decompiled.md)
- [KOEI tools — the shared engine toolchain](../projects/game-annotation/koei/README.md) — the toolchain shared by every KOEI target: `koei-nes` + `koei-snes`, the reversed engine, the portable-VM finding. A *peer* of the console nodes, since the engine spans both
- [SNES system tools — `snes-decompiler`](../projects/game-annotation/snes/tools/README.md) — target-agnostic teardown substrate; ⚠️ not on GitHub, local working copy only
- [ROTK2 (SNES)](../projects/game-annotation/snes/rot3k2-snes/README.md) — `rot3k2-snes-decompiler`; ~1,316 routines across 26 modules after the trampoline-bug re-walk
- [Gemfire (SNES)](../projects/game-annotation/snes/gemfire-snes/README.md) — `Gemfire-snes-decompiler`; 591 routines across 11 overlay modules; found the `JSR $3287` trampoline
