---
status: complete
created: 2026-05-03
published: true
layout: layouts/page.njk
title: "Caster of Magic — Anti-Colossus Counter Analysis"
---
# Caster of Magic — Anti-Colossus Counter Analysis
> Streamer-inspired matchup study: which CoM fantastic creature reliably beats the Colossus, and what the simulator runs revealed about the broader fantastic-creature meta.

**Links:** [Master of Magic — Economic Analysis](./README.md), [Tier System and MIRR](./tier-system-and-mirr.md), [BattleValue](../battle-value.md)
**Project:** [masterofmagic](https://github.com/chrisaacson69/masterofmagic) — scraper at `scraper/scrape_com.py`, simulator at `simulator/battle.py`, analysis at `analyzer/com_vs_colossus.py`

---

## The Question

A streamer's stack of *invisible* Great Drakes was getting shredded by an enemy Colossus in the endgame. **Why** the plan failed — and what should they have used instead?

## Why the Drakes Lost

The Colossus has **Illusion Immunity**, which in CoM also functions as see-invisible. The Drakes weren't actually hidden, so the Colossus opened with its boulders (4 ammo × 25 strength) and then ate the survivors with melee 25 + First Strike. The plan was structural: the Drakes' edge was supposed to be "Colossus can't shoot what it can't see." Without that, it was naked stat-on-stat — the [Capability Without Leverage](../capability-without-leverage.md) thesis at its most vivid: the *leverage* (invisibility), not the *capability* (the Drakes), was the asset, and a single counter removed it.

## MoM vs CoM — Why the Streamer's Strategy Made Sense

The deeper "why" is meta: the streamer was applying **original-MoM** strategy to **Caster of Magic**.

- **Original MoM:** thin economy, weak banishment defense, no safe stacks for the AI. You built 1-2 "doom stacks" of 9 elite units (a hero with support, or 9 maxed town units, or 9 high-end summons), buffed them to absurdity, and rampaged. Kill-the-king via banishment finished games. RPS (towns / heroes / summons) existed but was tenuous.
- **Caster of Magic:** much larger production and mana economy, more opponents, banishment nerfed (no kill-the-king), heroes vulnerable. Endgame is grind: the map fills with large stacks, no single elite unit is safe, and the 9-unit stack limit becomes a binding constraint rather than a soft one. The streamer quit a winning game out of grind frustration.

The Drake-with-Invisibility play is a *MoM-era* solution: one buff makes one elite untouchable, you rampage. CoM removes that pillar (Illusion Immunity is now common on tier-2+ defenders) and replaces it with a war of attrition the player has to actually grind through.

This also explains the BV/Slot vs BV/Cost tension in the parent README: "9 maxed slingers might beat a Colossus per-cost, but 9 Colossi will whip 9 slingers." The 9-unit stack cap is the binding constraint, not mana.

## The Roster

Scraped 44 fantastic creatures across all 5 realms (`data/com/fantastic-units.json`). Filtered to the 20 candidates ≥ 200 mana and ran each as the attacker against a naked Colossus through the Markov simulator. Faster unit initiates round 1; alternates from there.

## Sim Corrections Discovered Along the Way

Two simulator bugs surfaced during this analysis and were fixed:

1. **First Strike modeled as always-on.** Per the wiki, FS only triggers on voluntary attack, never on counter-attack. The simulator was applying defender's FS too. Fixed in `BattleEngine.fight` — initiator's full attack always resolves first; defender's FS is ignored. This matters because every flying or teleporting candidate can sidestep the Colossus's First Strike just by being the melee initiator.
2. **Doom damage and Life Steal not modeled.** Added `doom_damage` (bypasses defense + resist) and `life_steal_distribution` (per-figure 1d10 vs `resist - penalty`, with Magic/Death Immunity granting full immunity). Healing-from-Life-Steal back to the attacker is *not* yet modeled — defender's HP loss is.

A third "bug" turned out to be correct behavior: Missile Immunity does NOT block boulders per the wiki. Storm Giant's MI doesn't help vs the Colossus.

## Results

| Unit | Mana | Win % | Per 100mp | Why |
|---|---|---|---|---|
| **Hydra** | 480 | 96.1% | 20.0 | 9-figure × 10HP stack absorbs boulders, Fire Breath 6 chunks Colossus on contact. Regen 7 not modeled — true rate is higher. |
| **Great Wyrm** | 500 | 92.0% | 18.4 | Merging-teleport skips the boulder approach; Armor Piercing halves Colossus def 12 → 6. Poison 25 is wasted (Colossus has Poison Immunity). |
| **Great Drake** | 500 | 87.9% | 17.6 | Naked stats favor it cleanly. The streamer's pick was right; the *plan* (relying on Invisibility) was wrong. |
| **Demon Lord** | 666 | 68.7% | 10.3 | Caster 40 self-buffs not modeled — likely undervalued. |
| **Death Knights** | 420 | 36.6% | 8.7 | Armor Piercing helps; Life Steal -5 vs resist 15 yields zero damage (max d10 = 10 vs mod resist 10). |

Everything below 30%: Arch Angel (16.4%), Sky Drake (9.5%), Behemoth (2.8%), Gorgons (2.7%), Djinn (0.7%), Stone Giant (0.7%), Wraiths (0.2%), and full-zero results for Doom Bat, Storm Giant, Efreet, Chaos Spawn, Angel, Night Stalker, Great Lizard, Unicorns.

## The Strategic Picture (Rock-Paper)

A side experiment ran the Hydra vs every other ≥ 200mp candidate. Hydra goes **18-2**. The two losses are structural and revealing:

```
Drakes  → beat → Hydra      (high-strength breath vs multi-figure stack;
                             each head rolls defense separately, all die)
Hydra   → beats → Colossus  (mass + breath vs single-figure boulder)
Drakes  → beat → Colossus  (naked stats; only loses if plan depends
                             on a counter the Colossus has)
```

So **Great Drake is the strongest 1v1 unit on raw stats** — beats both Hydra and Colossus. But **Hydra is the safer reusable answer** because it post-battle full-heals if it wins, and it's not vulnerable to "the AI also brought Drakes."

## Recommendation

For the streamer's specific Colossus problem: **Great Drakes without Invisibility, or Hydras as the cheaper, more reusable option.** Hydras at 480 mp also dodge the trap of being hard-countered by enemy Drakes that could later show up.

## Next Direction — Spell-Based Killing

The unit-vs-unit lens is incomplete for CoM endgame. The probable *real* answer for high-resist single-figure threats like the Colossus is **spell chains, not unit matchups**: debuff-resistance → damage-or-kill spell, or terrain-targeting effects that bypass resistance entirely.

**Crack's Call** is the canonical CoM example — targets the ground rather than the unit, ~25% chance to instantly kill any non-flying target regardless of resistance. That mechanic structurally hard-counters the Colossus (high res, ground-only) in a way no unit can. A future analysis should model spell economy: cost-per-expected-kill across the spell list, with debuff chains as multi-step pipelines.

## Limitations of the Analysis

- **No Regeneration.** Hydra and Behemoth understated. Doesn't change either Drake-vs-Hydra matchup (Hydra dies in round 2-3 before regen matters), but matters for sustained fights.
- **No Caster X self-buffing.** Demon Lord, Djinn, Arch Angel, Behemoth all undervalued. Real-game self-Heroism / self-Holy-Armor changes their effective stat lines.
- **No Holy Bonus / Supernatural modifiers.**
- **No Drain Life healing back to attacker.** Damage modeled correctly; the heal isn't. Doesn't affect Colossus matchup (Life Steal damage = 0 anyway against 15 resist).
- **No multi-unit stacks.** This is the big one — boulder-per-figure damage, area breath against 9-figure stacks, AI buff stacking, etc. all change as soon as it's not 1v1.
- **No flying-vs-ground initiative model.** The sim treats movement only as a "who initiates round 1" tiebreaker. In real combat, a flying unit attacking a ground unit can stay out of melee reach indefinitely, which the engine doesn't capture.

## Tags
[games](../../../tags/games.md), [strategy](../../../tags/strategy.md), [simulation](../../../tags/simulation.md), [game-theory](../../../tags/game-theory.md)
