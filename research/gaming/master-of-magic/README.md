---
status: active — data gathering phase
created: 2026-04-03
---
# Master of Magic — Economic Analysis
> Apply BV and MIRR frameworks to the original 1994 4X classic. Everything is broken — but is it equally broken?

**Links:** [BattleValue](../battle-value.md), [MOO1 MIRR Analysis](../moo1/mirr-analysis.md), [Gaming](../README.md)
**Project:** [masterofmagic](https://github.com/chrisaacson69/masterofmagic)

---

## The Thesis

Master of Magic is famous for its "balance through imbalance" — powerful units, devastating spells, and game-warping combos exist across all five magic realms. The community consensus is that this works because *everything* is overpowered, creating a rough equilibrium.

But is that true? If we apply the same BV and MIRR analysis that worked for MOO1, we can quantify exactly which units, buildings, and spells are the best deals — and which are traps. The wiki data is complete enough to do this systematically across the entire game.

## Scope

### Units (~150 total)
- **Normal units** (~100): race-specific, built with production, maintained with gold/food
- **Fantastic creatures** (~46): summoned with mana, maintained with mana
- **Heroes** (~35): unique units with equipment slots, level progression

**BV model for MoM:**
```
Base BV = sqrt(Melee × Hits × Figures)
```

MoM complications beyond base BV:
- **Multi-figure units** — a 6-figure swordsman with 1 HP each vs a 1-figure dragon with 30 HP behave very differently (Lanchester applies differently)
- **Ranged attacks** — many units have ranged AND melee; ranged gets free damage before melee starts (first-strike multiplier)
- **To-Hit modifiers** — base 30% hit rate, modified by level and abilities; directly scales effective attack
- **Special abilities** — First Strike, Armor Piercing, Fire Breath, Life Steal, Immolation, Poison, etc. Each modifies effective BV differently
- **Resistance** — magic defense stat; some units are effectively immune to half the game's spells
- **Level progression** — units gain stats through experience; a Champion-level unit is dramatically stronger than Recruit

**Cost metrics:**
- Normal units: `BV / (build_cost + upkeep_NPV)` — production economy
- Fantastic creatures: `BV / (casting_cost + upkeep_NPV)` — mana economy
- Two separate efficiency rankings because the economies are independent

### Buildings
- ~30 building types with race-specific availability
- Prerequisite chains (tech tree)
- Effects: production bonuses, unit unlocks, population growth, gold income

**MIRR model:** Same structure as MOO1 factories — cost now, return stream over time. But buildings also unlock other buildings and units, creating option value (the right to build something better later).

### Spells (214 total)
- Five realms: Chaos, Life, Death, Nature, Sorcery (+ Arcane)
- Four rarities: Common, Uncommon, Rare, Very Rare
- Types: combat instant, combat enchantment, unit enchantment, city enchantment, global enchantment, summoning

**MIRR model for spells:**
- Research cost = upfront investment (paid in research points over many turns)
- Casting cost = deployment cost (mana, one-time or per-combat)
- Upkeep = ongoing maintenance (mana per turn for enchantments/summons)
- Return = effect value (damage, stat boost, economic benefit, summoned unit BV)

## Architecture — Python Gather, LLM Analyze

### Phase 1: Data Gathering (Python)
Scrape the MoM Fandom wiki via MediaWiki API:
1. Enumerate all pages in target categories (Normal_Units, Fantastic_Creatures, Town_Building, spells by realm)
2. Fetch wikitext for each page
3. Parse infobox templates into structured JSON
4. Store as `data/units.json`, `data/buildings.json`, `data/spells.json`

**Wiki source:** https://masterofmagic.fandom.com/wiki/Master_of_Magic_Wiki
**API endpoint:** `https://masterofmagic.fandom.com/api.php`

### Phase 2: BV Computation (Python)
- Compute base BV for all units
- Apply modifiers for ranged attacks, to-hit, special abilities
- Compute BV/Cost for both production and mana economies
- Rank all units by efficiency
- Flag outliers (top 10% and bottom 10% by BV/Cost)

### Phase 3: MIRR Analysis (Python + LLM)
- Model building prerequisite chains as investment paths
- Compute MIRR for each building given race-specific availability
- Model spell research as investment (research cost → value of having the spell)
- LLM analyzes the results: which combos are genuinely broken, which are traps, and why

### Phase 4: Synthesis (LLM → Vault)
- Write up findings as vault research pages
- Cross-link to BV theory, MIRR theory, economics frameworks
- Compare to community tier lists — do the numbers match player intuition?

## The Hard Counter Problem

Base BV assumes all damage is fungible — 10 melee damage is the same as 10 ranged damage. In MoM, this is wildly false. Abilities create **hard counters** where one unit's effectiveness against another drops to zero:

- **Magic Immunity** — immune to all spell damage and most magic-based abilities. Shuts down entire strategies.
- **Weapon Immunity** — immune to non-magical melee/ranged. Normal units literally can't touch it.
- **Flight** — can't be hit by ground-only melee units. Free attacks with no retaliation.
- **Illusionary attacks** — bypass all armor (defense stat irrelevant). Devastating against high-defense units.
- **First Strike** — attacks before the opponent in melee. High-damage first strikers can kill before taking any damage.
- **Poison/Life Steal/Stoning** — bypass HP entirely, attacking resistance or causing instant death.

This means the correct model isn't a single BV number but a **matchup matrix**: unit A's effective BV against unit B, considering both units' abilities and the damage type rules. A unit might have BV 50 against normal units but BV 0 against anything with Weapon Immunity.

The community gravitates to strategies that exploit the *most* hard counters (or that are immune to the most counters). The "broken" units are likely the ones with the highest *average* effective BV across all matchups — or the ones that counter the most common threats.

**Fan/official rewrites** (Caster of Magic, 2022 remaster) provide natural experiments: comparing BV/Cost rankings across versions reveals which hard counters the community and developers agreed were too dominant.

## Sub-Pages

- [Tier System and MIRR](./tier-system-and-mirr.md) — time-gated combat tiers as investment decisions; Wraith rush, Halfling Slinger stacking, building option value, wizard book picks as capital allocation

## Simulator Status and Next Steps

Working Markov chain battle simulator (`simulator/battle.py`) with:
- Per-round probability distributions from binomial hit/block model
- Figure-attrition-aware damage (multi-figure units degrade, single-figure don't)
- Initiator-aware asymmetry (attacker gets ranged phase, defender doesn't)
- First strike ordering
- Arena round-robin with "both directions" averaging

**Next steps:**
- **Approach phase** — N rounds of free ranged fire before melee, based on movement speed vs distance. "How many Slinger volleys to equalize against a Great Drake?" Same range-control insight as BattleTech.
- **Special damage** — Poison, Death Gaze, Stoning (resistance-based, bypasses HP)
- **Weapon tiers** — Normal/Magic/Mithril/Adamantium interaction with Weapon Immunity
- **Experience levels** — stat progression per level, model as BV stacking curves
- **Enchantment stacking** — per-enchantment BV improvement and diminishing MIRR
- **BV/Slot vs BV/Cost** — the 9-unit stacking limit means the cheapest BV/Cost unit isn't always optimal. 9 Great Drakes beat infinite spearmen because they only attack 9 at a time. BV/Cost optimizes for "fixed budget, unlimited slots." BV/Slot optimizes for "fixed slots, sufficient budget." Real strategy optimizes for both constraints simultaneously.

## Open Questions

- **How to value special abilities?** Fire Breath 30 is not the same as Melee 30. Need ability-specific BV multipliers.
- **Multi-figure Lanchester:** Does a 6-figure unit with 1 HP each behave as 6× the BV of a single figure? Or do figures die sequentially (Linear Law), reducing it?
- **Mana vs production:** The two economies aren't fungible. A unit that's efficient in mana might compete with a unit that's efficient in production — but you can't directly compare across economies. How do we handle this?
- **Combo value:** Some units/spells are mediocre alone but broken in combination (e.g., Berserk + high-figure units). BV per unit doesn't capture synergy. Same problem as mixed-army composition in the BV page.
- **Level progression:** Should BV be computed at Recruit level (what you get when built) or expected average level? Experienced players know which units level easily — that's hidden value.
- **BV/Cost vs BV/Slot:** The 9-unit stack limit creates a dual-constraint optimization. BV/Cost says spearmen, BV/Slot says drakes, and the right answer depends on the game state. Models are never perfect — empirics over theory, as the vault's praxis framework argues.
- **Range as force multiplier:** Ranged units get free damage during the approach phase. Movement speed determines how many free volleys the ranged unit gets. This makes range control a strategic multiplier that base BV doesn't capture — same insight as BattleTech range brackets.

## Tags
[games](../../../tags/games.md), [strategy](../../../tags/strategy.md), [economics](../../../tags/economics.md), [game-theory](../../../tags/game-theory.md), [mathematics](../../../tags/mathematics.md)
