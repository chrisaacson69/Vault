# Triangular Arbitrage — Currency & Crypto Market Differentials
> Can we exploit differentials in cross-rates for profit? Math says yes. The question is infrastructure.

**Status:** active — DeFi/Solana path under investigation
**Created:** 2026-02-12
**Repo:** `https://github.com/chrisaacson69/triangular-arbitrage`
**Links:** [Economics](../../research/economics/README.md), [Risk and Entrepreneurship](../../research/economics/risk-and-entrepreneurship.md), [Computation and Information Theory](../../research/computation-and-information.md), [Cyborg Model](../../research/cyborg-model.md), [Cognitive vs. Motor Skills](../../research/cognitive-vs-motor.md)

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

## Next Directions

### DeFi Triangular Arbitrage (Solana)

**Why DeFi solves the biggest practical risk:** On-chain transactions are atomic — an entire triangular loop (A→B→C→A) either executes completely or reverts. No partial execution, no stranded positions. If your internet drops mid-submission, the transaction either already landed or never happened. Flash loans eliminate capital requirements entirely — borrow, arbitrage, repay in one atomic transaction.

**Remaining practical concerns:**
- MEV (Maximal Extractable Value) — validators/searchers can front-run or sandwich your arbitrage transaction. Mitigation: use Jito bundles on Solana for MEV protection, or private transaction submission.
- Competition — other bots are scanning the same pools. Edge comes from speed (optimized on-chain programs), breadth (monitoring more pool pairs), or novel routes (multi-hop paths others miss).
- Simulation — Solana devnet and local validator allow full testing without risking capital.

### Cross-Exchange Arbitrage

**The mechanism:** Hold pre-funded balances on multiple exchanges (CEXs, DEXs, or both). When the same asset is priced differently across venues by more than the combined fees, buy on the cheaper exchange and sell on the more expensive one simultaneously. No transfer between exchanges during the trade — both legs execute against existing balances.

**Synchronization:** Maintain WebSocket connections to each exchange, streaming live order book data. An event loop processes price updates from all feeds and recalculates cross-venue spreads on every tick. Perfect clock synchronization isn't required — the spread just needs to exceed fees + the staleness window.

**Capital model:** Pre-funded accounts on each venue. Periodic offline rebalancing moves funds between exchanges to maintain inventory. The trade-off is capital efficiency — funds are spread across venues rather than concentrated.

**No prediction required:** Pure cross-exchange arbitrage is reactive, not predictive. You observe a current mispricing and exploit it. If you need to predict price direction, you've crossed from arbitrage into speculation.

### Futures and Derivatives Strategies

Futures analysis opens several strategies beyond spot arbitrage:

- **Cash-and-carry arbitrage** — when futures trade at a premium to spot, buy spot and short futures. The spread is locked in as profit because futures converge to spot at expiry. No prediction needed — convergence is structural.
- **Funding rate arbitrage** — perpetual futures have periodic funding payments between longs and shorts. When funding rates are elevated, go long spot + short perp (or vice versa) to collect funding as yield while remaining market-neutral.
- **Cross-venue futures arbitrage** — the same futures contract priced differently across exchanges. Same pre-funded inventory model as spot arbitrage.
- **Hedging during execution** — if a cross-exchange spot arbitrage can't be executed simultaneously (e.g., one leg is slow), hedge the directional exposure with a futures position until both legs complete.

**Statistical arbitrage (different risk profile):** When correlated assets' price ratios deviate from their historical mean, bet on reversion. This IS predictive — it requires a model of "normal" price relationships and a bet that deviations are temporary. Higher potential returns than pure arbitrage, but introduces directional risk. Closer to quantitative trading than arbitrage proper.

### Strategic Approach — Compete on Insight, Not Speed

**The competition gradient:** Simple, pure arbitrage on major pairs is a COO problem — execution speed, infrastructure, operational efficiency. MEV bots and HFT shops dominate this with Jito bundles, colocation, and custom hardware. Competing there as a solo operator means playing their game on their turf.

**Where the edge lives:** The more complex strategies — futures basis trades, funding rate capture, statistical arbitrage across correlated pairs — are CEO problems. They require judgment about *which* bets to take, modeling of risk/reward tradeoffs, and understanding of market microstructure. First-principles analysis provides an edge here because you're not racing on milliseconds, you're racing on insight. There's less competition precisely because the risk filters out participants who can't model it properly — profit is the reward for correct bets under uncertainty (see [Risk and Entrepreneurship](../../research/economics/risk-and-entrepreneurship.md)).

**The plan:**
1. **Explore all strategies in simulation** — even simple ones, to build empirical understanding of market behavior
2. **Focus analytical effort on the riskier strategies** — these are where competition is thinnest and the analysis edge matters most
3. **Prove the edge before scaling infrastructure** — dedicated hardware without a proven strategy is just expensive electricity. Traditional quant shops started on retail hardware and only moved to colocation/FPGAs once strategies proved out
4. **Scale infrastructure to match proven edge** — if strategies work in simulation and small live tests, invest in faster execution to capture more of the spread

**The data has value beyond P&L:** Even if direct trading doesn't produce immediate returns, the simulation process generates deep empirical understanding of how these markets actually behave — feeding back into the economics research, computation-and-information work, and general market microstructure knowledge.

### Architecture Considerations

- **Simulation first** — all strategies should be backtested against historical data and forward-tested on testnets/devnets before live capital
- **Risk management** — position limits, maximum exposure per venue, automatic shutdown on anomalous conditions
- **Monitoring** — real-time dashboard showing open positions, P&L, spread history, execution latency
- **Modular design** — exchange connectors as plugins (add new venues without rewriting core logic), strategy layer separate from execution layer

## Repository Files

- `detect_arbitrage.py` — Full triangular arbitrage detector with Bellman-Ford
- `single_leg_analysis.py` — Single-leg implied cross-rate deviation analysis
- `roi_analysis.py` — ROI comparison across all four scenarios

## Tags
[economics](../../tags/economics.md), [risk](../../tags/risk.md), [praxis](../../tags/praxis.md), [agents](../../tags/agents.md), [crypto](../../tags/crypto.md), [defi](../../tags/defi.md)
