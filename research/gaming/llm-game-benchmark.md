---
status: outline
created: 2026-04-23
published: true
layout: layouts/page.njk
title: "LLM Game Benchmark — Outline"
---
# LLM Game Benchmark — Outline
> Framework for evaluating a new LLM against the vault's seven-game cross-study. Turns ad-hoc observation of Quinn-Henry-style videos into a reproducible characterization so the obvious question — "how does model X compare?" — has a structured answer.

**Links:** [LLM Agents Across Strategic Games](./llm-agents-across-games.md), [Planner-LM Composites](../planner-lm-composites.md), [Diplomacy: 7 AI Models](./diplomacy-ai-analysis.md), [Monopoly Project](../../projects/monopoly/README.md)

---

## Objective

Given a new LLM (new release, new vendor, new architecture), produce a structured characterization of its strategic signature against the seven-game framework from the cross-study. Answer the question "how does X compare?" with something more reproducible than "it played this one game well."

This is a research outline, not an implementation spec. The goal is to establish what needs to be measured, what infrastructure that measurement requires, and what shape the output should take.

## What the seven games are testing

Each game in the existing study measures a different capability profile. A benchmark should run a new model through all seven (or a defensible subset) because no single game is sufficient — the [cross-game findings](./llm-agents-across-games.md) demonstrate that the same model plays very differently depending on whether verification is full, partial, or absent.

| Game | Regime | Verification | Primary capability tested |
|---|---|---|---|
| Coup | Small state, deception | Full (challenge reveals) | Logical bluff detection, card counting |
| Monopoly | Public state, trade-heavy | Full (math computable) | Numerical discipline, EPT reasoning, trade valuation |
| Diplomacy | Public state, pure negotiation | Full (move resolution) | Theory of mind, alliance/betrayal timing |
| Catan | Mostly public + hidden VP pocket | Partial | Planning over mechanical state, private-state accumulation |
| Mafia | Social deduction | None built-in | Rhetorical control, analytic resistance to contagion |
| Among Us | Social deduction + spatial | None built-in | Same as Mafia + spatial grounding |
| Clones control | Any game, 7 copies of same model | Any | Methodological baseline — architectural signature vs. role variance |

## What to measure

Outcome alone (who won) is low-signal at small N. The measurements below track *behavior* across games so that a single benchmark run yields a multi-axis profile.

### Outcome metrics (objective)
- Win rate per game
- Position / VP / centers held at game end
- Trades accepted, trades refused, trades revised

### Structural failure rates (from [Planner-LM Composites](../planner-lm-composites.md))
- **Action bias** — frequency of action taken when holding was the dominant move, measured against a reference simulator's evaluation. Requires the game to have a simulator that can score "best move."
- **Mechanical model absence** — frequency of illegal or impossible target selection (e.g., building toward a settlement with no road path), attempts to act on resources the model doesn't have, misreading own position. Directly measurable from transcript + game state log.
- **Rhetorical contagion** — frequency of acting on framings introduced by other agents without verification against game state ("sheep is rare" accepted when production math contradicts it). Requires semantic labeling of trade rationales.

### Commitment spectrum (from [Diplomacy analysis](./diplomacy-ai-analysis.md))
- Makes concrete commitments vs. vague language
- Honors commitments when strategically optimal to do so
- Breaks commitments reflexively (Grok-style) vs. strategically (Gemini-style)

### Verification discipline (from [state-awareness thesis](./llm-agents-across-games.md#phase-4--state-aware-ai-vs-session-based-ai))
- Audits opponent claims against game state before acting on them
- Tracks opponent history across turns
- Flags inconsistencies (e.g., "you sold Atlantic for $350 two turns ago and are now pricing it at $800")

### Terminal behavior
- Pre-announcement of win conditions (the 9-VP broadcast pattern)
- Reputation-capital management near game end (optimal betrayal timing)
- Endgame tunnel vision vs. continued positional awareness

### Architectural signature confirmation
- Does the model's behavior match predictions from prior games, or does it show role-dependent adaptation?
- If prior signature is absent, is this a new architecture or a fine-tuning shift?

## Required infrastructure

