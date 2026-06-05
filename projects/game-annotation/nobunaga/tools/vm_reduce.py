"""
tools/vm_reduce.py — REGION REDUCER (CFG epic V2 / "No More Gotos").

The single bottom-up CFG reducer that REPLACES the template menagerie
(`vm_decompile.structure_loops` + `structure_lines` + `structure_switches`).

WHY (the reframe, 2026-06-04 — see ROADMAP "CONTROL-FLOW STRUCTURING" epic +
[[project_nobunaga_decompiler_purpose]]): the gotos are assembly leftovers from a
structured-C source the compiler flattened. The job is to RECOVER that structure.
Template-matching cannot converge — it has no *closure under composition*, so every
new combination of shapes (a short-circuit feeding an if/else feeding a tail) looks
like a brand-new shape and spawns a new template. A region reducer DOES converge:
each rule firing collapses its subgraph into ONE abstract node that the next rule
consumes identically to a basic block, so a fixed grammar of ~7 rules yields
infinite nestings. RE-as-parsing — codegen walked DOWN the grammar; we build UP.

THE GRAMMAR (~7 fixed rules, applied to a FIXPOINT, bottom-up):
    sequence · if-then · if-then-else · short-circuit(&&/||) · while · do-while · switch
Irreducible residue (a goto INTO a block / multi-entry region) -> break one edge
with an honest goto and continue. Few, because most regions are reducible.

THE VERIFIER IS ALREADY BUILT — zero new verification work. The reducer proposes a
structured line list; `vm_cfg.structured_equivalent(raw, structured, leaders)` proves
it induces the SAME control-flow graph as the raw goto witness (== the bytecode) or
REJECTS it. Same safety model as the templates; the hard, valuable half is done.
Irreducibility is detected STRUCTURALLY by the reducer (no rule fires -> it breaks an
edge itself); the gate is a pure backstop that catches rule *bugs*, NOT the control
mechanism (inverts the template era, where gate-reject drove the fallback).

REUSE THE ANALYSIS, RE-DERIVE THE EMIT. The detectors in vm_cfg are *pure* and nail
the base shapes: `bytecode_cfg` (with value-diamonds/boolean-regions pre-contracted),
`dominators`/`post_dominators`, `back_edges`/`natural_loop`, `switch_dispatches`,
`boolean_regions`/`recover_bool_formula`. The reducer's new code is a region-tree
builder over that CFG + a tree -> (addr, indent, text) pretty-printer whose line
format matches what `structured_equivalent` consumes (so the gate reads it unchanged).

BUILD LADDER (each rung lands gate-green + measured on tools/v2-corpus.py):
    0. [DONE] harness + passthrough — reduce() returns lines unchanged; corpus wired.
    1. [DONE] block model + trivial emit — partition lines into blocks; emit seq-of-blocks
       with gotos (reproduce the raw form FROM the tree) -> proves block<->line round-trip.
    2. [DONE] sequence + if-then + if-then-else (acyclic diamonds via dom/post-dom).
    4. [DONE] while / do-while / while(1) (natural loops via back_edges / natural_loop) +
       early-return INLINING (bare-return targets become `if(C) return X;`, not a shared
       merge). 171 subs fold / 0 gate-reject. break/continue/return are loop-terminal arms;
       in-body merges use a body-LOCAL post-dom; rotated for-loops lift only the test expr.
       Conservative bails (all detected STRUCTURALLY, never gate-reject): nested loops (4d),
       compound multi-exit-test loops (need rung 3), a loop whose exit is non-adjacent or a
       pure-routing block (tail-of-if-arm), an empty then-arm with a goto-side body.
    3. short-circuit (&&/||) — DROPPED as a rung: the gate compares per-conditional-block
       orientation and contract() never removes a 2-succ block, so a merged `if(a&&b) goto`
       loses a node and is REJECTED; V1 itself emits NESTED ifs, not `&&`. No short_circuit
       bail exists in --bails. (Those cases surface as compound_pretest / multi_exit_loop.)
    cross_edge fold (DONE 2026-06-04, part of the acyclic walk, not a numbered rung): a forward
       branch to a SHARED continuation where the fall arm also reaches it but post-dom is EXIT
       (an early return on one path). `_reaches(fall, goto, n)` detects it -> use the goto-target
       as the merge so the tail is structured ONCE (the early returns become terminal guards).
       Inlined return blocks count for merge-ADJACENCY (added to `used`) but are EXCLUDED from
       the arm-ORDER disjointness check (a shared tail return floats). $9850/$A553 -> 0 gotos,
       beating V1 (which left honest gotos). behind 130->127, gotos 1541->1498, 0 gate-rejects.
    5. [DONE 2026-06-04] switch — block-level port of structure_switches as a composable region
       node (_structure_switch): keep the `switch(E){` opener, drop the `case N: goto` dispatch
       + closer, inline each case-target block's RAW lines (gotos verbatim — no break-conversion
       / no intra-case folding yet) in address order with `case N:`/`default:` labels, close
       after the last enclosed block. Folds the switch AND its enclosing loop/if (the closure
       payoff — e.g. $8D5D switch-in-while, $9BB4 fall-through ladder, both 0 gotos). +12 subs
       (171->183), V2 gotos 1624->1541, behind 142->130, 0 gate-rejects. An UN-foldable switch
       (not single-entry) still bails the sub (reason 'switch_unfoldable', 9 subs). The bigger
       switch potential (e.g. $A2D2) is gated behind a co-occurring cross_edge bail (whole-sub
       fallback hides the fold) — see the bail histogram. Follow-ups: break-conversion to the
       merge, and intra-case structuring (recurse _structure inside a case body) to match V1
       on switch subs whose cases carry ifs.
    4d. nested loops — drop the `any header inside loop -> bail` guard once 3/5 reduce noise.
    6. irreducible fallback — break one retreating/cross edge, honest goto, continue.
    7. cutover — V2 folds >= templates across all 495, every gate green -> flip default
       on, regen decompiled/*.c, DELETE the template structure_* functions.

reduce(lines, instructions) -> structured (addr, indent, text) line list.
    `lines` = the raw goto-form leaves the expression layer already emits
    (vm_decompile State.lines). `instructions` = the decoded bytecode for this sub.

RUNG 0: passthrough. Returns `lines` unchanged (== the raw goto witness, which the
gate accepts trivially since lower(raw) == bytecode by construction). Every sub
therefore reports as honest-goto / zero-fold; the templates fold more. That gap is
exactly what rungs 1-6 close. The harness, the gate wiring, and the corpus oracle
are proven FIRST, before any rule can introduce a bug.
"""


import re

import vm_cfg


# === Rung 1: block model + trivial emit ========================================
# Partition the raw (addr, indent, text) leaves into basic blocks by CFG leader, then
# emit the blocks in leader (address) order. This reproduces the raw goto/label form
# FROM a block-structured tree — proving the block<->line round-trip is faithful
# BEFORE any folding rule can perturb it. The one known hazard is the decompiler's
# flushed-call reordering (a discarded side-effecting CALL is appended at its later
# FLUSH point but tagged with its earlier call-site addr; vm_decompile.State.flush_
# pending) — partitioning by block_of(addr) would move such a line earlier, changing
# WHERE the side effect lands. So a leaf preserves its lines in RAW-LIST ORDER and the
# emit is checked against raw (the corpus "honest-goto" metric == structured-equals-raw):
# any sub that diverges is a reordering to handle, not a silent behaviour change.


def _partition(lines, leaders):
    """Group the raw leaves into {leader: [(addr, indent, text), ...]} by block_of(addr),
    preserving each line's original list order within its block (so a flushed-call line
    keeps its relative position among its block-mates)."""
    block_of = vm_cfg._block_of_fn(leaders)
    buckets = {L: [] for L in leaders}
    for addr, ind, text in lines:
        buckets[block_of(addr)].append((addr, ind, text))
    return buckets


