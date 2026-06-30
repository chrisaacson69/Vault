---
published: true
layout: layouts/page.njk
title: "Tag: reverse-engineering"
permalink: /tags/reverse-engineering/
---
# reverse-engineering
> Files about reading, annotating, and explaining existing code at a system level.

- [Game Annotation Series](../projects/game-annotation/README.md) — narrating already-disassembled code at a layer the comments don't reach
- [TIA Reference](../research/atari-2600/tia-reference.md) — Atari 2600 chip docs distilled for source-reading
- [NES Research](../research/nes/README.md) — PPU/APU/Mappers references distilled for source-reading
- [Transpilation as a Grounding Strategy](../research/transpilation-as-grounding.md) — the RE payoff: bytecode→C transpile (Nobunaga's Sea-16 VM) as the general technique, COBOL modernization as the application
- [Lowering Atlas](../projects/game-annotation/lowering-atlas/README.md) — the forward complement: compile known C constructs through GCC `-O0`, catalog the CFG signature each leaves, source the finite atom table without reverse-engineering each sub one at a time
- [APU Reference (NES)](../research/nes/apu-reference.md) — Load-bearing facts about the Audio Processing Unit (integrated into the Ricoh 2A03) for reading NES sound code.
- [NES Mappers Reference](../research/nes/mappers-reference.md) — The cartridge logic that extends the NES beyond its base 32 KiB PRG / 8 KiB CHR address space.
- [PPU Reference (NES)](../research/nes/ppu-reference.md) — Load-bearing facts about the Picture Processing Unit (Ricoh 2C02) for reading NES source code.
- [KOEI AI & combat evolution (5-decompiler study)](../research/gaming/koei-ai-combat-evolution.md)
