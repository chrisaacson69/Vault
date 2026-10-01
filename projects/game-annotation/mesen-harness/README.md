---
status: active
created: 2026-10-01
---
# mesen-harness — drive Mesen 2 from Python (core layer)

> The **console-agnostic core** of the emulator harness: a `bridge.lua` socket server inside Mesen 2,
> in lockstep with a Python client (inputs, frame advance, savestates, RAM reads, one input recorder).
> A peer of [koei/](../koei/README.md) for the same reason: it spans consoles, so it is not filed under one.

**Links:** design + decision → [The AI Zelda speedrun harness](../../../research/gaming/zelda-ai-speedrun-harness.md) ·
console layer → [nes/harness](../nes/harness/README.md) · series hub → [Game Annotation](../README.md) ·
project SDK → [projects/CLAUDE.md](../../CLAUDE.md)

| Field | Value |
|-------|-------|
| Logical name | `mesen-harness` *(public)* · [github.com/chrisaacson69/mesen-harness](https://github.com/chrisaacson69/mesen-harness) |
| Sibling path | `../mesen-harness` (resolved via `.claude/local-paths.md`) |
| Entry point | `CLAUDE.md` (layering + day-one rules) |
| Stack | Lua (inside Mesen 2) + Python client |
| Depended on by | `nes-harness`, then game adapters in each game's own repo |

**Stack:** `mesen-harness` (core) → `nes-harness` (console) → game adapters (Zelda as oracle, then Mappy,
then a KOEI adapter). Same dependency shape as `snes-decompiler` → `koei-snes` → titles.

**Status (2026-10-01):** scaffolded and pushed; no code yet. Milestone 1 = replay the AIBeatsZelda
run-6 input log from power-on. The local Rev 1 dump matches the run's ROM hash (verified 2026-10-01).

## Tags
[nes](../../../tags/nes.md) · [python](../../../tags/python.md) · [tools](../../../tags/tools.md) · [game-ai](../../../tags/game-ai.md)
