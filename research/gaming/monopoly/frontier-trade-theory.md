---
status: active — theory phase
created: 2026-03-15
---
# Efficient Frontier Trade Theory
> Using EPT frontier curves to solve the 3+ player trade valuation problem — reducing the permutation space through structural truths about development velocity and game horizon.

**Links:** [Monopoly](../../../projects/monopoly/README.md), [The Multiplayer Coalition Problem](../multiplayer-coalition-problem.md), [Nash Bargaining Problem](../nash-bargaining-problem.md), [Bilateral Trade Valuation](../bilateral-trade-valuation.md), [Subgraph Investment Optimization](./subgraph-investment-optimization.md), [CoM Spell Counter-Graph](../master-of-magic/com-counter-graph.md) — same dominance-graph methodology applied to MoM spell economy, [Risk and Entrepreneurship](../../economics/risk-and-entrepreneurship.md) (the economics parent — this page sits in its applications ledger), [The Dominance-Frontier Lens](../../dominance-frontier-lens.md) (the general method this EPT frontier is an instance of)

## The Problem

Bilateral trade valuation is solved (trajectory-based, accounts for competitive feedback). The 3+ player trade problem remains open: how to value trades in a multiplayer environment where each trade reshapes every player's competitive landscape.

The brute-force approach (evaluate all permutations) is intractable. The frontier approach reduces the decision space by identifying structural truths that eliminate most options before evaluation begins.

### Methodological lineage — adapted from CAPM / Modern Portfolio Theory

The "efficient frontier" name isn't borrowed loosely; it's borrowed *with the mathematical structure*. Modern Portfolio Theory (Markowitz 1952; CAPM, Sharpe 1964) represents all possible investment portfolios in a continuous risk-return space, then identifies the **Pareto-optimal subset** — the frontier where no other portfolio offers higher return at equal-or-lower risk. Investors don't enumerate portfolios; they think on the frontier.

The Monopoly application is the **discrete-game form of the same construction:**

| | CAPM / MPT (finance) | This frontier (Monopoly) |
|---|---|---|
| State space | Continuous (any weighted combination of assets) | Discrete (28 properties + 4 railroads + 2 utilities, integer holdings) |
| Axes of efficiency | Expected return vs. variance/risk | EPT (earnings per turn) vs. cash cost + development time |
| Frontier definition | Portfolios where no other has higher return at equal-or-lower risk | Portfolio paths where no other has higher EPT at equal-or-lower cost/time |
| Starting point | Arbitrary (any allocation possible at trade time) | Your "fragment" — properties you've already landed on (random draws) |
| Optimization | Free repositioning (subject to budget) | Constrained: must trade or land to acquire; opponents have veto |
| Combinatorial bloat reduction | Reduces continuous space to a 1-D curve | Reduces game-tree subset of trade/build sequences to a small graph of frontier paths |

The discrete-state-space reduction is **larger in proportional terms than CAPM's** because the starting fragment dominates the reachable set. From a typical mid-game state, only a handful of monopoly-completion paths are even reachable; most of the formally-possible state space is dominated by another reachable state (more EPT, less cost) and can be pruned. **The frontier collapses a combinatorial space to a tractable one for the same reason MPT works in continuous space: structural dominance means most options are strictly worse than other options on the same axes.**

This is the key technical contribution: not the bilateral evaluator (which is a precise NPV calculator) and not the simulation (which is execution), but **the recognition that the property-trade decision space has a Pareto-optimal subset that can be computed from each player's current fragment** — turning "consider all trades" into "consider only the frontier paths." Without this step, the combinatorial bloat makes principled play infeasible.

### Why the frontier generalizes

