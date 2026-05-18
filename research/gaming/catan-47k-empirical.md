---
status: active
created: 2026-05-18
---
# Catan — 47,000 Games of Empirical Findings
> Ioana Roman analyzed 47,000 recorded Catan games from twosheep.io and turned the board game into a stochastic dynamic system with real numbers attached. Headline findings: turn order is essentially balanced, opening placement predicts the winner barely above random (27% vs 25% baseline), Longest Road and Largest Army are *symptoms* not *causes* of victory, missing a resource barely matters because the market corrects, Monopoly cards are gigantic timing weapons (one played → 40% win rate; two played → 55%), and **winners systematically overpay on trades**. The last one is the empirical confirmation, across 47k games, of the [bilateral trade valuation thesis](./bilateral-trade-valuation.md): trade evaluation must be trajectory-based, not isolated NPV. **Important caveat:** despite the title, the video delivers descriptive statistics about how games tend to play out, not a strategic prescription for how to win. The empirical landmarks are real and useful as constraints, but the prescription layer — state-conditional opening policies, timing policies, trajectory valuation — is the work the [Monopoly project](../../projects/monopoly/README.md) does and Roman doesn't.

**Links:** [Gaming](./README.md), [LLM Agents Across Strategic Games](./llm-agents-across-games.md), [LLM Game Benchmark — Outline](./llm-game-benchmark.md), [Bilateral Trade Valuation](./bilateral-trade-valuation.md), [The Multiplayer Coalition Problem](./multiplayer-coalition-problem.md), [BattleValue](./battle-value.md), [Planner-LM Composites](../planner-lm-composites.md), [The LLM Grounding Problem](../llm-grounding-problem.md), [Monopoly Theory](./monopoly/), [Energy-Based Models](../energy-based-models.md), [Catan 50-Game Validation](./catan-50-games-validation.md) — proof-of-method run against the public 50-game Kaggle dataset; aggregate city-engine direction confirmed, board-conditional refinement only partially supported, theory's working form updated to "universal city-engine bias + layered archetype effect"

