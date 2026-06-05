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

**Links:** [decompiler-bottom-up-thesis](./decompiler-bottom-up-thesis.md) · [ROADMAP](./ROADMAP.md) (CFG epic) · **forward atom table → [lowering-atlas/atom-table.md](../lowering-atlas/atom-table.md)** (compile-and-catalog PoC: which inversions exist, sourced forward) · tools: `vm_reduce.py` · `v2-corpus.py` · `probe-cfg-reducibility.py`

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
| 4 | switch convergence/shared-merge folding | the VM's `switch` (`$D5`/`$D9`) with fall-through cases + a SHARED merge/exit | `$A30D`, `$9C84`, … (36 switch subs) | TBD — **multi-shape, hard** | ~365 in all switch subs, but **only ~59 / 8 subs are BEHIND V1** (probe below) | 🔬 deep-dive done, not implemented |
| 5 | multi-statement terminal-block duplication | N branches to a shared block that ENDS in `return`/`break` → duplicate it into each arm (`$AD38`). 1-statement case already inlines; ≥2-statement needs gate change | `$AD38`, `$8FF8`, `$918D` … | ~54 / 14 subs (probe below) | blocked by address-based gate | 🔬 not implemented |
| 6 | **forward-sink as merge (Track A, family-1)** | a branch to a SHARED TERMINAL sink (`→EXIT`, incl. multi-statement) emitted ONCE as the address-tail fall-through — invert the base lowering where guards converge on a trailing `return` | `$9F04` | **4** (`$9F04` 1→0, `$A003` 4→2, `$A068` 4→2, `$A113` 5→2) | **−8** (988→980) | ✅ landed |

Corpus: atom-3 start **V2 1025** → 988; **atom-6 988 → 980** vs V1 1151; behind-V1 59 → 57 → **53**. Atom 6 is the FORWARD slice of the sink family (address-ordered, reducer-only); the address-INVERTED sink slice (family-2, 9 back-jmp gotos) + the 77% non-sink majority remain.

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

**B exploration (2026-06-05) — B IS A.** Traced why the 8 detected switches flat-span in context.
`$A30D`: `merge=A381` is the `default` target AND a post-dom spine articulation point AND
**interleaved** (sits between case 0 `A37E` and case 1 `A385` by address). `_structure_switch`
consumes the territory `{A352..A391}` and returns `after=A399` — PAST the merge — but tier-2's
post-dom spine cuts the region boundary exactly AT `A381`, so the switch territory STRADDLES the cut
→ the region walk runs past its `stop` → `cross_edge_top` (3 of 4 traced subs bail this way; `$A2D2`
inlines but with 31 internal gotos that gate-fail). So the in-context failure is the SAME
shared/interleaved-merge problem: the merge is simultaneously the switch exit and a spine point, and
tier-2's decomposition fights the switch's territory. **You cannot fix B without modeling the shared
merge (A).** Confirms A is the principled root; B was a symptom. → defer to the principled A plan.

## Residue-cause experiment (2026-06-05) — the EXPERIMENT decides atom-4 vs atom-5, and corrects both
> Chris's call: trust the [lowering-atlas](../lowering-atlas/atom-table.md) experiment over the atom-4
> theory. `tools/probe-residue-cause.py` classifies all **220 recoverable gotos** (the 57 behind-V1
> subs) by which atom OWNS each, from CFG shape (independent of the flat-bail, so a self_gate sub's
> cause is read from structure not its raw goto dump). Result:

| relevant atom (by shape) | subs | gotos | |
|---|---|---|---|
| terminal_only (atom-5) | 13 | 31 | shared block ends in return/break |
| switch_only (atom-4) | 7 | 36 | has a switch dispatch |
| both (`$A2D2`) | 1 | 23 | the one sub with a switch AND a shared terminal |
| **neither** | **36** | **130** | **cross-edge / non-terminal shared merge / address-layout** |

Marginal reach: **atom-5 (terminal-dup) ≈ 14 subs / 54 gotos; atom-4 (switch) ≈ 8 subs / 59 gotos —
essentially TIED**, overlapping only on `$A2D2`.