def _flat_emit(buckets, leaders):
    """Rung-1 fallback: blocks in leader order, goto/label form intact."""
    out = []
    for L in leaders:
        out.extend(buckets[L])
    return out


# === Rungs 2 + 4: sequence / if-then / if-then-else / while / do-while / while(1) =
# The single recursive structurer. `_structure` walks a single-entry region into a tree of
# Seq / IfThen / IfThenElse, using the post-dominator as each 2-way branch's merge point.
# Branch polarity mirrors the decompiler exactly: a header's raw line is `if (RAWC) goto L_T`
# (goto = TRUE arm, fall-through = the body), so the structured then-body is the FALL-THROUGH
# arm with condition `_neg(RAWC)` — the same Pattern-A/B inversion, and the print loop's
# simplify_expression cleans `!((a<b))` -> `(a>=b)`.
#
# RUNG 4 — loops compose into the SAME recursion. A natural loop (back edge u->h, h dom u)
# collapses to ONE AST node (`_structure_loop`), consumed by the surrounding walk exactly
# like a basic block — so acyclic if/then/else (rung 2) nests inside loop bodies AND wraps
# around loops for free. Form is read from the CFG (reuse the analysis):
#   * pre-test  while(C){body}      header h is the 2-way test: one succ in loop, one = exit
#   * post-test do{body}while(C)    a single latch's 2-way test gates the back edge
#   * endless   while(1){body}      no governing 2-way test; control leaves via break/return
# A pre-test header that ALSO carries statements before its test renders faithfully as
# while(1){ stmts; if(!C) break; body } (no statement reorder — the honest form). Inside a
# loop body an edge to the header is `continue`, an edge to the exit is `break`; the if/then
# builder treats those as terminal arms. In-body merges use a body-LOCAL post-dominator (the
# global pdom is wrong — a breaking arm skips the merge), computed over the loop nodes with
# the header/exit/outside edges dropped so non-breaking paths' reconvergence is what shows.
#
# CONSERVATIVE by design: any shape a rung doesn't cleanly own (a block reached twice = cross
# edge, a forward goto skipping the merge, a switch, a multi-exit loop, nested loops [4d],
# a body that would force a statement reorder) raises NotReducible and the whole sub falls
# back to the rung-1 flat emit. The CFG-equivalence gate (structured_equivalent, applied in
# vm_decompile.decompile) is the backstop: a tree that builds but mis-routes is rejected
# there and the sub reverts to honest goto — never corrupted output.

# A statement line to emit verbatim, vs control scaffolding the structure consumes.
_RE_IFGOTO = re.compile(r'if \((.+)\) goto L_([0-9A-Fa-f]{4});$')
_RE_GOTO = re.compile(r'goto L_([0-9A-Fa-f]{4});$')


class _NotReducible(Exception):
    """Raised by a structuring rung when it can't cleanly own a shape (the whole sub then
    falls back to the rung-1 flat emit). `reason` is a short category tag for the bail
    histogram (`v2-corpus.py --bails`) — diagnostic only, never alters behaviour."""
    def __init__(self, reason=None):
        super().__init__(reason)
        self.reason = reason


# Bail attribution: the reason the LAST reduce() call fell back to flat emit (None if it
# folded cleanly). Single-threaded, set synchronously inside reduce() — read it right after.
# Drives `v2-corpus.py --bails`, which ranks the residue so the next rung targets the biggest
# lever. Purely diagnostic; does NOT affect emitted lines.
LAST_BAIL = None


def _parse_block(block_lines):
    """(stmts, rawcond, branch_addr, goto_target, is_switch) for one block's raw lines.
    stmts = [(addr, text)] to emit verbatim (the block body incl. any `return …;`); the
    label and the goto/if-goto terminator are stripped (the structure re-supplies them)."""
    stmts, rawcond, branch_addr, goto_target, is_switch = [], None, None, None, False
    for addr, _ind, text in block_lines:
        t = text.strip()
        if vm_cfg._RE_LABEL.match(t):
            continue
        m = _RE_IFGOTO.match(t)
        if m:
            rawcond, goto_target, branch_addr = m.group(1), int(m.group(2), 16), addr
            continue
        if _RE_GOTO.match(t):
            branch_addr = addr
            continue
        if vm_cfg._RE_SWITCH_CASE.match(t):
            is_switch = True
            continue
        stmts.append((addr, t))
    return stmts, rawcond, branch_addr, goto_target, is_switch


_STOP = object()          # "no merge stop" sentinel: a loop body walk ends only on h / exit


class _Ctx:
    """Per-sub invariants shared across the whole structuring recursion.
      full_cfg : the sub's block CFG (real successors, never remapped)
      info     : {leader: _parse_block(...)} — stmts / rawcond / branch_addr / goto_target
      block_of : addr -> its block leader;  nxt : leader -> address-next leader (or EXIT)
      loops    : {header: frozenset(loop nodes)} ;  latches : {header: set(latch blocks)}
      buckets  : {leader: [(addr,indent,text)]} — the RAW partitioned lines (rung 5 reads
                 the verbatim case-body lines from here, gotos/labels intact)
      switches : {switch_block: dispatch dict} — foldable switches (vm_cfg.switch_dispatches)
      visited  : cross-edge guard (a block reached twice = irreducible)
      far_by_loop : {header: frozenset(blocks)} — multi-LEVEL break targets for that loop: an
                 exit that escapes the PARENT loop too (C's single-level break can't reach it),
                 so the edge is kept as an honest `goto L_t` inside the body instead of a
                 structured break, and excluded from the loop's exit set (_structure_loop)."""
    __slots__ = ("full_cfg", "info", "block_of", "nxt", "loops", "latches",
                 "buckets", "switches", "visited", "far_by_loop")

    def __init__(self, full_cfg, info, block_of, nxt, loops, latches, buckets, switches):
        self.full_cfg, self.info, self.block_of, self.nxt = full_cfg, info, block_of, nxt
        self.loops, self.latches = loops, latches
        self.buckets, self.switches, self.visited = buckets, switches, set()
        self.far_by_loop = {}


def _is_return_block(L, ctx):
    """A leaf that is just `return …;` (-> EXIT). Such a block is INLINED at each jump to it
    (the early-return idiom: `if (C) return X;`) instead of being a shared merge — which is
    both how the C reads and CFG-neutral (contract() bypasses bare-return blocks anyway), so
    several branches converging on one `return` don't force an irreducible shared tail."""
    stmts, rawcond, _b, _g, sw = ctx.info[L]
    return (rawcond is None and not sw and len(stmts) == 1
            and stmts[0][1].startswith('return')
            and ctx.full_cfg[L] == frozenset({vm_cfg.EXIT}))


def _has_effect(seq):
    """True if `seq` emits any observable line — a non-empty basic block or any construct
    (if / guard / term / loop). An effect-LESS sequence is pure routing (empty blocks a value
    -diamond left behind), which the address-based gate can't place as an if-arm."""
    for it in seq:
        if it[0] == 'block':
            if it[2]:
                return True
        else:
            return True
    return False


def _reaches(start, target, avoid, ctx):
    """True if `target` is reachable from `start` in the block CFG without passing back through
    `avoid` (the branch header). Pure — never touches ctx.visited. Used to tell a forward
    branch to a SHARED continuation (the fall arm reaches the goto-target too) from a true
    if-then-else (the goto-target is an else-region the fall arm never reaches)."""
    seen = {avoid}
    stack = [start]
    while stack:
        b = stack.pop()
        if b is vm_cfg.EXIT or b in seen:
            continue
        if b == target:
            return True
        seen.add(b)
        stack.extend(ctx.full_cfg[b])
    return False


