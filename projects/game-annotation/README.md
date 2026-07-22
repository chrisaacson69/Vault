---
status: active
created: 2026-04-26
published: true
layout: layouts/page.njk
title: "Game Annotation Series"
permalink: /projects/game-annotation/
---
# Game Annotation Series

> System-level deep-reads of classic game source — used as a stress test for LLM interpretation of
> low-level code. Existing disassemblies carry *literal* per-line comments ("Get the direction wanted")
> but rarely explain what the code does at a **system** level: the data structures, state machines,
> hardware tricks, and design intent. This series writes that higher layer.

**Links:** [LLM Grounding Problem](../../research/llm-grounding-problem.md) ·
[Transpilation as a Grounding Strategy](../../research/transpilation-as-grounding.md) ·
[Planner-LM Composites](../../research/planner-lm-composites.md) ·
[LLM Agents Across Strategic Games](../../research/gaming/llm-agents-across-games.md) ·
project SDK → [projects/CLAUDE.md](../CLAUDE.md)

## Two axes, deliberately not one folder tree

The series grew two different shapes, and forcing either into the other would sever the valuable edges.
Per [Author Web, Derive Hierarchy](../../method/author-web-derive-hierarchy.md), both stay as links:

- **Arcs** — the *paired comparisons* the series began as. **Cross-console by design**: the comparison
  is the deliverable, so these are not filed under a system.
- **Systems & tools** — the decompiler work that came later, where the console *and* the shared engine
  are load-bearing structure.

## The map

| Node | What it holds |
|---|---|
| [comparisons/](./comparisons/README.md) | Adventure · Mappy · Utopia · M.U.L.E. — both arcs, one monorepo |
| [koei/](./koei/README.md) | **the shared KOEI toolchain** — `koei-nes` + `koei-snes`, the engine reversal, the portable-VM finding |
| [nes/](./nes/README.md) | 6502 + PPU substrate → [tools/](./nes/tools/README.md) + 7 title repos |
| [snes/](./snes/README.md) | 65C816 substrate → [tools/](./snes/tools/README.md) + 2 title repos |
| [civ-revolution/](./civ-revolution/README.md) | the next title by a **different method** — no decompilation available, so game-design analysis |

Why `koei/` is a peer of `nes/` and `snes/` rather than a child: the engine is **one thing carried
across two consoles**, so filing the toolchain under either would split it — and would strand the
portable-VM finding, which exists only *because* both sides were reversed.

## The meta-question

*How well can an LLM interpret vintage assembly from a cold read?* Assembly is the inverse of natural
language — pure mechanical structure, no rhetoric, no narrative, no social cues. The
[seven-game LLM study](../../research/gaming/llm-agents-across-games.md) named three structural failures
(action bias, absent mechanical modeling, rhetorical contagion); assembly **isolates** mechanical
modeling, so the failure mode would be unambiguous. It's also a control case for the verification-layer
thesis: the assembly source *is* the accumulated state, with no separate ground truth to drift from.

**The answer the series produced:** when the source is a *weakly-grounded* formal language (a bespoke
bytecode VM), the move isn't "read it cold" — it's **build a deterministic transpiler to a grounded
language and let the model read that**. `vm_decompile.py` (bytecode → C) is the existence proof, and
COBOL/legacy modernization is the real-world payoff. See
[Transpilation as a Grounding Strategy](../../research/transpilation-as-grounding.md).

## Tags
[6502](../../tags/6502.md) · [nes](../../tags/nes.md) · [snes](../../tags/snes.md) · [assembly](../../tags/assembly.md) · [reverse-engineering](../../tags/reverse-engineering.md) · [games](../../tags/games.md) · [llm-limitations](../../tags/llm-limitations.md)
