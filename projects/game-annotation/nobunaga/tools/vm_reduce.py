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
    0. harness + passthrough (THIS) — reduce() returns lines unchanged; corpus wired.
    1. block model + trivial emit — partition lines into blocks; emit seq-of-blocks
       with gotos (reproduce the raw form FROM the tree) -> proves block<->line round-trip.
    2. sequence + if-then + if-then-else (acyclic diamonds via dom/post-dom).
    3. short-circuit (&&/||) — reuse boolean_regions / recover_bool_formula.
    4. while / do-while (natural loops via back_edges / natural_loop).
    5. switch — reuse switch_dispatches; nested-in-if/while switches fall out for free.
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


# === Rung 2: sequence + if-then + if-then-else =================================
# The first reduction rule. Over an ACYCLIC sub (no back edges — loops are rung 4),
# recursively structure the single-entry/single-exit region from the entry to EXIT
# into a tree of Seq / IfThen / IfThenElse, using the post-dominator as each 2-way
# branch's merge point. Branch polarity mirrors the decompiler exactly: a header's
# raw line is `if (RAWC) goto L_T` (goto = TRUE arm, fall-through = the body), so the
# structured then-body is the FALL-THROUGH arm with condition `_neg(RAWC)` — the same
# Pattern-A/B inversion, and the print loop's simplify_expression cleans `!((a<b))` ->
# `(a>=b)`. CONSERVATIVE by design: any shape this rung doesn't cleanly own (a block
# reached twice = cross/shared edge, a forward goto skipping the merge, a switch, a
# body that lives on the goto side and would force a reorder) raises NotReducible and
# the whole sub falls back to the rung-1 flat emit. The CFG-equivalence gate
# (structured_equivalent, applied in vm_decompile.decompile) is the backstop: a tree
# that builds but mis-routes is rejected there and the sub reverts to honest goto.

# A statement line to emit verbatim, vs control scaffolding the structure consumes.
_RE_IFGOTO = re.compile(r'if \((.+)\) goto L_([0-9A-Fa-f]{4});$')
_RE_GOTO = re.compile(r'goto L_([0-9A-Fa-f]{4});$')


class _NotReducible(Exception):
    pass


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


def _structure(entry, stop, cfg, info, block_of, pdom, nxt, visited):
    """Structure the single-entry region from `entry` until control reaches `stop`
    (a merge/exit block outside this region) or EXIT. Returns (seq, used) where seq is
    a list of AST items and used is the set of block leaders the region consumed:
      ('block', leader, [(addr, text)…])                      — a basic block's body
      ('if',    branch_addr, [(addr,text)…], cond, then, else) — then/else are item lists;
                                                                 else is [] for an if-then.
    Raises _NotReducible on any shape rung 2 doesn't cleanly own."""
    seq, used = [], set()
    n = entry
    while n is not vm_cfg.EXIT and n != stop:
        if n in visited:
            raise _NotReducible                      # cross / shared edge
        visited.add(n)
        used.add(n)
        stmts, rawcond, baddr, gtgt, _sw = info[n]
        succ = cfg[n]
        if len(succ) == 1:
            (s,) = tuple(succ)
            seq.append(('block', n, stmts))
            n = s
        elif len(succ) == 2 and rawcond is not None and gtgt is not None:
            goto_block = block_of(gtgt)
            if goto_block not in succ:
                raise _NotReducible
            fall = next((x for x in succ if x != goto_block), None)
            if fall is vm_cfg.EXIT or fall is None:
                raise _NotReducible                  # header falls off the end — rare
            merge = vm_cfg._imm_post_dom(pdom, n)
            # The goto target must stay within the region (<= merge by address); a goto
            # PAST the merge is a forward skip (break-like) -> irreducible at rung 2.
            if merge is not vm_cfg.EXIT and goto_block > merge:
                raise _NotReducible
            then_seq, then_used = ([], set()) if fall == merge else \
                _structure(fall, merge, cfg, info, block_of, pdom, nxt, visited)
            else_seq, else_used = ([], set()) if goto_block == merge else \
                _structure(goto_block, merge, cfg, info, block_of, pdom, nxt, visited)
            if not then_seq:
                # empty/degenerate then, or body lives only on the goto side (would reorder
                # above the fall) -> bail.
                raise _NotReducible
            if else_seq:
                if not (fall < goto_block):
                    raise _NotReducible              # if-else needs then(fall) before else(goto)
                # The ENTIRE then-region must precede the ENTIRE else-region by address —
                # else emitting then-then-else reverses address order and the address-based
                # gate mis-routes (e.g. $A853: a nested if whose arm sits at a HIGHER addr
                # than the outer else-body, so the spans interleave). Lexical order == address
                # order is the invariant the gate (and readable C) rely on.
                if max(then_used) >= min(else_used):
                    raise _NotReducible
            # LEXICAL-ADJACENCY of the merge: the gate lowers a construct's merge as the
            # address-next leader after its last block, so the merge MUST be that block.
            # When an outer arm is laid out between this construct and its (shared) merge,
            # next_leader(last) != merge -> the nesting interleaves; bail (the gate would
            # otherwise mis-route, e.g. $8F0A's twin nested if/else sharing one merge).
            consumed = {n} | then_used | else_used
            if nxt[max(consumed)] != merge:
                raise _NotReducible
            cond = vm_cfg._neg(rawcond)
            seq.append(('if', baddr if baddr is not None else n, stmts, cond, then_seq, else_seq))
            used |= consumed
            n = merge
        else:
            raise _NotReducible                      # switch / >2-way / cond-less 2-way
    return seq, used


def _emit(seq, indent, out):
    for item in seq:
        if item[0] == 'block':
            _, _L, stmts = item
            for addr, text in stmts:
                out.append((addr, indent, text))
        else:  # 'if'
            _, baddr, stmts, cond, then_seq, else_seq = item
            for addr, text in stmts:
                out.append((addr, indent, text))
            out.append((baddr, indent, f"if ({cond}) {{"))
            _emit(then_seq, indent + 1, out)
            if else_seq:
                out.append((0, indent, "} else {"))
                _emit(else_seq, indent + 1, out)
            out.append((0, indent, "}"))


def reduce(lines, instructions):
    """Region reducer (CFG epic V2). Rungs 0-1 = block partition + flat emit; rung 2 adds
    sequence/if-then/if-then-else over acyclic subs (loops -> flat, handled at rung 4).
    Falls back to the rung-1 flat emit whenever the structure can't be cleanly recovered;
    the CFG-equivalence gate in vm_decompile.decompile is the final backstop."""
    cfg, leaders = vm_cfg.bytecode_cfg(instructions)
    if not leaders:
        return list(lines)
    buckets = _partition(lines, leaders)
    # Rung 2 only structures acyclic subs; a back edge means a loop (rung 4).
    edges, _dom = vm_cfg.back_edges(cfg, leaders[0])
    if edges:
        return _flat_emit(buckets, leaders)
    try:
        block_of = vm_cfg._block_of_fn(leaders)
        info = {L: _parse_block(buckets[L]) for L in leaders}
        if any(i[4] for i in info.values()):            # a switch -> rung 5
            return _flat_emit(buckets, leaders)
        nxt = {leaders[i]: (leaders[i + 1] if i + 1 < len(leaders) else vm_cfg.EXIT)
               for i in range(len(leaders))}
        seq, _used = _structure(leaders[0], vm_cfg.EXIT, cfg, info,
                                block_of, vm_cfg.post_dominators(cfg), nxt, set())
    except _NotReducible:
        return _flat_emit(buckets, leaders)
    out = []
    _emit(seq, 1, out)
    return out
