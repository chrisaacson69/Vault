---
name: label-walk
description: Name the anonymous decompiled subs in a Nobunaga RE code bank via the proven multi-pass pipeline (propose@C → independent-verify@bytecode → root writes toml → regen-guard). Use when working in projects/game-annotation/nobunaga and the ask is "label-walk bank N", "name the anon subs in bank_00/02", "run the label walk", "name bank N's functions", or finishing a bank's symbol table. Drives a Workflow — explicit multi-agent opt-in.
user-invocable: true
allowed-tools: Bash, Read, Edit, Write, Workflow, Grep
---

# label-walk — name a bank's anonymous subs

Crystallizes the bank_01 result (57/57 named in one session): a bank's anon `sub_XXXX`
defs become functional names through **decompiler stages — scan → symbol-table → link →
typecheck**. See [[project_nobunaga_bank01_complete]], [[feedback_re_is_multipass_compilation]],
[[feedback_verification_independence_is_altitude]].

**Rule 0 — anti-drift (read first, every run):** `PROJ/CONTEXT.md` then `PROJ/tools/README.md`.
`PROJ` = `C:\Users\Chris.Isaacson\Vault\projects\game-annotation\nobunaga`. Launcher is **`py -3`**
(not `python` — silent failure). The single source of truth for names is `mesen-labels.toml`;
everything else is projected from it. Verify every toml edit against a clean re-read
([[feedback_silent_tool_failure_hallucination]]).

## Where verification lives (the non-negotiable shape)

`propose@decompiled-C → independent verify@BYTECODE → ROOT writes survivors`. Verification flows
**lateral** (an independent sibling at a *lower* altitude), never up (rubber-stamp) or self
(correlated). The proposer reads `decompiled/bank_NN.c`; the verifier drops to the raw VM
bytecode (`disasm/bank_NN_vm.asm` + ext-op table + `native-call-index`) because the C is lossy.
**Root (this skill) is the single writer + the regen guard** — the Workflow returns data, writes
nothing. The bank_01 run proved the verifier corrected 29/50 proposer names; self-QA would have
rubber-stamped them.

## The batch loop (regen between batches = the fixpoint) — now 3 calls per batch

Each Workflow run handles ONE batch of clusters. Regen after each batch "relinks": the new toml
names propagate into every call-site, so the next batch reads a less-sparse `bank_NN.c`. Order
**leaves-first** so roots (turn loop, AI planner) are named against already-named callees. Two
scripts (`label-walk-prep.py`, `label-walk-apply.py`) make the mechanical work deterministic — the
coordinator only drives the Workflow. **Proven across bank_01 + bank_00 (2026-06-01); the glue was
scripted after bank_00 to make whole-bank runs hands-off.**

Per batch (loop until `prep` reports 0 anon = bank done):

1. **PREP — next batch + auto-seeds (deterministic):**
   ```
   py -3 tools/label-walk-prep.py <bank> --batch-clusters 3 [--landmarks "<bank-specific context>"] --json
   ```
   Emits `{bank, clusters:[first 3 leaves-first], seeds}` — `seeds` auto-pulls every already-named
   sub in the bank from the toml. Pass `--landmarks` ONCE per bank for the analytical context a
   script can't know (e.g. combat: the `$AFE1/$9647/$9675/$830B` engine spine from
   [[project_nobunaga_combat_architecture]]; oracle-rich banks: the econ formulas). Run without
   `--json` first for a human summary + remaining count.
2. **WORKFLOW — propose→verify (the agents; the only non-deterministic step):**
   ```
   Workflow({ scriptPath: "<this-skill>/scripts/label-walk.workflow.js", args: <prep's JSON> })
   ```
   Returns `{ bank, verified:[{addr, final_name, verdict, confidence, summary, evidence}] }`; the
   full result is also written to the task-output file (path in the completion notice).
3. **APPLY — write + regen + guard + commit (deterministic, HARD-GATED):**
   ```
   py -3 tools/label-walk-apply.py <bank> <task-output-file.json> --commit
   ```
   Writes survivors to `[prg.bankN]` (verdict/confidence-flagged, `summary` as the comment, REFUTED
   → `helper_<addr>`, dedup + collision guard), regens (`mesen-labels.py --mlb --asm` +
   `decompile-all.py`), then **HARD-FAILS (exit 2)** unless only `bank_NN.c` changed (no cross-bank
   bleed) and its diff is pure renames — then commits. A non-zero exit means STOP and inspect (a
   switchable-window label leaked banks, or logic moved); do not paper over it. Run once without
   `--commit` to preview the guard.

**Why auto-writing is correct, not a shortcut:** the verifier IS the check (lateral, lower-altitude
bytecode); a coordinator self-review rubber-stamps ([[feedback_verification_independence_is_altitude]]).
The only thing that must gate the write is the deterministic guard, which `apply` makes a hard
assertion. Mechanical→scripts, analytical→agents ([[feedback_mechanical_vs_analytical_fanout]]).

## Done / register

A bank is done when `cluster-anon-subs.py <bank>` reports 0 anon. Update `ROADMAP.md` (move the
item, note CONFIRMED/AMENDED/REFUTED tally) and, if a tool changed, `tools/README.md` — same
session. The verifier checks the **orchestrator** too: if reconcile agents reject a premise you
fed them, you were wrong, not them.