def _reachable_avoiding(start, avoid_set, ctx):
    """The set of blocks reachable from `start` WITHOUT entering any block in `avoid_set` (the
    loop), `start` included. Used to find where several loop-exit targets CONVERGE."""
    seen, stack = set(), [start]
    while stack:
        b = stack.pop()
        if b is vm_cfg.EXIT or b in seen or b in avoid_set:
            continue
        seen.add(b)
        stack.extend(ctx.full_cfg[b])
    return seen


def _convergent_exit(targets, loop, ctx):
    """A loop with several immediate exit targets is still SINGLE-exit if they CONVERGE on one
    block `c` (outside the loop) that EVERY target reaches without re-entering the loop — then
    `c` is the true exit and the non-`c` targets are short 'exit shims' pulled into the loop
    body as in-body break paths. `c` may be one of the targets (e.g. $8C45's `8C6D`, reached
    directly and via the `local11=1` shim `8C61`) or a common successor of all of them (e.g.
    $ADF6's `AE77`, where BOTH exits flow to it but neither IS it). Return `c`, else None
    (exits genuinely diverge). SOUNDNESS: every shim (a target that isn't `c`) must be
    loop-PRIVATE (no predecessor outside the loop), else folding it into the body would
    relocate code reached from elsewhere. Prefer the closest convergence (lowest address)."""
    preds = {}
    for b, succs in ctx.full_cfg.items():
        for s in succs:
            preds.setdefault(s, set()).add(b)
    reach = {t: _reachable_avoiding(t, loop, ctx) for t in targets}
    common = set.intersection(*reach.values()) if reach else set()
    # candidate exits: a target all others reach, or any common successor; closest first.
    for c in sorted(common, key=lambda x: (x is vm_cfg.EXIT, x)):
        if c in loop:
            continue
        if all(preds.get(t, set()) <= loop for t in targets if t != c):
            return c
    return None


def _terminal(b, loop, ctx):
    """If a control edge to block `b` should render as a one-line terminator rather than a
    walk INTO b, return that statement (no trailing `;`): `continue`/`break` for the
    enclosing loop's header/exit, or the inlined `return …` of a bare-return target. Else
    None (b is ordinary region code to keep structuring)."""
    if loop is not None:
        h, e = loop
        if b == h:
            return 'continue'
        if e is not None and b == e:
            return 'break'
        # Multi-LEVEL break: an edge out of this loop to a target that ALSO escapes the parent
        # loop (C's break only leaves ONE loop) -> kept as an honest `goto L_t` (the `goto
        # DISPLAY`/`goto done` abort idiom). The e-check above runs first, so the loop's OWN
        # single-level exit still renders as a clean break; only the farther target gotos.
        if b is not vm_cfg.EXIT and b in ctx.far_by_loop.get(h, ()):
            return f'goto L_{b:04X}'
    if b is not vm_cfg.EXIT and _is_return_block(b, ctx):
        return ctx.info[b][0][0][1].rstrip(';')
    return None


