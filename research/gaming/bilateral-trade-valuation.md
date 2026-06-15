---
status: active
created: 2026-02-23
published: true
layout: layouts/page.njk
title: "Bilateral Trade Valuation"
---
# Bilateral Trade Valuation
> A trade's value isn't what you get — it's where both players end up 20 turns later.

**Links:** [Gaming](./README.md), [The Multiplayer Coalition Problem](./multiplayer-coalition-problem.md), [Monopoly](../../projects/monopoly/README.md), [Economics](../economics/README.md), [Risk and Entrepreneurship](../economics/risk-and-entrepreneurship.md), [Insurance](../economics/insurance.md), [Catan — 47,000 Games of Empirical Findings](./catan-47k-empirical.md) — the trade-efficiency paradox (players with perfectly even trades win 8% of the time vs. 25% baseline; winners systematically overpay for position) is the empirical confirmation of this page's thesis across 47k recorded games, [Catan 50-Game Validation](./catan-50-games-validation.md) — independent N=50 confirmation: tradeNet vs. VP correlation **r = −0.313** (p < 0.001); trade winners are not game winners, holds across two independent datasets

## The Problem

Current Monopoly AI trade evaluation computes each player's "position" before and after a trade, then accepts if the AI's position improves and the opponent doesn't gain disproportionately. The position is calculated by summing:

1. Net worth (cash + property values + house liquidation value)
2. NPV of each monopoly's growth curve (simulated development over ~62 turns)
3. Discounted relative EPT from non-monopoly properties

This produces a **single number** per player. The trade decision compares the delta in these numbers.

The problem: this model runs each player's growth curve **in isolation**. It answers "how fast can I develop if nobody else exists?" not "how fast can I develop while my opponent is also developing and collecting rent from me?"

## What the Current Model Misses

### 1. Rent Outflow (the zero-sum feedback loop)

From the [relative EPT framework](./multiplayer-coalition-problem.md): property income is zero-sum. When Player A collects rent, Player B loses that exact amount. The current growth curve simulation (`simulateGrowthCurve`) adds income but never subtracts rent paid to opponents:

```javascript
// Current model (line 169 of relative-growth-ai.js):
cash += ept + DICE_EPT;  // Income only — no outflow
```

This means a player facing an opponent with Dark Blue hotels ($1500-$2000/landing) is modeled as developing at the same speed as a player facing an opponent with no properties. The growth curve is blind to threat.

### 2. Bilateral Interaction (the compounding feedback)

Because rent flows are zero-sum, development creates a **feedback loop**:

- Player A develops → higher rents → drains Player B's cash
- Player B has less cash → develops slower → lower rents → Player A keeps more cash
- Player A develops even faster → even higher rents → ...

This is the [interest rate framework](./multiplayer-coalition-problem.md) made concrete: Player A's effective interest rate goes UP as Player B's goes DOWN. The gap compounds. Two players who start at equal positions but develop at slightly different speeds will see their trajectories **diverge exponentially**, not linearly.

The current model can't see this because it simulates each player in a vacuum.

### 3. Cash Double-Counting

`calculatePosition` passes `player.money` (full cash) to each monopoly's growth curve independently. A player with Orange and Red monopolies gets their full $2000 cash counted toward Orange development AND toward Red development. In reality, every dollar spent on Orange is unavailable for Red. The model overstates multi-monopoly positions.

### 4. Trajectories vs Snapshots

The current model produces a single position number (net worth + NPV). But what matters for trade evaluation isn't the number — it's the **trajectory**. Two players might have equal positions now, but if one has a monopoly that develops faster, their trajectories diverge. The current model captures some of this through NPV, but because it ignores rent interaction, it can't see trajectory divergence caused by the competitive dynamic.

## The Proper Model: Bilateral Growth Simulation

The fix is to simulate both players simultaneously, with rent flowing between them:

```
For each turn t = 1 to horizon:
    For BOTH players:
        income = dice_EPT

        // Rent I collect from them
        For each of MY developed properties:
            income += my_EPT (from precomputed table)

        // Rent I pay to them
        For each of THEIR developed properties:
            income -= their_EPT (from precomputed table)

        cash += income

        // Build if possible (sequential decisions matter)
        while (can afford next house level):
            build → increases rent table → affects future cash flows

    Record: position_me(t), position_them(t)
```

