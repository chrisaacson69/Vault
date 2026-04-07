---
status: active
created: 2026-03-17
---
# Subgraph Investment Optimization
> Given the portion of the investment graph you actually own, find the tractable paths forward.

**Links:** [Gaming](../README.md), [Bilateral Trade Valuation](../bilateral-trade-valuation.md), [The Multiplayer Coalition Problem](../multiplayer-coalition-problem.md), [The Nash Bargaining Problem](../nash-bargaining-problem.md), [Monopoly](../../../projects/monopoly/README.md), [Insurance](../../economics/insurance.md), [Risk and Entrepreneurship](../../economics/risk-and-entrepreneurship.md)

## The Problem

The full Monopoly investment space is combinatorial: 28 properties, 5 house levels each, trades between 2-4 players, variable cash positions. Evaluating all possible futures from any game state is intractable. The [bilateral trade valuation](../bilateral-trade-valuation.md) model showed how to evaluate individual trades correctly, and the [multiplayer coalition problem](../multiplayer-coalition-problem.md) showed why the full multiplayer space resists solution.

But there's a structural reduction hiding in plain sight: **you don't own the whole graph.** Each player owns a subgraph of the property space, and at any decision point, the set of *actually available* actions is far smaller than the theoretical space. The problem isn't "what's the best portfolio?" — it's "given what I hold right now, what's the best use of my next dollar?"

This is Markowitz's efficient frontier applied under real constraints. CAPM assumes frictionless, liquid markets where you can always rebalance to the frontier. Monopoly has massive friction: trades require willing counterparties, assets are discrete and illiquid, and the opportunity cost of waiting for a better trade is concrete (your opponent is building houses while you hold cash).

## The Graph Structure

### Property Graph

The Monopoly board is a graph where:

- **Nodes** = individual properties (28 street properties, 4 railroads, 2 utilities)
- **Cliques** = monopoly color sets (e.g., Orange = {St. James, Tennessee, New York})
- **Value function** = superadditive over complete cliques — owning 2 of 3 Oranges is worth less than 2/3 of owning all 3, because completing the set unlocks building

The superadditivity is the key structural feature. It means the topology of your subgraph matters more than its size. A player with one complete clique (3 connected nodes) dominates a player with scattered nodes across 4 incomplete sets, even if the scattered player "owns more."

### Player Subgraphs

At any game state, the property graph is partitioned among players (plus unowned nodes). Each player's subgraph has:

- **Complete cliques** — monopoly sets where building is possible
- **Partial cliques** — 1 or 2 of 3 in a color set, no building allowed
- **Isolated nodes** — properties with no path to completion (opponent owns the rest)

The **depth** of a subgraph is its development level — how many houses are built on complete cliques. The **topology** is which cliques are complete vs partial vs isolated.

### The Two Moves

At each decision point, you have exactly two types of action:

**BUILD (deepen your subgraph):**
- Add houses to a complete clique you own
- Deterministic — always available if you have cash and a complete set
- Marginal return is calculable: Markov landing probability x rent increase for that house level
- Trades cash (intercept) for property-EPT (slope) per the [relative position model](../multiplayer-coalition-problem.md)

**TRADE (restructure your subgraph topology):**
- Exchange nodes between subgraphs to complete a clique or improve set quality
- Probabilistic — requires a counterparty in the [Nash bargaining zone](../nash-bargaining-problem.md)
- Potential return is high (completing a set unlocks building = step-function value increase)
- Execution probability is low (opponent must also improve, and they know this)

## Why "Build What You Got" Dominates

The bilateral trajectory model already showed this empirically (33.1% win rate, Z=10.25). The graph framework explains *why*:

### 1. Build Edges Are Deterministic, Trade Edges Are Probabilistic

A build action has execution probability = 1.0 (if you have cash). A trade has execution probability = P(counterparty agrees), which requires:

- The trade improves both subgraphs (mutual benefit)
- The counterparty has the cash to exploit their improvement (otherwise they won't value it)
- No third player blocks or outbids

In practice, this product of conditions is small. The expected value of a trade is `EV(trade) x P(execution)`. Even when `EV(trade) >> EV(build)`, the probability discount often kills it.

### 2. The Counterparty Problem Is Structural

For a trade to be mutually beneficial, both players must improve their subgraph topology. But in Monopoly, completing YOUR clique often means giving the opponent a node that completes THEIRS. The set of trades where both players complete a set without the other also completing one is small and game-state dependent.

More precisely: a trade is feasible when the subgraph partition is such that both players hold fragments of *different* cliques and can swap to each complete one. This is a **graph matching problem** — finding complementary subgraph completions. The matching exists in specific states but not generically.

### 3. The Opportunity Cost of Waiting Is Concrete

While you hold cash waiting for a trade that may never happen, your opponent is building. Every turn you don't build, you forgo the rent income that house would generate. The bilateral trajectory model makes this visible: the "do nothing, wait for trade" trajectory falls further behind the "build now" trajectory with each passing turn.

This connects to the [interest rate framework](../multiplayer-coalition-problem.md): cash earns 0% return. Houses earn property-EPT. Holding cash is a bet that a future trade will yield more than the cumulative property-EPT you're forgoing. That bet rarely pays off.

### 4. The Pareto Front Is Small

At any game state, the set of non-dominated actions (actions where no other action is better in every dimension) is small:

- Build highest-ROI house (usually the 3rd house on the best complete set)
- Build next-highest-ROI house (if cash allows)
- Attempt trade that completes a set (if a feasible trade exists)
- Hold cash for insurance against catastrophic rent (per the [liquidity curve](../../economics/insurance.md))

Most of the combinatorial space is dominated. You never need to consider building the 1st house on your worst set before the 3rd house on your best set. You never need to consider a trade that gives your opponent a monopoly without getting one yourself. Dominance pruning collapses the action space to a handful of candidates.

## The Decision Framework

### Step 1: Compute Your Build Frontier

For each buildable house on each complete set:
- Marginal rent increase (from EPT table)
- Cost
- ROI = marginal_EPT / cost
- Payback period = cost / marginal_EPT

Rank by ROI. This is the efficient frontier of deterministic investments.

### Step 2: Identify Feasible Trades

For each opponent, check: is there a swap of partial-clique fragments that completes a clique for both? This is the graph matching step — find complementary completions.

For each feasible trade:
- Run [bilateral trajectory simulation](../bilateral-trade-valuation.md) to get EV
- Estimate execution probability (does the opponent's trajectory also improve? do they have cash to exploit it?)
- Risk-adjusted EV = trajectory_improvement x P(execution)

### Step 3: Compare

The decision rule: **take the action with highest risk-adjusted EV.**

- If best_build_ROI > best_trade_risk_adjusted_EV → build
- If a feasible trade exists with risk-adjusted EV > build ROI → attempt trade
- If cash is below the [reserve threshold](../../economics/insurance.md) → neither; hold cash

### Step 4: The BATNA Check

Your BATNA (best alternative to negotiated agreement) is always the build option. This sets the floor for any trade:

- Never accept a trade where your post-trade trajectory is worse than your build-only trajectory
- The counterparty's BATNA is their build option — they apply the same logic
- A trade only happens when both post-trade trajectories exceed both BATNAs

This is the [Nash bargaining solution](../nash-bargaining-problem.md) applied to subgraph optimization: the disagreement point is "both players just build what they have."

## Why This Reduces the Problem

The full combinatorial space of all possible investments across all players is enormous. But from any single player's perspective at a single decision point:

1. **Build options** = number of buildable houses across your complete sets (typically 3-9 candidates)
2. **Trade options** = number of feasible complementary completions with each opponent (typically 0-2)
3. **Total decision space** = ~5-10 candidates, dominated down to 1-3 serious options

This is the "good news" — the problem is much smaller than the full combinatorial space because:

- You only own part of the graph (your subgraph, not the whole thing)
- Most of the theoretical investment space is unavailable to you (you can't build on sets you don't own)
- Most trades are infeasible (no counterparty in the bargaining zone)
- Dominance pruning eliminates most remaining options

The hard problem — "find the globally optimal strategy across all possible game states" — collapses to the tractable problem: "given my subgraph right now, which of these 2-3 non-dominated actions should I take?"

## Connection to Multiplayer Dynamics

Each player is simultaneously solving this same subgraph optimization problem. The interaction comes through:

1. **Trade feasibility** — your trade options depend on what others own (their subgraphs)
2. **Rent flows** — their development affects your trajectory (bilateral interaction from [trade valuation](../bilateral-trade-valuation.md))
3. **Housing scarcity** — 32 houses in the game create a shared constraint (building on your set may block others from building on theirs)

The housing scarcity point connects back to the "build what you got" insight: in a 4-player game, building early doesn't just improve your position — it claims scarce housing inventory, *worsening* other players' build frontiers. This is an externality of the build decision that the bilateral model can capture but the isolated growth curve cannot.

## Formalization: DAG of Reachable States

The sequence of decisions forms a DAG (directed acyclic graph):

- **Nodes** = game states (player subgraphs + cash positions + development levels)
- **Edges** = available actions (build or trade) weighted by EV
- **Paths** = sequences of decisions leading to different outcomes

From any node, the reachable set is small (the 2-3 non-dominated actions). The DAG fans out, but each level has low branching factor because of dominance pruning. Navigating the DAG = picking the highest-EV edge at each node.

This is dynamic programming on a state graph where:
- States = (your properties, your cash, your buildings, opponents' states)
- Actions = deterministic builds + probabilistic trades
- Transition probabilities = 1.0 for builds, estimated for trades
- Reward = trajectory improvement per the bilateral model

The Markov landing probabilities feed into the reward calculation. The bilateral simulation computes the reward. The graph structure determines the action space. Each piece of existing theory slots into the framework.

## Convergence Under Constraints

The full subgraph optimization problem isn't analytically solvable — you can't prove that "build the 3rd house on Orange" is the Nash equilibrium move from a given state. But the pattern across this vault's game research is that **real-world constraints and dominant strategies reduce the problem space until iterative convergence finds the right answer anyway.**

This is visible in the existing results:

- The **1.0x reserve multiplier** (from [insurance](../../economics/insurance.md)) was empirically calibrated, not derived. It turned out to match the theoretically correct value. The constraint structure (convex liquidity cost, bounded rent distribution) left only a narrow band of workable multipliers, and iteration found it.
- The **bilateral model's simplification** (ignore other players' development) "shouldn't" work for a 4-player game. It produced Z=10.25. The constraint (other players' development is slow relative to the two traders' post-trade trajectories) makes the N-body correction terms small enough to ignore.
- The **convergence-point Nash price** and the **area-equality Nash price** gave nearly identical results (33.8% vs 33.6%). Two different formulations converged to the same answer because the constraint structure (finite horizon, bounded cash, discrete house levels) collapses the space of possible prices to a narrow range.

The pattern: when constraints are tight enough, multiple reasonable approaches converge to the same solution. You don't need mathematical rigor to find it — you need a model that respects the constraints and an iteration loop.

This connects directly to [computational irreducibility](../../computation-and-information.md). The full game state space is irreducible — no shortcut to the optimal play sequence. But the *decision at each node* is reducible because dominance pruning, constraint satisfaction, and convergence dynamics collapse the choice set. The game is irreducible globally but tractable locally. You can't solve the whole DAG, but you can navigate it one node at a time, and convergence ensures that local greedy decisions approximate the global optimum.

The practical implication for implementation: don't try to solve the framework analytically. Build the bilateral simulation, apply the dominance pruning, iterate. If the result converges (as it has at every prior step), the solution is correct enough. The constraints do the mathematical work that closed-form solutions would otherwise require.

## Open Questions

- **Housing scarcity as strategic weapon:** When should you build specifically to deny housing to opponents, even if the ROI of that house is suboptimal for your own position? This is a blocking play on the shared constraint — the graph equivalent of occupying a chokepoint.
- **Trade timing:** The feasible trade set changes as the game progresses (properties get acquired, cash accumulates). Is there a phase transition where "attempt trade" becomes dominated by "just build" permanently? Probably around the time 3+ complete sets exist on the board with houses.
- **Multi-property trades:** The framework above considers pairwise swaps. In practice, 3-way trades (I give you A, you give them B, they give me C) can unlock completions that no bilateral swap can. These are rare but high-value — the graph matching problem on cycles rather than pairs.
- **Integration with coalition dynamics:** In multiplayer, the [self-balancing dynamic](../multiplayer-coalition-problem.md) (oppose the leader) interacts with subgraph optimization. Should you trade with the non-leader to build a coalition against the leader, even if the trade's bilateral EV is slightly negative? This is where the subgraph framework meets the coalition problem.
- **Cross-game application — MOO1:** The [MOO1 bad-start adaptation problem](../moo1/optimal-strategy.md) is this exact framework in 4X form. The subgraph is your planets and tech; the "build vs trade" decision becomes "develop vs expand vs militarize." The framework applies but the ROI numbers for military and research investment are missing — convergence can't operate without them.

## Tags
[games](../../../tags/games.md), [game-ai](../../../tags/game-ai.md), [economics](../../../tags/economics.md), [mathematics](../../../tags/mathematics.md)
