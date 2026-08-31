---
status: active
created: 2026-07-30
published: true
layout: layouts/page.njk
title: "Combinatorial vs Generative Design Space"
permalink: /research/gaming/combinatorial-vs-generative-design-space/
---
# Combinatorial vs Generative Design Space
> A game built from a closed vocabulary can be verified; one built from per-unit free text can only be playtested. The escape from the first to the second is measurable — and it is where balance stops being checkable.

**Links:** [HeroClix](../../projects/heroclix/README.md) (**the dated specimen** — 0 → 434 characters of bespoke rules text per figure, measured), [BattleTech Simulator](../../projects/battletech-simulator/README.md) (the sibling worry: rules drifting toward OP and absurd), [BattleValue](./battle-value.md), [D&D Monster Tournament — Exact Markov Chains](./dnd-monster-tournament-markov.md), [Gaming](./README.md)

## The two regimes

**Combinatorial.** Units are combinations drawn from a fixed vocabulary of abilities. The space is
finite and enumerable, so interactions can be *reasoned about exhaustively* — with 28 abilities
there are only 28 things that can interact, and a designer can hold the whole lattice in view.

**Generative.** Each unit carries arbitrary rules text unique to itself. The space is unbounded.
No enumeration exists, so balance stops being a property you can verify and becomes an empirical
question settled by play.

Every long-running unit-collection game faces the same pressure: **a combinatorial space
exhausts.** After enough releases the interesting combinations are used up. There are only two
exits — grow the vocabulary, or let each unit write its own rules — and the second is far cheaper.

## The measurement (HeroClix, 2002 → 2024)

| | 2002 (Infinity Challenge, 176 figures) | 2024 (43 figures) |
|---|---|---|
| standard vocabulary | **28 abilities**, exactly 7 per stat slot | **~50** (≈1.8×) |
| ability slots that are free text | **0.0%** | 19.8% |
| units carrying ≥1 free-text ability | **0%** | **86%** |
| **bespoke rules text per unit** | **0 characters** | **434 characters** |

Zero across 176 units, twenty-two years later 434 characters on 86% of the roster. The vocabulary
did grow, but that is a rounding error beside the escape hatch. **The exit is not vocabulary
growth; it is the shift of rules authorship from the system to the unit.**

## The currency inflates even when the pricing doesn't

A second measurement separates two things that are easy to conflate. Fitting unit cost on stat
lines alone, 2002 vs 2024: **R² falls 0.889 → 0.682, but mean absolute error is 10.1 points in
both eras and residual SD is 13.4 vs 13.3.** The pricing function did not get worse; modern units
just cluster in a narrower cost band (SD 40 → 24), so the same error explains less variance. *R²
measures explained variance, not accuracy* — here they come apart cleanly.

Yet a cost-matched cross-era test shows the baseline moved: a 67-point 2002 unit beats
**cost-matched** contemporaries 85% of the time and cost-matched 2024 units **37.5%** — and that
test is one-sided in the old unit's favour, since ~20% of the modern units' abilities are free
text the model cannot read.

**So the unit cost is an intra-era currency, not an inter-era one.** Power creep in its cleanest
form is not sloppy pricing — it is a *stable pricing function applied to a rising baseline*. Which
means internal balance metrics cannot detect it: every set looks well costed against itself.
Detecting creep requires cross-era play, which is exactly what a collectible game rarely tests.

## Three eras, three instruments

The transition is not a single step. HeroClix went through a middle stage worth naming, because
each stage needs a *different analytic tool*:

| Era | Rules regime | Right instrument |
|---|---|---|
| **Early** | simple rules; **each universe has its own ability set** | exact enumeration, per universe — small closed vocabulary |
| **Middle** | abilities **unified into one chart** and expanded; cross-universe play legal | same tool, wider vocabulary. **Best ratio of tractability to design richness** |
| **Modern** | abilities become **per-unit free text** | needs a *parser* before a solver is applicable at all |

The early stage is verifiable in the source documents: a 2002 colour-coded Marvel/DC rulebook diff
shows **Impervious as a DC-only ability**, and the Marvel set's entire defense vocabulary lacks it.
Two universes, two vocabularies — so the "closed vocabulary" of the early era is closed *per
universe*, which makes within-universe analysis easy and cross-universe analysis meaningless.

**The middle era is the sweet spot for any analyst**, and it is worth recognising while a system is
in it: one vocabulary, still enumerable, maximum expressive range. That window closes without
announcement.

## Why it matters beyond the game

**Verifiability is the thing traded away.** In the combinatorial regime, "is this balanced?" is
answerable in principle by enumeration. In the generative regime it is answerable only by
sampling actual play — so mispricing is no longer *prevented*, only *detected*, and only after
release. Power creep is not inevitable under that regime, but it becomes very hard to detect
early, which is the same failure mode by a slower route.

**It degrades the analyst, not just the designer.** Any model that reads the vocabulary — a
simulator, a solver, a ranking — sees 100% of a combinatorial set and progressively less of a
generative one. The HeroClix Markov model reads 100% of the 2002 vocabulary and ~80% of a 2024
set's ability slots. **A method's coverage can decay with the age of its target even though the
method never changed.** Any long-horizon analysis should therefore report coverage per release,
not once.

**The escape is a ratchet.** Once units carry bespoke text, returning to a closed vocabulary
would invalidate the existing catalogue. So the transition is effectively irreversible, which
means the decision to take it is far more consequential than it looks at the time — it is a
one-way door disguised as a content decision.

## Open questions

- **When does the transition happen, and what triggers it?** HeroClix appears to have taken it
  fast (a 2006 sample already shows free text, though n = 4). Is the trigger elapsed releases,
  vocabulary saturation, or commercial pressure for novelty?
- **Is there a stable middle?** Keyword systems (Magic's evergreen keywords, Warhammer's USRs)
  try to keep text *named and reusable* — free text that gets promoted back into vocabulary once
  it recurs. Does that actually arrest the ratchet or just slow it?
- **Can the generative regime be made checkable again** by machine — parsing the text back into
  a formal vocabulary? That is the same problem as lifting decompiled code to a symbol table, and
  the [three-layer method](../karpathy-three-layer-method.md) suggests it is tractable when a
  grounded lower artifact exists.
- **Does BattleTech show the same curve?** It is the natural comparison: same founder lineage
  (Jordan Weisman founded FASA in 1980 and WizKids in 2000), same worry about rules drifting
  toward the absurd, and an existing vault project positioned to measure it.

## Tags
[games](../../tags/games.md), [game-theory](../../tags/game-theory.md), [simulation](../../tags/simulation.md), [epistemology](../../tags/epistemology.md)
