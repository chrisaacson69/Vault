---
status: active
created: 2026-11-02
published: true
layout: layouts/page.njk
title: "NA1 Turn Economy — Action Slots, the Economic Index and the Winning Position"
---
# NA1 Turn Economy — Action Slots, the Economic Index and the Winning Position
> In Nobunaga's Ambition the binding constraint is the **action slot**, not the efficiency of any one action: a fief gets one command a season, so the strategy lives in *which* command, not in squeezing more out of it. From that follow three of Chris's quantitative claims, made playing Tokugawa in Mikawa (May 2026): an **Economic Index** that measures a clan's compounding capacity, a **Winning-Position Theorem** (the game is decided once your index exceeds everyone else's combined), and a **~10% CAGR** with a per-slot hurdle rate.

**Links:** [NA1 — A Game-Design Crucible](./nobunaga-crucible.md) (the specimen) · [The MIRR 4X Framework](./mirr-4x-framework.md) (the hurdle-rate engine this instantiates) · [The Dead-Verb Test](./dead-verbs-mechanism-viability.md) (verbs priced against this compounding) · [The Hollow Opponent](./hollow-opponent-perceived-depth.md) · [The Multiplayer Coalition Problem](./multiplayer-coalition-problem.md) (boom vs rush, coalitions) · [The Dominance-Frontier Lens](../dominance-frontier-lens.md)
**Grounding:** the mechanics cited (one command per fief per season, the develop formulas, the caps) are bytecode-verified in the [`na1-decompiler`](https://github.com/chrisaacson69/na1-decompiler) repo (`docs/appendix-formulas.md`, checked against the ROM by `na1sim.oracle`). The index, the theorem and the CAGR are **play observations and Chris's theory**, not ROM-derived; the game-specific doctrine built on them is the repo's `docs/synthesis-frontier.md` #35. Promoted from session memory 2026-11-02.

## Slots, not efficiency
A fief issues one command per season, four a year. Doubling an income matters less than what one more slot buys, so optimization happens at the allocation layer, not the production layer. The strategy frontier is therefore at least four-dimensional: terrain (each fief's tactical map), force count, force quality (skill, morale, arms) and **economic runway** (town, output, dams, wealth). A 5-year opening is 20 decisions per fief. *(Corrected: the May notes tied each season to one verb — Spring give, Summer build — which the game has no rule for: ch.11 gives one command per fief per turn.)*

## The Economic Index and the Winning-Position Theorem
Chris's index for a clan: **E = Σ over owned fiefs of ∛(town × output × wealth)** — a constant-returns Cobb-Douglas form that rewards balanced development and adds across fiefs, so it compounds through territory. Its fast-moving twin is the **Combat Index**, Σ(men × skill).

**Theorem (Chris, 2026-05-22).** A player is in a *winning position* once **E(self) > Σ E(all others)**: no alliance of the rest can out-compound the leader, so the outcome is decided by execution, not contention. Observed, Fall 1597 (Tokugawa playthrough): Tokugawa 10,009 against Oda 3,971 + "Uewa" 885 (as recorded) + Hojo 676 = 5,532, a ratio of 1.81 — over the threshold. Analogues: a dominant market position, a winning coalition, a material-won chess endgame.

## Boom vs rush, and the hurdle rate
| Vector | Index | Time scale |
|---|---|---|
| Boom | Σ ∛(town · output · wealth) | decades |
| Rush | Σ (men · skill) | seasons |
| Survival floor | the minimum defense that buys time to boom | — |

The winning line was **boom with minimum viable defense**: Mikawa held, the rear developed. Over 20 years of that playthrough every capability metric compounded at **~9.5–11.7% a year** (combat capacity 6.1×, town 8.1×, output 6.5×, rice and gold ~9×), which puts the per-slot hurdle at about **2.4%**: an action returning less is a drag on the baseline, so waiting while neighbours destroy each other is a positive-return choice. Each conquered fief raises the cap and with it the sustainable rate. This is the [MIRR](./mirr-4x-framework.md) argument on a game with hard per-fief caps.

## History as a check
The two scenarios encode two unification scopes: the 17-fief map is central Honshu around Kyoto (what Oda achieved before Honnō-ji, 1582); the 50-fief map adds the periphery Oda never reached (Mōri, Ryūzōji, Kyushu) — Hideyoshi's and Tokugawa's project. The boom line is Tokugawa's: patient development while neighbours exhausted each other, then a territorial advantage no rival could match by Sekigahara. The rush line is Oda's. That a game built in 1986 reproduces this ordering is part of why NA1 earns its [crucible](./nobunaga-crucible.md).

## Open Questions
- Does the theorem hold under the AI's actual behaviour (it attacks only its weakest neighbour; [Hollow Opponent](./hollow-opponent-perceived-depth.md)), or only against rational coalitions? A sim run (na1sim) could test the threshold directly.
- Is ∛(town·output·wealth) the right index? It omits rice and dams, which drive the rice harvest (output × dams); an index fitted to the harvest formula might predict better.
  **Evidence, 2026-11-04:** Chris's peasant shortcut beats balance. Leaving town and output alone and giving gold and rice to the peasants reached about 3.5 times the June rotation's income by year 10 in the checked sim, because wealth feeds both harvests and the gift costs no other stat. The index scores that fief poorly, so it measures balance, not income ([`synthesis-frontier` #36](https://github.com/chrisaacson69/na1-decompiler/blob/main/docs/synthesis-frontier.md)).
- The CAGR is from one playthrough; its spread across starts and cap rolls is unmeasured.

## Tags
[games](../../tags/games.md), [strategy](../../tags/strategy.md), [game-theory](../../tags/game-theory.md), [koei](../../tags/koei.md), [nobunagas-ambition](../../tags/nobunagas-ambition.md)
