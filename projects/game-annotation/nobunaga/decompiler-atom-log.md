---
status: active
created: 2026-06-05
---
# Decompiler Atom Log — the running case ledger
> One row per CFG-structuring **atom** (a missing inverse-lowering) discovered while folding the
> codebase function-by-function. The discipline (Chris, 2026-06-05): **fix as we go, but LOG each
> case** so we can see whether a fix GENERALIZES (clears many subs) or is a 1-off (clears one). An
> atom that only ever clears its discovery sub is a smell — it means we pattern-matched a shape
> instead of inverting a compiler lowering.

**Links:** [decompiler-bottom-up-thesis](./decompiler-bottom-up-thesis.md) · [ROADMAP](./ROADMAP.md) (CFG epic) · tools: `vm_reduce.py` · `v2-corpus.py` · `probe-cfg-reducibility.py`

## How to read this

Each atom = the inverse of one structured-source → bytecode lowering the compiler did. The forward
direction (codegen) is finite; so is the inverse table. A row records: the **shape** (what the CFG
looks like), the **forward lowering** it inverts, **where found**, the **fix** (where in the
reducer), and the **generalization** (subs cleared / corpus Δgotos). "Subs cleared" counts subs
whose goto-count dropped because of THIS atom — the generalization signal.

## Registry

| # | Atom | Forward lowering it inverts | Found in | Subs cleared | Δgotos | Status |
|---|---|---|---|---|---|---|
| 1 | multi-latch `while(1)`-with-`continue`s | each `continue` → jump-to-header (extra back-edge) | `vm_bootstrap $A778` | 2 (`$88AC`, `$D59D`) + enables #2 | part of −20 | ✅ landed `3c10cf6` |
| 2 | multi-level break = honest goto | nested-loop break to a far target → goto (C has only 1-level break) | `vm_bootstrap $A778` | 1 (`$A778` 14→1) | part of −20 | ✅ landed `3c10cf6` |
| 3 | routing-block absorption (adjacent) | a fall-through between regions → a standalone `goto L_X` forwarding block | `init_new_game_state $89A3` | **7** (`$89A3` 16→0, `$83E2` 34→30, `$813C` 6→0, `$90E8`/`$911E` 5→1, `$A066` 1→0, `$840B` 2→0) | **−37** (1025→988) | ✅ generalized |
| 4 | switch convergence/shared-merge folding | the VM's `switch` (`$D5`/`$D9`) with fall-through cases + a SHARED merge/exit | `$A30D`, `$9C84`, … (36 switch subs) | TBD — **multi-shape, hard** | up to ~**365** | 🔬 deep-dive done, not implemented |

Corpus: atom-3 start **V2 1025** → end **988** vs V1 1151; behind-V1 59 → **57**. `none` bucket is the target (41 subs); this cleared a slice, the rest are NON-adjacent routing (still bailed).

---

## Atom 1 — multi-latch `while(1)`-with-`continue`s
**Shape.** A natural loop with >1 back-edge to its header (latches). The extra back-edges are
`continue` statements; the compiler lowered each `continue` to a jump-to-header.
**Why it bailed.** `_structure_loop` flat-spanned *every* multi-latch loop (a blanket bail), plus a
rung-4d `nested_loop` guard refused any loop containing a multi-latch inner loop.
**Fix (`vm_reduce.py`).** Attempt `while(1)` for a multi-latch loop (header→`continue`, exit→`break`),
reduce()'s self-validation the backstop; deleted the `nested_loop` guard. The one unsound shape — a
body-TAIL `if(C) continue;` whose fall IS the loop-back (the gate collapses the exit into the
back-edge) — is collapsed by the both-terminal walk to a single `if(!C) break;`.
**Generalized?** YES — cleared `$88AC` (the session-7a "4 stacked loops", now beats V1) and `$D59D`,
and is the enabler for atom 2 on the spine. Not a 1-off (a fundamental loop shape).

## Atom 2 — multi-level break = honest goto
**Shape.** A loop exit edge whose target escapes the PARENT loop too (e.g. `goto DISPLAY` firing from
3 nested loops). C's single-level `break` can't reach it.
**Why it bailed.** The reducer treated the far target as a loop exit and tangled (convergent-exit
grabbed a block shared with the parent loop → `cross_edge_top`).
**Fix (`vm_reduce.py`).** `far_by_loop` (computed in `_structure_loop` relative to `outer_loop`)
records exits that escape the parent; `_terminal` emits them as honest `goto L_t`, and they're
dropped from the loop's exit set so the remaining single-level exit folds. Each inner loop keeps the
goto; only the outermost loop still CONTAINING the target breaks to it.
**Generalized?** Partially — the multi-level break is rarer (it folded `vm_bootstrap` 14→1, the
project spine). Sound and correct; broader reach TBD as more nested-loop subs are walked.

