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

## The batch loop (regen between batches = the fixpoint)

Each Workflow run handles ONE batch of clusters. Regen after each batch "relinks": the new toml
names propagate into every call-site, so the next batch reads a less-sparse `bank_NN.c`. Order
**leaves-first** so roots (turn loop, AI planner) are named against already-named callees.

1. **Cluster (leaves-first):**
   `py -3 tools/cluster-anon-subs.py <bank> --by-callgraph --json` → 14ish clusters. Take the first
   few un-done clusters as this batch (early batches = leaves; commit between batches).
2. **Gather OPTIONAL seeds** (degrade gracefully — bank_00 has almost none): named callees a root
   would lean on. Inject `vm_bootstrap $A778`, the AI war-target planner `$A4AB-$A5AF`
   ([[project_nobunaga_ai_war_architecture]]), and any bank_15/01 callees the batch calls. Oracle
   hints (econ formulas) only for oracle-rich banks.
3. **Run the Workflow** (the saved harness — do not inline a fresh script):
   ```
   Workflow({ scriptPath: "<this-skill>/scripts/label-walk.workflow.js",
              args: { bank: 0, clusters: <slice of the --json>, seeds: "<text>", oracle: "<text|omit>" } })
   ```
   Returns `{ bank, verified:[{addr, final_name, verdict, confidence, evidence}] }`.
4. **ROOT writes survivors** to `mesen-labels.toml` `[prg.bankN]` — one consolidated block, each
   line flagged `# [HIGH]/[MED]/[LOW] <verdict>`. REFUTED → `helper_<addr>` (honest, not a guess).
   Dedup against existing labels; resolve any address collision before writing.
5. **Regen guard** (the relink + the cross-bank-bleed detector):
   ```
   py -3 tools/mesen-labels.py --mlb --asm
   py -3 tools/decompile-all.py
   git diff --numstat decompiled/      # ONLY bank_NN.c may change — any other bank = STOP (bleed)
   git diff decompiled/bank_NN.c       # diff must be PURE RENAMES (sub_XXXX→name), zero logic lines
   ```
   If another bank's `.c` changed, a switchable-window label leaked banks — fix the section, don't
   commit. (This guard is how the bank_01 walk caught a real decompiler bug.)
6. **Commit** the batch (`mesen-labels.toml` + `.mlb` + `disasm/*_named.asm` + `decompiled/*.c`),
   then loop to step 1 for the next batch reading the now-enriched C.

## Done / register

A bank is done when `cluster-anon-subs.py <bank>` reports 0 anon. Update `ROADMAP.md` (move the
item, note CONFIRMED/AMENDED/REFUTED tally) and, if a tool changed, `tools/README.md` — same
session. The verifier checks the **orchestrator** too: if reconcile agents reject a premise you
fed them, you were wrong, not them.
