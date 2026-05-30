---
status: active
created: 2026-05-29
---
# ROADMAP — Living Frontier Ledger
> The persistent, dynamic task ledger for an exploratory project. Survives across sessions (unlike a session's scratch task list). Update it at the end of every session: move items between **Now / Open / Parked / Done**. This is where "what were we doing?" gets answered without re-deriving it.

## Now — current frontier
- **Tooling-discipline pass (this project's project)** — making NA1 stop drifting. DONE 2026-05-29:
  - [x] Phase 1 — registration layer: `CONTEXT.md`, `tools/README.md`, `traces/README.md`, this file.
  - [x] Phase 2 — `/nobunaga` dispatcher skill over the deterministic tools (anti-drift Rule 0 baked in).
  - [x] Phase 3 (started) — 16 `render-*-from-ppu.py` → `render-fief-from-ppu.py <fief>` (done); 3 stray scripts moved into `tools/` + made location-independent. **Still pending:** merge opcode trio, SRAM quartet, selector variants, `--variant` the 17/50 twins, resolve title-renderer duplicate.
  - [x] Phase 4 — trace bloat **gzipped** (not deleted — they're empirical, not regenerable): ~2.9 GB → ~250 MB, lossless; `combat-trace-decode.py` reads `.gz` transparently.
  - [x] **Data-provenance system** — `tools/data-index.py` + `traces/INDEX.tsv`; `capture-test.py` auto-registers snaps. New captures are self-documenting.
- **Backlog to triage:** `data-index.py scan` reports ~147 legacy un-contextualized dumps. Contextualize the recognizable ones, purge the rest — incrementally, not all at once.
- **Remaining Phase-3 merges** (lower priority, each confirmed before deleting): opcode trio → `analyze-vm-opcodes.py`; SRAM quartet → `analyze-sram.py --mode`; selector/trace-selector variants → `--mode`; adjacency/strategic 17-vs-50 → `--variant`.

## Open — questions & blockers
- **`math32_3arg` / `math32_2arg` ext-opcodes** — the standing blocker for exact *magnitudes* of several formulas. Until decoded, magnitudes are empirical fits, not derivations. *Highest-leverage unlock.*
- **Dam formula** — partial; output-coupling derived, exact constants pending (needs the ext-op unlock or a clean isolated test). See [commands/dam.md](./commands/dam.md).
- **Combat damage** — 2 of 4 quadrants confirmed via Lua; 2 remain. See ch17 + [[project_nobunaga_combat_damage_formula_decoded]].
- **AI war scorer** (`sub_B6B4` via `$B79B`) — RNG-weighted, not argmax-weakness; hits the ext-op wall too. See [[project_nobunaga_ai_war_architecture]].
- **`mesen-labels.py` missing** — the applier referenced by `mesen-labels.toml` doesn't exist; (re)write it or fix the header.

## Parked — intentional, not forgotten
- **Chapter 19** — combat resolution (commander death, retreats, supplies). Planned; combat terminators already understood ([[project_nobunaga_combat_terminators_and_illness]]).
- **Synthesis chapter** — bytecode → strategy counter-graph / dominance frontier. The payoff chapter; waits until mechanics are fully mapped.
- **Appendix** — per-command effect formulas + AI thresholds + adjacency; ongoing accretion.
- **Visual atlas** — render all 17 tactical maps + strategic map for the synthesis ([[project_nobunaga_visual_extraction]]).

## Done — recent (newest first; trim to ~15, full history is in chapters + git)
- 50-fief adjacency cracked, verified 5 ways ([[project_nobunaga_50fief_adjacency]]).
- Full NA1 economy engine unified (Grow/Build/Give/harvest verified; Dam partial) ([[project_nobunaga_full_econ_engine]]).
- Natural-death + event-spawn formulas cracked.
- VM bytecode → C decompiler operational ([[project_nobunaga_vm_decompiler]]).
- Combat architecture mapped end-to-end (bank-2 walk).
- Chapters 1–18 drafted (see [README.md](./README.md) chapter map for per-chapter status).

## How to use this file
End each session by asking the [[notes/claude-code-skill-engineering]] compounding question, applied to *plans*: did anything move? Promote/park/close items here. An item that's been in **Open** for many sessions with no progress is a signal — either it's blocked on one thing (name it) or it's actually Parked (be honest).
