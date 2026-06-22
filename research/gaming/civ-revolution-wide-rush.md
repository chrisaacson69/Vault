---
status: active
created: 2026-06-22
published: true
layout: layouts/page.njk
title: "Civilization Revolution — The City-Builder That Plays as a Rush"
---
# Civilization Revolution — The City-Builder That Plays as a Rush
> CivRev was designed as a fast, friendly Civ — a city-builder for the console. Competitive/1v1 play decoded it into something else: an opening **decapitation rush** feeding a **wide-expansion MIRR snowball** that ends the game before its intended midgame. The intended identity (build tall, develop cities, win on culture/economy/science over time) turns out to be a stack of **dead verbs**. This is specimen #2 for the [Dead-Verb Test](./dead-verbs-mechanism-viability.md) and the cleanest live confirmation of the [MIRR 4X thesis](./mirr-4x-framework.md) the vault has.

**Links:** [The MIRR 4X Framework](./mirr-4x-framework.md) (the hurdle-rate engine), [The Dead-Verb Test](./dead-verbs-mechanism-viability.md) (most options dominated), [The Hollow Opponent](./hollow-opponent-perceived-depth.md) (the deterministic AI exploited), [Capability Without Leverage](./capability-without-leverage.md) (liquidate to gold), [The Dominance-Frontier Lens](../dominance-frontier-lens.md) (the shrinking frontier), [Randomness as Termination (N≥3)](./n3-termination-and-randomization.md) (why N=2 map-RNG is the wrong place)
**Project:** [Civilization Revolution — Project Hub](../../projects/game-annotation/civ-revolution/README.md) (the working home for the data + the engines/generators that explore this space).
**Grounding:** static data captured Tier-1 (community wikis) in `raw/civrev-civilopedia-tables.md`, `raw/civrev-civilopedia-great-people-relics.md`, `raw/civrev-terrain.md`, `raw/civrev-combat-and-mechanics.md`, `raw/civrev-resources.md`. The hidden formulas (city growth, governments, AI tempo, combat win-%) are flagged below as a **CivRev2 measurement session** — Chris's live oracle, since the original no longer runs (iOS 32-bit cull). Source = competitive/1v1 CivRev play + Chris's analysis; numbers cited are confirmed-from-tables unless marked *(measure)*.

## 1. The opening: an immune scout + a deterministic AI = free capitals
Above the easiest difficulty you start as a **Settler (0/0/2)**, not a city. Two exploits stack:
- **The immune scout (a ruleset gap):** you can't attack a civ you haven't *contacted*, and the lone settler doesn't trigger contact — so a move-2 unit roams enemy ground untouchable, banking hut/relic gold and scouting AI capitals.
- **The hollow, deterministic AI ([Hollow Opponent](./hollow-opponent-perceived-depth.md)):** it always develops the same way — ~5 turns to its first unit, which then *wanders off to explore*, ~10 to the next. The capital is undefended on a **knowable clock**, and the human knows the script while the AI re-rolls blind every game (the best-response-vs-minimax asymmetry).

Found a city two tiles off an AI capital, put both citizens on **forest (+2 prod each → 4/turn)**, pop a **Warrior (cost 10)** in ~3 turns *or rush-buy it with hut gold*, and walk into the empty capital. Good map RNG → 2–3 capitals captured before the game "starts." *(Measure on CivRev2: does a settler really avoid contact; exact AI tempo; does a lone Warrior take an empty capital or do capitals have inherent defense.)*

## 2. Gold is the master resource — because it's liquid tempo
Gold rushes units (~2 gold/hammer; a Warrior ≈ 20 gold vs ~2.5 turns). By [MIRR](./mirr-4x-framework.md), the *opening* reinvestment rate is the highest it will ever be — taking a capital ~doubles you — so liquid, instantly-deployable capital beats illiquid build-queue production. Everything converts into the gold→rush loop:
- huts, barbarian kills, and named/resource tiles pay gold;
- a junk hut unit (Spy 25, Caravan 30) you won't use is [capability without leverage](./capability-without-leverage.md) — **sell it for gold** and it becomes a capital-taking Warrior;
- a Galley (30, move-2) is best as an explorer/relic-finder; **Knights Templar → a free Knight (4/2/2)** skips all of Feudalism and roams dominating Warriors (atk 1) and Archers (def 2); a favorable early **Wonder can win outright** in 1v1.

