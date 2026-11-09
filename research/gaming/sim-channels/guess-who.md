---
status: active
created: 2026-11-08
discussion: folded-in
---
# Guess Who — Board Odds vs Mark Rober (and Nica's Optimal Strategy)
> Mark Rober's 2015 video made "halve the board" famous, with a claimed 96% series win rate. Board Odds (2026) **solves the game exactly** and finds halving right but incomplete. The biggest single edge is a decision that depends on the position: **name a face as soon as your opponent is down to one.** Under the "first to narrow it down wins" rule, the trailing player should instead ask *narrow* bold questions, as Mihai Nica proved in 2016. Rober's numbers come from an undefined weak opponent and a model where the two players don't interact, and Board Odds could not reproduce the 96%. Good principle, inflated claim, and the missing piece is a decision that depends on who's ahead, which is the hub thesis in a 24-face game.

**Source:** [Board Odds — "The Best Guess Who Strategy, Simulated on 300 Million Games"](../../../raw/videos/2026-10-28%20board-odds-guess-who-300m-games.md) — <https://www.youtube.com/watch?v=4fbmWkPNcBQ> (16:16, 2026-10-28; auto-captions)
**Source:** [Mark Rober — "BEST Guess Who Strategy- 96% WIN record using MATH"](../../../raw/videos/2015-11-17%20mark-rober-guess-who-strategy.md) — <https://www.youtube.com/watch?v=FRlbNOno5VA> (12:24, 2015-11-17; creator captions)
**Paper:** Mihai Nica, "Optimal Strategy in 'Guess Who?': Beyond Binary Search", *Probability in the Engineering and Informational Sciences* 30 (2016) 576–592 — <https://arxiv.org/abs/1509.03327>

**Links:** [Simulation channels hub](./README.md#thesis--chess-not-chutes-and-ladders), [Solved Games](./solved-games.md), [Hangman — Solving Both Sides](../hangman-solving-both-sides.md), [Wordle — Solved](../wordle-solved.md) (other question-and-elimination games)

---

## Two rule sets, two answers

- **Official rule:** on your turn, ask one question *or* name a face. A wrong name loses [2:42–3:14].
- **House rule** ("win the moment you narrow it to one"): the version Rober uses [1:35].

Board Odds' exact solution: the first player wins 5/9 = 55.56% under the official rule (simulated 55.54%) and 63.19% under the house rule (simulated 63.20%) [3:16–4:12]. It notes the house-rule figure sits inside the range Nica proved [3:58–4:05].

## What each video found

| | Mark Rober (2015) | Board Odds (2026) |
|---|---|---|
| Testing | a 1,000-game simulation of a "standard" player only; halving worked out on paper [10:32–10:51] | 24 faces, two fan trait datasets, 9 players, ~300M games [1:54–5:22] |
| Halving | always wins in 5–6 moves, counting the final guess [5:13] | finds a face in 4.67 questions, never more than 5 [7:09] |
| Halving vs baseline, single game | "80%" vs a standard player needing ~7 guesses [10:37–10:51] | 62.56% vs Normal, who already picks the most even single trait (5.16 questions) [7:28] |
| Series claim | "96%" in a first-to-five match, asserted, not computed [10:53–11:01] | best-of-five: Halver 76.87%, Perfect 80.53% (85.25% house rule); "I couldn't reproduce 96%" [7:34–8:24] |

**On the 96%:** Board Odds tested *best of five* (first to 3), citing a "newer" Rober video. This 2015 video says "first one to five wins", a longer match that would raise any per-game edge. So part of the non-reproduction is a series-length mismatch. The larger cause is the opponent: Rober's "standard" player is undefined and needs about 7 guesses, and his model treats each player's game length as an independent normal curve, with no turn order.

## The position-dependent piece both principles miss

- **Official rule: name now when the opponent is down to one.** The "Last Chance" habit (Normal plus this one rule) beats Normal 64.91% and beats Halver 56.70% head to head, even with no compound questions [9:28–9:41]. "Nearly all of Smart's cleverness comes down to this one habit" [9:43]. Perfect play is "in effect the famous split plus this habit" [10:40].
- **House rule: when behind, gamble narrow.** Perfect "asks narrow ones instead", "the bold play from Mihai Nica's paper" [13:48–14:03]. Nica's result: binary search is not always optimal, and a player well behind should make a bold bid of a power of two set by the opponent's remaining pool, while the leader plays the safe half.
- **What optimal play looks like** (official rule) [11:26–12:13]:
  - Any opening question covering 8–12 faces is equally optimal; a 5-face opener drops to 53.47%.
  - It names a face only when it is down to one, when the opponent is down to one, or when both sides have exactly two left.
- **Overall table** [10:50–11:19]: Perfect 61.68, Last Chance 58.79, Halver 55.77, Smart 55.54, Gender First 46.29, Normal 46.02, Random 41.30, Guess-at-Two 38.61. Guessing at two faces finishes below random.

## Reading

Rober's principle (halve with compound questions) is sound and is part of perfect play. Board Odds is the rare channel video that reaches perfect play, by solving the game, and then distils it into rules. The rule that matters most is not a better split but a condition on who is ahead. That is the same lesson as Yahtzee pacing and the Risk bystander, in the smallest game in the collection.

## Caveats

- Board Odds' trait data comes from two fan datasets that disagree on a few faces. A full re-run moved overall averages by at most 1.19 points [2:03–2:23, 14:26–14:51].
- The official-rule wording is "the commonly published one"; Hasbro's site was unreachable [14:53–15:16].
- The bots never bluff or misread a face.
- Board Odds dates Rober's video to 2016 [1:05]; it was published 2015-11-17.

## Tags

[games](../../../tags/games.md) · [game-theory](../../../tags/game-theory.md) · [youtube](../../../tags/youtube.md)
