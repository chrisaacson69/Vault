---
source: https://www.youtube.com/watch?v=u7zgpVuP0ZY
author: Board Odds
channel: https://www.youtube.com/@BoardOdds
title: "The Best Connect 4 Strategy, Simulated on 300 Million Games"
clipped: 2026-11-08
published: 2026-10-29
type: youtube
duration: "14:00"
transcript: auto-generated captions (asr, en-orig), via yt-dlp json3
---

[0:00] Somewhere tonight, a kid drops the first
[0:02] disc of a game of Connect Four into the
[0:03] column on the far left, and a computer
[0:06] watching that game already knows how it
[0:07] ends. If both players make the best
[0:09] possible move from here on, that first
[0:11] disc is already lost. Not on the last
[0:14] move, early. The other player completes
[0:16] four in a row with their 20th disc. Of
[0:18] all seven first moves, that is the
[0:20] fastest way to lose. There is exactly
[0:22] one first move that wins by force. The
[0:25] column in the middle. Take it, never put
[0:27] a foot wrong after it, and the game is
[0:29] yours every single time.
[0:31] That is not a guess. Connect Four is a
[0:33] solved game, but nobody at that kitchen
[0:35] table plays perfectly. And against an
[0:37] ordinary player, that losing first disc
[0:40] on the edge still wins 42.46%
[0:43] of the time. So, what actually wins
[0:45] Connect Four for the rest of us?
[0:47] To find out, I built my own perfect
[0:49] player, a few imperfect ones, and a
[0:51] handful of players with one bad habit
[0:53] each. Then I made them play each other.
[0:56] 309,222,100
[0:59] games.
[1:01] What came back is surprisingly simple.
[1:03] Most real games are not won by clever
[1:05] plans. They are lost by two plain
[1:07] mistakes. And one rule, short enough to
[1:09] fit on a sticky note, wins three games
[1:11] in four against a normal player. By the
[1:14] end, you will know why the middle column
[1:16] wins, how much your first move matters
[1:18] when nobody is perfect, the hidden trap
[1:20] that quietly loses six games in 10, and
[1:22] that one-line strategy. First, the game
[1:25] itself, so we are talking about the same
[1:27] thing, the standard board. Seven
[1:29] columns, six rows. Players take turns
[1:32] dropping a disc into a column, and it
[1:34] falls to the lowest empty spot. Four in
[1:36] a row wins, across, up and down, or on a
[1:39] diagonal. If the board fills up with no
[1:41] four, it is a draw.
[1:43] Now, the perfect player. I built a
[1:45] solver for this video. It stores the
[1:47] whole board as two numbers, one for each
[1:49] player's discs, which makes it very
[1:51] fast. It searches through every reply,
[1:53] skips any branch that cannot change the
[1:55] answer, and remembers every position it
[1:57] has already worked out. How do I know it
[1:59] is right? Two ways. First, I tested it
[2:02] against plain brute force, the slow
[2:04] method that simply tries everything, on
[2:06] 12,000 random positions. They agreed
[2:09] every single time on the exact score and
[2:11] on win, draw, or loss. Second, it
[2:14] reproduces the published solution of the
[2:15] very first move, column by column. You
[2:18] will hear that answer in a minute.
[2:20] And it is not cheap. Solving one first
[2:22] move took between 99 and 369 seconds and
[2:26] up to 2.2 billion positions. Then the
[2:29] other players. Random drops its disc in
[2:31] any column. That is the floor. Normal is
[2:33] the family player. It takes a win if it
[2:35] sees one. It blocks your win. And it
[2:38] never drops a disc directly under a spot
[2:39] you need. You will see why that matters.
[2:41] Otherwise, it picks a column at random,
[2:43] leaning toward the middle. The center
[2:45] column is four times as likely as an
[2:47] edge.
[2:48] Center has the same safety rules, but no
[2:50] dice. When nothing is urgent, it always
[2:53] takes the most central safe column. Look
[2:55] ahead thinks four moves ahead and scores
[2:57] the lines that are still open. Think of
[2:59] a strong club player. And perfect uses
[3:01] the solver. It never gives away a win or
[3:03] a draw it already has. When several
[3:05] moves are equally good, it takes the
[3:06] most central one. Then six habit tests.
[3:09] Each one is the normal player with
[3:10] exactly one thing changed. One never
[3:13] blocks. One plays under threats. It
[3:15] never checks what its move gives away.
[3:17] One always opens on the edge. One always
[3:19] opens in the middle. One keeps stacking
[3:21] on its own last disc whenever that is
[3:23] safe. And one is an exact copy of the
[3:25] normal player as a fairness check.
[3:28] Every player met every other player from
[3:29] both seats. The family players played
[3:32] 3.7 million games for every pairing in
[3:34] every seat. Look ahead, 500,000. And
[3:37] perfect played 22,100
[3:40] because every perfect move has to be
[3:41] calculated, and that takes time.
[3:44] Two checks before we trust any of it.
[3:46] The copy of the normal player against
[3:48] the normal player scores 50.01%.
[3:51] A coin flip, which is exactly what it
[3:52] should be. And when two random players
[3:54] meet, the first player wins 55.56%
[3:58] in line with the usual figure for random
[4:00] play.
[4:01] One word you will hear a lot from here,
[4:03] score. Score means wins plus half of the
[4:06] draws over the same number of games
[4:08] going first and going second. 50% means
[4:11] no edge at all. So, the solved answer.
[4:14] Here is what happens with perfect play
[4:15] on both sides. For each first move, open
[4:18] in the middle column and you win. Your
[4:20] 21st disc completes four in a row. That
[4:23] is the 41st disc of the game with one
[4:25] hole left on the board. Open one column
[4:27] to either side of the middle and the
[4:29] game is a draw.
[4:31] Open two columns out and you lose to
[4:33] your opponent's 21st disc. That is the
[4:35] 42nd disc, the very last hole on the
[4:38] board.
[4:39] And open on either edge and you lose
[4:41] fastest of all to your opponent's 20th
[4:43] disc. So, the middle wins, the columns
[4:45] next to it draw, and everything further
[4:47] out loses. The further from the middle,
[4:50] the sooner. When two perfect players
[4:52] meet, the first player wins 100 games
[4:54] out of 100. And whenever the perfect
[4:56] player moved first, it won every game it
[4:59] played against every opponent.
[5:01] This is a famous result. Connect Four
[5:03] was solved in 1988 by James D. Allen and
[5:06] separately by Victor Allis. My solver
[5:09] did not look their answer up. It worked
[5:11] it out again from scratch and landed on
[5:13] the same thing. But notice the catch,
[5:15] the middle column only wins if you then
[5:17] play perfectly for the rest of the game.
[5:19] Every single move. My solver needed up
[5:22] to 2.2 billion positions to settle one
[5:24] first move. Nobody does that in their
[5:26] head. So, that is the answer for a
[5:28] computer. Now, what happens at a real
[5:30] table?
[5:31] Start with the simplest question. Does
[5:33] going first help? When two normal
[5:35] players meet, the first player wins
[5:37] 46.53%
[5:39] of games.
[5:39] >> [music]
[5:40] >> The second player wins 40.05
[5:42] and 13.42% end in a draw. So, yes, going
[5:46] first helps a little, about six and a
[5:48] half points. Even two random players
[5:50] show it. The first player wins 55.56%
[5:54] against 44.18 for the second. Now, watch
[5:57] what happens as the players get better.
[5:59] Between two look-ahead players, the club
[6:01] players, the first player wins 54.65%
[6:04] and the second only 31.31.
[6:07] That gap is more than 23 points. In a
[6:09] perfect play, going first becomes a
[6:11] certain win.
[6:13] The better both sides get, the more that
[6:15] first disc is worth. But in a normal
[6:17] family game, going first is a small head
[6:19] start, not a guarantee. The first player
[6:21] does not always win, not even close. Now
[6:24] the first move. The solved answer says
[6:26] the middle wins and the edges lose
[6:28] fastest. Does any of that survive when
[6:30] nobody plays perfectly? I took every
[6:32] game where a normal player opened
[6:34] against another normal player and sorted
[6:36] them by the column of the very first
[6:37] disc. Open in the middle and the opener
[6:40] wins 50.25%
[6:42] and loses 36.66.
[6:45] One column out, about 46% wins. Two
[6:47] columns out, about 45 and a half.
[6:50] And on the edge, the opener wins only
[6:52] 42.32%
[6:54] on one side and 42.53 on the other. And
[6:57] it loses more than that, 44.79
[7:00] and 44.55.
[7:02] Look at that again. Open on the edge and
[7:05] going first stops being an advantage.
[7:07] You become more likely to lose than to
[7:09] win against a player who has no idea the
[7:11] game is solved. The habit players tell
[7:13] the same story. A normal player who
[7:15] always opens in the middle, moving
[7:17] first, wins 50.28% against a normal
[7:20] player. One who always opens on the edge
[7:22] wins 42.46.
[7:25] And when two edge openers meet, the
[7:27] first player actually does worse than
[7:28] the second. 42.46%
[7:31] against 44.7.
[7:33] The theory says the edge opening loses.
[7:35] Even in casual play, you can see it.
[7:37] Over both seats, always opening in the
[7:39] middle wins 45.15%
[7:42] against a normal player and loses 41.6.
[7:45] One move at the very start and the game
[7:47] tilts a little your way. So does the
[7:49] middle always win? No. With perfect play
[7:52] after it, yes. At a kitchen table, it
[7:54] lifts your chance of winning from
[7:56] somewhere between 42 and 46% up to about
[7:59] 50. A small edge, but a real one from
[8:02] one disc.
[8:03] Now the two habits that decide most real
[8:05] games. Rule one, block.
[8:08] When your opponent has three in a row
[8:10] and the fourth spot is open, put your
[8:11] disc there. It sounds too obvious to say
[8:14] out loud. So, here is what happens when
[8:16] a player skips it. The player that never
[8:18] blocks loses to a normal player 85.16%
[8:21] of the time. Against all the family
[8:23] players together, its score is 26.16%.
[8:27] Of every player in this test, only the
[8:29] random one did worse. And the games are
[8:31] short. Two normal players put 28.2 discs
[8:34] on the board on average before the game
[8:36] ends. That is about 14 discs each. Two
[8:39] players that never block, 13.9 discs,
[8:43] about seven each. The game is over
[8:45] almost as soon as it starts.
[8:47] Of all the habits in this test, nothing
[8:49] costs more than this one. If you only
[8:51] remember one thing from this video,
[8:53] remember this, block. Rule two is the
[8:56] one most people have never heard of. And
[8:58] it comes from the way the discs fall. In
[9:01] Connect Four, you can only play a spot
[9:03] once the spot below it is filled. So,
[9:05] picture this. Your opponent has three in
[9:07] a row along the second row, and the spot
[9:09] they need to finish it is floating in
[9:11] the air. The spot under it is still
[9:13] empty. Right now, they cannot play it.
[9:16] Then you drop a disc into that column.
[9:18] Your disc fills the empty spot. And now
[9:20] their winning spot is sitting right on
[9:22] top of yours, ready to play. They drop
[9:24] their disc in, and that is four. You did
[9:27] not miss a threat. You built them the
[9:28] step to reach it.
[9:29] >> [music]
[9:30] >> So, rule two, never drop a disc directly
[9:32] under a spot your opponent needs. The
[9:35] normal player in this test always checks
[9:36] for that. So, I made one that does not.
[9:39] Everything else stays the same. It still
[9:41] wins when it can. It still blocks every
[9:43] three.
[9:44] It loses to a normal player 60.19% of
[9:47] the time, and wins only 32.53.
[9:50] Its overall score falls below an even 50
[9:52] to 47.44.
[9:54] A player that blocks every threat still
[9:56] ends up below even, just because it
[9:58] keeps handing over the step. So, before
[10:00] every move, ask one question. If I play
[10:03] here, which spot do I open up on top of
[10:05] my disc? If it is a spot my opponent
[10:07] needs, play somewhere else. Put those
[10:09] two rules together, add one more line,
[10:11] and you get the simplest strong strategy
[10:13] in this whole test.
[10:15] The center player. It wins if it can. It
[10:18] blocks. It never plays under a threat.
[10:20] And when nothing is urgent, it takes the
[10:22] most central column that is safe. That
[10:24] is it. No planning, no counting, one
[10:27] line. Against a normal player, over both
[10:29] seats, it wins 75.78%
[10:32] draws 9.36 and loses 14.86.
[10:36] Three games in four. When it moves
[10:38] first, it wins 83.32%
[10:41] and loses just 8.51. Even moving second,
[10:44] it wins 68.23.
[10:47] Against all the family players together,
[10:49] its score is 80.26%.
[10:51] Is it unbeatable? No. Two center players
[10:54] draw 53.88%
[10:56] of their games and fill the whole board
[10:58] 56.56%
[11:00] of the time. And two players in this
[11:02] test are better. Look ahead. The club
[11:04] player that thinks four moves ahead
[11:06] beats a normal player 96.67%
[11:09] of the time. Against center, it scores
[11:11] 74.13%.
[11:13] That is the gap between a good family
[11:15] player and a club player. Safe and
[11:17] central gets you a long way. Planning
[11:19] ahead gets you further.
[11:21] And above look ahead, perfect. Look
[11:23] ahead never beat it. Not one game.
[11:25] Against the normal player, perfect one
[11:27] virtually every game and lost none. In
[11:30] fact, apart from the games against
[11:32] itself, where one side has to lose,
[11:34] perfect never lost a game at all. Here
[11:36] is the whole ranking by score against
[11:38] the family players, from last place to
[11:40] first. Random, 8.37%.
[11:43] Never blocks, 26.16.
[11:46] Plays under threats, 47.44.
[11:49] Edge opener, 55.07.
[11:52] Stacker, 56.54.
[11:54] Normal, 57.69.
[11:57] Center opener, 60.79.
[12:00] Center, 80.26.
[12:02] Look ahead, 94.8. And perfect at
[12:05] virtually 100.
[12:07] Notice the habit of players. Every one
[12:09] of them sits below plain normal, except
[12:11] one. Opening in the middle.
[12:13] What about the habits people argue
[12:14] about? Stacking for one, building
[12:17] straight up on your own last disk
[12:19] whenever it is safe. Against a normal
[12:21] player, the stacker wins 44.99%
[12:24] and loses 47.8,
[12:26] slightly worse than not doing it, not a
[12:29] disaster. But here is a strange one.
[12:31] When two stackers meet, the first player
[12:33] wins 70.36%.
[12:36] Threats that go straight up favor
[12:37] whoever starts building first.
[12:40] So here is everything this test supports
[12:42] as five rules for your next game. Go
[12:44] first if you can and open in the middle
[12:46] column. Always block four. Never drop a
[12:48] disk directly under a spot your opponent
[12:50] needs. When nothing is urgent, play the
[12:52] most central safe column. And if you
[12:54] want to be good players, start thinking
[12:56] a few moves ahead. Now the limits.
[12:58] Honestly, the perfect player played
[13:00] 22,100 games, not millions, because
[13:03] every perfect move has to be calculated.
[13:05] The other 309.2 million games are
[13:08] between the faster players. The normal
[13:10] player is a model of a casual player,
[13:12] not data from real people. Look Ahead
[13:14] sees four moves ahead with a simple
[13:15] scoring rule and a strong human might be
[13:18] better or worse. When the perfect player
[13:20] was in a position it could not win
[13:21] against best play, it played the
[13:23] strongest looking move instead of
[13:25] proving that every move loses. And
[13:27] everything here is the standard board,
[13:29] seven columns by six rows. Back to that
[13:31] kid
[13:32] >> [music]
[13:32] >> and that first disk in the far left
[13:33] column. A computer would call that game
[13:35] lost, but the other player at the table
[13:37] is not a computer. In a real game, that
[13:39] first disk moves the odds by a few
[13:41] points. Blocking every three and never
[13:43] building the other player a step move
[13:45] them far more. The middle column is a
[13:47] head start. The two rules are what win
[13:49] the game. This lab puts a new game to
[13:51] the test in every video. If you want the
[13:53] next one, subscribe and tell me in the
[13:55] comments, when you play Connect Four, do
[13:58] you open in the middle?
