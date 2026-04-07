---
status: active — theory phase
created: 2026-04-03
---
# Master of Magic — Tier System and MIRR
> The "broken" strategies are entrepreneurial bets with exceptionally high MIRR at specific time windows. Games are won at turn 15 when one player has T3 and everyone else has T1.

**Links:** [MoM Economic Analysis](./README.md), [BattleValue](../battle-value.md), [MOO1 MIRR Analysis](../moo1/mirr-analysis.md), [Risk and Entrepreneurship](../../economics/risk-and-entrepreneurship.md), [Value and Profit](../../economics/value-and-profit.md)

---

## The Tier System as a Time-Value Problem

Combat units aren't just "stronger" at higher tiers — they're gated by escalating investment. Each tier requires more upfront cost (buildings, books, research, mana) but delivers disproportionately more combat power. The question isn't "which unit is best?" but "which unit is best *right now* given what I've invested so far?"

### Approximate Tiers

| Tier | Examples | Gate | Available |
|------|----------|------|-----------|
| T1 | Swordsmen, Spearmen | Barracks (cheap) | Turn 1-5 |
| T2 | Halberdiers, War Bears, Cavalry | Fighters' Guild, Nature Uncommon | Turn 10-20 |
| T3 | Wraiths, Nightblades, Longbowmen | Death Rare + books, Fighters' Guild (race-specific) | Turn 15-30 |
| T4 | Paladins, Doom Drakes | Armorer's Guild + Cathedral chain, full building tree | Turn 30-50 |
| T5 | Great Drake, Sky Drake, buffed Heroes | Very Rare research + massive mana/building investment | Turn 40+ |

Higher tiers completely dominate lower tiers — the Markov simulator shows Great Drake wins 100% against everything T3 and below. The game is decided by *when* you reach each tier relative to your opponents.

## The Wraith Rush — MIRR at Its Purest

The classic "11 Death books" opening:

**Investment:**
- Pick 11 Death books at wizard creation (opportunity cost: no other realm's spells)
- This guarantees access to Wraith summoning (Rare Death spell)
- Research to Wraith spell: moderate research investment
- Casting cost: expensive in mana

**Return:**
- Wraiths are T3 units: Weapon Immunity, flight, regeneration, life steal
- Deployed at turn ~15-20 when opponents have T1 swordsmen and spearmen
- One Wraith can defeat entire armies of T1 units (Weapon Immunity means they literally can't damage it)
- Snowball: Wraiths generate undead from kills, compounding the advantage

**MIRR analysis:**
- The "cost" is the wizard creation picks (11 books = no other realm access)
- The "return" is 2+ tiers of combat advantage for 15-30 turns
- The MIRR is astronomical because the return window is when it matters most (early-mid game expansion)
- By turn 50 when opponents have T4+ units with magic weapons, the advantage fades — but the game is often over by then

This is structurally identical to the MOO1 colony ship decision: massive upfront investment for compounding returns that dominate a specific time window.

## The Halfling Slinger Problem — Multiplicative Stacking

Base BV captures individual unit combat power. But MoM's buff system creates **multiplicative** scaling that makes certain base units disproportionately powerful when fully invested:

**Halfling Slingers (base stats):**
- 8 figures (highest in game for ranged units)
- Ranged attack (free damage phase)
- Lucky (affects to-hit AND defense for every figure)
- Modest base stats

**With full investment (Champion level + Adamantium + enchantments):**
- Each experience level adds stats to every figure: 8x multiplier
- Adamantium weapons add +2 to hit and +1 to damage per figure: 8x multiplier
- Each unit enchantment (Giant Strength, Holy Weapon, etc.) buffs every figure: 8x multiplier
- Lucky improves every roll for every figure across all phases

**The math:** Effective BV isn't `base + buffs`. It's `base * exp_multiplier * weapon_multiplier * enchant_1 * enchant_2 * ...`. With 8 figures, every multiplicative buff is 8x more effective than on a single-figure unit. A fully buffed Halfling Slinger can take down Great Drakes because the stacked multipliers on 8 ranged figures with Lucky generates more total damage than a single 30-melee dragon.

**Implication for BV:** We need a "stacking curve" — how BV scales with investment level (experience, weapons, enchantments). Units with high figure counts and Lucky will have steeper curves. The base BV ranking and the fully-invested BV ranking will be very different.

## MIRR Beyond Direct Returns — Option Value

Buildings don't just produce resources. They unlock capabilities:

| Building | Direct return | Option value |
|----------|--------------|--------------|
| Sawmill (40 prod) | +25% production | Unlocks Longbowmen (High Elves) |
| Smithy (40 prod) | Enables magic weapons | Unlocks Swordsmen, gates Armorer's Guild |
| Armorer's Guild (200 prod) | Nothing directly | Unlocks Paladins, best armor tier |
| Cathedral (400 prod) | Religious power, unrest | Required for Paladins alongside Armorer's Guild |

The Sawmill's MIRR as a production building is straightforward (same as MOO1 factory MIRR). But its value as a gate to Longbowmen is harder to measure — the "return" is access to a unit type, not a resource flow.

**How to model option value:**
1. Compute MIRR of the building's direct economic return (production, gold, research bonuses)
2. Compute BV of the units it unlocks
3. The "option value" is the BV/Cost improvement of the unlocked unit over the best currently available unit, discounted by the turns until you can actually build it
4. Total building MIRR = direct MIRR + option MIRR

This is exactly how financial options work: the Sawmill is a call option on Longbowmen, and the strike price is the building cost.

## The Strategic Decision

Every turn, the player faces the same decision tree as MOO1, but with more branches:

1. **Build economy** (Sawmill, Marketplace) — lowers future build times, compounds
2. **Build military now** (Barracks → T1 units) — immediate but weak combat power
3. **Build toward higher tier** (Smithy → Armorer's Guild → Cathedral → Paladins) — delayed but dominant
4. **Research spells** (invest in spell research) — unlocks fantastic creatures and combat enchantments
5. **Cast summoning spells** (mana → fantastic creatures) — bypass building tree entirely

The "broken" strategies are paths through this tree with the highest MIRR at critical time windows:
- **Wraith rush:** Skip economy, skip buildings, go straight to T3 via spell research
- **Economy turtle → Paladins:** Heavy economy investment, survive with T1/T2, then deploy unbeatable T4
- **Halfling Slinger stack:** Moderate buildings, invest in enchantments and experience, multiply a cheap base unit into a monster

Each strategy is an investment thesis. The simulator + MIRR framework should be able to quantify *why* each works and *when* each is optimal.

## Open Questions

- **How to compute option value MIRR for building prerequisites?** The chain Barracks → Smithy → Armorer's Guild → Cathedral is 4 buildings deep with ~700 production total. What's the per-turn MIRR of that investment path vs. spending 700 production on T1 units?
- **Experience as compound interest:** Units gain experience from combat. A T1 unit that fights and survives gains experience that makes it T2-equivalent. Is experience a "free" multiplier that favors aggressive play (more fights = more XP)?
- **Enchantment stacking economics:** Each enchantment costs mana to cast and maintain. At what point does the Nth enchantment on a Halfling Slinger have diminishing MIRR (upkeep exceeds marginal BV improvement)?
- **Wizard book picks as capital allocation:** The 11-book decision at game start is irreversible. Can we model this as a portfolio allocation problem where each book combination has an expected MIRR curve over the game timeline?

## Tags
[games](../../../tags/games.md), [strategy](../../../tags/strategy.md), [economics](../../../tags/economics.md), [game-theory](../../../tags/game-theory.md)
