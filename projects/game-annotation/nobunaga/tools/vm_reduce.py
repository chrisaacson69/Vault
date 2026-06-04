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


def reduce(lines, instructions):
    """Region reducer (CFG epic V2). Rung 1: build the block partition and emit the
    blocks in leader order — the trivial sequence-of-blocks tree, goto/label form intact.
    Later rungs replace the flat leader-order emit with a region tree (if/while/switch).
    Falls back to a verbatim passthrough when there's no CFG (empty/degenerate sub)."""
    _cfg, leaders = vm_cfg.bytecode_cfg(instructions)
    if not leaders:
        return list(lines)
    buckets = _partition(lines, leaders)
    out = []
    for L in leaders:
        out.extend(buckets[L])
    return out