### Game simulators
- **Monopoly** — vault project in progress; has Markov engine, EPT valuation, trade engine spec
- **Catan** — not currently built; estimated a few hundred lines for a playable simulator with standard rules, dev cards, robber, trading phase
- **Coup** — simple card game; small build
- **Diplomacy** — open-source implementations exist (e.g., DipCC, WebDipBot); adapt rather than build
- **Mafia / Among Us** — chat-centric; simpler mechanically, but need moderator bot + role-assignment logic
- **Clones control** — any of the above, seven instances of the target model

### Standardization requirements
- Identical system prompts across models (rule explanation, scoring)
- Identical context format (game state updates, chat messages)
- Identical no-op affordance (must allow passing as first-class choice)
- Identical turn time / token budget

### Opponent panel
- **Reference panel** — the five-model panel from the existing study (Claude, GPT-4o, Grok, DeepSeek, Gemini-family) to compare against prior data
- **Clones baseline** — N copies of target model vs. itself; isolates architectural signature from opponent-mix effects
- **Mixed-with-target** — target model placed into the reference panel, observed against the existing comparison

## Scoring

### Automated (objective)
- Outcome metrics, legal-move-rate, commitment-honored-rate, claim-audit-rate — all measurable from transcript + game log without human judgment

### LLM-as-judge (structured rubric)
- A strong reference model (not the target) scores behavioral markers from transcripts against a rubric
- Calibration: judge scores a held-out subset of prior games and results are compared to existing analysis; deviation above threshold invalidates the judge's scoring for this run
- Multiple judges with majority voting reduces single-judge bias

### Human validation subset
- Chris (or a small panel) manually scores ~10% of turns across games
- Used to validate judge calibration, not to do the full scoring at scale

## Output format

Per new model, produce:

1. **Signature table** — row per game, columns for each measured axis (outcome, three failures, commitment behavior, verification discipline, terminal behavior). One table, readable at a glance.
2. **Comparison plot** — signature placed alongside the existing five-model panel on the same axes. Radar chart or parallel coordinates.
3. **Architectural claim** — 2-3 paragraphs: where does this model sit on the state-aware ↔ session-based axis? On the logical ↔ rhetorical axis? Does it show known signatures or something novel?
4. **Cited transcript moments** — 3-5 concrete turns illustrating each axis. The existing study's power comes from specific quotes; the benchmark should preserve that.

## Known limitations

- **Judge dependency.** LLM-as-judge inherits its own signature biases. Rotating judges or using human calibration mitigates but doesn't eliminate.
- **Infrastructure cost.** Running seven games per target model is substantial — especially Diplomacy, which is long and expensive. Budget-constrained runs might use a subset (Monopoly + Catan + Coup as the verification-axis triple, Mafia + Among Us as the contagion-axis pair).
- **Roster dependency.** The clones experiment showed that performance varies with opponent mix. Target-vs-reference-panel and target-vs-clones produce different results and measure different things. Both should be run when possible.
- **Small-N variance.** One run of each game yields a weak signal. Ten runs would be better. Cost may force fewer.
- **No-op affordance.** If the game harness forces the model to produce an action every turn (common in chat-based implementations), action bias cannot be separated from harness-forced action. The harness must permit pass explicitly.
- **Ground-truth scoring for failures.** "Action bias" requires knowing the correct move, which requires a simulator that has a well-calibrated value function. For the games without a strong reference solver (Catan, Mafia), failure rates are approximate.

## Open questions

- Minimum game count per model to produce a stable signature? Likely 3+ per game for verification-axis games, more for the deduction games where variance is higher.
- Does the architectural-signature hypothesis make the full benchmark unnecessary once a model's signature is established? If signatures predict behavior across games, maybe one calibration game is enough. But new architectures (Claude-4, GPT-5, etc.) may break prior signatures — the benchmark is most valuable precisely when it's least needed, which is after new-architecture releases.
- Should the benchmark include composite systems (target LLM + simple planner) as a control, to separate LLM capability from architectural capability? Likely yes — this tests the central [Planner-LM Composites](../planner-lm-composites.md) claim directly.
- Can the benchmark be published / open-sourced? If so, it becomes a public standard and every new LLM release gets scored against the existing panel automatically. Hosting the infrastructure is the hard part.

## Tags

[ai](../../tags/ai.md), [game-ai](../../tags/game-ai.md), [games](../../tags/games.md), [llm-limitations](../../tags/llm-limitations.md)
