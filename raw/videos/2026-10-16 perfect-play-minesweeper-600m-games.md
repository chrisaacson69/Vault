---
source: https://www.youtube.com/watch?v=NXHu0n9Ezco
author: Perfect Play
channel: https://www.youtube.com/@PerfectPlaySim
title: "The Best Minesweeper Strategy, Tested on 600 Million Games"
clipped: 2026-11-08
published: 2026-10-16
type: youtube
duration: "8:23"
transcript: auto-generated captions (asr, en-orig), via yt-dlp json3
---

[0:00] Everybody who's played Minesweeper has a
[0:01] theory.
[0:02] >> [music]
[0:02] >> Always start in the corner. When you're
[0:04] stuck, click right next to the numbers.
[0:06] Or just close your eyes, click anywhere,
[0:09] and hope. So, I turned those habits into
[0:11] players and made them play the same
[0:13] expert boards, more than 600 million
[0:15] games in total. The best habit won 39%
[0:18] of its games.
[0:19] >> [music]
[0:19] >> The worst one won two. And always start
[0:22] in the corner? On the modern versions,
[0:24] it actually makes you lose more. By the
[0:26] end of this video, you'll know exactly
[0:28] where to click [music] when you're stuck
[0:29] and how close a person can get to a
[0:31] computer that never misses a thing.
[0:34] Quick refresher for anyone who's only
[0:36] ever opened Minesweeper by accident.
[0:38] Every number tells you how many mines
[0:40] touch that square, diagonals included.
[0:42] Open every square that isn't a mine and
[0:44] you win.
[0:45] >> [music]
[0:45] >> Click a mine and well, you don't. I'm
[0:48] using the standard expert board, [music]
[0:50] 30 by 16 with 99 mines. That's about one
[0:53] mine in every five squares.
[0:55] >> [music]
[0:55] >> And I'm using the modern rule where your
[0:56] first click always opens up an area,
[0:59] which is how a lot of versions work
[1:00] today.
[1:00] >> [music]
[1:01] >> To make sure I could trust my program, I
[1:03] built a player that works out the exact
[1:04] odds of every square and I compared it
[1:07] with a paper from 2017 that tested the
[1:09] same kind of player. The paper says it
[1:11] wins 35.56% [music]
[1:13] of classic expert games. Mine says
[1:16] 35.58. [music]
[1:18] I'll take it. And one thing my players
[1:20] don't care about is speed. Nobody here
[1:22] is chasing a world record. They only
[1:24] care about winning.
[1:26] So, meet the players. This one is the
[1:29] regular and it's my normal player. So,
[1:31] pay attention because every other player
[1:33] is the regular with one thing [music]
[1:35] changed. The regular knows the two basic
[1:37] rules. If a number already touches as
[1:39] many flags as it shows, every other
[1:41] square around it is safe. And if a
[1:43] number needs as many mines as it has
[1:45] covered squares, they're all mines.
[1:47] [music] It also knows the classic
[1:49] patterns like the 1 1 and the 1 2 1
[1:51] where two numbers side by side give away
[1:53] a square that neither of them could on
[1:55] its own.
[1:55] >> [music]
[1:56] >> When it gets stuck, it clicks a square
[1:58] right next to the numbers, and its first
[2:00] click goes in the middle of the board.
[2:01] The rookie is the regular without the
[2:03] patterns, [music] just the two basic
[2:05] rules. The corner starter opens every
[2:07] game in a corner, because that's the tip
[2:09] you've probably [music] heard. The
[2:11] explorer, when it's stuck, walks away
[2:13] from the numbers and clicks somewhere
[2:15] out in the open. The counter watches the
[2:17] mine counter, and once there are three
[2:19] mines left or fewer, it uses that number
[2:21] to work out the rest of the board. And
[2:23] the odds player does a little math
[2:25] before every guess. I'll show you
[2:26] exactly what it does, because it's the
[2:28] most useful thing in this video. Then
[2:30] there's [music] the machine. It isn't a
[2:32] person. It never misses a deduction, and
[2:34] it knows the exact odds of every single
[2:36] square. It's here to show us the
[2:38] ceiling.
[2:40] Every player got 10 million expert
[2:42] games, [music] and players with the same
[2:43] first click got exactly the same boards.
[2:46] Starting from the bottom, the rookie won
[2:48] less than 2% of its games. The corner
[2:51] starter won 23. [music]
[2:52] The regular, 29. The counter won 32,
[2:56] with the explorer just ahead at 33.
[2:58] [music]
[2:59] And in first place by a mile, the odds
[3:02] player with 39%.
[3:04] The machine won 51.
[3:06] So even with perfect logic and perfect
[3:08] odds, expert [music] beats you about
[3:10] half the time. But a ranking doesn't
[3:12] tell you why. So let's go through the
[3:14] mistakes one at a time, [music] always
[3:16] against the regular and its 29%.
[3:19] Mistake number one is thinking the two
[3:21] basic rules are enough. The rookie knows
[3:24] only those, and it won less than 2% of
[3:26] expert games. The regular, with a couple
[3:29] of patterns on top, won 29. [music]
[3:31] That's 15 times as many wins from
[3:34] something you can learn in an afternoon.
[3:36] Here's why. When the basic rules run
[3:39] dry, the rookie guesses, [music]
[3:40] and 96% of its guesses weren't
[3:42] necessary. There was a square it could
[3:44] have proven safe. It just didn't know
[3:46] where to look. Take a one, a two, and a
[3:49] one in a row against a wall of covered
[3:51] squares. The mines are right above the
[3:53] two ones, [music] and the square above
[3:55] the two is safe. Once you've seen it a
[3:57] few times, you'll spot it everywhere.
[4:00] Even the regular leave some on the
[4:01] table, [music] though. 28% of its
[4:03] guesses weren't necessary, either. Keep
[4:05] that in mind, because it comes back
[4:06] [music] at the end.
[4:08] Mistake number two is the one almost
[4:10] everybody makes. When you're stuck, you
[4:12] click right next to the numbers, because
[4:14] that's where you've been looking. The
[4:16] regular's guesses hit a mine 40% [music]
[4:18] of the time. That's two clicks in five.
[4:21] Next to the numbers is where the
[4:22] information is, but it's also where the
[4:24] mines are packed together. The explorer
[4:26] clicks out in the open instead, and its
[4:28] guesses hit a mine only 24% of the time.
[4:31] That alone took it from 29% to 33. If it
[4:34] also goes for the corners and edges out
[4:36] there, the square is most likely to open
[4:38] up a new area, it gets to 36. And the
[4:41] odds player [music] gets to 39. Here's
[4:43] its rule, and you can do it in your
[4:44] head. Next to a number, the chance of a
[4:47] mine is what that number still needs
[4:49] divided by the covered squares it
[4:50] touches.
[4:51] >> [music]
[4:51] >> So, a one touching four covered squares
[4:53] is one in four. Anywhere else, the
[4:56] chance is the mines left on the counter
[4:57] divided by the covered squares left.
[5:00] Click whichever is lower.
[5:01] >> [music]
[5:01] >> And if there's a tie, pick the square
[5:03] touching the fewest covered squares,
[5:04] like a corner. That rule only finds the
[5:07] exact best square about a quarter of the
[5:09] time, [music]
[5:09] but its guesses hit a mine about one
[5:11] time in five, which is half as often as
[5:13] the regulars. Apart from learning the
[5:15] patterns, no single habit I tested
[5:17] helped more. [music] 10 points.
[5:20] Mistake number three is the most famous
[5:22] tip of all. Start in the corner. The
[5:25] corner starter won 23%. The regular, who
[5:28] just clicks the middle, won 29. [music]
[5:31] The corner cost it six points. The
[5:33] reason is that a corner only has three
[5:35] neighbors. With the modern rule, your
[5:37] first click always opens an area, and
[5:39] the corner gives you the smallest one.
[5:42] So, I tried every square on the board.
[5:44] The best first click is three squares in
[5:46] from a corner along the diagonal.
[5:48] >> [music]
[5:48] >> It beats the middle by about a point.
[5:50] It's small, but it's free.
[5:53] >> [music]
[5:53] >> Hey guys, Leo from the future here.
[5:55] Quick note on that one. If you're
[5:57] playing an old version, like the one
[5:58] that came [music] with Windows XP, your
[6:00] first click is only guaranteed not to be
[6:02] a mine, and a lot of the time it doesn't
[6:04] open anything. On that version, the
[6:06] corner tip is actually right. It's the
[6:08] best [music] first click by three or
[6:10] four points. Okay, back to the video.
[6:13] Mistake number four is forgetting the
[6:15] mine counter.
[6:16] >> [music]
[6:16] >> That number in the corner of the screen
[6:18] isn't decoration. Near the end of a
[6:20] game, it's often the last clue [music]
[6:22] you've got. If the counter says two
[6:24] mines are left, and these numbers
[6:26] already need both of them, then every
[6:28] other covered square is safe, [music]
[6:30] even the ones no number touches. The
[6:32] counter only does this once there are
[6:34] three mines left or fewer, and that
[6:36] alone took it from 29% to 32. Start
[6:39] counting with [music] six mines left,
[6:41] and it's 33 and a half.
[6:43] So, what happens when you fix everything
[6:45] at once? My tuned player knows the
[6:48] patterns,
[6:48] >> [music]
[6:48] >> guesses with the odds player's rule,
[6:50] counts the mines at the end, and opens
[6:52] three squares in from a corner. On
[6:54] expert, it wins 41% of its games. On
[6:57] intermediate, 87. And on beginner,
[7:00] almost 97, which is the same as the
[7:02] machine. On beginner, a handful of
[7:05] habits play as well as a computer. On
[7:07] expert though, the machine is still
[7:09] almost 10 points ahead. So, I checked
[7:11] where that gap comes from. I gave my
[7:13] tuned player the machine's perfect
[7:15] logic, the kind [music] that finds those
[7:17] safe squares the regular kept missing.
[7:19] But I left it with its rule of thumb for
[7:20] guessing. It went from 41% to 45. The
[7:24] other six points come from guessing with
[7:26] the exact odds instead of the rule of
[7:28] thumb. In other words, the [music]
[7:30] computer's edge isn't really that it
[7:31] sees more. It's that it guesses better.
[7:34] And even the machine needs luck. 84% of
[7:37] its expert games need at least one
[7:39] guess, [music] and it still loses about
[7:40] half of all its games. Expert isn't a
[7:43] puzzle you can always solve. It's a
[7:45] puzzle with a few blind clicks [music]
[7:47] built in.
[7:48] So, here's what 600 million games have
[7:50] to say about your next one. Learn the 11
[7:53] and the 121. Open three squares in from
[7:56] a corner, not in the corner itself.
[7:58] >> [music]
[7:58] >> When you're stuck, don't poke next to
[8:00] the numbers. Compare each number divided
[8:03] by its covered squares with the mines
[8:05] left divided by the squares left and
[8:07] click [music] the lowest. And near the
[8:08] end, look at the counter. Do all that
[8:11] and you'll win about four expert games
[8:13] in 10. The machine wins five. The rest
[8:15] is up to luck. That was Minesweeper.
[8:18] Tell me in the comments which game I
[8:19] should run next.
