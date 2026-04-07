---
status: active
created: 2026-03-07
---
# Master of Orion — Optimal Play Strategy
> Derived strategy for the original 1993 4X. Race selection, opening theory, tech priorities, ship design through the BattleValue lens, diplomacy, and endgame paths.

**Links:** [Gaming](../README.md), [BattleValue](../battle-value.md), [The Multiplayer Coalition Problem](../multiplayer-coalition-problem.md), [Bilateral Trade Valuation](../bilateral-trade-valuation.md), [Risk and Entrepreneurship](../../economics/risk-and-entrepreneurship.md)

## Why MOO1

Master of Orion (1993, SimTex/MicroProse) is the cleanest 4X ever built. Ten races, six tech categories, simple ship design, one-screen colony management. The mechanics are transparent enough to analyze formally — unlike Civilization's sprawl, MOO1 lets you see the underlying systems and derive actual strategies rather than just accumulate heuristics.

The strategy guide by Alan Emrich and Tom Hughes coined the term "4X" (eXplore, eXpand, eXploit, eXterminate) to describe this game. The framework below treats each X as a phase with specific objectives and transition criteria.

## Race Tier List

Race selection is the single highest-leverage decision in the game. The racial bonuses are multiplicative with everything else you do.

### Tier 1 — Dominant

| Race | Core Advantage | Why It's Dominant |
|------|---------------|-------------------|
| **Psilon** | +50% research, Good in all 6 fields (0.8× cost), full tech tree | Technology compounds. A 50% research bonus on 80% cost means Psilons get techs nearly 2× faster than average races. The gap *widens* every turn because better tech → more production → more research → better tech. Left alone for 50 turns, Psilons are uncatchable. |
| **Klackon** | 2× population production | The only production bonus that scales for the entire game. Meklar +2 factory controls is additive and gets swamped by Robotics tech; Klackon doubling is multiplicative and stacks with every planetology upgrade. On turn 1, Klackons have ~33% more usable production than any other race after fleet maintenance. |

The Psilon vs. Klackon debate reduces to **compounding tech** vs. **compounding production**. Psilons win the late game; Klackons win the early game. Both snowball. The optimal play for either is to convert their advantage into territory before the other races can respond.

### Tier 2 — Strong

| Race | Core Advantage | Notes |
|------|---------------|-------|
| **Human** | Diplomacy bonus (all races trend friendly) | The diplomatic victory shortcut. Humans can win Council votes without military dominance. Trade treaties (which take ~30 turns to mature to full value) are essentially free income. The Humans' path is: expand enough to not get conquered, trade with everyone, win the vote. |
| **Sakkra** | +100% population growth | Cheap population = cheap expansion. Sakkra fill planets fast, which means more production sooner. Not as dominant as Klackon production doubling, but growth compounds similarly. |
| **Bulrathi** | +50 ground combat | Ground combat bonuses let you *capture* colonies instead of bombing them — preserving factories, population, and critically, *stealing tech* from conquered worlds. Trading colony control with AI is a viable tech-catch-up mechanic. |

### Tier 3 — Situational

| Race | Advantage | Limitation |
|------|-----------|------------|
| **Darlok** | Espionage bonus | Spy missions are high-variance. When they work, you steal critical techs for free. When they fail, relations crash and you face wars you're not ready for. |
| **Meklar** | +2 factory controls | Additive bonus. Strong early, diluted by Robotics tech. The Klackon bonus is strictly better at all stages. |
| **Mrrshan** | +4 beam attack | Only matters in tactical combat, which is a small fraction of the game's decision space. Ship design and fleet size dominate beam accuracy. |
| **Alkari** | +3 defense | Same problem as Mrrshan — tactical-only bonus. Helpful but not game-deciding. |
| **Silicoid** | Can colonize any planet, no ecology spending | Sounds amazing, but: no population growth bonus means you colonize everywhere but fill slowly. The production advantage from zero ecology is real but less impactful than Klackon doubling. Best exploited by early aggression — conquer the weakest AI to steal their infrastructure. |

## Opening Theory (Turns 1–50)

The opening is the most deterministic phase. Mistakes here compound for the rest of the game.

### Turn 1 Priorities

1. **Reassign population** — Move colonists from production to research. Your homeworld has factories; colonists on research accelerate your first critical techs.
2. **Scout** — Send your starting scout to the nearest stars. You need to know which planets are colonizable *immediately*.
3. **Fleet maintenance awareness** — On turn 1, fleet maintenance on your starting colony ship eats ~20% of production (14.6% for Klackons). Every turn the colony ship flies without landing is wasted production. Land it fast.

### Expansion Phase Objectives

- **Seal off territory** — Colonize systems that create a defensible border. The goal is maximum planet count behind minimum warp-lane chokepoints.
- **Never hit population cap** — A planet at population cap wastes growth. Build colony ships or send transports to new worlds before planets max out. Growth is the engine; capping it is like leaving money on the table.
- **Poor/Ultra-Poor planets are population farms** — Don't try to build factories on them. Ecology and research are not penalized on poor worlds. Use them as people generators feeding transports to your rich core worlds.
- **Missile bases on border worlds** — One or two missile bases per border planet deters AI aggression for dozens of turns. Cheap insurance. The trick: get a base mostly built, then dump reserves on the next turn to pop 2–3 bases at once instead of 1.

### The First Contact Decision

When you meet another empire, you face the game's first strategic fork:

- **Trade treaty** → ~30 turns to mature, provides free income split across planets. Always accept unless you're planning immediate war.
- **Non-aggression pact** → Buys time. Time favors the player with the better compounding advantage (Psilons want peace; Klackons can go either way).
- **War** → Only if you have clear military superiority *and* the target is adjacent. Early wars against distant enemies waste ships in transit while your borders are exposed.

## Technology Strategy

### The Randomized Tech Tree

MOO1's most distinctive mechanic: each game randomly removes ~50% of available techs from your tree. You will *never* have access to everything. This makes espionage, conquest, and trade essential — they're the only ways to fill gaps.

**Key exception:** Psilons see *all* techs in every field. This is the real reason they're tier 1 — it's not just the research speed, it's the elimination of randomness.

For all other races, every tech has a flat 50% chance of appearing regardless of your racial field rating. Your field rating (Poor/Average/Good/Excellent) only affects research *cost*, not tech *availability*.

### Research Cost Modifiers

| Rating | Cost Multiplier |
|--------|----------------|
| Poor | 1.25× |
| Average | 1.00× |
| Good | 0.80× |
| Excellent | 0.60× |

### Priority by Phase

**Early game (turns 1–50): Propulsion and Planetology**

- Propulsion = range. Without range extensions and better drives, you can't reach colonizable planets. Missing a critical drive tech as Klackon is the one scenario where they lose their advantage.
- Planetology = colony types. Expanding from Standard to Barren/Tundra/etc. worlds doubles or triples your available real estate. Terraforming techs directly increase population caps.

**Mid game (turns 50–150): Force Fields and Weapons**

- Class V Planetary Shields are a pivotal tech. Missile bases go from 2–3 absorption to 7–8 — a massive defensive leap. Humans get a 40% research bonus and wider selection in Force Fields, making this their signature tech.
- Weapons determine fleet effectiveness. The viable weapon path: Lasers (with armor piercing mod at the 150 RP tier) → skip Fusion/Neutron → Phasors. Fully modified lasers are the best early-game weapon per BV/Cost.

**Late game (turns 150+): Computers and Construction**

- Computers improve hit rates and espionage. Battle Computer upgrades are among the highest BV/Cost improvements you can make to existing ship designs.
- Construction tech reduces ship costs and increases durability. Combined with BV analysis, this is where you optimize fleet composition for the final push.

## Ship Design — BV Applied

Ship design is where [BattleValue](../battle-value.md) directly applies. Every design decision is a BV/Cost tradeoff.

### Design Principles

1. **Survivability first, damage second.** BV = sqrt(Attack × HP). Shields, armor, and ECM multiply effective HP — and HP is half the BV equation. A ship that survives one more round of combat does disproportionately more damage because it keeps firing.

2. **Split defense between shields and maneuverability.** Roughly 50/50 allocation. Low-cost ECM is worth taking if the next maneuverability tier is expensive.

3. **Warp speed > combat maneuverability.** MOO1 is a strategy game, not a tactics game. The ability to project force across the map (arriving before the enemy can respond) outweighs tactical dodge bonuses. Specify the best warp engine you can afford first; everything else is secondary.

4. **Bomber design: speed and bombs only.** Dedicated bombers should be the fastest hull with the best bombs and reserve fuel tanks. No shields, no beam weapons. The strategy: teleport next to the planet, bomb, retreat if bases survive, return next turn. Don't waste BV budget on combat stats for a ship that shouldn't be fighting ships.

5. **Missile ships: wait for Scatter Pack V or better.** Early missile tech has poor BV/Cost. Don't invest in missile fleets until the tech justifies it. Hyper-V and Hyper-X are generally not worth the cost.

### The BV/Cost Framework for Fleet Composition

Given a production budget, the optimal fleet maximizes total BV:

```
Total Fleet BV = Σ (BV_per_unit × count)
Budget constraint: Σ (cost_per_unit × count) ≤ budget
Optimal: maximize BV/Cost for each slot, then buy the max quantity of the best ratio
```