def _structure(entry, stop, pdom, ctx, loop):
    """Structure the single-entry region from `entry` until control reaches `stop` (a merge
    block), EXIT, or — inside a loop — the header (continue/loop-back) or the exit (break).
    `pdom` is the CURRENT region's post-dominators (the sub's at top level, a body-local one
    inside a loop). `loop` = (header, exit) or None. Returns (seq, used): seq is a list of
    AST items, used the set of block leaders consumed.
      ('block', leader, [(addr,text)…])                       — a basic block's body
      ('if', branch_addr, [(addr,text)…], cond, then, else)   — else=[] for an if-then
      ('guard', branch_addr, cond, kind)                      — `if (cond) break;/continue;`
      ('term', kind)                                          — bare `break;`/`continue;`
      ('loop', form, header_addr, cond, body, latch_addr, latch_stmts)  — a folded loop
    Raises _NotReducible on any shape no rung cleanly owns."""
    seq, used = [], set()
    n = entry
    while n is not vm_cfg.EXIT and n != stop:
        # a loop header reached from outside -> reduce the whole loop to one node. `bounded`
        # tells _structure_loop it sits in a region whose end is NOT the sub's EXIT (an if-arm,
        # `stop != EXIT`, or a loop body) — there a pure-routing exit is unsafe (the gate's
        # first_real_block would scan PAST the region boundary). At top level contract() absorbs
        # a routing exit, so it's fine.
        if n in ctx.loops and (loop is None or n != loop[0]):
            bounded = stop is not vm_cfg.EXIT or loop is not None
            node, consumed, after = _structure_loop(n, ctx, loop, bounded)
            seq.append(node)
            used |= consumed
            n = after
            continue
        # a foldable switch dispatch head -> fold the whole switch territory to one node (rung 5)
        if n in ctx.switches and n not in ctx.visited:
            node, consumed, after = _structure_switch(n, ctx, loop)
            seq.append(node)
            used |= consumed
            ctx.visited |= consumed
            n = after
            continue
        if n in ctx.visited:
            raise _NotReducible('cross_edge_top')    # cross / shared edge (top-of-walk)
        ctx.visited.add(n)
        used.add(n)
        stmts, rawcond, baddr, gtgt, _sw = ctx.info[n]
        succ = ctx.full_cfg[n]
        # RUNG 6 — un-foldable switch local fallback. A switch dispatch the detector can't fold
        # to a single-entry region (not in ctx.switches) is kept as an honest flat span — but it
        # must span the WHOLE switch TERRITORY (dispatch + every case body), not just the
        # dispatch block: the case bodies are reached ONLY via the dispatch gotos, so a linear
        # walk would ORPHAN every case except the first fall-through chain. Territory = all
        # blocks reachable from the dispatch up to its post-dominator merge (where the cases
        # reconverge); flat-span it (raw gotos verbatim) and continue at the merge. The sub's
        # code AROUND the switch still folds — localizes the old whole-sub `switch_unfoldable`
        # bail. (Matching V1's intra-case structuring is a separate rung-5 follow-up.)
        if _sw and n not in ctx.switches:
            merge = vm_cfg._imm_post_dom(pdom, n)
            avoid = set() if merge is vm_cfg.EXIT else {merge}
            territory = {b for b in _reachable_avoiding(n, avoid, ctx) if b is not vm_cfg.EXIT}
            # Continue the walk AT the merge only when it cleanly follows the whole switch by
            # address AND structuring the post-switch region is safe. Two unsafe shapes -> span
            # the WHOLE forward cone instead (merge = EXIT, no continuation): (a) a case body
            # WRAPS past the merge (a higher address — continuing there reverses address order
            # and the gate mis-routes, e.g. $D14E's $D270 past merge $D269); (b) the merge has
            # an out-of-territory predecessor (it's a shared continuation reached from elsewhere,
            # e.g. $D14E's $D269 with 4 preds — feeding it to the linear walk hits the cross-edge
            # structurer which mis-folds). Whole-cone keeps the switch territory honest-goto and
            # still folds the code BEFORE the switch.
            preds_of_merge = {b for b in ctx.full_cfg if merge in ctx.full_cfg[b]}
            if merge is not vm_cfg.EXIT and (any(b >= merge for b in territory)
                                             or not preds_of_merge <= territory):
                merge = vm_cfg.EXIT
                territory = {b for b in _reachable_avoiding(n, set(), ctx) if b is not vm_cfg.EXIT}
            node, consumed, after = _flat_span(territory, ctx, merge)
            seq.append(node)
            used |= consumed
            n = after
            continue
        if len(succ) == 1:
            (s,) = tuple(succ)
            seq.append(('block', n, stmts))
            st = _terminal(s, loop, ctx)             # continue / break / inlined return
            if st is not None:
                seq.append(('term', st, n))          # addr = this block (gate keys by addr)
                break
            if s is not vm_cfg.EXIT and s != stop and s in ctx.visited:
                # RUNG 6 — cross-edge local cut. This strand falls into an already-EMITTED
                # block s (a shared continuation reached by 2+ paths — the classic multiple
                # `goto cleanup` / `goto done` idiom, or a shared `return` block like $AD38's
                # $AD58). Keep THIS edge as an honest `goto L_s` (block n's terminator, tagged
                # with n's addr so the gate attributes the n->s edge to block n) and stop the
                # strand — s and its cone were already structured on the path that first visited
                # it. Both FORWARD and BACKWARD cuts are allowed: reduce() self-validates, so a
                # cut that reverses lexical-vs-address order self-gates cleanly (reverts to flat
                # / region-fallback) while one that holds is kept. CFG-faithful by construction.
                seq.append(('goto', n, s))
                break
            n = s
        elif len(succ) == 2 and rawcond is not None and gtgt is not None:
            goto_block = ctx.block_of(gtgt)
            if goto_block not in succ:
                raise _NotReducible('goto_not_succ')
            fall = next((x for x in succ if x != goto_block), None)
            if fall is None:
                raise _NotReducible('no_fall')
            gt, ft = _terminal(goto_block, loop, ctx), _terminal(fall, loop, ctx)
            # --- single-sided guard: `if (cond) break;/continue;/return X;` ---------------
            if gt is not None and ft is None:
                seq.append(('block', n, stmts))
                seq.append(('guard', baddr, rawcond, gt))        # taken (rawcond) -> terminal
                if goto_block is not vm_cfg.EXIT and _is_return_block(goto_block, ctx):
                    used.add(goto_block)         # inlined return occupies its address span
                n = fall
                continue
            if ft is not None and gt is None:
                seq.append(('block', n, stmts))
                seq.append(('guard', baddr, vm_cfg._neg(rawcond), ft))   # !rawcond -> terminal
                if fall is not vm_cfg.EXIT and _is_return_block(fall, ctx):
                    used.add(fall)               # inlined return occupies its address span
                n = goto_block
                continue
            if gt is not None and ft is not None:
                # both arms leave the region. This is the body TAIL (we break the walk after),
                # so an arm that `continue`s is just the implicit fall-off back to the header —
                # collapse it into a SINGLE guard on the OTHER arm (`if(cond) <other>;`), avoiding
                # a separate term tagged with the fall block's addr (which would COLLIDE when that
                # block is also emitted elsewhere — e.g. a multi-level break target). Else emit
                # the generic guard + tail term (guard keeps the branch addr, term its block addr).
                seq.append(('block', n, stmts))
                if gt == 'continue':
                    seq.append(('guard', baddr, vm_cfg._neg(rawcond), ft))   # !rawcond -> ft
                elif ft == 'continue':
                    seq.append(('guard', baddr, rawcond, gt))                # rawcond -> gt
                else:
                    seq.append(('guard', baddr, rawcond, gt))
                    seq.append(('term', ft, fall))
                break
            # --- both arms are regions: if-then / if-then-else (rung 2) -------------------
            # RUNG 6 — local honest-goto fallback. The clean if/then/else recovery below
            # raises _NotReducible on any shape it can't own (a shared continuation reached by
            # both arms = cross_edge, a non-adjacent merge, a goto past the merge, an empty
            # then-arm, reversed arm order…). Instead of flattening the WHOLE sub, catch it
            # here and emit the branch as an honest `if (rawcond) goto L_t;` — exactly the raw
            # conditional, so its CFG edge {goto_block, fall} is reproduced verbatim (sound by
            # construction, never a gate-reject) — then continue the linear walk at `fall`. The
            # surrounding region keeps all the structure it can; only this one edge stays a
            # goto, matching what V1's templates leave (e.g. $999A's tax-cap shared join). The
            # arm walks mutate ctx.visited as they probe; snapshot + restore it so the blocks
            # they touched are re-walked (and properly emitted) on the linear continuation.
            saved_visited = set(ctx.visited)
            try:
                if fall is vm_cfg.EXIT:
                    raise _NotReducible('header_falls_off')  # header falls off the end — rare
                merge = vm_cfg._imm_post_dom(pdom, n)
                # Early-return shared continuation: no clean post-dom merge (EXIT) because the
                # fall arm RETURNS on some path, yet the branch's goto-target is itself reached
                # BY the fall arm -> that target is the real reconvergence. Use it as the merge
                # so the early returns fold to terminal guards inside the then-arm and the tail
                # is structured ONCE after the if (else it is walked in BOTH arms -> cross_edge).
                if merge is vm_cfg.EXIT and goto_block is not vm_cfg.EXIT \
                        and _reaches(fall, goto_block, n, ctx):
                    merge = goto_block
                # The goto target must stay within the region (<= merge by address); a goto PAST
                # the merge is a forward skip (break-like) -> irreducible here.
                if merge is not vm_cfg.EXIT and goto_block > merge:
                    raise _NotReducible('goto_past_merge')
                then_seq, then_used = ([], set()) if fall == merge else \
                    _structure(fall, merge, pdom, ctx, loop)
                else_seq, else_used = ([], set()) if goto_block == merge else \
                    _structure(goto_block, merge, pdom, ctx, loop)
                if not _has_effect(then_seq) and _has_effect(else_seq):
                    # The then-arm is empty but the else-arm has a real body: the body lives on
                    # the GOTO side (`if(C) goto body; goto merge`), often with a routing block
                    # laid out BETWEEN the header and that body. The gate finds the else boundary
                    # by address (next leader after the then span), which an empty then-arm makes
                    # ambiguous -> bail. (Both arms empty = a value-diamond shell — fold it.)
                    raise _NotReducible('empty_then')
                if else_seq:
                    if not (fall < goto_block):
                        raise _NotReducible('else_before_then')  # then(fall) must precede else(goto)
                    # The ENTIRE then-region must precede the ENTIRE else-region by address —
                    # else emitting then-then-else reverses address order and the address-based
                    # gate mis-routes. Lexical order == address order is the invariant the gate
                    # relies on. (then_used/else_used can be empty when an arm is a pure
                    # terminal.) Exclude inlined RETURN blocks: a shared tail return (the
                    # early-return idiom inlines the SAME return at multiple jump sites,
                    # contract() bypasses it) is not part of an arm's exclusive address span —
                    # it floats, so it must not gate disjointness.
                    then_excl = [b for b in then_used if not _is_return_block(b, ctx)]
                    else_excl = [b for b in else_used if not _is_return_block(b, ctx)]
                    if then_excl and else_excl and max(then_excl) >= min(else_excl):
                        raise _NotReducible('arm_order')
                # LEXICAL-ADJACENCY of the merge: the gate lowers a construct's merge as the
                # address-next leader after its last block, so the merge MUST be that block.
                # Skipped when the merge is EXIT (the whole region ends after this if).
                consumed = {n} | then_used | else_used
                if merge is not vm_cfg.EXIT and ctx.nxt[max(consumed)] != merge:
                    raise _NotReducible('merge_not_adjacent')
                cond = vm_cfg._neg(rawcond)
                seq.append(('if', baddr if baddr is not None else n, stmts, cond, then_seq, else_seq))
                used |= consumed
                n = merge
            except _NotReducible as _ce:
                # Rung-6 fallback: keep this ONE branch as an honest `if (rawcond) goto L_t;` and
                # continue linearly at `fall`. SOUNDNESS GUARD: only valid when goto_block is
                # reachable FROM fall — then the linear continuation will actually walk + emit it
                # (a forward join). If it's reachable ONLY via this goto (a shared tail the fall
                # path returns/exits before hitting), the continuation would ORPHAN it (its
                # statements never emitted -> CFG divergence -> gate-reject). In that case
                # re-raise so the whole sub bails to flat (still sound). Restore ctx.visited
                # first (the failed arm probes marked blocks visited that must be re-walked).
                ctx.visited.clear()
                ctx.visited.update(saved_visited)
                if goto_block is vm_cfg.EXIT:
                    raise
                ctx.visited.add(n)
                used.add(n)
                seq.append(('block', n, stmts))
                seq.append(('ifgoto', baddr if baddr is not None else n, rawcond, gtgt))
                n = fall
                continue
        else:
            raise _NotReducible('multiway')          # switch / >2-way / cond-less 2-way
    return seq, used