## Atom 3 — routing-block absorption (adjacent)  ✅
**Shape.** A standalone **`L_X: goto L_Y;`** block — single successor, NO statement — sitting between
two regions (here, between chained `for` loops). The compiler emitted it as a fall-through-forwarding
stub. Canonical instance: `init_new_game_state`'s `$8A05: goto L_8A13;` between the `daimyo_turn_order`
loop and the `province_ai_state` loop.
**Why it bailed.** `_structure_loop`'s adjacency guard bailed any loop whose exit is a pure-routing
block (`bounded and len(succ)==1 and no stmt`) — on the theory that "it emits nothing, so the
address-based gate can't anchor the loop's exit on it." The `$89FC` loop flat-spanned for this
reason; worse, the near-complete tier-1 fold (got to just **1 goto**) then FAILED the gate, so tier-2
kept ~10 regions flat → **16 gotos** for a sub that is otherwise entirely reducible.
**Forward lowering.** A `for(...){...} for(...){...}` sequence where the first loop's fall-out lands
on a label the next loop's entry also targets → the compiler keeps the forwarding `goto`.
**Fix (`vm_reduce.py`).** The theory was wrong: a routing exit emits as an EMPTY block, so the gate's
`first_real_block` scans PAST it to the real target `t`, AND `contract()` drops the stub on BOTH
sides (raw + struct) so they match. So the guard was simply DELETED (the `bounded and routing(e)`
clause; the now-dead `bounded` param removed too). Only the genuine `nxt[max(region)] != e` (exit not
address-adjacent) bail remains. reduce()'s self-validation is the backstop for any real mis-route.
**Generalized? YES — 7 subs, not 1.** Cleared `$89A3` (16→0) plus 6 others across banks 0/15
(`$83E2`, `$813C`, `$90E8`, `$911E`, `$A066`, `$840B`); corpus −37 (1025→988); 0 gate-rejects, hard
gate 495/495, 114/114 tests, deterministic, default `*.c` byte-identical. **Lesson:** the bail was a
defensive guess ("the gate can't handle this") that was never tested against the gate — the gate
*could* handle it. Worth auditing the other `bounded`/adjacency bails the same way.
**Still open (NON-adjacent routing).** When the routing stub is NOT the address-next block
(`nxt[max(region)] != e`), the loop still bails — that's the rest of the `none` bucket ("redirect
predecessors", the address-ordered-emitter work). A candidate atom #4 — but the audit below shows
the obvious "routing-skip the adjacency check" refinement does NOT work (it re-breaks atom 3).

---

## Atom 4 candidate — switch convergence / shared-merge folding  🔬 (deep-dive 2026-06-05)
**The lever.** 36 subs have a `switch`; together they carry **365 gotos — >⅓ of the whole 988-goto
corpus.** Switches are the single biggest remaining target. The user's read (switches are first-class
in this VM but mis-folded) is correct.

