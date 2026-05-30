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

Then route the request.

> **Launcher: use `py`, not `python`** — `python` is not on PATH on this machine. All invocations are from `PROJ`. Signatures below were verified against the tools 2026-05-29 (the consolidation pass). If a tool changed, fix this table **and** `tools/README.md` in the same session — they must not disagree.

| Ask | Tool | Invocation (from `PROJ`) |
|---|---|---|
| Render a fief tactical map | `render-fief-from-ppu.py` | `py tools/render-fief-from-ppu.py <fief>`  (`--list` shows available PPU dumps) |
| Render the 17-fief strategic atlas | `render-strategic-atlas.py` | `py tools/render-strategic-atlas.py`  (no args; composites the 17 tactical maps + adjacency) |
| Render the 50-fief adjacency graph | `render-strategic-50.py` | `py tools/render-strategic-50.py [rom] [out.png]`  (*separate tool — there is no `--variant`*) |
| Test a command's effect | snap protocol | `py tools/capture-test.py <tag> pre` → make the move → `… <tag> post` → `… <tag> diff [--fief N]`; `--note "..."` on pre/post for provenance. See `commands/README.md`. |
| Run an effect handler in the emulator | `run-effect.py` | `py tools/run-effect.py <grow\|build\|dam\|give…> <sram_pre.dmp> [amount]` |
| Analyze the VM opcode table | `analyze-vm-opcodes.py` | `py tools/analyze-vm-opcodes.py <survey\|dispatch\|classify>` |
| Decompile a bytecode sub → C | `vm_decompile.py` | `py tools/vm_decompile.py disasm/bank_NN_vm.asm <addr_hex>`  (`_vm.asm` exists for banks 00/01/02/15 only — see ROADMAP epic) |
| Analyze an SRAM dump (landscape) | `analyze-sram.py` | `py tools/analyze-sram.py <structure\|detail> <dump.dmp>` |
| Decode the live province table | `sram-decode-province.py` | `py tools/sram-decode-province.py <dump.dmp> [--diff <other.dmp>]` |
| Province adjacency table | `adjacency.py` / `adjacency-50.py` | `py tools/adjacency.py "<rom>"` (17-fief) · `py tools/adjacency-50.py "<rom>"` (50-fief) |
| Fief strategic profile (50-fief) | bulk / drill-down | all-50 table → `py tools/fief-analysis-50.py` · one fief → `py tools/profile-fief-50.py <Name…>` |
| Simulate economy / check a formula | `econ_sim.py` | `py tools/econ_sim.py` |
| Decode a combat trace | `combat-trace-decode.py` | `py tools/combat-trace-decode.py <trace.txt[.gz]>` |
| Find a named address | `mesen-labels.toml` | grep it — **never re-trace a known label** |
| What is this dump / capture provenance | `data-index.py` | `py tools/data-index.py scan` (backlog) · `… auto` (bulk-classify by naming convention) · `… add <file> --note "…"` · `… show` |
| What's the frontier / what's next | — | show `PROJ/ROADMAP.md` |

**Emulator pattern** (for `nobunaga_vm.py`-based runs): load SRAM → switch bank → set `vm_pc`/`vm_sp` (pre-allocate locals!) → run. Details in `CONTEXT.md`.

**After the work:** if the session produced a reusable result, register it — update `ROADMAP.md` (move the item), `traces/README.md` (if a precious dump was captured, name it per convention), or `tools/README.md` (if a tool was added/changed). Leaving the result unregistered is how the project drifts.