**Two corrections the experiment forces:**
1. **Atom-4 was over-hyped.** "365 gotos / 36 subs" counted ALL switch subs; but **only 8 of the 57
   behind-V1 subs have a switch** — the other ~28 already fold ≥ V1 (rung 5 got them). Atom-4's
   *marginal* prize is ~59 gotos / 8 subs, not 365. Theory ≫ measurement; the experiment was right.
2. **NEITHER atom is the main lever.** The majority — **130 gotos / 36 subs (59%)** — is the cross-edge
   / non-terminal-shared-continuation / address-layout family (incl. the big self_gate subs `$A221`
   +11, `$9A5D` +10, which are cross-edge tangles, NOT clean guards). This is the 7f "address-ordered
   emitter" residue + the guard-audit `merge_not_adjacent` per-region-trial lever.

**The decision (1=evolve-gate-for-terminal-dup vs 2=switch):** the two atoms tie on raw leverage, but
the **gate change atom-5 needs — let the address-based gate accept a block emitted at a NON-address
position (a duplicated terminal) — is the SAME capability the dominant 130-goto "neither" bucket
needs.** Atom-4 (switch) is an isolated 8-sub fold with no spillover; evolving the gate unlocks atom-5
AND chips at the real majority. → **Recommend option 1 (evolve the gate).** Tool: `probe-residue-cause.py`.

## $AD38 dissection (2026-06-05) — atom-5 splits into TWO sub-families; the gain=+1 was a trap
> Started atom-5 on `$AD38` (smallest, +1). Dissection (`vm_cfg.py 2 AD38`, hand-built gate probe)
> shows it is NOT the clean minimal case — it's one of the HARDEST. Its CFG:
> `AD3D→{AD47,AD7B}; AD47→{AD58}; AD58→{EXIT}; AD67→{AD58}; AD7B→{AD67,AD85}; AD85→{EXIT}`.
> The shared terminal `AD58` (3 stmts, ends `return`) is reached by `AD47` AND `AD67`. The 0-goto form
> duplicates `AD58` into both arms — BUT `AD67` (a LOW address) is logically in the else-arm that
> starts at the HIGH address `AD7B`, so **there is no address-monotonic 0-goto layout.** Hand-feeding
> the ideal duplicated structuring to `structured_equivalent` REJECTS: the gate derives `else_start =
> next_leader[then_top=AD58] = AD67` (≠ the real `AD7B`) because the duplicated `AD58` is the then-arm's
> max address. So `$AD38` needs the gate's **lexical==address invariant lifted** — the big rearchitecture.

**Atom-5 is really two sub-families:**
1. **Address-ORDERED multi-stmt terminal merge** (`$8FF8` and likely most `terminal_only` +N). The
   shared terminal sits at its natural position AFTER its guard predecessors; V1 folds by nesting the
   guards with the terminal as the fall-through tail (no duplication). V2 leaves `if(C) goto L_term`
   ONLY because `_is_return_block` requires `len(stmts)==1` so the multi-stmt terminal isn't recognized
   as a guard/merge target. **Fix = reducer only, gate UNCHANGED** (generalize the terminal-merge
   recognition). The genuine clean first win.
2. **Address-INVERTED** (`$AD38`, and the 130-goto "neither" majority). A logical predecessor sits at a
   higher address than its successor → no address-monotonic form → needs the gate to become
   emit-order-aware (drop lexical==address). The rearchitecture; multi-session.

**Pivot:** the clean entry is family (1) — the address-ordered multi-statement terminal merge — NOT
`$AD38`. `$AD38`'s tiny +1 hid that it belongs to the hard family (2).