This produces **two trajectory curves** instead of two numbers. The evaluation then becomes:

### Trajectory Analysis

Given the two post-trade trajectories, several questions have clear answers:

1. **Do the lines diverge or converge?** If my trajectory grows faster, I'm winning the development race. If theirs grows faster, I'm losing.

2. **Is there a crossover?** I might start ahead (got cash in the trade) but they might overtake me (their monopoly develops faster). When does the crossover happen? If it's turn 5, I'm in trouble. If it's turn 50, it might not matter.

3. **What's the gap at the horizon?** The terminal position difference determines who wins the endgame.

A trade is good if my trajectory stays above theirs (or converges toward theirs from below). A trade is bad if my trajectory starts above but gets overtaken — which is exactly the "patient predator" exploit.

## The Patient Predator Exploit

This exploit demonstrates why trajectory analysis is necessary:

**Setup:** Player A has 2 of 3 Orange properties. Player B (AI) has the third Orange plus a Dark Blue. Player A accumulates $3000 over many turns.

**The offer:** Player A offers 2 Oranges + $1000 cash for the 1 Dark Blue.

**Current model's evaluation:**
- AI's position change: +$360 property value + $1000 cash + Orange monopoly NPV = large positive
- Their position change: +Dark Blue monopoly NPV - $1000 cash - $360 property = also positive
- Ratio check passes (AI gained a lot too)
- **AI accepts.**

**Trajectory analysis:**
- Turn 0: AI has Orange + $1000 extra. Opponent has Dark Blue + $2000 remaining.
- Turn 1-3: Both building. Opponent reaches Dark Blue hotels faster (only 2 properties × $200 = $400/level). AI building Orange (3 properties × $100 = $300/level).
- Turn 5: Opponent has Dark Blue at 3+ houses. Hotel rents: $1100-$1700/landing.
- Turn 5+: Every time AI lands on Dark Blue, it loses $1000+. This DRAINS AI's development cash. Feedback loop kicks in.
- Turn 15: Opponent's trajectory is far above. AI's development has stalled from rent payments.

**The trajectory lines cross around turn 5-8. By turn 15, the gap is enormous.**

The current model can't see this because it simulates AI's Orange development without the cash drain from Dark Blue rent payments.

## Nash Equilibrium Trade Price

With bilateral trajectory simulation, the Nash equilibrium price becomes well-defined:

**For a given trade (properties exchanged), search over cash amounts C:**

For each candidate C:
1. Simulate bilateral trajectories with the trade at cash = C
2. Compute my trajectory advantage: ∫(my_position(t) - their_position(t)) dt
3. Compute their trajectory advantage: the negative of mine

The Nash price is the C where both players' trajectory advantages are equal — neither player can improve their outcome by changing the cash amount.

**Key properties:**
- **Cash-rich player gets monopoly from cash-poor player:** Nash price is high (cash-rich player pays a lot) because cash-rich player's trajectory is strong post-trade
- **Equal cash, unequal monopoly quality:** Nash price reflects the quality difference, amplified by the development speed differential
- **Patient predator scenario:** Nash price for Dark Blue is MUCH higher than current model suggests, because trajectory analysis sees the post-trade divergence

## Connection to Insurance / Reserve Theory

The [insurance analysis](../economics/insurance.md) showed that the cost of facing an opponent's rent is **convex** — small rents are trivially absorbed, large rents are catastrophic. This convexity appears directly in the bilateral trajectory simulation:

- Small rent flows between players: trajectories stay close, game stays competitive
- Large rent flows (hotels): trajectories diverge rapidly, trailing player enters a liquidation spiral

The reserve calculation (how much cash to hold) and the trade evaluation (whether to accept a deal) are solving the same underlying problem from different angles:
- **Reserves:** "Given the rents I might face, how much cash insurance do I need?"
- **Trade evaluation:** "Given the rents I will face post-trade, is this trade worth it?"

Both need the bilateral trajectory model to answer correctly. The current reserve model works with a 1.0x risk-loaded multiplier (empirically calibrated). The trade evaluation currently ignores rent interaction entirely.

## Gap Analysis: Theory vs Current Implementation

