---
status: active
created: 2026-07-29
published: true
layout: layouts/page.njk
title: "HeroClix — Dial Data, Rules, and Exact Combat"
permalink: /projects/heroclix/
---
# HeroClix — Dial Data, Rules, and Exact Combat
> Fetch 14,659 HeroClix figure dials plus the official rules, join them, and rebuild the exact Markov combat model that once crowned Hercules for the wrong reasons.

**Links:** [Combinatorial vs Generative Design Space](../../research/gaming/combinatorial-vs-generative-design-space.md) (**the thesis this project produced** — closed vocabulary vs per-unit free text), [D&D Monster Tournament — Exact Markov Chains](../../research/gaming/dnd-monster-tournament-markov.md) (**the direct ancestor** — it already records the prior HeroClix result and the Hercules confound), [BattleValue](../../research/gaming/battle-value.md) (the metric this tests), [BattleTech Simulator](../battletech-simulator/README.md) (the Monte Carlo sibling — same bargain-hunting motive, sampled instead of exact), [Gaming](../../research/gaming/README.md)

**Code:** logical name `heroclix`, cloned as a sibling (`../heroclix`). Local, not yet pushed.
**Repo entry point:** `README.md` → `docs/00-source-recon.md`.

## Why this exists

HeroClix is the ideal case for exact Markov combat modelling, because of one mechanic: **the
dial**. A figure has no single stat line. Every click of damage rotates its dial to a *different*
line, so speed, attack, defense, damage, and its whole power set change as it gets hurt.

That is exactly backwards for a closed-form metric like [BV = sqrt(Attack × HP)](../../research/gaming/battle-value.md),
and exactly right for a Markov chain — a chain already carries HP in its state, so "stats are a
function of remaining HP" costs nothing. Transition probabilities just read the current click.

Chris built a version of this years ago and the code is gone. **The finding survived**, and it is
the reason this project has a constraint before it has a line of model code: Hercules topped
BV/cost only because he was a cheap melee brawler, and range plus non-combat abilities were too
hard to model. *The metric crowned whatever best fit the model's blind spot.*

## Recon result (2026-07-29) — both sources fetch, and they join

The knowledge needed splits in two, and no single source has both halves:

| Half | Source | Gives |
|---|---|---|
| **Data** | `hcunits.net/api/v1/` — undocumented but clean JSON | Per-click stat lines and powers, point values, range, keywords |
| **Rules** | WizKids PDFs (free to players) | Comprehensive Rules + the Powers and Abilities Card that defines each power |

Scope: **333 sets, 14,659 units.** One request enumerates a whole set; full dials cost one
request per unit. A third candidate, **HCRealms**, is a dead end for automation — the 2015 "Units
API" thread ends with the admin shelving it, and hcunits gives strictly better structured data.

The two halves join on the power name, normalised past punctuation. The wrong guess is instructive:
a naive underscore→space match silently loses every slash-named power (`Energy Shield/Deflection`,
`Penetrating/Psychic Blast`, `Phasing/Teleport`) and reads as a coverage gap across rules editions
rather than as a broken matcher. Normalised, coverage is 17/17.

Full probe log, endpoint map, and licence posture: `docs/00-source-recon.md` in the repo.

## Fetch politely — a set at a time

Both sources disallow crawlers in `robots.txt` (hcunits `/api/`, WizKids `/*.pdf`), and hcunits'
TOS reserves reuse to written permission. So the fetcher is **cache-first, rate-limited, and
resumable**, the corpus grows one set at a time, and the ~14.7k-request full sweep is refused
behind an explicit permission flag. Fetched material is gitignored — the repo commits tools and
derived analysis, never the mirrored corpus, exactly as the decompiler repos treat ROMs.

## Infinity Challenge (2002) — the first set modelled, and the result that matters

IC is the right first target: the original Marvel set, the era Chris played competitively, small
enough to model exhaustively. All 176 character dials fetched.

**The unit count isn't what it looks like.** 208 entries are only **70 distinct characters** — the
Rookie/Experienced/Veteran ring mechanic, exactly 46/46/46, plus uniques and 32 non-characters
(bystanders, maps, terrain markers). The same character costed three ways is a *built-in
cost-efficiency experiment*, and arguably the most interesting structure in the set.

**The Marvel/DC rules fork was real but shallow — and it's measurable.** The 2002 fan-compiled
annotated rulebook colour-codes Marvel text against DC's separate rulebook, and those colours
survive as PDF span attributes, so the divergence extracts mechanically: DC-only 270 characters,
Marvel-only 1,415, almost all terminology or single-word clarifications. **Nothing in either fork
touches core combat resolution.** One combat model is valid across both universes for this era.