def _strip_trailing_continue(seq):
    """A loop body's natural tail loop-back is implicit (the closing `}` re-enters the
    header), so a trailing top-level `continue;` is redundant — drop it for readability.
    CFG-neutral: continue -> header is the same edge the fall-off back-edge supplies."""
    if seq and seq[-1][0] == 'term' and seq[-1][1] == 'continue':
        return seq[:-1]
    return seq


def _structure_loop(h, ctx, outer_loop, bounded=False):
    """Reduce the natural loop headed at `h` to one ('loop', …) node. Returns
    (node, consumed_leaders, after) where `after` is the block to continue the surrounding
    walk from (the loop's single exit, or EXIT if it only leaves via return). `bounded` = the
    loop sits inside a region that ends before the sub's EXIT (an if-arm or a loop body), where
    a pure-routing exit can't be folded (the gate would scan past the region boundary)."""
    loop = ctx.loops[h]
    # RUNG 4d: nested loops compose for free — the body walk recurses into _structure_loop for
    # an inner header, collapsing it to one node the outer walk consumes like a block. A
    # multi-latch inner loop is NO LONGER bailed here (the old `nested_loop` guard): the
    # multi-latch handler below folds it to while(1)-with-continues and reduce() self-validates,
    # so nested multi-latch loops compose like any other (e.g. vm_bootstrap's per-turn/per-fief).
    # Exit target(s): a single clean exit, else not ours yet. An exit to a bare-RETURN block is
    # an EARLY RETURN, not a competing loop exit — the body walk's _terminal already inlines it
    # as `if (C) return X;` (CFG-neutral; contract() bypasses bare returns). So when a real
    # (non-return) exit exists, drop the return-block exits from the count: a loop with one
    # normal exit + N early returns collapses to the single-exit (pre/post-test) case and folds,
    # the returns falling out inside the body (e.g. $91A1: while-search with `return idx`). Only
    # when EVERY exit is a return block do we keep them (prior behaviour: one becomes the break
    # exit) — excluding them there would force e=None/while(1) and mis-anchor. (Tried widening
    # this to ALL return-EXITING blocks incl. multi-stmt `…; return` — net regression + a gate-
    # reject; multi-stmt returns aren't reliably clean early-return paths, so kept narrow.)
    all_exits = {s for nn in loop for s in ctx.full_cfg[nn]
                 if s is not vm_cfg.EXIT and s not in loop}
    # MULTI-LEVEL break: an exit that escapes the PARENT loop too is unreachable by a single
    # C `break` -> keep that edge as an honest `goto L_t` in the body (recorded in far_by_loop,
    # consumed by _terminal) and DROP it from this loop's exit set, so the remaining single-level
    # exit makes the loop foldable. Top-level loops (no parent) have nothing "far". This is what
    # lets a `goto DISPLAY` abort gate firing from N nested loops fold: each inner loop keeps the
    # goto; only the outermost loop that still CONTAINS the target breaks to it.
    if outer_loop is not None:
        parent_nodes = ctx.loops.get(outer_loop[0], frozenset())
        far = frozenset(s for s in all_exits if s not in parent_nodes)
    else:
        far = frozenset()
    ctx.far_by_loop[h] = far
    all_exits -= far
    nonreturn = {s for s in all_exits if not _is_return_block(s, ctx)}
    if nonreturn:
        exit_targets = nonreturn
    elif all_exits:
        # Every exit is a return block. The loop's NATURAL exit is the header's own non-body
        # successor (the pre-test fall-out, e.g. $91A1's `return 255` tail); any OTHER return
        # exit is a body early return the walk inlines. Use the header-exit as primary when it's
        # unique; otherwise (post-test latch exit, or ambiguous) keep all so the count bails.
        header_exit = all_exits & ctx.full_cfg[h]
        exit_targets = header_exit if len(header_exit) == 1 else all_exits
    else:
        exit_targets = all_exits
    shims = set()        # convergent-exit shim blocks pulled into the body (rung-6)
    if len(exit_targets) > 1:
        # CONVERGENT multi-exit: the targets may still funnel to one block (the others are
        # loop-private exit shims that flow to it) -> that block is the real single exit and
        # the shims become in-body break paths. Only genuinely-divergent exits bail.
        c = _convergent_exit(exit_targets, loop, ctx)
        if c is None:
            # Genuinely-divergent multi-exit loop: no single construct owns it. Keep the LOOP as
            # a flat honest-goto span (rung-6 region-local fallback) and structure everything
            # around it — the surrounding regions still fold. Continue at the address-next block.
            return _flat_span(loop, ctx, ctx.nxt[max(loop)])
        shims = exit_targets - {c}      # walked in the body; extend the loop's emitted region
        exit_targets = {c}
    e = next(iter(exit_targets)) if exit_targets else None
    # The shims are walked inside the body, so the loop's emitted address span runs up to the
    # highest shim, not just max(loop) — the adjacency / consumed accounting below uses this.
    region = loop | shims
    # GATE ANCHORING: if the exit block is itself a do-while LATCH (a 2-way post-test rendered as
    # the `} while (C);` scaffold line), the gate's first_real_block skips PAST it to the block
    # after the do-while and mis-reads THIS loop's exit. The reducer's output is correct C, but
    # the verifier can't anchor an exit on a scaffold line -> bail (sound). Hits an inner while
    # that is the last statement of a do-while body (e.g. $DB97: while(...) ending a do-while).
    # ONLY when the parent is a SINGLE-latch do-while (so e really renders as `} while(C);`): a
    # MULTI-latch parent renders as while(1), where e (a back-edge block) is a normal `if(cond)
    # continue; …` block the gate anchors on fine — bailing there blocks valid nested folds.
    if outer_loop is not None and e is not None and len(ctx.full_cfg[e]) == 2 \
            and len(ctx.latches.get(outer_loop[0], ())) == 1 \
            and e in ctx.latches.get(outer_loop[0], ()) and not ctx.info[e][0]:
        raise _NotReducible('exit_is_dowhile_latch')
    # LEXICAL ADJACENCY of the exit: the gate reads a loop's exit as the first REAL block AFTER
    # the closing brace by address. So the exit must (a) be the leader right after the loop's
    # last block, and (b) emit a line the gate can anchor on. A pure-routing exit (a 1-succ
    # `goto merge` block with no statement, as when the loop is the tail of an if-arm) emits
    # nothing, so the gate skips PAST it to the next arm -> mis-routes the exit. Bail on both.
    if e is not None and (ctx.nxt[max(region)] != e
                          or (bounded
                              and len(ctx.full_cfg[e]) == 1 and not ctx.info[e][0])):
        # The loop's exit isn't the address-next block (or is a pure-routing block the gate
        # can't anchor on). Keep the LOOP as a flat honest-goto span and structure around it
        # (rung-6 region-local fallback); continue at the address-next block so the walk picks
        # up the between-blocks and the real exit.
        return _flat_span(region, ctx, ctx.nxt[max(region)])
    lp = (h, e)
    # Body-local post-dominator: an edge that LEAVES the body (to the header = continue, to
    # the exit / outside = break, to EXIT = return) is TERMINAL — it must not pull the merge
    # toward itself, so it is DROPPED from the merge graph. A block whose every edge was
    # dropped (a latch, an unconditional break) becomes a sink -> {EXIT} so post_dominators
    # stays well-defined (an edge-LESS node would wrongly post-dominate to ALL nodes). The
    # merge of an in-body if is then where its NON-terminal paths reconverge, e.g. the latch.
    merge_src = {}
    for nn in loop:
        keep = frozenset(s for s in ctx.full_cfg[nn]
                         if s is not vm_cfg.EXIT and s in loop and s != h)
        merge_src[nn] = keep if keep else frozenset({vm_cfg.EXIT})
    body_pdom = vm_cfg.post_dominators(merge_src)

    hsucc = ctx.full_cfg[h]
    h_stmts, h_rawcond, h_baddr, h_gtgt, _h_sw = ctx.info[h]

    # A clean post-test latch: a SINGLE 2-way latch whose two edges are (back-to-header, exit).
    # Such a loop is a do-while — even when the header ALSO 2-way-tests the exit (so it would
    # ALSO match the pre-test shape). Prefer do-while there: the pre-test rendering would put the
    # latch's body block as a while-body tail that EXITS via fall (a `break`), and a body-tail
    # break is unrepresentable for the gate (its per-block lowering keeps one terminator/block,
    # so the `continue` edge is lost). V1 renders these as do-while too. (Computed before the
    # pre-test so it can gate it; a 1-way for-loop update latch is NOT 2-way -> doesn't divert.)
    latches2 = [u for u in ctx.latches[h]
                if len(ctx.full_cfg[u]) == 2 and h in ctx.full_cfg[u]
                and e is not None and e in ctx.full_cfg[u]]
    clean_dowhile = e is not None and len(ctx.latches[h]) == 1 and bool(latches2)

    # ---- pre-test while: the header itself is the 2-way exit test ----------------------
    # The in-loop successor must be a DISTINCT body block, not the header itself: a self-loop
    # (header == latch, the test at the bottom of its single block) is a do-while, not a
    # pre-test while — treating it as pre-test sets body_entry = h, which is already visited
    # and raises a spurious cross_edge. So require a non-self in-loop successor here and let a
    # self-loop fall through to the do-while detection below (which carries the body in latch_stmts).
    if (not clean_dowhile and e is not None and len(hsucc) == 2 and h_rawcond is not None
            and e in hsucc and any(s in loop and s != h for s in hsucc)):
        body_entry = next(s for s in hsucc if s in loop and s != h)
        cond = h_rawcond if ctx.block_of(h_gtgt) in loop else vm_cfg._neg(h_rawcond)
        ctx.visited.add(h)
        body, _u = _structure(body_entry, _STOP, body_pdom, ctx, lp)
        body = _strip_trailing_continue(body)
        # Only the test EXPRESSION lifts to `while (cond)`. Any statements the header block
        # carries before the test (the ROTATED for-loop's update, e.g. `i += 2`) keep their
        # address and sit at the body BOTTOM — where the listing already places them (body is
        # laid out before the bottom test), so this is a lift, not a side-effect reorder. This
        # is sound only for a SINGLE-exit loop (a clean for-loop): with a COMPOUND exit
        # (>1 edge to e, e.g. `while (i<6 && p<n)` split across two test blocks), deferring
        # the update past the second test changes first-iteration semantics -> bail.
        if h_stmts:
            exit_edge_blocks = {nn for nn in loop if e in ctx.full_cfg[nn]}
            if len(exit_edge_blocks) > 1:
                raise _NotReducible('compound_pretest')
            body = body + [('block', h, h_stmts)]
        node = ('loop', 'while', h, cond, body, None, [])
        ctx.visited |= set(loop)
        return node, set(loop) | shims, e

    # ---- post-test do-while: a single latch's 2-way test gates the back edge -----------
    if clean_dowhile:
        u = latches2[0]
        u_stmts, u_rawcond, _u_baddr, u_gtgt, _u_sw = ctx.info[u]
        cond = u_rawcond if ctx.block_of(u_gtgt) == h else vm_cfg._neg(u_rawcond)
        body, _u = _structure(h, u, body_pdom, ctx, lp)
        ctx.visited.add(u)
        ctx.visited |= set(loop)
        node = ('loop', 'dowhile', h, cond, body, u, u_stmts)
        return node, set(loop) | shims, e

    # ---- self-loop with no clean exit (header is its own only body, succ includes h) ----
    # An infinite self-loop can't be walked as a body (the body IS the header, which is
    # already visited -> a spurious cross_edge that flattened the whole sub). Fold to
    # while(1){stmts} when the block carries statements (the gate's tail-falls-off rule
    # rebuilds the self back-edge from the body tail); when it's a bare `goto self` with no
    # statement, while(1){} would DROP the back-edge (empty body = no tail) so keep it as an
    # honest self-goto. Either way the REST of the sub stays structured — the rung-6
    # local-honest-goto idea applied to the one shape that needs it most. (A self-loop WITH
    # an exit edge is a do-while, already handled above via latch_stmts.)
    if loop == frozenset({h}):
        ctx.visited.add(h)
        if h_stmts:
            node = ('loop', 'while1', h, None, [('block', h, h_stmts)], None, [])
        else:
            node = ('selfgoto', h)
        return node, {h}, (e if e is not None else vm_cfg.EXIT)

    # ---- multi-latch loop -> while(1) with `continue` guards (else flat honest-goto span) ----
    # A loop with >1 latch is a while(1) whose extra back-edges are `continue` statements (the
    # inverse of the compiler lowering each `continue` to a jump-to-header). ATTEMPT that fold:
    # walk the body (edges to the header render as `continue`, to the exit as `break`). The one
    # UNSOUND shape is a body-TAIL `if(C) continue;` whose fall-through IS the loop-back — the
    # gate then reads the fall as the back-edge and loses the exit; the both-terminal walk now
    # collapses such a tail to a single `if(!C) break;` guard, and reduce()'s self-validation is
    # the backstop. If the body walk can't own a shape, fall back to the flat honest-goto span
    # (the surrounding loops/ifs still fold), restoring `visited` so the bailed blocks re-walk.
    if len(ctx.latches[h]) > 1:
        saved = set(ctx.visited)
        try:
            body, _u = _structure(h, _STOP, body_pdom, ctx, lp)
            body = _strip_trailing_continue(body)
            ctx.visited |= set(loop)
            return ('loop', 'while1', h, None, body, None, []), set(loop) | shims, (e if e is not None else vm_cfg.EXIT)
        except _NotReducible:
            ctx.visited.clear()
            ctx.visited.update(saved)
            return _flat_span(loop, ctx, e if e is not None else vm_cfg.EXIT)

    # ---- endless: while(1) { body }  (exits via break / return inside) -----------------
    # The header h IS the first body block of a while(1) (no governing pre-test), so the body
    # walk must START at h and EMIT it. Do NOT pre-mark h visited: _structure(h) checks
    # `n in visited` on its first step and would raise a spurious cross_edge (the multi-latch
    # bug — e.g. $88AC's {8908,8911}). Edges back to h are already resolved as `continue` by
    # _terminal (keyed on b == h, not on visited), so no pre-add is needed for correctness;
    # the whole loop is marked visited AFTER the walk.
    body, _u = _structure(h, _STOP, body_pdom, ctx, lp)
    body = _strip_trailing_continue(body)
    ctx.visited |= set(loop)
    return ('loop', 'while1', h, None, body, None, []), set(loop) | shims, (e if e is not None else vm_cfg.EXIT)


