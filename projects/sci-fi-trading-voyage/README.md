---
status: active
created: 2026-10-06
---
# Sci-Fi Trading Voyage — Trade-Route Calculator
> Ranks every two-stop round trip in the game's trading mini-game by profit per hour, using a 25-stop price-and-coordinate snapshot.

**Links:** [Triangular Arbitrage](../triangular-arbitrage/README.md) (same buy-low/sell-high search, in real markets), [MOO1 Opening Optimizer](../moo1-opening-optimizer/README.md) (the other distance-limited game economy), [BattleTech Simulator](../battletech-simulator/README.md) (the likely shape of the next step: value per cost for picking ships)

**Logical name:** `sci-fi-trading-voyage` — [github.com/chrisaacson69/sci-fi-trading-voyage](https://github.com/chrisaacson69/sci-fi-trading-voyage) (public), cloned as a sibling (`../sci-fi-trading-voyage`). Python standard library only.
**Repo entry point:** `README.md` (model, how each assumption was measured, usage). `trade_routes.py --selftest` checks the numbers.

## Status (2026-10-06)

- All 25 stops recorded. Travel time = distance × 10,000 / warp seconds, no fixed overhead. Stopwatch runs at warp 5,000 and warp 2,250 match it to the second; route levels add +N% profit.
- **The game's own $/hr figure is not ground truth.** Treating it as the oracle chose the wrong speed model (it matched twice by coincidence). The stopwatch was the lower artifact. The game's figure is still unexplained (~0.7× under a pooled-hold model).
- Best route: Proxima → AlphaCentA (ResearchData3), only 7 Gm apart, about 30× ahead of the next best (BlackGoldStar ↔ Troy).
- Lesson worth keeping: the highest-margin trade ranked 8th once distance and empty return legs were counted. **Rank by margin per distance for the whole cycle, not margin per load.**
- **Goods come in whole units, so hold size is a threshold, not just a quantity.** ResearchData3 is 100,000 per unit, so a fleet of 25,200 haulers can't run the best route at all, while 3 × 130,000 earns about 40× more. `--ships` packs each hold with an unbounded knapsack.
- Next: fleet selection. Each route has a CP cap set by its level, so maximise cargo/CP × speed while keeping enough combat strength for pirates. The `--json` output is the interface for that tool.

## Tags
[games](../../tags/games.md), [python](../../tags/python.md), [economics](../../tags/economics.md)
