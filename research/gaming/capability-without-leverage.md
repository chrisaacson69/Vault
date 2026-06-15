---
status: active
created: 2026-06-08
published: true
layout: layouts/page.njk
title: "Capability Without Leverage"
---
# Capability Without Leverage
> A capability you paid to acquire is worth **zero — or negative — unless something downstream lets it actually shift the outcome.** Face efficiency (EPT-per-dollar, BattleValue, trade-efficiency) is the trap; the right metric is **impact conditional on use.** Because you *paid* the acquisition cost, an unleveraged capability is *worse* than none — you're down the cost and the opportunity. A cross-game invariant: Monopoly, Master of Magic, and Catan all independently coin it.

**Links:** [BattleValue](./battle-value.md) (BV→0 in a bad matchup *is* this, in combat units), [Bilateral Trade Valuation](./bilateral-trade-valuation.md) (impact-share is its third-party / position layer), [Frontier Trade Theory](./monopoly/frontier-trade-theory.md), [Gaming](./README.md)

> A **thesis page** (portable, source-independent). The worked numbers live in the specimens it cites; this page states the claim.

## The thesis

Every acquisition buys a **capability** — a monopoly, a unit, a port, a tech. Capability is not the asset. **Leverage** is: the downstream mechanism by which the capability changes the result. A capability with no leverage is a sunk cost wearing the costume of progress — it *looks* like you climbed the efficiency curve, because face metrics reward it, while the leaderboard doesn't move.

The diagnostic question is never "is this efficient?" but **"if I hold this, what changes for whom?"** If the honest answer is "nothing decisive," the efficient-looking buy is a trap.

## Two failure modes

**A — Intrinsically low-impact.** The capability *works* exactly as designed; it just doesn't move the outcome.
- *Monopoly — the Brown trap.* Browns are cheap and EPT-per-dollar-efficient, but generate small absolute rent, apply no positional pressure, drain no reserves, block no high-traffic paths. "A player who spends 3 random properties + cash to acquire Browns… looks like they moved up the EPT curve — but they spent their available trade capital on a monopoly that **doesn't translate into wins**." The fix is a metric: **game-impact-share, not EPT-per-dollar.** "Browns are EPT-efficient and impact-inefficient."

**B — Conditionally gated.** The capability's payoff depends on an enabling condition the opponent (or your own board) can negate. Remove the condition → value collapses to zero.
- *MoM — the hard counter to zero.* "A unit might have BV 50 against normal units but **BV 0 against anything with Weapon Immunity**." Effective value isn't a scalar; it's a matchup matrix, and the wrong cell is a cliff.
- *MoM — the Drake/invisibility play* (sharpest, because the gate is *removed live*). Invisible Great Drakes whose entire edge was "the Colossus can't shoot what it can't see" — until Illusion Immunity (which doubles as see-invisible) negates the gate and "it was **naked stat-on-stat**." The capability was real; the leverage was contingent, and the contingency failed.
- *Catan — the unleveraged 2:1 port.* A port's face value is "trade efficiency"; its **capability value** is "trade efficiency *conditional on producing enough of the resource to use it*." Empirically: leveraged ports ≈ 25% baseline win rate, **unleveraged ports 12.5% — half baseline.** "Holders with no matching production are paying for an unused capability." A 2:1 port replaces a productive vertex; if the matching resource is weak, you sacrificed leverage *for* the capability — net negative.

## Why it's worse than nothing (the cost asymmetry)

A free unused capability is merely neutral. A *paid* one is negative: you spent acquisition cost + the opportunity cost of the higher-impact thing you could have bought instead. That's why "capability-with-no-leverage is worse than no capability" — the comparison isn't to zero, it's to the leveraged buy you forwent. Failure mode B is especially punishing because the capability *appears* high-value right up until the gate is contested.

## The dual — leverage that can't be negated

Invert the lens and you get a design/strategy target: the capability whose enabling condition the opponent **cannot** remove. *Being* the Weapon-Immunity unit (rather than the one it zeroes) is pure leverage; a monopoly on a high-traffic path is leverage that doesn't depend on a contingency. The strongest acquisitions aren't the most efficient — they're the ones whose impact is **unconditional**. This is the same axis as MoM's "the broken units are the ones immune to the most counters."

## The metric correction (one pattern, three names)

| Game | Face metric (the trap) | Capability/leverage metric (the truth) |
|---|---|---|
| Monopoly | EPT-per-dollar | game-impact-share |
| Master of Magic | BattleValue | effective BV in the actual matchup |
| Catan | trade efficiency | trade efficiency *conditional on matching production* |

In every case the face metric prices the capability in isolation; the correct metric prices it *conditional on the leverage that lets it pay back.*

## Evidence ledger (specimens)

- **[Monopoly — Frontier Trade Theory](./monopoly/frontier-trade-theory.md)** (§"The Brown trap"). *Contributes:* failure mode A in its cleanest form, the EPT-per-dollar→impact-share metric correction, and the "18× more EPT-efficient yet impact-inefficient" raw number.
- **[Master of Magic — Economic Analysis](./master-of-magic/README.md)** (§"The Hard Counter Problem"). *Contributes:* failure mode B as a cliff (BV 50 → BV 0 vs Weapon Immunity); the matchup-matrix-not-scalar correction; the dual (immunity = un-negatable leverage).
- **[MoM — Anti-Colossus study](./master-of-magic/com-anti-colossus.md)**. *Contributes:* the gate-removed-live case (Drakes' invisibility negated by Illusion Immunity → "naked stat-on-stat") — the most vivid demonstration that the leverage, not the capability, was the asset.
- **[Catan — 50-Game Validation](./catan-50-games-validation.md)** (§port-leverage). *Contributes:* the empirical number (unleveraged port = half baseline win rate) and the face-value-vs-capability-value framing the whole thesis borrows.

## Related (not folded in here)

- The **information-design** half of `feedback_capability_value_and_information_design` (hidden-trackable = soft flaw, hidden-random = legitimate mechanic) is a *separate* lens that shares the memory note — a distinct promotion, not this page.
- The **dominance-frontier analysis lens** (map cost/effect edges, find the frontier, flag asymmetric counters) is the methodology that *finds* these traps; candidate sibling hub.

## Tags
[games](../../tags/games.md), [strategy](../../tags/strategy.md), [game-theory](../../tags/game-theory.md), [game-ai](../../tags/game-ai.md)
