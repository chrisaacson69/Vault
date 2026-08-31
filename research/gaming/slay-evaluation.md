---
status: active
created: 2026-07-20
published: true
layout: layouts/page.njk
title: "Slay — Evaluation & Search (the 1v1 case)"
---
# Slay — Evaluation & Search (the 1v1 case)
> The evaluation function and search design for two-player Slay, and three theses that generalize past it: the cut/join graph duality, realizable-treasury (use-it-or-lose-it), and eval-beats-depth in wide-branching games.

**Links:** [The Multiplayer Coalition Problem](./multiplayer-coalition-problem.md) (the N≥3 wall; this page is the tractable 1v1 base case), [Slay](../../projects/slay/README.md), [Slay-C](../../projects/slay-c/README.md), [Gaming](./README.md), [Economics](../economics/README.md)

## Framing — at 1v1 the algorithm question is moot

Two-player Slay is a zero-sum perfect-information game, so **minimax = MaxN = Paranoid** — they all collapse into the plain iterative-deepening alpha-beta already in `slay-c/search`. The Paranoid-vs-MaxN debate is an *N-player* argument (worked out in the [coalition page](./multiplayer-coalition-problem.md)); it doesn't bear on where the project is. The transferable, engine-independent parts are **evaluation** and **search/pruning**, and they carry forward to the N-player game unchanged.

One framing upgrade even at 1v1: **score relative** (`V_me − V_opp`), not absolute. In a zero-sum cut game that makes "a cut I can inflict on *them*" score symmetrically with "a cut they can inflict on me" — which the articulation-point term below depends on.

## The evaluation model

A widely-circulated starter formula is `V = w₁·Hexes + w₂·NetIncome − w₃·CutVuln − w₄·TreeTax`. The instincts are right but it *regresses* the existing `slay-c` GreedyAI eval (which already had **unit strength**) and double-counts. The corrected term set:

- **Hexes** — territory is the fundamental resource (income *and* victory). Keep.
- **Upkeep drag, not "net income."** Income ≈ hex count per territory, so `Hexes` and the positive half of `NetIncome` are collinear — you fight the tuner. The independent signal is the **upkeep/sustainability** side; score that as the drag, don't pay for hexes twice.
- **Frontier margin (non-linear unit strength).** What holds a border isn't summed unit value — it's `max_defense(border hex) − max_attacker(enemy adjacent)`, per contested border. Unit level is wildly non-linear (a Baron/L4 is near-unkillable). This is the term the starter formula drops and the one *least* worth losing.
- **Realizable treasury** — see thesis 2. Not raw gold; gold discounted by deniability, with a mild penalty on un-protectable excess.
- **Consequence-weighted, reachability-gated cut** — see thesis 1. Not a raw articulation-point *count*.
- **Effective income (tree fold-in).** Trees are a hex that should produce and doesn't. Subtract treed hexes from effective income rather than adding a separate `TreeTax` weight — same effect, one fewer knob. With look-ahead this matters: uncontrolled tree spread loses games, and effective-income makes the search *see* the spreading drag before it compounds.

## Thesis 1 — cut vulnerability and join potential are the same graph, opposite sign

Slay's late game is a contest of **who cuts long borders more effectively**; cheap cut/join capacity is what keeps peasants valuable into the endgame. The key structural insight: **cut vulnerability and join potential are one graph structure read from two directions.**

- **Cut vulnerability** = *my* articulation points / narrow necks an enemy can sever (negative).
- **Join potential** = the bridge hexes where two of *my* territories are N captures from merging (positive), and symmetrically *their* articulation points I can sever (positive).

Because fragmented territories can't afford knights/barons and **eventually all must be joined**, the eval needs a **connectivity-distance** term: how many captures until my fragments become one economy that crosses the next unit-tier threshold. Two consequences for the cut term specifically — it must be **consequence-weighted** (a split strands the treasury-poor side, whose units die at next upkeep; weight by army/economy orphaned, and by which side keeps the capital) and **reachability-gated** (an articulation point only counts if an enemy has an adjacent unit of level > its defense *this* turn — a cut nobody can execute is free).

This also resolves the decomposition tension in the search section: **decompose for move generation, evaluate globally.** Peasants-in-the-endgame falls straight out — a peasant is the cheapest tool that both severs a 1-defense neck and bridges a gap, so the cut-delta term is what makes an AI value them late instead of dismissing them.

## Thesis 2 — realizable treasury (use-it-or-lose-it) makes gold non-monotonic