The combinatorial-reduction-via-Pareto-dominance trick is what makes the frontier approach **transferable** to other discrete-portfolio games. The Catan version ([catan-47k-empirical.md §"The exact-vs-frontier architectural distinction"](../catan-47k-empirical.md#the-exact-vs-frontier-architectural-distinction)) is the same construction with:

- State space = settlement vertices reachable from current road network
- Axes = pip-weighted production gain vs. resource cost + build-order constraints
- Starting point = current settlements + road network
- Frontier = reachable vertices where no other reachable vertex has higher gain at equal-or-lower cost

Same Markowitz/CAPM Pareto-frontier structure, different discrete game. The same generalization applies to MOO1 tech-tree branches, Diplomacy supply-center growth paths, Master of Magic spell-school progressions, anywhere a player has a starting fragment and a combinatorial set of reachable expansions with measurable cost/gain pairs.

**The vault's frontier work is best read as discrete-game MPT.** That naming pins down what it is mathematically and what it shares structurally with two centuries of financial-economics scholarship. The contributions on top of MPT are: handling the constrained-acquisition layer (you can't repurchase freely; trades require counterparty consent), the asymmetric-externalities pricing layer ([[bilateral-trade-valuation]] §"asymmetric-externality reading"), and the build-order constraint layer (some frontier positions are only reachable in sequence). Those are real refinements but they're refinements *on top of* the Pareto-frontier construction, not replacements for it.

### The architectural relationship to bilateral evaluation

Bilateral and frontier are **complementary tools that answer different questions**, not competing approaches to the same problem:

| Tool | Question it answers | When it shines | When it fails |
|---|---|---|---|
| [Bilateral trade valuation](../bilateral-trade-valuation.md) | "Exactly what is THIS specific trade worth between THESE specific players?" | Apples-to-apples trades (both players completing monopolies); auction bid prices; high-stakes single-move decisions | Non-completion 1:1 trades where strategic value depends on the broader portfolio; combinatorial trade chains |
| Frontier subgraph (this page) | "What's the strategic-value landscape for each player, and which trades are worth considering at all?" | Long-horizon planning; eliminating frivolous exchanges; identifying counterparty leverage points | Exact NPV of any specific trade — frontier gives strategic value, not prices |

The frontier was created **explicitly because** the bilateral evaluator's narrow domain of cleanness (apples-to-apples monopoly completions) covered only a small fraction of real Monopoly trade decisions. The bilateral evaluator works wonderfully when two players are each completing monopolies and dominating the field — but it says little about 1:1 trades of non-completion properties, because the strategic value of a single non-completion property depends on what *else* the player might acquire over the rest of the game. That combinatorial structure is exactly what the frontier subgraph captures by showing each player's reachable Pareto-optimal expansion paths from their random portfolio.

**Conceptual flow:** frontier subgraph identifies *which* trades are worth considering (which moves are on the frontier); bilateral evaluator prices the ones that survive that filter. Frontier without bilateral leaves pricing fuzzy; bilateral without frontier evaluates too many trades, most of them strategically irrelevant. Both together give you the right shape.

This architectural relationship also applies to Catan ([catan-47k-empirical.md §"The exact-vs-frontier architectural distinction"](../catan-47k-empirical.md#the-exact-vs-frontier-architectural-distinction)). A Catan frontier graph would show each player's expansion-path Pareto frontier; a Catan bilateral evaluator would price specific trade offers. Same complementary architecture, different game.

## The Efficient Frontier

For each player, the **efficient frontier** maps cash-on-hand to maximum achievable EPT across all possible development configurations of properties they currently own.

### What the Frontier Shows

At each cash level, the frontier answers: "What is my optimal allocation across everything I own?"

Key properties of the frontier curve:
- **Steep sections** = high-value investments (e.g., light blue 2→3 houses)
- **Flat sections** = capped position (no further investment moves the needle)
- **The flat section IS the information** — it tells you your ceiling and signals when to trade

### The Marginal EPT/Dollar Ranking

Development decisions should follow the marginal EPT per dollar invested, sorted across ALL monopolies a player holds. This produces a strict build order that often defies intuition:

**Example (Player with Browns + Light Blues, $800):**

| Investment | Cost | EPT+ | EPT/Dollar |
|---|---|---|---|
| LB 4h → Hotel | $150 | $21.60 | 0.144 |
| LB 3h → 4h | $150 | $19.68 | 0.131 |
| Brown 4h → Hotel | $100 | $9.68 | 0.097 |
| Brown 3h → 4h | $100 | $9.24 | 0.092 |
| Brown 2h → 3h | $100 | $7.92 | 0.079 |
| Brown 1h → 2h | $100 | $2.64 | 0.026 |
| Brown 0h → 1h | $100 | $0.79 | 0.008 |

Light blue dominates at every level. The optimal build order is: max out light blue first, then browns only with remaining cash. This is the **brown trap** — browns look cheap but their EPT/dollar is 18x worse than light blue hotels.

### The Brown Trap (Confirmed by Simulation)

Monte Carlo simulation (5000 games): a player holding browns + light blues wins **more often without browns** (61.8% vs 58.1%). Owning browns causes the AI to invest in them suboptimally, even with frontier-based development. The trap is that browns consume cash that would be better held as reserve or invested in light blue 4th houses/hotels.

## The Race Condition

The frontier alone is insufficient. What matters is not just "where can I get to" but "can I get there before my opponents reach their thresholds?"

### Three States

Each player is in one of three states at any moment:

1. **Growing faster than opponents** → Don't trade, develop
2. **Opponents catching up** → Trade to extend ceiling or accelerate
3. **Falling behind** → Trade now, even at cost, or die slowly

The frontier + growth rate tells each player which state they're in. This alone collapses the decision space from "evaluate all trade permutations" to "what moves me from state 3 to state 2, or state 2 to state 1?"

### The Death Spiral

When one player develops early (e.g., light blue at 3+ houses), they drain opponents' cash through rent, keeping opponents below their development thresholds, which keeps their EPT low, which means they can't fight back. The early developer's EPT advantage compounds — this is why light blues with sufficient cash can produce early-game knockouts even though their ceiling is low.

## Multi-Depth Frontiers

The depth-1 frontier (what can I build right now) can mislead. The depth-2+ frontier (what does this position lead to) reveals dead ends.

**Example:** Browns at 3 houses looks good on the depth-1 frontier — positive EPT movement, cheap to achieve. But depth-2 shows browns are a dead end: low ceiling, consumed cash, lost bargaining leverage, no path to a competitive position.

The true efficient frontier is the **envelope of the deepest reachable positions** — a tree of surfaces, not a single curve. The structural reduction gets *stronger* at depth because most paths collapse. The "structural truths" are:
- Certain color groups dominate others regardless of game state
- Certain cash thresholds must be reached to develop meaningfully
- Certain holdings are trade-dead-ends that no future opponent will help you upgrade from

## Properties as Liquidity Tools

**Key finding from simulation:** Incomplete monopoly pieces are often more valuable as cash-extraction tools than as properties to develop.

### The Evidence

Balanced 3-player scenario (equal NW ~$2120, orange split 3 ways):
- A: Pink monopoly + St. James, $1500
- B: LtBlue monopoly + Tennessee, $1620 (leader — cheap fast development)
- C: DkBlue monopoly + New York, $1170

**Baseline (no trades):** B wins 51.3% — light blue speed + cash dominance.

**C sells New York to B for $250:** C goes from 22.6% → 31.4%. C doesn't need orange — C needs cash to develop dark blue. The orange piece was worth more as a bargaining chip than as a property. B drops from 51.3% → 39.3% despite acquiring a property — B spent cash that was fueling their light blue advantage.

**A sells St. James to B for $350:** A goes from 26.1% → 36.5%. Same logic — A converts a useless orange piece into cash to push pinks further.

**A+C both sell to B (B completes orange!):** B drops from 51.3% → 36.6%. Even completing orange hurts B because the cash spent on acquisition exceeds the development benefit — orange at $100/house is slower than light blue at $50/house, and B's advantage was speed, not ceiling.

**Structural truth:** The frontier tool should identify that "your orange piece moves your frontier outward not by building orange, but by selling it to fund the monopoly you already have."

## Denial Value and Knockout Probability

Two concepts from the repo's research that the frontier framework subsumes but should name explicitly.

### Denial Value

A property's value isn't just what YOU can do with it — it's also what you prevent opponents from doing. The frontier captures this implicitly (your frontier includes the competitive landscape), but the concept deserves a name:

```
denialValue(property) = opponentFrontierWith(property) - opponentFrontierWithout(property)
```

The "properties as liquidity tools" finding above is denial value in action: holding a piece of an opponent's target set is worth more as leverage than as a development path. The frontier tool already accounts for this by computing post-trade subgraphs for ALL players, not just the traders.

### Knockout Probability

The frontier shows what EPT you can reach. But the game doesn't run to infinity — it ends when players go bankrupt. Against a cash-poor opponent, moderate EPT may be sufficient (they can't survive many rent hits). Against a cash-rich opponent, you need higher ceiling.

```
knockoutTurns ≈ opponentCash / myEPT
```

This connects directly to game horizon: if knockoutTurns is short, you're in a short-horizon game and speed (light blue) dominates. If knockoutTurns is long, ceiling (green/dark blue) matters. The frontier tool should weight development paths by whether they achieve knockout in the estimated horizon.

## Game Horizon and Strategy Selection

The game horizon determines which monopoly ceiling matters:

| Horizon | Dominant Strategy | Why |
|---|---|---|
| Short (low NW, early knockouts) | Light blue, cheap sets | Speed to 3 houses kills before opponents develop |
| Medium (properties bought, trades happen) | Orange/red | Best ROI at the typical trade-ready NW level |
| Long (patient players, late trades) | Green/yellow/dark blue | High ceiling eventually materializes |

The existing stubborn AI is calibrated to the medium horizon — which is why orange/red dominate its static valuations. It happens to be right *on average* because most games resolve at the medium horizon (the point where all properties are bought is roughly when orange/red hit their ROI sweet spot).

### Can You Control the Horizon?

Theoretically, a frontier AI could exploit the medium-horizon bias by:
1. Recognizing that green/yellow are undervalued by opponents using static valuations
2. Delaying trades to push the game horizon later (hoarding orange pieces to block opponents)
3. Acquiring green/yellow at a discount
4. Developing when the game has gone long enough for the ceiling to matter

**The practical problem:** this requires other players to cooperate with your timeline. The moment two opponents trade and someone gets orange at 3 houses, the game horizon snaps back to medium and the long-game strategy dies.

**Conclusion:** You can influence the horizon (by blocking trades, selling pieces strategically) but you can't control it. The frontier tool must adapt to the *actual* horizon, not try to force a preferred one.

## Empirical Validation (from repo simulations)

Tournament results from the Monopoly repo's simulation suite confirm the theory:

### Growth AI Tournament (2000-game round-robin)

| AI Type | Win Rate | Approach |
|---|---|---|
| **Growth** | **30.9%** | Models development timeline (S-curve), cash-after-trade NPV |
| NPV | 27.6% | Standard net present value, no development timing |
| Trading | 24.9% | Heuristic trade acceptance |
| NoTrade | 9.2% | Builds only, never trades |

**Key finding: conservative trades win.** The Growth AI demands 35% of the opponent's monopoly NPV as compensation when selling a completing piece. Being conservative outperforms being aggressive — matching the frontier theory's prediction that selling pieces to fund your own development beats cheap trades that enable opponents.

### Cash-After-Trade Is the Variable

The repo's most important empirical result:
```
Orange monopoly NPV by post-trade cash:
  $0 remaining:    NPV = $307    (can't develop!)
  $500 remaining:  NPV = $5,557  (slow development)
  $1000 remaining: NPV = $7,675  (fast development)
```

This validates the frontier concept: the curve IS the cash-to-EPT mapping, and a trade that leaves you cash-poor is worse than no trade at all — even if you acquire a "better" monopoly.

**Source:** [GROWTH-AI-SUMMARY.md](https://github.com/chrisaacson69/monopoly/blob/master/research/simulation/GROWTH-AI-SUMMARY.md), [valuation-notes.md](https://github.com/chrisaacson69/monopoly/blob/master/research/valuation-notes.md)

## Implementation Path

The frontier tool needs to answer three questions in order:

1. **What can I build right now?** — Development frontier (solved: EPT/dollar ranking across all owned monopolies)
2. **What can I realistically trade for?** — Achievable trades given other players' frontiers (filter theoretical trades by: does the counterparty gain? can I afford to develop the result?)
3. **What does the game horizon favor?** — Which ceiling matters given the pace of play (short/medium/long)

The structural reduction: most of the permutation space dies at step 1 (most investments are dominated), more dies at step 2 (most trades aren't achievable or beneficial for both sides), and step 3 is the strategic edge.

### Open Questions

- **Reserve algorithm:** The $150 fixed reserve in simulations is too crude. Reserve should be a function of opponent threat level (max rent exposure weighted by probability). A dynamic reserve would eliminate the false "brown trap" signal — browns ARE worth developing when you have excess cash and no threat.
- **Mortgage integration:** The existing AI handles mortgaging. The frontier tool needs to account for mortgage as a cash source (converting property equity to liquidity at 50% face value).
- **Frontier recomputation after trades:** When A trades with B, C's frontier shifts even though C wasn't involved. The tool needs to recompute all frontiers after each hypothetical trade.
- **The game-theoretic observation problem:** Murphy's critique of Weinstein applies here too — if a player knows they'll re-optimize next turn, they optimize differently today. Does the frontier calculation change if opponents know you're using it?

## The acceptor-underprices-the-externality pattern (added 2026-05-18)

This page covers **denial value** thoroughly — the blocker's value from preventing a trade that would create an opposing monopoly. The **symmetric form** hasn't been explicitly named here and is worth adding from the Catan trade-efficiency-paradox analysis ([[bilateral-trade-valuation]] §"asymmetric-externality reading").

### The pattern in Monopoly

Player A holds two Oranges. Player B holds the third Orange plus a Light Blue. Players C and D have unrelated holdings. A offers B a trade finalizing the Orange monopoly for A.

The current bilateral evaluator on this page asks: "is the trajectory-NPV of future-Orange for A worth more than what A is giving up?" and "does B come out ahead on trajectory terms?" If both yes, the trade clears.

**But the trade also catastrophically damages C and D.** A's Orange monopoly lands them in heavy-rent range repeatedly. C and D's win probability collapses. **The load-bearing point: B is also damaged** by:

1. A's monopoly directly raises A's win probability — bad for B
2. C and D being weakened accelerates A's dominance over the *remaining* opponents (B being one)
3. B's coalition options shrink — fewer viable allies to dogpile A with later

A 1:1 NPV-fair trade is **substantially underpriced** from B's correct perspective. B should be demanding cash + denial-tax + position-tax above the NPV-fair price.

### Engineering implication

The current bilateral simulator evaluates "does this trade improve my trajectory at least as much as theirs?" This is the symmetric form of "is the resource math fair?" extended to NPV. The next refinement is **N-body trajectory simulation:**

1. Compute trade's NPV impact on all four players, not just the trading pair
2. The acceptor's correct decision: does (my own gain) − (aggressor's gain × coupling) − (third-party damage that loops back through coalition imbalance) ≥ 0?
3. If yes, accept; if no, demand a position-tax until it does

```javascript
// Current bilateral check:
// myTrajectoryDelta >= theirTrajectoryDelta?

// N-body extension:
function tradeIsAcceptable(trade, me, them, others) {
  const myDelta = simulateMyTrajectory(trade, me, them);
  const theirDelta = simulateMyTrajectory(trade, them, me);
  // Cost of aggressor's gain to me: their win-share increase × coupling factor.
  const aggressorGainCostToMe = -theirDelta * couplingFactor(me, them);
  // Damage to third parties that loops back through coalition imbalance.
  const externalityFromOthers = others.reduce((sum, c) => {
    const cDelta = simulateMyTrajectory(trade, c, [me, them]);
    return sum + cDelta * couplingFactor(me, c);
  }, 0);
  return myDelta + aggressorGainCostToMe + externalityFromOthers >= 0;
}
```

This is more expensive (more sims per trade decision), but it's the correct shape. The current Monopoly AI **accepts trades too eagerly** — empirically documented in the bilateral page — and the N-body acceptor pricing is the structural fix that derives the right selectivity rather than tuning a multiplier (gap #6 in the bilateral page's frontier-derivation table).

### Generalizable

In any N≥3 game with bilateral trade and multi-player consequences, **the acceptor systematically underprices because they price on two-player math while the trade has three+-player effects.** Catan, Monopoly, Diplomacy alliance trades, M&A involving market consolidation — all instances of the same pattern. The bilateral-trade-valuation page is the canonical home; this page is the Monopoly-specific application.

## The Brown trap — EPT-per-dollar vs. game-impact-share

A specific empirical finding from the Monopoly project, sharpened 2026-05-18:

The Brown monopoly (Mediterranean + Baltic) is **cheap to acquire and cheap to develop**, and on a naive EPT-per-dollar metric it looks attractive. The "Open Questions" item above notes that the current reserve algorithm gives a "false brown trap signal" — saying don't develop browns when actually browns are EPT-efficient per dollar.

**The deeper truth is that the trap is real, the model just hasn't captured the right metric.** Browns:
- Generate small absolute EPT (even fully built, the rents are modest)
- Don't apply meaningful pressure to opponents (low landing rent → no real position threat)
- Don't drain opponent reserves (no jail-rent terror)
- Don't enable strategic blocks (Brown spaces aren't on high-traffic paths)

So a player who spends 3 random properties + cash to acquire Browns from the global frontier looks like they moved up the EPT curve — but they spent their available trade capital on a monopoly that **doesn't translate into wins**. The 50-game Catan analog is the [unleveraged-port finding](../catan-50-games-validation.md#port-leverage-finding): 2:1 ports with low matching production yielded *half-baseline* win rates. Same pattern: capability-with-no-leverage is worse than no capability, because you've spent the acquisition cost on something that doesn't pay back. **The portable thesis is now [Capability Without Leverage](../capability-without-leverage.md)** — this brown trap is its Monopoly specimen (failure mode A: intrinsically low-impact).

**The right metric isn't EPT-per-dollar; it's game-impact-share** — how much does this acquisition shift the leaderboard? Browns are EPT-efficient and impact-inefficient. The frontier construction is *correct* in identifying them as Pareto-improvements; the **counterparty-modeling layer** and the **game-impact filter** are the missing pieces that would tell you to skip them in favor of higher-impact monopolies that are also reachable.

This sharpens what the frontier tool needs in its next generation: not just "reachable Pareto-optimal positions" but "reachable Pareto-optimal positions filtered by impact-share." See also the [Catan analog for capability-without-leverage](../catan-50-games-validation.md#port-leverage-finding).

## Frontier reduces but doesn't eliminate — the choice-among-improvements problem

A subtle limitation of the frontier construction worth naming explicitly: from your current fragment, **many** trades are frontier-improving. Trading 3 random properties for Light Blue is better than your starting position; so is trading for Purples, Oranges, Reds, or Yellows. The frontier filters out the dominated set (e.g., the Brown trap above), but it leaves multiple non-dominated paths. **Which one do you actually pursue?**

The choice-among-improvements layer requires:

1. **Target EPT** (frontier-visible) — what's the destination worth?
2. **Acquisition feasibility** (counterparty-modeled, not solved) — will any counterparty actually agree to this trade chain?
3. **Information cost** (sequencing-modeled, not solved) — what does revealing this strategy cost in subsequent trade prices?
4. **Game-impact share** (related to the Brown trap above) — does this destination actually shift the leaderboard?

The frontier construction handles row 1 cleanly. The other three rows are why "frontier identifies the destination, but the transfer problem is hard" is the right summary. **You can have a perfect frontier and still pick the wrong trade because you misjudged the counterparty's veto, leaked information that raised the next trade's price, or aimed at an impact-inefficient destination.**

This is what makes Monopoly trade play hard at the expert level: the frontier is the *easy* part. Strong play differentiates on the other three rows.

## Multi-counterparty trade sequences and information cascade

Real-game Monopoly trades aren't 1-on-1 in isolation. The player executing a strategy is typically running a **trade sequence with 3 different counterparties**, and **each trade leaks information to the others** about what you're going for. Concrete sequence pattern:

1. **Trade A:** offer Counterparty 1 something cheap to get a property on your target chain
2. **Trade B:** offer Counterparty 2 a second property for the next piece — but C2 has now seen Trade A and can infer your target monopoly. C2's price goes up.
3. **Trade C:** offer Counterparty 3 the final piece — by now your strategy is obvious. C3 charges the maximum extraction price, or refuses to trade because they understand the [acceptor-underpricing externality](../bilateral-trade-valuation.md#the-asymmetric-externality-reading-of-the-trade-efficiency-paradox).

The information cascade is a real cost. A trade sequence that looks frontier-optimal in isolation can become **infeasible at later steps** because the early steps revealed too much. Strong play orders trades to *minimize information leakage* — for example, putting the high-cost / hard-to-disguise trade *first* (when counterparties haven't yet inferred the plan), or executing two trades simultaneously through a single offer (denying counterparties the chance to update between trades).

This is a Monopoly-specific manifestation of a general principle in negotiation theory: **your moves are signals, and signal cost is part of the trade cost.** Vault has the related [Keynesian-beauty-contest framing](../catan-47k-empirical.md#common-knowledge-competition--the-counter-positioning-move) on the Catan page — same dynamic, different game. Worth naming on this page so it's discoverable from the Monopoly-trade thread.

**Engineering implication:** trade evaluation can't be per-trade only. The AI needs to evaluate **trade sequences** with information-leakage costs across the sequence. Currently the vault's [subgraph-trade-engine-spec](./subgraph-investment-optimization.md) handles 3-way cycles but doesn't explicitly model information cost. That's another open layer of the transfer problem.

**Live-agent validation:** the whole frontier/bilateral stack is empirically tested against real LLM play in [LLM Agents Across Strategic Games](../llm-agents-across-games.md) — which documents where the models' actual mistakes (action bias, no mechanical model) line up with the gaps named here. (Previously this page was linked *from* there one-way; this is the reciprocal.)

## Tags
[game-ai](../../../tags/game-ai.md), [economics](../../../tags/economics.md), [game-theory](../../../tags/game-theory.md), [strategy](../../../tags/strategy.md)