### The Pyro result — the Hercules confound running in reverse

Veteran Pyro (42 pts, range 8, 2 targets, **printed damage 1**) against Thanos (185 pts, defense 18,
Invulnerability). Invulnerability reduces damage by 2:

| Model | E[damage]/attack | Turns to KO |
|---|---|---|
| **Stats only, powers ignored** | **0.000** | **never** |
| + Ranged Combat Expert (damage +2) | 0.278 | 39.6 |
| + Black Panther's Outwit removes Invulnerability | 0.833 | **13.2** |

A stats-only model doesn't underrate the era's premier damage dealer by some percentage — it reports
that he **can never kill Thanos at all**, because 1 − 2 = 0. Model two powers and 88 points grind
down 185.

**This is the same error as Hercules, pointed the other way.** Hercules was crowned because the blind
spot flattered him; Pyro is erased because the same blind spot zeroes him. Unmodelled abilities read
as zero — and Pyro is the more dangerous case, because a zero looks like a *conclusion* rather than a
gap. The lesson generalises past HeroClix: **a metric's silence about an input is indistinguishable
from a measurement of nothing.**

Two supporting facts explain why that pairing *defined* the era rather than merely working: Outwit
appears on **exactly one figure in the whole set** (Black Panther — 1 of 70 characters), so there was
no substitute; and a 2002 arbitrator ruling forbids combining Ranged Combat Expert with any power
except Probability Control, so Pyro must choose single-target burst or multi-target area **every
turn** — meaning even 1v1 needs a policy, and the policy will move the rankings.

## First results (2026-07-30) — the model ran, and it caught the old error twice

All **15,400** Infinity Challenge matchups solved *exactly* as absorbing Markov chains over both
dials — state is (click_a, click_b), both sides attack simultaneously, win probabilities from
`N = (I−Q)⁻¹`. No simulation. The dial really is the ideal Markov feature.

Two things went wrong in instructive ways, and both are the *same* error wearing new clothes.

### 1. The metric reproduced the Hercules artifact

Ranking by win-rate-per-point put **every one of the top 20 between 10 and 38 points**. A 10-point
generic losing 80% of its fights outranked every premium figure. The mechanism is general and worth
remembering beyond games:

> Win rate is bounded below by zero, so dividing a bounded value by a small cost inflates cheap
> options automatically. **Any value/cost metric where value cannot go negative will crown the
> cheapest thing that isn't completely useless.**

The abilities had been fixed — so the blind spot simply relocated into the *ranking function*.
Fixed by measuring each figure against the field's cost curve (`win_rate = a + b·ln(points)`,
R² = 0.80) and ranking the residual, which centres at zero by construction.

### 2. Hercules returned — and this time the confound was measurable

With the corrected metric, **Hercules (experienced), 67 pts, ranks #4 underpriced: 83.8% win rate
against a predicted 46.8%, fair value ~120 points.** Same figure, same verdict, twenty years later.
His dial is exactly the profile that won in 1st edition: range 0, attack 11, damage 4, 8 clicks,
Super Strength and Toughness all the way down.

The two range modes *agreed* on him — which turned out to be the trap. Testing whether they were
capable of disagreeing:

| mean P(ranged beats melee) | |
|---|---|
| best_case | 0.4518 |
| scalar | 0.4470 |
| **difference** | **0.005** |

**They were bracketing nothing.** Both quietly favour melee — `best_case` grants free adjacency,
`scalar` forces the shooter into close combat once closed. Two melee-friendly models agreeing that a
melee figure is great is not evidence. Adding a `kite` bracket (shooter fires every turn, melee never
connects) widened the spread to 0.071, and Hercules moved:

| Range assumption | Hercules win rate | Stalemates |
|---|---|---|
| best_case (melee-friendly) | **0.843** | 0 / 170 |
| scalar | 0.819 | 3 / 170 |
| kite (ranged-friendly) | **0.385** | 20 / 170 |

*(Corrected 2026-07-30: first reported as 0.585 / 89 stalemates. That was a solver bug —
`(I−Q)` was inverted over unreachable states, whose self-loops made the matrix singular and were
scored as stalemates worth 0.5. Restricting to reachable states fixes it, and makes the confound
**larger**: the bracket is 0.46 wide, not 0.25.)*

So the honest result is not "Hercules is underpriced" but: *underpriced **if** figures reliably close
to melee, roughly fair **if** ranged figures can kite.* The answer is an interval, and the interval is
a property of the board, which this model doesn't have.