Banked gold looks like a pure positive; it isn't. Treasury is **dry powder** — valuable for flexibility and survival, but earning nothing *and deniable*. This is the Slay instance of the Monopoly insight from the [coalition page](./multiplayer-coalition-problem.md#the-relative-position-model-2026-02-22): **cash is intercept, not slope — it earns nothing until converted to position.** Slay adds a twist: the gold is not merely idle, it's capturable/forceable.

So the term is **realizable treasury** = gold discounted by the probability it's denied or force-spent before conversion. Gold on a secure capital = full value; gold on a threatened capital = discounted; gold *beyond* a survival buffer that's just being sat on = **mildly penalized**, because holding un-protectable, un-converted gold is dominated by spending it (a unit, an extension, a tree-clear). This is why "**hit a town just to empty the treasury**" is a real objective: you're attacking their *unrealized* value — the cheapest thing on the board to destroy — and it ties treasury straight back into the cut term (a cut that orphans the treasury-poor side, or a threat forcing premature spend, is the same attack on realizability).

## Thesis 3 — in wide-branching games, eval beats depth (the early-NNUE lesson)

Slay's turn = {move each unit} × {merges} × {purchases} × {placements} — a branching factor closer to **Go than chess**. In a wide game each ply multiplies by a huge factor, so reachable depth is shallow, and **a smart eval that already *sees* cut-delta, connectivity, and realizable-treasury crushes a deep search running a dumb hex-counter.**

The principle: **a good eval is search compression** — you pay eval cost once to avoid the exponential depth cost of discovering the same fact tactically. In a narrow game (chess) depth is cheap enough that a weak eval gets rescued by search; in a wide game it can't, so eval dominates. That's exactly the early-NNUE lesson.

**The handcrafted terms are not throwaway — they are the input features of the eventual learned eval.** Frontier-margin, articulation-consequence, connectivity-distance, realizable-treasury, tree-spread-lookahead: hand-craft them now (they also run the Phase-2 bottleneck test below), and they survive into the Stockfish-template [Phase 3](./multiplayer-coalition-problem.md#the-stockfish-architecture-as-template) as the NNUE's features. This is feature engineering the learned weights refine, not scaffolding to tear down.

## Search & pruning

- **Per-territory decomposition — for *generation*, not evaluation.** Money is per-territory, so each territory's turn is *nearly* independent; generate its tactical options separately to cut the joint product. But **evaluate globally** (connectivity, total realizable economy) or you never value a join. The coupling moves — cross-border captures that merge my partitions or split theirs — are the high-value actions move-ordering should surface first.
- **Transposition table is the *primary* reduction, not an optimization.** With orderings this permutable (move-A-then-B = move-B-then-A), **collapsing transpositions to 1 *is* the search.** Represent a turn as a *set* of atomic actions reaching an end-of-turn state, hash it (Zobrist), and dedup there. **Measure the convergence ratio** — naive branching vs. unique-end-state count; that single number says how wide the game actually is after dedup (likely far smaller than naive) and whether depth is even reachable.
- **Move ordering is what makes alpha-beta fast.** Best-first expansion of highest-value atomic actions (captures that take a capital, merges that clear a border margin) + alpha-beta cutoffs, rather than enumerating the full turn tree.
- **Immediate bankruptcy pruning — heuristic, not sound.** Discard branches that can't pay next-turn upkeep — but deliberate over-extension to grab an enemy **capital** can be winning, so order bankrupt branches last (or only discard bankruptcies with no capital captured that turn) rather than hard-pruning.
- **Proximity restriction — split it.** Captures can only happen at a border (a *rule*, so restricting capture-generation to the frontier is lossless), but repositioning/defense/tree-clearing needs interior moves (covering a threatened articulation point, clearing an interior tree). Allow ≤1 reposition step toward an objective and skip no-op interior shuffles — cut branching without going tactically blind.

## The discriminator — run this before tuning weights

The [coalition page's Phase-2 test](./multiplayer-coalition-problem.md#the-stockfish-architecture-as-template): give the AI **unbounded depth on a small board** and see if it plays perfectly. Perfect ⇒ the bottleneck is *search* (the pruning/transposition work pays off). Imperfect ⇒ it's *eval* (the term surgery pays off). This tells you which half to invest in before touching a single weight — and thesis 3 predicts eval.

## Tags
[games](../../tags/games.md), [game-ai](../../tags/game-ai.md), [ai](../../tags/ai.md), [economics](../../tags/economics.md)
