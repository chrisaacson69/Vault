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
| Depended on by | game adapters in each game's own repo (Zelda first, as the oracle: [`Zelda1-decompiler`](../zelda1/README.md); [`mappy-decompiler`](../comparisons/mappy/README.md), the first title through all nine phases) |

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

**Status (2026-10-22): becoming the console-RE toolset.** The NES/SNES decompiler tools (koei-nes,
koei-snes, snes-decompiler, nes-render, per-title copies) fold in as plugins, REA-style. The repo's
`MIGRATION.md` holds the audit (339 files; jobs done up to 7 times) and the move order. Step 0 is done:
an installable package (`pip install -e`, `py -3.14`) whose layer rules are import contracts run in pytest.
nes-render, folded in as `machines/nes/ppu` (row O), was archived 2026-10-26.
Rows A, A2, D, B and the generic half of E are done (2026-10-23): one `.mlb` exporter, one native-floor
tool, and one shared 6502 recursive descent. A CPU-log benchmark measured every disassembler, and
nes-disasm6 is now a plugin.

**Next machines (planned 2026-10-27):** 2600, Intellivision (first non-6502 CPU), Atari 800 →
[Taking emu-harness to the other three](../comparisons/harness-expansion.md).

## Tags
[nes](../../../tags/nes.md) · [python](../../../tags/python.md) · [tools](../../../tags/tools.md) · [game-ai](../../../tags/game-ai.md)
