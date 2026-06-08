---
status: active
created: 2026-06-08
---
# MIRR — 4X Strategy as Capital Allocation Under Uncertainty
> The central thesis of 4X strategy: **each turn is an investment decision.** Your production is capital; the available actions (economy, expansion, research, defense, offense) are competing investments; the right comparison metric is **MIRR** — return that is time-adjusted, risk-adjusted, and reinvested at *your empire's own growth rate*. Rank the options by MIRR, fund the top, reassess as the state changes. This is not a metaphor — the mathematical structure is identical to a firm allocating capital, which is why it is [Risk and Entrepreneurship](../economics/risk-and-entrepreneurship.md) applied to a game.

**Links (up):** [Risk and Entrepreneurship](../economics/risk-and-entrepreneurship.md) (the economics parent — profit as the reward for bearing risk; time preference), [Value and Profit](../economics/value-and-profit.md), [Insurance](../economics/insurance.md) (hedging research bets)
**Sibling (cousin instrument):** [Monopoly Frontier-Trade Theory](./monopoly/frontier-trade-theory.md) & [Subgraph Investment Optimization](./monopoly/subgraph-investment-optimization.md) — same capital-allocation root, a *non-4X* game; Markowitz frontier / EPT is the metric there, MIRR is the metric here.

> A **thesis page** (portable, source-independent). The worked numbers, per-game tiers, and simulator results live in the **specimens** it cites below — this page states the claim; they are its evidence.

## The thesis

Optimal 4X play reduces to the same problem as optimal business management: **allocate scarce capital (production) to the investment with the highest risk-adjusted return (MIRR) each period (turn), reassessing as conditions change.** The player who sees each turn as a capital-allocation decision beats the player running cached heuristics ("always factories first," "rush colony ships") — the heuristics are the deontological cache; the MIRR calculation is the consequentialist test you run when the situation deviates from the default.

| Business concept | 4X equivalent |
|---|---|
| Revenue | Production per turn |
| Capital expenditure | Economy / expansion / unit investment |
| R&D spending | Tech or spell research |
| Market expansion | Colony ships / new cities |
| Defense / insurance | Missile bases / garrisons |
| Acquisitions | Conquest |
| Opportunity cost | What you *didn't* build this turn |
| **MIRR** | The common currency for comparing all of the above |

## Why MIRR (not ROI, NPV, or IRR)

| Metric | Measures | Blind spot |
|---|---|---|
| ROI | Return per unit invested | No time dimension — *when* do returns arrive? |
| NPV | Returns discounted to present | Requires an arbitrary discount rate |
| IRR | Rate making NPV zero | Assumes reinvestment *at the IRR itself* (unrealistic) |
| **MIRR** | Effective return assuming reinvestment at your **actual growth rate** | Requires estimating your empire's growth rate |

```
MIRR = (FV_returns / PV_costs)^(1/N) − 1
   FV_returns compounded at YOUR empire's current growth rate (the reinvestment rate)
   N = turns
```

**The load-bearing insight:** the reinvestment rate is *your empire's growth rate, not the investment's own return.* A cheap immediate return (a factory) and a large delayed one (a colony) both get reinvested at whatever rate you're compounding at — so MIRR normalizes every option to your actual situation and makes them apples-to-apples across categories.

## The decision algorithm

```
Each turn:
  1. Assess state (map, neighbors, tech/spell tree, current production)
  2. For each investment category: estimate MIRR + attach a confidence level
       (high for economy/expansion; lower for military/diplomacy)
  3. Rank by MIRR
  4. Fund the top option
       — exception: mandatory minimums (some research, some defense)
       — exception: if the top two are close, split (diversify against uncertainty)
  5. Reassess next turn (state changed → re-rank)
```

**You don't need MIRR to the decimal — you need the *ranking* right.** Order-of-magnitude estimates suffice for correct decision ordering, which is the whole game. Real constraints keep the non-dominated set small (≈2–3 live options per turn); the framework's job is to prune, not to oracle.

## Three refinements the specimens forced

