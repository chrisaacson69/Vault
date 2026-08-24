---
status: active
created: 2026-08-24
published: true
layout: layouts/page.njk
title: "Watching the Solver Learn — the observation layer is the iteration engine"
---
# Watching the Solver Learn — the observation layer is the iteration engine
> When you iterate a solver, the thing that decides how fast you converge is not the algorithm — it is **whether you can see what the solver is currently doing.** Reward-function bugs are *behavioural*: they crash nothing, fail no test, and produce a confidently-wrong agent. The only detector is a live view plus training telemetry. Worked from a project that gets this right, and stops one step short on evaluation.

**Links:** [The Anchor Method](./anchor-method.md) (the spine — this is the *observation* end of the same anti-drift problem), [Method](./README.md), [pygone](../projects/pygone/README.md) and [MOO1 Opening Optimizer](../projects/moo1-opening-optimizer/README.md) (the vault's existing solver-iteration projects — batch harnesses, no live view), [oop-neurons](../projects/oop-neurons/README.md)

**Worked example:** [Pezzza's Work — "AI Gladiator learns to fight Zombies"](https://www.youtube.com/watch?v=tdIjzqQgHCc) (19:10, 2026-08-05). Transcript: [`raw/videos/2026-08-05 ai-gladiator-zombies-pezzza.txt`](../raw/videos/2026-08-05%20ai-gladiator-zombies-pezzza.txt). A custom PPO implementation in **C++ + SFML**, two layers × 256 neurons, training an agent ("Gary") to fight zombies in a 2D arena.

---

## Why this specimen

Not for the reinforcement learning — for the **stack around it**. Pezzza builds five layers, and the vault's own solver projects currently build only three:

| Layer | Gary | Vault projects today |
|---|---|---|
| Environment / simulator | C++ arena, SFML rendering | ✅ (slay-c, battletech-sim, moo1) |
| Solver | PPO, 2 × 256 | ✅ (pygone search, moo1 sweeps) |
| Batch evaluation | scores per episode | ✅ (pygone's match/tactics harness) |
| **Live view of the agent acting** | ✅ watch Gary fight, mid-training | ❌ **missing** |
| **Training telemetry dashboard** | ✅ four tracked signals | ❌ **missing** |

The bottom two are the subject of this page. They are also, in this specimen, where every actual discovery came from.

## The core move

> **Build the observation layer before the tuning loop, not after.** You are not debugging code, you are debugging a *policy* — and a wrong policy runs perfectly.

Pezzza's dashboard tracks four things, and the set is worth copying wholesale:

- **Raw score** (bar chart) — a snapshot of the last N episodes.
- **Average score** — the same signal smoothed, *"much less noisy than the raw score."* Two views of one metric at different time constants, because the noisy one shows events and the smooth one shows trend.
- **Policy entropy** — *"measures the model's confidence in its understanding of the problem. The lower the value, the more confident the model is."* A convergence/exploration read that score alone cannot give.
- **Episode duration** — with an explicit cap (120 s), so the metric can't run away.

Plus an **event monitor**: *"a glimpse of what is happening behind the scenes without needing to interrupt the training."* That clause is the whole design principle — **observation must not cost you the run.**

## The warning signs, and the moves

### 1. Reward bugs are behavioural. Watching is the only detector.

Two distinct failures appear in this project, and **neither would fail a test**:

- **A design error.** Survival was weighted too heavily, so Gary learned to run away and never engage. *"Highly effective from a survival standpoint, the same cannot be said for the spectacle."* Score rising, duration rising, everything green — and the agent doing nothing. The fix took three passes of lowering the survival term, through an intermediate stage he calls *"a committed pacifist."*
- **An outright bug.** *"For some reason, attacking carried a negative reward. Gary was therefore penalized every time he tried to use it. My bad."* The agent was correctly optimising an objective that punished the behaviour the whole project existed to produce.

**Move:** when a solver's metrics improve but the artifact is useless, suspect the objective before the algorithm — and go and *look* at what it is doing. Both bugs above are invisible in the numbers and obvious on screen within seconds.

### 2. Run the curriculum, but keep a control.

Difficulty was ramped 1 → 2 → 4 → 8 → 16 zombies, warm-starting each stage from the previous policy. Result: 1→2 was rough, 2→4 smoother, and *"the transition from four to eight is even smoother, showing that Gary's strategy scales surprisingly well."*

The valuable part is that he then **ran the control**: training fresh at 16, from scratch. *"Gary the pacifist is back. This shows how gradually increasing the difficulty can help."*

**Move:** a curriculum without a from-scratch control is an assertion, not a result. The control costs one extra run and converts "the ramp seemed to help" into evidence.

### 3. Make perception fixed-size, and the cost stops tracking the world.

Gary senses via **92 raycasts across a full 360°**, chosen deliberately: *"the volume of sensory data Gary processes remains entirely independent of the number of enemies."*

That single decision is why 4 → 8 → 16 scaled at all. An observation space that grows with entity count forces a network change (or a re-train) every time the environment gets busier; a fixed-size sensory field means more enemies is a *harder* problem, not a *different* one.

**Move:** when designing the interface between simulator and solver, ask what the observation size is a function of. If it's a function of the world's population, you have coupled two things that should be independent.

### 4. The action rate is a planning-horizon decision, not a performance one.

The agent runs at **12 updates/second, not 60** — and the reason is not CPU: *"that would make planning more difficult since the agent would have to anticipate five times as many steps over the same period."*

**Move:** treat the decision frequency as part of the problem statement. Sampling faster than the task's natural granularity lengthens the credit-assignment chain for no gain.

## Where it stops short — the benchmark that shrinks

The video opens by promising to raise difficulty until it *breaks*. It stops at 16 with Gary still winning, so **the breaking point is never found** — the headline question goes unanswered.

Worse, and more instructive: **the 16-zombie test is not a 16-zombie test.** Zombies are not replaced as they die, and Gary's learned strategy is explicitly to *"look for an isolated opponent, take it out, and move on to the next."* So the encounter's difficulty **decreases monotonically from the moment it starts** — 16, then 15, then 14. The agent is permitted to reduce the problem size faster than it has to survive it.

> **A benchmark the agent can shrink is not measuring the difficulty on the label.** "Handles 16" here means "handles 16 briefly, then 12, then 8, then a mop-up."

The fix is one line of environment code — **respawn on death** — which converts a decreasing-difficulty encounter into sustained pressure, and would find the breaking point the intro promised. (This was raised in the video's comments, not by the author.) The shield-energy result hints at what sustained pressure would expose: at 16, blocking finally drains the shield, and the kick returns *"to keep the threats at bay while the shield recharges."* The binding constraint had only just started to move when the experiment stopped.

**Move:** before trusting a difficulty result, ask whether the agent can *change the difficulty from inside the episode*. If it can, the label describes the first second only.

## What this means for the vault's projects

The vault's solver work — pygone's search, MOO1's parameter sweeps, the simulators — is strong on **batch** evaluation: run N trials, compare aggregates. It has no equivalent of the two bottom rows in the table above. That is the gap this page exists to name:

1. **A live view of the artifact acting**, watchable mid-run without stopping it.
2. **Training/iteration telemetry** — a smoothed and unsmoothed objective, a confidence or convergence signal, a bounded cost metric, and an event log.

Batch aggregates answer *did it get better*. They cannot answer *what is it actually doing*, which is the question both of this project's real bugs required. That asymmetry is the argument for building the layer.

## Open Questions

- **What is the vault's equivalent of "policy entropy"** for a non-learning solver — a search engine or a parameter sweep? Something that reports *confidence/convergence* rather than score. Move-choice stability across depths? Variance across restarts?
- **Does live observation survive an agent-driven workflow?** Watching works because a human is looking. If the iteration loop is run by an agent, what replaces the eye — periodic renders it inspects, or derived behavioural statistics (engagement rate, action histogram) that make "doing nothing" a *measured* quantity rather than a seen one? **Partly answered below: for one of the two bug classes, no statistic can replace the eye, because there is nothing anomalous to measure.**

## Two classes of objective bug — and only one is findable from inside

The two failures above look alike and are not. The distinction decides what can be automated (Chris, 2026-08-24):

**Class A — internally detectable.** The negative reward on *attack* is an inconsistency *within the system*: an action carrying systematically negative return, or one the policy learns never to select. That leaves a statistical signature — per-action return, action histogram, an ability present in the action space and absent from the policy. **An agent could plausibly catch this**, and it's worth instrumenting for deliberately.

**Class B — detectable only against intent.** Gary avoiding combat to survive is **not a malfunction. It is the correct optimum** for the objective as written. Nothing inside the loop is anomalous: score climbing, episode duration climbing, entropy falling — the run looks like a *success*. The only referent that reveals the failure is what the system is *for* — a gladiator who fights — and that lives entirely outside the specification. As Chris put it: *the fight was easy — just don't engage.*

> **The signature of a Class B bug is that every metric agrees the run went well.**

That has three consequences:

1. **This is the same faculty as "AI creativity."** The mechanism that finds a clever solution nobody anticipated is the mechanism that finds a useless one — the difference lies in intent, not in the search. You cannot suppress one without suppressing the other, which is why "the AI found an unexpected strategy" and "the AI gamed the objective" are the *same event* described from different sides.
2. **It is not an AI problem.** It is the letter-versus-spirit problem, and law has fought it for centuries — see [Mens Rea in Libertarian Law](../research/philosophy/morality/legal-theory/mens-rea.md), where the vault's own position is that a system should be **intent-blind** and the remedy is therefore to *specify better* (penalties that bite regardless of provable intent) rather than to adjudicate motive. That is structurally the same move as [the lemonade-stand result](../research/economics/lemonade-stand-agents.md): **when you cannot appeal to intent, the constraint has to live in the objective.**
3. **The observation layer is what supplies the missing referent.** Watching is not a convenience — for Class B it is the *only* channel through which intent enters the loop at all. So the automation question is not "how do we replace the eye with a statistic" but **"how does intent get re-injected each iteration, and by whom?"**

## Open Questions
- **Is "the benchmark must not shrink" a general evaluation rule?** It sounds like it should generalise past this case — anywhere the agent's actions alter the difficulty of its own test.

## Tags

[methodology](../tags/methodology.md) · [ai](../tags/ai.md) · [agents](../tags/agents.md)
