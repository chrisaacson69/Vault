---
published: true
layout: layouts/page.njk
title: "Tag: software-engineering"
permalink: /tags/software-engineering/
---
# software-engineering
> Files about software design, architecture, code quality, and engineering practice.

- [Practicality vs. Precision — Principled LLM Code](../research/principled-llm-code.md) — legacy strata, worse-is-better as economics, the LLM refactor-cost inversion, persistence as the fix
- [The Context Cache Hierarchy](../notes/context-cache-hierarchy.md) — Claude Code memory layers as a CPU cache; eviction policy, drift, and a memory-hygiene check
- [Transpilation as a Grounding Strategy](../research/transpilation-as-grounding.md) — transpile-to-grounded-language as the technique for legacy/obscure code; COBOL modernization
- [Repairing LLM Code — The Two Oracles](../research/repairing-llm-code.md) — structured programming (Böhm–Jacopini 1966 / Dijkstra 1968) is the LLM-readability argument; goto-count is the Goodhart trap
- [The Substrate Is the Governing Mechanism](../research/substrate-as-governance.md) — Agents coordinating through a shared store is read as the thing that makes them ungovernable.
- [Comments and the Distance to an Oracle](../research/comment-oracle-distance.md) — an eviction rule for comments with a test behind it: distance to the oracle, measured by a fixed-context reader
- [The Contract Model vs. the Substrate Model](../research/contract-vs-substrate.md) — a per-delivery **contract** (delivery / constraints+guardrails / proof artifact / outside-verification / owner) is the vault's architecture with the accumulation stripped out — contracts don't compound, substrate does; plus the artifact-vs-reader split in verification independence, and *tests written only to pass* as oracle collapse
