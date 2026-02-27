# BattleTech Simulator
> Monte Carlo combat simulator to derive empirical BattleValue for BattleTech mechs and find bargains in the official BV2 system.

**Status:** planning
**Created:** 2026-02-26
**Links:** [BattleValue](../../research/gaming/battle-value.md), [Gaming](../../research/gaming/README.md), [YouTube Migration](../youtube-migration/README.md)

## Motivation

The [BattleValue formula](../../research/gaming/battle-value.md) (BV = sqrt(Attack × HP)) works cleanly for simple combat systems. BattleTech breaks every assumption:

- **Sectional HP:** Mechs don't have one HP pool — they have 8+ locations (head, CT, LT, RT, LA, RA, LL, RL), each with separate armor and internal structure
- **Hit location tables:** Damage is assigned by probability table (2d6 bell curve), not uniformly
- **Damage transfer:** When a section is destroyed, excess damage flows to adjacent sections (arm → torso, side torso → center torso)
- **Critical hits:** Internal hits can destroy weapons, ammo (explosion!), engines, gyros — changing the mech's effective combat power mid-fight
- **Weapon systems:** Multiple weapons with different ranges, damage, heat, and clustering behavior. A mech's "attack" isn't a single number — it's a loadout with range-dependent DPS
- **Heat management:** Firing all weapons generates heat; overheating degrades performance or forces shutdown. Effective DPS is heat-constrained, not just weapon-constrained
- **Movement modifiers:** Speed affects to-hit numbers, making fast mechs harder to hit (effective HP multiplier) but often lighter-armed

This makes analytical BV derivation a computational nightmare. The interactions between sectional damage, crits, damage transfer, and heat create a combinatorial space too complex for closed-form solution.

## Approach: Monte Carlo

Instead of solving analytically, **simulate**:

1. Implement BattleTech combat rules (hit locations, damage, crits, heat, movement modifiers)
2. Run N simulated combats (10,000+) between each mech pair
3. Record win rates, average survival HP, rounds to kill
4. Derive **empirical BV** from win-rate matrices
5. Compare empirical BV to official BV2 values
6. **Find the bargains:** mechs where official BV2 undervalues actual combat effectiveness, and the traps where BV2 overvalues

### The Bargain-Hunting Angle

The official BV system (now BV2) has gone through multiple iterations — each trying to correctly price every mech for balanced play. But with 500+ mech variants and the complexity above, mispricing is inevitable.

Every mispriced mech is an arbitrage opportunity:
- **Undervalued:** empirical BV > official BV2 → you get more combat power than you're "paying" for in BV budget games
- **Overvalued:** empirical BV < official BV2 → avoid these, you're overpaying

This is structurally identical to finding mispriced assets in a market — the official BV2 is the "market price," the Monte Carlo gives you the "true value," and the spread is the opportunity. Same instinct as [Triangular Arbitrage](../triangular-arbitrage/README.md), different domain.

## Technical Considerations

- **Rules fidelity:** How closely to model the tabletop rules? Full fidelity means 2d6 hit locations, cluster hit tables, piloting skill rolls, ammo explosions. Simplified versions could start with just sectional damage + transfer.
- **AI behavior:** How do simulated mechs choose targets, weapon groupings, movement? Random? Greedy (maximize expected damage)? This affects results significantly — a mech that's strong with smart play but weak with random play will show different empirical BV depending on the AI.
- **Range bands:** BattleTech combat varies dramatically by range. A mech loaded with PPCs dominates at long range; an AC/20 brawler dominates at close range. Empirical BV may need to be range-dependent.
- **Language:** TBD. Python for prototyping speed, C for simulation performance if N gets large enough to matter.

## Open Questions

- Can the empirical BV be decomposed to understand *why* certain mechs are mispriced? (e.g., "this mech is undervalued because damage transfer from side torso protects its weapons better than average")
- Does the simplified BV formula (sqrt(A×HP)) work as a rough first approximation even for BattleTech, if you define "A" as heat-adjusted DPS and "HP" as total armor+structure? How far off is the approximation?
- Are there systematic patterns in BV2 mispricing? (e.g., does BV2 consistently undervalue mechs with XL engines because it doesn't model crit vulnerability correctly? Or overvalue slow assault mechs because it doesn't account for movement modifiers?)
- Could this become a YouTube video? "We ran 10 million simulated BattleTech fights and found the most underpriced mechs" — that's a hook for the BattleTech community.

## Tags
[games](../../tags/games.md), [battletech](../../tags/battletech.md), [simulation](../../tags/simulation.md), [game-theory](../../tags/game-theory.md), [mathematics](../../tags/mathematics.md)
