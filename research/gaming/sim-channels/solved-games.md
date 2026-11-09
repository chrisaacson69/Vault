---
status: active
created: 2026-11-08
discussion: folded-in
---
# Solved Games — Board Odds' Checkers and Connect 4
> In the two solved games, Board Odds measures the full ladder from principles to search to perfect play, and the ladder shows the hub page's thesis in numbers. **The best classic principle is worth a few points, search is worth tens, and perfection sits above both.** In Checkers the best tip ("control the center") scores 53.5% against a normal player, while thinking six moves ahead scores 97.5%. In Connect 4 a one-line principle player scores 80%, a four-move look-ahead 95%, and the solver never loses. Both videos say outright that the game is solved and that real games are decided by mistakes: "decided by one loose piece". Tactics beat strategy, as in chess.

**Source:** [Board Odds — "The Best Checkers Strategy, Simulated on 300 Million Games"](../../../raw/videos/2026-10-30%20board-odds-checkers-300m-games.md) — <https://www.youtube.com/watch?v=dYJn-33fg8I> (14:46, 2026-10-30; auto-captions)
**Source:** [Board Odds — "The Best Connect 4 Strategy, Simulated on 300 Million Games"](../../../raw/videos/2026-10-29%20board-odds-connect-4-300m-games.md) — <https://www.youtube.com/watch?v=u7zgpVuP0ZY> (14:00, 2026-10-29; auto-captions)

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

## Why this matters for the other games

These are two-player games with no dice and full information, so a perfect player exists and the gap can be measured. Minesweeper adds chance and still shows a gap (41% with good advice, 51% for the perfect-odds machine). The N≥3 games on the other pages add chance, hidden information and coalitions, so no channel can build the top rung. Their "best strategy" is the best fixed principle, and these two videos show how far below search and perfect play that rung sits even when nothing else is in the way.

## Caveats

- No perfect Checkers player; the top is 8-move search with 1,000 games per seat [5:02].
- The "normal" players are models of casual play, not data from people [14:12; Connect 4 13:10].
- The Connect 4 solver played 22,100 games; in lost positions it plays the strongest-looking move rather than proving every move loses [12:58–13:27].
- Checkers uses forced captures and an automatic 40-move draw rule; families often play without forced captures, which "would change a lot" [13:56–14:20].

## Tags

[games](../../../tags/games.md) · [game-theory](../../../tags/game-theory.md) · [game-ai](../../../tags/game-ai.md) · [youtube](../../../tags/youtube.md)
