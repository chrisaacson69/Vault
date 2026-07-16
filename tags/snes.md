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
- [The one that isn't a VM — Nobunaga's Ambition (SNES) compiled native](../research/gaming/na1-snes-native-port.md) — first HiROM KOEI SNES title; the exception that compiled straight to native 65C816 (no bytecode VM); drove a native 65816→C decompiler
