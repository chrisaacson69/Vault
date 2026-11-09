---
source: https://www.youtube.com/watch?v=dYJn-33fg8I
author: Board Odds
channel: https://www.youtube.com/@BoardOdds
title: "The Best Checkers Strategy, Simulated on 300 Million Games"
clipped: 2026-11-08
published: 2026-10-30
type: youtube
duration: "14:46"
transcript: auto-generated captions (asr, en-orig), via yt-dlp json3
---

[0:00] In 2007, after almost two decades of
[0:02] work, a team of computer scientists
[0:04] finished a proof about the game of
[0:06] checkers. The game your grandparents
[0:08] played on the porch. 12 pieces each,
[0:10] dark squares only.
[0:12] Their proof says this. If both players
[0:14] make the best possible move every single
[0:16] time, nobody wins. Ever.
[0:19] Every game of checkers played perfectly
[0:22] ends in a draw.
[0:23] Checkers is a solved game. But nobody at
[0:25] your kitchen table plays perfectly. Real
[0:28] games of checkers do not end in draws.
[0:30] Somebody wins. Somebody loses. Usually
[0:34] by a lot.
[0:35] So what actually wins checkers when
[0:37] nobody is perfect?
[0:38] To find out, I wrote my own checkers
[0:40] engine.
[0:41] I built a family player, two stronger
[0:43] players that think ahead, and a handful
[0:45] of players with one habit each. Then I
[0:47] made them play each other.
[0:49] 300 million 709,000 games. What came
[0:52] back surprised me. One single habit
[0:54] decides almost everything. A player who
[0:57] skips it does about as badly as a player
[0:59] moving completely at random. After that
[1:01] habit, thinking just a few moves ahead
[1:03] beats every classic tip you have ever
[1:04] heard. And of those classic tips, two
[1:07] help, one does nothing at all, and one,
[1:10] the one almost every kid follows,
[1:11] actually hurts.
[1:13] By the end of this video, you will know
[1:15] the one check to make before every move,
[1:17] how far ahead you really need to look,
[1:19] which of the old tips are true, whether
[1:21] going first helps, and how real games of
[1:23] checkers actually end. First, the rules,
[1:25] because checkers has a lot of house
[1:27] rules, and they change everything. I
[1:29] used the official rules of American
[1:30] checkers, also called English draughts.
[1:33] An 8 by 8 board, 12 pieces each on the
[1:35] dark squares. Dark moves first. A normal
[1:38] piece, called a man, moves one square
[1:40] diagonally forward. When it reaches the
[1:43] far side of the board, it is crowned and
[1:44] becomes a king. A king moves one square
[1:47] diagonally in any direction, forward or
[1:49] back.
[1:50] Now the three rules people forget.
[1:52] One. Captures are forced. If you can
[1:54] jump, you must jump. And if that jump
[1:57] lands you where you can jump again, you
[1:59] must keep going until the chain is
[2:00] finished. If there is more than one
[2:02] capture, you do get to choose which one.
[2:05] Two, if a man reaches the far row in the
[2:07] middle of a jump, it is crowned and its
[2:09] move ends right there. A brand new king
[2:11] does not get to keep jumping in the same
[2:13] turn. Three, a player who cannot move
[2:16] loses. Not only a player with no pieces
[2:18] left, a player whose pieces are all
[2:20] still on the board but completely
[2:22] blocked in has lost. Keep that one in
[2:24] mind. It comes back at the end.
[2:27] End rules. A game when 40 go by on each
[2:30] side with no capture and with no man
[2:32] moving, only kings. Or when the same
[2:34] position comes up three times. And as a
[2:36] safety net, any game that reaches 400
[2:39] turns is stopped and counted as a draw.
[2:41] How do I know the engine really plays by
[2:43] these rules? There is a standard test
[2:45] for that. From the starting position,
[2:47] you count every possible sequence of
[2:48] legal moves. One move deep, two moves
[2:51] deep, and so on. Those counts are
[2:53] published. If the engine gets a single
[2:55] rule wrong, its numbers drift away from
[2:57] them.
[2:58] From the start, there are seven legal
[2:59] first moves.
[3:01] 49 sequences two moves deep. 302 at
[3:04] three moves.
[3:05] And at 10 moves deep, 18,391,564.
[3:11] My engine matches the published count at
[3:13] every depth from one to 10.
[3:15] Then the players.
[3:16] Random makes any legal move. That is the
[3:18] floor. Normal is the family player and
[3:21] it is the one that matters most. If it
[3:23] can capture, it takes the capture that
[3:25] wins the most pieces. If not, it never
[3:27] leaves a piece where it can be jumped.
[3:29] It crowns a king whenever it can. Half
[3:31] the time, it picks a move that sets up a
[3:33] capture threat. When it is ahead, it
[3:35] avoids repeating positions so it does
[3:37] not throw a one game away to a draw.
[3:39] >> [music]
[3:39] >> And when only kings are left, it walks
[3:41] them toward the enemy pieces.
[3:43] Greedy looks two moves ahead, its own
[3:45] move and your answer, and it counts
[3:47] nothing but pieces. Look ahead thinks
[3:49] six moves ahead plus any forced captures
[3:51] at the end of that. And it judges a
[3:53] position by more than pieces, how far
[3:55] its men have advanced, whether its back
[3:57] row is still at home, and who holds the
[3:59] center. Think of a strong club player.
[4:02] And deep is the same player, but it sees
[4:03] eight moves ahead. There is no perfect
[4:05] player here, and that is on purpose. To
[4:08] play checkers perfectly, a computer
[4:09] needs an enormous database of finished
[4:11] end games. The team that solved the game
[4:13] built one with every position of 10
[4:15] pieces or fewer, about 39 trillion of
[4:17] them. So, the strongest players in this
[4:19] lab are the ones that think six and
[4:21] eight moves ahead.
[4:23] Then six habit tests. Each one is the
[4:25] normal player with exactly one thing
[4:27] changed. The back row keeper never moves
[4:29] a man off its own back row unless
[4:31] nothing else is safe. The rusher always
[4:33] pushes the man that is closest to being
[4:35] crowned. The edge lover prefers moves to
[4:38] the side edges of the board. The center
[4:40] lover prefers moves to the center
[4:41] squares. The careless player skips one
[4:43] check. Can the piece I just moved be
[4:45] jumped? And one is an exact copy of the
[4:48] normal player as a fairness check.
[4:50] Every player met every other player from
[4:52] both sides of the board. The fast
[4:54] players played 3.71 million games for
[4:57] every pairing and every seat. Look ahead
[4:59] played 10,000 per seat against everyone,
[5:02] and Deep played 1,000 per seat because
[5:04] every single one of its moves has to be
[5:06] calculated, eight [music] moves deep.
[5:08] 300 million, 709,000 games in all. And
[5:11] the fairness check? The copy of the
[5:13] normal player against the normal [music]
[5:15] player scores 49.98%.
[5:18] A coin flip, exactly what it should be.
[5:21] One word you will hear a lot from here,
[5:22] score. Score means wins plus half of the
[5:25] draws over the same number of games as
[5:27] black moving first and as white moving
[5:30] second. 50% means no edge. So, rule one,
[5:34] and this is the most important minute of
[5:35] the whole video. The careless player is
[5:37] identical to the normal player in every
[5:39] way. It captures the same, it crowns the
[5:42] same, it sets up the same threats. It
[5:45] makes one change only. Before it moves a
[5:47] piece, it does not check whether that
[5:49] piece can be jumped on its new square.
[5:51] That is it. One check. Against the
[5:53] normal player, the careless player wins
[5:55] 0.15% of its games. It loses 99.83%.
[6:00] Its score is 0.16%.
[6:03] Now, compare that with the random
[6:04] player, a player with no plan at all,
[6:07] which does not even try to take the most
[6:08] pieces. Against the normal player,
[6:10] random scores 0.13 percent. Skip that
[6:13] one check and you are playing at the
[6:15] level of a player who moves at random.
[6:17] In the overall ranking, it is even worse
[6:19] than that. The careless player finishes
[6:21] dead last, below random. And when the
[6:23] two of them meet head-to-head, random
[6:25] scores 62.62 percent.
[6:28] Why is one check so costly? Because of
[6:30] the forced capture rule. In checkers, a
[6:33] loose piece is a piece you might lose.
[6:35] Your opponent has to take it. And one
[6:37] loose piece can turn into a double jump,
[6:39] and a double jump can turn into a lost
[6:41] game. So, here is rule one. If you only
[6:44] remember one thing from this video,
[6:46] remember this. Before you move, look at
[6:48] the square you are moving to. Is there
[6:50] an enemy piece diagonally in front of it
[6:52] with an empty square behind you on the
[6:54] other side? If there is, you are about
[6:56] to give that piece away.
[6:58] Once your pieces are safe, what is the
[6:59] next level?
[7:01] Thinking ahead. Greedy looks just two
[7:03] moves ahead and counts only pieces.
[7:05] Against the normal player, it wins 33.19
[7:08] percent and loses 21.92 percent. Its
[7:12] score, 55.63 percent. A real edge, but a
[7:15] small one. Counting pieces is not
[7:17] enough. Now, look ahead. Six moves ahead
[7:20] and it judges the position, not just the
[7:22] pieces. Against the normal player, it
[7:24] wins 95.34 percent of its games. It
[7:27] loses 0.33 percent. That is about three
[7:31] losses in a thousand games. Its score,
[7:33] 97.51 percent.
[7:36] And deep, eight moves ahead, beats the
[7:38] normal player about 98 percent of the
[7:40] time, and it almost never loses at all.
[7:43] Does foresight still matter at that
[7:44] level? Put the two strongest players
[7:46] against each other. Deep, eight moves
[7:49] ahead, against Look Ahead, six moves
[7:51] ahead. Deep wins about 52 percent, draws
[7:54] about 44 percent, and loses only about 4
[7:57] percent. Its score, about 74 percent.
[8:01] Two extra moves of foresight. Still a
[8:03] clear edge, even between two very strong
[8:05] players.
[8:06] The overall ranking says the same.
[8:08] Against all the family players, Look
[8:10] Ahead scores 96.83%.
[8:13] The next best, Greedy, 64.56.
[8:17] So, rule two, look ahead at least two
[8:19] moves to start with. After my move, what
[8:22] can my opponent take? And after that,
[8:24] what can I take back? Every move further
[8:26] that you can see is worth more. That one
[8:28] habit is the difference between a family
[8:30] player and a club player. Now the tips.
[8:33] Every checkers player has heard them.
[8:34] Control the center. Keep your back row.
[8:37] Stay on the edges where you cannot be
[8:38] jumped. Get kings as fast as you can.
[8:41] I tested each one on its own. The normal
[8:44] player with that one tip added against
[8:46] the normal player. Nothing else changed.
[8:48] Control the center. It wins 34.8% of its
[8:51] games and loses 27.74.
[8:54] A score of 53.53%.
[8:57] The best of the classic tips. It helps.
[9:00] Why? A man in the middle of the board
[9:02] has two squares it can move to. A man on
[9:04] the side edge has only one.
[9:06] Center pieces have more choices and they
[9:08] get in the way of more enemy pieces.
[9:10] Keep your back row. It wins 33.49%
[9:13] and loses 29.06.
[9:16] A score of 52.21%.
[9:18] It helps, too. This is classic advice
[9:20] and the data backs it up. As long as
[9:22] your back row is still at home, your
[9:24] opponent's men have nowhere to land
[9:25] there and they cannot be crowned. Stay
[9:27] on the edges. It wins 28.29%
[9:30] and loses 29.26.
[9:33] A score of 49.51%.
[9:35] That is no effect at all and the tip is
[9:37] only half true. A piece on the edge
[9:39] really cannot be jumped cuz there is no
[9:41] square behind it to land on. But a piece
[9:43] on the edge also does very little. It
[9:45] reaches fewer squares and it blocks
[9:47] fewer enemy pieces. Safe, but passive.
[9:50] It does not lose you games. It does not
[9:52] win them, either.
[9:53] Rush for kings. It wins 28.75%
[9:57] and loses 35.66.
[9:59] A score of 46.54%.
[10:02] The only classic tip that hurts. The
[10:04] rusher always pushes the man closest to
[10:06] the far row. That man runs ahead alone
[10:09] far from the pieces that could protect
[10:11] it, and it leaves a gap behind it every
[10:13] time. Kings still matter, by the way.
[10:15] The normal player crowns whenever it
[10:17] can. The lesson is not to avoid kings.
[10:19] The lesson is not to sprint for them.
[10:21] And the overall ranking puts them in the
[10:23] same order. The center lover first, then
[10:26] the back row keeper, then the normal
[10:27] player, then the edge lover, and the
[10:29] rusher last.
[10:31] Next, a question every family argues
[10:33] about. Does going first help? In
[10:35] checkers, dark moves first.
[10:37] >> [music]
[10:37] >> So, does black have the edge? Between
[10:39] two normal players, no. It is the other
[10:41] way around. White, [music] the player
[10:43] moving second, wins 38.73%.
[10:46] Black, moving first, wins 34.69%.
[10:50] The other 26.59%
[10:52] are draws. So, for casual players, going
[10:54] first is not an advantage. If anything,
[10:56] the second player comes out ahead. But
[10:58] watch what happens as the players get
[11:00] better. Two look ahead players, six
[11:02] moves ahead. Black wins 30.76%,
[11:06] white only 15.93.
[11:08] Two deep players, eight moves ahead.
[11:10] Black wins about 23%. White about 13.
[11:14] Between strong players, moving first is
[11:16] worth something. Between casual players,
[11:19] it is not. The first move only helps if
[11:21] you know what to do with it. Look at
[11:23] those numbers again, and something else
[11:25] stands out, the draws. When two random
[11:27] players meet, 4.06% of games are drawn.
[11:31] Two normal players, 26.59%
[11:34] two look ahead players, 53.31%
[11:37] two deep players, about 64% careful play
[11:41] draws more, and that fits the solved
[11:43] result. If you could play every move
[11:45] without a single mistake, every game
[11:47] would be a draw. As the players in this
[11:48] lab make fewer and fewer mistakes, their
[11:51] games creep toward that.
[11:53] But it is not as simple as better
[11:54] players drawing more. The most drawish
[11:56] pair in the whole lab is two greedy
[11:58] players at 65.04%,
[12:01] and greedy is nowhere near the
[12:02] strongest. It is simply very cautious.
[12:05] It counts pieces, and it never gives one
[12:07] away for free. Put two players like that
[12:09] together, and neither one takes a risk.
[12:12] And that is the real lesson of the
[12:13] solved game. The draw only exists at the
[12:16] very top. [music] In real games between
[12:18] real people, checkers is decided by
[12:20] mistakes, usually one. The piece you
[12:22] left where it could be jumped. So, how
[12:25] do real games of checkers end? Here is a
[12:27] typical game between two normal players.
[12:29] It lasts about 162 turns. That is about
[12:32] 81 moves each. And along the way, almost
[12:35] seven kings get crowned. In 56.43%
[12:38] of games, one side loses every single
[12:41] piece. In 16.99%
[12:44] one side still has pieces on the board,
[12:46] but cannot move. Blocked in, lost.
[12:49] Remember that rule from the start.
[12:51] Almost one game in six ends that way. If
[12:53] your family forgets that rule, you have
[12:55] been missing one of the most common ways
[12:56] to win.
[12:58] 13.17%
[12:59] end in a draw by the 40-move rule.
[13:01] 11.92% by the same position coming up
[13:04] three times. And 1.5% run all the way to
[13:07] the 400-turn limit. When somebody wins,
[13:10] it is usually not close. On average, the
[13:13] winner finishes with 7.74 pieces still
[13:15] on the board, out of 12. Casual games of
[13:18] checkers are often lopsided. One mistake
[13:20] early and the rest of the game is the
[13:22] winner cleaning up. So, here is
[13:24] everything this lab found in six rules.
[13:27] One, before every move, check whether
[13:29] the piece can be jumped on its new
[13:31] square. Skip that and you play no better
[13:33] than a random player. Two, look at least
[13:35] two moves ahead. What can your opponent
[13:37] take after your move? Three, control the
[13:40] center. Four, keep your back row as long
[13:43] as you safely can. Five, do not rush
[13:45] your men forward just to get kings. Six,
[13:48] the edges are safe, but passive. They
[13:50] will not lose you the game. They will
[13:52] not win it for you either. And a few
[13:54] honest limits. I use the official rules
[13:56] of American checkers. Many families play
[13:58] without forced captures. I did not test
[14:00] that and it would change a lot. There is
[14:02] no perfect player in this lab. The
[14:04] strongest players think six and eight
[14:05] moves ahead and they played 20,000 and
[14:07] 2,000 games preparing because every one
[14:10] of their moves has to be calculated. The
[14:12] normal player is my model of a casual
[14:13] player, not data from real people. And
[14:16] the draw rules were applied
[14:17] automatically. At a real table, families
[14:20] often just play on or agree on a draw.
[14:22] Checkers is solved. With perfect play,
[14:24] nobody wins. But you are not playing a
[14:26] perfect player. You are playing your
[14:28] brother, your grandmother, your friend
[14:30] across the table. And against them, the
[14:32] game is not decided by a brilliant plan.
[14:35] It is decided by one loose piece. So
[14:37] before your next move, look at the
[14:38] square. Can anything jump you there? And
[14:41] tell me in the comments. In your family,
[14:43] are captures forced or optional?
