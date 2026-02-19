# Monopoly
> Monopoly game engine with mathematically rigorous AI — Markov chains, property valuation, and strategic trading.

**Status:** active
**Created:** 2026-02
**Repo:** `C:\Users\Chris.Isaacson\source\repos\Monopoly`
**Links:** [Economics](../../research/economics/README.md)

## Overview

Full Monopoly implementation in JavaScript with a deep AI stack. The engine models the complete game (properties, auctions, trades, jail, chance/community chest) and the AI uses Markov-chain positional analysis to compute Earnings Per Turn (EPT) for every property, driving trade evaluation and strategic decisions.

### AI Architecture

- **Markov Engine** — steady-state landing probabilities for all 40 tiles
- **Property Valuator** — EPT (Earnings Per Turn) based on landing probability x rent, accounting for monopoly/house multipliers
- **Monte Carlo Validation** — empirical verification of Markov predictions
- **Strategic Trade AI** — trade filtering based on empirical monopoly win rates
- **20+ AI variants** in `simulation/` for comparative testing

### Key Results

- Best AI (StrategicTradeAI) achieves 35.7% win rate in multi-player games
- Trade quality filtering based on empirical monopoly win-rate data
- Genetic algorithm optimization explored for parameter tuning

### External Interface

Uses [Monopoly-Bot-Richup.io](https://github.com) (foreign repo in `source/repos/`) to interface bots with the Richup.io online platform.

## Tags
[game-ai](../../tags/game-ai.md), [economics](../../tags/economics.md), [javascript](../../tags/javascript.md)
