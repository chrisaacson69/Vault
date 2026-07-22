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
- [KOEI tools — the shared engine toolchain](../projects/game-annotation/koei/README.md) — the toolchain shared by every KOEI target: `koei-nes` + `koei-snes`, the reversed engine, the portable-VM finding. A *peer* of the console nodes, since the engine spans both
- [NES / Famicom — system node](../projects/game-annotation/nes/README.md) — the 6502+PPU substrate and its three-layer stack: `nes-render` (generic) → `koei-nes` (family engine) → per-title decompilers
- [LADS — byte-exact reconstruction](../projects/lads/README.md) — Mansfield's 1984 6502 assembler rebuilt from printed source, verified byte-for-byte against the published object code; the inverse of decompilation
- [The comparison studies](../projects/game-annotation/comparisons/README.md) — the four paired deep-reads the series began as (Adventure · Mappy · Utopia · M.U.L.E.), one monorepo; indexed by arc because both arcs are cross-system by design
- [NES system tools](../projects/game-annotation/nes/tools/README.md) — `nes-render` (generic render core, graduated out of NA1) + Mesen emulator integration; flags the three-homes label-emission duplication
- [SNES system tools — `snes-decompiler`](../projects/game-annotation/snes/tools/README.md) — target-agnostic teardown substrate (verified header/mapper tools); ⚠️ not on GitHub, local copy only