**The generalisable lesson — [agreement between models is worthless until you have checked they were
capable of disagreeing](../../research/gaming/dnd-monster-tournament-markov.md).** The toggle's job
was never to pick the right assumption; it was to convert a hidden assumption into a measured
interval, and it failed silently at that job until the bracket width itself was tested.

Under `kite` the ranking doesn't merely shift, it **inverts** — brawlers out, shooters in (Bullseye,
Cyclops, Skrull Warriors), and Hercules leaves the top 15 entirely. There is no "best figure in
Infinity Challenge"; there is only a best figure *per assumption about the board*.

### The bonus finding: the price list knows about the board

The cost curve's own fit collapses across the bracket — R² = **0.800** (best_case), 0.791 (scalar),
**0.477** (kite). WizKids' point values predict combat outcomes well in a world where figures reach
each other and poorly in a world of pure kiting. Since the designers priced with real boards and
terrain in mind, that is **empirical evidence, recovered from the price list alone, that the game is
costed on the assumption that melee can close.**

So the melee-friendly end of the interval is the more probable one — but note the direction of the
inference: that comes from the data, not from preferring the mode with the tidier answer. It makes
the interval *asymmetric*; it does not collapse it.

### 3. The class that proves the pricing idea

Four figures have **damage 0 on every click** — all three Professor Xaviers and Ant-Man LE, **252
points** in total. Xavier cannot KO anything ever; Xavier vs a 10-point Thug is a genuine
*non-absorbing* chain, now detected rather than scored as a loss. WizKids charged **83 points** for a
figure whose 1v1 combat value is *provably* zero — the tail that proves the +6.3-point team-power
premium isn't noise. They're reported in their own section, because a zero at the bottom of a ranking
reads as "bad figure" while a zero under *no kill path* reads as "wrong instrument."

## Rarity, and the action economy that prices everything (2026-07-30)

Full detail in the repo (`docs/05`); the parts that generalise:

**The special rarities were properly pointed.** Gold figures (`limited_edition`, from
tournament prize kits) and Rares (`unique`) are statistically indistinguishable from the standard
R/E/V ladder on *both* instruments — a hedonic fit on stat lines and 15,300 exactly-solved fights
(all |t| < 1). Two measures that could easily have disagreed, agreeing.

**The 50-point rule is a structural constant, not a heuristic.** The rulebook gives 1 action per
100 points of build total, one action per figure per turn, and a click of self-damage for acting
twice running. So a figure sustains 0.5 actions/turn, filling every action needs ≥2A figures on a
budget of 100A, and the average cost lands at exactly **100A/2A = 50 points**, independent of build
total. Consequence: **a centrepiece is taxed twice — in points and in action throughput** — because
it eats one action slot per turn just like a 25-point thug.

Remarkably, the set's own cost distribution is built around it: mean cost is 51.2 (R/E/V) and 50.2
(gold), while Rares average 93.2. **The common classes are priced as action fillers and the Rares as
centrepieces.**

**A third valuation channel.** Leadership grants +1 action on a d6 of 4–6 — i.e. +0.5 actions/turn,
worth ~50 points of *equivalent build total*, against a hedonic price of ~10 points. The 1v1 chain
scores it exactly zero and always will, because it isn't about fighting. So the action economy
prices **force-level** abilities with no combat modelling at all — the only one of the three
instruments that can see above the figure level. That is the real answer to "team abilities are hard
to model in 1v1": not too hard, just *measured on a different instrument*.

**A schema can be complete and still not tell you what's playable.** The 300-point, 18-click
Sentinel is typed `character` with a full dial, and was silently sitting in the rankings winning 94%
and anchoring the cost curve. It's a purchase-only scenario model. The tell is `dimensions != "1x1"`
— but knowing to look came from domain memory, not from the data.

## Team abilities — one of twelve is modellable, and we know exactly why

The 2002 rulebook settles the "do they need two figures?" question directly: **it's per-team,
not universal.** "The X-Men team ability requires two X-Men members to work. The Avengers team
ability, however, is available to any Avengers team member. There is no underlying rule."

