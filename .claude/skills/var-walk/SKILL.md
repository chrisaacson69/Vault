---
name: var-walk
description: Name the positional frame slots (arg1..arg4 / local0..local11) of the decompiled Nobunaga subs by role-inference + caller-propagation — the 3rd sibling to /label-walk (names subs) and /data-walk (names data). Use when working in projects/game-annotation/nobunaga and the ask is "var-walk bank N", "name the args/locals", "name the frame variables", "rename the localN in <sub>", or finishing a bank's variable names. Drives a Workflow — explicit multi-agent opt-in.
user-invocable: true
allowed-tools: Bash, Read, Edit, Write, Workflow, Grep
---

# var-walk — name a bank's frame args & locals

The variable-side completion of the symbol table. `/label-walk` names anonymous **subs**;
`/data-walk` names **data** (ROM tables, RAM vars); **var-walk** names the **stack-frame slots** the
decompiler prints positionally — `effect_grow(arg1, arg2)` / `local11` → `effect_grow(fief, amount)`
/ `gain`. Same multi-pass shape: **scan → symbol-table → link → typecheck**. Proven end-to-end on
`effect_grow` ($87F0) 2026-06-03 (M4 pilot). See [[project_nobunaga_label_walk_skill]],
[[project_nobunaga_data_walk_skill]], [[feedback_re_is_multipass_compilation]],
[[feedback_verification_independence_is_altitude]].

**Rule 0 — anti-drift (read first, every run):** `PROJ/CONTEXT.md` then `PROJ/tools/README.md`.
`PROJ` = `C:\Users\Chris.Isaacson\Vault\projects\game-annotation\nobunaga`. Launcher is **`py -3`**.
The single source of truth for names is `mesen-labels.toml`; the slot names live in
`[vars.bankN."0xADDR"]` sections (ADDR = the sub's stub). Verify every toml edit against a clean
re-read ([[feedback_silent_tool_failure_hallucination]]).

## What makes a slot nameable (the one rule that matters)

**Name a slot ONLY if it has ONE coherent role across the whole sub.** A slot REUSED for two
disjoint things — `local10` is `header-output` headroom, *then* a drain% — must be **LEFT
POSITIONAL** (verdict REFUTED). That is the honest "this is scratch" signal, not a miss. The
decompiler models frame slots as raw storage; the compiler reused one for two temporaries, and a
single semantic name would lie. This conservatism is what keeps the renamed C trustworthy.

Two evidence lanes, both now available (the M3 reverse-push fix made caller-propagation legible):
- **usage-role (body):** `slot->output` ⇒ province record ptr (`fief`); `pct_op(base, slot)` ⇒ a
  percent; `daimyo_record_ptr(slot)` ⇒ daimyo idx; loop bound / `arr[slot]` ⇒ index; accumulator ⇒ total.
- **caller-propagation:** the expression each caller pushes into an arg slot (call sites now print in
  callee-param order, so arg1 = first pushed-arg shown).

## Where verification lives (the non-negotiable shape)

`propose@decompiled-C → independent verify@BYTECODE + caller-pushes → ROOT writes survivors`.
Verification flows **lateral** (an independent sibling at a *lower* altitude), never up (rubber-stamp)
or self (correlated). The proposer reads `decompiled/bank_NN.c` + callers; the verifier drops to the
raw VM bytecode (`disasm/bank_NN_vm.asm`) to see which frame offset each slot actually is and how it's
used. **Root (`var-walk-apply.py`) is the single writer + the regen guard** — the Workflow returns
data, writes nothing.

## The batch loop (regen between batches = the fixpoint)

Targets are **named** subs (anon ones → `/label-walk` first) that still carry positional slots and have
no `[vars.*]` section yet. Order is leaves-first so a caller is named when its callees already are.
Each batch the toml grows and the next `prep` returns the next un-done subs (one section per sub =
"processed once"). Per batch, loop until `prep` reports 0:

1. **PREP — next batch + role vocabulary (deterministic):**
   ```
   py -3 tools/var-walk-prep.py <bank> --batch 8 [--landmarks "<bank-specific context>"] --json
   ```
   Emits `{bank, subs:[{addr,name,slots}], seeds}` — `seeds` is the role-inference vocabulary
   (province fields, helper arg semantics, the conservatism rule). Pass `--landmarks` once per bank
   for analytical context a script can't know. Run without `--json` first for a human summary +
   remaining count.
2. **WORKFLOW — propose→verify (the agents; the only non-deterministic step):**
   ```
   Workflow({ scriptPath: "<this-skill>/scripts/var-walk.workflow.js", args: <prep's JSON> })
   ```
   Returns `{ bank, verified:[{addr, name, slots:[{slot,final_name,verdict,confidence,summary}]}] }`;
   the full result is also written to the task-output file (path in the completion notice).
3. **APPLY — write + regen + guard + commit (deterministic, HARD-GATED):**
   ```
   py -3 tools/var-walk-apply.py <bank> <task-output-file.json> --commit
   ```
   Writes `[vars.bankN."0xADDR"]` sections (CONFIRMED/AMENDED slots; REFUTED → a `# left positional`
   note so the sub still counts as processed), regens (`decompile-all.py`), then **HARD-FAILS (exit 2)**
   unless **only `bank_NN.c` AND `all_banks.c`** changed (var renames legitimately hit the merged view
   too — that is the difference from label-walk) and each diff is a pure rename — then commits. Run
   once without `--commit` to preview the guard. A non-zero exit means STOP and inspect (a name
   leaked to another bank's subs, or a slot name collided).

**Token-economy mode (`single: true`):** add `"single": true` to the Workflow args to collapse
propose→verify into ONE fused agent per sub (it proposes AND self-checks against bytecode+callers in
one pass). Halves agent count — use when rate-limited or for a large batch. It trades the independent
second-altitude verifier for economy (Chris-sanctioned); the deterministic regen guard still gates the
write. Default (omit the flag) keeps the stronger 2-agent propose→verify.

**Why auto-writing is correct, not a shortcut:** the verifier IS the check (lateral, lower-altitude
bytecode + independent caller read); a coordinator self-review rubber-stamps
([[feedback_verification_independence_is_altitude]]). The deterministic regen guard is the only thing
that gates the write, and `apply` makes it a hard assertion.

## Done / register

A bank is done when `var-walk-prep.py <bank>` reports 0 remaining. Update `ROADMAP.md` (move the M4
item, note the slot tally) and, if a tool changed, `tools/README.md` — same session. The slot names
are projected into `decompiled/*.c` automatically by the regen; nothing else consumes them (`.mlb`/
`.asm` don't carry frame-slot names, so `mesen-labels.py` is not re-run).
