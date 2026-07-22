---
status: active — design phase
created: 2026-07-20
published: true
layout: layouts/page.njk
title: "D&D Monster Tournament — Exact Markov Chains Instead of Dice"
---
# D&D Monster Tournament — Exact Markov Chains Instead of Dice
> A YouTube series rolls real dice to run elimination tournaments among same-CR D&D monsters. The same tournament is exactly solvable as an absorbing Markov chain — **because** the videos' combat has no real decisions in it. Expected payoff, per the Master of Magic precedent: a good approximation plus the ability to diagnose *why* a monster over- or under-performs.

**Links:** [BattleValue](./battle-value.md) (the metric this would give a ground-truth oracle for), [D&D Spell Damage Model](./dnd-spell-damage-model.md) (prior D&D math work), [Master of Magic — Economic Analysis](./master-of-magic/README.md) (the closest precedent — same complication classes), [Caster of Magic — Spell Counter-Graph](./master-of-magic/com-counter-graph.md) (the dominance-graph instrument to reuse), [The Dominance-Frontier Lens](../dominance-frontier-lens.md), [Yahtzee — 259 Trillion → 405 Million](./yahtzee-solved.md) (where the EV-vs-win-objective distinction was worked out), [BattleTech Simulator](../../projects/battletech-simulator/README.md) (**the sibling project** — same BV-validation motivation, but a state space that forces Monte Carlo; this one is its tractable proving ground), [Monopoly](../../projects/monopoly/README.md) (existing vault Markov-chain machinery)

---

## The core insight: the flaw is the enabling assumption

Chris's critique of the source videos is that the combat is unfaithful — **flyers don't exploit mobility, spells are cast essentially whenever available**, so melee brawlers are favored. That critique is correct, and it is also precisely what makes exact solution possible:

> **"Cast when available" is a fixed policy, and a fixed policy collapses a Markov *decision* process into a plain Markov *chain*.**

If these monsters made genuine tactical choices, this would be a two-player stochastic game — and we'd be back to approximation. Because they don't, the whole fight is a memoryless walk over a finite state space with an exact answer. The fidelity limitation and the tractability are **the same fact**. Don't apologize for the simplification; exploit it, then measure what it costs (see Deliverable 2).

## Prior art — Chris already did this, for HeroClix 1st edition

**This is not an untried method for Chris.** He built the same thing for **HeroClix (1st ed.)**:
Markov chains over combat, producing **exact** results, used to rank figures by **BV/cost**. Nothing
about this existed in the vault before 2026-07-20 — it is recorded here because it changes the
project's design, not as a war story.

**What HeroClix adds that D&D doesn't have — the dial.** Every HP step has a *different stat line*,
so figures gain and lose abilities as they take damage. This is the perfect Markov feature and a
terrible closed-form-metric feature: a chain already carries HP in its state, so
"stats are a function of remaining HP" is free — transition probabilities simply read off the
current position. Any single-number metric has to average over the dial and lose the structure.

**The Hulk case — damage granularity skips states.** Hulk starts near base-human stats and gets
*stronger* as he loses HP, making him a glass cannon. Chris's finding: **a multi-damage figure can
push him past the meatier positions on his dial.** Generalized, that's a real principle —
*with position-dependent stats, one big hit ≠ several small hits summing to the same total*,
because large hits **skip** favourable states entirely. D&D has thinner but real versions of this:
bloodied/half-HP phase changes, mythic traits, regeneration thresholds. Wherever a threshold exists,
damage granularity is a strategic variable, not a rounding detail.

### ⚠ The Hercules warning — and a confound this project must design around

Chris's headline HeroClix result: **Hercules topped BV/cost — but only because he was a cheap,
strong melee fighter, and range plus non-combat abilities were too hard to model.** The metric
crowned the figure that best fit the model's blind spot.

That is the *same* melee bias predicted for D&D, now observed independently in a completed project.
It stops being a guess and becomes a strong prior. It also exposes a confound in Deliverable 1:

> **If the exact model and BattleValue share a blind spot, their agreement is weak evidence.**
> Both under-credit range and mobility. So "BV predicts the Markov win rates well" may only mean
> *"two melee-biased instruments agree with each other"* — not that BV is sound.

