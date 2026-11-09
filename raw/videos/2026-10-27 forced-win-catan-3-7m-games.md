---
source: https://www.youtube.com/watch?v=_3h9RjWUyts
author: Forced Win
channel: https://www.youtube.com/@forcedwingames
title: "The Best Catan Strategy, Tested on 3.7 Million Games"
clipped: 2026-11-08
published: 2026-10-27
type: youtube
duration: "11:02"
transcript: creator-uploaded captions, via yt-dlp json3
---

[0:00] If you build a road every chance you get, chasing Longest Road, you win Catan
[0:05] 3.5% of the time.
[0:07] I know, because I made a computer play exactly like that 350,000 times.
[0:14] Everybody at the Catan table has a strategy.
[0:17] The road builder. The one hoarding cards just in case.
[0:20] The one who trades with everybody, and the one who won't trade with anyone.
[0:25] So I turned eight of those strategies into computer players and ran 3.7 million
[0:30] games of Catan. The best one won 33% of its games.
[0:35] Then I brought in an AI, the strongest bot in the open-source Catan engine
[0:40] I used. It plays like none of them.
[0:43] It has five habits, and one of them, on its own, takes a normal player from
[0:48] 25% to 38%.
[0:49] I'd bet you break at least two of those habits every game.
[0:53] And at the end, I'll show you a simple player built on those habits beating
[0:57] the AI at its own game.
[1:00] Quickly, the setup. Base-game rules, four players, ten points to win, and
[1:04] a fresh random board every single game.
[1:07] When anyone rolls a seven, every player holding more than seven cards loses
[1:12] half of them. Longest Road needs five roads, Largest Army three knights.
[1:17] The engine is catanatron, an open-source Catan simulator by Bryan Collazo.
[1:20] Every result has a little luck in it, so when two numbers are too close to
[1:26] call, I'll say so.
[1:27] One thing my players can't do is negotiate.
[1:30] Their only deal is a simple one-for-one swap.
[1:34] Remember that. It matters at the end.
[1:37] So, meet the players.
[1:40] The Builder is the normal one. It settles on the best numbers and builds what
[1:44] it's saving for as soon as it can.
[1:46] The Trader offers the table a one-for-one swap whenever it's one card short.
[1:51] Never Trades won't trade with anyone.
[1:53] Not even the bank. You know who you are.
[1:57] The Saver never spends its last four cards.
[2:00] Just in case.
[2:01] The Road Builder wants Longest Road.
[2:03] Wood, brick, and a road every time it can.
[2:07] The City Rusher starts on ore and wheat and upgrades to cities before it expands.
[2:12] The Army buys development cards and plays a knight every turn, going for Largest
[2:17] Army.
[2:17] And the Port Master builds on a port and trades its spare cards there.
[2:23] I sat them at every possible table of four.
[2:26] That's 70 tables, with 10,000 games at each one.
[2:29] Starting from the bottom. The Road Builder won 3.5% of its games.
[2:36] Never Trades won 18. The Saver, 24.
[2:40] The Army, 29. The Builder, 30. The Port Master, 31, and the Trader, 32.
[2:48] And in first place, by a hair, the City Rusher, with 33%.
[2:53] At a table of four, a fair share is 25%.
[2:56] That's the number to beat.
[2:58] Now, the obvious objection. Maybe the City Rusher only won because everyone
[3:03] else was doing something different.
[3:05] So what if the whole table copies it?
[3:08] I sat every player against three City Rushers, 600,000 more games.
[3:13] None of my players beat it. The closest was the Port Master, at 24%.
[3:18] My Builder dropped to 17, the Road Builder to 2.1.
[3:21] When everyone plays City Rusher, the best answer among my players is to play
[3:27] it too. Game theorists call that an equilibrium.
[3:30] Remember that table of City Rushers.
[3:33] Now, that Road Builder. A fan's simulation of 36,000 games of Catan concluded
[3:39] that roads are overpowered, because more than half of its winners held Longest
[3:44] Road.
[3:45] My Road Builder got Longest Road in 79% of its games, and it still lost 96.5%
[3:52] of them.
[3:54] And the winners? Leave my Road Builder's tables out of it, and 44% of winners
[4:00] held Longest Road. 43% held Largest Army.
[4:03] Less than half, either way.
[4:05] Roads aren't useless. In a minute you'll see they're the AI's most common
[4:09] buy. But a road has to go somewhere.
[4:13] A ranking doesn't tell you why, though.
[4:15] So I tested one habit at a time: one player changes a single thing, and the
[4:21] other three are plain Builders.
[4:22] 60,000 games for each habit. Four Builders win 25% each.
[4:26] That's the number to beat.
[4:28] Mistake one: never trading. Never trading with the bank or a port dropped
[4:33] a player to 16%.
[4:35] Mistake two: saving cards for later.
[4:37] Never spending its last four cards, just in case, dropped the Saver to 20%.
[4:43] Cards in your hand aren't points on the board.
[4:46] And here's the sneaky version. Even my plain Builder, which builds as soon
[4:51] as it can, ended 28% of its turns sitting on eight or more cards, and lost
[4:57] 28 cards a game to sevens. The AI, as you'll see, rarely does.
[5:02] Mistake three: wasting the robber.
[5:04] Moving it at random dropped a player to 21%.
[5:07] Hitting the leader or blocking the busiest tile was a tie.
[5:11] Just never waste it.
[5:13] Mistake four: cities before settlements.
[5:15] From a normal start, building cities first dropped a player to 22%.
[5:21] Even from an ore-and-wheat start, cities first did worse than settling first:
[5:26] 30% against 32%.
[5:29] The biggest lever of all is the very first thing you do.
[5:33] Your first two settlements.
[5:34] Everyone counts the dots under the numbers.
[5:37] More dots, more rolls. But the dots mattered less than you'd think.
[5:42] Players who started on 21 to 23 dots won 26%.
[5:47] On 18 to 20, 24%.
[5:49] What mattered was variety. Players whose first two settlements touched all
[5:55] five resources won 42% of the time.
[5:59] Four, 21%. Three, 14%.
[6:01] And one thing you can't control: your seat.
[6:04] In my tournament, the player who goes last won 31% of games, the one who goes
[6:09] first only 18%. Probably because the last player gets two picks in a row,
[6:14] and the first gets the very last pick.
[6:18] Time for the AI. This is catanatron's strongest player.
[6:21] It doesn't follow fixed rules like my players.
[6:24] It tries every move it could make, looks one more move past each, including
[6:28] every way the dice could land, and picks the one its scoring formula likes
[6:33] best.
[6:34] It's slow, so it played 25,000 games against my players.
[6:38] At a table of three random players from my eight, it won 35%.
[6:43] Against three City Rushers, my best, it won 28.
[6:48] So the AI wins. But what if the players who are behind team up against the
[6:53] leader?
[6:54] So I tested it. When the other three just block the busiest tile, the AI wins
[6:59] 40%. When all three rob the leader, it drops to 29%.
[7:03] Ganging up works. Your family was right.
[7:07] So what does the AI do that my players don't?
[7:11] I logged every decision it made in 5,000 games, and found five habits.
[7:16] Habit one: variety over dots. 77% of the time, its first two settlements touch
[7:22] all five resources, even when that means fewer dots.
[7:25] When I gave my Builder just that rule, it went from 25% to 33%.
[7:31] Habit two, and it's the big one: it doesn't sit on cards.
[7:35] It ended just 4% of its turns holding more than seven, and lost 9 cards a
[7:41] game to sevens. The Builders at its table lost 28.
[7:44] So I gave my Builder just that habit.
[7:47] If you're holding more than seven cards at the end of your turn, buy something
[7:51] or trade some away. It went from 25% to 38%.
[7:54] The biggest jump of any single habit I tested.
[7:58] Habit three: it trades with the bank, about 7 times a game, and 46% of those
[8:03] at a port. My Builder, about 2.
[8:06] Habit four: roads that go somewhere.
[8:08] Most of what it buys is roads, and it holds Longest Road in 72% of its games.
[8:14] But it keeps settling: its towns and cities are worth 6 points by the end
[8:19] of a game. The Road Builder's were worth 3.
[8:22] And habit five, the weird one: it almost never buys development cards.
[8:27] 0.2 a game. Largest Army? Not once in 25,000 games.
[8:32] It wins without them.
[8:35] So can a normal person play like that?
[8:38] I built one more simple player.
[8:40] No looking ahead, no search. Just the AI's habits, written down as rules,
[8:45] with one big difference: it still buys development cards whenever it has nothing
[8:49] else to build. The AI almost never does.
[8:52] I call it the AI's Playbook.
[8:55] Against three Builders, the Playbook won 41%.
[8:58] The AI managed 30 at the same kind of table.
[9:03] Against three City Rushers, the Playbook won 41%.
[9:07] The AI, 28.
[9:09] Then I sat the AI down with three Playbooks.
[9:12] It won 18%. Less than a fair share.
[9:15] The student beat the teacher.
[9:17] And the final: the AI, the Playbook, the City Rusher and the Builder, all
[9:23] at one table, 3,000 games. The Builder won 14%.
[9:26] The AI and the City Rusher were neck and neck, 24 and 25.
[9:31] And the Playbook won 37%.
[9:34] To be fair to the AI: it only looks two moves ahead, it barely touches development
[9:39] cards, and two of its habits, variety and never sitting on cards, are written
[9:44] into its scoring formula. A stronger AI might well beat the Playbook.
[9:48] But it didn't need to be perfect to teach us something.
[9:52] So here's what 3.7 million games say about your next game of Catan.
[9:58] One. Never end your turn holding more than seven cards.
[10:01] Build, trade, or buy something.
[10:04] Two. Count resources, not dots.
[10:05] Touch as many of the five as you can.
[10:09] Three. Lean into ore and wheat.
[10:12] Cities made up 44% of a winner's points.
[10:15] Four. Trade. With the table, with the bank, at a port.
[10:19] Five. Roads are for getting somewhere, not for Longest Road.
[10:24] And if someone's running away with the game?
[10:27] Everyone, put the robber on them.
[10:28] It works.
[10:29] One last thing. My players can't negotiate.
[10:31] They can't bluff, and they can't talk a friend into a terrible trade.
[10:36] People can. That part of Catan is still up to you.
[10:40] Which game should I put through the machine next?
[10:42] And if you've got a Catan strategy you swear by, describe it in the comments.
[10:46] I'll turn it into a player and test it.
