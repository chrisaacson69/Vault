---
status: active
created: 2026-11-08
discussion: folded-in
---
# Board Odds vs Exact Solutions — Battleship and Yahtzee
> Two games where the vault already holds an exact answer (Ballpark Figures' exhaustive Battleship analysis and solved Yahtzee), so Board Odds' "best strategy" can be scored against perfect play directly. **Battleship:** Board Odds' heat-map shooter is the right kind of policy and lands within about 1.6 shots of the exact greedy searcher (46.6 vs ≈45). Its *placement* advice, though, is a best response to bots that never adapt, while the exact answer is close to uniform random. **Yahtzee:** Board Odds builds the exact expected-score solver itself (254.61). Its best one-rule habit (hunt the upper bonus, 215.48) closes only about a sixth of the gap from the family player, because the missing 93% is pacing the top section, a decision that depends on the scorecard. Both show the hub thesis: principles get you most of the way, and the rest depends on the position.

**Source:** [Board Odds — "The Best Battleship Strategy, Tested on 100 Million Games"](../../../raw/videos/2026-10-25%20board-odds-battleship-100m-games.md) — <https://www.youtube.com/watch?v=b1c0Yg9t6EM> (15:00, 2026-10-25; auto-captions)
**Source:** [Board Odds — "The Best Yahtzee Strategy, Simulated on 300 Million Games"](../../../raw/videos/2026-10-27%20board-odds-yahtzee-300m-games.md) — <https://www.youtube.com/watch?v=5tf4GqBPAqU> (18:40, 2026-10-27; auto-captions)

**Links:** [Simulation channels hub](./README.md#thesis--chess-not-chutes-and-ladders), [Battleship: 30 Billion Boards](../battleship-board-analysis.md) (the exact Battleship analysis), [Yahtzee: 259 Trillion → 405 Million](../yahtzee-solved.md) (the solved Yahtzee page), [Solved Games](./solved-games.md)

---

## Battleship

**Setup.** Classic rules: 10×10, ships of 2, 3, 3, 4, 5, one shot a turn, sinks announced, ships may touch [1:00–1:18]. Four shooters (Random, Hunter = hunt/target baseline, Checkerboard, Heatmap) and six hiding styles; 100M games in total [0:24, 3:04–4:35, 7:24–7:37]. Controls: Hunter vs Hunter 49.96%, random placement vs Hunter 49.98% [1:21–2:50].

| Measure | Board Odds | Vault (exact analysis) |
|---|---|---|
| Hunt/target, average shots | 59.8 [3:55] | ≈63 |
| Probability-density shooter | Heatmap 46.6 [4:37] | greedy ≈45 |
| Best shooter vs baseline | Heatmap beats Hunter 76.4% [5:54] | greedy beats a human 86% (7 games) |
| First-move edge | 50.9% [12:53] | 51.6% under mutual greedy |
| Best placement | Spread out 54.3% vs Hunter [11:16] | near-uniform, wins 51.7% |

- **Shooting is near-exact.** Heatmap ("works out where the ships left could still fit, then fires at the square that fits the most") is the vault's greedy heat-map policy, starting in the centre. The 1.6-shot gap is plausibly post-hit handling, which the transcript doesn't specify.
- **The shooting gradient is steep and the hiding gradient flat, on both.** Board Odds: shooters span 58 tournament points and hiding styles 10, so "shooting matters ~6× more" [6:53–7:10]. That is the vault's best-response vs minimax split.
- **Placement is where Board Odds falls short.** Every hiding result is measured against a fixed shooter. Hiding on the edges is worth +6 shots against Heatmap but nothing against Hunter [10:02–10:47], which exploits a known shooter's prior rather than being a principle. Against an adaptive shooter it becomes a liability. Board Odds concedes the bots never learn your habits [14:19–14:27]. The vault's minimax answer is near-uniform placement, worth about half a turn.
- **Evidence for the vault's open thread.** The vault asks whether placement edge is really just the opponent's prior being wrong. Board Odds' "edges only help against the strong shooter whose prior says middle" is that effect measured.

## Yahtzee

**Setup.** Official Hasbro rules with the forced joker [1:15–1:48]. Players: an exact expected-score solver ("perfect"), a family "normal" player, random, and five one-habit variants. 300M games [1:52–2:52]. The solver gives 254.588 from an empty card, matched to four decimals by an independent open-source solver. Published figures (Verhoeff 1999, Glenn 2006) are 254.59 under a looser joker reading. Simulated spread and median match Verhoeff [3:11–4:17].

| Player | Average score | vs normal |
|---|---|---|
| Random | 46.01 | wins 1 in 8,665 |
| Stop after two rolls | 161.83 | 23.4% |
| Always chase Yahtzees | 164.70 | ~25% |
| Normal | 208.25 | — |
| Hunt the upper bonus | **215.48** | 54.5% |
| Perfect (max expected score) | **254.61** (vault: EV ≈ 255) | **76.32%** |

[5:53–6:33, 8:39–8:53, 11:16–11:33, 15:22–16:26]

- **The best principle closes a sixth of the gap.** Hunting the upper bonus lifts the bonus rate from 2.88% to 20.30%. The solver reaches 68.15%; the vault says about 2/3 is achievable [9:38, 11:16].
- **The gap is pacing, a decision that depends on the scorecard.** The top section plus its bonus account for 43.1 of the 46.4-point gap (93%) [9:16–10:42]. The solver gives back about 9.5 points elsewhere on purpose. The right move depends on which boxes are open and how many rolls are left: the same full house should be broken on the first roll and scored on the last [11:55–12:01]. The vault's "track pace" advice is that adaptive rule; a fixed habit can't do it.
- **Chasing Yahtzees is a trap**, in both sources: it averages 164.70 and fills the Yahtzee box *less* often than the normal player [7:12–8:19]. That matches Chris's keeper on the vault page: multiple Yahtzees mean you probably win, but you can't plan around them.
- **"Perfect" carries the asterisk in both.** Board Odds' solver maximises expected score, "isn't trying to beat you", and win-maximising play was not tested [4:19–4:35, 17:31–17:44]. So 76.32% is a lower bound on what optimal play wins against the family player, and the vault's toy model of when riskier play wins stays untested.
- **Unreconciled:** Board Odds counts "just over 1 million scorecard states" [1:56]; the vault counts 405 million positions after reduction. They probably count different things (scorecards vs scorecards × top-section score); not resolved.

## What the two games add to the thesis

These are the cleanest cases: one player against a fixed target (Yahtzee), or a shooter against a fixed distribution (Battleship). Principles land close where the target really is fixed: Heatmap is within 1.6 shots. They fall short where the right move depends on the state (Yahtzee pacing) or on what the opponent will do (Battleship placement). Those are the same two gaps the N≥3 games show, at a smaller scale.

## Tags

[games](../../../tags/games.md) · [game-theory](../../../tags/game-theory.md) · [simulation](../../../tags/simulation.md) · [youtube](../../../tags/youtube.md)
