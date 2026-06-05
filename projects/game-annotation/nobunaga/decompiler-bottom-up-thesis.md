---
status: active
created: 2026-06-04
---
# The Decompiler is a Reverse Compiler — Bottom-Up Atom Inversion
> NA1's engine is **100% reducible**: there is no irreducible control flow anywhere. The V2 region-reducer's "irreducible residue" was a phantom of the top-down framing. The right model is bottom-up — invert a *finite* table of compiler lowering patterns ("atoms"), substituting each matched subgraph with a token, until the procedure collapses to structured C.

**Links:** [ROADMAP](./ROADMAP.md) (CFG epic V2, sessions 7a–7g) · [05-bytecode-vm](./05-bytecode-vm.md) · [06-vm-disassembler](./06-vm-disassembler.md) · tool: `tools/probe-cfg-reducibility.py`

---

## The finding that reframes everything

`probe-cfg-reducibility.py` measured formal reducibility of every sub (a CFG is reducible iff
removing its dominator back-edges leaves a DAG — no multiple-entry loops):

```
REDUCIBILITY CENSUS over 495 subs:
  reducible:   495  (100.0%)
  irreducible: 0    (0.0%)
BEHIND-V1: 59 subs   reducible (missing-atom) 59   irreducible (genuine residue) 0
```

**Every sub in the engine is reducible. Zero exceptions.** A reducible CFG *always* has a
goto-free structured form. So:

1. **There is no "irreducible residue."** Session 7f's conclusion — that ~22 subs are genuinely
   improper and need an address-ordered emitter or must be accepted as honest gotos — was wrong.
   It was an artifact of top-down post-dominator decomposition manufacturing false irreducibility
   out of shared continuations (the classic case: N blocks branching to a shared `return`).