**Design consequence:** the mobility-on run (Deliverable 2) is not a bonus deliverable, it is the
**control** that makes Deliverable 1 meaningful. BV must be scored against the *kiting-enabled*
matrix, not just the stand-and-trade one. Without that control, this project would reproduce the
Hercules artifact in a new game and mistake it for a validation.

## Model sketch

- **State:** `(HP_A, HP_B, whose turn, resource/condition flags)`.
- **Absorbing states:** either side at 0 HP.
- **Solve:** absorption probabilities → **exact** P(A wins), zero sampling noise.
- **Size:** HP ≤ ~300 each ⇒ ~90k × 2 core states; a handful of binary flags multiplies it but the matrix is extremely sparse. Comfortably tractable.
- **Recharge abilities** (breath weapon on 5–6) are *natively* memoryless — the ideal case, not an obstacle.
- **What genuinely breaks it:** *adaptive* positional decision-making — a monster choosing each round whether to close or withdraw based on the state. That's a decision, and decisions are what force a stochastic game.

> **Correction (worth stating plainly, because the first draft of this page got it wrong):**
> **scripted kiting does *not* break the Markov model.** A dragon that breathes, withdraws, and
> returns on recharge is following a *fixed policy* — so it's still a plain chain, just a different
> one. Model it as "the melee attacker connects only on the rounds the dragon chooses to close."
> The recharge bit is already in the state. This matters a lot for feasibility: it means
> **Deliverable 2 (mobility off vs on) is cheap**, not a separate engine. Only *adaptive* choice
> is expensive.

## The complication classes (Chris: "similar to what we saw in MoM")

The [MoM analysis](./master-of-magic/README.md) already enumerates this exact family of problems, which is why that page is the precedent rather than a loose analogy:

| MoM complication | D&D counterpart |
|---|---|
| Resistance; units effectively immune to half the spell list | Damage-type resistance / immunity, magic weapon immunity, legendary resistance |
| Special abilities (First Strike, Armor Piercing, Life Steal, Poison…) | Multiattack, riders, on-hit saves, grapple/restrain, regeneration |
| Ranged attacks get free damage before melee (first-strike multiplier) | Opening round + flight/reach — the axis the videos flatten |
| Multi-figure units (Lanchester applies differently) | Not applicable in 1v1, but returns if this ever goes to group fights |
| To-hit modifiers scaling effective attack | Attack bonus vs AC, advantage/disadvantage |

**Chris's expectation, calibrated to MoM:** *"at best I am expecting similar things to what we had with MoM — a good approximation, and the ability to dive into why performance was either too good or too poor."* That diagnostic capability is the actual product. An exact model that says "the roper wins 71% and here is the state-space reason" beats a dice tournament that says "the roper won."

## The hard part is not the math

Chris: *"the hard part might be sourcing and rules."* Agreed, and it splits in two:

**1. Sourcing.** Encoding hundreds of stat blocks correctly is the whole cost. **Convert, don't hand-enter** — the 5e SRD is openly licensed and machine-readable dumps exist. Verify licensing and completeness before committing; a hand-typed monster table is an unverified artifact, a parsed one is cross-checkable against its source.

**2. The rules/policy spec — this is the experimental protocol, not an implementation detail.** Because "on the fly" decisions have to be frozen into a written policy, *the policy IS the model*. It has to be explicit and defensible up front (Chris: *"enough rules to make sure it is done somewhat fairly"*), because every ranking the project produces is conditional on it. Minimum decisions to pin down: spell/resource ordering, when to use a recharge ability, target-vs-condition priorities, whether to break grapples, opening-round assumptions.

## Deliverables — what this does that the videos can't

1. **Validate BattleValue against ground truth.** [BV = √(Attack × HP)](./battle-value.md) is a lifelong vault project asserting a unit compresses to one number. An exact pairwise win matrix is the oracle that claim has *never* been tested against. Where BV predicts well and where it fails is a real result either way — and the MoM page's complications list predicts *where* it should fail.

   **⚠ This deliverable already has a sibling: [BattleTech Simulator](../../projects/battletech-simulator/README.md)** (status: planning) — *"Monte Carlo combat simulator to derive empirical BattleValue."* Same motivation, different method, and the difference is the whole point:

   | | BattleTech | D&D 1v1 |
   |---|---|---|
   | State | 8+ locations × armor/structure, damage transfer, crits, heat | two HP pools + a few flags |
   | Tractability | state space forces **Monte Carlo** | small enough for an **exact** answer |

   So these are not competing projects — **D&D is the tractable proving ground for the BV-validation methodology that BattleTech can only approximate.** Doing D&D first means the BattleTech sim inherits a method already checked against exact truth. If only one gets built, build this one first.
