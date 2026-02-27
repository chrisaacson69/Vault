# BattleValue — A Universal Combat Comparison Metric
> BV = sqrt(Attack × HP). One number to compare any two units across any game system.

**Status:** active — lifelong project
**Created:** 2026-02-26
**Links:** [Gaming](./README.md), [Economics](../economics/README.md), [The Multiplayer Coalition Problem](./multiplayer-coalition-problem.md), [YouTube Migration](../../projects/youtube-migration/README.md)

## The Problem

Most strategy games use the same combat model descended from D&D (and earlier wargaming): a unit has an **attack value** (damage per tick) and **hit points** (how much damage it absorbs before dying). Variations add hit rates, armor, resistances, critical hits, and other modifiers — but the core mechanic is the same: deal numerical damage, subtract from HP, dead at zero.

Given two unit types with different Attack and HP values, which one wins? And if they have different costs, which is the better investment?

The answer is not obvious. A unit with 100 Attack and 10 HP is not obviously better or worse than a unit with 10 Attack and 100 HP. Raw stats don't compare directly because combat effectiveness depends on the *interaction* of attack and durability.

## The Historical Origin

This combat model has roots much older than D&D. The original formulation modeled **groups, not individuals**: 100 hit points meant 100 men, and damage represented how many men could be killed in a given timeframe. The individual-unit version in games is an abstraction of the group model — one character "is" a fighting force with aggregate stats.

This matters because the math was originally designed for exactly the comparison problem BattleValue solves: given two armies with different compositions, which one wins?

## The Derivation

**Setup:** Two units fight. Each deals damage per tick equal to its Attack. Each dies when HP reaches zero.

Unit A: Attack = a, HP = h
Unit B: Attack = b, HP = k

**Time to kill:**
- A kills B in k/a ticks (B's HP divided by A's damage per tick)
- B kills A in h/b ticks (A's HP divided by B's damage per tick)

**A wins if** it kills B before B kills it:
```
k/a < h/b
```

Cross-multiply:
```
k·b < h·a
```

Rearrange:
```
a·h > b·k
```

**The product Attack × HP determines the winner.** The unit with the higher product wins a 1v1.

But raw products aren't convenient for comparison — they scale quadratically. To get a linear metric:

**BV = sqrt(Attack × HP)**

BV₁ > BV₂ means unit 1 wins. The ratio BV₁/BV₂ gives the relative combat effectiveness.

### Cost Efficiency

If units have a resource cost, the strategically relevant question isn't "which unit wins 1v1" but "which unit gives more combat power per resource spent":

**Combat Efficiency = BV / Cost**

This is the army composition metric. Given a fixed budget, buy the unit type with the highest BV/Cost ratio. This is directly analogous to the economic concept of return on investment — you're maximizing combat output per unit of input.

## Why Square Root?

The square root isn't arbitrary — it linearizes the comparison. Without it:

| Unit | Attack | HP | Attack×HP | BV |
|------|--------|-----|-----------|-----|
| Soldier | 10 | 100 | 1,000 | 31.6 |
| Glass Cannon | 100 | 10 | 1,000 | 31.6 |
| Tank | 5 | 400 | 2,000 | 44.7 |
| Balanced | 50 | 50 | 2,500 | 50.0 |

