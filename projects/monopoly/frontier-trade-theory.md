# Efficient Frontier Trade Theory
> Using EPT frontier curves to solve the 3+ player trade valuation problem — reducing the permutation space through structural truths about development velocity and game horizon.

**Status:** active — theory phase
**Created:** 2026-03-15
**Links:** [Monopoly](./README.md), [The Multiplayer Coalition Problem](../../research/gaming/multiplayer-coalition-problem.md), [Nash Bargaining Problem](../../research/gaming/nash-bargaining-problem.md), [Bilateral Trade Valuation](../../research/gaming/bilateral-trade-valuation.md)

## The Problem

Bilateral trade valuation is solved (trajectory-based, accounts for competitive feedback). The 3+ player trade problem remains open: how to value trades in a multiplayer environment where each trade reshapes every player's competitive landscape.

The brute-force approach (evaluate all permutations) is intractable. The frontier approach reduces the decision space by identifying structural truths that eliminate most options before evaluation begins.

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

## Tags
[game-ai](../../tags/game-ai.md), [economics](../../tags/economics.md), [game-theory](../../tags/game-theory.md), [strategy](../../tags/strategy.md)
