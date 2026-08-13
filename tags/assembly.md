---
published: true
layout: layouts/page.njk
title: "Tag: assembly"
permalink: /tags/assembly/
---
# assembly
> Files about assembly-language programming and reading low-level code.

- [Game Annotation Series](../projects/game-annotation/README.md) — documenting classic game source at the system level
- [TIA Reference](../research/atari-2600/tia-reference.md) — chip-level facts needed to read 2600 source
- [PPU Reference](../research/nes/ppu-reference.md) — chip-level facts needed to read NES source
- [APU Reference](../research/nes/apu-reference.md) — NES audio chip reference
- [Mappers Reference](../research/nes/mappers-reference.md) — NES cartridge logic from NROM through MMC5
- [Breaking Down an SNES Cart](../research/gaming/snes-cartridge-teardown.md) — 65C816 vs 6502; why a width-aware disassembler is needed
- [SNES teardown — `snes-decompiler`](../projects/game-annotation/snes/README.md) — the target-agnostic SNES teardown substrate
- [Battlezone (1980) — 3D Without a Multiply Instruction](../research/gaming/battlezone-mathbox.md) — reading Atari's 12 KB of 6502 from McFadden's commented disassembly: the memory-mapped math-box API, the vertex inner loop, quarter-wave sine and octant-folded arctan, `RTS`-dispatch sign fixup
- [Arithmetic Scarcity and the 3D Problem](../research/gaming/arithmetic-scarcity-3d.md) — why 8086 inner loops avoided `MUL` too (118-133 clocks, microcoded not silicon); the four strategies for real-time 3D when arithmetic is the scarce resource
- [Stellar 7 (1983) — The Same Game Without the Coprocessor](../research/gaming/stellar7-software-3d.md) — unrolled shift-add multiply (7 stages, no loop), a 4-path specialized divide with the fixed-point pre-shift folded into the signature, and a vertex loop that services bit-banged audio four times per vertex
- [Arithmetic as a Purchase — Sixty Years of Paying for Multiply](../research/arithmetic-as-a-purchase.md) — the request protocol that never changed: write operands to a port, let the last write trigger, wait a known cycle bound, read the result — the 1401's option gate, Battlezone's `$1860`, the SNES's `$4202`, a GPU command buffer
