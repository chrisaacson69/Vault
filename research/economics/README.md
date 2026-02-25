# Economics
> A major area of interest — understanding how value, trade, and systems of exchange work.

**Status:** active
**Created:** 2026-02-12
**Links:** [Vault Index](../../INDEX.md), [Claude Opus 4.6 Research](../claude-opus-4-6.md), [Computation and Information Theory](../computation-and-information.md)

## Why This Matters
Economics is foundational to understanding how AI agents interact with the real world. If an AI is going to run a business, manage resources, or make decisions that involve trade-offs, it needs to understand the principles that govern exchange — not just the accounting, but the theory underneath.

The [Claudius vending machine experiment](../claude-opus-4-6.md) is a concrete example: the AI failed not because it couldn't do math, but because it had no model of value, utility, or why profit exists.

## Sub-Topics

### Fundamentals
- [Value and Profit](./value-and-profit.md) — utility theory, mutual benefit, and why profit emerges from trade
- [Risk and Entrepreneurship](./risk-and-entrepreneurship.md) — uncertainty, time preference, and why profit is the reward for correct bets

### Risk Management
- [Insurance](./insurance.md) — the one thing insurance does right (catastrophic tail hedging) and everything it does wrong (free riders, risk class paradox, mission creep)

### Praxis
- [Agent Teams vs. the Theory](./praxis-agent-teams.md) — testing the framework against real Opus 4.6 deployments

### The Price System as Distributed Computation

A market economy is a massively parallel, distributed computing system. The price mechanism is its communication protocol — encoding supply, demand, scarcity, opportunity costs, and subjective valuations into a single number that propagates at the speed of transactions.

**Why this matters for economic theory:**

Hayek's insight in *The Use of Knowledge in Society* (1945) was that the knowledge required for economic coordination is dispersed across millions of actors, each holding local information no central authority can access. The price system solves this by letting each node process only its local data while the price signal aggregates the result.

Framed in computational terms (see [Computation and Information Theory](../computation-and-information.md)):

- Each market participant is a **computationally irreducible agent** — you can't predict their choices without running their deliberation (this is free will, see [measurement-causality](../philosophy/measurement-causality.md))
- The market is a **computationally irreducible system** of such agents — you can't shortcut the market's output without running the market
- Central planning attempts to simulate this distributed computation on a single serial node, with worse information, higher latency, and degraded fidelity at every translation step
- **This is not a practical limitation but a theoretical impossibility** — for the same formal reason you can't predict a conscious agent's choice without running the agent

The price system's advantages are structural, not incidental: massive parallelism, zero-latency proximity between information source and decision maker, distributed computational cost, and bandwidth compression (one price encodes what no report can).

### Data
- [US Spending Per Student](./us-spending-per-student.md) — inflation-adjusted K-12 per-pupil expenditure over time, cross-verified across federal and independent sources
- [K-12 Instruction vs. Administration Spending](./k12-instruction-vs-administration.md) — breakdown of where school dollars go: instruction, administration, support services, staffing trends, and what actually drives cost growth

### Planned
- Business Models — how value is captured and sustained
- Architecture & Guardrails — how system design protects the profit signal (bridges to AI agent architecture)
- Agent Team Economics — compute costs vs. value created, optimal team structures

## Tags
[economics](../../tags/economics.md), [ai](../../tags/ai.md)
