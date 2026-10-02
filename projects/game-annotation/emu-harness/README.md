---
status: active
created: 2026-10-01
---
# emu-harness — drive emulators from Python (backends × machines)

> One harness, two independent plug-in axes: **backends** (one emulator each: Mesen 2, BizHawk) and
> **machines** (one console each: NES). Lockstep inputs, frame advance, savestates, RAM reads and
> per-frame traces, for replay verification, search and testing. Game adapters live in each game's repo.
> A peer of [koei/](../koei/README.md) for the same reason: it spans consoles, so it is not filed under one.

**Links:** design + decisions → [The AI Zelda speedrun harness](../../../research/gaming/zelda-ai-speedrun-harness.md) ·
system → [NES](../nes/README.md) · series hub → [Game Annotation](../README.md) ·
project SDK → [projects/CLAUDE.md](../../CLAUDE.md)

| Field | Value |
|-------|-------|
| Logical name | `emu-harness` *(public)* · [github.com/chrisaacson69/emu-harness](https://github.com/chrisaacson69/emu-harness) |
| Sibling path | `../emu-harness` (resolved via `.claude/local-paths.md`) |
| Entry point | `CLAUDE.md` (layout, import rules, day-one rules) |
| Stack | Python 3.14 + Lua inside each emulator |
| Depended on by | game adapters in each game's own repo (Zelda first, as the oracle) |

**Layout:** `emu_harness/backends/{mesen,bizhawk}` · `emu_harness/machines/nes` · `tools/` (replay, trace diff)
· `spike/<backend>/`. Which backend runs which machine is configuration, not structure.

**History:** began 2026-10-01 as two repos stacked emulator-at-the-bottom, `mesen-harness` (core) →
`nes-harness` (console). **Merged 2026-10-02** when BizHawk became a second backend and turned emulator and
machine into orthogonal axes ("Decision 2" on the design page). `mesen-harness` was renamed (GitHub redirects);
`nes-harness` is archived with its history imported.

**Status (2026-10-02):** Mesen backend works headless (`--testRunner`, lockstep, savestates, per-frame RAM
trace; Zelda Rev 1 smoke test deterministic). BizHawk has a `.bk2` RAM-trace script only, the reference for
cross-emulator drift; `replay_log --offset -1` aligns against BizHawk movies (run 6). Known debt:
`machines/nes` still subclasses the Mesen backend, to be split when BizHawk gets a Python client.

## Tags
[nes](../../../tags/nes.md) · [python](../../../tags/python.md) · [tools](../../../tags/tools.md) · [game-ai](../../../tags/game-ai.md)