2. **Quantify the melee bias instead of asserting it — and serve as Deliverable 1's control.** Run it twice, kiting/mobility off then on, and measure how far the rankings move. This converts Chris's observation into a number, is the honest accounting of what the fixed-policy simplification costs, and — per the Hercules warning above — is what prevents Deliverable 1 from being a self-confirming loop between two melee-biased instruments. Cheap to build, since scripted kiting is just another fixed policy.
3. **Hunt for non-transitivity.** A full round-robin matrix exposes rock-paper-scissors cycles (A beats B beats C beats A). If they exist, "same CR" is **not a total order**, and the tournament winner is partly an artifact of bracket seeding. This is the [counter-graph](./master-of-magic/com-counter-graph.md) instrument pointed at a new game — a conversion of existing vault machinery, not a new invention.

## The source tournament's structure (Chris)

The channel gained traction by **starting at CR 1 and working up the chain**, and it carries the
**previous tier's champion up into the next tier** as a guest entrant. Two consequences:

- **Start at CR 1** — the monsters are simplest, so it's the natural first build *and* the tier
  where the source has the most episodes to check against.
- The champion-promotion gimmick is free content for the model: it can state exactly how badly
  outmatched a promoted champion is, which the dice version can only show anecdotally.

### Rules complexity explodes going up (Chris's examples)

**Mirror image / duplicate-creating monsters** — Chris flagged a fight where you roll to hit, then
roll again to see whether you struck a duplicate (no HP loss; the image is consumed). This is the
ideal illustration of the project's thesis: **miserable to hand-roll, trivial as a matrix.** It's
one extra state dimension of size ≤4 (`images_remaining`), and a hit becomes a probabilistic branch
— image destroyed *or* real damage. Still perfectly memoryless.

**Dragons underperform** — a real dragon breathes, flies off, and returns on recharge; the videos'
model forces it to stand and trade, best-attack-available each round. Chris's read is that this is
why dragons do worse than they should. Per the correction above, this is *directly testable* and
cheap: run the same matchup with kiting scripted on, and the delta is the measured cost of the
abstraction. **Prediction to check:** the model should underrate monsters systematically in
proportion to how much of their damage sits behind a recharge timer.

### CR 1 will be a high-variance mess — which is the argument *for* exact solution

Chris: *"I bet with the low HP of CR1, this will be a high variance mess."* Agreed — and it inverts
into the strongest case for the method. Low HP ⇒ short fights ⇒ swingy outcomes ⇒ **Monte Carlo (and
literal dice) need enormous samples to separate a 52% matchup from a 48% one.** The exact chain
returns those numbers with no sampling noise at all. The method is most valuable exactly where the
dice are least informative.

**The sharp implication:** if CR-1 matchups really are near-coinflips, then the *source tournament's
CR-1 bracket results are mostly luck* — a single-elimination bracket over near-even matchups measures
seeding and variance more than monster quality. That's a checkable claim about the videos, and it
rhymes with the seeding-artifact point from [Yahtzee](./yahtzee-solved.md) and the non-transitivity
hunt in Deliverable 3.

## Open questions

- **Scope: settled — start at CR 1**, mirroring the source's own progression and monster set, so the creator's dice results are a free external oracle. Open: how far up the chain before the rules cost outruns the payoff.
- **Verification:** Monte Carlo is not the competitor here, it's the **cross-check** — sample a few matchups and confirm they converge to the exact answer. Two methods agreeing is the grounding standard.
- Does the SRD dump cover the tournament's monsters, or do some come from non-SRD books?
- Ties/timeouts: what happens to mutual-regeneration stalemates with no absorbing state reachable?
- Graduates to a `projects/` pointer once a repo exists; research page for now.

## Tags

[games](../../tags/games.md), [game-theory](../../tags/game-theory.md), [strategy](../../tags/strategy.md)