## Compiler reproduction (2026-06-05) — $AD38 is an UNDONE OPTIMIZATION, and the gate fix is NARROW
> Chris's question: can the two atoms be reproduced in [lowering-atlas](../lowering-atlas/atom-table.md)?
> Yes — and it reframes atom-5. `corpus/07_terminal_merge.c` + `tools/probe-opt-levels.py` compile the
> `$AD38` shape (two arms, common multi-stmt tail ending in `return`) at -O0 AND -O2:
> - **-O0 DUPLICATES the tail** (one copy per arm, address-ordered, 0 goto) — *this is the decompiler's target.*
> - **-O2 MERGES it** (one copy; the later arm `jmp`s BACKWARD into it) — *this is `$AD38` exactly.*
>
> **So `$AD38` is a TAIL-MERGE / CROSS-JUMP OPTIMIZATION, not a base lowering.** Three consequences:
> 1. **NA1's compiler did cross-jumping.** The ROM has the merged form → NA1's toolchain optimized to
>    at least the tail-merge level (non-optimizing for *structure* — reducibility holds — but it
>    cross-jumped). Refines the [thesis](./decompiler-bottom-up-thesis.md): "non-optimizing EXCEPT tail-merge."
> 2. **Atom-5 = invert the cross-jump = duplicate the shared terminal back to the -O0 layout.** The
>    inverse is well-defined and provably sound (duplicating a sink/terminal block is CFG-preserving);
>    the -O0 output is the witness for the correct decompile.
> 3. **The gate fix is NARROW, not the feared rearchitecture.** The gate's lexical==address invariant
>    is exactly the -O0 assumption; only cross-jumped (-O2) code violates it. Because a duplicated tail
>    is a TERMINAL (→EXIT sink), its multiple lexical positions add NO ordering ambiguity for other
>    blocks — so the gate only needs "a →EXIT block may appear at >1 lexical position; the
>    then_top/else_start boundary computation must not derive the next boundary FROM a terminal-ending
>    arm (it doesn't fall through)." That is a small, principled change, NOT "drop lexical==address."
>
> **Revised plan:** atom-5 splits — (1) address-ordered family-1 (`$8FF8`) is a base lowering, reducer-
> only (fold the loop-body guard→multi-stmt-terminal merge); (2) the cross-jump family (`$AD38` + much
> of the 130-goto "neither" bucket) = duplicate-the-terminal pre-contraction + the NARROW gate tweak
> above. The 130-goto majority may be mostly un-cross-jump too — worth re-running probe-residue-cause
> after the gate tweak to see how far "terminal-dup as cross-jump inverse" reaches.

## Gate-tweak crack (2026-06-05) — $AD38 needs FOUR emit-order fixes; 2 safe, 2 hard. REVERTED.
> Took a test-driven crack at the gate change (hand-built the ideal duplicated `$AD38` structuring,
> iterated `lower_struct_cfg` against `structured_equivalent`, gated by the 114-test suite). The
> "narrow tweak" is **not** narrow — the cross-jump inverts the layout so the gate's if-handling needs
> emit-order (text-span) boundaries in FOUR places, derived address-based today:

| # | derivation | change | result |
|---|---|---|---|
| 1 | `then_true` (then-arm entry) | `first_real_block(then span)` vs `next_leader[hb]` | **SAFE** (114/114) — bounded by the if's braces; fixed `$AD3D` & inner-if true edge |
| 2 | `else_start` (else-arm entry) | `first_real_block(else span)` | **SAFE** (114/114) — bounded; fixed `$AD3D` false edge |
| 3 | `merge` (post-if continuation) | emit-order `first_real_block(close+1, …)` | **UNSAFE** — leaks across scope, **broke 4 tests** (`$885E` do-while, `$9778` break: an if nested in a loop pulled its merge past the loop). Needs nesting-DEPTH-bounded search. |
| 4 | per-block fall-through of the DUP terminal | — | **UNSOLVED** — the duplicated `AD58` lines keep `AD58`'s addresses, so the gate assigns them to block `AD58` (not the predecessor `AD67`); `AD67` then falls by address to `AD7B`. The dup must either be re-tagged to the predecessor's address range, or the fall-through made emit-order. |

Fixes 1+2 took `$AD38`'s hand-form from 3 wrong edges to **1** (only `$AD67→{AD7B}` remains, the #4 collision). Both are CFG-equivalent no-ops on the current corpus (988/57/0 unchanged) — i.e. **inert** until #3+#4 land and the reducer emits the dup. Per the build-ladder discipline (land gate-green + MEASURED), **reverted to keep the gate pristine**; the map above is the deliverable so next session re-applies 1+2 and tackles 3+4 without re-deriving.

**Takeaway:** confirmed `$AD38` (cross-jump family) is the address-INVERTED hard case — the gate is pervasively address-based and the fix is the emit-order rearchitecture, scope-bounded. The genuinely tractable win remains **family-1 (`$8FF8`, base lowering, reducer-only, no gate change)**. Next session: do family-1 first; treat the $AD38 emit-order-gate as its own bounded sub-project (the 4-row table is the spec).

## Family-1 attempt (2026-06-05) — built the atom + the acceptance infra; BOTH sound, BOTH inert. REVERTED.
> Tried family-1 on the cleanest exemplars (`$A003` +1 no-loop, `$A95E` +5 DAG). V2 emits `if(!C) goto
> L_term` where V1 nests `if(C){…}` with the shared multi-statement terminal tail (`$A003`'s `$A063` =
> d759;cc89;return 0) emitted ONCE. The reducer CROSS-EDGES on the shared terminal because `imm_post_dom`
> returns EXIT (an early `return` on the `$A042`=return-1 path hides the reconvergence).
>
> **Two changes built + validated (both REVERTED — sound but inert):**
> 1. **`_common_merge(fall, goto_block, n)`** — when post-dom is EXIT, find the terminal sink both arms
>    reconverge on; use it as the if's merge. (Fired correctly: `_common_merge=A063` for `$A003`.)
> 2. **Goto-count-aware whole-sub acceptance** — a SECOND whole-sub pass with `ctx.aggressive_merge`,
>    offered as a candidate at every `reduce()` return, kept ONLY if it validates AND has strictly fewer
>    gotos. Proven **regression-proof** (988/57 unchanged, 114/114) — solves the first naive try's
>    +25-goto regression (forcing the merge made arms need internal gotos; first-valid-wins kept the
>    worse fold). This is the right acceptance model and it's safe.
>
> **Why still inert: `$A003` is ADDRESS-LAYOUT-bound, not a clean family-1 case.** The aggressive
> structuring `if(number_input){return 1;}else{cc89;return 0;}` **ORPHANS `$A05C`** (redraw_no_rice;
> d759): `A05C` is a low-address block with real content sitting BETWEEN the if-body and the merge
> `A063`, reached by the guards `goto A059/A053`. V1 only folds it by placing `A05C` INSIDE the
> `if(number_input){}` braces and jumping INTO it (goto-into-block) — the address-inversion trick a
> region reducer can't do. So the whole-sub fold gate-REJECTS (drops `A05C`), and `_common_merge`/the
> acceptance infra can't help — the blocker is the layout, exactly like `$AD38`.
>
> **DECISIVE META-FINDING ($AD38 + $8FF8 + $A003 all hit the SAME wall):** the terminal family is
> dominated by cross-jump address-inversions (the compiler experiment predicted this — NA1 tail-merged).
> Every one needs the **emit-order gate** (let a block be emitted at a non-address position / inside an
> if-body it's address-before). That ONE infrastructure change is the universal unlock for the terminal
> family; the `_common_merge` + goto-aware-acceptance infra (above) is sound and ready to compose ON TOP
> of it (re-apply both from this log — they're regression-proof). **There is no cheap localized atom
> here; the 57-behind residue is gate-architecture-limited.** Next-session target is unambiguous: the
> scope-bounded emit-order gate (the 4-row spec above), THEN re-apply family-1's two changes.

**`$8FF8` caveat (the family-1 exemplar is also non-trivial).** Traced: `reduce()` raises NO
`_NotReducible` for `$8FF8` (LAST_BAIL=None, whole-sub structuring SUCCEEDS + gate-validates) — its 8
gotos come from the **loop body being `_flat_span`'d** (the session-7e loop-local fallback, not a bail).
The multi-stmt terminal `L_908A` (reached by 3 guards) lives INSIDE that flat-spanned loop body, so
clearing it means getting `_structure_loop`'s body walk to fold the guard→multi-stmt-terminal merge
rather than flat-spanning the body. Still reducer-only / gate-unchanged, but it's a loop-body
structuring change, not a one-line `_is_return_block` widening. **Next session:** instrument WHY the
loop body flat-spans (which `_structure`/`_structure_loop` guard declines it), then fold the
multi-stmt-terminal merge there; re-validate (114 tests, hard gate, 0-reject, byte-identical, census).

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

## Cross-jump forward-experiment (2026-06-05) — the optimization is PINNED + its reversibility MAPPED
> Chris's call: the cross-jump feels like the big culprit; the [lowering-atlas](../lowering-atlas/atom-table.md)
> tests confirmed NA1's compiler optimizes, so go deconstruct the optimization at different `-O` levels
> and decide if it's reversible. Done in the compiler sub-project (`corpus/08_crossjump_reversibility.c`
> + `tools/probe-crossjump.py`). Result is sharper than "build the emit-order gate."

**The forward pass is GCC's RTL CROSS-JUMPING (`-fcrossjumping`, on at -O2+).** Flag bisection at -O2:
`-fno-crossjumping` alone restores the -O0 duplicated form; `-fno-tree-tail-merge` does nothing. So the
"address-inverted shared tail" the gate can't place = the output of one named, well-understood pass that
merges identical block SUFFIXES (emitting the backward `jmp`).

**Reversibility boundary (7 graded shapes, measured -O0/-O1/-O2/-Os):**
- **GCC cross-jumps SINKS ONLY.** Every backward-jmp inversion (switch-cases→return, partial-suffix→return,
  the `07` `$AD38` family) merges a suffix ending in `return`/tail-call. The one **non-sink** merge with a
  real successor GCC handled by **DUPLICATION, never cross-jump** — so it stayed address-ordered.
- **⇒ the sink inverse (tail-duplication) is provably sound AND address-monotonic** (a →EXIT block
  constrains no successor ordering, so each duplicate lands at its predecessor's natural address). This is
  why the "narrow gate change" is the *right* scope. The earlier `$AD38` 4-row gate-crack wall (#4: the dup
  block keeps `AD58`'s address) is an *implementation* detail of that narrow change — **re-tag the duplicate
  to the predecessor's address range** — not a refutation.
- **The inversion is an -O2 LAYOUT choice:** at `-Os` the *same* merges come out **forward-only** (emittable).
  So a cross-jumped CFG has both an emittable and a non-emittable linearization; the decompiler just picks
  the forward one (= duplicate the sink). It's layout, not structural loss — fully recoverable.

**Reframes the plan (vs the family-1/$AD38 meta-finding above):**
1. The provably-reversible slice is the **SINK** inversions = `terminal_only` (13 subs/31) + `switch_only`
   (7/36) + `both` `$A2D2` (1/23) ≈ **21 subs / ~90 gotos**. The atom = duplicate the shared sink + the
   narrow (re-tag-the-dup) gate change. Compiler proves the inverse is sound and emittable.
2. **The 130-goto "neither" bucket is probably NOT cross-jump.** GCC never cross-jumps a non-sink, so a
   genuine non-terminal shared merge is most likely real irreducibility / address-ordered-emitter layout,
   not an undo-able optimization. **Don't build a blanket emit-order rearchitecture for it on a hunch.**
   **▶ NEXT: extend `probe-residue-cause.py` to tag each NA1 residue inversion SINK-vs-NON-SINK** (read the
   merge block's terminator from CFG). If the residue is sink-dominated (expected), the narrow sink-dup atom
   is the whole game; if not, the non-sink subs are a separate, harder problem to scope on their own.

## Sink/non-sink classification RESULT (2026-06-05) — the residue is NOT sink-dominated. Hypothesis REFUTED.
> Ran the test above: `tools/probe-inversion-sink.py` classifies every residue `goto L_T` by the TARGET
> block's forward cone (SINK = T reaches EXIT and its whole cone is privately T-dominated = freely
> duplicable; NON-SINK = the cone has a foreign predecessor / a loop = a non-terminal shared merge).
> Validated: it tags every known dissection correctly ($AD38→1 sink AD58, $A2D2→14 sink case-tails,
> $A003→1 sink A063, $8FF8→4 sink guard-targets) and its recoverable total (221) matches the
> residue-cause probe's 220. So the classes are trustworthy.

| target cone | V2 | V1 | **recoverable** | subs | back | fwd |
|---|---|---|---|---|---|---|
| **sink** (reversible by dup) | 99 | 56 | **44 (22%)** | 37 | 9 | 90 |
| **non-sink** (non-terminal shared merge) | 411 | 258 | **153 (77%)** | 56 | 70 | **341** |
| loop (latch/continue) | 61 | 37 | 24 | 30 | 57 | 4 |

**Two hard conclusions, both correcting the optimistic cross-jump read:**
1. **The cross-jump (sink) slice is a MINORITY lever — 44 recoverable gotos (22%), not the prize.** The
   provably-correct sink-dup atom is real and worth doing, but it does NOT clear the residue. "The cross-jump
   is the big culprit" was the wrong read; it's a small one.
2. **The residue is 77% NON-SINK, and overwhelmingly FORWARD (341 fwd vs 70 back).** Cross-jumping produces
   *backward* jmps into *sink* suffixes (lowering-atlas, confirmed); GCC *never* cross-jumps a non-sink (it
   duplicates — corpus shape `E`). So these 153 forward non-sink gotos are **NOT cross-jump artifacts to
   invert** — they are genuine non-terminal shared merges = the **reducer/emitter capability gap** (fold a
   forward goto into a shared if-merge under the address-based gate), i.e. the guard-audit's `merge_not_adjacent`
   per-region-TRIAL lever + the 7f/7g address-ordered-emitter "redirect predecessors" work. This is the real
   majority and it is NOT an optimization to undo.

**▶ Revised plan.** Two independent tracks, sized by the data: **(track A, small+sound)** the sink-dup atom
+ narrow re-tag gate change → ~44 recoverable gotos / the terminal+switch families; **(track B, the actual
majority)** the non-terminal-shared-merge fold = a per-region if-node TRIAL (build the if, keep iff it
self-validates AND beats the honest-goto), the latent −21 from `merge_not_adjacent` generalized. Track B is
where 77% of the residue lives, and it is a reducer/gate problem, not a cross-jump inversion. Tool:
`tools/probe-inversion-sink.py` (`--detail` for per-sub).

## Atom 6 LANDED (2026-06-05) — Track A forward-sink-as-merge. −8 gotos, 4 subs, 0 worse, all-green.
> The clean, sound, reducer-only slice of Track A. **Root cause** (traced on `$9F04`, the minimal +1
> case): when a branch's goto-arm targets a SHARED TERMINAL sink (a block flowing only to EXIT — e.g.
> a multi-statement trailing `return`) and the local post-dom is EXIT (the fall arm RETURNS on some
> path before the join), the reducer DIDN'T recognize the sink as the merge. So an inner `if` CONSUMED
> the sink as its else-arm → `max(consumed) == the sink` → `nxt[sink] != merge` tripped
> `merge_not_adjacent` → the whole branch fell back to an honest `goto L_sink`. V1 instead emits the
> sink ONCE as the address-tail fall-through (it is address-last on the forward slice), 0 gotos.

**Fix (`vm_reduce.py`, reducer-only, NO gate change).** In `_structure`'s if-then/else handler, when
`merge is EXIT and goto_block` is a sink (`full_cfg[goto_block] == {EXIT}`), use it as the merge
(the `ctx.sink_merge` atom). The sink then folds once after the if; on the forward slice it is
address-last so `merge_not_adjacent` is satisfied; on the address-INVERTED slice (an interleaved
predecessor, e.g. `$93BF`'s `$9453 > $944E`, family-2) the adjacency check still bails to goto — so the
atom self-limits to the reversible forward slice without touching family-2.

**Goto-count-aware acceptance (the key to 0-worse).** Forcing the sink-merge regressed `$A853` (0→3):
a *valid* fold with MORE gotos won under first-valid-wins (the gate proves equivalence, not goto-count
— the exact trap the family-1 dissection flagged). Fix: `reduce()` now runs the whole-sub structuring
**both** with `sink_merge` off and on and keeps whichever VALIDATES with **fewer gotos**; the region
fallback likewise tries both per region (its existing per-region goto guard already protected it). This
is the regression-proof acceptance model the earlier family-1 attempt designed — now landed.

**Result.** V2 988→**980** (−8); behind-V1 57→**53**; `$9F04` 1→0, `$A003` 4→2, `$A068` 4→2, `$A113`
5→2; **0 subs worse**; folded 350 unchanged; **0 gate-rejects; hard gate 495/495 + 495/495; 114/114
tests; dispatcher green; deterministic; default `*.c` byte-identical** (V2-only path). Notably cracked
`$A003` (4→2), which the family-1 dissection had filed as family-2-stuck — its FORWARD portion folds
now; only its address-inverted remainder stays. recoverable-sink 44→**39** (`probe-inversion-sink`).

**Still open (the rest of Track A + Track B).** The address-INVERTED sink slice (family-2: 9 back-jmp
gotos — `$AD38`, `$93BF`'s `$9453`, …) needs the narrow re-tag gate change (duplicate the sink, tag the
copy to the predecessor's address range). The 77% non-sink majority (Track B) is the per-region if-node
trial. Atom 6 took the slice that needed neither — the honest reducer-only win.

## Track B PROTOTYPE (2026-06-05) — −49 gotos / 11 subs potential; ONE regression isolates the next fix. REVERTED.
> Prototyped the per-region if-node trial = the guard audit's `merge_not_adjacent` lever, made safe.
> The audit found suppressing `merge_not_adjacent` is net −21 but regressed 5 subs WITHOUT goto-aware
> acceptance; the prototype pairs the suppression with atom 6's acceptance machinery so a worse fold
> can't win. Built, MEASURED, reverted (the map below is the deliverable — re-apply next session).

**The change (5 small edits, all reducer-only, gate UNCHANGED):**
1. `_Ctx`: add a `merge_nonadj` flag (slot + init `False`), alongside `sink_merge`.
2. The bail: `if merge is not EXIT and nxt[max(consumed)] != merge and not ctx.merge_nonadj:
   _audit_bail('merge_not_adjacent')` — i.e. under the flag, build the if-node even when the merge
   isn't address-adjacent. (Orphaned gap blocks → gate-reject → fall back; self-validation backstops.)
3. `_fresh_ctx(sink_merge=False, merge_nonadj=False)` + `_structure_region(..., merge_nonadj=False)`.
4. A combo list `_COMBOS = [(F,F),(T,F),(F,T),(T,T)]` (sink_merge × merge_nonadj).
5. The whole-sub trial AND the region-fallback per-region loop iterate `_COMBOS`, keeping the
   fewest-goto VALIDATING result (extends atom 6's two-pass to four).

**Measured: V2 980 → 933 (−49); behind-V1 53 → 51; folded 351; 0 gate-rejects; hard gate
495/495 + 495/495.** 11 subs better. The −49 is large vs the −2 behind because most of it is
EMIT-QUALITY on subs already ahead of V1 (a non-adjacent forward merge that was an honest goto becomes
a folded `if`), not just behind-sub recovery — i.e. Track B improves the whole corpus, not only the
work-list. (Confirms the 77%-non-sink-is-the-majority finding: this is the lever.)

**The ONE regression — `$8694` 9 → 11 — pins the next fix precisely (root cause CONFIRMED).** With
`merge_nonadj` on, `$8694`'s WHOLE-SUB structuring now VALIDATES (LAST_BAIL=None) at 11 gotos, so
`reduce()` returns it — **short-circuiting the region-fallback that yields 9** (at atom-6 no whole-sub
combo validated, so it fell to the leaner region-fallback). The acceptance is **LOCAL** (the whole-sub
trial returns as soon as any combo validates) instead of **GLOBAL** (whole-sub-best should compete with
region-fallback-best on goto-count). This is the only thing between the prototype and a clean −49/0-worse
landing.

**▶ NEXT SESSION (Track B, the plan):** (1) make `reduce()` acceptance GLOBAL — compute the best
validating whole-sub result AND the region-fallback result, return whichever has FEWER gotos (don't let
whole-sub short-circuit a leaner region-fallback). (2) Re-apply the 5-edit `merge_nonadj` prototype
above. (3) Re-measure — expect ≈ −49, behind ≤51, **0 worse** (the `$8694` regression dissolves once
acceptance is global). (4) Full discipline (hard gate 495/495, 114/114, dispatcher, deterministic,
default `*.c` byte-identical) then land as atom 7. Then revisit the ~70 BACKWARD non-sink gotos (the
address-inverted remainder) — those still need emit-order gate work, the harder tail of B.
