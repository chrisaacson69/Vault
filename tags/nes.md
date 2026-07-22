---
published: true
layout: layouts/page.njk
title: "Tag: nes"
permalink: /tags/nes/
---
# nes
> Files about the Nintendo Entertainment System / Famicom — 2A03, PPU (2C02), APU, mappers, and the games written for them.

- [NES Research](../research/nes/README.md) — platform overview; 2A03 vs 6507 comparison; the storytelling-vs-logic axis
- [PPU Reference](../research/nes/ppu-reference.md) — Picture Processing Unit (Ricoh 2C02): registers, NMI, OAM, scrolling, frame timing
- [APU Reference](../research/nes/apu-reference.md) — Audio Processing Unit: 5 channels, envelope/sweep/length-counter autonomy
- [Mappers Reference](../research/nes/mappers-reference.md) — NROM through MMC5; what cartridge logic enables
- [Nobunaga's Ambition (NES)](../projects/game-annotation/nes/na1/README.md) — Koei, 1989; MMC1/SOROM 256 KB; solo deep-dive
- [Game Annotation Series](../projects/game-annotation/README.md) — the series hub; two axes (arcs + systems/families)
- [KOEI AI & combat evolution (5-decompiler study)](../research/gaming/koei-ai-combat-evolution.md)
- [L'Empereur — the two-tier turn (NES→SNES design hinge)](../research/gaming/lempereur-two-tier-turn.md)
- [NES / Famicom — system node](../projects/game-annotation/nes/README.md) — the 6502+PPU substrate and its three-layer stack: `nes-render` (generic) → `koei-nes` (family engine) → per-title decompilers
- [KOEI tools — the shared engine toolchain](../projects/game-annotation/koei/README.md) — the toolchain shared by every KOEI target: `koei-nes` + `koei-snes`, the reversed engine, the portable-VM finding. A *peer* of the console nodes, since the engine spans both
- [The comparison studies](../projects/game-annotation/comparisons/README.md) — Mappy's home; the paired deep-reads, indexed by arc rather than console
- [NES system tools](../projects/game-annotation/nes/tools/README.md) — `nes-render` + Mesen integration; the three-homes label-emission duplication
- [ROTK1 — Sangokushi (NES)](../projects/game-annotation/nes/ro3k/README.md) — `ro3k-decompiler`, 1985; full 30-day battle sim, and the lineage's only explicit AI combat handicap
- [Genghis Khan (NES)](../projects/game-annotation/nes/gk/README.md) — `gk-decompiler`, 1987; cheap round simulation, casualties quadratic in the loser's share
- [ROTK2 — Sangokushi II (NES)](../projects/game-annotation/nes/rot3k2/README.md) — `rot3k2-decompiler`, 1989, MMC5; fully decompiled; the NES half of the portable-VM proof
- [Bandit Kings of Ancient China (NES)](../projects/game-annotation/nes/bk/README.md) — `bk-decompiler`, game 6; 988 bytecode subs + native floor + sound engine
- [Gemfire (NES, 1992)](../projects/game-annotation/nes/gemfire/README.md) — `GemFire-decompiler`, game 7; 521/521 subs named
- [L'Empereur (NES, 1991)](../projects/game-annotation/nes/lemp/README.md) — `LEmp-decompiler`, game 8; the `$E2E3` native trampoline and the country→province two-tier turn
