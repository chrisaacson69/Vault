---
status: active
created: 2026-11-08
discussion: folded-in
---
# Solved Games — Board Odds' Checkers, Connect 4 and Othello
> In three solved games, Board Odds measures the full ladder from principles to search to perfect play, and the ladder shows the hub page's thesis in numbers. **The best classic principle is worth a few points, search is worth tens, and perfection sits above both.** In Checkers the best tip ("control the center") scores 53.5% against a normal player, while thinking six moves ahead scores 97.5%. In Connect 4 a one-line principle player scores 80%, a four-move look-ahead 95%, and the solver never loses. In Othello the best rule (corners plus caution) wins 94.7%, yet three-move search beats that rule 91.8% of the time. All three videos say the game is solved and that real games are decided by mistakes: "decided by one loose piece". Tactics beat strategy, as in chess.

**Source:** [Board Odds — "The Best Checkers Strategy, Simulated on 300 Million Games"](../../../raw/videos/2026-10-30%20board-odds-checkers-300m-games.md) — <https://www.youtube.com/watch?v=dYJn-33fg8I> (14:46, 2026-10-30; auto-captions)
**Source:** [Board Odds — "The Best Connect 4 Strategy, Simulated on 300 Million Games"](../../../raw/videos/2026-10-29%20board-odds-connect-4-300m-games.md) — <https://www.youtube.com/watch?v=u7zgpVuP0ZY> (14:00, 2026-10-29; auto-captions)
**Source:** [Board Odds — "The Best Othello Strategy, Tested on 100 Million Games"](../../../raw/videos/2026-11-08%20board-odds-othello-100m-games.md) — <https://www.youtube.com/watch?v=wn3W1_WijjA> (15:03, 2026-11-08; auto-captions)
**Solved status:** Hiroki Takizawa, "Othello is Solved", <https://arxiv.org/abs/2310.19387> (submitted 2023-10-30): a *weak* solution of 8×8 Othello, built on the Edax engine; perfect play from both sides draws.