def _structure_switch(S, ctx, loop):
    """Rung 5: fold the foldable switch dispatched at block `S` to ONE composable node so the
    walk consumes it like a block (and any enclosing loop/if folds around it). Block-level
    port of vm_decompile.structure_switches: keep the `switch (E) {` opener, DROP the
    `case N: goto L_T;` dispatch lines + the closer, then inline each case-target block's raw
    lines (verbatim — internal gotos/returns stay honest, exactly as V1) in ADDRESS order with
    `case N:` / `default:` labels injected, +1 indent, closing `}` after the last enclosed
    block. Returns ('switchspan', rel_lines), consumed_leaders, after. `rel_lines` is a list of
    (addr, rel_indent, text); _emit adds the base indent so it nests under loops/ifs.
    Faithful (no break-conversion, no intra-case structuring yet — those are follow-ups); its
    CFG matches the raw witness the same way V1's inline does, so the gate accepts it."""
    d = ctx.switches[S]
    body_end = d['body_end']
    after = ctx.block_of(body_end) if body_end is not None else vm_cfg.EXIT
    # target block -> the case-label lines to emit before it, in key-declaration order.
    by_target = {}
    for key, tgt in d['key_targets']:
        by_target.setdefault(tgt, []).append('default:' if key is None else f'case {key}:')

    rel = []                                   # (addr, rel_indent, text)
    # --- S's block: leading selector stmts + the `switch (E) {` opener; skip dispatch+closer.
    opener_seen = False
    for addr, _i, text in ctx.buckets[S]:
        t = text.strip()
        if vm_cfg._RE_LABEL.match(t):
            continue
        if opener_seen:
            continue                           # dispatch `case: goto` lines + the `}` closer
        rel.append((addr, 0, t))
        if vm_cfg._RE_SWITCH_OPEN.match(t):
            opener_seen = True
    # --- enclosed case bodies: every leader strictly between S and body_end, address order.
    enclosed = [L for L in d['enclosed'] if L != S
                and (body_end is None or L < body_end)]
    consumed = {S} | set(enclosed)
    labeled = set()
    for L in sorted(enclosed):
        if L in by_target:
            for lab in by_target[L]:
                rel.append((L, 1, lab))           # case label aligns one in from `switch`
            labeled.add(L)
        for addr, _i, text in ctx.buckets[L]:
            t = text.strip()
            rel.append((addr, 2, t))              # case body one deeper than its label
    # --- empty trailing cases: a key pointing at the merge (== body_end) has no enclosed
    #     block; emit it as an empty case that falls off the `}` (== break / fall-to-merge).
    for tgt in sorted(t for t in by_target if t not in labeled):
        if tgt == after and after is not vm_cfg.EXIT:
            for lab in by_target[tgt]:
                rel.append((tgt, 1, lab))
            labeled.add(tgt)
    rel.append((0, 0, "}"))
    # --- prune case-target leader labels whose only refs were the dropped dispatch lines.
    referenced = set()
    for _a, _ri, txt in rel:
        for m in re.finditer(r'goto L_([0-9A-Fa-f]{4})', txt):
            referenced.add(int(m.group(1), 16))
    pruned = []
    for a, ri, txt in rel:
        lm = re.match(r'L_([0-9A-Fa-f]{4}):$', txt.strip())
        if lm and a in labeled and int(lm.group(1), 16) not in referenced:
            continue
        pruned.append((a, ri, txt))
    return ('switchspan', pruned), consumed, after