Soldier and Glass Cannon have equal BV (they tie in a 1v1 — Soldier kills in 0.1 ticks, Glass Cannon kills in 10 ticks... wait, that's wrong — Glass Cannon kills Soldier in 100/100 = 1 tick, Soldier kills Glass Cannon in 10/10 = 1 tick. They kill each other simultaneously). The square root preserves this symmetry while making the numbers human-readable and linearly comparable.

A unit with BV 50 is not "twice as good" as BV 25 in a 1v1 — it's four times as good in terms of raw combat product. But BV makes relative comparison intuitive: bigger number wins, ratio tells you by how much.

## Lanchester's Square Law — The Formal Ancestor

Frederick Lanchester (1916) formalized this math for WWI military operations research. His **Square Law** states:

> In concentrated-fire combat (where all units in a force can engage simultaneously), the combat power of a force is proportional to the **square** of its numbers times its individual firepower.

For a force of N identical units each with attack power a:
```
Combat Power = N² × a
```

This means doubling your numbers quadruples your combat power — not just doubles it. This is why concentration of force is a military principle: two forces of 50 lose to one force of 100, even though total numbers are equal.

**BattleValue is the individual-unit version of Lanchester.** Where Lanchester asks "which army wins?", BV asks "which unit type wins?" — same math, different scale. And BV/Cost is the resource-allocation version: "given a budget, which unit type produces the strongest army?"

### Lanchester's Linear Law

Lanchester also described a **Linear Law** for sequential combat (where only one unit from each side engages at a time — think single-file through a gate). In this case:

```
Combat Power = N × a
```

Numbers matter linearly, not quadratically. This maps to different game mechanics — turn-based combat where only the front unit fights, or narrow chokepoints that prevent concentration.

**BV applies to the Square Law case** — which is the default in most game combat systems (all units in range attack simultaneously).

## Multi-Unit Convergence — BV Scales to Armies

The individual BV derivation compares two single units. But games involve armies. Does BV still work when N units fight N units?

Yes — and the proof is elegant.

### Worked Example

**Setup:** 50 units of Type A (1 dmg, 100 HP, BV=10) vs 50 units of Type B (2 dmg, 50 HP, BV=10). Equal BV — should tie.

**Round-by-round attrition (simultaneous, concentrated fire):**

| Round | A units | A total damage | B units killed | B units | B total damage | A units killed |
|-------|---------|---------------|----------------|---------|---------------|----------------|
| 1 | 50 | 50 × 1 = 50 | 1 (50/50) | 50 | 50 × 2 = 100 | 1 (100/100) |
| 2 | 49 | 49 | 1 | 49 | 98 | 1 |
| 3 | 48 | 48 | 1 | 48 | 96 | 1 |
| ... | ... | ... | ... | ... | ... | ... |
| 50 | 1 | 1 | — | 1 | 2 | — |

Both sides lose one unit per round. Both are eliminated simultaneously. **Tie confirmed** — BV correctly predicted the outcome.

Note the asymmetry: A units deal exactly enough damage each round to kill one B unit (50 damage vs 50 HP), while B units deal exactly enough to kill one A unit (100 damage vs 100 HP). Different stats, same attrition rate — because A×HP is equal.

### The Aggregate Combat Product

Each side's total damage output over the entire battle follows the triangular number pattern — 50 units attack, then 49, then 48:

```
Total rounds of fire = N + (N-1) + (N-2) + ... + 1 = N(N+1)/2
```

For N=50: 50 × 51 / 2 = 1,275 unit-rounds.

The **aggregate combat product** multiplies this by the per-unit combat product (A×HP):

```
Aggregate = A×HP × N(N+1)/2
```

For both sides: 100 × 1,275 = **127,500**. Equal — tie confirmed from the aggregate as well.

### The 1/sqrt(2) Asymptote

Now compare the aggregate to the naive linear sum:

```
Naive sum: BV × N = 10 × 50 = 500
Aggregate BV: sqrt(127,500) ≈ 357
Ratio: 357 / 500 ≈ 71.4%
```

At larger N, the triangular number N(N+1)/2 approaches N²/2:

```
Aggregate = A×HP × N²/2
sqrt(Aggregate) = sqrt(A×HP) × N/sqrt(2) = BV × N / sqrt(2)
```

The ratio of aggregate BV to naive linear BV converges to:

```
(BV × N / sqrt(2)) / (BV × N) = 1/sqrt(2) ≈ 0.7071 = 70.71%
```

| N | Triangular N(N+1)/2 | Aggregate (×100) | sqrt(Aggregate) | Naive BV×N | Ratio |
|---|---------------------|-------------------|-----------------|------------|-------|
| 50 | 1,275 | 127,500 | 357.1 | 500 | 71.4% |
| 100 | 5,050 | 505,000 | 710.6 | 1,000 | 71.1% |
| 1,000 | 500,500 | 50,050,000 | 7,074.6 | 10,000 | 70.7% |
| 10,000 | 50,005,000 | 5,000,500,000 | 70,714.2 | 100,000 | 70.71% |
| ∞ | ≈ N²/2 | ≈ A×HP × N²/2 | BV × N/sqrt(2) | BV × N | **1/sqrt(2)** |

**This IS Lanchester's Square Law derived from first principles.** The square-law scaling (combat power ∝ N²) appears naturally from the triangular attrition pattern. The 1/sqrt(2) factor is the bridge between the individual metric (BV) and the army-scale metric.

### Why the Relative Comparison Survives

The 1/sqrt(2) correction is a constant — it applies equally to both sides. If BV₁ > BV₂ for individual units, then:

```
BV₁ × N / sqrt(2) > BV₂ × N / sqrt(2)
```

The constant cancels. **BV correctly predicts the winner at every scale.** The absolute aggregate values differ from naive BV×N by the sqrt(2) factor, but the *relative comparison* — which is all that matters for deciding who wins — is preserved identically.

This is why BV works as a universal metric: it captures the combat product that determines outcomes, and the multi-unit scaling is a constant correction that doesn't change the ranking.

## Uneven Engagements — Survival Rates from BV

The multi-unit convergence proves BV works for equal forces. The real power shows when forces are *unequal* — BV gives you exact survival rates.

### The Pythagorean Survival Formula

When two forces of unequal total BV engage, the winner's surviving combat power is:

```
Surviving BV = sqrt(Total_BV_A² - Total_BV_B²)
```

Where:
- Total_BV_A = BV_a × N (individual BV times unit count)
- Total_BV_B = BV_b × M

And the surviving unit count:

```
Surviving units = Surviving BV / BV_individual
```

This is a Pythagorean relationship — the two forces' total BVs form the legs, and the difference of squares gives the surviving power. The sqrt() is what makes this work. With raw A×HP products, you'd need to track quadratic terms that don't compose. The square root linearizes individual BV so that total BV is additive (BV × N), and the survival formula falls out as a clean difference of squares.

### Worked Examples

**Example 1: Numerical advantage, equal unit types**

100 A-units (1 dmg, 100 HP, BV=10) vs 50 B-units (2 dmg, 50 HP, BV=10):

```
Total BV_A = 10 × 100 = 1,000
Total BV_B = 10 × 50  = 500
Surviving BV = sqrt(1,000² - 500²) = sqrt(750,000) ≈ 866
Surviving A units = 866 / 10 ≈ 87
```

A 2:1 advantage costs only ~13% losses. This is the Lanchester concentration-of-force principle quantified: doubling numbers doesn't double your advantage — it *quadruples* your combat power (because BV² scales with N²), so losses are disproportionately small.

**Example 2: Quality vs quantity**

30 Elite units (10 dmg, 90 HP, BV=30) vs 100 Militia units (2 dmg, 18 HP, BV=6):

```
Total BV_Elite   = 30 × 30  = 900
Total BV_Militia = 6 × 100  = 600
Surviving BV = sqrt(900² - 600²) = sqrt(450,000) ≈ 671
Surviving Elites = 671 / 30 ≈ 22
```

30 Elites beat 100 Militia and lose only 8 units. But if Militia cost 1/5 the price of Elites, they have equal BV/Cost — and at equal *budget*, the Militia win because they field more total BV.

**Example 3: The break-even**

When Total_BV_A = Total_BV_B, surviving BV = sqrt(0) = 0. Mutual annihilation. This is the tie case from the multi-unit convergence section, confirmed from the survival formula.

### Why This Matters for Game Design and Strategy

The survival formula reveals why certain strategies dominate:

- **Concentration of force** is always correct under Lanchester. Splitting your army in half doesn't halve your power — it *quarters* it (each half has (N/2)² = N²/4 of original power). Never fight two battles when you can fight one.

- **First strike / alpha strike** is devastating because units killed before they fire contribute zero BV to the fight. Eliminating 10% of the enemy force before combat starts doesn't reduce their power by 10% — it reduces it by ~19% (1 - 0.9² = 0.19). This is why initiative, range, and ambush are consistently the strongest mechanics.

- **Attrition wars favor the larger force** non-linearly. A force with 20% more total BV doesn't win by 20% — it wins overwhelmingly with minimal losses. This is why smart strategy games make comeback mechanics (terrain, morale, logistics) to prevent the snowball.

- **Cost efficiency (BV/Cost) is king.** The survival formula shows that total BV determines outcomes. Given a fixed budget, the player who buys more total BV wins. This makes BV/Cost the single most important number in any strategy game's unit roster.

## Extensions and Complications

The base BV formula assumes the simplest possible combat model. Real games add complications:

### Hit Rate / Accuracy
If attacks have a probability p of hitting:
```
Effective Attack = Attack × p
BV = sqrt(Attack × p × HP)
```

### Armor / Damage Reduction
If armor reduces incoming damage by a flat amount r:
```
Effective HP = HP × (Attack_enemy / (Attack_enemy - r))
```
This gets circular (your effective HP depends on the enemy's attack), which is why armor makes comparison harder — BV gives the clean case, and armor requires knowing the matchup.

### AoE / Splash Damage
Area damage multiplies effective attack by the number of targets hit. This is why AoE is disproportionately powerful — it's a force multiplier that scales with enemy concentration (Lanchester's Square Law in reverse: the more concentrated the enemy, the more effective your splash).

### Healing / Regeneration
Healing effectively multiplies HP by extending the time to kill. A unit with 100 HP and 10 HP/tick regeneration against an enemy dealing 15 HP/tick damage has effective HP of:
```
Effective HP = HP / (1 - heal_rate/incoming_damage) = 100 / (1 - 10/15) = 300
```

### Range / Initiative
First strike (attacking before the enemy can respond) is a massive force multiplier that BV doesn't capture. A unit that kills before being attacked has infinite effective HP for that first exchange. This is why range advantages and initiative bonuses are consistently among the strongest mechanics in strategy games.

## Applications Across Games

| Game/Genre | Attack Analogue | HP Analogue | BV Application |
|------------|----------------|-------------|----------------|
| D&D/RPGs | DPS (damage per round) | Hit Points | Character build optimization |
| RTS (StarCraft, AoE) | DPS | HP + Armor | Unit composition, build order efficiency |
| 4X (MOO, Civilization) | Ship/unit firepower | Hull/HP | Fleet composition, tech investment |
| Auto-battlers (TFT) | DPS | HP + shields | Team composition, item optimization |
| Card games (MTG) | Power | Toughness | Creature evaluation, trade analysis |
| Wargames | Combat Factor | Steps/strength | Force comparison, the original use case |

## Connection to Economics

BV/Cost is structurally identical to return on investment. The strategy game player faces the same problem as the entrepreneur:

- Fixed budget (resources, gold, minerals)
- Multiple investment options (unit types, buildings, tech)
- Each option has a measurable output (BV) and a known cost
- Optimal allocation maximizes total output per unit of input

The complication — in both games and markets — is that BV/Cost is only the *local* metric. The global optimization includes:
- **Composition effects** — some unit types synergize (healers amplify tank BV; artillery behind infantry)
- **Counter-matchups** — high BV/Cost against one enemy composition, low against another
- **Timing** — cheap low-BV units now vs. expensive high-BV units later (the time preference / interest rate problem from [economics](../economics/README.md))
- **Information** — you don't know what the opponent is building (the entrepreneurial uncertainty problem)

The BV formula gives you the *floor* of analysis. Everything above it is game-specific strategy — but without the floor, you can't even start comparing.

## Open Questions

- **Does BV generalize to non-symmetric combat?** The derivation assumes both units attack simultaneously. Turn-based games with initiative, or games with attack/defense phases, may need a modified formula.
- **Mixed-composition armies:** The multi-unit convergence is proven for homogeneous forces (N identical units vs N identical units). What about mixed armies — e.g., 25 Soldiers + 25 Tanks vs 50 Glass Cannons? Can total army BV be computed as a sum, or do composition effects (focus-fire targeting, kill order) break the additivity? (This connects to the [coalition problem](./multiplayer-coalition-problem.md).)
- **Is there a BV-equivalent for non-combat interactions?** Economic competition has analogous structure: "attack" = competitive pressure, "HP" = market resilience. Can BV model market competition?
- **Historical validation:** How well does BV predict outcomes in actual wargame simulations? The Lanchester model has known limitations in historical military analysis — do those same limitations apply to the game-mechanic version?

## Sources

- **Frederick Lanchester** — *Aircraft in Warfare: The Dawn of the Fourth Arm* (1916). The formal mathematical model of combat attrition. Square Law (concentrated fire) and Linear Law (sequential engagement).
- **D&D / Gary Gygax** — The popularization of the HP/damage combat model for individual units, adapted from wargaming roots (Chainmail, 1971).
- **Historical wargaming** — The "100 HP = 100 men" formulation predates D&D, rooted in hex-and-counter wargames of the 1950s-60s (Avalon Hill, SPI) which themselves formalized Napoleonic-era military theory.

## Tags
[games](../../tags/games.md), [game-theory](../../tags/game-theory.md), [mathematics](../../tags/mathematics.md), [economics](../../tags/economics.md)
