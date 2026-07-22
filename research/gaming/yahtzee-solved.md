---
status: active
created: 2026-07-20
discussion: folded-in
---
# Yahtzee: 259 Trillion → 405 Million, and the Asterisk on "Solved"
> Ballpark Figures collapses Yahtzee's position space by ~640,000× and solves it by backward induction — but solves *expected points*, not *winning*, and then has to mint a second currency to talk about the actual game.

**Source:** [Ballpark Figures — "I Solved Yahtzee\*"](https://www.youtube.com/watch?v=DOgb5wrb7mM) (33:16, 2026-07-19) — [transcript](../../raw/debates/yahtzee-solved-clean.txt) · [raw VTT](../../raw/debates/yahtzee-solved-DOgb5wrb7mM.en.vtt)
**Sibling specimen:** [Battleship — 30 Billion Boards](./battleship-board-analysis.md) — same creator, his first video, already in the vault. He explicitly calls back to it ("both are basically one-player games disguised as multiplayer games").

> A **specimen page** (dated, source-anchored). Portable home TBD — see the seeds below; that judgment belongs to the discussion, not to this draft.

---

## What he actually did

**1. The state space, and its collapse.**

| Stage | Positions | What was thrown away |
|---|---|---|
| Raw | **259 trillion** | — |
| Equivalence classes | **80 billion** | *Which* boxes hold *which* numbers; only (boxes filled, top score, bottom score, # yahtzees) survives |
| EV-only reduction | **405 million** | Bottom-section score entirely; yahtzee count → one eligibility bit; top score capped at 63 |

The reduction rule is stated explicitly: **keep only information that affects *future* points.** Bottom-section score is discarded because it's sunk — it changes your total but not any future decision. Top score above 63 is discarded because the bonus is already banked.

Supporting counts: 5 dice = 7,776 ordered outcomes but **252** distinct multisets; 756 situations per turn; ~8,000 box-fill combinations; 385 billion ways to fill a scorecard.

**2. The method.** Backward induction / dynamic programming. Start at the last roll of the last turn, compute EV of every keep-set, take the max, step back one roll, repeat to the opening. Result: **EV ≈ 255**, median 248.

**3. Endgame per-box results** (last-turn, going all-out): yahtzee <5%; large straight ~25%; full house ~1/3; four-of-a-kind 28% (≈6 pts avg); three-of-a-kind 71% (≈15 pts avg); small straight high — which is why it's the box to keep alive longest. Chance has a clean closed form: a die's EV is 3.5 with one roll left, 4.25 with two, so keep 5–6 on the first roll and 4–6 on the second → 23⅓ average.

**4. The counterintuitive bit.** Three/four-of-a-kind score the *sum* of dice, so they mix all-or-nothing with score-maximizing. With three 1s and two 6s, keeping the **sixes** beats keeping the ones — lower success chance, higher payoff conditional on success.

**5. The re-scoring.** Raw points produce a weirdly multimodal score histogram. He explains it by minting a **second currency**: extra yahtzee = 4, {top bonus, large straight, yahtzee} = 2, {3oak, 4oak, full house, small straight} = 1. The peaks are then just "missed N bonus points." Claim: between two optimal players, a **1-point lead on this scale ⇒ 97% chance of winning the game**.

**6. Option-value curve.** A plot of each box's EV *conditional on still being unfilled at round N*. Safest to zero: four-of-a-kind in the first half, yahtzee in the second (worth more, but harder). Last to give up: small straight, then three-of-a-kind, then large straight.

**7. Top bonus.** 63 = three of every number. ~2/3 achievable; track pace against "3 per filled box." Putting 12 in the sixes box costs ~6 points directly **and ~17 more in bonus EV**.

**8. Opening.** Best turn-1 outcome is a yahtzee; **second best is four sixes** (24 in the six box), then four 5s, large straight, four 4s, four 3s. Never fill four-of-a-kind on turn 1 (the top section always pays better). Worst opening roll: 2-3-4-4-6 → dump 19 into chance.

**9. Where it stops.** Multiplayer is **not** solved — each added player is exponentially harder, and he says his hardware couldn't do it. Multiplayer advice degrades to heuristics: aggressive when behind, conservative when ahead. Median needed to win rises with the field: 248 (1 opp) → 268 (2) → 279 (3) → 307 (5); then 3 yahtzees to win a box of 80 sheets, 4 at a 5,000-person Hasbro picnic, 6 for Rhode Island, 9 for all 8.3 billion humans, and a perfect 1,575 somewhere around 51 quintillion players.

## Discussion seeds

1. **The asterisk is load-bearing.** He solved *expected points*, but the game's telos is *winning*. He knows it — that's why §5 mints a second currency. Is the 4/2/1 bonus scale an elegant heuristic, or a quiet admission that the DP optimized the wrong objective and the real one had to be bolted on afterward?
2. **The reduction is telos-relative.** "Discard what doesn't affect future points" is valid *only* for the EV objective. Under win-maximizing, the discarded bottom-section score becomes decision-relevant again (you need to know whether you're ahead). So the 405M model is provably insufficient for the very question §9 asks it. Does that quietly undercut all the multiplayer advice?
3. **Option pricing in disguise.** §6's curve is an option-value decay chart, and "zeroing out" is exercising your cheapest option. Does this connect to the manufactured-option-space work, or is the resemblance superficial?
4. **What's the portable claim?** Battleship's was *structure creates norms* (symmetry-breaking). The candidate here might be *state compression is telos-relative* — what counts as "the same position" depends entirely on what you're optimizing. Is that a real thesis, and is it new, or does it already live somewhere in the vault?
5. **The 97% number.** A 13-box scorecard compressed to one integer that predicts the winner 97% of the time — but measured *between two optimal players*. Does it survive contact with human play, where the score distribution is different?
6. **Anti-Battleship?** Battleship's randomness was adversarial (placement = minimax against an opponent). Yahtzee's is exogenous (dice don't respond to you). Does that make Yahtzee the purer test of option-value play — or the shallower game?

## Discussion

### Chris's verdict: this is confirmation, not discovery

> "There isn't too much here, just a math-confirmed state machine. The end result is that it is
> good to mathematically confirm what is probably well-known strategy."

The deflation is the finding. Nothing in the strategy output would surprise a heavily-experienced
Yahtzee player — the value is that **folk knowledge got formally verified**, and that the deep-math
treatment surfaces moves that aren't *inherently* obvious but "probably make sense to a player with
lots of experience." Chris keeps the channel around for the method (deep math on even the simplest
games), not for novel conclusions.

**Chris's three keepers from the video:**
1. Multiple yahtzees ⇒ you probably win — but you can't plan around it.
2. Therefore the **+35 top-section bonus is the real target** — the big lever you actually control.
3. **The zero-out / switch-targets chart is "gold"** — the single most practically useful artifact,
   because knowing *what to sacrifice on a missed roll* is the decision players actually face.

### Chris on the EV-vs-win split

He grants the critique and locates it in the video's own words: the creator flags the difference
between playing optimally and beating your opponent. **Chris's framing of the sequence:** the
simplifications were made *to make optimal play computable* — and then he simplifies a second time,
in a different direction, to say anything at all about PvP.

**Chris's challenge to "play riskier when behind":**

> "Optimal play already takes into account risk, so theoretically 'taking more risks' is going to
> lose you more games than you win if behind."

### Worked through: when does "play riskier when behind" actually win?

Chris pushed back on the claim that EV-optimal play is wrong when behind, and the pushback held.
His decomposition: *optimal play isn't a static path, it's a decision tree* — and the real question
is a comparison of probabilities, "the odds of you double-yahtzeeing vs. the odds of him rolling
bad." **Claude's initial counterexample was the easy case** — it assumed the opponent had already
finished, making their score a fixed threshold. Mid-game their score is a random variable too, so
you are maximizing P(X > Y) against a *distribution* of thresholds.

A toy model (**not** Yahtzee — deliberately minimal) isolates the variable. You are at 200 filling
your last box: SAFE = +25 guaranteed, RISKY = +40 at p=0.30 else 0 (EV 25 vs 12, so the
EV-maximizer always takes SAFE). The opponent's *expected* final score is pinned at 235 in every
row; only **how determined it is** changes:

| Opponent rounds left | P(win) SAFE | P(win) RISKY | Better |
|---|---|---|---|
| 0 (finished) | 0.000 | **0.300** | RISKY |
| 1 | 0.167 | **0.200** | RISKY |
| 2 | **0.278** | 0.203 | SAFE |
| 3 | **0.356** | 0.232 | SAFE |
| 4 | **0.363** | 0.242 | SAFE |
| 6 | **0.388** | 0.281 | SAFE |

**The finding — Chris's read was right.** "Keep playing optimally and hope for a bad string on
their side" is not the timid option, it is the *correct* one for most of the game: the opponent's
own variance supplies the spread for free, and you don't pay the EV cost to buy it. Variance-seeking
turns on only as their score **hardens**. The trigger is therefore not "am I behind" but
**"is their number still moving"** — which is why the advice as stated in the video is
directionally right but numerically empty.

**Two distinct mechanisms, which the video conflates into one "take more risks":**
- **Reachability (support).** Chris's double-yahtzee case: *"the only way to win now is to also
  double yahtzee, so any play that doesn't keep this option open is dead."* If their locked score
  exceeds your maximum achievable score, P(win) = 0 for support reasons — variance is irrelevant,
  your winning set has zero measure. This is the k=0 row.
- **Variance tuning.** Only operative *inside* the reachable set, and only worth paying for as the
  opponent's distribution collapses toward a spike.

Reachability binds first. Note the minimax caveat Chris flagged: the whole frame assumes the
opponent plays perfectly from here on.

### Chris on "solo-together" games (flagged as a side quest)

The creator opens by calling both Battleship and Yahtzee "one-player games disguised as multiplayer
games." Chris: "in many ways they are — you can't interact with the other player." The entire
interaction surface in Yahtzee reduces to the one risk-posture knob above.

**Chris is parking this deliberately** ("I just have to think about it more, as there are several
games like this") — but he widened the category before parking it: it includes **multiplayer race
games where the only interaction is trying to trip up the leaders.** That suggests a spectrum of
interaction surfaces rather than a binary solo/multiplayer split:

- **Zero channel** — Battleship placement, Yahtzee: you affect the opponent not at all; the only
  lever is your own risk posture, read off *their* state.
- **Spoiler-only channel** — race games: you cannot help yourself, only hinder the leader.

Open question for when this gets picked up: is "solo-together" one category or the degenerate end
of a gradient — and does the risk-posture finding above generalize as *the* strategic content of
games with no interaction channel? Nearby vault pages:
[Multiplayer Coalition Problem](./multiplayer-coalition-problem.md),
[Capability Without Leverage](./capability-without-leverage.md).

## Tags

[games](../../tags/games.md), [game-theory](../../tags/game-theory.md), [strategy](../../tags/strategy.md)