Of the twelve Marvel team abilities: **9 need a partner, 3 work solo, and exactly 1 is a combat
effect the chain can represent.** The split isn't arbitrary — the solo three are a targeting
dodge and two free moves; everything that reaches *across* figures (sharing stat values, healing
each other, buffing an ally's attack) needs the ally. That's what "team" means.

**Skrulls** is the modellable one: target rolls a d6, and on a 6 the attack cannot be made —
structurally Super Senses but at the targeting step. Worth **+2.5 to +4.4 points of win rate** on
figures costing 11–19 points.

The rest sort onto the other instruments: Avengers/Brotherhood (a free move action) belong to
the **action economy**; the nine partner abilities to **hedonic pricing**. Watch **Masters of
Evil** — 2+ adjacent members attacking on *one action* attacks the 0.5-actions-per-figure
ceiling, the binding constraint of the whole economy.

**The data doesn't carry team abilities.** hcunits' `keywords` is the *modern* theme-team
mechanic, retro-applied, conflating affiliation with team ability: 13 of 175 figures carry 2–3
team names (Wolverine veteran is both Avengers and X-Men) though a figure has exactly one base
symbol. Skrulls is implemented only because its 8 figures are unambiguous *in this set* — hence
a flag, not a default. Assigning the others from keywords would be fabrication.

## Stealth: the power that makes the range question well-posed

Stealth was flagged as the model's biggest known distortion — 20 IC figures carry it, and it is
the melee figure's answer to a kiting shooter, i.e. exactly the matchup the bracket is widest on.
The 2002 rule is *"hindering terrain blocks line of fire to this character"*, so it needs terrain
the model doesn't have.

Rather than invent map geometry, terrain enters as **one explicit number**: `C` = the fraction of
lines of fire that cross hindering terrain. Ranged attacks on a Stealth figure are blocked with
probability `C` — and so is Outwit, since a 2002 ruling notes Outwit also needs a clear line of
fire.

The result confirms the intuition and then says something sharper. Mean bracket width
|best_case − kite|, which measures *how much the range assumption matters*:

| Cover | Stealth figures | No-Stealth control |
|---|---|---|
| 0.00 | 0.337 | 0.294 |
| 0.35 | 0.229 | 0.264 |
| 0.70 | **0.134** | 0.250 |

**Stealth collapses the bracket by 60%** while the control barely moves. So for figures that have
it, enough cover makes the outcome nearly *independent* of the range assumption.

That reframes what Stealth is. It doesn't merely help melee figures — **it converts an
assumption-dependent question into a determinate one.** The ranged-vs-melee axis is exactly where
this model is least trustworthy, and Stealth is the mechanic that makes it well-posed.

### And the advantage doesn't just shrink — it reverses

Mean win-rate gap between the 19 Stealth carriers and the other 152 figures:

| Cover | `kite` (ranged-friendly) | `best_case` (melee-friendly) |
|---|---|---|
| 0.00 | **−0.165** | +0.097 |
| 0.35 | −0.023 | +0.113 |
| 0.70 | **+0.087** | +0.125 |

Under a kiting assumption, Stealth carriers are **worse** than average on a bare board and
**better** on a covered one, crossing zero at roughly 40% cover. Meanwhile the melee-friendly
column barely moves.

Two things follow. First, Stealth carriers are the population **most sensitive to the terrain
assumption** — a 0.25 swing versus 0.03 for everyone else, ~9×. That follows from what Stealth
*is*: a short-range support power, so its carriers are exactly the figures a kiter beats, and
cover is the only thing that rescues them.

Second, and more interesting: **terrain density is not a nuisance parameter to average away — it
is the dial that decides whether short-range figures are viable at all.** That is a statement
about the metagame, not about any figure. It is also the mechanical form of "finding the proper
place for units is the important thing": the map chooses which half of the roster is playable.

## The open modelling problem

The recon moved the Hercules blind spot but did not close it:

- **Now addressable:** range, targets, and per-click powers are all in the data, so they no longer
  have to be dropped for lack of inputs.
- **Still hard:** `special` powers are *free text* — and they were 15 of 22 click-slots in the
  first proof slice. Terrain, objects, and team abilities are board-level, not dial-level.

So the honest first deliverable is a **restricted** exact model — 1v1, no terrain, standard powers
only, `special` figures excluded rather than silently mismodelled — that **counts and reports what
it excluded**. An unmodelled ability must never quietly read as a zero. That is the discipline the
Hercules result paid for, and the thing worth harvesting back into the vault when it holds.

## Open questions

- Does the dial make exact solution *harder* or *easier* than D&D 1v1? The state space grows
  (click position per figure), but it stays finite and small for 1v1 — likely still exact.
- Do 20 years of rules editions make cross-era comparison meaningless? A 2006 figure and a 2026
  figure were costed under different rules; is "points" even a common currency across eras?
- Is there systematic mispricing by era or by rarity — the same arbitrage angle as
  [BattleTech's BV2](../battletech-simulator/README.md)?
- How much of the roster is modellable at all, once `special` figures are excluded? If it's a
  small minority, the restricted model is a curiosity; if it's most of the roster, it's a ranking.

## Tags
[games](../../tags/games.md), [simulation](../../tags/simulation.md), [game-theory](../../tags/game-theory.md), [mathematics](../../tags/mathematics.md), [python](../../tags/python.md)
