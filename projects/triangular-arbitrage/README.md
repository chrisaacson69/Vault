# Triangular Arbitrage — Currency & Crypto Market Differentials
> Can we exploit differentials in cross-rates for profit? Math says yes. The question is infrastructure.

**Status:** active — DeFi/Solana path under investigation
**Created:** 2026-02-12
**Repo:** `C:\Users\Chris.Isaacson\source\repos\triangular-arbitrage`
**Links:** [Economics](../../research/economics/README.md), [Risk and Entrepreneurship](../../research/economics/risk-and-entrepreneurship.md), [Cyborg Model](../../research/cyborg-model.md), [Cognitive vs. Motor Skills](../../research/cognitive-vs-motor.md)

## Summary

Exploit differentials in exchange rates across currencies or tokens. If the product of rates around a loop != 1.0, there's a profit opportunity. Multiple approaches from full triangular loops to single-leg trades to DeFi flash loans.

### Key Findings

- **264 out of 336** triangular paths show positive profit (live ECB rates, 8 currencies)
- Best full-loop: USD -> AUD -> JPY -> USD yields **$7.13 on $10,000** (0.071%)
- Best single-leg: **JPY/GBP** at 0.087% deviation — **$86.79 profit on $100K**
- **JPY is consistently the mispriced currency** — slower price discovery

### Business Case

| Scenario | Upfront | Monthly Profit | Break Even |
|----------|---------|----------------|------------|
| Forex Institutional | $135,000 | $1,500 | 90 months |
| Crypto CEX | $0 | $300 | Immediate |
| DeFi Solana (Conservative) | $600 | $430 | 1.4 months |
| DeFi Solana (Optimistic) | $600 | $2,830 | 6 days |

**Decision:** Forex no. DeFi/Solana worth investigating — asymmetric risk profile, flash loans = zero capital, failed txs cost near-zero gas.

### Framework Validation

This project validated every layer of the economics framework: utility/trade (differentials exist), risk (asymmetric profile favors the bet), COO vs CEO (we initially skipped the CEO step), grounding (real money, can't be talked out of a loss).

See full analysis and next steps in the repo README.

## Repository Files

- `detect_arbitrage.py` — Full triangular arbitrage detector with Bellman-Ford
- `single_leg_analysis.py` — Single-leg implied cross-rate deviation analysis
- `roi_analysis.py` — ROI comparison across all four scenarios

## Tags
[economics](../../tags/economics.md), [risk](../../tags/risk.md), [praxis](../../tags/praxis.md), [agents](../../tags/agents.md), [crypto](../../tags/crypto.md), [defi](../../tags/defi.md)
