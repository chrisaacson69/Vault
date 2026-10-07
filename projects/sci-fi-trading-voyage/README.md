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
- **The game's own $/hr figure is not ground truth.** Treating it as the oracle chose the wrong speed model (it matched twice by coincidence). The stopwatch was the lower artifact. Now explained: profit = listed margin × (1 + route bonus + ~45% global), the fleet's cargo is one pooled hold, and leg time = distance × 10,000 / warp. That matches the game's figure within 0.5% on every clean row. The game's own loading and sale logs were the grounding, not its summary figure.
- Best route: Proxima → AlphaCentA (ResearchData3), only 7 Gm apart, about 30× ahead of the next best (BlackGoldStar ↔ Troy).
- Lesson worth keeping: the highest-margin trade ranked 8th once distance and empty return legs were counted. **Rank by margin per distance for the whole cycle, not margin per load.**
- **Goods come in whole units, so hold size is a threshold, not just a quantity — but the threshold is the *fleet's* pooled hold, not each ship's.** The game's loading logs proved the pooling (a fleet of ≤2,000-cargo ships loaded 9 units of a 4,000-size good). The earlier claim here, that 25,200-cargo haulers couldn't carry ResearchData3 (100,000/unit), was wrong; it assumed separate holds. `--ships` packs the pooled hold with an unbounded knapsack.
- **Prices are premiums over a fixed class average** (2026-10-07). A good's trailing digit is its class, with averages of 0.295 per cargo unit for class 1, 10 for class 2, and about 25–30 for class 3. Stops sell near the average; every premium is on the buy side, so margin ≈ class average × (buyer's multiple − 1). This is why a ×3 premium on a class-1 good is worth less than a ×1.5 premium on a class-2 good. `--premiums` tracks the premiums by class per day, to test Chris's guess that class 3 takes over later in the event.
- Next: fleet selection. Each route has a CP cap set by its level, so maximise cargo/CP × speed while keeping enough combat strength for pirates. The `--json` output is the interface for that tool.

## Tags
[games](../../tags/games.md), [python](../../tags/python.md), [economics](../../tags/economics.md)
