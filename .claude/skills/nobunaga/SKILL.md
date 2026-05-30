---
name: nobunaga
description: Run the Nobunaga's Ambition (NES) reverse-engineering tools — render fief/strategic maps, test command effects, decompile VM bytecode to C, query labels, run the verified econ sim, decode combat traces. Use when working in projects/game-annotation/nobunaga so a tool gets INVOKED instead of rebuilt. Triggers — "run the nobunaga <X> tool", "render <fief>", "test the <command> effect", "decompile bytecode at <addr>", "where's the label for <addr>".
user-invocable: true
allowed-tools: Bash, Read, Grep, Edit
---

## Nobunaga tool dispatcher

Project root: `C:\Users\Chris.Isaacson\Vault\projects\game-annotation\nobunaga` (`PROJ` below).

**Rule 0 — anti-drift (this is why the skill exists):** before running OR building anything, the source of truth is the registries, not your memory:
1. Read `PROJ/CONTEXT.md` (vocabulary + canonical artifacts + quick-routes).
2. Read `PROJ/tools/README.md` (the tool catalog — canonical ✅ / duplicate 🔁 / one-shot 🧪).
3. If a tool seems missing, it is probably there under a different name, or its **output** already exists as a data file/label. Re-derive only after confirming it doesn't. If you do build one, add it to `tools/README.md` in the same session.

Then route the request:

| Ask | Tool | Invocation (from `PROJ`) |
|---|---|---|
| Render a fief tactical map | fief PPU renderer | `python tools/render-fief-from-ppu.py <fief>` (post-Phase-3) — until merged, the per-fief `render-<fief>-from-ppu.py` |
| Render strategic / adjacency map | `render-strategic-atlas.py` | `python tools/render-strategic-atlas.py [--variant 17|50]` |
| Test a command's effect | snap protocol | follow `commands/README.md`: `python tools/capture-test.py <tag> pre|post|diff --fief N` |
| Run an effect handler | `run-effect.py` | `python tools/run-effect.py <effect> <amount>` |
| Decompile bytecode → C | `vm_decompile.py` | `python tools/vm_decompile.py <bank> <addr>` |
| Find a named address | `mesen-labels.toml` | grep it — **never re-trace a known label** |
| Simulate economy / check a formula | `econ_sim.py` | `python tools/econ_sim.py` |
| Province adjacency table | `adjacency.py` | `python tools/adjacency.py [--variant 17|50]` |
| Decode a combat trace | `combat-trace-decode.py` | `python tools/combat-trace-decode.py <trace.txt[.gz]>` |
| What's the frontier / what's next | — | show `PROJ/ROADMAP.md` |

**Emulator pattern** (for `nobunaga_vm.py`-based runs): load SRAM → switch bank → set `vm_pc`/`vm_sp` (pre-allocate locals!) → run. Details in `CONTEXT.md`.

**After the work:** if the session produced a reusable result, register it — update `ROADMAP.md` (move the item), `traces/README.md` (if a precious dump was captured, name it per convention), or `tools/README.md` (if a tool was added/changed). Leaving the result unregistered is how the project drifts.