def _flat_span(blocks, ctx, after):
    """RUNG 6 — region-local honest-goto fallback (the audit's `_flat_span`). A region the
    grammar can't fold to a SOUND construct (here: a multi-latch loop whose `while(1)`
    exit-via-fall is ambiguous to the gate — e.g. $88AC's {8908,8911}) is kept as its RAW
    lines (gotos/labels verbatim, address order) and the surrounding walk structures
    everything AROUND it — exactly as V1 leaves such loops as honest gotos. CFG-faithful by
    construction (the raw lines ARE the witness), so it never gate-rejects; only this one
    region stays flat. Returns ('flatspan', rel_lines), consumed, after — rel_lines =
    (addr, 0, text) the emitter places at the base indent (labels kept for the goto targets)."""
    # Strip the raw `L_xxxx:` labels (like the structured emit does); _insert_labels re-adds
    # exactly the ones an emitted goto targets, so a label isn't duplicated when the span's
    # entry/targets are also goto destinations (e.g. $88AC's L_8908).
    rel = [(addr, 0, text.strip()) for L in sorted(blocks) for addr, _i, text in ctx.buckets[L]
           if not vm_cfg._RE_LABEL.match(text.strip())]
    ctx.visited |= set(blocks)
    return ('flatspan', rel), set(blocks), after


def _emit(seq, indent, out):
    for item in seq:
        kind = item[0]
        if kind == 'block':
            _, _L, stmts = item
            for addr, text in stmts:
                out.append((addr, indent, text))
        elif kind == 'term':
            out.append((item[2], indent, f"{item[1]};"))
        elif kind == 'guard':
            _, baddr, cond, gkind = item
            out.append((baddr, indent, f"if ({cond}) {gkind};"))
        elif kind == 'selfgoto':
            # An irreducible bare self-loop (`L_h: goto L_h;`) — kept as an honest goto so
            # the rest of the sub still structures. The label is supplied by _insert_labels.
            h = item[1]
            out.append((h, indent, f"goto L_{h:04X};"))
        elif kind == 'ifgoto':
            # Rung-6 honest conditional goto: a 2-way branch the structurer couldn't cleanly
            # own, kept verbatim as `if (rawcond) goto L_t;` (target label via _insert_labels).
            _, baddr, rawcond, tgt = item
            out.append((baddr, indent, f"if ({rawcond}) goto L_{tgt:04X};"))
        elif kind == 'goto':
            # Rung-6 unconditional cross-edge cut: block `src` falls into an already-emitted
            # shared continuation `tgt`; kept as an honest `goto L_tgt;` (tagged with src's
            # addr so the gate attributes the edge to that block; label via _insert_labels).
            _, src, tgt = item
            out.append((src, indent, f"goto L_{tgt:04X};"))
        elif kind in ('switchspan', 'flatspan'):
            for addr, rel_indent, text in item[1]:
                out.append((addr, indent + rel_indent, text))
        elif kind == 'if':
            _, baddr, stmts, cond, then_seq, else_seq = item
            for addr, text in stmts:
                out.append((addr, indent, text))
            out.append((baddr, indent, f"if ({cond}) {{"))
            _emit(then_seq, indent + 1, out)
            if else_seq:
                out.append((0, indent, "} else {"))
                _emit(else_seq, indent + 1, out)
            out.append((0, indent, "}"))
        else:  # 'loop'
            _, form, haddr, cond, body, latch_addr, latch_stmts = item
            if form == 'while':
                out.append((haddr, indent, f"while ({cond}) {{"))
            elif form == 'while1':
                out.append((haddr, indent, "while (1) {"))
            else:  # dowhile
                out.append((haddr, indent, "do {"))
            _emit(body, indent + 1, out)
            if form == 'dowhile':
                for addr, text in latch_stmts:
                    out.append((addr, indent + 1, text))
                out.append((latch_addr, indent, f"}} while ({cond});"))
            else:
                out.append((0, indent, "}"))


