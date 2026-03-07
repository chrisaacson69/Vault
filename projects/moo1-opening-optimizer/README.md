# MOO1 Opening Optimizer
> Turn-level economic simulator for Master of Orion 1 opening theory. Answers: when should you build the 2nd colony ship?

**Status:** planning
**Created:** 2026-03-07
**Links:** [MOO1 Optimal Strategy](../../research/gaming/moo1-optimal-strategy.md), [BattleValue](../../research/gaming/battle-value.md), [Gaming](../../research/gaming/README.md), [Risk and Entrepreneurship](../../research/economics/risk-and-entrepreneurship.md), [BattleTech Simulator](../battletech-simulator/README.md)

## Motivation

The [MOO1 strategy analysis](../../research/gaming/moo1-optimal-strategy.md) identifies the 2nd colony ship timing as the first big strategic decision — and shows it's a tractable optimization problem. The conventional wisdom ("build 100 factories first, then colonize") is likely wrong for long-horizon games, but proving it requires simulation because the variables interact:

- **Planet quality:** Rich/Ultra-Rich worlds have doubled/tripled factory output. A Rich colony pays back much faster than a Poor one.
- **Planet capacity:** A size-100 world has a different logistic growth curve than a size-30 world. Bigger planets compound harder.
- **Distance:** Every transit turn is dead production from the colonist in flight *and* a delayed colony start. A 3-parsec colony starts 3 turns earlier than a 6-parsec one.
- **Seed population:** Sending 1 pop vs. 5 pop to bootstrap the colony changes everything — more seed pop means faster factory building and faster logistic growth (further from zero, closer to the peak growth rate at C/2), but each colonist sent reduces homeworld production and shifts its logistic curve.
- **Homeworld opportunity cost:** Every BC spent on the colony ship is a BC not spent on factories, eco, or research at home. The marginal value of a homeworld factory depends on how many unmanned factory slots remain.
- **Fleet maintenance:** The colony ship (590 BC) generates ~10 BC/turn in maintenance overhead while it exists. Building and landing it fast reduces this drag.
- **Race modifiers:** Klackon (2× worker output), Sakkra (+100% pop growth), Silicoid (no eco cost), and Meklar (+2 factory controls) all shift the breakeven math differently.

The analytical framework in the strategy doc gets the direction right (colonies compound, factories don't, so colonize early), but can't give precise answers across the full parameter space. Simulation can.

## Approach

### Phase 1: Single-Planet Economic Engine

Model a single MOO1 planet's turn-by-turn economics:

```python
class Planet:
    pop: float           # current population (fractional, rounded for display)
    max_pop: int         # planet capacity
    factories: int       # built factories
    mineral: str         # ultra-poor | poor | normal | rich | ultra-rich

    def production(self, race) -> float:
        worker_out = pop * race.worker_output
        factory_out = min(factories, pop * race.factory_controls) * mineral_modifier
        return worker_out + factory_out

    def grow(self, eco_spending) -> None:
        # discrete logistic: ΔP = 0.1 * P * (1 - P/C) + excess_eco/20
        ...

    def build_factories(self, production_allocated) -> None:
        # factories += production_allocated / (10 / mineral_modifier)
        ...
```

Core formulas from game data:

| Mechanic | Formula |
|----------|---------|
| Worker output | `0.5 + (planetology_level × 1.5 / 50)` per colonist (×2 for Klackon) |
| Factory output | `1.0` per manned factory × mineral modifier |
| Factory controls | `2` per colonist (+2 for Meklar, scales with Robotics tech) |
| Mineral modifier | ultra-poor: 1/3, poor: 1/2, normal: 1, rich: 2, ultra-rich: 3 |
| Pop growth | `0.1 × P × (1 - P/C) + (eco_spend - waste_cleanup) / 20` |
| Waste cleanup | `factories × 0.5` BC (improves with planetology tech) |
| Factory cost | `10 / mineral_modifier` BC |
| Colonist cost | `20` BC (via eco spending) |
| Colony ship cost | `~590` BC |
| Fleet maintenance | proportional to fleet_value / total_empire_production |

### Phase 2: Two-Planet Simulator

Model the homeworld + one colony, with a colony ship build decision at turn T:

```
for colony_ship_start in range(1, 30):
    simulate 100 turns:
        - homeworld builds factories until turn colony_ship_start
        - homeworld builds colony ship (590 BC / production_rate = N turns)
        - colony ship transits (distance / speed turns)
        - colonist(s) deducted from homeworld pop
        - new colony starts growing
    record: total_empire_production at turn 50, 75, 100
```

Sweep across planet quality, distance, race, and seed population. Output: optimal colony_ship_start as a function of (quality, distance, race).

### Phase 3: Decision Guidelines

Distill simulation results into actionable rules:

- "As Klackon, if within 3 parsecs of a Rich world, start colony ship on turn X"
- "As Psilon, if nearest planet is Poor and 5+ parsecs away, build to Y factories first"
- Heat maps or lookup tables that a player can reference mid-game

### Phase 4 (Stretch): Multi-Colony Optimization

Extend to the full opening: when to build the 2nd, 3rd, 4th colony ships. When to start sending transports. When to switch from expansion to consolidation. This is where the DP approach from the strategy doc would apply — the state space grows but is still tractable with pruning.

## Technical Notes

- **Language:** Python. This is an economic sim, not a performance-critical combat sim. Thousands of 100-turn simulations run in seconds.
- **Validation:** Compare simulator output against known MOO1 behavior. The RotP (Remnants of the Precursors) Java source code has the exact formulas and could serve as ground truth. The GOG forum and Realms Beyond threads have player-verified growth tables to check against.
- **Output:** Tables and plots. Matplotlib for visualization. The key deliverable is a set of guidelines, not a tool the player runs live.

## Connections

This is the same class of problem as [BattleTech Simulator](../battletech-simulator/README.md) — both use simulation to answer questions that are analytically intractable due to interacting variables. The difference: BattleTech simulates combat (stochastic, high-dimensional), this simulates economics (deterministic given a strategy, lower-dimensional). This one is simpler and could serve as a warm-up.

The underlying economic reasoning — compound returns vs. linear returns, opportunity cost, investment timing — comes directly from [Risk and Entrepreneurship](../../research/economics/risk-and-entrepreneurship.md) and [Value and Profit](../../research/economics/value-and-profit.md). The simulator is those frameworks made executable.

## Open Questions

- **Reserve spending:** The game allows transferring production between planets via the reserve at a 50% penalty (except Rich planets, which break even). Does this change the optimal strategy? Probably — it means you can bootstrap a colony faster by subsidizing it from the homeworld.
- **Research interaction:** Early research spending competes with factory building and colony ships. When should you start putting points into propulsion/planetology? This interacts with the colony ship question because better range tech opens more colony targets.
- **Difficulty scaling:** Starting conditions change by difficulty level (more/fewer starting factories and population). Does the optimal strategy shift, or just the timing?
- **Multi-player extrapolation:** The sim ignores opponents. In a real game, the AI is also expanding. How does competition for planets change the calculus? (Answer: it makes early colonization even more important, pushing optimal colony ship timing earlier.)

## Tags

[games](../../tags/games.md), [game-theory](../../tags/game-theory.md), [economics](../../tags/economics.md), [strategy](../../tags/strategy.md), [python](../../tags/python.md), [simulation](../../tags/simulation.md)