But remember the [BattleValue caveats](../battle-value.md#extensions-and-complications): range/initiative bonuses, first-strike damage, and counter-matchups all modify the pure BV calculation. A fleet of cheap high-BV/Cost fighters loses to a smaller fleet with longer range that kills half your ships before they fire — because units killed before firing contribute zero BV to the engagement.

### Concentration of Force

From Lanchester's Square Law (derived in the [BattleValue](../battle-value.md#lanchasters-square-law) analysis): splitting your fleet halves the count but *quarters* the combat power. Never fight two battles when you can fight one. This applies to both offense and defense:

- **Offense:** Mass your entire fleet at one target. Destroy it. Move to the next. Serial conquest beats parallel invasion.
- **Defense:** Don't spread missile bases evenly. Concentrate them on the 2–3 border worlds that face actual threats.

## Diplomacy and Espionage

### The AI's Logic

MOO1's AI is self-interested, not anti-player. AIs try to maximize their own standing, not gang up on the human. The galaxy typically divides into two mega-alliances or descends into chaos — rarely three stable blocs.

This means:
- You can exploit alliance dynamics. If two AIs are at war, ally with one and you'll quickly reach maximum friendship.
- Spy failures crash relations, but shared enemies restore them. Run espionage during wars when the friendship buffer absorbs the fallout.

### Espionage Strategy

- Keep spies on every empire, always.
- Default mission: **Hide** (reconnaissance, low risk of detection).
- During war: switch to **Espionage** (tech theft) against the target.
- **Sabotage** only if the target has no tech worth stealing.
- Budget: 10–15% of total income split between espionage and counter-espionage.
- Computer tech improves spy effectiveness — another reason Computers matter in mid-game.

### Trade Treaties

Trade treaties provide free income distributed across your planets. They take ~30 turns to reach full value, so sign them early and break them only for immediate military necessity. Trade income is production-agnostic — it boosts Poor planets and Rich planets equally, making it especially valuable for filling gaps in your empire's resource distribution.

## The Council Vote — Endgame

The Galactic Council convenes when 2/3 of planets are colonized, then every 25 years. This is the diplomatic victory condition.

### Mechanics

- Votes are proportional to population.
- AIs will vote against you if you're at war with them — even if it means handing victory to a third party.
- If the AI thinks you can self-vote to victory, *all* your allies will drop you and form a counter-alliance. Expanding past the threshold where you obviously control the vote triggers a galaxy-wide dogpile.

### Strategies

- **Human path:** Maintain friendly relations with everyone, leverage trade treaties and diplomacy bonuses, win the vote naturally. This is the cleanest win condition for Humans.
- **Psilon path:** Achieve such overwhelming tech superiority that your fleet is unchallengeable, then either win the vote from a position of strength or exterminate enough rivals that the vote is moot.
- **Filibuster:** If you can't win the vote, you can evade it by timing your military actions to destabilize the council — documented in the original strategy guide as a legitimate tactic.
- **Population awareness:** Keep your population growth calibrated. Growing too large too fast triggers the anti-player alliance. Sometimes it's better to cap growth and win quietly.

## The Meta-Strategy — Connecting the Phases

The optimal game follows a clear arc:

1. **Explore (turns 1–20):** Scout, identify colonizable worlds, plan your border.
2. **Expand (turns 20–60):** Colonize everything reachable, seal borders with missile bases, sign trade treaties.
3. **Exploit (turns 60–150):** Research mid-game tech, optimize ship designs using BV/Cost, run espionage to fill tech gaps, build economy.
4. **Exterminate (turns 150+):** Concentrate fleet, serial conquest of weakest neighbor, absorb their territory and tech. Repeat until you control enough population/planets to win the Council vote or eliminate all opposition.

The key insight: **each phase has a transition trigger, not a fixed turn count.** You transition from Explore to Expand when you've identified your territory, not on turn 20. You transition from Exploit to Exterminate when your BV/Cost analysis shows fleet superiority, not on turn 150. Playing on a timer instead of reading the board is the most common mistake.

### The Interest Rate Analogy

From [Risk and Entrepreneurship](../../economics/risk-and-entrepreneurship.md): every investment has an opportunity cost measured against your implicit "interest rate" — the return you'd get from the default alternative.

In MOO1, the default alternative is *growth*. Every resource spent on military is a resource not spent on production, research, or expansion. The "interest rate" of growth is roughly your compound production increase per turn.

Military spending is justified only when the expected return (conquered territory, eliminated threat, stolen tech) exceeds the opportunity cost of that same production invested in growth. This is why early wars are usually wrong — the growth rate is highest early, so the opportunity cost of diverting to military is highest. And why late-game wars are usually right — growth has plateaued, and the marginal return on conquest exceeds the marginal return on internal investment.

## Mathematical Opening Theory — When to Build the 2nd Colony Ship

The opening is the most analyzable phase of MOO1 because it has the fewest variables. Can we derive the optimal turn to begin building the second colony ship?

### The Core Mechanics (Extracted from Game Data)

**Production formula:**

```
Total_Production = (Pop × worker_output) + (Factories_manned × 1.0)
worker_output = 0.5 + (planetology_level × 1.5 / 50)   # starts at 0.5 BC/colonist
Factories_manned = min(Factories, Pop × factory_controls)  # starts at 2 per colonist
```

Klackons double the worker_output term (1.0 BC/colonist at start).

**Population growth (discrete logistic):**

```
ΔP = 0.1 × P × (1 - P/C) + (eco_spending - eco_minimum) / 20
```

Where P = population, C = planet capacity, eco_minimum = waste cleanup cost. Growth peaks at P = C/2 and is rounded to nearest 0.1.

**Key costs:**

| Item | Cost (BC) |
|------|-----------|
| Factory | 10 |
| Colonist (via eco) | 20 |
| Colony ship | ~590 |
| Scout | 10 |
| Missile base | ~50 (varies with tech) |

**Starting conditions (Impossible difficulty):**

- 40 population, 30 factories on homeworld
- Starting production: 40 × 0.5 + 30 × 1.0 = 50 BC
- Fleet: 1 colony ship (590 BC), 2 scouts (10 BC each) → 610 BC fleet value
- Fleet maintenance: ~20% of production (~10 BC/turn lost to maintenance)

**Net usable production:** ~40 BC/turn on turn 1.

### The Colony Ship Investment Problem

Building a colony ship costs ~590 BC. The question is: **at what turn does diverting production from factory-building to colony-ship-building maximize total empire production at some future horizon T?**

This is a classic **investment timing problem** — identical in structure to the entrepreneurial judgment framework in [Risk and Entrepreneurship](../../economics/risk-and-entrepreneurship.md).

#### Model Setup

Let's define two strategies and compare them:

- **Strategy A (Early Ship):** Start building the 2nd colony ship immediately (turn 1). At ~40 BC/turn net production, it takes ~15 turns. Colony lands around turn 18 (15 build + 3 transit). New colony starts at 2 pop, 0 factories.
- **Strategy B (Factories First):** Spend the first N turns building factories on the homeworld, then build the colony ship. The ship is faster to build (higher production), but the colony starts later.

#### Factory ROI Analysis

Each factory costs 10 BC, produces 1 BC/turn, costs 0.5 BC/turn in waste cleanup = **0.5 BC/turn net**.

**Factory payback period:** 10 / 0.5 = **20 turns**.

This means a factory built on turn 1 breaks even on turn 21. A factory built on turn 5 breaks even on turn 25. The ROI is fixed at 5% per turn.

#### Colony ROI Analysis

A new colony starts at 2 pop, 0 factories. Its first-turn production is 2 × 0.5 = **1 BC**. But unlike a single factory, a colony is a **compound growth engine** — it grows population, builds factories, and its output accelerates.

Modeling the new colony's growth (assuming all production goes to factories, eco stays at minimum):

| Turn after landing | Pop | Factories | Production | Cumulative |
|-------------------|-----|-----------|------------|------------|
| 0 | 2 | 0 | 1.0 | 0 |
| 5 | 3 | 4 | 5.5 | ~15 |
| 10 | 4 | 8 | 10.0 | ~55 |
| 15 | 6 | 12 | 15.0 | ~120 |
| 20 | 9 | 18 | 22.5 | ~225 |
| 25 | 13 | 26 | 32.5 | ~365 |
| 30 | 18 | 36 | 45.0 | ~560 |

(Population growth uses ΔP = 0.1 × P × (1 - P/C) with C ≈ 50 for a standard planet; factory build rate = production allocated to industry / 10.)

**Colony payback:** The colony ship cost (590 BC) plus the lost production from the homeworld during build. At ~40 BC/turn, building the ship costs 15 turns × 40 BC = 600 BC of homeworld production opportunity cost, plus the 590 BC ship cost is an accounting identity (the production *is* the ship). The real opportunity cost is the ~15 turns of factories not built.

15 turns of factory-building at 40 BC/turn = ~60 factories. Each producing 0.5 BC/turn net = 30 BC/turn permanently.

**The crossover question:** When does the new colony's cumulative production exceed what those 60 factories would have produced?

- 60 factories produce 30 BC/turn starting immediately
- The colony produces ~0 initially, ramping to ~45 BC/turn by turn 30

**Rough crossover: ~35–40 turns after the colony ship build decision.**

#### The Key Insight: Time Horizon Determines the Answer

If you're optimizing for production at turn 50 (short game), factories first is better — the colony hasn't paid back yet.

If you're optimizing for turn 100+ (which you are in any serious game), the colony wins decisively because:

1. The colony's growth is **compound** (logistic, not linear)
2. The colony becomes a second production center that can build *its own* colony ships
3. Each planet adds population, which adds research, which accelerates tech, which boosts *everything*

This is the same reason compounding investments beat fixed-rate returns in [Value and Profit](../../economics/value-and-profit.md) — the exponent always wins given enough time.

#### Optimal Timing Formula

The optimal turn T* to start building the colony ship satisfies:

```
Marginal factory production at T* = Colony NPV per turn delayed
```

In words: **build the colony ship when the marginal value of one more turn of factory-building on the homeworld equals the marginal value of the colony arriving one turn sooner.**

Since colonies compound and factories don't, this crossover happens early. The approximate answer:

- **Standard race:** Build 2nd colony ship as soon as your homeworld has enough factories to man all colonists (Pop × 2 factories). Beyond that, excess factory-building has diminishing returns because you need population to man them, and population growth is slow without eco spending.
- **Klackon:** Even earlier, because their doubled worker output means factories are relatively less important (the pop-to-factory ratio matters less when each colonist produces 1 BC instead of 0.5).
- **Numerical estimate:** For a standard race starting with 40 pop / 30 factories (10 unmanned factory slots), fill those 10 slots (~100 BC = 2.5 turns), then immediately start the colony ship. **Optimal build start: turn 3–5.**

#### The "Factories First" Fallacy

The popular advice to "build factories for at least 10 turns before your first colony ship" is suboptimal. It's correct that factories have a faster *short-term* payback (20 turns vs. 35+ for a colony), but it ignores:

1. **Population caps your factory utility** — you can only man 2 factories per colonist. Once all colonists are manning factories, excess factories sit idle until pop grows.
2. **Compound returns dominate** — the colony creates a second growth engine; factories at home are purely linear.
3. **Map control is nonlinear** — colonizing a planet denies it to opponents. Delay means the AI takes it. The opportunity cost of losing a planet is much harder to quantify but potentially enormous.
4. **Fleet maintenance burns every turn** — your starting colony ship costs ~10 BC/turn in maintenance while it sits. Landing it and building the 2nd ship saves that overhead.

#### The Real Formula You'd Want to Solve

For a fully rigorous answer, you'd simulate:

```
maximize: Σ(t=0 to T) Empire_Production(t)

where Empire_Production(t) = Σ over all planets of Planet_Production(planet, t)

subject to:
  - colony ship build requires ~590 BC accumulated from a single planet
  - new colony starts at 2 pop, 0 factories
  - population follows logistic growth ΔP = 0.1 × P × (1 - P/C)
  - factory build rate = production_allocated / 10
  - production = pop × worker_output + min(factories, pop × 2)
  - fleet maintenance proportional to total fleet value / total empire production
```

This is a **dynamic programming problem** with a small enough state space to solve exactly for fixed map configurations. The state is (homeworld_pop, homeworld_factories, colony_pop, colony_factories, turn) — maybe 50 × 100 × 50 × 100 × 100 = 2.5 billion states, which is large but within reach of a focused DP implementation with pruning.

A simpler Monte Carlo approach: randomly sample 1000 opening strategies (vary colony ship build start from turn 1 to turn 20), simulate each for 100 turns, and plot total empire production at turn 100 as a function of colony ship build start turn.

**This is a tractable problem. The opening can likely be solved.** See [MOO1 Opening Optimizer](../../../projects/moo1-opening-optimizer/README.md) for the simulation project that will answer this definitively.

## The Bad-Start Adaptation Problem

The analysis above optimizes the *good-start* case: open space, colonizable planets in range, no immediate military threat. The numbers are clear — factory ROI is 5%/turn, colonies compound, expand early, factories first is a fallacy.

But map generation is highly random. Bad starts are common: Ultra-Poor homeworld neighbors, Bulrathi two parsecs away, no colonizable planets within range, critical propulsion tech missing from the tree. When this happens, the good-start numbers don't apply, and the decision framework collapses because **the ROI of each investment option changes and the new numbers don't exist yet.**

### The Investment Menu Under Adversity

At any turn, production can go to one of five buckets:

| Investment | Good-Start ROI | Bad-Start ROI | Status |
|-----------|---------------|---------------|--------|
| Factory | 5%/turn (known) | Same, but population-capped sooner on small/poor worlds | **Known** |
| Colony ship | ~3% compound (known) | Depends on target quality; may be negative if only Poor planets available | **Partially known** |
| Missile base | 0% in peacetime | Unknown — depends on threat proximity, neighbor aggression, fleet strength | **Unknown** |
| Research | Varies by tech | Varies more — propulsion to reach better planets? Planetology to colonize hostile worlds? | **Unknown** |
| Military fleet | 0% in peacetime | Unknown — deterrence value? Conquest value? | **Unknown** |

The good-start case has two unknowns (research, military) that don't matter because they're dominated by expansion. The bad-start case has *three or four* unknowns that are suddenly the only viable options. You can't iterate to convergence when most of the ROI figures are missing.

### What Numbers Are Needed

**1. Missile Base ROI as a Function of Threat**

A missile base costs ~50 BC and produces 0 BC/turn in peacetime. In wartime, it prevents the loss of a planet worth potentially thousands of BC in accumulated infrastructure. The ROI is:

```
ROI(base) = P(attack) × E[damage_prevented] / cost
```

`P(attack)` depends on: neighbor distance, neighbor aggression (Bulrathi high, Psilon low), your relative fleet strength, diplomatic state. `E[damage_prevented]` depends on: what you'd lose if the planet falls (pop + factories + strategic position).

Neither term has been quantified. The [opening optimizer](../../../projects/moo1-opening-optimizer/README.md) Phase 5 identifies this gap but doesn't fill it.

**2. Research ROI Under Constraint**

When the map is bad, research may be the highest-ROI investment because it *changes what's available*:

- Propulsion tech → new planets in range (converts a dead subgraph to a live one)
- Planetology tech → hostile worlds become colonizable (adds nodes to the graph)
- Force fields → missile bases become more effective (multiplies defense ROI)

The ROI of research depends on what tech you'll actually get (randomized tree), how soon it pays off, and what alternatives exist. This is a multi-armed bandit problem — explore (research) vs exploit (build with current tech).

**3. Information Value of Scouting**

The first scout resolves enormous uncertainty about which investment path to take. Knowing your neighbors' identity, distance, and disposition lets you pick the right branch. The expected value of scouting is the difference between:

- Average payoff of the optimal strategy *given perfect information* about neighbors
- Average payoff of the best *unconditional* strategy (blind to neighbors)

This difference is likely highest in the first 10 turns, when uncertainty is maximum and the cost of misallocation compounds furthest.

**4. The Adaptation Trigger**

The hardest number to derive: **when should you abandon the expansion plan?** The subgraph optimization framework ([Subgraph Investment Optimization](../monopoly/subgraph-investment-optimization.md)) says: take the action with highest risk-adjusted EV from your current position. But identifying the crossover point — the turn where military/research ROI exceeds expansion ROI — requires all the numbers above.

## MIRR: The Generalized Decision Framework

### The Thesis

**Optimal play in a 4X is finding the highest-return investment each turn.** This is the same thesis that drives the Monopoly subgraph trade engine and the vault's economics framework — the player is an entrepreneur making investment decisions under uncertainty. Each turn's production is capital to allocate. The question is always: what gives the best risk-adjusted return?

Simple ROI fails because it ignores time. A factory's 5%/turn ROI looks worse than a colony's ~12% eventual ROI, but the factory's returns arrive immediately and compound into everything you build afterward. The colony's returns are delayed, and during the delay your empire is growing at the pre-colony rate.

The framework from finance that handles this: **Modified Internal Rate of Return (MIRR).**

### What MIRR Captures That ROI Doesn't

| Metric | What it measures | Blind spot |
|--------|-----------------|-----------|
| ROI | Return per unit invested | No time dimension — when do returns arrive? |
| NPV | All returns discounted to present | Requires choosing a discount rate (arbitrary) |
| IRR | Rate that makes NPV zero | Assumes reinvestment at the IRR itself (unrealistic) |
| **MIRR** | Effective return assuming reinvestment at your ACTUAL growth rate | Requires estimating your empire's growth rate |

MIRR's formula:

```
MIRR = (FV_returns / PV_costs)^(1/N) - 1

where:
  FV_returns = future value of all returns, compounded at your reinvestment rate
  PV_costs = present value of all costs
  N = number of turns
  reinvestment rate = your empire's current production growth rate
```

The key insight: **the reinvestment rate is YOUR empire's growth rate, not the investment's own return.** A factory's 0.5 BC/turn gets reinvested at whatever rate your empire is currently growing. A colony ship's delayed returns also get reinvested at that rate once they arrive. MIRR normalizes everything to your actual situation.

### The Investment Menu with MIRR

For each investment option available on a given turn, estimate:

**1. Factories (known, calculable)**
```
Cost: 10 BC per factory
Returns: 0.5 BC/turn net (1.0 gross minus 0.5 waste), starting immediately
Constraint: only useful up to pop × factory_controls
MIRR: high early (immediate returns), falls off as you hit the manning cap
```

**2. Colony Ship (known, calculable)**
```
Cost: ~590 BC + opportunity cost of turns spent building
Returns: compound growth curve (logistic), delayed by transit + development
Data available: population growth model, factory build rates from vault page
MIRR: low short-term (delay), high long-term (compound), depends on target planet quality
Calculable: yes — simulate colony development curve, compute MIRR at your reinvestment rate
```

**3. Research (partially calculable)**
```
Cost: production diverted from other uses (turns × research allocation)
Returns: tech payoff — varies by category and what you get
Data available: tech costs are roughly known (base costs × field cost modifier × randomization)
    - Propulsion: unlocks new planets (step function — suddenly new colonies possible)
    - Planetology: colonize hostile worlds (new nodes in the subgraph)
    - Construction: reduce factory/ship costs (multiplier on all future production)
    - Computers: better targeting + spy defense (situational)
    - Force Fields: better shields + missile bases (defensive multiplier)
    - Weapons: better offense (military multiplier)
Expected value: calculable if you know the tech tree probabilities for your race
MIRR: highly variable. Propulsion when you have no reachable planets = extremely high.
       Weapons when at peace with no neighbors = near zero.
Simplification: categorize as "unlocks new capability" (high MIRR) vs "improves existing
                capability" (moderate MIRR) vs "situational" (calculate only when relevant)
```

**4. Missile Bases (calculable with threat estimate)**
```
Cost: ~50 BC per base (scales with tech)
Returns: 0 BC/turn in peacetime. In wartime: prevents planet loss.
    Expected value = P(attack) × E[value_of_planet_preserved]
    P(attack) ≈ f(neighbor_distance, neighbor_aggression, relative_fleet_strength, diplomacy)
    E[value_preserved] ≈ accumulated_factories × factory_cost + population_value + strategic_position
MIRR: zero in guaranteed peace, potentially infinite if planet would be lost without it
Simplification: compute break-even P(attack). If your estimate of attack probability exceeds
                break-even, build the base. Otherwise, skip.
```

**5. Military Fleet (highest variance)**
```
Cost: ship_design_cost × quantity + maintenance_per_turn ongoing
Returns:
    Offensive: E[planets_conquered] × E[planet_value] - E[fleet_losses]
    Defensive/Deterrent: reduction in P(attack) on border worlds
    Value of conquest: factories + population + tech stealing (Bulrathi specialty)
Data available: ship costs calculable from BattleValue framework
    BattleValue([your fleet]) vs BattleValue([their fleet]) gives win probability
    Planet value calculable from production model
MIRR: heavily situation-dependent. Weak neighbor with good planets = high.
       Strong neighbor with nothing worth taking = negative.
Simplification: only compute when military action is being considered.
                Default: military MIRR ≈ 0 until a specific opportunity presents.
```

### The Decision Algorithm

```
Each turn:
    1. Assess game state (map, neighbors, tech tree, current production)
    2. For each investment category:
        Estimate MIRR given current state
        Attach confidence level (high for factories/colonies, lower for military)
    3. Rank by MIRR
    4. Allocate production to highest-MIRR option
        - Exception: mandatory minimums (some research always, some defense always)
        - Exception: if top 2 are close, split production (diversification against uncertainty)
    5. Next turn: reassess (game state changed, re-rank)
```

This is the **entrepreneurial judgment framework** from [Risk and Entrepreneurship](../../economics/risk-and-entrepreneurship.md) applied to 4X: each turn is an investment decision under uncertainty. The player who consistently finds the highest-MIRR option — accounting for risk, timing, and reinvestment — wins.

### Data Collection Plan

Much of the data needed to compute MIRR for each category is derivable from the game mechanics without exhaustive simulation:

**Already known (from vault + game mechanics):**
- Factory cost and return curve
- Colony development curve (logistic growth model)
- Ship costs (calculable from design + BattleValue)
- Missile base costs (scale with tech level)
- Tech base costs per field per race (race field modifiers are known)

**Needs estimation but is bounded:**
- Tech payoff: categorize techs by type (unlocking vs multiplier vs situational), estimate the production impact of each type. Doesn't need to be exact — the RANKING is what matters, not the precise number.
- Attack probability: model as a function of (distance, aggression_trait, fleet_ratio). Even a rough model beats the current approach of guessing.
- Conquest value: planet value is calculable (population × production + factories). The unknown is fleet loss, which BattleValue can estimate.

**The key simplification:** You don't need precise MIRR to the decimal. You need the RANKING to be correct. If factory MIRR ≈ 8%, colony MIRR ≈ 6%, research MIRR ≈ 15% (because propulsion unlocks 3 new planets), you don't need the exact numbers — you need to know research is the top priority this turn. Order-of-magnitude estimates are sufficient for correct decision ordering.

### The Thesis Restated

Optimal 4X play reduces to the same problem as optimal business management: **allocate scarce capital (production) to the investment with the highest risk-adjusted return (MIRR) each period (turn), reassessing as conditions change.** This is not a metaphor — the mathematical structure is identical:

| Business concept | 4X equivalent |
|-----------------|---------------|
| Revenue | Production per turn |
| Capital expenditure | Factory/colony ship/research investment |
| R&D spending | Tech research |
| Market expansion | Colony ships |
| Defense/insurance | Missile bases |
| Acquisitions | Conquest |
| Opportunity cost | What you DIDN'T build this turn |
| MIRR | Your tool for comparing all of the above |

The player who internalizes this — who sees each turn as a capital allocation decision and evaluates options by their time-adjusted, risk-adjusted return — will consistently outperform players who rely on cached heuristics ("always build factories first," "rush colony ships," "tech up before expanding"). The heuristics are the deontological cache. The MIRR calculation is the consequentialist testing phase. The best players do both: follow heuristics by default, calculate when the situation deviates from the default.

### Research Allocation: Portfolio Theory in a Tech Tree

The research system adds a layer of complexity that makes the MIRR calculation more interesting — and maps directly to portfolio theory from finance.

#### The Discovery Mechanic

Research isn't deterministic. The process:

1. **Fill the lightbulb:** Spend RP equal to the tech's base cost. This is deterministic.
2. **Discovery rolls:** Once the lightbulb is full, overflow RP adds to a discovery percentage. Each turn, the game rolls against this percentage. If the roll succeeds, you discover the tech. If not, the percentage increases and you roll again next turn.

This is a geometric distribution with increasing probability — front-loaded uncertainty with guaranteed eventual completion. For 10% increments:

| Turn after lightbulb | Chance | P(still waiting) | Expected discovery |
|---------------------|--------|------------------|-------------------|
| 1 | 10% | 100% | 10.0% |
| 2 | 20% | 90% | 18.0% |
| 3 | 30% | 72% | 21.6% |
| 4 | 40% | 50.4% | 20.2% |
| 5 | 50% | 30.2% | 15.1% |

Expected turns after lightbulb ≈ 3.6 turns (for 10% increments). The 90th percentile is ~5 turns. Worst case (10 turns) has <0.05% probability. For MIRR estimation, the EV is a solid approximation.

Higher RP overflow → larger increments → faster expected discovery → higher MIRR. There's a sweet spot where additional RP stops meaningfully accelerating discovery — that's where marginal research MIRR equals the MIRR of whatever else you'd spend that production on.

#### The Split Research Bonus

The game penalizes solo research paths and rewards splitting across multiple fields. This produces more total RP when funding multiple fields simultaneously. The effect:

```
Early game:  CONCENTRATE → one critical capability (range/planetology)
             Like a startup: all resources on the one thing that unblocks growth

Mid game:    TRANSITION → 2-3 fields as critical needs are met
             Like a growing company: diversify once core capability exists

Late game:   DIVERSIFY → even split across all 6 fields
             Like a mature economy: broad R&D portfolio captures the split bonus
```

This mirrors real economics: diminishing returns on specialization. The first dollar of R&D in a field is worth more than the hundredth. MOO1 mechanically enforces what reality naturally produces — past a certain point, diversification outperforms concentration in total output.

The optimal research allocation shifts naturally as the MIRR rankings change. Early on, propulsion MIRR is sky-high (unlocks planets = compound growth engines). As propulsion techs are acquired, their marginal MIRR drops (range 8 vs range 9 barely matters), while the diversification bonus raises the MIRR of neglected fields. The crossover from concentration to diversification is itself a MIRR calculation.

#### Tech Tree Randomness as Risk Management

The tech tree is partially randomized — you might not get range 5. But techs within a field have heavy duplication: range 6 or 7 will solve the same problem as range 5, just later. This is **portfolio theory applied to a tech tree:**

| Finance concept | MOO1 tech equivalent |
|----------------|---------------------|
| Diversification reduces risk | Split research bonus |
| Individual stocks are random, portfolios are stable | Individual tech rolls are random, but across 6 fields you'll get something useful |
| Concentrated bets: higher upside AND downside | Solo propulsion: range 5 on turn 20 (great!) or turn 40 (disaster) |
| Hedging reduces variance at a small cost to expected return | 2/3 propulsion + 1/3 planetology: slightly slower but two paths to new planets |

The 2/3 propulsion + 1/3 planetology split is buying insurance — sacrificing some speed on propulsion to hedge against bad propulsion rolls by opening a second path to the same goal (access to new planets via hostile colonization instead of range). This connects directly to the vault's [insurance framework](../../economics/insurance.md): hedge the catastrophic downside (no range tech at all) at a small cost to expected return.

#### Data Needed for Research MIRR

The computation is tractable once the game mechanics are known:

| Data point | Type | Status |
|-----------|------|--------|
| Base tech costs per field | Deterministic | Derivable from game data |
| Race field cost modifiers | Deterministic | Known (e.g., Psilons 0.8× all fields) |
| Overflow-to-percentage conversion rate | Deterministic | Needs extraction from game mechanics |
| Split research bonus formula | Deterministic | Needs extraction from game mechanics |
| Tech tree probabilities per race | Probabilistic | Partially known (guaranteed techs vs random) |
| Production impact per tech category | Estimated | Order-of-magnitude sufficient for MIRR ranking |

Items 1-4 are game mechanics — deterministic once the formulas are known. The optimization over research allocation splits (solo, 2-field, 3-field, even split) is a small search space with known probability distributions. This is a tractable module for the MOO1 Opening Optimizer.

### The Big Picture: Complexity Stacks But Remains Tractable

The full decision framework has multiple interacting layers:

```
Layer 1: PRODUCTION ALLOCATION (factory/colony/research/defense/military)
    → MIRR comparison across categories
    → Pick highest risk-adjusted return

Layer 2: RESEARCH ALLOCATION (which fields, what split)
    → Portfolio optimization within the research budget
    → Concentration vs diversification based on game phase
    → Tech tree probabilities inform expected returns

Layer 3: MILITARY DECISIONS (when to build, what to build, who to attack)
    → BattleValue framework for fleet comparison
    → Conquest MIRR vs expansion MIRR
    → Threat assessment for defensive spending

Layer 4: DIPLOMATIC DECISIONS (trade, alliances, war declarations)
    → Multiplayer coalition dynamics from vault framework
    → Trade treaties as passive income (Human specialty)
    → Alliance value as threat reduction (lowers defensive MIRR threshold)
```

Each layer has its own optimization, but they interact: research allocation affects what techs you get, which affects military MIRR, which affects whether you should be spending on military vs expansion. The layers can't be solved independently.

But they don't need to be. The MIRR framework provides a **common currency** for comparing across layers. "Should I spend 50 BC on a factory, a research allocation, or a missile base?" becomes "which has the highest MIRR given my current game state?" The comparison is apples-to-apples because MIRR normalizes everything to the same time-adjusted, risk-adjusted return metric.

**This is the thesis fully stated: 4X play is capital allocation under uncertainty, layered but tractable, solvable by estimating MIRR at each layer and picking the highest return. The data to compute it is mostly derivable from game mechanics. The remaining unknowns (threat levels, diplomacy) are estimable at order-of-magnitude, which is sufficient for correct decision ordering. The framework doesn't give you THE answer — it gives you a TOOL for finding the answer in any specific situation.**

### Connection to Subgraph Optimization

This is the same problem as Monopoly's build-vs-trade decision, translated to 4X:

| Monopoly | MOO1 |
|----------|------|
| Your properties (subgraph) | Your planets and tech |
| Build houses (deepen) | Build factories / bases (deepen) |
| Trade for monopoly (restructure) | Colonize / conquer (restructure) |
| Opponent's rent drain | Military threat / lost planets |
| Dominance pruning | Most investments dominated at any given state |
| BATNA = build what you have | BATNA = develop existing planets |

The pattern holds: real constraints reduce the decision space. Even with a bad start, the number of non-dominated actions is small — probably 2-3 at any given turn. The missing piece isn't the framework; it's the numbers that go into the framework. Without ROI figures for missile bases, research paths, and military deterrence, the dominance pruning can't operate. You can't tell which options are dominated if you don't know their values.

### Path Forward

The [opening optimizer](../../../projects/moo1-opening-optimizer/README.md) Phase 5 is where these numbers would come from. The approach:

1. **Simulate bad starts**: Generate maps with hostile neighbors at various distances, poor planet quality, missing tech. Run the same sweep as Phase 2 (vary investment allocation across the 5 buckets).
2. **Measure military ROI empirically**: Run simulations where the AI attacks at various timings. Compare outcomes with 0, 1, 2, 3 missile bases. Derive `P(survival)` as a function of base count and threat level.
3. **Measure research ROI**: For each race, compute the expected value of the first propulsion/planetology tech given the randomized tree. How much does "access to one more planet" change the 100-turn production integral?
4. **Derive adaptation triggers**: Find the map conditions (neighbor distance, planet quality, available tech) where each investment bucket becomes dominant. Express as rules: "if nearest planet is Poor and neighbor is within 4 parsecs, missile base before colony ship."

The convergence principle should still apply — once the numbers exist, the constraints are tight enough that iteration should find the right answer. The problem right now is that iteration has nothing to iterate *on*.

## Open Questions

- **Can the opening be solved?** Given a fixed map and race, is there a provably optimal turn sequence for the first 20 turns? The state space is small enough that brute-force search might be feasible — unlike the full game, which is combinatorially intractable. The mathematical analysis above suggests the answer is yes, at least for the colony ship timing subproblem.
- **BV validation:** Do the BV predictions hold for MOO1's specific combat system? MOO1 has initiative, range bands, and defensive fire that complicate pure BV comparison. Worth simulating.
- **Remnants of the Precursors (RotP):** Ray Greer's Java remake modernizes MOO1's mechanics. How do the balance changes affect this strategy? Does the tier list hold?
- **AI exploits:** The AI's diplomatic logic has known quirks (the council spite-vote, the population-triggered alliance flip). Can these be modeled formally to predict and manipulate AI behavior?

## Sources

- **Alan Emrich & Tom Hughes** — *Master of Orion Strategy Guide* (MicroProse, 1994). Coined the term "4X." Comprehensive race analysis and strategic framework. Available on [Archive.org](https://archive.org/details/MasterOfOrionStrategyGuide).
- **StrategyWiki** — [Master of Orion](https://strategywiki.org/wiki/Master_of_Orion), [Best Races](https://strategywiki.org/wiki/Master_of_Orion/Best_races), [Warship Design](https://strategywiki.org/wiki/Master_of_Orion/Warship_design), [Spying](https://strategywiki.org/wiki/Master_of_Orion/Spying), [Diplomacy](https://strategywiki.org/wiki/Master_of_Orion/Diplomacy)
- **CivFanatics** — [Race Selection and Balance](https://forums.civfanatics.com/threads/race-selection-in-moo1-and-balance.519900/), [Tactical Combat](https://forums.civfanatics.com/threads/moo1-tactical-combat.228446/)
- **Steam Community** — [The Orionator Strategy Guide](https://steamcommunity.com/app/410970/discussions/0/3817417431880638859/)

## Tags

[games](../../../tags/games.md), [game-theory](../../../tags/game-theory.md), [economics](../../../tags/economics.md), [strategy](../../../tags/strategy.md)