**Links:** [Simulation channels hub](./README.md#thesis--chess-not-chutes-and-ladders), [Battleship — 30 Billion Boards](../battleship-board-analysis.md) (another N=2 case with a computable answer), [Yahtzee — Solved](../yahtzee-solved.md), [Wordle — Solved](../wordle-solved.md)

---

## The ladder

| Player | Checkers (score vs normal) | Connect 4 (score vs family players) |
|---|---|---|
| Random | — | 8.37% |
| Worst habit | rush for kings 46.54 [9:53]; skip the "can it be jumped?" check ≈ random [0:52] | never blocks 26.16 [11:43] |
| Best classic principle | control the center 53.53 [8:48]; keep the back row 52.21 [9:10] | open in the middle 60.79 [11:57] |
| Principles combined | — | "Center" (win, block, never play under a threat, else most central safe column) **80.26** [10:15–10:51] |
| Shallow search | Greedy, 2 moves, pieces only: 55.63 [7:01] | — |
| Search | Look Ahead, 6 moves plus forced captures: **97.51** [7:17] | Look Ahead, 4 moves: **94.8**; scores 74.13 against Center [11:02–12:02] |
| Deeper search | Deep, 8 moves: ~98% vs normal; ~74% vs Look Ahead [7:36–8:01] | — |
| Perfect | not built (the 10-piece endgame database alone has ~39 trillion positions) [4:05] | solver: never lost except to itself; Look Ahead never beat it [11:21–11:36] |

Score = wins plus half of draws. The solver is checked against brute force on 12,000 positions and reproduces the published 1988 first-move solution (Allen; Allis) [1:59–2:18, 5:01].

## What the solved games show

- **Search beats principles by an order of magnitude.** The best Checkers tip adds about 3.5 points over normal, and six-move search adds about 47. Two more moves of foresight still win about 74% between two strong players. Rule two in the video is simply "look ahead at least two moves" [8:17].
- **Principles still help, and some popular ones hurt.** Centre control and the back row help. Hugging edges does nothing (49.51). Rushing for kings hurts (46.54). In Connect 4, every single-habit player except the middle opener scores below plain normal [12:07].
- **The theory shows through only as skill rises.** Checkers draws climb from 4.06% (random) to 26.59% (normal), 53.31% (Look Ahead) and about 64% (Deep), approaching the solved result that perfect play always draws [11:25–11:51]. Connect 4's first-move edge grows from about 6.5 points between normal players to 23 between look-ahead players, and to certain victory under perfect play [5:33–6:11]. The same pattern as "Seeding for Success": the more skill, the more the position decides.
- **Caution is not the same as skill.** The most drawish Checkers pair is two Greedy players (65.04%), who never give a piece away but aren't strong [11:53–12:09].
- **Real games are lost, not won.** "In real games between real people, checkers is decided by mistakes, usually one" [12:16]. Connect 4: "Most real games are not won by clever plans. They are lost by two plain mistakes" (not blocking, and playing under a threat) [1:01–1:07].

## Othello

16 habit players against a "normal" beginner (who flips the most discs), 85M games with colours alternated, then a 6-player round robin of 1M games per pair [2:50–3:08]. The simulator was checked against the published move counts to depth 8, an independent rules replay of 900 games, and a brute-force check of its endgame solver [3:11–3:57]. Normal against a copy of itself: 48.17 / 48.19, with 3.64% draws [4:00].

| Player | Win rate vs normal |
|---|---|
| Fewest flips | 31.10 [4:52] |
| Random | 37.17 [6:43] |
| Edges first | 52.18 [5:02] |
| Mobility | 62.96 [5:12] |
| Corners first | 76.26 [5:18] |
| Beginner + perfect last 10 moves | 81.26 [10:16] |
| Weighted squares | 85.68 [5:25] |
| **Corners + caution** (take corners, never play next to an empty corner) | **94.67** [0:41] |
| Three moves ahead | **97.32** [5:30] |
| Expert (three moves ahead + perfect last 10) | **99.67**, loses 0.27% [5:34] |

- **The beginner's principle barely beats random.** The player who flips the most discs still loses more than one game in three to a player moving at random. Early discs are targets, not points [6:25–6:50].
- **The best rule versus search.** Three-move search beats corners plus caution 91.76% of the time [11:12]. In the round robin: three moves ahead 82.73, expert 91.42, corners plus caution 44.82, weighted squares 40.58 [11:46–12:08].
- **Perfect play at the end can't rescue a bad middle.** A perfect last 10 moves lifts the beginner from 48 to 81, but the plain corner rule still beats it 74.30 to 21.62 [10:08–10:32]. "The middle is where games are won and lost."
- **Shallow search on a bad judgement loses.** Looking one move ahead lifts the beginner from 48 to 68.82 against normal, yet that player finished last in the round robin (13.81) [11:36–11:52]. Search multiplies the evaluation it is given. That fits Chris's correction that search does not automatically beat rules.
- **The channel concedes the thesis.** "If you are about to type that my computer players are weak, you are right." The expert would lose to real Othello programs and strong humans. The point "was never to build a champion" [13:58–14:28]. It also notes the 2023 solution: perfect play draws [12:53].

## Why this matters for the other games

These are two-player games with no dice and full information, so a perfect player exists and the gap can be measured. Minesweeper adds chance and still shows a gap (41% with good advice, 51% for the perfect-odds machine). The N≥3 games on the other pages add chance, hidden information and coalitions, so no channel can build the top rung. Their "best strategy" is the best fixed principle, and these two videos show how far below search and perfect play that rung sits even when nothing else is in the way.

## Caveats

- No perfect Checkers player; the top is 8-move search with 1,000 games per seat [5:02].
- The "normal" players are models of casual play, not data from people [14:12; Connect 4 13:10].
- The Connect 4 solver played 22,100 games; in lost positions it plays the strongest-looking move rather than proving every move loses [12:58–13:27].
- Checkers uses forced captures and an automatic 40-move draw rule; families often play without forced captures, which "would change a lot" [13:56–14:20].

- Othello's expert searches only three moves ahead and has no opening book; ties between equal moves are broken at random [14:00–14:05].

## Tags

[games](../../../tags/games.md) · [game-theory](../../../tags/game-theory.md) · [game-ai](../../../tags/game-ai.md) · [youtube](../../../tags/youtube.md)
