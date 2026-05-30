---
status: active
created: 2026-04-26
---
# Game Annotation Series
> Documenting classic game source code at the system level — and using it as a stress test for LLM interpretation of low-level code. Two arcs: hardware capability (6502) and mechanical complexity (early strategy engines).

**Links:** [Adventure (Atari 2600)](./adventure/README.md), [Mappy (Famicom/NES)](./mappy/README.md), [Utopia (Intellivision)](./utopia/README.md), [M.U.L.E. (Atari 800)](./mule/README.md), [LLM Grounding Problem](../../research/llm-grounding-problem.md), [Transpilation as a Grounding Strategy](../../research/transpilation-as-grounding.md), [Planner-LM Composites](../../research/planner-lm-composites.md), [LLM Agents Across Strategic Games](../../research/gaming/llm-agents-across-games.md), [CoM Spell Counter-Graph](../../research/gaming/master-of-magic/com-counter-graph.md) — same dominance-frontier lens applied to game design

## What this is

A series of deep reads of classic game source. Existing disassemblies have *literal* per-line comments ("Get the direction wanted") but rarely explain **what the code does at a system level**: the data structures, the state machines, the hardware tricks, the design intent. This series writes that higher layer.

## The meta-question

How well can an LLM interpret vintage assembly from cold reading?

Assembly is the inverse of natural language: pure mechanical structure, no rhetoric, no narrative, no social cues. Our [seven-game LLM study](../../research/gaming/llm-agents-across-games.md) named three structural failures: action bias, absent mechanical modeling, rhetorical contagion. Assembly **isolates** mechanical modeling — there is nothing rhetorical to be contaminated by, and no actions to bias toward. If the model can build a mechanical picture of a 4KB ROM by reading bytes and labels, that's evidence for the verification-by-accumulated-state thesis. If it can't, the failure mode is unambiguous.

This is also a control case for the [verification layer thesis](../../notes/conservation-of-complexity.md): the assembly source IS the accumulated state. There's no separate "ground truth" to drift from.

**The thesis the series produced:** by Nobunaga, the meta-question got a sharper answer. When the source is a *weakly-grounded* formal language (a bespoke bytecode VM), the move isn't "read it cold" — it's **build a deterministic transpiler to a grounded language and let the LLM read that.** `vm_decompile.py` (bytecode → C) is the existence proof. See [Transpilation as a Grounding Strategy](../../research/transpilation-as-grounding.md) — grounding across formal languages is a gradient, solved one transpiler at a time, with COBOL/legacy modernization as the real-world payoff.

## Two Arcs

The series is organized as **paired comparisons**. Each pair targets a specific design dimension; the pair structure forces the comparison rather than letting each game stand alone.

### Arc 1 — Hardware Capability (6502 family)

How does the platform's hardware constraint shape the design? Same CPU family, different display/memory architecture.

| Game | Platform | ROM | Status |
|---|---|---|---|
| [Adventure](./adventure/README.md) | Atari 2600 | 4 KB | complete (8 chapters) |
| [Mappy](./mappy/README.md) | Famicom/NES | 16 KB + 8 KB CHR | complete (8 chapters) |

The arc reveals: 2600 (no frame buffer, beam racing, 128 bytes RAM) → NES (PPU does rendering, 2 KB RAM, larger code budget) is roughly a 4-8× capability jump that enabled a different *kind* of game, not just a bigger one.

### Arc 2 — Mechanical Complexity (early strategy engines)

How does the strategic decision engine evolve when the platform is no longer the limiting factor? Different ISAs, but mechanical depth is the comparison axis.

| Game | Platform | Status |
|---|---|---|
| [Utopia](./utopia/README.md) | Intellivision (CP1610) | **complete** (8 chapters) |
| [M.U.L.E.](./mule/README.md) | Atari 800 (6502) | **complete** (8 chapters; ch 7.5 reserved for Chris's strategic-frontier analysis) |
| [Nobunaga's Ambition](./nobunaga/README.md) | NES (6502, MMC1) | **active** — session 1 done (boot + 23-entry BRK dispatcher mapped) |

The arc question: as designers built more elaborate economic-strategy engines, what mechanical patterns emerged? Utopia (1981) is one of the earliest turn-based strategy games on a console. M.U.L.E. (1983) adds an *auction* layer — same economic spine, but trading as a strategic decision-space expansion. The pair isolates "what does player-vs-player auctioning add to a Utopia-style solo economic engine?"

Nobunaga's Ambition (1989 NES US port) is the active solo-deep-dive — not a paired comparison. NA is the canonical example of *hidden* mechanics so opaque that the dominant strategy degenerates to "exploit the highest-leverage stat" (TAS-speedruns pick a high-luck leader and assassinate everyone). Source-level transparency is the antidote — turn the hidden mechanics into a mappable counter-graph in the same vein as the [CoM Spell Counter-Graph](../../research/gaming/master-of-magic/com-counter-graph.md) work. After the M.U.L.E. paired study, the framework is calibrated enough to take on NA's ambitious 256 KB on familiar NES territory.

This arc cross-feeds the broader **dominance-frontier game-analysis lens**: source-level reverse-engineering is what makes the lens applicable to opaque games at all.

## Method

1. Start from an already-disassembled and lightly-commented source.
2. Read it in passes — first, identify the major subsystems (display, input, AI, state); then drill into each.
3. Write per-subsystem chapters as vault pages. Code excerpts, prose explanation, diagrams where useful.
4. Note where the LLM had to stop and verify against external knowledge (TIA register semantics, undocumented opcodes, Intellivision MOB conventions, etc.) versus where structure alone was enough.

## Reusable references

System-level material that recurs across games lives under `research/`, not in any one game's chapters:

- `research/atari-2600/tia-reference.md` — TIA registers, beam racing, kernel patterns
- `research/nes/{ppu,apu,mappers}-reference.md` — PPU, APU, mappers, NMI/IRQ timing
- `research/cp1610/` — Intellivision CP1610 ISA, MOB hardware (planned only if needed; the Utopia source is well-annotated enough that we may not need to spelunk the 16-bit ISA)

## Tags

[6502](../../tags/6502.md) · [atari-2600](../../tags/atari-2600.md) · [nes](../../tags/nes.md) · [assembly](../../tags/assembly.md) · [llm-limitations](../../tags/llm-limitations.md) · [reverse-engineering](../../tags/reverse-engineering.md) · [games](../../tags/games.md) · [strategy](../../tags/strategy.md)
