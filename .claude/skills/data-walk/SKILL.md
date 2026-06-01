---
name: data-walk
description: Name the anonymous DATA elements (ROM tables/strings/blobs, RAM/SRAM variables) in the Nobunaga RE project by back-inference from the now-named subs that reference them. The variable-side twin of /label-walk. Use when working in projects/game-annotation/nobunaga and the ask is "data-walk", "name the ROM tables", "label the hot RAM vars", "name the data at $ADDR", "what is this table/blob", or finishing a region's data symbols. Oracle/provenance lanes are deterministic (zero agents); the analytical residue drives a Workflow (explicit multi-agent opt-in).
user-invocable: true
allowed-tools: Bash, Read, Edit, Write, Workflow, Grep
---

# data-walk — name a region's anonymous data

The variable-side twin of `/label-walk`. Once the code banks are named, a data element's
meaning is inferred from the **named sub that references it**: a `play_growth_animation` sub that
reads `blob_X` ⟹ `blob_X` is the growth animation, and that label propagates to every other
referencer through the toml (same multi-pass-linker trick as the code walk).
See [[project_nobunaga_decompiler_readability_pass]], [[feedback_re_is_multipass_compilation]],
[[feedback_mechanical_vs_analytical_fanout]].

**Rule 0 — anti-drift (read first, every run):** `PROJ/CONTEXT.md` then `PROJ/tools/README.md`.
`PROJ` = `C:\Users\Chris.Isaacson\Vault\projects\game-annotation\nobunaga`. Launcher is **`py -3`**
(not `python` — silent failure). Single source of truth for names is `mesen-labels.toml`; everything
else is projected from it. Verify every toml edit against a clean re-read
([[feedback_silent_tool_failure_hallucination]]).

## The two enabler tools (already built + registered)

| Tool | Surface | Frontier cmd |
|---|---|---|
| `tools/rom-xref.py` | ROM data ($8000+, reached as imm-word pointers `$8A/$8C/$8E`) — strings, tables, blobs | `rom-xref.py frontier [--class str\|tbl]` · `stats` |
| `tools/data-xref.py` | RAM/SRAM vars ($6000-$7FFF, abs reads/writes) | `data-xref.py hot --unlabeled --min N` |

Both group references **by the named sub** (`rom-xref refs <addr>` / `data-xref refs <addr>`) — that
grouping IS the provenance the names come from. A region is done when its frontier cmd returns 0.

## Three lanes — run the deterministic ones FIRST (they clear the majority for free)

Mechanical→scripts, analytical→agents. Most data is named with **zero agents**.

1. **ORACLE (deterministic, zero agents) — ROM strings.** The decoded ASCII *is* the ground truth,
   so no verifier is needed. `py -3 tools/rom-xref.py strings --toml` emits ready `msg_<slug>` lines
   → paste into `[prg.bankN]`. (297 strings landed this way in one pass.)
2. **PROVENANCE (deterministic, zero agents) — ROM tables/blobs.** Named from the referencing named
   sub, honest by construction. `py -3 tools/rom-xref.py tables --toml` emits `<refsub>_data_<addr>`
   (or `jumptab_<addr>` only when content-verified as a clean code-pointer table); the bucket
   heuristic + byte preview live in the COMMENT, not the name (*vague-but-correct beats
   specific-but-wrong*). (125 tables landed this way.)
3. **ANALYTICAL (Workflow, agents) — the opaque residue + anything that deserves a *real* name.**
   The numeric tables whose role is interpretive (map coords, palettes, rate books, combat geometry)
   and the RAM/SRAM vars. This is where verification must flow lateral. Drives the Workflow below.

## The analytical loop (mirrors label-walk: propose → independent verify → root writes)

`propose@referencing-subs → independent verify@bytes+bytecode → ROOT writes survivors`. The proposer
reads the named referencers (their `decompiled/bank_NN.c` use of the addr); the verifier drops to the
raw bytes + the referencer's bytecode (ground truth; C is lossy). Root (this skill) is the single
writer + the regen guard — the Workflow returns data, writes nothing
([[feedback_verification_independence_is_altitude]]).

1. **PREP — list the analytical frontier (deterministic):**
   ```
   py -3 tools/rom-xref.py frontier --class tbl        # ROM tables still unlabeled
   py -3 tools/data-xref.py hot --unlabeled --min 3    # RAM vars by ref-count
   ```
   Build the `targets` array: `[{addr, refsubs, preview, rw?}]` (the frontier output already carries
   the referencing subs + a byte/count preview — copy them in so agents start with the provenance).
2. **WORKFLOW — propose→verify (the only non-deterministic step):**
   ```
   Workflow({ scriptPath: "<this-skill>/scripts/data-walk.workflow.js",
              args: { region: "rom"|"ram", targets: [...], seeds: "<region structure / field maps>" } })
   ```
   Returns `{ region, verified:[{addr, final_name, verdict, confidence, summary, evidence}] }` (also
   written to the task-output file named in the completion notice). REFUTED ⟹ the honest provenance
   name `<refsub>_data_<addr>` — data ALWAYS has one, so there is no `helper_` fallback.
3. **APPLY — write + regen + guard + commit (deterministic):**
   - Write survivors to the right toml section: ROM data → `[prg.bankN]`, RAM/SRAM → `[ram]`
     (one `"0xADDR" = { name, comment = summary }` line each; the `summary` is the comment verbatim).
   - Regen: `py -3 tools/mesen-labels.py --mlb --asm` then `py -3 tools/decompile-all.py`.
   - **GUARD (the data variant):** the decompiled diff must be **pure `0xADDR`→name substitutions**
     (incl. `name[idx]` when `annotate_array_access` fires on a labeled base) — zero logic lines.
     ⚠️ Unlike the code walk's single-bank guard, a data addr is referenced from MANY banks, so the
     diff legitimately spans banks — that is NOT bleed. The integrity anchor is **`effect_grow` stays
     byte-identical** (it uses math32 host-calls, a known-good body). Confirm with `git diff
     decompiled/` and eyeball that every changed line is a name-for-hex swap.
   - Commit (toml + .mlb + decompiled/ + ROADMAP).

`label-walk-apply.py` is **not** reusable here — its guard hard-asserts a single bank + `sub_XXXX→`
renames. Data spans banks and renames `0xADDR→`. Do the APPLY as above (proven on the 3 combat
tables, 2026-06-01); script a `data-walk-apply.py` only once a multi-batch run makes the hand-write
the bottleneck.

## Done / register

A region is done when `rom-xref frontier` (its class) and `data-xref hot --unlabeled` return 0.
Update `ROADMAP.md` (CONFIRMED/AMENDED/REFUTED tally, move the item) and `tools/README.md` if a tool
changed — same session. The verifier checks the **orchestrator** too: a strong cross-reference (e.g.
adjacency vs claimed coordinates) is the data-side equivalent of reproducing a formula blind.
