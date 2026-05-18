---
status: active — frontier mapping in progress
created: 2026-05-03
---
# Caster of Magic — Spell Counter-Graph
> CoM counters form a directed graph where each tier's standard answer ages out and demands a more expensive successor. Same structural pattern as Monopoly's efficient-frontier dominance map, applied to spell economy.

**Links:** [Master of Magic — Economic Analysis](./README.md), [CoM Anti-Colossus Counter Analysis](./com-anti-colossus.md), [Efficient Frontier Trade Theory](../monopoly/frontier-trade-theory.md), [BattleValue](../battle-value.md)
**Project:** [masterofmagic](https://github.com/chrisaacson69/masterofmagic) — `data/com/spells.json` is the source

---

## Thesis

CoM's spell book is not a flat list of effects — it's a **dominance graph**. The cheap counter to today's threat is the threat that ages out tomorrow, demanding a more expensive successor. Mapping the graph reveals (a) which research investments are forced, (b) where asymmetric counters create attrition wars, and (c) where the only "counter" is behavioral discipline rather than another spell.

This is the same methodological pattern as the Monopoly [Efficient Frontier Trade Theory](../monopoly/frontier-trade-theory.md): identify dominance edges to collapse a brute-force decision space into a navigable structure.

## Scope Categories

Counters operate at different *scopes*, and a complete graph needs nodes for each:

| Scope | Mechanism | Examples |
|---|---|---|
| **Single-target active** | Removes one effect on one unit | Dispel Magic, Disjunction |
| **Area active** | Removes all effects in an area | Disenchant Area (overland), Dispelling Wave (combat-mass) |
| **Passive pool** | Buffer that auto-counters until drained | Counter Magic (70-pt pool, -10 per cast) |
| **Resource denial** | Starves the spell pool itself, not the spells | Mana Leak (5 MP/turn drain) |
| **Lock/protect** | Increases the cost of removal | Spell Lock (~2× dispel cost) |
| **Behavioral** | No spell, just discipline | Don't-stack vs Dispelling Wave; delay-don't-counter vs Spell of Mastery |

## The Warp Wood Frontier (canonical example)

```
Tier 0:  Bows                                  free with unit
   ↓
Tier 1:  Warp Wood (Chaos C, 5MP/320RP)        strips all ammo
   ↓
Tier 2:  Magic ranged units come online        Warp Wood doesn't apply
   ↓
Tier 3a: Resist Elements (Nature C, 5MP/440RP) +4 def vs magical ranged (cheap partial)
Tier 3b: Magic Immunity (Sorc R, 36MP/5500RP)  100 def+res vs spells & magical ranged
   ↓
Tier 4:  Disenchant / Dispel Magic on the buff back to dispel taxonomy
```

The cost ratchet is roughly 5-10× per tier. The cheap base counter (Warp Wood, 5 MP) becomes irrelevant in the magic-ranged meta; the late counter (Magic Immunity, 36 MP + 5500 RP) requires a different realm AND deep research investment.

## Dispel Taxonomy and Asymmetric Edges

The dispel formulas show that counters are *taxes*, not bargains — equal-cost = 50% chance:

| Spell | Realm | Cost range | Formula | Notes |
|---|---|---|---|---|
| Dispel Magic | Arcane | 10-50 MP | `cost / (orig + cost)` | Single-unit, in-combat |
| Disenchant Area | Arcane | 50-250 MP | same | Overland enchantments |
| Disjunction | Arcane | 375-1875 MP | `cost / (1.5 × orig)` | Globals — *worse* ratio (asymmetric edge) |
| Dispelling Wave | Sorc Uncom | 25-125 MP | `(0.5×cost) / (orig + 0.5×cost)` | Mass combat dispel — half-power, area |

**Asymmetric edge example — Spell of Mastery vs Disjunction.** SoM costs 15,000 MP. To get 50% Disjunction success: 11,250 MP. The counter is nearly as expensive as the spell. **Conclusion:** SoM cannot be reliably dispelled — only delayed (chip-attack the caster, attack their cities, pressure them to interrupt). The "counter" is behavioral, not magical.

**Spell Lock as a cost-doubler.** Mind Storm (35 MP) without Spell Lock: opponent's expected dispel cost = 35 MP. With Spell Lock (100 MP) on top: opponent must dispel two layers, expected cost ≈ 270 MP. You paid 135, they pay 270 — net 2× ratio, exactly as `feedback_spell_lock` style discipline predicts.

## Counter Magic as Zone Defense

Counter Magic (Sorc Uncom, 50 MP, 1280 RP) creates a 70-point pool. Each enemy spell rolls `cost/pool` chance to succeed; on failure, pool drops by 10. Over the lifetime of a combat, that's ~7 enemy spells potentially denied — passive, no targeting required. **Different category** from active dispel: pays once, denies many. A natural complement to Spell Lock for stacking-based wizards.

## Mana Leak as Resource Denial

Mana Leak (Death Common, 20 MP) does not target a spell or an enchantment — it drains the opponent's *capacity to cast at all*. 5 MP/turn off caster units, 5 mana crystals/turn from the wizard, 1 ammo/turn off magical-ranged units. Over a 10-turn combat that's 50+ MP worth of denied casting. **Counters the spell pool, not the spells** — orthogonal to dispel. Pairs especially well against caster-heavy stacks (Demon Lord, Djinn, Efreet).

## Open Chains Worth Mapping (next exercises)

- **Anti-fantastic chain.** Resist Magic / True Sight / Magic Immunity tier; how Holy Word / Banish / Disintegrate each hit different points on the resist curve.
- **Anti-stack chain.** Black Prayer / Mass Invisibility / Wrack on the offense; Heroism / Bless / Holy Armor on the defense; Dispelling Wave as the anti-stack cleanup.
- **Anti-caster chain.** Mana Leak / Counter Magic / Spell Blast / Possession-on-the-mage; the chain that targets the caster instead of the unit.
- **Global enchantment race.** Eternal Night / Tranquility / Time Stop / Spell of Mastery; which globals dominate which others, and where Disjunction's asymmetric cost forces tempo investment.

## Limits and Caveats

- The graph is **wizard-build-conditional** — Life ↔ Death incompatibility removes whole chains; multi-realm wizards open combo paths impossible to a single-realm caster.
- **Casting-rate constraint** (per-combat-turn skill cap) means a chain with N spells takes N turns minimum. The cheapest chain may not be the *fastest*, and time-to-effect matters as much as total MP.
- **Stacking rules** (do `-2 res` from Black Prayer and `-5 res` from Mind Storm sum to `-7`?) need wiki verification before the graph's combo-edges are trusted.
- The graph is also **map-state-conditional** — Disenchant Area is decisive when you can reach the buffed enemy stack between turns; useless when geography blocks you.

## Tags
[games](../../../tags/games.md), [strategy](../../../tags/strategy.md), [game-theory](../../../tags/game-theory.md), [simulation](../../../tags/simulation.md)
