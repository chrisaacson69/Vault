---
source: https://www.youtube.com/watch?v=wn3W1_WijjA
author: Board Odds
channel: https://www.youtube.com/@BoardOdds
title: "The Best Othello Strategy, Tested on 100 Million Games"
clipped: 2026-11-08
published: 2026-11-08
type: youtube
duration: "15:02"
transcript: auto-generated captions (asr, en-orig), via yt-dlp json3
---

[0:00] Everybody at the table has an Athell
[0:01] strategy. Your uncle flips as many discs
[0:04] as he can on every single turn because
[0:06] more discs feels like winning. Your
[0:08] sister runs for the edges because edges
[0:10] feel safe. Somebody keeps all their
[0:12] discs bunched tightly together. Somebody
[0:15] else tries to leave you with as few
[0:16] moves as possible. And there is always
[0:18] one person who goes straight for the
[0:20] corners and talks about it all night.
[0:22] You know who you are. So, I turned 16
[0:24] habits like these into computer players
[0:26] and made them play 100 million games.
[0:29] Here is the headline. The habit almost
[0:32] every beginner has flipping the most
[0:34] discs, loses more than one game in three
[0:37] to a player that moves completely at
[0:38] random. Then one simple rule, take the
[0:41] corners and stay away from the squares
[0:43] next to an empty corner beats that same
[0:45] beginner 94.67%
[0:48] of the time. That is about 24 wins for
[0:50] every loss. But that is not the end of
[0:53] the story. A player that does nothing
[0:55] clever except look three moves ahead
[0:57] beats the corner rule 91.76%
[1:00] of the time. And the best player I built
[1:03] beats the beginner in 99.67%
[1:05] of its games. So what do those players
[1:08] know that the rest of us do not? It is
[1:10] not a secret opening. It is a short list
[1:12] of ideas and you have probably ignored
[1:14] at least one of them. First, a quick
[1:16] word about how I built the game. I used
[1:18] the standard 8x8 board with the standard
[1:21] starting position. Black moves first. A
[1:23] move must outflank at least one line of
[1:25] opposing discs, which means your discs
[1:28] sit at both ends of the line, and every
[1:30] disc between them flips to your color.
[1:32] If you have no legal move, you pass. The
[1:34] game ends when neither player can move,
[1:36] and whoever has more discs wins. Any
[1:39] empty squares at the end go to the
[1:40] winner. Now, the players, my yard stick
[1:43] is a player I call normal. Normal always
[1:46] plays the move that flips the most
[1:48] discs. That is the classic beginner
[1:50] instinct and it is the player everyone
[1:52] else has to beat. Every other player is
[1:54] built around one idea. Random picks any
[1:56] legal move. Fewest flips does the
[1:58] opposite of normal and flips as little
[2:00] as it can. Edges first likes the squares
[2:03] along the border. Corners first takes a
[2:05] corner whenever one is available. Then
[2:07] there is the rule I just described which
[2:09] I will call corners plus caution. Take
[2:11] the corners and never play next to an
[2:13] empty corner. Another player flips the
[2:15] most discs, but never plays the diagonal
[2:17] squares beside a corner. Mobility tries
[2:19] to have as many moves as possible while
[2:21] leaving you as few as possible. Another
[2:23] one only tries to leave you the fewest
[2:25] moves. Another keeps the fewest frontier
[2:27] discs, which are the discs that touch
[2:28] empty squares. A classic weighted square
[2:31] player gives every square on the board a
[2:33] score and picks the highest. One player
[2:35] flips the most discs, but looks at your
[2:36] reply first. One flips the most discs
[2:39] and then plays the last 10 moves
[2:41] perfectly. One searches three moves
[2:43] ahead and the expert searches three
[2:45] moves ahead and plays perfectly once 10
[2:47] squares are empty. Here is the scale. In
[2:50] the first test, every player played
[2:52] against normal, 85 million games in all,
[2:55] and the colors alternated so that every
[2:56] player took black and white equally
[2:58] often. In the second test, the six
[3:00] strongest players played around Robin. 1
[3:03] million games for every pair, 15 million
[3:05] games in all. 85 million plus 15 million
[3:08] is 100 million. Before I believe any
[3:11] result, I need to know the simulator is
[3:13] honest. So I checked it first. I counted
[3:15] every possible sequence of moves from
[3:17] the starting position, one move deep,
[3:20] two deep, and so on up to 8 deep. The
[3:22] counts were 4, 12, 56, 244, 1,396,
[3:29] 8,2,
[3:30] 55,92,
[3:32] and 390,216.
[3:35] Those match the published counts
[3:37] exactly. Second, a separate version of
[3:40] the rules written as a different program
[3:42] replayed 900 games move by move. Errors
[3:45] zero. [snorts]
[3:46] Third, the simple players always chose a
[3:49] move their own rule allows and the
[3:51] perfect ending solver gave the same
[3:52] answers as a slow plain method that
[3:55] checks every possibility on 60
[3:57] positions. Fourth, a control. A copy of
[4:00] normal won 48.17%
[4:03] lost 48.19 and drew 3.64. That is what
[4:07] two identical players must give. So the
[4:10] number to beat is about 48%. It is not
[4:13] 50 because some games end in a draw. Any
[4:15] player that wins more than that is a
[4:17] real improvement over the beginner and
[4:19] any player under it is a real mistake.
[4:21] One more thing, planted now because it
[4:23] matters at the end. These are simple
[4:25] computer players with shallow search.
[4:27] They have no opening book and when two
[4:29] moves look equal, they pick one at
[4:31] random. Even the expert is strong only
[4:33] compared with the other players here.
[4:35] real fellow programs and strong human
[4:37] players would beat it. So these rankings
[4:39] show which ideas matter. They do not
[4:41] show how a champion plays. Enough setup.
[4:44] Here is what happened. This is the
[4:46] leaderboard against normal from the
[4:48] bottom. Normal itself wins 48.16%.
[4:52] Fewest flips wins 31.10%.
[4:55] Random 37.17.
[4:57] Fewest Frontier discs 42.73.
[5:00] Then normal in the middle of the pack.
[5:02] Edges first 52.18. leaving the opponent
[5:05] the fewest moves 60.84. Flipping the
[5:08] most while avoiding the diagonal squares
[5:10] 62.45.
[5:12] Mobility 62.96.
[5:15] The beginner that looks at your reply
[5:17] 68.82. [music]
[5:18] Corners first 76.26.
[5:21] The beginner with a perfect ending
[5:23] 81.26.
[5:25] Weighted squares 85.68. [music] Corners
[5:28] plus caution 94.67.
[5:30] Thinking three moves ahead 97.32.
[5:34] And at the very top, the expert, 99.67%.
[5:38] It loses only 0.27% of its games and
[5:42] wins by an average of 43.1 discs. Look
[5:44] at the bottom of that list. Random play
[5:47] and three habits about how many discs
[5:49] you flip or own. Now look at the top
[5:51] corners, options, and looking ahead. So
[5:54] the story is about what a disc is worth,
[5:56] not how many you have. The average
[5:57] margins tell the same story. Remember,
[6:00] normal sits at zero because it is the
[6:02] yard stick. Corners plus caution wins by
[6:04] 22.3 discs a game. Weighted squares
[6:08] 17.0. The beginner with a perfect ending
[6:10] 19.1. Mobility 7.6. And at the bottom,
[6:15] random loses by 7.7. And fewest flips
[6:18] loses by 14.3. A win rate tells you how
[6:21] often a habit wins. The margin tells you
[6:23] how comfortably Let me start with the
[6:25] beginner. Why does flipping the most
[6:27] discs lose? Because in a fellow, discs
[6:29] are not points until the very end. Early
[6:32] on, they are targets. Every disc you own
[6:34] is one your opponent might flip back.
[6:36] The more discs you hold, the more places
[6:38] your opponent can play, and the fewer
[6:40] moves you tend to have later. You can
[6:42] see it in the numbers. A player that
[6:43] moves at random still wins 37.17%
[6:46] of its games against normal. That is
[6:49] more than one game in three from a
[6:50] player with no idea at all. Put [music]
[6:52] the other way, normal beats random in
[6:54] only about 59 games in 100. So, this is
[6:57] not a small flaw. The most natural
[6:59] instinct in the game loses more than one
[7:01] game in three to a player with no plan
[7:03] at all. And remember where it sits on
[7:05] the list. Most of the other players beat
[7:07] it, some by a mile. Which brings up a
[7:10] bigger question. If more discs is the
[7:12] wrong target, what is the right one? The
[7:14] answer starts with four squares. [music]
[7:16] A disc on a corner can never be flipped.
[7:18] To flip a disc, your opponent needs
[7:20] discs on both sides of it along the
[7:22] line. And a corner has nothing on one
[7:24] side. Once you own a corner, it is yours
[7:26] until the last move. It also gives you
[7:28] something to build on. Discs along the
[7:30] edge next to your corner are much harder
[7:32] for your opponent to attack because one
[7:33] end of every line is already anchored by
[7:35] a disc that cannot move. Corners first.
[7:38] The player that takes a corner whenever
[7:40] it can wins 76.26%
[7:42] against normal and wins by an average of
[7:45] 13.2 discs. That is a huge jump from 48.
[7:48] But the bigger secret is the squares
[7:50] next to the corners. If you play next to
[7:52] a corner that is still empty, you often
[7:54] hand your opponent the way in. So, I
[7:56] added one rule. Never play next to an
[7:58] empty corner. Corners first plus that
[8:00] single rule of caution wins 94.67%
[8:04] of its games. It loses only 3.97. That
[8:07] is about 24 wins for every loss and an
[8:09] average margin of 22.3 discs. The two
[8:13] halves need each other. Avoiding only
[8:15] the diagonal squares beside the corners
[8:17] without caring about the corners wins
[8:19] 62.45.
[8:21] Taking corners alone wins 76. Do both
[8:24] and you get 94. It is not a trick. It is
[8:27] two simple habits that fit together. Now
[8:29] a second question. If counting discs is
[8:31] wrong, what about counting moves? In a
[8:34] you cannot skip a turn when you have a
[8:36] legal move. You must play one. So a
[8:38] player with only bad moves left has to
[8:40] play a bad move. [music] And a player
[8:42] with plenty of choices does not.
[8:44] Mobility is the idea of keeping your
[8:45] options open. As many moves as possible
[8:48] for you and as few as possible for your
[8:50] opponent. It wins 62.96%.
[8:53] A player that only tries to leave you
[8:55] the fewest moves wins 60.84. Those are
[8:58] real gains over the beginner and they
[9:00] are far from the corner rules. Options
[9:02] matter. Corners matter more. Now the
[9:05] famous tips because every player has
[9:07] heard a few. Take the edges. Edges first
[9:09] wins 52.18%
[9:12] against 48.16 for the beginner. That is
[9:14] a nudge. If you take one thing from
[9:16] this, it is that grabbing the border is
[9:18] not the answer. Keep your discs tucked
[9:20] in and give the opponent nothing to hit.
[9:22] A player that keeps the fewest frontier
[9:24] discs, those touching empty squares,
[9:26] wins 42.73.
[9:28] That is worse than normal. It even wins
[9:30] slightly more games than random, but it
[9:32] loses by more discs behind by 9.9 on
[9:35] average against 7.7 for random. Now
[9:38] careful, stronger programs do use
[9:41] frontier discs as one piece of a much
[9:43] bigger judgment. All this says is that
[9:46] as a single rule, it lost. And finally,
[9:49] the quiet game. If flipping a lot is
[9:51] bad, surely flipping as little as
[9:53] possible is good. No. Fewest flips wins
[9:56] 31.10%.
[9:57] The worst of all the players tested. And
[10:00] it loses by 14.3 discs on average. The
[10:03] opposite of a bad idea is not
[10:04] automatically a good one. Now, the thing
[10:06] that sounds like it should fix
[10:08] everything. A perfect ending. With 10
[10:10] squares left, a computer can check every
[10:12] way the game can finish and pick the
[10:14] best. Give that to the beginner and it
[10:16] jumps from 48 to 81.26%
[10:19] against normal. That is a big
[10:21] improvement. So I sat it down against
[10:23] the simple corner rule. Result, the
[10:25] corner rule wins 74.30
[10:28] and the beginner with a perfect ending
[10:30] wins 21.62.
[10:32] I tried it against weighted squares.
[10:34] Weighted squares wins 66.82,
[10:36] the perfect ending 29.29.
[10:39] So a perfect ending cannot save a bad
[10:41] game. By the time only 10 squares are
[10:43] left, the damage has often been done
[10:45] already. The middle is where games are
[10:46] won and lost. That raises the next
[10:48] question. If the rules about corners are
[10:50] so good, is there anything better? There
[10:53] is. Instead of following a rule, you
[10:55] look. A player that thinks three moves
[10:58] ahead that checks its move, your reply,
[11:00] and its answer wins 97.32%
[11:04] against normal with an average margin of
[11:06] 27.8 discs. The corner rule was already
[11:10] very good, but look at the head-to-head.
[11:12] Thinking three moves ahead beats the
[11:14] corner rule 91.76
[11:16] to 7.06.
[11:18] It beats weighted squares 97.34 to 2.45.
[11:23] Why? A fixed rule is a guess about what
[11:25] will be good. Looking ahead checks what
[11:27] actually happens. If a rule tells you to
[11:29] take a square and the reply wrecks you,
[11:31] the rule does not notice. The search
[11:33] does. Do not take the wrong lesson from
[11:36] this though. Looking just one move ahead
[11:38] helped the beginner from 48 to 68.82.
[11:42] But in the round robin, that player
[11:43] finished last. Here is the round robin
[11:46] of the six strongest where each score is
[11:48] the share of the available points a
[11:49] player took in its own games. Most flips
[11:52] with a look at the reply 13.81.
[11:55] Most flips with a perfect ending 26.65.
[11:59] Weighted squares 40.58. Corners plus
[12:02] caution 44.82.
[12:05] thinking three moves ahead, 82.73,
[12:08] and the expert 91.42.
[12:11] It searches three moves ahead and plays
[12:13] the last 10 moves perfectly. That one
[12:15] addition is worth a lot. Against the
[12:17] three move player, the expert wins 61.41
[12:20] and loses 37.67.
[12:23] But do not call the expert perfect. It
[12:25] is not unbeatable. It plays perfectly at
[12:27] the end. And only that, it is the best
[12:29] player in this test and nothing more
[12:31] than that. Now, one more question people
[12:34] always ask. Does it matter who goes
[12:36] first? When normal plays normal, black,
[12:38] the player who moves first, wins 49.15%
[12:42] of its games. White wins 47.19.
[12:45] The rest are draws 3.64%.
[12:48] So, for these players, going first was
[12:50] worth about two points. Not nothing, not
[12:53] a lot. In the real game, in 2023, Athell
[12:56] was reported solved. With perfect play
[12:58] from both sides, the game is a draw.
[13:00] That does not mean your game night will
[13:02] end in a tie. People do not play
[13:04] perfectly. This video is about which
[13:06] ideas help normal players. So, what do
[13:08] you do with all this? Here are five
[13:10] rules the data supports. One, do not
[13:13] flip as many discs as you can early on.
[13:15] Early discs are targets and random play
[13:17] took more than one game and three from
[13:19] the player who did. Two, take corners
[13:22] whenever you can. A corner disc cannot
[13:24] be flipped. Three, never play next to an
[13:26] empty corner. That one rule added to
[13:29] taking corners move the win rate from 76
[13:31] to 94. Four, keep your options open.
[13:34] More moves for you, fewer for your
[13:36] opponent. It is worth 12 to 15 points
[13:39] over the beginner, and it will not beat
[13:40] the corner rules. So, do not trade a
[13:42] corner for it. Five, before every move,
[13:45] look at your opponent's best reply. Even
[13:48] the beginner gained from this, and the
[13:49] player that looked three moves ahead
[13:51] beat the best fixed rules it faced. Try
[13:53] them at your next game night and see who
[13:55] notices first. Now the limits because
[13:58] they matter. These are computer players
[14:00] with simple rules and shallow search.
[14:02] They have no opening book and ties
[14:04] between equal moves are broken at
[14:05] random. The expert is strong only
[14:07] compared with the other players here.
[14:09] Real Athell programs and strong human
[14:11] players would beat it. So do not read
[14:13] these rankings as a lesson in how
[14:15] champions play. They show which ideas
[14:17] matter and how much. If you are about to
[14:19] type that my computer players are weak,
[14:21] you are right. And I said so at the
[14:23] start. The point was never to build a
[14:25] champion. It was to put popular ideas on
[14:28] the same board against the same opponent
[14:30] and see which ones hold up. And if you
[14:32] are wondering whether the simulator
[14:33] itself can be trusted, go back to the
[14:35] checks. The move counts match the
[14:38] published ones exactly and a second
[14:40] program replayed 900 games without a
[14:42] single error. And the biggest limit of
[14:44] all, a computer player does not get
[14:46] nervous. It does not hesitate in front
[14:48] of a corner or talk itself into one more
[14:50] flip because it feels good. The relative
[14:52] at your table does all of that. that
[14:54] half of the game. No simulation of mine
[14:56] can change and it is still up to you.