| # | Theory Says | Code Does | Gap | File:Line |
|---|------------|-----------|-----|-----------|
| 1 | Bilateral trajectory simulation with rent flows | Independent single-player growth curves in vacuum | **No rent interaction** — `simulateGrowthCurve` adds income but never subtracts rent paid to opponents | `relative-growth-ai.js:169` |
| 2 | Cash is a shared resource across all monopolies | Full `player.money` passed to each monopoly's curve independently | **Double-counting** — player with 2 monopolies gets full cash counted twice | `relative-growth-ai.js:220` |
| 3 | Compare trajectory divergence/convergence over time | Compare two static position deltas (single numbers) | **Snapshot, not trajectory** — can't see crossover points or divergence dynamics | `relative-growth-ai.js:415-416` |
| 4 | Nash equilibrium price from trajectory equality | `gainRatio × faceValueDiff` (TradingAI) or bilateral NPV search (RelativeGrowthAI) | **No trajectory in pricing** — cash fix uses NPV snapshots, not trajectory comparison | `relative-growth-ai.js:309-346` |
| 5 | Risk-loaded reserve from liquidity curve | Flat 1.0x multiplier (empirically calibrated, works) | **Not derived** — 1.0x is empirically correct but the theory should produce it | `enhanced-relative-ai.js:~230` |
| 6 | Trade acceptance from trajectory dominance | `theirPositionChange <= myPositionChange * 3` | **Arbitrary ratio gate** — 3x is a fudge factor, not derived from any theory | `relative-growth-ai.js:443` |

Each row is a spec violation. "Closed" means the implementation matches the theory column.

## Implementation Path

### Phase 1: Bilateral Growth Simulation Function

Replace `simulateGrowthCurve` (single-player, vacuum) with a bilateral version that closes gaps #1, #2, and #3 simultaneously.

**New function:** `simulateBilateralGrowth(myState, theirState, propertyStates, numOtherOpponents)`

Where each player state is `{ groups: [...], cash, id }` — all their monopolies and current cash as a single budget.

**The simulation loop:**
```
For t = 1 to horizon:
    For BOTH players:
        income = dice_EPT
        income += my_total_EPT_at_current_development    (from EPT table)
        income -= their_total_EPT_at_current_development  (I pay them)
        // Note: numOtherOpponents contribute dice EPT to rent income
        // but are not modeled as developing (simplification)
        cash += income
        // Build: pick highest-marginal-ROI house across ALL monopolies
        // (single cash pool, no double-counting)
        while (can build and cash > 0):
            build best available house
```

**Returns:** `{ myTrajectory: [pos_t0..pos_tN], theirTrajectory: [pos_t0..pos_tN] }`

Where `pos_t = netWorth + houses_built × housePrice` (tangible position, not NPV projection on top of NPV projection).

