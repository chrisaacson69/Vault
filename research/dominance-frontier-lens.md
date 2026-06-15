---
status: active
created: 2026-06-08
published: true
layout: layouts/page.njk
title: "The Dominance-Frontier Lens"
---
# The Dominance-Frontier Lens
> A recurring analytical frame for **any competitive system with counter dynamics** — games, but also markets and portfolios. Map **cost** against **effect**, draw the **edges** where X dominates or counters Y, trace the **frontier curve** of non-dominated choices, and flag the **asymmetric edges** where a counter costs more than the threat it answers. Then ask the design-quality question: **does every starting endowment have at least one viable path along the frontier?** It's the same construction as a Markowitz efficient frontier in finance — which is why this lens reaches past games.

**Links:** [Capability Without Leverage](./gaming/capability-without-leverage.md) (the trap this lens *finds*), [MIRR — 4X as Capital Allocation](./gaming/mirr-4x-framework.md), [The Anchor Method](../method/anchor-method.md) (dominance pruning is a reducer — see below) · specimens linked in the ledger.

> A **thesis page** (portable, source-independent), promoted from a working note. The worked graphs live in the specimens it cites; this page states the lens.

## The lens

For a system where choices interact (one beats, counters, or denies another), don't enumerate mechanics flatly. Instead:

1. **Pick the cost axis** — mana, production, BattleValue, cash, research, dollars.
2. **Pick the effect axis** — kill rate, denial rate, position value, expected return.
3. **Draw the dominance edges** — X dominates Y if it's cheaper *and* more effective; X counters Y if it specifically negates Y's effect.
4. **Trace the frontier** — the non-dominated set: the efficient choices for each cost level. Most options are dominated and can be pruned.
5. **Flag the asymmetric edges** — where the counter costs *more* than the threat. These are the most interesting findings: they create **attrition wars** (you can't cheaply remove the threat, only grind it) and force **tempo investment**.

**The design-quality verdict — random-start viability.** Once the frontier is drawn, ask: does *every* starting endowment have at least one viable path along it? If a starting position has no non-dominated path, the game is unfair from that seed. This turns a descriptive map into a verdict on the design.

## Three companion axes

- **Pre-emptive vs reactive.** When miss-cost is high, a pre-cast guarantee beats a reactive option (Bloodlust > Heal in WC2; doom-stacks in MoM; pre-commitment in [Newcomb's Paradox](./philosophy/dynamics/newcombs-paradox.md)). The frontier shifts toward pre-emption as variance rises.
- **Sparse vs dense graph.** WC2 has a near-empty counter-graph where one edge decides the meta; CoM has a dense graph where *navigation itself* is the skill. Same lens, opposite design choice — and the density tells you where skill lives.
- **Variance compression as the system matures** (Gould's "Extinction of .400 Hitting"). The mean stays put; the standard deviation shrinks as the talent pool professionalizes. New 4X games look like .400-hitter eras (any strategy works); mature ones look like .260-hitter eras (tight optimal play). The evolved "sport closure rate" — football's ~3 yards/play, baseball's .333 threshold, tennis's ~80% hold — is the equilibrium where games still *close*. A quantitative health-check for any strategy game's tuning.

## Why it reaches past games

The efficient frontier is not a game idea borrowed into finance — it's the **same construction**. Markowitz's portfolio frontier plots risk (cost axis) against expected return (effect axis), keeps the non-dominated set, and prunes everything below the curve. Market-share dynamics, security/counter-exploit races, and R&D portfolios all have dominance edges and asymmetric counters. The lens is domain-general; games are just where the graph is cleanest to draw.

**Connection to method.** Dominance pruning *is* a reducer — it collapses a combinatorial action space to the small non-dominated set (≈2–3 live options per turn). That's the same move as the [Anchor Method](../method/anchor-method.md)'s "enumerate the table forward" / lowering-atlas: when reactive discovery won't close a set, draw the dominance graph and read the frontier off it.

## Evidence ledger (specimens)

- **[Monopoly — Frontier Trade Theory](./gaming/monopoly/frontier-trade-theory.md)** — the efficient frontier of cash-vs-EPT; dominance pruning of trades; the canonical worked instance.
- **[MoM/CoM — Spell Counter-Graph](./gaming/master-of-magic/com-counter-graph.md)** — counters as a *directed* dominance graph with scope categories (single / area / passive-pool / resource-denial / lock / behavioral); the dense-graph case.
- **[BattleValue](./gaming/battle-value.md)** — BV/Cost as the per-unit frontier ranking; the metric that draws the cost axis for combat units.
- **[MoO1 — MIRR Analysis](./gaming/moo1/mirr-analysis.md)** — MIRR as the *investment-decision* frontier (the factory-vs-colony non-dominated path over turns).

These four already describe themselves as "the same methodology"; this page is the hub they were missing.

## Open questions

- Can "random-start viability" be made a computable test (search every seed for a non-dominated path) rather than a judgment call?
- Where exactly does the games↔finance correspondence break — is there a frontier construction with no game analogue, or vice-versa?

## Tags
[game-theory](../tags/game-theory.md), [strategy](../tags/strategy.md), [games](../tags/games.md), [methodology](../tags/methodology.md), [economics](../tags/economics.md)
