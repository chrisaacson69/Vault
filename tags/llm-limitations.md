---
published: true
layout: layouts/page.njk
title: "Tag: llm-limitations"
permalink: /tags/llm-limitations/
---
# llm-limitations
> Files about structural limitations of large language models.

- [The LLM Grounding Problem](../research/llm-grounding-problem.md)
- [Cognitive vs. Motor Skills](../research/cognitive-vs-motor.md)
- [Diplomacy: 7 AI Models](../research/gaming/diplomacy-ai-analysis.md)
- [H-Neurons: The Neural Basis of Hallucination](../research/h-neurons.md)
- [The Birthmark and the Search for Truth](../research/philosophy/epistemology/the-birthmark.md)
- [LLM Agents Across Strategic Games](../research/gaming/llm-agents-across-games.md) — Catan (Phase 5) isolates three LLM-general failures
- [Planner-LM Composites](../research/planner-lm-composites.md) — bare LLMs don't act, planner-LM composites do
- [Energy-Based Models](../research/energy-based-models.md) — the Sudoku tell: frontier LLMs only "solve" Sudoku by writing a Python script; tool-use ≠ reasoning; EBM + formal verifier as the architectural answer
- [LLM Game Benchmark — Outline](../research/gaming/llm-game-benchmark.md)
- [Game Annotation Series](../projects/game-annotation/README.md) — assembly as a stress test for LLM mechanical-modeling without rhetorical contagion; per-chapter LLM-interpretation logs
- [Transpilation as a Grounding Strategy](../research/transpilation-as-grounding.md) — LLMs are weakly grounded in obscure formal languages (6502, bespoke VMs, COBOL); transpile to a grounded one rather than reason in them
- [Repairing LLM Code — The Two Oracles](../research/repairing-llm-code.md) — LLMs faithfully read *wrong* structure and report it with high confidence; confidence and reader-consensus both fail as signals
- [Comments and the Distance to an Oracle](../research/comment-oracle-distance.md) — a stale comment is the one repo artifact that can be flatly wrong with nothing to notice — last run's fluent output re-fed as evidence
- [The Contract Model vs. the Substrate Model](../research/contract-vs-substrate.md) — a per-delivery **contract** (delivery / constraints+guardrails / proof artifact / outside-verification / owner) is the vault's architecture with the accumulation stripped out — contracts don't compound, substrate does; plus the artifact-vs-reader split in verification independence, and *tests written only to pass* as oracle collapse
- [Oracles Are Objective Functions](../research/oracles-as-objective-functions.md) — greedy left-to-right decoding is hill-climbing with no restart, so self-sycophancy is a local minimum — and more samples or more agents is the *same landscape*, which is why headcount cannot substitute for altitude