**VM switch format (confirmed from `vm-disasm.py`):**
- **`$D5` contiguous:** bytecode `[offs(2), limit(2), default(2), target_0 … target_{limit-1}]` — the
  **`default` target is stored BEFORE the case targets** (the user's "switch{ default; case0; … }").
  Keys are `offs..offs+limit-1` (signed; the disasm renders `offs=0xFFFF` as `65535,65536,…` instead
  of `-1,0,1,…` — a cosmetic key-wrap bug, structure is fine).
- **`$D9` noncontiguous:** `[count(1)+1, (key,target)×count, default(2)]` — default LAST.
- Cases **fall through** (C-style) and converge on a merge.

**Two failure modes, BOTH rooted in the merge being a SHARED block:**
- **(A) detection — 11 subs not foldable.** `switch_dispatches` requires every case target to be
  single-entry-dominated by the switch block S, and the enclosed span to be S-dominated. But the
  switch's exit `M = post-dom(S)` is routinely a SHARED block — a shared `return` (`$9C84`: all 3
  cases converge on `9CA6 return marry()`, which the early `if(!rng) return marry()` guard ALSO
  jumps to) or a pre-switch block (`$9ED9`: `default => M=9F10`, also reached from `9F0D`). So M
  isn't S-dominated and the check rejects. Same shared-continuation theme as the cross-edge atoms.
  **Excluding M from the checks recovers only 2/11** — the rest have shared CASE targets, interleaved
  merges (`$9C84`'s M sits BETWEEN case addresses), or empty regions. Multi-shape, not one fix.
- **(B) in-context — 8 of the 25 DETECTED switches still render dispatch+goto** (incl. the corpus's
  single biggest sub `$A2D2` = **42 gotos**, plus `$D14E` 23, `$D3ED` 21, `$B6B4` 20, `$AC11` 17,
  `$9954` 15, `$94B1`/`$A30D` 10). `_structure_switch` CAN inline them (the test suite proves it),
  but the whole-sub self-validation fails (other improper regions in the sub), so tier-2 region-
  fallback FLAT-SPANS the switch region instead of switch-folding it. The fold capability exists;
  the region fallback just doesn't reach for it.

**Assessment.** Switches are a focused mini-epic, not a one-line atom: model `M=post-dom(S)` as the
(possibly shared) switch EXIT — excluded from the case-target + enclosed checks — and teach the
region fallback to switch-fold a region, not just flat-span it. Highest-leverage tractable start is
likely (B) (the 8 detected subs ≈ 158 gotos: the fold already works in isolation). DEFERRED pending a
plan decision — logged so the diagnosis isn't re-derived.

## Guard audit (2026-06-05) — globalizing the atom-3 lesson
> Atom 3's bailed guard was an untested "the gate can't anchor this" GUESS. Are the OTHER bails the
> same? Because `reduce()` self-validates against the CFG gate, suppressing a guard is safe (a wrong
> guess → gate-reject / worse fold; a correct removal → win). Audited every guard whose fall-through
> builds a CFG-validatable node, via `tools/probe-bail-audit.py` (one-line per guard,
> `vm_reduce._AUDIT_SKIP`). Semantic guards (`compound_pretest` — update-timing the CFG gate can't
> police) and crash/loop-risk guards (`cross_edge_top`, `goto_not_succ`, `no_fall`) are NOT audited.

| guard suppressed | Δgotos | subs worse | verdict |
|---|---|---|---|
| `goto_past_merge` | +0 | 0 | no-op (the case is caught by another bail) |
| `empty_then` | −1 | 0 | trivial — leave it |
| `else_before_then` | +0 | 0 | no-op |
| **`arm_order`** | **+30** | 2 | **GENUINE — the gate really rejects** (`char_classify $CDCA` 2→29) |
| **`merge_not_adjacent`** | **−21** | **5** | **over-broad but RIGHT sometimes** — see below |
| `exit_is_dowhile_latch` | +0 | 0 | no-op (already tightened in session 8) |

**Headline lesson: atom 3 was the EXCEPTION, not the rule.** 5 of 6 audited guards are well-calibrated
(genuine soundness or no-ops). Do NOT assume a guard is a bad guess — the gate audit is the arbiter,
and most of these guards are doing real work. `arm_order` in particular is load-bearing (suppressing
it sends `char_classify` 2→29 gotos — the gate genuinely can't handle reversed arm order).

**`merge_not_adjacent` — the one real lever, but no cheap refinement.** Suppressing it is net −21 yet
breaks 5 subs (`$8C75` 3→14, `$AAA7` 1→7…), so it's right for those 5 and over-conservative for the
rest. Two refinements TRIED and REVERTED:
- **routing-skip the if-merge adjacency** (atom-3's idea on if-merges): DISASTER — +49 (1037), 32
  subs worse, even `vm_bootstrap` 1→2. A routing block between an if-body and its merge is NOT
  droppable the way a loop-exit stub is; skipping it makes the guard accept CFG-wrong if-nodes.
- **routing-skip the non-adjacent LOOP-exit** (the atom-#4 candidate): also regressed (−0 net, 10
  worse) AND re-broke atom 3 — when `e` IS the stub (atom-3's adjacent case) `_routing_skip` skips
  PAST it, so the check wrongly bails. `$89A3` went 0→16.

**So routing absorption (atom 3) is LOOP-EXIT-specific and does NOT generalize** to if-merges or
non-adjacent exits. The latent −21 in `merge_not_adjacent` is real but needs a per-region TRIAL
(build the if-node, keep it only if it self-validates AND beats the local honest-goto), not a
condition tweak — deferred. **Net code change from the audit: none to the folds** (the harness
`_audit_bail`/`_AUDIT_SKIP` stays as 0-cost instrumentation for future audits); the deliverable is
the lessons above + `tools/probe-bail-audit.py` to re-run them.