def reduce(lines, instructions):
    """Region reducer (CFG epic V2). Rungs 0-1 = block partition + flat emit; rungs 2+4 add
    sequence / if-then / if-then-else / while / do-while / while(1) over the whole sub.
    Falls back to the rung-1 flat emit whenever the structure can't be cleanly recovered;
    the CFG-equivalence gate in vm_decompile.decompile is the final backstop."""
    global LAST_BAIL
    LAST_BAIL = None
    cfg, leaders = vm_cfg.bytecode_cfg(instructions)
    if not leaders:
        return list(lines)
    buckets = _partition(lines, leaders)
    block_of = vm_cfg._block_of_fn(leaders)
    info = {L: _parse_block(buckets[L]) for L in leaders}
    # Rung 5: foldable switches (single-entry dispatch) become composable region nodes.
    # An UN-foldable switch is handled LOCALLY inside _structure (flat-span its dispatch,
    # structure the case bodies around it — rung 6), not by bailing the whole sub.
    switches = {d['S']: d for d in vm_cfg.switch_dispatches(instructions)}
    nxt = {leaders[i]: (leaders[i + 1] if i + 1 < len(leaders) else vm_cfg.EXIT)
           for i in range(len(leaders))}
    edges, _dom = vm_cfg.back_edges(cfg, leaders[0])
    from collections import defaultdict
    loops, latches = {}, defaultdict(set)
    for u, hh in edges:
        loops.setdefault(hh, set()).update(vm_cfg.natural_loop(u, hh, cfg))
        latches[hh].add(u)
    loops = {hh: frozenset(s) for hh, s in loops.items()}
    pdom = vm_cfg.post_dominators(cfg)

    def _fresh_ctx():
        return _Ctx(cfg, info, block_of, nxt, loops, latches, buckets, switches)

    def _structure_region(entry, stop):
        """Structure the single-entry/single-exit region [entry, stop) into a seq (AST items),
        or None on a structural bail. Fresh visited per call (regions are disjoint)."""
        try:
            seq, _u = _structure(entry, stop, pdom, _fresh_ctx(), None)
            return seq
        except _NotReducible:
            return None

    def _validates(seq):
        out = []
        _emit(seq, 1, out)
        out = _insert_labels(out, block_of)
        if not vm_cfg.structured_equivalent(lines, out, leaders)[0]:
            return None
        # CFG-neutral peephole (drop redundant goto-to-fall-through + dead labels), kept only if
        # it still proves equivalent — the gate is the backstop for the rare emit-order divergence.
        peeled = _peephole(out)
        return peeled if vm_cfg.structured_equivalent(lines, peeled, leaders)[0] else out

    # 1) WHOLE-SUB structuring, self-validated against the CFG-equivalence gate (the design's
    #    verifier). Composed local fallbacks (honest-goto cuts / flat spans / convergent exits)
    #    can emit a CFG-divergent LAYOUT no structural guard caught; rather than enumerate every
    #    hazard, prove equivalence or fall through. Keeps "0 gate-rejects downstream" automatic.
    whole = _structure_region(leaders[0], vm_cfg.EXIT)
    if whole is not None:
        out = _validates(whole)
        if out is not None:
            return out

    # 2) REGION-LEVEL PARTIAL FALLBACK. Decompose the sub at its post-dominator SPINE (the
    #    immediate-post-dom chain entry -> … -> EXIT — the blocks ALL paths pass through) into a
    #    sequence of single-entry/single-exit regions. Structure each independently and keep it
    #    only if (that region structured + every OTHER region flat) self-validates; else flat-span
    #    just that region. Regions are disjoint and joined linearly at the articulation points, so
    #    a divergence in one improper region no longer flattens the WHOLE sub — the reducible
    #    regions around it keep their structure. Every kept piece is CFG-proven.
    spine, p, seen = [leaders[0]], leaders[0], {leaders[0]}
    while p is not vm_cfg.EXIT:
        p = vm_cfg._imm_post_dom(pdom, p)
        if p in seen:                      # malformed / cyclic spine — abandon recovery
            spine = None
            break
        seen.add(p)
        spine.append(p)
    if spine and len(spine) > 2:           # >1 region, else recovery == whole-sub (already failed)
        regions = list(zip(spine, spine[1:]))
        # Each region (Pi, Pj) owns the blocks reachable from Pi walled off by EVERY OTHER spine
        # point — not just Pj. Walling only Pj is unsound when the spine cuts through a loop: a
        # back-edge from a LATER spine point (a loop latch) re-enters an EARLIER region's body, so
        # that region's flat-span re-emits the whole loop body as unreachable dead code (CFG-
        # equivalent, so the gate misses it, but it doubles the gotos). Spine points are
        # articulation points, so nothing legitimately between Pi and Pj is itself a spine point —
        # walling them all off makes the regions a true disjoint partition.
        spine_walls = set(spine) - {vm_cfg.EXIT}
        rblocks = [{b for b in _reachable_avoiding(Pi, spine_walls - {Pi}, _fresh_ctx())
                    if b is not vm_cfg.EXIT}
                   for Pi, Pj in regions]
        flat = [[_flat_span(bl, _fresh_ctx(), None)[0]] for bl in rblocks]   # one flatspan node
        chosen = [seq[:] for seq in flat]                                    # default: all flat

        def _gotos_of(seq):
            o = []
            _emit(seq, 1, o)
            return sum(1 for _a, _i, t in o if _RE_GOTO_TGT.search(t))

        flat_g = [_gotos_of(seq) for seq in flat]
        for i, (Pi, Pj) in enumerate(regions):
            s = _structure_region(Pi, Pj)
            # Keep the region structured only if it BOTH validates AND emits no more gotos than
            # the flat span — an honest-goto cut can turn a raw fall-through into an explicit
            # goto, so an over-aggressive structuring may carry MORE gotos than the leaner flat
            # form; prefer flat there (fewer gotos, and the gate-faithful raw layout).
            if s is None or _gotos_of(s) > flat_g[i]:
                continue
            trial = chosen[:i] + [s] + chosen[i + 1:]
            if _validates([it for sub in trial for it in sub]) is not None:
                chosen[i] = s
        out = _validates([it for sub in chosen for it in sub])
        if out is not None:
            LAST_BAIL = None if any(chosen[i] is not flat[i] for i in range(len(regions))) \
                else 'self_gate'
            return out
    LAST_BAIL = 'self_gate'
    return _flat_emit(buckets, leaders)


_RE_GOTO_TGT = re.compile(r'goto L_([0-9A-Fa-f]{4})')


def _insert_labels(out, block_of):
    """Re-insert `L_xxxx:` labels for any honest goto the structured emit produced (rung-6
    self-gotos / edge cuts). The structured tree strips labels — clean folds emit zero gotos
    so this is a no-op for them — but a kept honest goto needs its target label back for valid
    C. Insert each target's label (column 0, the existing convention) before the first emitted
    line of that target's block. The gate ignores labels, so this is cosmetic-only."""
    targets = set()
    for _a, _ind, t in out:
        for m in _RE_GOTO_TGT.finditer(t):
            targets.add(int(m.group(1), 16))
    if not targets:
        return out
    result, placed = [], set()
    for addr, ind, text in out:
        if targets and addr and block_of(addr) in targets and block_of(addr) not in placed:
            T = block_of(addr)
            result.append((T, 0, f"L_{T:04X}:"))
            placed.add(T)
        result.append((addr, ind, text))
    return result


_RE_GOTO_ONLY = re.compile(r'^goto L_([0-9A-Fa-f]{4});$')


def _peephole(out):
    """CFG-neutral cleanup of the emitted lines — the caller RE-VALIDATES the result against
    the equivalence gate, so this only ever PROPOSES; an unsound proposal is rejected wholesale.

    (1) goto-to-fall-through: a standalone `goto L_X;` whose IMMEDIATELY-following emitted line
        is `L_X:` is redundant — physical fall-through already reaches X (the region reducer's
        honest-goto cuts / flat-span joins routinely emit `goto L_next; L_next:` at a boundary).
        Drop the goto. Emit-order adjacency (not address order) is the trigger, because the
        structured C is read in emit order; the gate's address-based re-check is the backstop.
    (2) then drop any `L_X:` label no surviving goto still targets (cosmetic; the gate ignores
        labels, so this is always safe)."""
    pruned = []
    for i, (addr, ind, text) in enumerate(out):
        m = _RE_GOTO_ONLY.match(text.strip())
        if m and i + 1 < len(out):
            tgt = int(m.group(1), 16)
            if out[i + 1][2].strip() == f"L_{tgt:04X}:":
                continue                       # redundant goto-to-next — drop it
        pruned.append((addr, ind, text))
    refs = set()
    for _a, _i, t in pruned:
        for m in _RE_GOTO_TGT.finditer(t):
            refs.add(int(m.group(1), 16))
    result = []
    for addr, ind, text in pruned:
        lm = vm_cfg._RE_LABEL.match(text.strip())
        if lm and int(text.strip()[2:6], 16) not in refs:
            continue                           # dead label — no goto targets it anymore
        result.append((addr, ind, text))
    return result
