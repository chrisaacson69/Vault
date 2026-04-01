# MOO1: MIRR-Based Investment Decision
> Applying Modified Internal Rate of Return to the factory-vs-colonizer decision. Instead of brute-force search, use a financial metric to determine which investment has a better return at each decision point.

**Status:** active — theory phase
**Created:** 2026-04-01
**Links:** [MOO1 Optimal Strategy](./moo1-optimal-strategy.md), [Risk and Entrepreneurship](../economics/risk-and-entrepreneurship.md), [Value and Profit](../economics/value-and-profit.md), [Bilateral Trade Valuation](./bilateral-trade-valuation.md)
**Project:** [moo1-opening-optimizer](https://github.com/chrisaacson69/moo1-opening-optimizer)

---

## The Decision

At any given turn, your homeworld's production can go toward:
1. **Build a factory** — immediate, small, compounding return
2. **Build toward a colony ship** — delayed, large, compounding return
3. **Research** — deferred return, unlocks future capabilities

The GA optimizer found good strategies by brute-force searching parameter combinations. But it doesn't explain *why* one strategy beats another. MIRR gives us that — a principled comparison of investment quality at each decision point.

## Why MIRR, Not IRR or NPV

**NPV (Net Present Value):** Requires a discount rate chosen in advance. In MOO1, what's the discount rate? It's not obvious — it depends on the game state. NPV is useful for comparing two specific cashflows but doesn't tell you the *rate* of return.

**IRR (Internal Rate of Return):** The rate that makes NPV = 0. Problem: IRR assumes reinvestment at the IRR itself, which is unrealistic. A colony that returns 50% doesn't mean you can reinvest those returns at 50%.

**MIRR (Modified IRR):** Fixes IRR's reinvestment assumption. Uses a realistic reinvestment rate (the return available from the *next* best alternative). In MOO1, the reinvestment rate is roughly the marginal factory return — because any production not spent on the colony ship goes to factories.

```
MIRR = (FV of positive cashflows at reinvestment rate / PV of costs at finance rate)^(1/n) - 1
```

## Factory MIRR

**Cost:** `factory_cost × base_robot_controls / 2` BC (one-time)

**Return stream:** `FACTORY_OUTPUT × mineral_mod` BC per turn, forever (until the factory is no longer manned)

**Constraint:** Factory only produces if manned (need `pop ≥ factories / robot_controls`)

**Example (Normal mineral, starting tech):**
- Cost: 10 × 2 / 2 = 10 BC
- Return: 1 × 1.0 = 1.0 BC/turn
- Simple payback: 10 turns
- But the return compounds (1 BC/turn → more factories → more BC/turn)

**The marginal factory return decreases when:**
- All factory slots are manned (no more room)
- Population hasn't grown enough to man the next factory
- The planet approaches its factory cap

## Colony Ship MIRR

**Costs (multi-part):**
1. Construction: 590 BC (spread over multiple turns of ship spending)
2. Maintenance drag: ~10 BC/turn while the ship exists (fleet maintenance)
3. Opportunity cost: BC spent on the ship could have been factories
4. Transit time: colony produces nothing during transit (dead turns)
5. Seed population: colonists sent reduce homeworld output

**Return stream:**
- Starts after transit (delayed)
- Grows logistically (slow start, accelerates, approaches cap)
- Eventually produces MORE than the homeworld if the planet is good
- But "eventually" can be 20-50 turns

**The marginal colony return depends on:**
- Planet quality (Rich/Ultra-Rich colonies have much higher MIRR)
- Planet size (bigger = more compounding room)
- Distance (more transit = more dead turns = lower MIRR)
- Seed population (more seed = faster start but higher homeworld cost)

## The MIRR Decision Rule

At each turn, compute:
1. **Factory MIRR** — marginal return of the next factory at current state
2. **Colony MIRR** — marginal return of starting (or continuing) a colony ship at current state

If factory MIRR > colony MIRR → build factory.
If colony MIRR > factory MIRR → build toward colony ship.

This should converge to the same optimal strategies the GA found, but with *explanation* — you can see exactly when and why the decision flips from "build factories" to "build colony ship."

## What the Simulation Data Should Show

From the existing GA results, we expect:
- **Early game:** Factory MIRR is very high (cheap, immediate return). Colony MIRR is low (huge cost, delayed return).
- **Crossover point:** As factory slots fill up (diminishing marginal return), colony MIRR surpasses factory MIRR.
- **Race effects:** Klackon's 2× production makes factory MIRR higher for longer (delay colonization). Sakkra's growth bonus makes colony MIRR higher earlier (colonize sooner). This should match what the GA found.

## Implementation Plan

1. **Extract production streams** from existing simulation histories (the `TurnResult` list)
2. **Compute marginal factory MIRR** at each turn: cost of next factory vs incremental production stream
3. **Compute marginal colony MIRR** at each turn: full colony ship cost vs new colony's production stream
4. **Plot the crossover** — when does colony MIRR exceed factory MIRR?
5. **Compare to GA results** — does the MIRR crossover match the optimal factory_target the GA found?

If it matches, we've explained the GA's result with a principled financial metric. If it doesn't match, we've learned something about what MIRR misses (interaction effects, timing, etc.).

## Connection to Vault Economics

This is [Risk and Entrepreneurship](../economics/risk-and-entrepreneurship.md) applied to a game:
- The factory is the safe investment (predictable, immediate, linear)
- The colony is the entrepreneurial bet (uncertain, delayed, exponential if it works)
- The crossover point is the moment when the marginal safe return drops below the marginal entrepreneurial return
- Exactly the same structure as "when should a business reinvest vs expand?"

The MOO1 simulator gives us clean data to test this because the game has no noise — no market fluctuations, no competitors (in single-player opening), no random events. It's a pure investment optimization problem. If MIRR works here, it validates the framework for messier real-world applications.

## Tags
moo1, gaming, economics, MIRR, investment, optimization
