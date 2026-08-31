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
- [NA1 NES↔SNES — grading two blind reverse-engineerings](../research/gaming/na1-nes-snes-blind-regrade.md) — SNES-derived vs NES-derived, all 5 sections converge (record bytes, Grow formula, event cadence, weakest-neighbour AI, 8-stat combat table); create-then-check method
- [Arithmetic as a Purchase — Sixty Years of Paying for Multiply](../research/arithmetic-as-a-purchase.md) — the SNES multiplier as a memory-mapped coprocessor, and the DSP-1 / Super FX cartridge chips as the Atari math box reborn — arithmetic priced *per game*
- [Game Annotation Series](../projects/game-annotation/README.md) — System-level deep-reads of classic game source — used as a stress test for LLM interpretation of
- [Gemfire (SNES)](../projects/game-annotation/snes/gemfire-snes/README.md) — The second KOEI SNES title reversed — and the pass that exposed the trampoline bug in
- [KOEI tools — the shared engine toolchain](../projects/game-annotation/koei/README.md) — **Tools node, not a title index.** One studio, one bytecode-VM engine lineage, two consoles.
- [ROTK2 — Sangokushi II (SNES)](../projects/game-annotation/snes/rot3k2-snes/README.md) — The first KOEI **SNES** title reversed, and the title that proved the portable VM from both sides.
- [SNES system tools — `snes-decompiler`](../projects/game-annotation/snes/tools/README.md) — The **target-agnostic** substrate for taking apart *any* SNES cart: 65C816, LoROM/HiROM detection,
