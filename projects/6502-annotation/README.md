---
status: active
created: 2026-04-26
---
# 6502 Annotation Series
> Documenting classic 6502 game source code at the system level — and using it as a stress test for LLM interpretation of low-level code.

**Links:** [Adventure (Atari 2600)](./adventure/README.md), [LLM Grounding Problem](../../research/llm-grounding-problem.md), [Planner-LM Composites](../../research/planner-lm-composites.md), [LLM Agents Across Strategic Games](../../research/gaming/llm-agents-across-games.md)

## What this is

A series of deep reads of 6502 game source. Existing disassemblies have *literal* per-line comments ("Get the direction wanted") but rarely explain **what the code does at a system level**: the data structures, the state machines, the hardware tricks, the design intent. This series writes that higher layer.

## The meta-question

How well can an LLM interpret 6502 from cold reading?

Assembly is the inverse of natural language: pure mechanical structure, no rhetoric, no narrative, no social cues. Our [seven-game LLM study](../../research/gaming/llm-agents-across-games.md) named three structural failures: action bias, absent mechanical modeling, rhetorical contagion. Assembly **isolates** mechanical modeling — there is nothing rhetorical to be contaminated by, and no actions to bias toward. If the model can build a mechanical picture of a 4KB ROM by reading bytes and labels, that's evidence for the verification-by-accumulated-state thesis. If it can't, the failure mode is unambiguous.

This is also a control case for the [verification layer thesis](../../notes/conservation-of-complexity.md): the assembly source IS the accumulated state. There's no separate "ground truth" to drift from.

## Method

1. Start from an already-disassembled and lightly-commented source.
2. Read it in passes — first, identify the major subsystems (display, input, AI, state); then drill into each.
3. Write per-subsystem chapters as vault pages. Code excerpts, prose explanation, diagrams where useful.
4. Note where the LLM had to stop and verify against external knowledge (TIA register semantics, undocumented opcodes, etc.) versus where structure alone was enough.

## Games

| Game | Platform | ROM | Status |
|---|---|---|---|
| [Adventure](./adventure/README.md) | Atari 2600 | 4 KB | scaffolded |
| TBD (NES, ≤32 KB, no mapper) | NES | ≤32 KB | planned |
| TBD (NES with MMC) | NES | bank-switched | future |

Constraint progression matters: 2600 (4 KB, no frame buffer, beam racing) → NES no-mapper (32 KB + 8 KB CHR, PPU does the rendering) → NES with mappers (bank switching, expanded RAM, scanline IRQs).

## Reusable references

System-level material that recurs across games lives under `research/`, not in any one game's chapters:

- `research/6502/` — instruction set, addressing modes, common idioms (planned)
- `research/atari-2600/` — TIA, RIOT, beam racing, kernel patterns (planned)
- `research/nes/` — PPU, mappers, NMI/IRQ timing (planned)

## Tags

[6502](../../tags/6502.md) · [atari-2600](../../tags/atari-2600.md) · [assembly](../../tags/assembly.md) · [llm-limitations](../../tags/llm-limitations.md) · [reverse-engineering](../../tags/reverse-engineering.md)
