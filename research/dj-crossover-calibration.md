---
status: active
created: 2026-07-22
published: true
layout: layouts/page.njk
title: "Crossover Calibration — Measuring the EQ Cutoff Instead of Guessing It"
---
# Crossover Calibration — Measuring the EQ Cutoff Instead of Guessing It
> Design for a tool that finds the EQ crossover frequency for a transition by measurement and a
> psychophysics harness, replacing the slowest and most frustrating loop in manual mix authoring.

**Links:** [DJ EQ Blending Technique](./dj-eq-blending.md), [Programmatic DJ Mixing Tools](./programmatic-dj-mixing-tools.md), [CyborgDJ](../projects/cyborgdj/README.md), [Camelot From YouTube](../projects/camelot-from-youtube/README.md), [Planner-LM Composites](./planner-lm-composites.md), [The Three-Layer Method](./karpathy-three-layer-method.md)

*Status: design, not yet implemented. No numbers here are measured — every quantity is a parameter to be
determined by the harness this page describes.*

## The problem

The [February 2026 implementation results](./dj-eq-blending.md#step-1-implementation-results-2026-02-22)
identified crossover frequency as "the single biggest lever," found 300 Hz leaked bass harmonics into the
mid band, fixed one track pair at 450 Hz, and concluded it "needs per-transition tuning or spectral
analysis." Finding that number by ear was the slowest part of the loop — each candidate cost a render and
a listen, and the comparison was between two things heard minutes apart.

The goal is not a better guess. It is to stop spending judgment on the number at all, so the conversation
moves up an altitude — **testing technique rather than arguing about a few Hz.**

## Two hypotheses, and they point opposite ways

**H1 — the crossover is derivable, not searchable.** With source-separated stems, the question "where do I
split so that killing the low band removes the bass without gutting the body" is answerable from two curves:
the bass stem's spectral envelope and the melodic stem's. The crossover wants to sit *above the bass stem's
harmonic reach* and *below the melodic content's fundamental region* — a crossing point read off a plot, not
a value hunted by trial. The February finding is this in hindsight: 300 Hz sat below the bass's harmonic
reach, 450 Hz cleared it.

If H1 holds, the search collapses into a measurement, and the per-bar third-octave matrix from
`spectral_analysis.py` already supplies the raw material.

**H2 — the perceptual tolerance is coarse.** A working DJ sets this by twisting a knob, in a loud room,
under headphone bleed, mid-performance. That practice is *independent evidence about the tolerance*: knobs
overshoot constantly and nobody notices except a studio engineer. If the just-noticeable difference is
±100 Hz rather than ±10 Hz, then precision beyond that band is wasted effort, and much of the February
frustration was chasing resolution below the noise floor of human judgment.

H1 and H2 are not in tension — they are two independent routes to the same outcome. H1 says *compute it*;
H2 says *you didn't need it that precisely anyway*. Either one shortens the loop; both together close it.
**H2 is also the cheaper to test, and it bounds how much H1 has to deliver.**

## The harness

One tool serves both hypotheses and produces the training data for a
[learned evaluator](./dj-eq-blending.md) as a by-product. Every trial is a labelled pair — the calibration
harness *is* the A/B log.

### Stimulus generation

- Render the transition **only in a window around the bass swap** (≈8 bars). Full-transition renders are
  wasteful; the crossover question does not live outside that window. This makes hundreds of candidates cheap.
- Loop seamlessly. Auditory memory for timbre is a few seconds — **long samples actively destroy the
  comparison** the test depends on.
- Present as **2AFC**: "which is cleaner, A or B?" Absolute ratings ("is this good?") drift across a session;
  forced choice does not, and it yields the pairwise labels a preference model needs.

### Procedure — and the failure modes it must avoid

The naive design (fixed 100 Hz steps, sweep upward until it sounds right) is the psychophysics **method of
limits**, which carries known biases:

| Failure mode | Effect | Mitigation |
|---|---|---|
| **Hysteresis** — ascending and descending sweeps disagree | habituation overshoots going up, anticipation undershoots coming down; a one-direction sweep bakes in a systematic offset | interleave both directions, average the thresholds |
| **Fixed grid wastes trials** | equal effort spent far from the threshold as near it | **adaptive staircase**: start at 100 Hz, halve the step on each judgment reversal; converges in ~10–15 trials |
| **Expectation contamination** | knowing which sample is 450 Hz means partly grading your own hypothesis | blind presentation, randomized order, harness records the mapping |

### The measurement that governs everything else

**Insert repeat trials** — the same pair, presented twice, separated in the sequence. The rate at which the
same choice is made is the **noise floor of the entire project**.

If self-consistency collapses at ±50 Hz, then ±50 Hz is not a meaningful target and no amount of tooling
will make it one. This single number sets the resolution worth optimizing to, converts "stop arguing about
a few Hz" from an opinion into a measured bound, and is obtainable in one afternoon. **It is the highest
value-per-effort item in this design, and it should be run first** — it may retire H1 before H1 is built.

## What to do with the judgments — the cheap result first

Once a few hundred pairwise judgments exist, **do not train a model yet.** First check which
already-computable deterministic metric best predicts the choices:

- residual bass-stem energy above the candidate crossover
- spectral overlap between the two tracks within the crossover band
- short-term LUFS deviation through the swap
- correlation of the two bass stems (phase cancellation)

If one of these predicts picks at high accuracy, **the critic is done** — explainable, deterministic, and no
model required. Only if none predicts well is a learned evaluator justified, and by then both the training
data and the *evidence that the simple version was insufficient* are in hand.

This is the [three-layer discipline](./karpathy-three-layer-method.md) applied to the metric itself: try the
deterministic, lower-altitude check before the opinionated one, and let it gate the write.

## Scope limit — this is the EQ-domain answer

Crossover frequency is a **mixer constraint**, not a law of mixing. It exists because hardware gives three
knobs. In the stem-rendering path there is no crossover at all — the incoming bass stem is muted outright,
so there is nothing to tune and no harmonic leak to fight.

This tool therefore matters for the EQ-domain render path, which remains live because
[stem re-summation artifacts are unresolved](./programmatic-dj-mixing-tools.md#still-open-do-not-read-absence-as-absence)
and melodic content separates poorly (the "other" stem caps at 8.7–9.0 dB SDR). Both paths stay open until
measured.

## Honest caveats

- **Plot the metric curve before assuming a knee exists.** A sweep may be flat for a given pair, in which
  case the crossover does not matter there — a real result, not a failed experiment.
- Thresholds are likely **track-pair specific**. The harness measures a distribution, not a constant; the
  useful output may be a rule ("crossover ≈ bass-stem -30 dB point") rather than a number.
- Everything above is **untested design**. It is written down to be falsified, not to be believed.

## Tags
[music](../tags/music.md), [audio-processing](../tags/audio-processing.md), [cyborg](../tags/cyborg.md)
