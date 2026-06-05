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
predecessors", the address-ordered-emitter work). A candidate atom #4.