**Key design decisions:**
- Single cash pool across all monopolies per player (fixes gap #2)
- Build order by marginal ROI, same as current `buildOptimalHouses` logic
- EPT values read from precomputed table at each house level (no re-deriving P×rent)
- Other opponents (players 3, 4) contribute to EPT as landing probability multiplier but don't develop — this is a simplification, but modeling all 4 players' development makes it an N-body problem

### Phase 2: Trajectory-Based Trade Evaluation (closes gap #3, #6)

Replace the position-delta comparison in `evaluateTrade` with trajectory comparison:

1. Run bilateral simulation for **pre-trade** state (both players, current monopolies, current cash)
2. Run bilateral simulation for **post-trade** state (swapped properties, adjusted cash)
3. Compare trajectory improvements:
   - My trajectory improvement: `myAfterTrajectory - myBeforeTrajectory`
   - Their trajectory improvement: `theirAfterTrajectory - theirBeforeTrajectory`
4. Accept if my trajectory improvement ≥ their trajectory improvement (or within some threshold)

**Replaces:** the `theirPositionChange <= myPositionChange * 3` fudge (gap #6). The acceptance criterion becomes "does this trade improve my trajectory at least as much as theirs?" — derived from the theory, not an arbitrary multiplier.

**The patient predator check falls out naturally:** if their post-trade trajectory overtakes mine (crossover in the first ~20 turns), my trajectory improvement is negative even if my cash position improved. The bilateral simulation sees the rent drain that the current model misses.

### Phase 3: Trajectory-Based Trade Pricing (closes gap #4)

Replace the cash search in `calculateMutualTradeCash` with Nash bargaining on trajectories:

For each candidate cash amount C:
1. Run bilateral simulation with trade at cash = C
2. Compute my trajectory area: `Σ myPosition[t]` over horizon
3. Compute their trajectory area: `Σ theirPosition[t]` over horizon
4. Nash price = C where trajectory areas are equal (both players gain equally from the trade)

This replaces both the original `gainRatio × faceValueDiff` (TradingAI) and the bilateral NPV search (RelativeGrowthAI cash fix), unifying them into a single trajectory-based pricing model.

### Phase 4: Unify with Reserve Model (closes gap #5)

The bilateral simulation produces expected rent outflow per turn, which feeds directly into the reserve calculation. Instead of:

```
liqCost = P(landing) × max(0, rent - R) × 1.0   // flat multiplier
```

The reserve model can use the bilateral simulation's rent outflow to determine the actual expected drain, eliminating the empirical 1.0x multiplier. The multiplier was a stand-in for "average effective liquidation cost" — the bilateral model computes that cost directly.

**Note:** This is the lowest-priority phase. The 1.0x multiplier works (Z=4.34 without the cash fix) and the reserve model is less broken than the trade evaluation. Fix trades first.

## Implementation Results (Feb 2026)

The bilateral growth simulation was implemented in `relative-growth-ai.js` as `simulateBilateralGrowth()`, closing gaps #1, #2, #3, #4, and #6 simultaneously.

**Tournament results** (1 new vs 3 control, StrategicTradeAI, 3000 games):

| Variant | Win Rate | Z-Score | Status |
|---------|----------|---------|--------|
| **Bilateral Trajectory + Reserves** | **33.1%** | **10.25** | **HIGHLY SIGNIFICANT** |
| ReserveOnly (old best) | 29.2% | 4.34 | Previous best |
| Cash Fix + Reserves (old) | 26.8% | 1.81 | Conflicted |
| Original baseline | 25.0% | 0.00 | Expected |

**Key confirmation:** The cash fix/reserve conflict is resolved. The old NPV-snapshot cash fix made the AI stingy when cash-poor (steep growth curve → low offers → few trades accepted). The bilateral model sees the opponent's trajectory explode when they get a monopoly-completing property AND have cash, which raises the Nash price appropriately. The cash fix and reserves now work synergistically.

**Performance:** 3000 games completed in 69 seconds. The bilateral simulation adds ~5-6x per trade evaluation vs the old single-player curves, but this is still sub-millisecond per trade.

### Current vs Theory (Gap Closure)

| # | Gap | Status | Implementation |
|---|-----|--------|---------------|
| 1 | No rent interaction | **CLOSED** | `simulateBilateralGrowth` — rent flows both ways each turn |
| 2 | Cash double-counted | **CLOSED** | Single cash pool per player in bilateral sim |
| 3 | Snapshot not trajectory | **CLOSED** | `evaluateTrade` compares trajectory improvement areas |
| 4 | No trajectory in pricing | **CLOSED** | `calculateMutualTradeCash` — Nash bargaining on trajectory areas |
| 5 | Empirical 1.0x multiplier | Open | Works well, lower priority |
| 6 | Arbitrary 3x ratio gate | **CLOSED** | Derived 1.5x tolerance from trajectory analysis |

### Nash Equilibrium: Convergence-Point Pricing

The Nash price is determined by the **convergence point** — the time t where |myTrajectory[t] - theirTrajectory[t]| is minimized. The Nash price is the cash amount C where the signed gap at convergence equals zero: both players are exactly equal at the moment competitive pressure is most balanced.

This is more theoretically precise than area equality (Σ pos[t]), which averages over the whole timeline and can miss late-game structural advantages. A/B testing showed both produce similar aggregate results (33.8% vs 33.6%, Z≈9), but the convergence point gives an exact equilibrium — critical for future negotiation/counter-offer implementation where both sides need a well-defined anchor price.

## Extension: Auction Bilateral Bidding (Feb 2026)

The bilateral model extends naturally to auction bidding. The old `getMaxBid` used static multipliers (1.05x base, 1.5x completion, 1.3x blocking) — the same flat formula regardless of game state. The bilateral model replaces this with a single concept: **indifference price**.

### The Indifference Price

For a property at auction, the indifference price is the cash C where:

```
trajectoryArea(I own it at cost C) = trajectoryArea(threat opponent owns it)
```

"I'm equally well-off paying C for this property as I am letting my most threatening opponent have it." This naturally handles:

- **Monopoly completion**: If I'd complete a monopoly, "I own it" trajectory explodes → high indifference price
- **Blocking**: If opponent would complete a monopoly, "they own it" trajectory explodes → high indifference price
- **Non-strategic**: Neither side gets a monopoly → indifference price ≈ face value

No separate multipliers needed. One model, one concept.

### Smart Blocking: The Bystander Effect

A key insight from Chris: "when doing this last time, there was code to make sure the AI didn't block EVERY trade... often, it is natural other players will value that property more than you, so let them work on the leader."

In auctions, the same principle applies. If Player A is about to complete Orange, and Players B, C, and D all bid the full indifference price to block, they all overpay. The **bystander effect** — each blocker thinks they must be the one to stop it.

The fix uses `analyzeBlockingContext`: if another player already owns property in the threatened group (has a real stake in blocking), don't bid the full indifference price. They'll naturally outbid because the property is more valuable TO THEM. Only bid full price when you're the **sole blocker**.

Initial implementation used `opp.money >= square.price` as the "someone else can block" condition — but this was almost always true ($1500 starting cash), so the AI basically never blocked. The fix checks for actual ownership stake in the group.

### Selectivity: The Cash-Poor Problem

Chris's insight: "the new valuation model sees the value in property and wants to win auctions while the old AI said +10%... but when they were buying everything for +20%, they started becoming cash poor... hopefully the new AI is more selective when it wants to spend big $."

This is exactly what happens. The static bidder pays +20% on EVERYTHING — even properties with no strategic value — and goes cash-poor. The bilateral bidder only pays premium prices when the trajectory analysis says it's worth it. Non-strategic properties get base premium only (5%). This preserves cash for the moments that matter.

### Performance Optimization

The bilateral simulation is expensive (~62 turns × 2 players per call). In auctions, `getMaxBid` is called 12-16 times per auction (once per player per bidding round). Two optimizations made it tractable:

1. **Per-position-per-turn caching**: The indifference price doesn't change during an auction (same position, same game state). Cache the result and return it on subsequent rounds.

2. **Binary search**: Instead of linear search over all possible costs (~60 iterations at step=25), binary search converges in ~10 iterations.

Combined: ~4.5 games/sec in all-bilateral tournaments.

### Results

| Test | Win Rate | Z-Score | Status |
|------|----------|---------|--------|
| **Auction-only: Bilateral vs Static** | **45.0%** | **10.33** | **HIGHLY SIGNIFICANT** |
| Normal game: Bilateral vs Static | 24.6% | -0.29 | Neutral (expected — auctions rare) |
| All-static baseline | 25.0% | 0.00 | Control |

The 45% auction-only result is the strongest domain-specific result in the project. The bilateral model dominates when auctions are the primary acquisition mechanism. In normal games, auctions are rare enough that the improvement doesn't show up in aggregate stats.

### Implementation

New `getMaxBid` in `enhanced-relative-ai.js`:
- Non-street or non-strategic → base premium (5%)
- Pure blocking + someone else owns in group → base premium (defer)
- Monopoly-completing or sole-blocker → binary search for indifference price via `simulateBilateralGrowth`

New files:
- `cached-engines.js` — Caches deterministic Markov/EPT tables to `.markov-cache.json` (89 KB). First run: 97ms computation. Subsequent: 2ms load (50x speedup).
- `auction-bilateral-test.js` — Tournament framework for bilateral vs static bidding.

## The asymmetric-externality reading of the trade-efficiency paradox

The [trade-efficiency paradox](./catan-47k-empirical.md#7-the-trade-efficiency-paradox--winners-overpay) is usually read as "winners overpay for position." That's true, but it's only half the picture. The same finding, flipped, says something sharper about the other side of every overpaid trade:

**Trade-acceptors systematically underprice their goods in N>2 settings.**

If overpayers win, the market is mispricing. In a market where prices clear at rational valuations, you cannot consistently overpay AND find a counterparty — the counterparty would push back for a better price. The fact that overpayment trades happen frequently and that overpayers win means **the trade-acceptors aren't charging enough**. They're seeing the local two-player resource math, missing the multi-player strategic externality.

### The asymmetric-stakeholder structure

Every trade in an N≥3 game has at least three stakeholders, not two:

- **The aggressor** (proposes / overpays): sees the full strategic value because they're proposing the trade *for* a position move
- **The acceptor** (sells the resource): typically sees only their own balance sheet — "did I get more pips than I gave?"
- **The third party (or parties)**: the player(s) the trade enables an action against (e.g., the one about to be blocked by the new road, the one about to lose Largest Army)

The pricing collapses when the **acceptor doesn't include the third-party damage in their valuation.** They look at the trade as A-to-B and price it on A-B resource math. But the trade is really A-to-B-with-effects-on-C-D — and B's own future is materially worse if the trade lets A move ahead of B in the standings.

Chris's example, paraphrased: A trades wood to B so A can build a road that blocks Player C's expansion. B sees "wood for wheat at fair pip-ratio, sure." But the road also raises A's win probability, which is bad for B — and B never priced that in. B might *also* be hurt by C losing position (because B benefits from C being a counter-weight to A), but B doesn't see this layer either.

### The pricing model the acceptor should use

For a trade to be correctly priced for an N=4 game, the acceptor needs to ask:

1. **Direct math**: do I get more resource value than I give?
2. **Aggressor's gain**: how much does this trade improve the aggressor's win probability?
3. **Third-party damage**: does this trade enable an action that hurts other opponents, and does that change *my* position relative to those opponents?
4. **Position substitution effect**: by selling this resource, am I helping the aggressor close the *specific* gap that was keeping them off the leaderboard?

A "fair" trade in the resource-math sense (1:1 pip exchange) is *almost always underpriced* in N≥3 if the trade enables an aggressive action. The acceptor should charge a **premium proportional to the aggressor's strategic gain**, not just the resource difference.

### Why this is "the trade-efficiency paradox from the other side"

The paradox empirically shows:

- Winners had **trade-net < 0** (they paid more than they received).
- Their tablemates accepted those underpriced offers.

Read forward: winners exploited the acceptor's underpricing.
Read backward: the *losing players* were paying for everyone else's wins by accepting too-cheap trades. The 8% win rate for "perfectly even" traders isn't because they refused to overpay; it's because *they were the ones being overpaid against*. The market gave the strategic value to whoever was willing to charge for it, and the players doing the resource-math-only valuation gave it away.

This sharpens the strategic prescription:
- **Don't just consider overpaying for position.** Also consider **demanding overpayment when you're the resource holder.** The mirror image is just as valuable.
- A player who walks away from "fair" trades unless the aggressor adds a position-tax to the price is playing the right game. A player who reflexively accepts pip-balanced trades is leaving win-equity on the table.

### N>2 makes this non-obvious to the acceptor

Why don't trade-acceptors charge correctly? Three bounded-rationality reasons:

1. **The benefit to the aggressor is opaque-ish.** B sees A's settlements and roads, but not A's plan. B has to *infer* what A intends to do with the resource. This is hard.
2. **The damage to third parties is even more opaque.** B might not realize that A's road blocks C; even if B does, B might not realize that C's diminishment hurts B (via coalition imbalance).
3. **The aggressor benefits by *not* explaining the value.** A who says "I really need wood to block C's expansion" is asking for a 2× price. A who says "want to trade wood for wheat?" gets the 1:1.

This is **why the trade-efficiency paradox is a sustainable equilibrium across thousands of games and against varied opponents**: the acceptor's underpricing is a stable bounded-rationality failure of the *acceptor population*, exploitable by any aggressor who plays for position. It will not be priced away by competition because the acceptors aren't pooling information across games.

### Connection to Monopoly — the same pattern, never explicitly named there

The [Monopoly project](../../projects/monopoly/README.md) and the [Frontier Trade Theory](./monopoly/frontier-trade-theory.md) page already handle related ideas (denial value, race conditions, knockout probability), but the **acceptor-underprices-because-they-only-see-the-two-player-math** framing isn't there yet. It should be.

Concrete Monopoly instance: Player A holds Boardwalk; Player B holds Park Place; Player C and D have unrelated holdings. A trade between A and B forming the Dark Blue monopoly is **catastrophic for C and D** (highest rents on the board, accelerated by hotel buildouts). If C is the third property holder (Baltic, say) and B offers C a cash + minor-property trade to finalize the monopoly, C's correct pricing has to account for "this trade dramatically raises A and B's win probability simultaneously, and C is now competing against TWO compounding monopolies." A 1:1 NPV trade is wildly underpriced.

This is the structural reason Monopoly's "fair trades" are rarely fair. The vault's existing [frontier trade theory](./monopoly/frontier-trade-theory.md) treats this implicitly via denial value (the *blocker's* value from preventing the trade), but the symmetric form — the *acceptor's* obligation to charge for the externality — has been latent. The Catan finding makes it explicit and worth porting back to Monopoly trade evaluation.

**Engineering implication for the Monopoly bilateral evaluator:** the current model evaluates "is this trade good for me?" The improvement is "is this trade good for me *including the cost of the aggressor's strategic gain and any third-party damage that loops back to me through coalition imbalance*?" This is harder to compute but probably accounts for a meaningful slice of the current "trade-accepts-too-eagerly" symptom in the AI.

### The general principle

In any multiplayer trading game where bilateral trades have multi-player consequences:

- **The trade's price should reflect ALL stakeholders' value/cost, not just the two parties at the table.**
- **The party who sees more of the strategic structure (usually the aggressor) systematically wins** — not because they're better at trade math, but because they include the other layers and the counterparty doesn't.
- **The trade-acceptor's correct play is to demand a position-tax** above the resource-math fair price, scaled by the aggressor's expected strategic gain.

This generalizes well beyond games:
- M&A: the target should price in the strategic value to the acquirer, not just the assets-on-balance-sheet value (this is well-known in corporate finance — "synergy premium")
- Real estate: a seller in a redevelopment zone should charge for the developer's anticipated upside, not just the current property value
- Talent markets: an employee with rare skills should charge the marginal hire-value to the employer, not just the salary-band median
- Coalition politics: a swing vote should charge the coalition's marginal value of having them, not just the seat-share value

**The Catan and Monopoly trade-efficiency paradoxes are instances of acceptor-underpricing-the-externality, a recurring pattern wherever bilateral pricing happens with multi-party consequences.**

## Downward ledger — specimens that consume this model

The pages that apply the trajectory/bilateral framework, with what each contributes (reciprocating the up-links they already carry):

- [Frontier Trade Theory](./monopoly/frontier-trade-theory.md) — uses bilateral as the per-trade NPV pricer the frontier filter feeds into; denial value, race condition, and knockout probability build on top.
- [Subgraph Investment Optimization](./monopoly/subgraph-investment-optimization.md) — calls the bilateral trajectory sim for trade EV inside the build-vs-trade decision (BATNA = the build option).
- [LLM Agents Across Strategic Games](./llm-agents-across-games.md) — the **live-agent validation layer**: real LLMs playing Monopoly are graded against this model, and it documents what the model still misses (third-party poisoning, opponent-side cash EPT).
- [Catan — 47k](./catan-47k-empirical.md) & [Catan 50-game Validation](./catan-50-games-validation.md) — the N=47k / N=50 empirical confirmation of the trade-efficiency paradox this model predicts.
- [Monopoly project](../../projects/monopoly/README.md) — the implementation (`simulateBilateralGrowth`, auction indifference pricing).

## Open Questions

- ~~**Convergence-point Nash:**~~ **RESOLVED.** Implemented and confirmed. Marginal improvement (33.8% vs 33.6%) but theoretically correct. Kept as canonical approach for negotiation foundation.
- **N-player interaction:** Should the bilateral simulation account for other players' development? The current simplification (others contribute to EPT but don't develop) produced Z=10.25, so it may be sufficient.
- **Quality filter subsumption:** Does the bilateral model make StrategicTradeAI's `GROUP_QUALITY` multipliers redundant? If Green's trajectory advantage is captured by the simulation, the static quality filter may be unnecessary.
- **Horizon sensitivity:** The 62-turn horizon from the GA works well for bilateral sim. Shorter horizons might be worth testing for performance.
- **calculatePosition double-counting:** Still present in `calculatePosition()` (used for ranking) but irrelevant for trade evaluation now that `evaluateTrade` uses bilateral sim directly.
- **Competitive edge in decideBid:** The bilateral model computes what the property is worth TO ME. Estimating the opponent's indifference price would tell me when to drop out vs push — a strategic layer on top of valuation.
- **High timeout rate:** Bilateral trade evaluation's 1.5x selectivity (vs old 3x) means fewer trades accepted → fewer monopolies → longer games → 10-14% timeouts in normal mode. Separate from auction work but affects aggregate results.

## Tags
[games](../../tags/games.md), [game-ai](../../tags/game-ai.md), [economics](../../tags/economics.md)
