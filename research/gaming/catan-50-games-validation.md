---
status: active
created: 2026-05-18
---
# Catan 50-Game Validation — What N=50 Can and Can't Tell Us
> Proof-of-method run of the [board-frontier theory](./catan-47k-empirical.md#board-as-efficient-frontier--a-prescription-theory-sketch) against the public `lumins/settlers-of-catan-games` dataset (50 four-player games on Kaggle, mirrored on GitHub). Aggregate winner-vs-loser bias toward the city engine **directionally confirmed** (Δ = +0.016, matching Roman's qualitative finding at much smaller scale). Board-conditional prediction is **partially confirmed** — city-rich boards show the right direction; road-rich don't, but at N=10 games per archetype the sample can't distinguish "wrong direction" from "noise." Snake-position pattern in this dataset **does not match Roman's** — P2 dominates 36% / P1 underperforms 16%, suggesting the dataset's games may not use standard snake-order placement. Classifier comparison turned out to be the **wrong comparison** at this scale (within-game ranking is much easier than across-game outcome prediction; Roman's 27% and my 48% are not on the same axis).

**Links:** [Catan — 47,000 Games of Empirical Findings](./catan-47k-empirical.md), [Gaming](./README.md), [Bilateral Trade Valuation](./bilateral-trade-valuation.md), [Monopoly Theory](./monopoly/), [Frontier Trade Theory](./monopoly/frontier-trade-theory.md), [Subgraph Investment Optimization](./monopoly/subgraph-investment-optimization.md)

**Data:** [lumins/settlers-of-catan-games on Kaggle](https://www.kaggle.com/datasets/lumins/settlers-of-catan-games) — 50 four-player games (200 player-rows), starting placements (settlement positions with adjacent tile numbers and resources), dice-roll histograms, port adjacencies, and resource-flow stats. Mirrored at [DevinRS/Settlers_of_Catan_Analysis](https://github.com/DevinRS/Settlers_of_Catan_Analysis). Local copy: `raw/datasets/catan-50games/catanstats.csv`.

**Analysis script:** `raw/datasets/catan-50games/analyze.js` — saved tool (the "code over tokens" rule); rerunnable.

---

## Setup

The four predictions from the [board-frontier theory](./catan-47k-empirical.md#what-this-theory-would-predict-testable-claims-for-romans-data) are:

1. **Conditional on board archetype, winners cluster on the predicted strategy** (city-rich → city-engine winners; road-rich → road-engine winners)
2. **Obvious-path crowding leads to overpay-counter-positioning** — late-pick obvious-strategy players underperform late-pick counter-positioners (NOT testable from this dataset — no opponent-modeling data)
3. **Classifier ceiling improves dramatically when board-archetype is a feature** (Roman: 27% from placement-only)
4. **Snake-position win-rate variance tracks board-archetype skew** — gap should widen on archetype-skewed boards

What this dataset has: starting placements with full pip-and-resource info, port adjacencies, dice histograms, final VPs, snake position. What it lacks: per-turn moves, trades, robber placements, opponent perception.

## Method

For each player, computed pip-weighted exposure per resource (pip-weight for each of the 6 hex adjacencies = 1+2+3+4+5 for number tokens 2/12, 3/11, 4/10, 5/9, 6/8; desert = 0). City engine = pip(wheat + ore + sheep); road engine = pip(wood + brick). Per game, aggregated all 4 players' exposures into a board-level resource distribution proxy. **Classified each board:**

- city-rich: cityShare ≥ 0.62 (n = 22 games)
- balanced: 0.55 < cityShare < 0.62 (n = 18 games)
- road-rich: cityShare ≤ 0.55 (n = 10 games)

Note: this is a *proxy* — we never see the full 19-tile board, only the 24 hex-adjacencies the placements collectively touched. The aggregate skews toward what was *picked*, not what was *available*, which is endogenous. A better dataset would record the full hex layout. The proxy still distinguishes city-rich from road-rich boards usefully because pip-weighted exposure is roughly proportional to the player-perceived value of each resource on that board.

## Findings

### Aggregate replication — directionally confirms Roman (✅)

| Metric | Winners | Losers | Δ |
|---|---|---|---|
| Mean cityShare | 0.63 | 0.61 | **+0.016** |

Roman's 47k showed "winners had slightly higher ore/wheat/sheep exposure." The 50-game dataset shows the same direction at a small magnitude. With N=50, this is "consistent with" not "proven," but the proof-of-method works. The features are computable; the direction is right.

### Prediction 1 — board-conditional winner archetype (⚠️ partial)

| Board archetype | Games | Winner cityShare | Loser cityShare | Δ (winner − loser) |
|---|---|---|---|---|
| city-rich | 22 | 0.69 | 0.68 | **+0.014** ✅ direction right |
| balanced | 18 | 0.59 | 0.59 | +0.003 (≈ 0, as predicted) |
| road-rich | 10 | 0.55 | 0.50 | **+0.046** ❌ direction wrong |

City-rich boards: winners *do* lean more city-engine than losers, but the gap is tiny (+0.014). Predicted direction confirmed but the effect is small enough to be sample noise.

Balanced boards: near-zero gap, as theory predicts.

Road-rich boards: **winners still have HIGHER city-engine exposure than losers** (Δ = +0.046, opposite of theory's prediction). Three readings:

- **Reading A (small N):** Only 10 road-rich games (40 player-rows, 10 winners). The +0.046 could be 1-2 anomalous winners; the standard error is large.
- **Reading B (theory too sharp):** Even on relatively-less-city-rich boards, the city engine still wins. The threshold for true "road-rich" boards (where the road engine dominates) might require cityShare ≤ 0.50, which doesn't occur in this dataset at all. What I called "road-rich" is really just "less city-rich than average."
- **Reading C (theory wrong):** City-engine bias is universal in Catan, regardless of board configuration. Roman's aggregate finding is the conditional truth.

Reading B is most consistent with what we know: the city engine has a structural advantage (cities double production; dev cards add hidden VPs) that operates across configuration. The board-frontier theory may need refinement: archetype effect exists but is *layered on top of* a universal city-engine bias, not a clean either-or.

### Snake-position pattern — does NOT match Roman (⚠️)

| Position | n | Win rate |
|---|---|---|
| P1 | 50 | **16.0%** |
| P2 | 50 | **36.0%** |
| P3 | 50 | 28.0% |
| P4 | 50 | 20.0% |

Roman's 47k: position win rates ≈ 24.9% / ~25% / >25% / ~25%, essentially balanced.

This 50: P2 dominates (36%) and P1 underperforms (16%) by a huge margin. At N=50 per position, the standard error on a win rate ≈ √(0.25 × 0.75 / 50) ≈ 6 percentage points, so the 20-point spread between P1 and P2 is **multiple standard errors** — unlikely to be pure noise.

The most likely explanation: **this dataset's games may not use standard snake-order placement.** The 50-game dataset comes from one group's home games (per the Medium write-up by the original author and the duddhawork.com analysis), and home games often use simplified placement rules (everyone places in straight turn order, or some other house variant). Without knowing this group's rules, we can't draw conclusions about snake-order balance from this dataset.

This is a *methodological finding* about the dataset rather than a finding about Catan. Worth recording: **Roman's "turn order is balanced" claim requires the snake-order placement rule; in home games with non-snake rules, position 1 may be substantially disadvantaged.**

### Prediction 4 — snake-position variance by archetype (⚠️ inconclusive)

| Archetype | P1 | P2 | P3 | P4 | P1 − P4 range |
|---|---|---|---|---|---|
| city-rich (n=22) | 22.7% | 31.8% | 22.7% | 22.7% | 0.000 |
| balanced (n=18) | 11.1% | 33.3% | 38.9% | 16.7% | −0.056 |
| road-rich (n=10) | 10.0% | 50.0% | 20.0% | 20.0% | −0.100 |

Theory predicted: variance widens on archetype-skewed boards. The data shows variance does widen as boards move from city-rich (flat) to road-rich (P1 underperforms by 10 points). But:

- The direction is the opposite of "P1 wins more on skewed boards" — P1 underperforms most on road-rich boards (the more-skewed archetype in this sample is road-rich).
- N=10 in the road-rich row is too thin (P2's 50% comes from 5 wins of 10 games — could swing wildly with one more game).
- The dataset-wide P1 disadvantage swamps the conditional pattern.

Verdict: not interpretable at this scale. Right dataset is needed.

### Prediction 3 — classifier ceiling lift (❌ — and the comparison was wrong)

| Classifier | Within-game accuracy |
|---|---|
| Random pick among 4 players | 25.0% |
| Placement-only (max totalPip) | **48.0%** |
| City-engine-only (max cityEnginePip) | 42.0% |
| Archetype-aware (city/road by board) | 42.0% |

The archetype-aware classifier **did not beat** the placement-only classifier — actually performed slightly worse. At face value this looks like a refutation of Prediction 3.

But the comparison to Roman's 27% is **the wrong comparison**, and this finding clarifies why. Roman's classifier was *across-game outcome prediction* — given the opening features of one player in one game, predict whether *that game* was a win. My classifier is *within-game ranking* — given four players in one game, pick the one most likely to win. The within-game problem is dramatically easier because all four players see the same board and the same dice; the relative pip exposure between them is highly predictive of the relative outcome.

A fair test of Prediction 3 would require running Roman's analysis design on this dataset: train on a feature set excluding board archetype, then add board archetype as a feature, and see whether held-out across-game accuracy lifts. With N=50 across-game prediction is statistically underpowered to detect a 3-percentage-point lift (which is what Roman would expect to see at 27% → 30%), so this test is unreliable on this data regardless.

**The intra-game classifier finding does tell us something useful:** between players on the same board, total pip exposure dominates archetype alignment. That's consistent with reading B above — the universal city-engine bias plus raw production rate together overwhelm the conditional archetype signal at this N.

## What this exercise actually validated

1. ✅ **The methodology is implementable.** Pip-weighted features, archetype classification, and per-board aggregation can all be computed from per-settlement data alone. This is a deliverable; the analyze.js script lives in the dataset folder for reuse.
2. ✅ **The aggregate direction is right** (winner bias toward city engine). Replicates Roman qualitatively at 1000× smaller scale.
3. ⚠️ **The board-conditional refinement is partially supported but not strong** — Reading B (universal city-engine bias plus layered archetype effect) is most consistent with the data.
4. ❌ **The 50-game dataset is unsuitable for Prediction 3 and Prediction 4 tests** — the right comparisons require Roman's across-game classifier on N≥1000 or proper snake-order rule.
5. 🔍 **Methodological finding:** the 50-game dataset has non-standard turn-order behavior (P1=16%, P2=36%). Roman's balanced-turn-order result requires *snake-order placement specifically*, which may not be universal in casual play.

## What the analysis can't determine

At N=50, several theoretically-interesting things are unmeasurable:

- The crowding/counter-positioning prediction (P2) requires opponent-modeling data this dataset doesn't have
- Late-game Monopoly card timing analysis requires per-turn play logs
- Trade efficiency vs. position analysis requires trade-by-trade detail
- The conditional cityShare effect needs N≥500 per archetype to distinguish from noise

These are the questions where the [Monopoly project](../../projects/monopoly/README.md) is the better proving ground — full simulator access, controllable conditions, unlimited N. The Catan board-frontier theory inherits the validated form from the Monopoly time-axis form once that's mature.

## Next steps

Three directions, ordered by ROI:

1. **Pivot to Monopoly for theory validation.** The frontier-and-bidding theory has the right shape; testing should happen where data access is unlimited. ([[catan-data-landscape]] reference memory has the standing recommendation.)
2. **If pushing on Catan: contact Roman or twosheep.io** for research-grade access to the 47k dataset. Roman has an ORCID; she may share code or aggregated tables on request.
3. **If DIY: build a board-archetype-aware Catan simulator** (rather than relying on real play data). The vault already has the methodology pattern from the Monopoly project; a small Catan simulator with full controllable boards would let us test the predictions at unlimited N.

## Connections

- **[Catan 47k page](./catan-47k-empirical.md)** — the framing this exercise was meant to validate. Updated cross-reference: the theory's strong form (clean archetype-conditional split) is **not** supported at N=50; a refined form (universal city-engine bias + layered archetype effect) is consistent with the data and is the working hypothesis.
- **[Frontier Trade Theory (Monopoly)](./monopoly/frontier-trade-theory.md)** — the right place for further validation; full data access.
- **[Catan data landscape (memory)](../../../.claude/projects/C--Users-Chris-Isaacson-Vault/memory/reference_catan_data_landscape.md)** — the public-data audit that motivated this proof-of-method.

## Tags

[games](../../tags/games.md), [game-theory](../../tags/game-theory.md), [strategy](../../tags/strategy.md), [mathematics](../../tags/mathematics.md), [simulation](../../tags/simulation.md)
