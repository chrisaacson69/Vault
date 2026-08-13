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
- [L'Empereur — the two-tier turn (NES→SNES design hinge)](../research/gaming/lempereur-two-tier-turn.md)
- [Breaking Down an SNES Cart — the teardown method](../research/gaming/snes-cartridge-teardown.md) — the SNES analog of the NES chip references: header/mapping/memory-map/subsystems, grounded in the SNESdev wiki
- [SNES teardown — `snes-decompiler`](../projects/game-annotation/snes/README.md) — process-table pointer for the target-agnostic SNES teardown substrate (verified header/mapper tools)
- [KOEI's portable VM (SNES ROTK2 reversal)](../research/gaming/koei-snes-portable-vm.md) — first KOEI SNES title reversed; byte-for-byte portable bytecode VM, faithful port + facelift (NES↔SNES comparison)
- [DREAM — goto-free control-flow structuring](../research/reverse-engineering/dream-goto-free-structuring.md) — reaching-conditions (not node splitting) resolve shared tails; the decompiler-output experiment
- [The Rosetta Stone Method](../method/rosetta-stone-method.md) — learn new hardware by anchoring the unknown machine against a portable program you already understand (KOEI's cross-platform VM as the exemplar)
- [Gemfire (SNES) fully decompiled](../research/gaming/gemfire-snes-decompiled.md)
- [Nobunaga's Ambition (SNES) compiled native — no VM](../research/gaming/na1-snes-native-port.md) — native-65816 exception proven 3 ways (no fetch loop / no dispatch table / native `main`); reachability walk 0 conflicts; built a native 65816→C decompiler reusing the DREAM structurer
- [NA1 NES↔SNES — grading two blind reverse-engineerings](../research/gaming/na1-nes-snes-blind-regrade.md) — SNES-derived vs NES-derived, all 5 sections converge (record bytes, Grow formula, event cadence, weakest-neighbour AI, 8-stat combat table); create-then-check method
- [Battlezone (1980) — 3D Without a Multiply Instruction](../research/gaming/battlezone-mathbox.md) — a complete third-party disassembly read as a specimen: what the pipeline actually does, verified against the listing (no software mul/div exists anywhere in the ROM), with cycle counts derived rather than assumed
- [Arithmetic Scarcity and the 3D Problem](../research/gaming/arithmetic-scarcity-3d.md) — hub for the 3D-under-scarcity specimens; Battlezone grounded from primary source, Elite/Doom/Ultima marked as unwalked stubs so the grounding gap stays visible
- [Stellar 7 (1983) — The Same Game Without the Coprocessor](../research/gaming/stellar7-software-3d.md) — the control specimen for the arithmetic-scarcity hub; reading the source overturned the hub's own strategy-2 claim (software 3D does *not* preserve geometric freedom — it constrains the representation)
- [Arithmetic as a Purchase — Sixty Years of Paying for Multiply](../research/arithmetic-as-a-purchase.md) — uses the vault's own decompiled evidence as a specimen: KOEI's `$C1:F800` 32-bit math library wrapping the SNES hardware mul/div registers, read off a real ROM rather than a spec sheet
