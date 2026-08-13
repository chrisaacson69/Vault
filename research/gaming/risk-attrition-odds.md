---
status: active
created: 2026-08-13
published: true
layout: layouts/page.njk
title: "Risk — The Attrition Constant, and Why Big Battles Are Predictable"
---
# Risk — The Attrition Constant, and Why Big Battles Are Predictable
> A Risk battle solved exactly as an absorbing Markov chain, and the three structural facts that collapse it. The headline is a design result, not a math result: because the engagement frontage is capped at 3-vs-2 dice *regardless of stack size*, Risk implements Lanchester's **linear** law — concentration of force buys nothing — and the attrition price is the exact rational **2387/2797 ≈ 0.853 attacker armies per defender killed**. Two consequences run in opposite directions: **there is no tactical deterrence** (matched stacks of 12+ favour the attacker, and the defensive premium needed to hold *shrinks* as borders grow, so a big border is an offensive asset), but **a won battle costs ~85% of the attacking force**, so in a symmetric three-player standoff the winner drops from a third of the board's force to 13.6% while the bystander rises to 86.4%. Risk omits tactical deterrence and recovers stability from the player count — and that stability **decays as players are eliminated**, since the restraint was always the bystander. Applied to two pieces of common table advice: matching an escalating border is the most expensive way to stay unprotected, and interior garrisons should be **2, never 3** (the 2nd army buys the defender's second die; the 3rd buys nothing).

**Links:** [BattleValue](./battle-value.md) (**the direct contrast** — BV = sqrt(Attack × HP) is a *Square* Law metric; Risk is the linear-law counterexample), [D&D Monster Tournament — Exact Markov Chains Instead of Dice](./dnd-monster-tournament-markov.md) (same method, sibling specimen), [Yahtzee — 259 Trillion → 405 Million](./yahtzee-solved.md) (state-space collapse as the enabling move), [Battleship — 30 Billion Boards](./battleship-board-analysis.md) (structure creates norms, substrate fully enumerated), [D&D Spell Damage Model](./dnd-spell-damage-model.md), [Randomness as the Termination Mechanism](./n3-termination-and-randomization.md) (**the sibling stabilizer** — the brake here is the *cost of winning*, not randomness), [The Multiplayer Coalition Problem](./multiplayer-coalition-problem.md) (**where the strategic half of this page lives** — relative position is everything, and the bystander math below is that thesis with the arithmetic filled in), [The Three-Layer Method](../karpathy-three-layer-method.md)

**Tool:** [`tools/risk-battle-odds.py`](../../tools/risk-battle-odds.py) — two independent engines, `--selftest` cross-checks them on every run.

> **Specimen trigger (2026-08-13).** A Risk short: a stack of 299 attacks a territory of 300 and takes it, moving in 54 and leaving 1 behind. The table-side claim was that ~50 survivors is roughly par and 54 is only slightly lucky. That claim is **correct** — the exact expectation is 45.3 given a win, and 54 sits at the 65th percentile.

## The exact answer

299-stack (so 298 committed) against 300 defenders, fought to the death, both sides always rolling maximum dice, defender winning ties:

| Quantity | Value |
|---|---|
| P(territory falls) | **94.39%** |
| E[survivors] given a win | **45.31** |
| E[survivors] over all attacks (a failure = 0) | 42.77 |
| Median / mode | 43 / 44 |
| sd given a win | **22.04** — only **7.4%** of the 298-army force |
| The observed 54 | ~65th percentile; 33% of wins do better |

## Why the matrix collapses

The brute-force `(a, d)` grid is mostly waste, and the game says so. While `a ≥ 3` and `d ≥ 2` the round is always 3-vs-2, and **a 3-vs-2 round kills exactly two armies** — never one, never three. Three consequences follow:

1. **Parity is invariant.** `a + d` falls by exactly 2 each round, so its parity never changes and half the grid is unreachable. Measured on the 299-vs-300 case: of 89,999 cells, exactly **50.7%** are ever touched (half, plus the boundary).
2. **The bulk is one-dimensional.** In that regime the dice odds do not depend on `(a, d)` at all, so attacker losses are a running sum of IID draws from {0, 1, 2}. Not a 2-D chain — a random walk.
3. **The endgame is a thin closed shell.** The regime is left only through `a ≤ 2` or `d ≤ 1`, and that region is closed under transitions, so it solves separately in O(A+D) — **595 states** against a 90,000-cell grid.

**Honest accounting:** the reduction is *not* asymptotically faster. Both engines are O(A·D)/2, because a forward sweep that skips zero-probability cells already avoids the dead half implicitly. What the reduction actually buys is a structurally independent oracle, and fact 2's closed forms — which brute force cannot give you.

## The closed forms (derived, not fitted)

Per 3-vs-2 round the attacker loses `7161/7776` armies and the defender `8391/7776`; they sum to exactly 2, because two armies always die. So the attacker's price per defender killed is the exact rational

> **c = 7161/8391 = 2387/2797 = 0.8534143725…**

Because the bulk increments are IID, `Z = a − c·d` is a **martingale** — expected change per round exactly zero — so optional stopping gives `E[survivors] = A − c·D` directly. The same argument on the variance gives the part everyone misjudges:

> **sd(survivors) ≈ 1.447 · √D**

**Spread grows with the square root of the battle while force grows linearly, so big battles are proportionally *more* predictable.** Risk feels swingy because a single 3-vs-2 roll is; a 278-round battle is not. The back-of-envelope players actually use — *"attacker wins 7 for every 6 lost"* — is 7/6 = 1.1667 against the exact ratio 2797/2387 = 1.1718: **0.435% off**, and slightly *understating* the attacker's edge.

## The design result: Risk is Lanchester-LINEAR

Lanchester's **Square** Law says concentrated force is superlinearly better — the basis of [BattleValue](./battle-value.md)'s `BV = sqrt(Attack × HP)`. Risk does **not** obey it, and the reason is a design choice: **the engagement frontage is capped at 3 dice vs 2 regardless of stack size.** A 300-army stack brings exactly as much force to bear per round as a 3-army stack. Fixed frontage is the classic condition that produces linear-law attrition, and the exact chain confirms it:

| N vs N | P(win) | E[S] | E[S]/N | sd/√N |
|---|---|---|---|---|
| 25 | 0.6565 | 5.24 | 0.2096 | 1.019 |
| 100 | 0.8244 | 16.13 | 0.1613 | 1.228 |
| 400 | 0.9730 | 59.14 | **0.1479** | **1.412** |

`E[S]/N` converges to the predicted `1 − c = 0.1466`, and `sd/√N` to the predicted `1.447`. Doubling both sides multiplies survivors by 1.795 → 1.880 → **1.950**, converging on 2 — linear, not square.

The sharpest test is direct. Is one concentrated 200-vs-100 fight better than two separate 100-vs-50 fights?

- 200 v 100 in one battle: **E[S] = 114.88**
- 100 v 50, twice: **E[S] = 115.10 total**
- Difference: **−0.22 armies. Zero concentration advantage** (the sign is an endgame artifact — each smaller battle gets its own favourable tail).

**So numerical superiority in Risk is purely additive.** This is a real design lever, and it explains a familiar table dynamic: massing a doom-stack buys staying power but no force multiplier, which is exactly what keeps a Risk leader killable and the game terminating — the same function [randomness serves in N≥3 games](./n3-termination-and-randomization.md). A Square-Law Risk (dice scaling with stack size) would snowball uncontrollably.

## Tactical: there is no defensive deterrence, and big borders make it worse

Because an attacking army is worth **1/c = 1.172 defending armies** — the third die more than pays for the defender's tie-break — parity favours the attacker, and *linear* attrition means that per-army edge multiplies by the count instead of washing out. The crossover is sharp. If both players hold a stack of N and the attacker commits N−1:

| Equal stacks | 9 v 10 | 10 v 11 | **11 v 12** | 12 v 13 | 49 v 50 | 99 v 100 | 299 v 300 |
|---|---|---|---|---|---|---|---|
| P(attacker wins) | 0.4799 | 0.4940 | **0.5065** | 0.5179 | 0.7057 | 0.8079 | **0.9481** |

**Stacks of 12 are the tipping point** — above that, matched borders favour the *attacker*, and the edge runs away with scale. The break-even frontier converges on the attrition constant itself: the attacker needs only `A/D → 0.8534` for even odds. And the defensive premium required to actually hold (P(hold) ≥ 0.9) **shrinks** as the border grows — 1.90× the attacker's numbers at 10 armies, 1.41× at 100, 1.31× at 300.

> **A big border is not a defensive structure. It is an offensive one** — a stack large enough to hold is already large enough to attack, and the bigger it gets the truer that becomes. Risk has no tactical deterrent; it was never built in.

## Strategic: winning is how you lose (the bystander)

The brake is not on the board, it is in the player count — and the exact chain quantifies precisely how expensive a won battle is. Take a symmetric three-player standoff, each holding a stack of N. P1 attacks P2 with everything; P3 does nothing:

| N | P1 wins | P1 left with | P3 / P1 | P1 share of board | P3 share |
|---|---|---|---|---|---|
| 12 | 0.51 | 5.75 | 2.09× | 32.4% | 67.6% |
| 100 | 0.81 | 19.92 | 5.02× | 16.6% | 83.4% |
| **300** | **0.95** | **47.11** | **6.37×** | **13.6%** | **86.4%** |

At N = 300: P1 spends **253 armies**, P2 spends **all 300**, P3 spends **nothing** — and P1 goes from a third of the board's force to **13.6% by winning**, while the bystander rises to 86.4%. Since retention converges on `1 − c = 14.7%`, this gets *worse* at scale, not better. Hence the closed form for the price of admission:

> To attack a stack of N without falling behind an untouched bystander, you need **(1 + c) = 1.853 × N** — measured at 1.833 → 1.853 as N grows.

**In Risk, relative strength is the only strength**, so a border stack's value is as an *unspent threat*. Spending it converts a tactical certainty into a strategic collapse. That is the same brake [randomness provides in N≥3 games](./n3-termination-and-randomization.md) and the [coalition problem](./multiplayer-coalition-problem.md) describes socially, arriving here through the combat arithmetic instead — which is a design result worth naming: **Risk deliberately omits tactical deterrence and recovers stability from the player count.**

**What is computed here and what is not.** The two-player battle is exact. The three-player table is *arithmetic layered on top of it* under a deliberately bare model — symmetric stacks, no turn order, no cards, no coalition choice, and **no reinforcement income**. That last one is the real limitation and cuts against the thesis: conquest takes territory, territory pays reinforcements, and continent bonuses can repay 253 armies over enough turns. So this is a **snapshot of force, not a flow** — it shows what a battle costs, not whether the conquest was worth it. The claim that a third player actually *converts* the advantage is an assumption imported from the two pages above, not a result of this solver.

## Reading the signal: what to do about a big border

**Matching it is the worst available option** — not merely insufficient, but the most expensive way to remain unprotected:

| Both hold N | 12 v 12 | 50 v 50 | 300 v 300 |
|---|---|---|---|
| Attacker takes it anyway | 50.7% | 70.6% | **94.8%** |

You spend 300 armies and still lose 95% of the time if they commit — while both of you feed the bystander. So the correct read of an escalating neighbour is *don't follow*, and the reason is not stinginess: **the escalation cannot be answered tactically at all**, because there is no tactical deterrent to buy.

**The phase transition — stability decays as players are eliminated.** Since an attacker retains `S − c·D`, an attack only improves their *relative* standing if `S − c·D ≥ B` for a bystander at `B`. The required border therefore depends on the third player, and rises sharply as the table empties:

| Board state | Border you need vs a 300-stack |
|---|---|
| 3 players, all equal | almost nothing — their attack cannot pay |
| bystander at half | ~59% of their stack |
| **2 players left (B = 0)** | **117% of their stack** |

This is the mechanism under [the N≥3 stability thesis](./n3-termination-and-randomization.md): the restraint was never in the combat system, and it **evaporates as players die**. The endgame knife fight is not a change in mood — it is `B → 0` removing the only constraint that was operating.

> **The signal to read is not your neighbour's stack size. It is their stack size relative to the largest untouched player.** A 300-border while someone else also sits at 300 is a bluff that cannot be profitably cashed; the same border in a three-player endgame with a crippled third is a genuine threat.

⚠ **Heuristic, not a rule.** The `D > (S − B)/c` threshold is directionally sound in the mid-range but **degenerates at both ends**, and the failure is instructive: at `B = S` it claims a 300-stack cannot profitably take even a *1-army* territory, i.e. "defend with 1 army." That is the no-income assumption showing through — taking a 1-army territory for ~0.85 armies is plainly correct in real Risk, because territory pays reinforcements and advances the card track. Use the *direction* (a larger third player means a smaller border needed); do not use the number.

## Interior garrisons: the folk advice is half right, and the half is "2, never 3"

Common table advice is to hold interior territories with 2 or 3 armies rather than 1. The exact chain says the entire effect is the **second** army, because the defender rolls `min(2, d)` dice — the 2nd buys a second die, the 3rd buys nothing:

| A defending army absorbs | attacking armies |
|---|---|
| alone in a 1-stack | **0.516** |
| in a stack of 2 or more | **0.853** |

A **1.65× improvement**, so the instinct is sound. But it is fully spent at two. Holding the same 12-army budget:

| Deployment | Attacker pays to clear it all |
|---|---|
| 12 × 1 | 6.19 |
| **6 × 2** | **9.28** |
| 4 × 3 | 9.23 |
| 2 × 6 | 9.81 |

Three-stacks are *marginally worse* than two-stacks for the same budget **and** cover a third fewer territories. **The advice should be "2", never "3".**

**What it actually buys is denial of the one-turn cascade.** A rolling stack clears ten 1-army territories for **5.2** armies; ten 2-army territories cost it **15.5**. That is frequently the difference between losing your whole interior in a single turn and stalling the stack halfway. It is an anti-sweep measure, not general defense.

**Why it is still usually wrong.** Per army, offense beats even the best defensive arrangement: an attacking army removes `1/c = 1.172` defending armies against 0.853 absorbed — **1.37×**, and **2.27×** against 1-stacks. ⚠ **But the dominant term is outside this model: mobility.** Risk permits one fortify per turn, so armies spread two-deep across a dozen interior territories are not merely lower-value, they are *stranded* — they cannot be reassembled into the concentration a winning attack requires. That mechanic, not the 1.37×, is the real argument against garrisoning, and this solver cannot see it.

**The exception is when the offense multiplier has nothing to multiply.** The 1.37× premium only pays if the attack changes your standing — and per the bystander section above, a won battle costs ~85% of the committed force and *lowers* your relative position. A player far enough behind that no available attack improves their position holds armies with an offensive value of effectively zero, leaving 0.853-per-army survival as the only remaining return. **Garrisoning at 2 is what is left when attacking has stopped paying** — which makes it a symptom of a losing position rather than a route out of one.

## Verification ledger

Four routes, agreeing — the point of the exercise, per [the three-layer method](../karpathy-three-layer-method.md):

| Oracle | Independent of | Result |
|---|---|---|
| Forward 2-D sweep (floats) | — | P(win) 0.943857516025 |
| Backward recursion in exact **rationals** | float arithmetic, sweep order | identical to 12 dp |
| **Reduced** chain (parity walk + boundary shell) | the entire 2-D formulation | delta **5.6e-16** |
| Monte Carlo, 200k battles, actual dice | all three exact engines | 45.34 vs 45.31 |
| Martingale closed form | every chain implementation | 41.98 vs exact 42.77 |

Per-round dice odds are checked against the published Risk tables (3v2 = 2890/2611/2275 over 7776). The MC's `P(win)` first landed 3σ high — two further seeds at 0.95σ and 0.47σ showed that was an unlucky draw, not a bug. **A single-seed Monte Carlo is not a verification.**

## Open threads

- **Multi-territory campaigns.** One battle is solved; a chain of territories (each conquest leaving 1 behind, feeding the next attack) is the real strategic object and is not yet modelled.
- **The stop-early decision.** This assumes fighting to the death. The genuine decision problem — when to break off — turns this from a chain into an MDP, the same fixed-policy-vs-decision boundary that makes the [D&D tournament](./dnd-monster-tournament-markov.md) tractable.
- **Does the linear-law finding generalize?** Any game with a capped engagement frontage should be linear-law. Candidate check across the vault's combat games — and a genuine falsifier for BV's Square-Law framing wherever frontage is capped.

## Tags

[games](../../tags/games.md), [game-theory](../../tags/game-theory.md), [game-design](../../tags/game-design.md), [strategy](../../tags/strategy.md)