1. **Option value — prerequisites are call options.** A building or tech rarely pays only in resources; it *unlocks* capability. Model it as a call option: the strike price is the build/research cost, the payoff is the value of what it gates, discounted by turns-until-exercisable. **Total MIRR = direct MIRR + option MIRR.** (MoM's Sawmill→Longbowmen; MoO's Propulsion→reachable planets are the same structure — a step-function unlock, not a flow.)
2. **"Broken" strategies are high-MIRR bets at a time window.** A rush isn't strong because the unit is strong — it's strong because the return *lands exactly when it matters most* and decays afterward. MoM's Wraith rush has astronomical MIRR because 2 tiers of dominance arrive at turn ~15 when opponents have T1, then fades by the time T4 magic weapons exist. The window, not the unit, is the asset. (Games are decided at turn 15 when one player has T3 and everyone else has T1.)
3. **Research is a portfolio, not a queue.** Tech/spell payoff is random per-roll but stable across a diversified set; a split-research bonus rewards holding several fields. Phase-dependent: **concentrate early** (one capability that unblocks growth — like a startup), **diversify late** (a mature R&D portfolio). Hedging a critical path (e.g. 2/3 Propulsion + 1/3 Planetology = two routes to new planets) is buying [insurance](../economics/insurance.md): sacrifice a little expected speed to cap the catastrophic downside (no range tech at all).

## Why it transfers to the messy world

The economics parent ([Risk and Entrepreneurship](../economics/risk-and-entrepreneurship.md)) says profit is the reward for bearing risk correctly under uncertainty, with returns subject to time preference. A 4X opening is that problem *with the noise removed* — no market swings, no competitors in the single-player opening, deterministic mechanics. It is a clean test bench: the safe investment (factory) vs the entrepreneurial bet (colony) with a crossover where marginal safe return drops below marginal entrepreneurial return — the same structure as "should a business reinvest or expand?" **If MIRR ranks correctly here, the framework earns trust for the messier domains it abstracts.**

## Evidence ledger (specimens)

- **[MoO — Optimal Strategy](./moo1/optimal-strategy.md)** — where this thesis was derived. *Contributes:* the full framework, the 5-bucket investment menu with MoO numbers, research-as-portfolio-theory, and the layered-but-tractable common-currency argument.
- **[MoO — MIRR Analysis](./moo1/mirr-analysis.md)** — the operational test (`mirr.py`). *Contributes:* empirical factory-vs-colony crossover turns per race (Klackon T8, Sakkra T13, Human/Psilon T25) and the counter-intuitive finding that a production bonus helps *colonies* more than factories (more growth headroom); plus the model-gap list.
- **[moo1-opening-optimizer](../../projects/moo1-opening-optimizer/README.md)** (project) — *Contributes:* the simulation substrate (Phase 5) meant to produce the missing MIRR inputs (military/research/threat ROI).
- **[MoM — Tier System and MIRR](./master-of-magic/tier-system-and-mirr.md)** — the cross-game extension. *Contributes:* the **option-value** refinement (buildings as call options), **multiplicative stacking** (effective value is a product, not a sum — high-figure units have steeper investment curves), and the **time-window** thesis (Wraith rush as MIRR at its purest).
- **MoM — `masterofmagic` repo** (external) — *Contributes:* the Markov battle simulator grounding tier dominance (T5 Great Drake wins 100% vs everything T3 and below), which is what makes "reach the tier first" a real return.
- *(Open slot: any future 4X specimen — Civ, Stellaris, RotP — drops in here with its own contribution line.)*

## Open questions

- **Is the reinvestment rate stable enough to estimate live?** MIRR's whole advantage rides on a good growth-rate estimate; in practice the rate is itself a function of the allocation you're choosing — mild circularity worth bounding.
- **Can option-value MIRR be computed cheaply for deep prerequisite chains** (MoM's Barracks→Smithy→Armorer's→Cathedral, ~700 prod, 4 deep), or does it require full simulation?
- **Does the crossover-turn structure generalize**, or is "safe vs entrepreneurial with a single crossover" specific to the homeworld-opening sub-problem?

## Tags
[games](../../tags/games.md), [strategy](../../tags/strategy.md), [economics](../../tags/economics.md), [game-theory](../../tags/game-theory.md)