2. **The engine is structured-source-shaped.** Reducibility is *precisely* the property that
   compiling from a structured language guarantees (you can't `goto` into a loop body). Hand-written
   spaghetti shows irreducible loops; there are none. NA1 was compiled from — or written with the
   discipline of — structured source. (Corroborated: rungs 1–5 cleanly folded ~280 subs; messy asm
   would not.)
3. **The 59 "behind-V1" subs are 100% missing-atoms, 0% irreducibility.** The goto-count metric
   was measuring "inverse-lowerings we haven't written yet" the whole time.

## Why bottom-up, and why top-down spawled

The decompiler is the inverse of a compiler. A non-optimizing structured-source → bytecode
compiler emits a **finite** set of control-flow patterns — one per construct (`if`, `if/else`,
`while`, `do`, `for`, `switch`, `&&`, `||`, `?:`, `break`, `continue`, early-`return`).
Decompilation = invert that finite table, bottom-up: match an atom's subgraph, collapse it to a
token, repeat until one token remains. Closed table → **convergent**.

Top-down (the V2 region-reducer) and bottom-up are equivalent on clean code. They differ entirely
in **failure mode**, and that difference *is* the rung-6 spawl:

| | top-down (region templates) | bottom-up (atom inversion) |
|---|---|---|
| match fails | recursion stuck → whole-sub flat-bail → must **build** a local fallback per messy flavor | rule simply isn't applied → residual atoms **are** honest gotos, no special-casing |
| graceful local fallback | hand-built, one flavor at a time (the 16 rung-6 handlers) | **free** |
| rule source | discovered from *failing subs* (open-ended → spawl) | the compiler's *lowering table* (finite → converges) |

The rung-6 menagerie (`_convergent_exit`, spine-decomposition, cross_edge_top/fall, disjoint
walls, orphan-check, self-validation-revert, peephole, …) is V1's template menagerie reborn — built
because top-down has no graceful local fallback, so one had to be hand-assembled per shape.

## The goto metric actively lied

Canonical example, already sitting in the ROADMAP as "irreducible residue" (`$AD38`, `$A2D2`):

```c
if (!A) return;
if (!B) return;
if (A < B) sub1(); else sub2();
```

Compiled, this is N conditional branches to a shared `return` block. Top-down sees a shared
continuation → "cross-edge" → the exact shape that ate 7a–7g. V1 has fewer gotos only via
goto-layout tricks, so the metric screamed "V2 behind," so we chased it. But there is nothing
irreducible here — the high goto-count was a **missing atom**: *branch-to-terminal → guard
statement*. `return` is a terminal; it can be inlined/duplicated freely, which dissolves the
"merge" top-down treated as sacred. Invert that one pattern and the whole shared-return family
collapses to clean guards with zero gotos.

## The open question, answered: solve-in-place vs. another refactor

**They are the same activity, if each atom is added as a CFG pre-contraction — and doing so
*deletes* the spawl rather than adding to it.**

- The original V2 design already pre-contracts value-diamonds and boolean-regions to tokens
  before the region tree runs (locked decisions #3/#4). That pre-contraction **is** the bottom-up
  move. The spawl happened when rung 6 stopped pre-contracting atoms and started post-classifying
  regions.
- So the right home for a new atom (the guard; switch-case inline) is **another pre-contraction
  pass**: rewrite the matched subgraph to a token on the CFG, *before* decomposition. Same
  mechanism as the diamonds, extended.
- Crucially, each atom added this way should make a rung-6 handler **dead code** — those handlers
  exist only to cope with the un-contracted atom (the cross_edge handlers cope with un-contracted
  shared-returns). Add the atom, delete the handler. The work is **net-negative on rules.**
- Endpoint: when `behind-V1 == 0` and the rung-6 fallbacks are all unreachable, delete them. What
  remains — pre-contractions + a clean region tree over reducible graphs — *is* a bottom-up
  reducer. You arrive at the refactor **by attrition, no big-bang rewrite.** A full from-scratch
  bottom-up rewrite is only forced if the spine machinery actively corrupts atoms even after
  pre-contraction; the census gives no reason to expect that.

**Does it take the PoC to decide this?** No. The census already proves the load-bearing claim — a
structured form exists for all 495. The PoC (compile Small-C / lcc, observe each construct's jump
pattern) does two *different* jobs: (a) hands you the **complete, finite atom table** so you stop
discovering atoms one-failing-sub-at-a-time and know when you're *done*; (b) a confidence check
that the inverse round-trips. It's rule-sourcing and de-risking, not the architecture decision.

**What's proven vs. bet:** *Proven* — no irreducibility; a clean decompile exists; goto-count was
measuring missing atoms. *Strongly indicated, to be demonstrated* — the atom table is small (the
59 cluster on a few signatures, not 59 one-offs), and pre-contraction cleanly deletes the spawl
(confirmed by pulling the first atom and watching handlers die). So: the idea is essentially
proven; the *engineering tractability* is the remaining, well-supported bet.

## Next session — the working idea

Not "fix unreadable functions" (that risks 1-offs). Instead, an **atom-extraction loop** with a
built-in convergence gate:

1. **Pick a behind sub from a cluster**, smallest first for a clean read:
   - `$9A5D` (b1, V1 3 / V2 13, shared-ret 1) — minimal guard-chain case.
   - `$A2D2` (b1, V1 19 / V2 42, shared-ret 2) — biggest payoff; the guard + switch handler.
   - `$A221` (b2, V1 11 / V2 22, shared-ret **0**) — a *different* atom (not guard; switch-inline?).
   - `$9954` (b2, V1 7 / V2 15, shared-ret 0) — routing-blocks / switch cases.
2. **Name the forward lowering** it came from (`if(!c) return;` = branch-to-shared-return; `switch`
   = jump-table → cases). *If you can name the forward pattern, it's a real atom.* If you can't —
   "this region just needs this treatment" — it's a 1-off; reject it, leave the honest goto.
3. **Implement the inverse as a local pre-contraction** (collapse the matched subgraph to a token),
   and **delete** the rung-6 handler it obsoletes.
4. **Re-run `probe-cfg-reducibility.py`.** A real atom moves *several* subs out of "behind"; a 1-off
   moves one. That is "the test is the process" made measurable, and the convergence proof.

Likely first atoms, by the cross-tab: **branch-to-terminal guard** (clears the `shared-ret > 0`
cluster) and **switch-case inline** (clears the `shared-ret = 0` cluster). Two atoms may clear most
of the 59.

Optional parallel PoC: `tcc`/`lcc`/Small-C, compile `if/else/while/switch/&&/early-return`, read the
emitted jump patterns — that *is* the inverse-lowering table, finite and complete. The census proved
the target obeys it.

## Tags
[reverse-engineering](../../../tags/reverse-engineering.md)
