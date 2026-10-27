---
published: true
layout: layouts/page.njk
title: "Tag: decompilation"
permalink: /tags/decompilation/
---
# decompilation
> Turning binaries back into readable code — control-flow structuring, decompiler output quality, and the reverse-engineering toolchain.

- [DREAM — goto-free control-flow structuring](../research/reverse-engineering/dream-goto-free-structuring.md) — reaching-conditions (not node splitting) resolve shared tails; practical, beats Hex-Rays/Phoenix; the koei-snes vm_struct testbed
- [KOEI's portable VM (SNES ROTK2 reversal)](../research/gaming/koei-snes-portable-vm.md) — 512 named routines, layered source, Mesen .mlb, C-lift + DREAM structuring experiments
- [The AI Decomp Wave — Outside Confirmation](../research/ai-decomp-wave.md) — agent decompilation's "answer key" = the vault's correctness oracle; flashy ports/mods vs. mechanics; idea/expression legality
- [REA (Reverse Engineer Anything) — Candidate Tool and Harness Teardown](../research/reverse-engineering/rea-candidate-tool.md) — MCP harness driving Ghidra/IDA; teardown vs. our harness (borrow: evidence records, unknowns registry); blocked on MOO1 because half of STARMAP is an FBOV overlay; 8-bit = raw 6502 only
- [Mappy (Famicom) — `mappy-decompiler`](../projects/game-annotation/comparisons/mappy/README.md) — pointer to the Mappy code repo; the first title through all nine emu-harness phases
