# Subgraph Trade Engine — Implementation Spec
> Combining the build frontier with subgraph-driven trade search to create a complete Monopoly decision engine.

**Status:** spec — not yet implemented
**Created:** 2026-03-19
**Links:** [Monopoly](../../../projects/monopoly/README.md), [Frontier Trade Theory](./frontier-trade-theory.md), [Subgraph Investment Optimization](./subgraph-investment-optimization.md), [Bilateral Trade Valuation](../bilateral-trade-valuation.md), [Nash Bargaining Problem](../nash-bargaining-problem.md), [Multiplayer Coalition Problem](../multiplayer-coalition-problem.md)

## What This Solves

The existing AI has two pieces that work independently:
1. **Build decisions** — the EPT/dollar frontier ranking (solved, running)
2. **Trade filtering** — heuristic-based trade acceptance (working but crude)

What's missing is a **trade search engine** — the AI can evaluate a trade that's offered to it, but it can't *generate* the right trade to propose. The subgraph framework turns the AI from reactive (evaluate offers) to proactive (identify what it needs, find who has it, propose the deal).

This also solves the 3+ player trade valuation problem. By computing post-trade subgraphs for ALL players (not just the two trading), the engine can assess whether a trade creates an unbalanced state that the non-trading players can't answer.

## Architecture

### Core Data Structures

```
PlayerSubgraph {
    properties: Property[]          // nodes this player owns
    completeSets: ColorSet[]        // cliques where building is possible
    partialSets: PartialSet[]       // 1 or 2 of N in a color group
    isolatedNodes: Property[]       // no path to completion (opponents own the rest)
    cash: number
    buildings: Map<Property, 0-5>   // house level per property
    buildFrontier: FrontierCurve    // EPT vs cash curve for build-only path
    frontierSlope: number           // is frontier steep (grow) or flat (capped)?
}

PartialSet {
    owned: Property[]               // what we have
    needed: Property[]              // what we need to complete
    heldBy: Map<Property, Player>   // who holds each missing piece
}

CandidateTrade {
    give: Property[]                // nodes leaving our subgraph
    receive: Property[]             // nodes entering our subgraph
    counterparty: Player
    cashDelta: number               // net cash exchanged (positive = we receive)
    postTradeSubgraphs: Map<Player, PlayerSubgraph>  // ALL players' subgraphs after
    bilateralEV: number             // trajectory sim result for both traders
    thirdPartyImpact: number[]      // trajectory delta for non-trading players
    riskAdjustedEV: number          // bilateralEV × P(acceptance)
}
```

### Phase 1: Subgraph Analysis

On each decision point, compute the current player's subgraph:

1. **Classify all owned properties** into complete sets, partial sets, and isolated nodes
2. **Compute build frontier** — existing EPT/dollar ranking across complete sets
3. **Assess frontier slope** — steep (still growing, build is productive) or flat (capped, need trade)

```
assessPosition(player) → {
    state: GROWING | CAPPED | LOSING
    buildROI: number           // best available build EPT/dollar
    ceiling: number            // max EPT achievable by building only
    turnsToMaxDev: number      // how many turns to reach ceiling
}
```

**Decision gate:** If state = GROWING and buildROI exceeds a threshold, just build. Skip trade search entirely. This is the fast path — most turns, the right move is to build your best house.

### Phase 2: Trade Search (when CAPPED or LOSING)

When the frontier is flat or the player is losing, search for trades that restructure the subgraph.

#### Step 2a: Generate Candidates

For each opponent, enumerate trades that could complete a partial set:

```
generateCandidates(player, opponent) → CandidateTrade[]

For each partialSet in player.partialSets:
    neededFromOpponent = partialSet.needed ∩ opponent.properties
    if neededFromOpponent is empty: skip

    For each subset of neededFromOpponent:  // what we want
        For each offer from player.tradeableProperties:  // what we give
            create CandidateTrade(give=offer, receive=subset, ...)
```

**Tradeable properties** = partials and isolated nodes. Never trade away complete sets or properties in sets you're actively building.

#### Step 2b: Pruning Rules

Before running any simulations, eliminate dominated candidates:

1. **Never give an opponent a monopoly completion without getting one yourself** — check if the "give" set completes any of the opponent's partial sets
2. **Never trade if post-trade frontier is worse than current** — quick frontier recalc
3. **Eliminate trades where counterparty has no incentive** — their post-trade frontier must also improve
4. **Cash feasibility** — after trade + development, both players must stay above reserve threshold
5. **Domination** — if Trade A gives strictly better post-trade frontier than Trade B for both parties, eliminate B

**Expected pruning:** From ~100-200 raw candidates per opponent down to ~5-20 serious candidates total.

#### Step 2c: Bilateral Evaluation

For each surviving candidate:

1. Compute post-trade subgraphs for BOTH players
2. Run bilateral trajectory simulation (existing Monte Carlo engine)
3. Get win probability delta for both players
4. A trade is in the **Nash bargaining zone** if both players' win probability improves

```
evaluateTrade(trade) → {
    myWinDelta: number      // my win% after - my win% before
    theirWinDelta: number   // their win% after - their win% before
    feasible: myWinDelta > 0 AND theirWinDelta > 0
}
```

#### Step 2d: Third-Party Impact Check

For each feasible bilateral trade, check the non-trading players:

1. Recompute non-traders' subgraphs (their properties didn't change, but the competitive landscape did)
2. Run trajectory sim for non-traders against the post-trade positions
3. Flag trades that create a **dominant position** — one trader's post-trade trajectory is unbeatable

```
thirdPartyCheck(trade, nonTraders) → {
    balanced: boolean       // no single player dominates post-trade
    leaderWinProb: number   // highest post-trade win% among all players
    selfBalancing: boolean  // do non-traders have counter-moves?
}
```

**Why this matters:** A trade where both traders improve but one ends up at 55%+ win probability will trigger the self-balancing dynamic — the other players will coalition against the leader. The AI should prefer trades that improve its position without painting a target on itself.

### Phase 3: 3-Way Cycle Search (when no bilateral trade works)

If no bilateral trade is in the Nash bargaining zone (my improvement requires giving the opponent something too valuable), search for 3-way cycles:

```
A gives X to B
B gives Y to C
C gives Z to A
```

The constraint: each player must improve their subgraph. This is graph matching on cycles rather than pairs.

**Enumeration:**
- For each pair of opponents (B, C):
  - What does A need from C? (partial set completions)
  - What does B need from A? (partial set completions)
  - What does C need from B? (partial set completions)
  - Does a cycle exist where all three improve?

**Pruning is aggressive here** — the cycle must close (Z from C must actually be useful to A), so most combinations fail immediately. Expected feasible 3-way trades: 0-5 per game state.

**Evaluation:** Run full trajectory sim with all three post-trade subgraphs. Same Nash bargaining criterion: all three players must improve.

### Phase 4: Property Valuation (emergent)

Property valuation falls out of the framework naturally:

```
valueOfProperty(prop, player) =
    frontierWithProp(player) - frontierWithoutProp(player)
```

A property's value to a specific player is the **delta between their subgraph frontier with and without that node**. This is position-dependent:

- A property that completes a clique → massive value (step-function unlock)
- A property in a partial set with 1 more needed → moderate (closer to completion)
- An isolated property with no path to completion → value only as trade bait or cash (via sale/mortgage)

This replaces the static EPT valuation tables with dynamic, position-aware valuation.

**Trade pricing:** The Nash bargaining price for a property is somewhere between the buyer's valuation (their frontier delta) and the seller's valuation (their frontier delta from losing it). The exact split depends on outside options (BATNAs) per the existing Nash bargaining framework.

## Integration with Existing AI

The engine slots in as a new decision layer:

```
onDecisionPoint(player, gameState):
    subgraph = analyzeSubgraph(player, gameState)

    // Phase 1: Can we just build?
    if subgraph.state == GROWING:
        bestBuild = subgraph.buildFrontier.bestROI()
        if bestBuild.roi > BUILD_THRESHOLD:
            return BuildAction(bestBuild)

    // Phase 2: Search for bilateral trades
    candidates = []
    for opponent in gameState.otherPlayers:
        raw = generateCandidates(player, opponent)
        pruned = applyPruningRules(raw, gameState)
        evaluated = pruned.map(t => evaluateTrade(t, gameState))
        feasible = evaluated.filter(t => t.feasible)
        candidates.push(...feasible)

    // Phase 2d: Third-party check
    checked = candidates.map(t => thirdPartyCheck(t, gameState))
    balanced = checked.filter(t => t.balanced)

    // Phase 3: 3-way search if needed
    if balanced.isEmpty():
        cycles = search3WayCycles(player, gameState)
        balanced = cycles.filter(t => t.feasible && t.balanced)

    // Decision
    if balanced.isEmpty():
        // No good trade exists — build best available or hold cash
        return subgraph.buildFrontier.bestROI() ?? HoldCash()

    bestTrade = balanced.maxBy(t => t.riskAdjustedEV)

    // Compare trade to build
    if bestTrade.riskAdjustedEV > subgraph.buildFrontier.bestROI():
        return ProposeTradeAction(bestTrade)
    else:
        return BuildAction(subgraph.buildFrontier.bestROI())
```

## Tractability Estimate

| Phase | Candidates | Sims per candidate | Total sims | Time est. |
|-------|-----------|-------------------|-----------|-----------|
| Build frontier | 5-10 | 0 (analytic) | 0 | <1ms |
| Trade generation + pruning | 100-200 → 15-60 | 0 | 0 | <10ms |
| Bilateral evaluation | 15-60 | 1 trajectory sim | 15-60 | ~1s |
| Third-party check | 5-20 feasible | 2 sims (non-traders) | 10-40 | ~0.5s |
| 3-way cycle search | 0-5 feasible | 1 full sim | 0-5 | <0.5s |
| **Total** | | | **25-105** | **~2-3s** |

Tractable for game AI. May need optimization for Richup.io bot (tighter time constraints), but the pruning is where most savings come from — better pruning rules reduce sim count without changing the algorithm.

## Validation Plan

### Test 1: Trade Search Quality
Run the subgraph engine on known game states from existing simulation logs. Check:
- Does it find trades the heuristic AI missed?
- Does it avoid trades the heuristic AI incorrectly accepted?
- Do the position-dependent property valuations match intuition from gameplay?

### Test 2: Head-to-Head
Run SubgraphTradeAI vs StrategicTradeAI (current best) over 10,000 games. Win rate improvement is the metric. The theory predicts improvement should be largest in mid-game states where trade opportunities exist but the heuristic AI's static valuations misjudge them.

### Test 3: Pruning Validation
Track how many candidate trades survive each pruning step. If too many survive (>100), pruning rules need tightening. If too few survive (0 in most states), the rules are too aggressive and may be eliminating good trades.

### Test 4: 3-Player Trade Discovery
Specifically test game states where no bilateral trade helps but a 3-way cycle does. These are the states where the framework should show its biggest advantage over the existing AI, which can't even consider 3-way trades.

## Assumptions to Test

1. **"Never trade complete sets"** — Usually correct, but are there edge cases where selling a low-value monopoly (browns with houses) for cash + a piece that completes a better set is optimal?
2. **"Counterparty must also improve"** — In theory yes (Nash bargaining). In practice, can the AI exploit an opponent's miscalculation or time pressure?
3. **Pruning doesn't miss non-obvious trades** — A trade that looks bad locally (giving up a partial set) might be great globally (the received property completes a better set). The pruning rules must not eliminate these.
4. **Third-party check is worth the cost** — Does checking non-trader impact actually change trade selection, or are most bilateral-feasible trades also balanced? If the check rarely changes the outcome, it can be deferred or simplified.

## Open Questions

1. **Auction integration:** The engine evaluates trades, but auctions are another way to acquire properties. Should the subgraph analysis drive auction bidding too? (Bid up to your frontier delta for that property.)
2. **Timing of trade proposals:** When should the AI propose a trade vs. wait? Proposing too early reveals information about what you want; waiting too long means the opportunity passes.
3. **Bluffing and information hiding:** The subgraph analysis reveals exactly what the AI values. Should it sometimes propose trades it doesn't want, to disguise its real target?
4. **Dynamic reserve integration:** The reserve threshold from frontier trade theory interacts with trade evaluation — a trade that leaves you below reserve is risky even if the frontier improves. This needs to be part of the feasibility check.

## Tags
[game-ai](../../../tags/game-ai.md), [economics](../../../tags/economics.md), [game-theory](../../../tags/game-theory.md), [strategy](../../../tags/strategy.md)
