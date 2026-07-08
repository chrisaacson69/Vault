---
status: active
created: 2026-07-08
---
# DREAM — Goto-Free Control-Flow Structuring
> How the DREAM decompiler recovers `if`/`while`/`switch` with **zero** `goto`s — and how it resolves the shared-tail problem that node-splitting can't.

**Links:** [koei-snes vm_struct experiment](../gaming/koei-ai-combat-evolution.md), [three-layer method](../karpathy-three-layer-method.md)

**Paper:** Yakdan, Eschweiler, Gerhards-Padilla, Smith — *"No More Gotos: Decompilation
Using Pattern-Independent Control-Flow Structuring and Semantics-Preserving
Transformations."* NDSS 2015. DOI 10.14722/NDSS.2015.23185.
- PDF: <https://net.cs.uni-bonn.de/fileadmin/ag/martini/Staff/yakdan/dream_ndss2015.pdf>
- Local copy: [`raw/papers/dream_ndss2015.pdf`](../../raw/papers/dream_ndss2015.pdf)
- NDSS page: <https://www.ndss-symposium.org/ndss2015/ndss-2015-programme/no-more-gotos-decompilation-using-pattern-independent-control-flow-structuring-and-semantics/>

## The core idea — reaching conditions, not patterns, not duplication

Classic structuring (structural/interval analysis) **pattern-matches** the CFG against
schema shapes (if-then, while, …). It fails on anything that doesn't fit a schema →
emits `goto`. DREAM abandons patterns. Instead, for each node it computes a **reaching
condition** `cr(ns, ne)` — the boolean formula over branch predicates under which control
flows from `ns` to `ne`, derived from a **graph slice** `SG(ns, ne)`. Three phases:
1. Compute each node's reaching condition from the region header.
2. **Group nodes by reaching condition + reachability** into sets representable as
   `if`/`switch`. In cyclic regions, edges to the region successor first become `break`,
   then the loop body (now acyclic) is structured.
3. Infer loop type/condition (assume endless loop, then reason about exits).

A **shared tail** (node with many predecessors) is emitted **once**, guarded by the
disjunction of the conditions under which it's reached. No copies, no gotos. Correctness
("semantics-preserving") falls out of the reaching conditions being exact.

## The twist: DREAM is the authors' *fix* for their own node-splitting

The same group (Yakdan et al.) earlier built **REcompile**, which used **node splitting**
to cut gotos — "nodes are split into several copies. While this reduces goto statements,
it increases the size of decompiled output." That is *exactly* the `$XXXX.0/.1/.2`
shared-tail approach (give each path its own copy of the tail): it works but bloats, and
the exceptions never fully close. DREAM replaces splitting with reaching conditions —
same problem, condition-based instead of copy-based. So the address-suffix tail idea
wasn't wrong; it was REcompile, and DREAM is the documented next step past it.

## Theoretical or practical?

**Practical.** Implemented in the DREAM decompiler, evaluated on GNU coreutils, and shown
to beat **Hex-Rays and Phoenix** on both correctness and goto-count (0 gotos). The cost is
that reaching conditions can grow complex, so DREAM adds **semantics-preserving
transformations** + post-structuring simplification (e.g. `while`→`for`, condition
simplification, function outlining, API-based variable naming) purely for readability.
So: goto-free is real and achievable; the open engineering question is keeping the
recovered *conditions* simple enough to read.

## Bearing on the koei-snes experiment

`koei-snes/tools/vm_struct.py` currently does the *old* thing — follow-node (post-dominator)
pattern matching — which is why it's ~65-75% goto-less and leaves loop back-edges. Porting
it to reaching-conditions is the path to the paper's 100%. And because KOEI bytecode is
compiled from structured C (reducible CFG), it's a clean testbed to implement reaching
conditions and finally characterize the shared-tail exception in isolation.

## Tags
[reverse-engineering](../../tags/reverse-engineering.md) · [decompilation](../../tags/decompilation.md)
