# MOO1: MIRR-Based Investment Decision
> Applying Modified Internal Rate of Return to the factory-vs-colonizer decision. Instead of brute-force search, use a financial metric to determine which investment has a better return at each decision point.

**Status:** active — theory phase
**Created:** 2026-04-01
**Links:** [MOO1 Optimal Strategy](./optimal-strategy.md), [Risk and Entrepreneurship](../../economics/risk-and-entrepreneurship.md), [Value and Profit](../../economics/value-and-profit.md), [Bilateral Trade Valuation](../bilateral-trade-valuation.md)
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

## Initial Results (2026-04-01)

Implementation in [moo1-opening-optimizer/moo1/mirr.py](https://github.com/chrisaacson69/moo1-opening-optimizer/blob/master/moo1/mirr.py). Simulation-based factory MIRR (runs with/without extra factory, measures production difference) vs colony MIRR (full cost accounting: construction, maintenance, transit, pop loss).

**Normal 80-pop colony @ 3 parsecs, 50-turn horizon:**

| Race | Crossover Turn | Factories at Crossover | Pop | Interpretation |
|---|---|---|---|---|
| **Klackon** | **Turn 8** | 68 | 75 | 2× production makes colonies productive fast — colonize early |
| **Sakkra** | **Turn 13** | 76 | 99 | Fast pop growth fills colony quickly — colonize after minimal factories |
| **Human** | Turn 25 | 151 | 100 | No bonus — fill factories first, colonize after pop caps |
| **Psilon** | Turn 25 | 151 | 100 | Research bonus doesn't help early production — same as Human |

**Key finding:** The Klackon result was unexpected — the prediction was that 2× production would make factory MIRR higher for longer (delaying colonization). Instead, 2× production makes the COLONY more productive too, and the colony benefits more from the multiplier because it compounds from a fresh start. **The production bonus helps colonies more than factories because colonies have more growth headroom.**

**Rich colony target:** Colony MIRR exceeds factory MIRR from turn 1 for Klackon — the model says "colonize immediately, never build factories." This matches experienced player knowledge: if a Rich planet is nearby, always grab it first.

### Known Model Gaps

The current model simplifies several factors that would push the crossover EARLIER:

1. **Pollution** — waste cleanup eats production per factory. More factories = more waste = diminishing returns before the cap.
2. **Starting colony ship** — the game starts with one in flight. The real decision is the 2nd colony, not the 1st. Two colonies producing lowers the opportunity cost of the third ship.
3. **Pop transfer costs** — sending colonists takes transit turns and removes homeworld production during transit.
4. **Factory outpacing pop** — factories build faster than pop grows, creating unmanned factory periods where factory MIRR should tank.
5. **Factory MIRR oscillation** — discrete turn simulation creates noise in the marginal production difference.

All of these make factory MIRR worse and colony MIRR better — so the real crossover likely happens earlier than shown. The model is conservative in favoring factories.

## Implementation Plan (Next Steps)

1. ~~Compute marginal factory MIRR~~ — Done (simulation-based)
2. ~~Compute marginal colony MIRR~~ — Done (full cost accounting)
3. ~~Find crossover point~~ — Done (per-race analysis)
4. **Add pollution to factory MIRR** — waste cleanup reduces net return
5. **Model 2-colony start** — real decision is 2nd colony timing
6. **Add pop transfer mechanics** — transit delay, homeworld production loss
7. **Compare to GA results** — does MIRR crossover match optimal factory_target?
8. **Sensitivity analysis** — distance, planet size, mineral richness

## Connection to Vault Economics

This is [Risk and Entrepreneurship](../../economics/risk-and-entrepreneurship.md) applied to a game:
- The factory is the safe investment (predictable, immediate, linear)
- The colony is the entrepreneurial bet (uncertain, delayed, exponential if it works)
- The crossover point is the moment when the marginal safe return drops below the marginal entrepreneurial return
- Exactly the same structure as "when should a business reinvest vs expand?"

The MOO1 simulator gives us clean data to test this because the game has no noise — no market fluctuations, no competitors (in single-player opening), no random events. It's a pure investment optimization problem. If MIRR works here, it validates the framework for messier real-world applications.

## Tags
[games](../../../tags/games.md), [strategy](../../../tags/strategy.md), [economics](../../../tags/economics.md)
