# Monopoly
> Monopoly game engine with mathematically rigorous AI — Markov chains, property valuation, and strategic trading.

**Status:** active
**Created:** 2026-02
**Repo:** [github.com/chrisaacson69/monopoly](https://github.com/chrisaacson69/monopoly)

## Vault ↔ Project Relationship

The Vault's gaming research pages contain the **abstract theory**. The Monopoly repo contains the **applied implementation**. Findings from the project validate or challenge the theory, which feeds back into the Vault.

| Vault Research (theory) | Monopoly Repo (applied) |
|---|---|
| [Nash Bargaining Problem](../../research/gaming/nash-bargaining-problem.md) | `research/positional-value-analysis.md` — 3-player Orange coalition |
| [Multiplayer Coalition Problem](../../research/gaming/multiplayer-coalition-problem.md) | `research/positional-value-analysis.md` — coalition formation dynamics |
| [Bilateral Trade Valuation](../../research/gaming/bilateral-trade-valuation.md) | `research/valuation-notes.md` — denial value, time-to-impact |
| [Subgraph Investment Optimization](../../research/gaming/subgraph-investment-optimization.md) | `ai/property-valuator.js` — EPT and ROI calculations |
| [Praxis: Agent Teams](../../research/economics/praxis-agent-teams.md) | `research/simulation/GROWTH-AI-SUMMARY.md` — tournament results |

**The rule:** Abstract theory lives in the Vault. Applied implementation lives in the repo. Cross-link, don't duplicate.

## Overview

Full Monopoly implementation in JavaScript with a deep AI stack. The engine models the complete game (properties, auctions, trades, jail, chance/community chest) and the AI uses Markov-chain positional analysis to compute Earnings Per Turn (EPT) for every property, driving trade evaluation and strategic decisions.

### AI Architecture

- **Markov Engine** — steady-state landing probabilities for all 40 tiles
- **Property Valuator** — EPT based on landing probability × rent, accounting for monopoly/house multipliers
- **Monte Carlo Validation** — empirical verification of Markov predictions
- **Strategic Trade AI** — trade filtering based on empirical monopoly win rates
- **20+ AI variants** in `simulation/` for comparative testing

### Key Results

- Best AI (StrategicTradeAI) achieves 35.7% win rate in multi-player games
- Trade quality filtering based on empirical monopoly win-rate data
- Genetic algorithm optimization explored for parameter tuning

## Tags
[gaming](../../tags/gaming.md), [projects](../../tags/projects.md)