## 3. The main theory: wide beats tall on the hurdle rate
Chris's words: *"building stuff, even though it shows positive ROI, does not meet MIRR."* That **is** the MIRR thesis. The hurdle isn't zero — it's the empire's own growth rate, which **going wide** sets very high:
- **The Republic settler exploit:** at the low gate of **Code of Laws (60)** you can run Republic and build settlers for **1 pop**. A 3-pop city → settler (−1) = back to 2, plus a *new* 3-pop city: **net +2 pop and +1 city per cycle** *(Republic 1-pop rule + founding-pop = measure)*. Minting a city is far cheaper than growing one organically (*~2→3 pop ≈ 20 food — measure*). Food is dominated.
- **The multiplicative snowball:** the first-to-discover bonuses are all *"+1 [yield] in **every** city"* (Literacy +1 sci/60, Irrigation +1 pop/60, Engineering +1 prod/130). Value = bonus × city-count, and city-count grows geometrically — so **per-city bonus × geometric cities = super-linear science with no braking term**. Result: **tech victories before 0 BC.**
- **The tech tree is a thin spine, not a tree.** Most techs are dominated; you want the per-city-bonus techs, Republic, and key wonder-unlockers. And **backfill breaks the DAG** — Great Library (techs ≥2 civs hold), Lost City of Atlantis (several free), Oxford (an advanced tech), Apollo (all of them) let you skip prerequisites and grab them free. The designed pacing is routed around.
  - *Tool-confirmed* (`tools/tech-frontier.py`, a deterministic generator over the captured table): just **4 of 46 techs** sit on the cost-vs-value frontier (Masonry, Irrigation, Railroad, Industrialization) — the spine is even thinner than it looks. And the rush-order **flips at 1→2 cities**: one-time bonuses (Free Walls) lead the single-city opening, per-city bonuses (Irrigation, Literacy) take over the instant you expand — *rush first, then go wide*. Separately `tools/trap-detector.py` (unit stats × the tech DAG, no soft params) flags **Navigation as the lone tech-trap**: a dead-end leaf whose Galleon is outclassed by Steam Power's Cruiser — a tech you'd research anyway. Normal progression is *not* flagged; only the off-spine detour is.

## 4. The dominance cascade — what dies
- **Yields:** hammers/trade **>** food **>** culture. You mint pop instead of growing it (food weak); culture's payoff needs the *tall* play that's already dominated (culture dead).
- **Great People** pass through MIRR too — "gold now vs 10× by endgame" is a discount calc. The only uses that clear the hurdle are **tempo on contested spikes** (Great Scientist → a key tech *now*; Great Builder → win a wonder race *now*) and per-city effects scaled by width (+1 pop/city × wide). GP as a *goal* fails the hurdle — they're cheap enough to get incidentally.
- **The intended game.** Build-tall, culture, slow economy, and most of the command surface are **dead verbs**. The deepest finding: *the game's designed identity — the city-builder — is itself the biggest dead verb.*

## 5. 1v1 makes it worse — the frontier collapses
The [dominance-frontier](../dominance-frontier-lens.md) verdict on design quality is the size of the viable-strategy set, and in 1v1 it shrinks to ~one line. Map RNG becomes **instant death**: this is randomness in the *wrong place* — in N≥3 it's a healthy [termination mechanism](./n3-termination-and-randomization.md) against the gang-up equilibrium, but in **N=2 with a dominant strategy** there's no coalition to break, so map variance just decides *who executes the one line first* — a coinflip, not agency.

## 6. What's grounded vs. the CivRev2 measurement session
**Grounded from the captured tables:** settler 0/0/2, Warrior 10, forest +2, Knight 4/2/2, all first-discover bonuses, wonders, backfill mechanics, the resource→tech map (+ Game = +3 food).
**To measure on CivRev2 (the load-bearing gaps):** Republic 1-pop-settler rule + founding pop; the city **growth/food curve** (turns wide-vs-tall from *"tends to beat"* into *"beats by X"*); AI **opening tempo**; the **rush-cost formula**; **unit sell** values; settler **contact-immunity**; per-resource bonuses (paste the 403'd Fandom table). This session doubles as the **"does the designer learn?"** test — *did CivRev2 nerf the Republic exploit, the wide snowball, the backfill, or the immune scout?* — the Civ-series twin of the KOEI-catalog scorecard.

## Tags
[games](../../tags/games.md), [strategy](../../tags/strategy.md), [game-theory](../../tags/game-theory.md), [game-ai](../../tags/game-ai.md)