**Primary source:** [I Analysed 47,000 Games of Catan. Here's How to Win Every Time (mathematically)](https://www.youtube.com/watch?v=nGszJM2BNi4) — Ioana Roman, 2026-05-10. [Transcript](../../raw/yt-nGszJM2BNi4.transcript.txt). Data: [twosheep.io](https://twosheep.io).

---

## The mathematical model

Roman frames Catan as a **multi-agent stochastic dynamic optimization problem**. The skeleton:

- **Board** = graph G = (V, E). Vertices are settlement locations, edges are roads, faces are hexes with (resource type, number token) attributes.
- **State** = per-player 5-dimensional resource vector (brick, wood, sheep, wheat, ore), evolving over time.
- **Roll** = sum of two fair d6, fixed and known PMF. 7 is most likely (robber, no tile produces); 6 and 8 are most likely *producers*; 2 and 12 are rarest.
- **Production** = conditional on roll. Settlements adjacent to matching tiles get 1 resource; cities get 2.
- **Victory** = stopping time. First player to reach 10 VP.

The framing matters: this is "probabilistic income streams + endogenous market dynamics + asymmetric information + stopping-time decision," which is much closer to the [bilateral trade valuation](./bilateral-trade-valuation.md) and [Monopoly project](../../projects/monopoly/README.md) framings than to anything that "luck vs skill" captures. Catan is a small economy under uncertainty.

## The seven empirical findings

### 1. Turn order is balanced

| Position | Win rate |
|---|---|
| 1st | 24.9% |
| 2nd | ~25% |
| 3rd | slightly >25% |
| 4th | ~25% |

The snake-order placement (last player places twice before order reverses) genuinely works. There's no exploitable structural disadvantage to seating. **If you lost from 4th, it wasn't the reason.**

### 2. Longest Road and Largest Army are symptoms, not causes

- Longest Road appears in **96% of games**; holder wins **59%** (vs 25% baseline).
- Largest Army appears in **57% of games**; holder wins **54%**.

These are large lifts over baseline, but the holder *still loses 40% / 46% of the time*. Roman's read: they reflect underlying structural advantage rather than create it. Longest Road tracks spatial dominance over the graph; Largest Army tracks ore/wheat investment plus robber control. Both are downstream of the actual strategic position.

This is the **structural-realism pattern** ([[BattleValue]], [[D&D Spell Damage Model]]): the headline number is a proxy. The thing that produces both the bonus and the win is the underlying configuration.

### 3. Pip-weighting reveals winners prefer the city engine

Each number token has a weight proportional to its dice-roll probability. Summing the weights of a settlement's three adjacent tiles gives a scalar **expected production intensity**.

Winners had *slightly* higher exposure to:
- Ore
- Wheat
- Sheep

(combined: the "city engine" — what powers cities and development cards)

Winners and losers had **nearly identical** exposure to:
- Brick
- Wood

(the "road engine")

The finding is small per game but consistent across 47k. **Catan is not fundamentally a road game; it's a compounding city game.** Cities double production, development cards provide hidden leverage and Largest Army eligibility, and the late-game acceleration runs on ore+wheat+sheep. The road-heavy intuition that beginners get from "Longest Road feels decisive" is misleading at the strategy-selection layer.

### 4. Missing a resource barely matters

Across 47k games, missing any single resource at the opening leaves win rate at ~25% with small dips for missing ore or wood. The trading and port system is enough to correct the imbalance.

This is **self-balancing market behavior**, the same pattern that makes [N≥3 multiplayer coalitions](./multiplayer-coalition-problem.md) game-theoretically interesting. The game has built-in correction mechanisms; outcomes don't collapse on one bad draw. **Resilience comes from the trade graph, not from the production graph.**

### 5. The opening predicts almost nothing

Roman trained a classifier on initial-placement features (pip exposure, resource diversity, balance metrics), tested on 20% held-out games. Accuracy: **27%**. Random baseline: 25%.

The opening matters by **two percentage points**.

The other 73% of outcome variance lives in the post-opening sequence: trades, development card draws, robber placements, timing, interaction. **Catan is path-dependent, not predetermined at turn zero.** This is the empirical answer to "where does the game actually happen?" — not in the opening, but in the running game.

### 6. Monopoly cards are timing weapons, not just resource cards

| Monopoly cards played | Win rate |
|---|---|
| 0 | 25% |
| 1 | 40% |
| 2 (max) | 55% |

Roman's framing: "systemic liquidity extraction." A late-game Monopoly when opponents have accumulated inventory is a much bigger shock than an early one — the card *redistributes* the inventory state, and the larger the state, the bigger the move.

Two architectural implications:

- A **bare LLM** asked to play Catan has no mechanical model of when inventory has accumulated. It plays Monopoly when the prompt suggests, not when the state shows. ([[LLM agents across strategic games]] Catan phase documents exactly this failure.)
- A **planner-LM composite** would observe state and time the card. The 15-30 point win-rate lift on this single decision is exactly the kind of return-on-state-awareness that the [planner-LM composite thesis](../planner-lm-composites.md) and the [EBM constraint-engine thesis](../energy-based-models.md) predict. It's a state-conditional optimization with a fixed action and a measurable payoff.

### 7. The trade-efficiency paradox — winners overpay

Trade efficiency = resources received / resources given.

| Trade efficiency | Win rate |
|---|---|
| ~1.0 (perfectly even) | **8%** |
| > 1.0 (favorable) | (not the winners) |
| < 1.0 (overpaying) | (where the winners cluster) |

Players who make *perfectly fair* trades win at **8%** — three times worse than baseline. Players who systematically appear to overpay are the ones who win.

The mechanism Roman names: **they're not optimizing the trade; they're optimizing their position.** Overpaying to complete a city before a key roll. Overpaying to secure Longest Road before someone else gets it. Overpaying to block an opponent's expansion. Short-term inefficiency for long-term positional gain.

This is **the empirical confirmation of [bilateral trade valuation](./bilateral-trade-valuation.md)** across 47k games. That page argued: a trade's value is *where both players end up 20 turns later*, not the static resource delta. Roman's data is the smoking gun. Players treating trade as a transaction-level optimization (even ratio = "fair") lose almost three times the rate of players treating it as a position-level move.

The pattern generalizes well past Catan:
- Successful investing: short-term P&L vs. long-term position
- Monopoly trade theory ([[Frontier Trade Theory]]): pay above EPT to complete monopolies that compound
- Negotiation games (Diplomacy, Coup): concede tactically to win strategically
- M&A: pay a premium for the strategic position, not the asset

The principle is one layer above game theory: **valuation requires a trajectory, not a snapshot.**

## How this lands in the vault

### Confirms

- **[Bilateral Trade Valuation](./bilateral-trade-valuation.md)** — the trade-efficiency paradox is the empirical proof, with N=47,000.
- **[The Multiplayer Coalition Problem](./multiplayer-coalition-problem.md)** — Catan's "missing-a-resource barely matters" is the trade graph doing self-balancing work in N=4.
- **[BattleValue](./battle-value.md) / [Structural realism](./dnd-spell-damage-model.md)** — pip-weighting is BattleValue for settlement placement. The instinct generalizes.

### Sharpens

- **[LLM Agents Across Strategic Games — Catan Phase 5](./llm-agents-across-games.md#phase-5--catan-verification-as-a-spectrum-not-a-binary)** — the LLM-failures page documents what bad Catan play looks like (action bias, no mechanical model, rhetorical contagion). This page documents what *good* Catan play looks like (city engine, trajectory-trades, timed Monopoly cards). Together they bracket the problem.
- **[LLM Game Benchmark](./llm-game-benchmark.md)** — quantitative ceilings now exist. An LLM agent that doesn't time Monopoly cards, doesn't bias toward ore/wheat/sheep, and trades to even ratios is leaving 30+ percentage points of win rate on the table relative to known-good human play. These become benchmark axes.

### Connects

- **[Planner-LM Composites](../planner-lm-composites.md)** — the three findings most resistant to bare-LLM play (Monopoly timing, trajectory-trades, late-game city scaling) all require **state-conditional optimization with a stable goal across turns**. That's the planner's job, not the language model's. The Catan empirics are a quantitative version of the Catan-phase qualitative findings.
- **[Energy-Based Models](../energy-based-models.md)** — pip-weighting is a hand-built energy function for settlement placement. A learned EBM over Catan states would generalize this to "score whole states by how well they fit the city-engine + trade-graph + Monopoly-timing structure."
- **[Monopoly project](../../projects/monopoly/README.md)** — the Roman analysis is the methodology Chris's Monopoly project already uses, applied to Catan. The shapes are the same: graph board, resource vectors, market with imbalances, hidden info. The Monopoly project's [frontier trade theory](./monopoly/frontier-trade-theory.md) and [subgraph investment optimization](./monopoly/subgraph-investment-optimization.md) are doing for Monopoly what this video does for Catan.

## The descriptive / prescriptive gap — what the analysis doesn't do

Roman's title promises *"How to Win Every Time (mathematically)."* The video doesn't deliver that. What it delivers is **descriptive statistics about how games tend to play out**. That's a different (and lesser) artifact than strategic prescription. Worth naming the distinction because the vault's Monopoly project lives on the *other* side of this line, and the comparison clarifies what an actual Catan strategy paper would have to add.

**What Roman did (the empirical / descriptive layer):**

- "Winners have slightly higher ore/wheat/sheep exposure" — a *correlation in outcomes*
- "Monopoly cards correlate with 25% → 40% → 55% win rate" — a *count-based aggregation*
- "Trade-efficiency 1.0 → 8% win rate" — an *unconditional summary statistic*
- "27% classifier accuracy from opening features" — a *predictive ceiling*

**What she didn't do (the prescription / policy layer):**

- *Which* opening placement archetype to actually pick on a given board (state-conditional opening policy)
- *When* in a game to play a Monopoly card as a function of opponents' visible inventory (state-conditional timing policy)
- *Which* positions to overpay for and *by how much* (a frontier curve over trade value vs positional gain)
- A counterfactual layer ("if I had built here instead, my win rate would have been X") that actually moves you up the win-rate distribution
- Any optimization formalism — utility function, Pareto frontier, dynamic program — that takes the empirical tendencies and converts them to a *decision procedure*

The gap is the difference between *"winners tend to have X"* and *"given the current state, do Y"*. Roman is honest about this implicitly (her language is "structural advantage," "tendencies," "compounding") but doesn't bridge to the second layer. **Headline tendencies → strategy is a separate exercise the video didn't take on.**

### What a Catan prescription layer would look like

The [Monopoly project](../../projects/monopoly/README.md) has the pattern. For Monopoly:
- [Subgraph Investment Optimization](./monopoly/subgraph-investment-optimization.md) — Pareto dominance over reachable states + dynamic programming = an actionable build-vs-trade decision
- [Frontier Trade Theory](./monopoly/frontier-trade-theory.md) — EPT frontier curves + denial value + game horizon = which trades are worth overpaying for and by how much
- [Subgraph Trade Engine Spec](./monopoly/subgraph-trade-engine-spec.md) — the integrated AI architecture

The Catan equivalents would be:

| Empirical finding (Roman) | What the prescription layer would add |
|---|---|
| Winners favor ore/wheat/sheep | A **placement frontier** over (production weight, resource diversity, port adjacency, blocking value) with Pareto-optimal openings labeled by board configuration |
| Monopoly cards lift win rate to 40%/55% | A **state-conditional play policy**: hold Monopoly until opponents' aggregate inventory of resource R exceeds threshold T(R, turn, opponents' VP) |
| Winners overpay for position | A **trajectory-valuation function** — when offered trade T at state S, evaluate ΔV(state at turn S+20 with T) − ΔV(state at S+20 without T) |
| Opening predicts 27% | Implies the *running game* dominates outcome variance; that's where the planner work needs to go (state-tracking, opponent modeling, robber timing — none of which Roman touches) |

This is the same shape as Chris's [frontier trade theory](./monopoly/frontier-trade-theory.md) for Monopoly: the empirical observation that "winners overpay" becomes the prescriptive question "by how much, for which positions, against which opponents." Roman's data has the inputs; the optimization formalism is missing.

### Why the resource-vector framing matters here

Roman models per-player state as a 5D resource vector evolving over time. That formalism is **one Pareto-frontier away** from a strategy theory — the vault's Monopoly work already lives in that adjacent space. Once you have state vectors, you can:

- Define a **utility function** over state (Roman implicitly does this via "win rate" but doesn't formalize a per-state value function)
- Compute **dominated vs non-dominated states** (which build orders are Pareto-improved by any other; which are on the frontier)
- Search the **state graph** for the path to victory with highest expected value under uncertainty (this is the planner layer in the [planner-LM composite](../planner-lm-composites.md))

Roman has the vectors but stops at descriptive statistics over them. The prescription layer is *what to do with the vectors* — and the Monopoly project shows the methodology transfers cleanly.

**The honest verdict on the video:** good empirical landmarks, good intuition-builders, useful as *constraints* for any future prescriptive theory (a Catan strategy paper that contradicts the 27% classifier accuracy is wrong). But the title overpromises. "How to win every time" would require the prescription layer the video doesn't build.

## Toward the prescription — capability value over face value

Roman's tokens are sharp because she stops at *correlation*. The vault-side reading of what those correlations *mean* is sharper, and it changes the strategy implications.

**The general principle: Longest Road, Largest Army, and the Monopoly card don't lift win rate because of the points they grant. They lift win rate because they unlock or signal strategic capability.**

The face value is the wrong unit of analysis. The right unit is *what the holder can now do that opponents can't*.

### Largest Army → robber control

The 2 victory points are nominal. The real asset is **agency over the robber**. A player with Largest Army has played enough knights that they have:

- **Production control over their own board** — knights can pull the robber off your own high-pip hexes whenever a 7 (or someone else's knight) puts it there
- **Production *denial* over opponents** — place the robber on a 6 or 8 you don't share, especially on the resource the leading opponent needs to scale (ore for cities, wheat for development cards)
- **Resource extraction on each move** — every knight steals one card from the blocked hex's adjacent settlements; against a hoarding leader, that's a targeted hit on their state
- **A *threat asset* against trade and placement** — opponents bid lower or refuse trades from the largest-army player because the next knight is also a weapon

The 54% win rate isn't "Largest Army gives 2 VP." It's "Largest Army gives a four-channel intervention mechanism over the production graph." Roman observes the lift; the lift is the *capability rent*.

### Longest Road → map control

Similarly, the 2 VP from Longest Road is the cheaper reading. The expensive reading is **spatial dominance**:

- **More expansion vertices reachable** — the road network grants future settlement slots that other players literally cannot reach without their own road infrastructure
- **Blocking power** — your road on a key edge denies an opponent that intersection forever
- **Port access** — your network reaches 2:1 ports that your starting placement didn't
- **Frontier options** — you control where the next round of settlements goes; opponents react to your structure

The 59% win rate is what map control buys, not what 2 VP buys. The actual VP from Longest Road would be roughly worth 10-15% win-rate by raw point-share math; the other 30+ points of lift is the capability.

### Monopoly card → timed shock

Monopoly's "play one for +15 win rate" effect is essentially capability stacking too:

- **Resource acquisition** — pull every brick out of opponents' hands so you can build the road sealing Longest Road
- **Simultaneous denial** — opponents who were sitting on wheat to build a city now have none
- **State-conditional value** — the card's payoff grows with how much inventory exists to extract; a Monopoly played turn 3 transfers maybe 2 cards, one played turn 25 against a hoarder transfers 10

The 25 → 40 → 55 ladder isn't "Monopoly cards are good." It's "**Monopoly cards are a timing weapon whose strike value grows with the game's accumulated state**." A player who plays it when their opponent has just spent everything is wasting the card.

This is **the exact pattern an EBM or planner would discover and a bare LM would miss** ([[planner-lm-composites]]): the action is fixed, but its value depends on a global property of the state at the moment of play. Action-bias LMs play the card because it's playable; state-aware planners hold the card.

### The lesson, restated

**All three "factors" Roman highlights are the same kind of thing.** They're not levers that grant points. They're levers that grant *the ability to act differently than opponents can*. The win-rate lift is option-value rent — the holder's strategy space is strictly larger than the non-holder's. That's the structural advantage Roman names but doesn't decompose.

This pattern recurs widely:
- [Frontier Trade Theory](./monopoly/frontier-trade-theory.md) — denial value, race condition, knockout probability are option-value framings in Monopoly
- [The Multiplayer Coalition Problem](./multiplayer-coalition-problem.md) — coalition formation is option-value over future negotiation paths
- M.U.L.E. auction system — auction-floor access is an option, not a payoff; the [[project_mule_zero_sum_paradox]] finding is exactly about when this option is in or out of the money
- General principle: **headline rewards are usually downstream proxies for capability or position; the capability is the actual asset**

## Catan's information model — hidden trackable vs hidden random

Roman doesn't analyze Catan's information design. It's worth doing, because the design has a structural inconsistency that affects which strategies pay.

**Two kinds of "hidden" coexist in Catan:**

| What's hidden | How hidden | Adversary's recourse |
|---|---|---|
| Resource hands | Face down on the table | Memory + arithmetic — fully recoverable |
| Development cards | Face down + content unknown until played | None — true unpredictability until reveal |

### Hidden trackable — a soft design flaw

A player's resource hand is technically face down, but it is **fully reconstructible** from public information: every dice roll, every settlement/city adjacency, every trade, every steal, every build. A good-memory player can know every other player's hand at every moment of the game.

This means the "hidden" face-down convention is *not actually hiding information* — it's hiding it from players who aren't bothering to track. Two players at the same table can have radically different information states from the same public game.

That's a soft design flaw. Skill at the game shouldn't reduce to skill at bookkeeping. The convention exists mostly to **keep play moving** — if every trade required players to publicly enumerate hands first, games would drag. So the design accepts an information-asymmetry between memory-good and memory-average players as the price of pace.

The honest reading: **resource hiding is a UX optimization, not a strategic mechanic.** It looks like hidden information but functionally rewards bookkeeping skill, which is a separate axis from strategic skill.

This shows up in Roman's data implicitly: the trade-efficiency paradox depends on opponents being unaware that you "overpaid" because the resource state is opaque to them. Against perfect-memory opponents, the paradox might shrink — they'd know exactly what you gained and re-rank the trade. The 8% / overpay finding is partly about *exploiting other players' incomplete bookkeeping*, not just about trajectory valuation.

### Hidden random — the good design layer

Development cards, in contrast, are **genuinely unpredictable**:

- The draw order is shuffled and unknown
- A drawn card is not visible to opponents until played
- Victory-point dev cards are *never visible* until the game ends (or a 10-VP reveal)

Opponents can see your roads, settlements, cities, and resource flow. They can model your strategy and react. But they *cannot model* what cards you've drawn or when you'll play them. This is the **surprise channel** — and it's the only piece of Catan that's robust to a perfect-information opponent.

This is why dev-card strategies tend to win even when straight-development is more *raw-efficient* per resource invested. The points are roughly equivalent, but **dev card points are uninterceptable**. A road network gets blocked. A settlement gets robbered. A city gets sandbagged. A face-down VP card sits in your hand until you cross 10 and announce it.

**Compounding effects:**

- Largest Army (Roman's #2 lever) is reached by playing knights, which means *spending* development cards. Players investing in dev cards naturally cluster on Largest Army eligibility — both rewards funnel from the same source.
- The hidden-VP card mechanic enables the [Catan LLM Phase 5 finding](./llm-agents-across-games.md#phase-5--catan-verification-as-a-spectrum-not-a-binary) where Claude beats DeepSeek 10-9 by revealing a hidden VP card on turn one. That win condition exists *because* dev cards have a true-hidden information mode.

### The good half / bad half framing

Catan's information design has **two halves** that pull in different directions:

- **Resources (hidden trackable) — bad half.** Rewards bookkeeping over strategy. Creates skill asymmetry along the wrong axis. Probably present only as pace concession.
- **Dev cards (hidden random) — good half.** Creates real uncertainty no opponent can plan around. The structural reason hidden-card strategies overperform their raw-efficiency cost.

This is a useful **game-design lens**: when a game uses hidden information, ask which kind. *Hidden but inferrable* is usually a band-aid for play-time. *Hidden and random* is the genuine strategic mechanic. The two have very different design implications, and players who recognize the difference adjust strategy accordingly — under-investing in tactics opponents can perfectly track, over-investing in the channels they can't.

The principle generalizes:
- Poker hands are hidden-random (legitimate); poker tells are hidden-trackable (compensated by skill in misdirection)
- Diplomacy orders are hidden-random per turn (legitimate); coalitions are hidden-trackable (eroded over time by signaling)
- Real-world business: contract terms are hidden-trackable (NDA-protected but inferable); R&D pipelines are hidden-random (genuinely unknown to competitors)

The instinct generalizes from Catan: **bet on the genuinely-hidden channels, not the bookkeeping-hidden ones.** Anything in the second category is a tax on opponents' attention, not a real strategic asset.

## Board as efficient frontier — a prescription theory (sketch)

Chris's theory of the opening, articulated as the prescription layer Roman didn't reach. Marked as *sketch* — the formalism isn't fully worked out, but the shape is sharp enough to capture and refine.

### The thesis

A Catan board, post-random-setup, is **a vector space whose structure determines the optimal path to victory**. The structure has three observable dimensions:

- **Resource-probability distribution** — pip-weighted production rates per resource type across the board
- **Geographic adjacency** — which resources are clustered, which intersections touch which combinations
- **Port positions** — where 2:1 trades are accessible

Together these collapse onto a **strategy preference landscape**: some build paths are well-supported by this board, others are uphill. The optimal opening isn't an absolute — it's *conditional on the realized board*.

### The resource-strategy correspondence

Each resource biases toward specific build paths:

| Resource abundance | Favored build path | Why |
|---|---|---|
| **Wood + Brick** (high pip exposure on both) | Road expansion, Longest Road, frontier settlement | The road-engine is feasible because the inputs are cheap; aggressive expansion outruns competition |
| **Wheat + Ore** (high pip exposure on both) | City scaling, dev cards, Largest Army | The city-engine compounds; ore+wheat fuels both cities (which double production) and dev cards (which include knights → Largest Army) |
| **Sheep** (over-represented) | Dev cards + settlement expansion | Sheep is the limiting reagent of dev cards (1 sheep per card) and of settlements (1 sheep each); abundant sheep enables the [hidden-card](#hidden-trackable--a-soft-design-flaw) strategy |
| **Mixed / balanced** | Hybrid; flexibility-led | No single path dominates; the strategy is adaptability and trade-based correction |

Roman's empirical finding (winners have slightly higher ore/wheat/sheep exposure) is the **average** of this correspondence over 47k random boards. The interesting claim isn't "favor city engine in general" — it's "**the strategy should be conditioned on the realized board's distribution**." A board with abundant wood/brick should produce road-engine winners; a board with abundant ore/wheat should produce city-engine winners.

This is the prescription Roman didn't deliver: not "favor X" but "**the right strategy is a function of the board state — and here's the function**."

### Efficient frontier framing

This shape is the same one the [Monopoly project](../../projects/monopoly/README.md) already formalizes:

- [Frontier Trade Theory](./monopoly/frontier-trade-theory.md) — EPT curves over property sets, denial value, race conditions
- [Subgraph Investment Optimization](./monopoly/subgraph-investment-optimization.md) — Pareto dominance over reachable states

The Catan equivalent is a frontier curve over **(strategy archetype × board configuration)**:

- X-axis: which strategy archetype (roads / cities / dev cards / hybrid)
- Y-axis: expected value given the realized board
- Pareto-dominated combinations: paths that lose to another path on the same board (e.g., road strategy on a wheat/ore-rich board with brick/wood scarcity)
- Frontier: the set of (archetype, board) combinations where no other archetype strictly dominates

A player choosing their opening is **picking a point on this frontier** — and the choice is constrained by which board they're playing.

This formalism is exactly what would convert Roman's correlations into a decision procedure. Roman observed that winners had slightly higher ore/wheat/sheep exposure *on average*; the frontier theory says **of course they did — the average board mildly favors the city-engine archetype, but the right move on a brick-heavy board is roads, and on a balanced board is hybrid.** The 27% classifier accuracy is what you get when you don't condition on board structure; conditioning collapses the variance.

### Sequential constraint — the frontier shrinks as picks happen

The frontier isn't static. Snake-order placement creates a **stateful auction**:

- Player 1's first settlement claims a vertex → those three adjacent hexes are now committed to Player 1's production
- Remaining players see a *modified* board with that vertex unavailable and that triangle of resources marginally less competitive for them
- By the time Player 4 places their first settlement, the frontier has shrunk substantially; some originally-optimal opening combinations no longer exist
- Snake-order's second-round-reverse means Player 4 (who picked last in round 1) picks first in round 2 — they're picking against the *most-constrained* frontier of round 1's leftovers, but with first crack at the *post-pick* frontier of round 2

The 24.9% / ~25% / >25% / ~25% win-rate distribution is the empirical signature of this design working: the second-pick advantage in round 2 roughly compensates for the late-pick disadvantage in round 1.

This is **the same dynamic as a sequential auction with declining inventory**. Each pick is best-responding to the *current* frontier, not the original. Players who treat opening placement as a static optimization (pick the highest-pip 2:1 ore + wheat regardless) are leaving value on the table; the right play accounts for **what the frontier will look like when it's your next turn**.

### Common-knowledge competition — the counter-positioning move

Here's the second-order strategic insight, and the one Roman's data couldn't reach without much more sophisticated analysis:

**The board is common-knowledge information to all players.** Everyone sees the same hex layout, the same number tokens, the same port positions. Therefore:

1. If the board has a clearly-optimal resource path (say, abundant ore + wheat), every player can see it
2. Every rational player wants those vertices
3. Snake order awards them to whoever picks first/last in the snake
4. Players who *don't* get those vertices are forced into the second-best strategy
5. The popular strategy gets **overbid** — too many players competing for too few good vertices

The contrarian move: **the popular resources are overbid; the less-popular configurations leave open cheaper routes.**

If the board obviously favors cities (ore/wheat clustered with high pips), but four players are bidding for those vertices, the *third-best* ore/wheat vertex might be worse than the *best* wood/brick vertex on the same board — even though the average ore/wheat opening beats the average wood/brick opening across 47k boards.

This is **the same dynamic as crowded trades in finance**: the consensus opportunity gets bid up to a point where its risk-adjusted return is lower than the unfashionable alternative. The right play is to **best-respond to opponents' expected bids, not to the nominal frontier**.

The strategic implication:

| Player's situation | Right play |
|---|---|
| Picks early (round 1) on a clearly-optimal board | Take the obvious vertex; you have the bidding advantage |
| Picks late (round 1) on a clearly-optimal board | The obvious vertices are gone; counter-position toward the second-tier path *if its third-best vertex is better than the obvious path's fifth-best vertex* |
| Picks early on a balanced board | The frontier is wide; pick for flexibility and adjacency to ports / future trade partners |
| Picks late on a balanced board | Same flexibility logic; the bidding asymmetry is smaller |

This is a **Keynesian beauty contest** layered on the [bilateral trade valuation thesis](./bilateral-trade-valuation.md): you're not maximizing trade efficiency, you're maximizing position; and *what counts as good position* depends on what other players are bidding for.

### What this theory would predict (testable claims for Roman's data)

The frontier-and-bidding theory predicts patterns Roman's aggregate stats wouldn't see, but her dataset would:

- **Conditional on board archetype, winners cluster on the predicted strategy.** On wood/brick-rich boards, road-engine winners; on ore/wheat-rich boards, city-engine winners. The aggregate "winners favor city engine" is the population average, not the conditional truth.
- **Win rate of "obvious" strategies is lower than face-value, because of crowding.** Players picking obvious-path settlements late in the snake should underperform players counter-positioning, when the obvious-path bid is over-subscribed.
- **The 27% classifier ceiling improves dramatically when board-archetype is a feature.** Roman trained on per-player placement features; adding board-level features (resource distribution, port topology, second-pick adversary's archetype affinity) should push the classifier well above 30%.
- **Snake-order matters more on archetype-skewed boards than on balanced ones.** A clearly-city-engine board is a high-stakes auction; a balanced board is a low-stakes one. Snake-position win-rate variance should track board-archetype skew.

None of these are proven. They're the testable form of the theory. Roman's dataset has the inputs to test all four.

### Data access — what's available and what isn't (audited 2026-05-18)

The 47k-game dataset Roman analyzed is **not publicly downloadable**. Twosheep.io collected it on their platform and provided it to Roman directly. The video description has no link; Roman has published no code, GitHub, or blog post associated with the analysis (only an Instagram). Twosheep's own blog has done smaller public analyses (108 Champs games, 500+ 1v1 games) but never publishes the underlying data.

| Source | Scale | Public? | Notes |
|---|---|---|---|
| Twosheep.io 47k dataset (Roman's data) | ~47,000 games | **No** | Private; provided to Roman by twosheep directly |
| Twosheep.io replay browser at `twosheep.io/games?to=...` | All games on platform | Replays viewable, not exportable | Per-game replay only; no bulk export |
| Colonist.io game logs | 3M / month, 600GB total | **No** | Explicitly withheld; community [feature request](https://colonist.featureupvote.com/suggestions/87602) unfulfilled |
| `colonist.inpolen.nl` community archive | Currently 0 stored | Per-game JSON download mentioned | Personal use only; bulk scraping IP-banned |
| Kaggle `lumins/settlers-of-catan-games` | **50 four-player games, 200 rows** | **Yes** | The standard small public dataset; everyone's analysis uses this |
| Kaggle `thedevastator/...` and `koftezz/...` | Similarly small | Yes | Alternative small datasets, similar shape |

**The gap:** Roman's analysis at N=47k is ~1000× larger than the largest publicly downloadable Catan dataset. Her empirical landmarks (24.9% turn-order, 59% Longest Road, 25/40/55 Monopoly card, 8% even-trade win rate) cannot be reproduced or extended at scale without:

1. **Direct outreach** — contacting twosheep.io for research-grade data access, or asking Roman to share her code/data. Roman has an ORCID (active research scholar); plausible she'd share post-publication.
2. **DIY collection** — Chrome extension scraping Colonist + accepting the legal/IP-ban risk; multi-month accumulation timeline.
3. **Settling for 50 games** — the Kaggle dataset is statistically underpowered for the four testable predictions but is enough for proof-of-method work (does the direction of each prediction hold even at small N?).

**Strategic takeaway:** The frontier-and-bidding theory's empirical validation is gated by data access that doesn't currently exist. The theory remains internally coherent and connected to the [Monopoly project's frontier work](./monopoly/frontier-trade-theory.md), where Chris already has access to the simulator and can test analogous predictions. **Monopoly is the better proving ground for now** — same theoretical structure, full access to the data-generating process.

### The exact-vs-frontier architectural distinction

A genealogy point worth recording: the Monopoly project went through two distinct generations of trade-valuation tools, and the lessons map directly onto what a Catan frontier tool would and wouldn't be.

**Generation 1 — Exact bilateral valuation.** The [bilateral trade valuation page](./bilateral-trade-valuation.md) is the trajectory-based exact calculator: simulate both players' development paths under hypothetical trades, compute who wins what 20 turns later, score the trade against position deltas. It works brilliantly for **apples-to-apples trades** — "I'll give you my orange to complete your monopoly, you give me your dark blue to complete mine." In that situation, both players are completing monopolies, both dominate the rest of the field, and the math closes cleanly. **It also was known at the time to say almost nothing about 1:1 trades of non-completion properties** — where the strategic value of any single property depends on what *else* you might acquire, and the exact NPV calculation can't see that combinatorial structure.

**Generation 2 — Efficient frontier subgraphs.** The [frontier trade theory page](./monopoly/frontier-trade-theory.md) is the structural tool: each player has a *random portfolio* (the properties they hold from random landing), and the frontier subgraph shows the **Pareto-optimal expansion paths from that portfolio** — which trades or developments would move them toward dominance, which are strictly dominated. The frontier doesn't give exact valuations; it gives **strategic-value visibility** ("this property is on my critical path"; "that property is dominated for me but on Player B's frontier — so they'll trade hard for it") and eliminates frivolous exchanges by structural truth rather than enumeration.

**The two tools are complementary, not competing:**

| Tool | What it does | When to use |
|---|---|---|
| Exact bilateral simulation | Precise NPV-delta on a specific trade between two specific players | Apples-to-apples completion trades; bidding decisions on auctioned properties; high-stakes single-move evaluations |
| Frontier subgraph | Map of reachable strategic positions and their dominance relations | Long-horizon planning; deciding which trades to even consider; identifying counterparty leverage points |

The bilateral evaluator says "here's exactly what this trade is worth." The frontier subgraph says "here are the trades worth thinking about, here's what each player values, and here's the shape of the reachable strategy space."

### What a Catan frontier graph would look like

The Catan equivalent of the Monopoly frontier subgraph would map **possible expansion paths from each player's current state** — which is closer to the right shape for Catan than a bilateral evaluator would be (Catan has fewer crisp apples-to-apples trades than Monopoly's monopoly-completion structure).

**Inputs the Catan frontier tool would need (and what we have / lack from the 50-game dataset):**

| Input | Per-game cost to compute | Have in 50-game dataset? |
|---|---|---|
| Full hex layout (19 tiles with number tokens and resource types) | Read from game setup | ❌ Only the tiles a player's settlements touched |
| Port layout (9 ports around the coast) | Read from game setup | ⚠️ Partial — only ports adjacent to player settlements |
| Current settlements and cities for each player | Read from game state | ✅ Starting only; no mid-game expansion data |
| Current road network for each player | Read from game state | ❌ Not in dataset |
| Each player's current resource hand | Read from game state | ❌ Not in dataset |

The 50-game dataset is **not enough to build the frontier tool** — it has starting positions but no mid-game state, and no full board layout. But the algorithmic shape can be specified independently:

**The frontier algorithm (sketch):**

1. **For each player, compute reachable expansion vertices.** A vertex is reachable if you have a road network connecting to it, or if you have the resources + road-build chain to extend to it.
2. **For each reachable vertex, compute the build cost.** Number of roads + 1 settlement = (R × brick + R × wood) + (1 brick + 1 wood + 1 wheat + 1 sheep), where R is the number of new roads needed.
3. **For each reachable vertex, compute the production gain.** Sum of pip-weights of the three adjacent hexes for the new settlement (plus city upgrades available there).
4. **Pareto-filter the reachable positions.** A position is on the frontier if no other reachable position has both lower cost AND higher production gain.
5. **Frontier subgraph output:** the set of (position, cost, gain) triples plus the build-order constraints (you need road A before road B before settlement C).

**What the frontier graph shows:**

- **For each player:** their reachable expansion frontier (what they should build, in what order, given infinite resources)
- **Cross-player overlap:** if two players have a frontier-critical vertex in conflict, the player who reaches it first wins that vertex and the loser must reroute (this is the spatial-dominance angle of Longest Road)
- **Trade-relevant resources:** the resources missing from the player's current hand to reach their next frontier position. *This is the "what they value" signal.*
- **Threats:** opponents whose frontier includes blocking the current player's road network

**What the frontier graph doesn't show (and intentionally doesn't):**

- **Exact NPV of any single trade.** Frontier gives strategic value, not exact prices.
- **How to actually acquire the missing resources.** "You need 2 wood and 1 brick to complete the road" — the graph tells you what's missing but not how to get it (trade? wait for dice? attack with the robber? port-convert?). That's a separate problem layer.
- **Per-turn play.** Frontier is a planning artifact; per-turn decisions still need turn-level reasoning.

**The "you need X, Y, Z to get here, but the graph doesn't know how to get X, Y, Z" structure is the same as Monopoly's frontier subgraph.** Both tools answer "what's the destination worth pursuing" and leave "how to procure the inputs" to other components. In Monopoly the procurement is mostly trade; in Catan it's trade + production timing + dice + robber play. The split keeps both tools focused on what they're good at.

### Why this matters for the theory line

The whole [board-frontier theory sketch](#board-as-efficient-frontier--a-prescription-theory-sketch) earlier in this page can now be more precisely typed:

- The **opening placement** is a frontier problem at game start. Pick from the Pareto-optimal opening archetypes given the board.
- The **mid-game expansion** is a frontier problem within the game. From your current portfolio, what's the next Pareto-optimal expansion?
- The **trade decisions** are *implementation* problems that the frontier graph tells you *what to negotiate for* but not *how to price*. Pricing is the [bilateral trade valuation](./bilateral-trade-valuation.md) problem with the [asymmetric externality](./bilateral-trade-valuation.md#the-asymmetric-externality-reading-of-the-trade-efficiency-paradox) layer.

The vault's two Monopoly-project tool generations map directly onto two complementary Catan tools. We don't have the data to build either yet, but the architectural shape is now specified.

### Connection back to vault frameworks

This is **the [Monopoly project's frontier methodology](./monopoly/frontier-trade-theory.md) applied to Catan opening placement** — same shape, different game. The instinct generalizes:

- **Any game with random initial setup + sequential pick** has a stateful auction-frontier dynamic (Catan, Civilization start positions, drafting in MTG / fantasy sports, BattleTech force composition)
- **Any game with common-knowledge structure + competitive resource access** has a Keynesian-beauty-contest layer (MOO1 race/planet selection, Master of Magic spell-school choice, real estate, capital markets)
- **The optimal play in both cases is conditional on opponents' expected best-response, not on nominal first-order optimization** — which is exactly what [planner-LM composites](../planner-lm-composites.md) provide and bare LMs miss

The Catan theory and the Monopoly theory are two instances of the same underlying frontier-and-bidding analysis. **Formalizing one helps formalize the other; both are open vault threads worth continuing.**

## Rubber-banding and the skill-cap tension

Catan has very little rubber-banding by design. The main lever is the **robber** — when 7 is rolled, every player holding more than 7 cards must discard half, and the rolling player may move the robber to a specific tile, blocking production and stealing a card from one adjacent player. This is *mild* anti-hoarding pressure aimed loosely at the leader: high-producers tend to accumulate more cards, so the discard-on-7 rule strips them disproportionately. It's transparent, symmetric (applies to anyone over 7 cards), and rule-level — exactly the [good-rubber-banding profile](../../tags/games.md) the M.U.L.E. analysis named ([[feedback_rubber_banding_and_friction_patterns]]).

**Monopoly has effectively zero rubber-banding.** No mechanism redistributes from leader to laggards; the snowball just snowballs. Once one player owns three monopolies and the others own none, the game is structurally over — even if it takes 20 more turns to finalize. This is one reason Monopoly is widely disliked despite its iconic status: the loser-player experience drags long after the outcome is determined.

### The design tension

The case for *more* rubber-banding (egalitarian dynamics):
- Games stay interesting for all players through to the end
- Casual / family contexts are better served when no one is hopelessly behind
- The play experience generalizes to a wider audience

The case for *less* rubber-banding (skill-rewarding dynamics):
- A skilled player who pulls ahead should be able to *hold* that lead — that's the skill premium
- High-skill players develop and improve because there's a clear reward gradient
- Tournament play and competitive depth depend on this
- **Chess is the limit case** — zero rubber-banding, grandmaster gets ahead and stays ahead unless they make a skill mistake. Maximum skill ceiling.

Too little rubber-banding → runaway games where the early-game determines the late-game; losing players have nothing to do. Too much rubber-banding → all players bunched at the finish line, and the winner is whoever rolls the right number on the last turn. **Both extremes collapse to a less interesting game**, just in different directions:

| Rubber-banding level | Failure mode | Skill cap | Example |
|---|---|---|---|
| None | Runaway snowball, dead late-game for laggards | Maximum | Chess, Monopoly |
| Mild | Lead is defensible but pressure exists | High | Catan (robber), M.U.L.E. (auction + events), Power Grid |
| Heavy | Lead is hard to keep; the last turn matters most | Reduced | Mario Kart with blue shells |
| Total | Everyone tied at the end; dice/luck decides | Floor (≈ random) | Some racing-game catch-up AI; "everyone gets a trophy" |

The interesting question isn't "is rubber-banding good or bad" — it's *where on this axis is the game designed to land, and is the choice intentional?* Bunten's M.U.L.E. (1983) made a clear deliberate choice for mild, transparent, rule-level rubber-banding — that's the design master move the M.U.L.E. project documented. Catan made a similar choice with the robber. Monopoly made the opposite choice (no rubber-banding) — defensible at the time of design, but the snowball-then-finish-it problem is what makes modern players prefer game-night Catan.

### Skill cap as a design dial

A subtler version of the tension: **rubber-banding caps the skill ceiling.** When a leader can be reliably dogpiled or random-evented back to the pack, the skill premium of "playing well from a good position" collapses. Skilled players cannot translate their lead into reliable victory; the game becomes about *reading rubber-band moments* rather than about *executing strategy*. This is fun for newcomers but disincentivizes investment in skill development.

Chess at the extreme: grandmaster vs. amateur is a deterministic outcome. The skill premium is total. This is why chess is the canonical competitive game and not a popular casual one.

Most well-designed Eurogames (Catan, Terra Mystica, Brass) sit in the **mild rubber-banding** zone — enough leveling to keep games interesting without flattening skill. The trick is that the leveling is **at the rule level** (everyone faces the same discards-on-7, the same auction structure) rather than **at the mechanic level** (some hidden code targets the leader). Rule-level rubber-banding preserves competitive integrity; mechanic-level rubber-banding feels like the game cheating against the leader.

### Why this matters for AI play

A planner-LM composite or an EBM playing a rubber-banding-aware game needs to model **how much its lead is worth**. In Chess, a +2 advantage is worth ~certainty. In Catan with the robber, a +2 VP advantage is worth maybe 60% — opponents will robber-target you, dogpile via trade refusal, and the dev-card deck remains a wild card. A naive Catan AI that maxes for instantaneous expected VPs will systematically over-value early leads and under-invest in the *defensive* moves that protect them from rubber-band reversal. **Skill-cap calibration is part of opponent modeling.**

## N≥3 termination — interference completeness is the real mechanism

The [Multiplayer Coalition Problem](./multiplayer-coalition-problem.md) page already documents the **three-player stable state**: in any game where N≥3 and players can interfere with each other's development, weaker players gang up on the leader. The leader gets restricted; a new leader emerges; the cycle repeats. No coordination required — each weaker player independently arrives at the same conclusion (the leader is the biggest threat to my survival).

What makes the cycle *terminate* — that's where games differ structurally. The first reading of this thread put weight on hidden-random information as the kill switch. The sharper reading puts weight on **interference completeness**: can the dogpile actually stop progress, or only slow it?

### The two axes

**Interference completeness:**
- **Complete:** opponents can fully neutralize a player's progress. Armies destroyed, territories taken, resources confiscated, position erased. Risk and Diplomacy: complete. The dogpile can reduce a leader to zero.
- **Incomplete:** opponents can throttle progress but cannot stop it. Some channel of advancement continues regardless of others' wishes. Catan: incomplete — the dice roll resources every turn, robber blocks one tile of many, refusal-to-trade doesn't stop production.

**Hidden-random information:**
- **None:** every state visible to every player; perfect information.
- **Present:** opaque state that can carry uninterceptable progress (dev cards, hole cards, hidden orders).

The interaction matrix for whether N≥3 games **terminate under ideal play**:

| Interference | Hidden-random | Terminates under ideal play? | Example |
|---|---|---|---|
| Complete | None | ❌ Never — perfect-AI dogpile is stable | Hypothetical perfect-info Risk |
| Complete | Present | ⚠️ Only via persuasion / asymmetry exploit; fails vs. perfect AI | Risk, Diplomacy |
| Incomplete | None | ✅ Yes — un-suppressible progress accumulates | Hypothetical no-dev-card Catan |
| Incomplete | Present | ✅ Yes — production stream forces it; hidden-random adds timing | **Catan** |

The hidden-random kill switch helps games like Risk *almost* terminate, but it's not enough — Chris's sharpest point: **in Risk, high-level players treat 3+ cards AS-IF the player already has the turn-in armies**. That converts the hidden-random into common knowledge, neutralizing it. Good Risk players assume worst-case and plan accordingly, which collapses the asymmetry and restores the perfect-information dogpile. The card turn-in surprises a beginner; it doesn't surprise a planner.

The same move works in Diplomacy. Good players treat ambiguous-intent moves as if they're the worst plausible interpretation. Hidden-random becomes assumed-worst, and the dogpile re-stabilizes.

This is why **Risk and Diplomacy at high level require out-of-game persuasion to terminate.** The strategic stalemate is broken not by mechanical state but by *social negotiation* — convincing an opponent to defect from the optimal dogpile coalition. Diplomacy is the genre name for this and the literal mechanic of the game. Risk's endgame is full of meta-talk ("if you attack me I'll throw the game to him") because the on-board state cannot resolve the equilibrium by itself.

**Against a perfect AI that doesn't believe out-of-game promises, neither Risk nor Diplomacy would end.** This is the structural reason Cicero needed *both* a planner AND a language model — the language model is what does the persuasion the planner can't fake. [[cicero-press-diplomacy-captain-meme]] and [[Gunboat Diplomacy and Diplodocus]] together bracket this exact result: Cicero needs the language layer to handle the persuasion side; Diplodocus (pure planner, no language) wins only in Gunboat where persuasion isn't allowed.

### Catan is structurally different — and that's the design genius

Catan's interference is **incomplete in a specific way:** the production stream. Every turn, dice are rolled, and every adjacent settlement/city produces resources. You can rob one tile. You can refuse to trade. You can play knights to displace the robber to a defender's tile. But you **cannot stop the dice from coming up 6 and 8**, and as long as a player has high-pip settlements, they will accumulate resources regardless of what their opponents do.

This is why Chris's sharpest claim holds: **"In ideal play, Risk will never end, but Catan will always end."**

- Risk: ideal-play interference is complete → perfect-AI dogpile is stable → no termination
- Catan: ideal-play interference is incomplete → production stream forces accumulation → termination guaranteed

The dev cards add a *timing* element — they let a particular player end the game *sooner* than visible-state accumulation alone would — but they're not the structural termination mechanism. The structural mechanism is the un-suppressible production stream. Even in a hypothetical no-dev-card Catan, games would still end; they'd just end slower, with the winner being whichever player's pip exposure best survived the dogpile-throttle.

The "feels like chance" complaint is correctly diagnosed once you separate the two factors:

- **Production-stream determinism**: which player will accumulate enough to win is partly determined by their initial pip exposure (skill of placement) and partly by which specific numbers come up (luck of dice). The race to the finish line under dogpile pressure has a real luck component because the production stream is dice-driven.
- **Dev-card timing**: hidden VP cards can decide *which turn* the game ends, but not really *who* wins — the player who's accumulated the position to be in dev-card range is the player whose production stream has succeeded.

Both elements are partly luck. But the structural fact remains: Catan ends because production keeps happening, not because dev cards eventually reveal. The hidden-random is the timing layer; the un-suppressible production is the engine.

### Game-class comparison

| Game | N | Interference | Hidden-random | Ends under perfect AI? | Termination mechanism |
|---|---|---|---|---|---|
| Chess | 2 | Complete | None | Yes (zero-sum) | Direct |
| Risk | 3-6 | **Complete** | Card turn-ins | **No — needs persuasion** | Out-of-game diplomacy |
| Diplomacy | 7 | **Complete** | Hidden orders | **No — needs persuasion** | Out-of-game diplomacy |
| Coup | 3-6 | Complete (player elimination) | Hidden roles | Partly — hidden roles + bluffing | Bluff resolution |
| Poker (multi-way) | 3+ | Incomplete (you can only fold, can't take their stack except by winning hands) | Hole cards | Yes | Forced bet-stream + reveal |
| **Catan** | 3-4 | **Incomplete (production stream)** | Dev cards | **Yes** | **Production accumulation** |
| Monopoly | 2-8 | Incomplete (no direct attack; only refuse-trade and cash drain) | None significant | Yes (snowball) | Cash drain to zero |
| MOO1 (mp) | 3+ | Mostly complete (fleets can kill) | Hidden tech/fleets | Partly — hidden tech enables breakouts | Tech breakthrough + military |

The pattern: **incomplete interference is what makes a multiplayer game tractable for perfect AI**. Complete-interference games (Risk, Diplomacy) require the *language/persuasion* layer to terminate at all — which is exactly why Cicero needed an LM and why [[planner-lm-composites]] are the right architecture for that game class.

Catan, Poker, and Monopoly terminate without persuasion because their interference is structurally incomplete. The dice / cards / cash flow can't be fully throttled.

### Why this matters

For AI design: **the right architecture depends on whether the game is interference-complete.** A pure planner (Diplodocus-style) works in incomplete-interference games where mechanical state dominates. A planner-LM composite (Cicero-style) is required in complete-interference games where the language layer is the termination mechanism.

For game design: **interference completeness is a more load-bearing knob than hidden information.** A designer choosing N≥3 has to decide whether their game will terminate via mechanical accumulation (incomplete interference, like Catan) or via social negotiation (complete interference, like Risk/Diplomacy). The first works for casual / family / closed-system contexts; the second requires players who treat persuasion as a legitimate game move and willingly defect from optimal coalitions.

For the rubber-banding analysis above: the rubber-banding dial interacts with interference completeness. **Heavy rubber-banding on top of complete interference produces deadlock** (everyone bunched, can't escape). **Mild rubber-banding on top of incomplete interference produces the Catan zone** — skill-driven progress with leveling pressure but guaranteed termination. The design space isn't one-dimensional.

**The vault claim:** Chris's "Risk will never end, Catan will always end" is the cleanest one-line summary of the difference between these two N≥3 design families. It deserves to be stated explicitly: *interference completeness, not hidden information, is the structural termination determinant in N≥3 multiplayer games.*

### How complete-interference games actually terminate — bounded rationality

The perfect-AI result says Risk and Diplomacy should never end. In practice they end every weekend. What gives?

The answer is **bounded human rationality**, and Risk's two card-variant designs make this visible:

**Fixed turn-ins** (4-6-8-10-style, or fixed army counts per card type) — the turn-in value is bounded and predictable. Players can apply Chris's AS-IF rule cleanly: 3+ cards = treat as if the player already has roughly N armies coming. The hidden-random asymmetry collapses to common-knowledge worst-case, and the dogpile re-stabilizes. **Fixed turn-in Risk preserves the deadlock**, which is why high-level fixed-turn-in games end via persuasion / kingmaker plays rather than via mechanical state.

**Escalation turn-ins** — values grow *linearly but unboundedly*. Typical schedule is +5 per turn-in (e.g., ..., 20, 25, 30, 35, 40, 45, 50, ...). It's not exponential; each step is small. But there's no cap. After ~200 turn-ins in a long game, the value is ~1000 armies (by which point all players should have 2000+ total armies on the board). Mechanically this is just scale, and a perfect AI would track it perfectly. But **humans systematically under-update their threat models** for two reasons:

1. **Anchoring on the recent past, not the absolute scale.** Each +5 looks small in context — 30 → 35 is a 17% increase, feels like a tweak. But the cumulative effect over 100 turn-ins is a 500-army jump, which is several times the typical reinforcement budget. Players normalize to the *recent* turn-in value rather than re-anchoring on absolute board state.
2. **Long-game distraction and cognitive fatigue.** Escalation games run long; by turn 400+, players have spent hours tracking state across the board, and attention to single-channel threats (card-holders) degrades. The 1000-army-card-holder problem isn't a math problem — it's a *bandwidth* problem.

These aren't the same as the "exponential exceeds cognition" failure I initially described — they're closer to **anchoring bias + base-rate neglect + attention erosion over long games**. The math itself is trivially linear; the cognitive failure is in re-pricing the cumulative.

**The termination mechanism in escalation Risk is human cognitive failure to re-anchor**, not strategy. A perfect AI playing escalation Risk would dogpile card-holders much more aggressively than humans do, because the AI would correctly anchor on the *current* turn-in value rather than the early-game one. Against perfect AI, escalation Risk would also stall — just at a different scale than fixed Risk. The variant doesn't change the structural result; it changes how easily humans fall out of the deadlock.

### Why this matters

**Risk and Diplomacy are designed for humans, not perfect agents.** The "tractable termination via persuasion" mechanism and the "tractable termination via cognitive-scaling failure" mechanism are both **bounded-rationality exploits**. Strip the bound and the games revert to their structural form: indefinite deadlock.

This connects to several existing vault threads:

- **[[planner-lm-composites]]** — Cicero needed the language model not just for play-pretty-prose but because **the language layer IS the bounded-rationality interface**. The LM is what does the persuasion the planner can't fake; persuasion is what terminates complete-interference games. This is one structural step deeper than "Cicero uses an LM to talk nicely."
- **[[project_mule_zero_sum_paradox]]** — same conditional-equilibrium pattern. Equilibria depend on the player-pool's specific failure modes. Tournament-mode M.U.L.E. plays differently than casual M.U.L.E.; escalation Risk plays differently than fixed Risk; the *mechanism* is the rationality bound of the actual players.
- **[[LLM Grounding Problem]]** — LLMs would likely fail the same cognitive-scaling test that humans fail in escalation Risk. A 1000-army turn-in by turn 50 is the same kind of out-of-distribution problem as inflation-adjusted dollar amounts in long-running discussions. An LLM trained on early-game Risk transcripts (where turn-ins are 4-15 armies) would similarly under-update on late-game scale.
- **Economic parallels** — escalation Risk's anchoring failure is the same shape as Cantillon distortion ([[Inflation]], [[Equation of Exchange]]) — early-stage prices anchor the threat model; late-stage repricing is under-incorporated. The structural pattern is "**slow linear growth that compounds + anchoring on the recent past = exploitable asymmetry**." Boiling-frog dynamics at game scale.

**Generalizable lens:** when a multiplayer game terminates under perfect-AI theory it terminates "structurally" (production stream, forced bets, etc.). When it terminates only under bounded-rationality real players it terminates "experientially." Most successful complete-interference multiplayer games are experiential — Risk, Diplomacy, Coup, Werewolf, social-deduction generally. **They are designed *for* the bound, not despite it.** Strip the human and you strip the game.

This is one reason game-AI for these titles is genuinely hard: the AI must model not just optimal play but *the opponents' rationality bound*. Cicero's LM is doing exactly that — modeling what humans will believe and feel persuaded by. Diplodocus avoids the problem by playing Gunboat (no persuasion channel) — but that's a deliberately bounded variant where the rationality-failure exploit isn't available.

### A third bounded-rationality termination mode — the emotional leveler

The two mechanisms above (persuasion-for-defection, anchoring + fatigue) don't exhaust the failure modes humans bring to complete-interference games. A third mode worth naming is **emotional leveling** — players who break the dogpile equilibrium not because the math says they should, and not because their threat models are mis-anchored, but because they have an *aesthetic / emotional preference for board balance* that overrides strategy.

A worked example from a real play group: a player who didn't like it when army counts got "too high" would, on a whim, systematically attack across multiple opponents to "even things out." Mechanically suboptimal — he exhausted his own troops across several players, weakening himself. But the result was *exactly* what breaks the deadlock: he created a new asymmetric state where the next player's turn-in produced overwhelming advantage against a specific weakened target, often ending the game in 1-2 turns. The leveler player became an unintentional kingmaker for the next-up player.

This is a distinct bounded-rationality failure from the others:

| Failure mode | Trigger | Mechanism | Result |
|---|---|---|---|
| **Persuasion-for-defection** (fixed Risk, Diplomacy) | Out-of-game social pressure | Player abandons mathematically-optimal coalition for personal/social reasons | Defector becomes kingmaker |
| **Anchoring + fatigue** (escalation Risk) | Long-game cumulative scale | Player under-updates threat model for late-game card values | Card-holder accumulates uninterceptable advantage |
| **Emotional leveling** (any complete-interference game) | Aesthetic discomfort with imbalance | Player burns own position to "even" perceived inequality | Creates exploitable asymmetry for next-up player |

The Diplomacy parallel: there's a documented "longest tournament Diplomacy game ever" video series — high-tournament Diplomacy genuinely *does* stall for many hours / multiple game-sessions before terminating. The empirical signature of "perfect play → infinite" shows up exactly as you'd predict: among the skillest available humans (who don't make obvious anchoring or emotional-leveling mistakes), games trend toward indefinite. Termination requires *some* opponent to make *some* sub-optimal move — and the longer the tournament, the more reliably someone eventually does.

**The structural conclusion sharpens:** complete-interference games terminate in practice because real players have *multiple independent* bounded-rationality failures any of which can break the deadlock. Persuasion, anchoring, emotional leveling, plus boredom, ego-driven plays, alliance-as-friendship-test, etc. The game design doesn't need to exploit any specific bound — it just needs the *set* of human bounds to be large enough that, given N≥3 players over enough turns, at least one will fire. **Multiple-independent-bounds redundancy is how human play terminates structurally-infinite games reliably.**

This is also the empirical answer to "why hasn't a perfect Diplomacy AI just dominated the field by being unexploitable" — the answer is that there are some games (the longest ones) where the AI just *would not finish*, and human tournament play would beat it on time-budget alone. Cicero handled this by being able to *cause* the bounded-rationality failures (via persuasion) rather than just exploiting ones that happened to occur — which is the structural reason its language model is doing real strategic work, not just performative chatter.

## Where the randomness lives — Monopoly vs. Catan as a structural contrast

Both games are resource-allocation problems with random elements; both are vault research threads (Monopoly with deep work, Catan now sketched). But they are mathematically *different kinds* of problems, and naming the difference clarifies why the same frontier framework looks different in each, and why Catan was groundbreaking when it shipped.

### The core distinction

**Where in the game does the randomness actually live?**

| Game | Random axis | Deterministic axis | What the player optimizes |
|---|---|---|---|
| **Monopoly** | *Access* (dice rolls determine which fixed properties you land on, when) | Board configuration (same every game) | Convert randomly-dealt holdings into a winning portfolio via trade and development |
| **Catan** | *Terrain* (hex layout + number tokens + ports are different every setup) | Play sequence once board is set (snake-order + standard turn structure) | Read the board and commit to the strategy archetype the terrain supports |

This is two different problems sharing the same resource-allocation skeleton:

- Monopoly's randomness is on the **time** axis. *When* will I get my third light blue? *When* will my opponent land on Boardwalk with a hotel? The set of possible portfolios is fixed before the game starts; only the order of arrival is random.
- Catan's randomness is on the **configuration** axis. *Which* boards am I even playing? *What* are the resource probabilities I'll be acting against? The portfolio of possibilities itself is regenerated each game.

### Chris's compression

> *"Monopoly's efficient frontier is how to get from your random slice of the pie to a winning one. Catan is what are the high-probability resources that will be in play so I know what to play for or around."*

That's the whole structural difference in one line. Both are "frontier" problems, but the frontiers operate at different time scales:

- **Monopoly: portfolio-rebalancing frontier.** You're constantly trading dollars and properties to move along a Pareto frontier whose axes (the 28 properties, the railroads, the utilities) are fixed before the game begins. The frontier is *static in shape, dynamic in your position on it*.
- **Catan: terrain-reading frontier.** You're picking opening positions on a frontier whose shape itself was generated randomly five minutes ago. The frontier is *static once the board is set, but different game-to-game*.

### Why Monopoly is Markov-friendly and Catan isn't

This explains why [the Monopoly project](../../projects/monopoly/README.md) leans heavily on Markov chains and Catan-style analysis doesn't:

- A Markov chain wants a fixed state space with fixed transition probabilities. **Monopoly's board gives you exactly that** — the 40 spaces and the dice-and-card distribution define a stationary Markov chain that converges on landing-frequency probabilities. Every Monopoly analysis can build on those landing rates.
- **Catan changes the state space every game.** The hex layout, number assignment, and port positions are all re-randomized. You can build per-board Markov chains, but you can't build *the* Catan Markov chain. The randomness is at the wrong layer.

Catan trades one kind of math (Markov-on-time) for another (combinatorics-on-configuration plus per-board state-conditional analysis). It's actually a *harder* mathematical problem in the sense that it requires conditioning on the board archetype before any inference is valid. Roman's aggregate 47k-game stats blur exactly this conditioning, which is why her findings feel descriptive rather than prescriptive — she averaged across board-archetypes that demanded different strategies.

### Catan's modular board as a game design milestone

The modular hex-tile setup was Catan's **first-major-mainstream shift** to a different design axis when it shipped in 1995. Modular-board games did exist before Catan in niche / hobbyist circles — Avalon Hill's *Galactic Conquest* and other lesser-known titles experimented with variable setup — but the dominant 20th-century mass-market resource-allocation games (Monopoly, Risk, Axis & Allies, Diplomacy) all had fixed boards, and the design instinct was "fix the geometry, randomize the play through it." Catan was the first crossover hit to reverse this at scale: *randomize the geometry, deterministic the play through it*. The credit isn't strict invention; it's the move from niche-hobby experiment to mainstream-defining standard.

Game-design implications:

- **Replayability** — fixed-board games are eventually solved or at least heavily theorized (Monopoly EPT theory, Diplomacy opening books, Risk continent strategy). Modular-board games regenerate the puzzle each session.
- **Theory transfers differently** — fixed-board theory generalizes from game to game (Monopoly EPT in 2025 looks like Monopoly EPT in 1985). Modular-board theory is *meta-theory* (you don't learn "the best Catan opening"; you learn "how to read a board and pick the best opening *for it*").
- **Skill ceiling shape** — fixed-board games reward memorization-of-position; modular-board games reward pattern-recognition-across-configurations. Different cognitive workloads, different player demographics, different design pressure on rules.

Catan-style modular setup spread across the hobby after 1995 — see virtually every modern Eurogame (Terra Mystica, Scythe, Wingspan, Brass: Birmingham). Roman's analysis is best read as one of the first systematic empirical studies of the *modular-board class* of games rather than just of Catan specifically.

### Why this routes back to Monopoly first

The board-frontier theory's predictions need a data-generating process to validate against. **The vault has full access to one for Monopoly** (the simulator) and zero for Catan (Roman's 47k is private; Kaggle is 50 games). The structural contrast above explains *why* this is fine rather than a compromise:

- The Monopoly project is the right home for testing **"obvious portfolio crowding → counter-positioning pays"** — that's the time-axis frontier mechanic, fully observable in your simulator. Properties everyone is bidding for vs. monopolies others under-value (the brown trap analysis is already this).
- Once the time-axis form of the theory is mature, **migrating it to the configuration-axis form for Catan is straightforward** — same Pareto-frontier framework, different randomization layer. The simulator does the proving; Catan inherits the validated form.

**Cleaner framing:** Monopoly and Catan are not competitor analyses — they're complementary instances of the same frontier theory at different randomization layers. Validating one strengthens the other.

## Open questions the data could answer (but the video didn't)

- **Is there a stable "best opening placement archetype"?** The 27% classifier was simple; a deeper model might find that *certain combinations* of pip weighting + diversity + connectivity hit higher win rates. Would help distinguish "opening barely predicts" from "opening predicts within structural classes."
- **What's the optimal Monopoly card timing as a function of inventory state?** The 25/40/55 numbers are aggregate. A state-conditional policy could push higher — and is exactly what a planner-LM composite would learn from this data.
- **Trade efficiency distribution conditional on game phase.** Roman implies winners overpay strategically; do they overpay *more* late-game, or is the pattern uniform? Phase-conditional efficiency would reveal whether the "trade for position" instinct is universal or game-stage-specific.
- **How does Catan robber placement correlate with winning?** Knight cards (largest army) get measured by holding the bonus; robber placement *itself* (where to block) is barely covered. Likely high signal.

## Tags

[games](../../tags/games.md), [strategy](../../tags/strategy.md), [game-theory](../../tags/game-theory.md), [mathematics](../../tags/mathematics.md), [simulation](../../tags/simulation.md), [economics](../../tags/economics.md)
