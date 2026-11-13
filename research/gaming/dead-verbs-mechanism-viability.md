---
status: active
created: 2026-06-22
published: true
layout: layouts/page.njk
title: "The Dead-Verb Test — Mechanism Viability and Whether KOEI Learns"
---
# The Dead-Verb Test — Mechanism Viability and Whether KOEI Learns
> A game mechanism (a *verb* on the command menu) is viable only if it has a non-empty **home state** — a region of the game's state-space where it is the *uniquely best response*. NA1 fails this for most of its menu: Bribe, Ninja, Pact, and Marry are **dead verbs**, dominated by compounding development and redundant with the one policy that already wins. This page states the test, the anti-pattern, and the falsifiable forward question for the [Game Annotation Series](../../projects/game-annotation/README.md): *does a later KOEI title give its alternative verbs a home state?*

**Links:** [NA1 — A Game-Design Crucible](./nobunaga-crucible.md) (the specimen this was decoded from), [Civilization Revolution — The City-Builder That Plays as a Rush](./civ-revolution-wide-rush.md) (**specimen #2**, cross-franchise: an entire designed identity reduced to dead verbs), [The Dominance-Frontier Lens](../dominance-frontier-lens.md) (dead verbs are dominated edges), [Capability Without Leverage](./capability-without-leverage.md) (the player-side mirror: a capability with no leverage), [The Hollow Opponent](./hollow-opponent-perceived-depth.md) (the AI-tuning side), [NA1 Turn Economy](./na1-turn-economy.md) (the compounding baseline every verb is priced against)
**Grounding:** the cost/effect formulas, the war-commit gate, the turn-economy, and the attrition accounting are byte-exact in the [`na1-decompiler`](https://github.com/chrisaacson69/na1-decompiler) repo (`na1sim/FINDINGS-defensibility.md`), not inferred from play.

## The test
A verb earns its slot on the menu only if there exists a game state where **playing it beats every other verb**. Absent such a state, it is dead weight — it widens the option list (and the player's cognitive load) while never being correct. The viability question is therefore not "is this verb ever affordable?" but "is this verb ever *optimal*?"

## Why NA1's alternative verbs are dead
**The binding constraint prices every verb against compounding.** NA1's real scarcity is **action slots** (4 decisions/year — the [turn-economy thesis](./nobunaga-crucible.md)), not gold. So a verb's true cost is the *opportunity cost of a develop slot*, and develop compounds geometrically. Bribe, Ninja, Pact, Marry are all **one-shot, non-compounding** effects. Against a compounding baseline, a non-compounding action is dominated *unless* it (a) averts a catastrophic loss or (b) unlocks a compounding gain. None of NA1's reliably clear that bar:

- **Pact / Marry** — buy safety from attack. But the dominant policy is already *don't be a target*: the [war-commit gate](./nobunaga-crucible.md) selects the **weakest-provisioned** border fief, so non-weakness means you are never *selected* and the battle never happens — zero cost, no slot spent. Diplomacy is redundant with economics. *Priced from the ROM (2026-11-13, [ledger #49](https://github.com/chrisaacson69/na1-decompiler/blob/main/docs/synthesis-frontier.md)):* a relation is one d100 roll in the AI's war commit, re-rolled every season, and a pact's cell decays 10 a year, so against a neighbour who attacks whenever he can a pact buys about two seasons; a marriage (daimyo-wide, decays 2 a year) buys about eight, but its 300+ gold dowry buys about 100 men in 1560, which close the gate for good.
- **Bribe** (gold-for-defection) — the one with a faint pulse (a maxed-gold pump fief with nothing compounding left to buy). Still capped by conquest: an assault *garrisons you with the surviving army anyway*, so Bribe pays gold for strictly less than force delivers.
- **Ninja / sabotage** — a *temporary* enemy debuff against an AI whose spring-boon rubber-band repairs it next turn. Negative EV by construction. *Measured (2026-11-13, [ledger #50](https://github.com/chrisaacson69/na1-decompiler/blob/main/docs/synthesis-frontier.md)):* drained every season for six years, Uprising, Dams and Arson changed nothing; only Revolt, at 25-100 ninjas a season (33-130 gold in 1560) and every command, toppled a strong capital in a third to two thirds of games, without gaining the fief.

**The anti-player drift makes it worse over time.** NA1 hands the AI economic handicaps (linear develop vs the player's √-curve; spring-boon loyalty/wealth). As the AI's gold-denominated power outpaces the player's, every **fixed-gold** verb (Bribe) gets *relatively* more expensive each year — the verbs decay toward uselessness exactly as the game lengthens.

## The anti-pattern: a verb with no home state
Pact is the clean specimen. Its cost and its value are **anti-correlated in time**:
- when you're *strong* you can afford it but won't be attacked (no need),
- when you're *weak* you're attacked, and the gold is not the bar (the price is a share of *your* treasury, about 20 when it is empty) but the slot is: a command spent on a two-season stall instead of the men that end the threat,
- and where the two would finally align, **non-weakness has already pre-empted the threat**.

This is *insurance you can only buy when you don't need it*, layered on *redundancy with the optimal strategy*. Empty home state → zero marginal value. A mechanism is only as alive as the set of states where it's the best response is large.

## Legitimate handicap vs. design miss
Compensating for weak-era AI with **resource** handicaps is legitimate — it's an honest patch for a real ability gap (the AI can't search, so give it economic slack). The miss is letting that handicap **price the player's alternative toolkit out of viability**, collapsing the game to a single dominant line (*develop + don't-be-target*) while 80% of the command menu stays dead. A good design uses its surface; this one builds surface it then prices out. The fix is orthogonal to the handicap: tune the *cost/probability* and *compounding* of the alternative verbs so each owns a home state, independent of how much slack the AI gets.

## The falsifiable series question — does KOEI learn?
Stated as a per-title scorecard for the annotation series: **does the dominated fraction of the command menu shrink across the catalog?** Three concrete repair moves to watch for, title by title:
1. **Make them compound** — a pact that buys uninterrupted development, a vassal that pays recurring tribute: converts one-shot into compounding.
2. **Tie them to a non-redundant objective** — diplomacy *required* for a victory condition, not just for a safety the economy already provides.
3. **Rebalance cost/probability** so the home state is affordable *in* the weak state where the verb is needed.

If KOEI learns, later titles show fewer dead verbs and more states with a unique best response. That's a measurable prediction to carry *into* the next ROM, so we test a hypothesis instead of rationalizing after the read.

## Tags
[games](../../tags/games.md), [strategy](../../tags/strategy.md), [game-theory](../../tags/game-theory.md), [game-ai](../../tags/game-ai.md), [koei](../../tags/koei.md)

**See also:** [KOEI AI & combat evolution](./koei-ai-combat-evolution.md) — the combat-resolution + AI-fairness arc across five decompilers; the empirical answer to "does KOEI learn?" on the combat axis (yes: one-shot compare → cheap round-sim; combat handicap → symmetric).
