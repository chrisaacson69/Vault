---
status: active
created: 2026-11-11
published: true
layout: layouts/page.njk
title: "The Margin Sets the Intelligence — Weak Positions Are Where Players Separate"
---
# The Margin Sets the Intelligence — Weak Positions Are Where Players Separate
> **How much intelligence a player needs grows as its margin shrinks.** From a strong position every reasonable move survives, so moves score alike and the method of choosing barely matters. From a weak one the moves differ by tens of points of survival, and only a player that prices the collisions between its priorities finds the narrow path. Corollary: **develop smarter players on weak positions.** A strong position cannot tell good play from lucky play.

**Links:** [NA1 — A Game-Design Crucible](./nobunaga-crucible.md) (the hub), [The Hollow Opponent](./hollow-opponent-perceived-depth.md) (its "random-start viability, made computable" is the question this measures), [NA1 Turn Economy](./na1-turn-economy.md) (one command a season is why every choice is a trade), [Slay — Evaluation & Search](./slay-evaluation.md) (eval-beats-depth, the same lesson from search), [The Dominance-Frontier Lens](../dominance-frontier-lens.md), [Solved Games — the principle → search → perfect ladder](./sim-channels/solved-games.md) (the same ladder, measured on Checkers/Connect 4/Othello)

> A **thesis page**, promoted from a 2026-11-11 session with Chris. The specimen is Saito of Mino in Nobunaga's Ambition (NES), the weakest-but-one start; the code and the numbers live in [`na1-decompiler`](https://github.com/chrisaacson69/na1-decompiler) (`docs/synthesis-frontier.md` #41-#46).

## The specimen: breathing life into a dead fief

Saito starts with 38 men, morale 21, loyalty 31, 29 gold and 25 rice. Every neighbour is bigger. Most of his games are decided before he moves: in 157-172 of every 300, an attack lands before his first command. The rest hinge on four early choices that pull against each other:
- **morale** against revolt;
- **men** against being picked, and against losing close battles;
- **rice** against the Fall upkeep (rice 0 after the harvest is certain death);
- **loyalty and wealth** against the income that pays for all of it.

The players, on the same seeds (skill 1, 3 years, 600 games; the last two rows are the same seeds):

| Player | How it chooses | Saito alive |
|---|---|---|
| scripted opening, then expand | a fixed sequence | 1.7% |
| `reader` | reads the position, works down a priority list | 3.7% |
| `reader` + two collision rules | Summer rice before loyalty; hire to the picker line first | 6.7% |
| `ev` | prices every move by its survival over four seasons, from the game's own formulas | **8.3%** |

The same scripted player keeps **68.1%** of all 17 starts alive on average. The strong fiefs get there with play no smarter than the script.

## Why the margin decides

- **Strong position: the scores flatten.** When every candidate move leaves you above every neighbour's attack line, all moves score near 1. A better decision rule has nothing to pick between, so its intelligence has no leverage.
- **Weak position: the scores split.** At Saito's first command in one game (seed 3093), spending the 29 gold on morale or on men scored 0.00: the next Fall's upkeep dismisses men, and six neighbours pick him instead of three. Hiring just to the picker line scored 0.90 and kept 22 gold. The spread between moves is the room in which intelligence matters.
- **Rule orders fail exactly where priorities collide.** "Fix morale under 45" and "buy Summer rice" are each right alone. The `reader` lost games when both applied at once. An expected-value player has no order to get wrong; it prices the collision. Its gains came on fresh seeds as much as on tuning seeds, with nothing fitted.

## The ladder of player intelligence

1. **Scripts.** Enough wherever the margin is large.
2. **Rule orders.** Read the state, act on the first rule that fires. They break at collisions.
3. **Formula EV.** Price each move with the game's mechanics, measured once (revolt odds, battle-odds tables, the harvest). Chris's method: *derive it, then sim to validate*, not empirics. Each part is a formula someone can read.
4. **Lookahead / search.** Roll the simulator forward per move. Strongest in principle, but it finds rules without explaining them, so it sits last on purpose.

Each rung costs more to build and pays only where the margin is thin. That is why most strategy-game AI stops at rung 1-2 and seems fine: it is usually tested from comfortable positions.

## The same shape at empire scale

The [expanding player](https://github.com/chrisaacson69/na1-decompiler/blob/main/docs/synthesis-frontier.md) (#48) follows Chris's order: make yourself safe, then build, then expand. It attacks only when every fief it owns stays past its gates afterwards, buys men once the economy tops out, and uses interior fiefs as depots for the front. Over 70 years from all 17 starts, 137 of 340 games die in the opening without taking a second fief. Of the 203 that expand, 186 unify Japan (92%). A planner that matched targets to sources within the free army changed nothing (185 against 186), although it was built against measured slack: 70-89% of the spare army idled and enemy holes stayed open for years.

The margin explains why. Once a player is past being hunted, the AI cannot retaliate strategically. It judges each attack on its own gates, so any plan that takes territory fast is close to optimal, and a greedy one is enough. All the intelligence pays in the opening, where the margin is thin. A planner should matter against opponents that answer back: the all-player map in the NA1 roadmap, which explores what is possible rather than what beats this AI (and see [the coalition problem](./multiplayer-coalition-problem.md)).

## History, read through the formulas

A fief starting at morale 21 and loyalty 31 reads like a ruler the army and the peasants already resent. Surviving it takes the arc of a lord who turns wise: feed the army before you tax it, buy its loyalty before you need it, and make yourself not worth picking. The Saito of Mino are an apt specimen. Dōsan, the "Viper of Mino", rose by betraying his own lords and was killed in 1556 by his son Yoshitatsu. Past wrongs collect, and the 1560 fief carries that debt.

## Open Questions

- ~~Is the strong-fief insensitivity real, or only observed? Test it: run `ev` against the script on a strong start; the thesis predicts a near-zero gap.~~ **Resolved 2026-11-11** → [`na1-decompiler` synthesis #47](https://github.com/chrisaacson69/na1-decompiler/blob/main/docs/synthesis-frontier.md): 6-year games, 50 seeds each. On Oda (47-49 alive of 50) and Tokugawa (41-42) survival is the same under every player; on the mid fiefs Hojo and Imagawa the EV players keep 4-8 more. The dial is the warning horizon: react to a threat 2 seasons ahead and the mid fiefs gain survivors for about 5% income, while the strong fiefs lose nothing.
- Does a planner (rung 4) start to pay once the opponents retaliate? The all-player NA1 map is the test; against the gated AI it was neutral (#48).
- Does the margin also predict *which* rung is enough? Is there a margin below which rung 3 beats rung 2 and above which they tie?
- Is this the same lesson as [binding-constraint determines analysis depth](./nobunaga-crucible.md) (a candidate on the crucible page), one level down: the position rather than the game?

## Tags
[games](../../tags/games.md), [strategy](../../tags/strategy.md), [game-ai](../../tags/game-ai.md), [nobunagas-ambition](../../tags/nobunagas-ambition.md), [methodology](../../tags/methodology.md)
