---
status: active
created: 2026-05-29
---
# CONTEXT — Nobunaga RE Project Hot Layer
> Read this FIRST every session. It exists so no session has to re-derive vocabulary, re-find data, or rebuild a tool. If you catch yourself searching for "where was that data" or writing a script that might already exist — the answer is here or in the registries this points to.

**Narrative / chapters:** [README.md](./README.md) — the 18-chapter story, cartridge facts, method.
**This file:** the working vocabulary + the canonical-artifact index + quick-routes. Point, don't re-derive.

## The registries (registration layer — added 2026-05-29)

| Registry | Answers | File |
|---|---|---|
| **Tools** | "does a tool for this already exist? how do I run it?" | [tools/README.md](./tools/README.md) |
| **Data / dumps** | "where is that SRAM/PPU/trace, and what does it represent?" | [traces/README.md](./traces/README.md) |
| **Plans / frontier** | "what's done, what's open, what's parked?" | [ROADMAP.md](./ROADMAP.md) |
| **Command tests** | "how do I snap a command's effect? what's the field layout?" | [commands/README.md](./commands/README.md) |

## Canonical artifacts — the single source of truth for each thing

**Do not regenerate these ad-hoc. Point at them.**

| Artifact | Is the source of truth for | Notes |
|---|---|---|
| `mesen-labels.toml` | every named address (RAM/SRAM/ROM, all 16 banks) | ⚠️ its header references `tools/mesen-labels.py` which is **missing** — applier needs (re)writing; until then labels are applied by hand. |
| `tools/vm-opcodes-v2.toml` | the VM opcode spec (256 ops, `verified=true` flags) | sole version; there is no v1. Sourced from nesdev t=15931 + ROM dispatch. |
| `tools/nobunaga_vm.py` + `tools/cpu6502.py` | runnable VM/6502 emulator (the "ask the ROM" tool) | loads `mesen-labels.toml` for symbolic trace. Standard pattern: load SRAM → switch bank → set vm_pc/vm_sp (pre-allocate locals!) → run. |
| `tools/vm_decompile.py` | bytecode → readable C | new investigations are "decompile and read," not "walk bytecode by hand." |
| `tools/econ_sim.py` | the verified economy formulas (Grow/Build/Give/Dam/harvest) | end-to-end validated against emulator, May 2026. |
| `disasm/bank_NN_vm.asm` | per-bank VM bytecode disasm | `*_labeled.asm` = native+labels; `*_vm.asm` = VM expansion. |
| `commands/*.md` | per-command effect handler + formula + test log | one file per lord command. |
| ROM: `Nobunaga's Ambition (USA).nes` | the only ground truth | SHA-1 `1F7D440085E9BC17FA22B23744D611E69B978C07`. |

## Glossary — vocabulary not to re-derive

- **VM / Sea-16** — the bytecode interpreter most game logic runs on; the 6502 is mostly a state machine hosting it. Reference impl: `tools/sea16-reference.c` (NovaSquirrel). The VM is a "perfect C interpreter" → hence `vm_decompile.py`.
- **Syscall API** — 23-entry dispatch table at `$C173` (bank 15), called via `jsr $F226`. Mechanism is `PHP + JMP ($FFFE)`, *not* BRK (ch1 framing corrected in ch4).
- **Frame pointer / locals** — VM subroutines allocate frame-local words; addresses are runtime-computed (`frame_ptr + signed byte`). **Static grep misses these** — low-SRAM data you can't grep is almost always a VM frame local (e.g. combat damage words `$6FF6-$6FFC`).
- **ext-op / `math32_3arg` / `math32_2arg` / `pct_op`** — the VM's 32-bit arithmetic helpers (bank-15 bytecode subs, built on the `B7` extended opcodes). **DERIVED 2026-05-29** (`tools/probe-math32.py`): `pct_op(a,b)=⌊ab/100⌋`, `math32_3arg(a,b,c)=⌊ab/c⌋`, `math32_2arg(a,b)=⌊100a/(a+b)⌋`. No longer a blocker. (The B7 sub-op table itself remains undecoded but is not needed — the 3 composite helpers are the formula interface.)
- **`pct_op`** — percentage operator used across drains/penalties (e.g. tax penalty `stat -= pct_op(stat, |Δtax|)`).
- **Province record** — 26 bytes at `$7001 + idx*26`, 16-bit LE. Field map lives in [commands/README.md](./commands/README.md) §"Per-fief field layout" — gold/debt/town/rice/output/dams/loyalty/wealth/men/morale/skill/arms/header.
- **High-water marks** — several stats track their *low*-water value; harvest/drain formulas key off these. See [[project_nobunaga_harvest_formula_cracked]].
- **17-fief vs 50-fief** — two scenarios/ROM-layouts. Many tools have a `-50` twin; treat scenario as a `--variant` axis, not a separate codebase.
- **PRE/POST snap** — the command-test capture protocol (`capture-test.py`); files land in `traces/<tag>_PRE.dmp` / `_POST.dmp`.

## Quick-routes — "to do X, use Y" (don't rebuild)

- **Render a fief's tactical map (from PPU dump):** `tools/render-fief-from-ppu.py <fief>` *(parameterized; see tools/README — replaces the 16 per-fief copies)*.
- **Test a command's effect:** follow [commands/README.md](./commands/README.md) snap protocol → `capture-test.py <tag> pre|post|diff`.
- **Run an effect handler in the emulator:** `tools/run-effect.py`.
- **Decode a bytecode routine to C:** `tools/vm_decompile.py`.
- **Find a named address:** grep `mesen-labels.toml` — do **not** re-trace it.
- **Capture data / find what a dump is:** `tools/data-index.py add <file> --note "..."` registers provenance; `scan` lists un-contextualized files; `show` prints the index. Never leave a capture un-noted — see [traces/README.md](./traces/README.md).
- **Simulate the economy / check a formula:** `tools/econ_sim.py`.
- **Province adjacency / strategic map:** `tools/adjacency.py` / `tools/render-strategic-atlas.py` (`--variant 17|50`).

## The discipline (why this file exists)

This project is the in-house case study for [[research/principled-llm-code]] / [[notes/context-cache-hierarchy]] / [[notes/claude-code-skill-engineering]]: **drift is re-derivation.** A tool rebuilt because it couldn't be found, a dump re-captured because nobody noted where it was, a label re-traced — each is a fresh stochastic sample that diverges. The cure is registration: this file + the three registries are the hot layer. Keep them current; when something here goes stale (like the missing `mesen-labels.py`), fix the pointer, don't route around it.
