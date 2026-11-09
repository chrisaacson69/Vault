---
source: https://www.youtube.com/watch?v=E05MAjOyEaI
author: Perfect Play
channel: https://www.youtube.com/@PerfectPlaySim
title: "I Made 13 Ticket to Ride Strategies Fight for 200 Million Games"
clipped: 2026-11-08
published: 2026-11-07
type: youtube
duration: "13:21"
transcript: auto-generated captions (asr, en-orig), via yt-dlp json3
---

[0:00] Under my Catan video, a comment with
[0:02] more than 100 likes said just three
[0:04] words, Ticket to Ride. So here it is.
[0:08] And there's one question about this
[0:09] game, I really wanted to settle. Can you
[0:12] win Ticket to Ride without finishing a
[0:13] single ticket? [music]
[0:15] A 2022 thesis from Leiden University
[0:17] says yes. Its computer player hoarded
[0:20] train cards, [music] then grabbed the
[0:21] longest routes and won 85% of its games.
[0:25] The catch is that its rival scored
[0:26] [music] between 32 and 44 points. Real
[0:29] players at a four-player table average
[0:31] more than 100. So I rebuilt the game in
[0:34] a computer program [music] with players
[0:35] that score like real people and ran more
[0:37] than 200 million games. The short answer
[0:40] [music] in my simulator is yes, and by a
[0:43] lot. But what wins isn't skipping the
[0:45] tickets, and the only plan that won more
[0:48] than half its games at every table in my
[0:50] tournament finishes two of them.
[0:53] Quick rules. From the 2025 box you'd buy
[0:56] today [music]
[0:56] with four players, everyone has 45
[0:59] trains. On your turn you do one thing.
[1:02] [music] You take two train cards or you
[1:04] claim one route by paying cards of its
[1:06] color or you draw new [music] tickets.
[1:08] Long routes pay much more per train. A
[1:10] one-train route pays one point and a
[1:12] six-train route pays [music] 15. Each
[1:15] ticket names two cities. Connect them by
[1:17] the end and you score its [music] points
[1:19] or fail and lose them. The longest
[1:21] continuous line of trains gets 10
[1:23] [music] more. When someone ends a turn
[1:25] with two trains or fewer, everyone gets
[1:28] one last turn.
[1:29] Remember that rule because it turns out
[1:31] [music] to be the whole video.
[1:35] Meet the regular, the [music] everyday
[1:36] player in this video. It keeps about
[1:38] five tickets, finishes most of them, and
[1:40] scores about 110 points in about [music]
[1:43] 41 rounds. A table of four regulars
[1:45] scores like real four-player games with
[1:47] the winner around 140. [music] The
[1:50] expert is stronger. It finishes about
[1:52] five tickets a game and scores about
[1:54] 128. [music] A table of experts scores
[1:57] above the real games I could find, so
[1:59] that's the table. Then six plans from
[2:01] strategy guides and studies. The long
[2:04] hauler mostly claims routes [music] of
[2:05] five and six. The ticket collector keeps
[2:08] every ticket it can. The blocker cuts
[2:10] other players off. The route builder
[2:13] links its tickets by the [music]
[2:14] shortest path. The opportunist takes the
[2:16] best route open each turn and longest
[2:19] path chases [music] that 10-point bonus.
[2:21] And the hoarder, the plan from that
[2:23] thesis, it keeps its two cheapest
[2:25] tickets, takes nothing but train cards
[2:27] for the first 21 [music] rounds, and
[2:29] then lays down the longest routes it
[2:31] can. For each of those plans, my program
[2:33] searched [music] for its strongest
[2:35] version. A few of those searches ran out
[2:37] of time before they settled, so their
[2:38] numbers are a floor.
[2:41] First, every plan against three
[2:42] regulars. With four players, a fair
[2:45] share is 25 % The regular itself wins 25
[2:49] and the expert 32 and a half. Every plan
[2:52] from the guides beat that, from 42 % for
[2:54] the opportunist to 61 for the blocker.
[2:57] The hoarder won 83 % That's five games
[3:01] out of every six without finishing a
[3:03] single ticket. When I let the search
[3:06] tweak it further, it reached 87 and it
[3:08] still finished almost none. But skipping
[3:11] tickets isn't the trick on its own. The
[3:13] long hauler skips its tickets too and
[3:15] starts claiming long routes around round
[3:17] six. [music] It won 52. What it doesn't
[3:20] do is hoard. And the names turned out to
[3:23] lie. The blocker won under 2 % before
[3:26] the search and 61 after it. But switch
[3:28] it's blocking off and it wins even more
[3:31] at every table. Longest path did the
[3:33] same. [music] And the best ticket
[3:35] collector the search found kept fewer
[3:37] tickets than the regular. [music]
[3:39] So why does it work?
[3:41] Here's the hoarder's game. It draws
[3:43] until round 21, then lays its first
[3:46] train in round 22, holding as many as 46
[3:49] cards. [music] 46 isn't random. Four
[3:52] starting cards plus two a turn for 21
[3:54] turns makes 46, enough for all 45 trains
[3:57] without drawing again. Then it plays
[3:59] almost seven routes of five or six
[4:01] trains worth 98 of its 105 route points.
[4:05] It loses 16 points on its two unfinished
[4:07] tickets, gets the longest path bonus in
[4:09] about 1 games in 10 and still ends near
[4:12] 92. [music] And running out of trains
[4:14] that fast ends the game around round 30.
[4:16] Without a hoarder, the same table plays
[4:19] to round 41 and each regular scores
[4:21] about 110. Stop that game at round 30
[4:24] and they have 51. With the hoarder at
[4:26] the table, they finish with 55. Then I
[4:29] swapped the hoarder for a player that
[4:31] only draws cards and never lays a train
[4:33] and cut the game at round 30. The
[4:35] regulars scored almost exactly the same.
[4:38] So almost all of that drop comes from
[4:40] the clock, not from the routes the
[4:41] hoarder takes. [music] The game just
[4:43] ends before they finish their plans.
[4:46] And the window is narrow. Stopping at
[4:48] round 18 or at round 25 cost it 20 to 28
[4:52] percentage points. At 18, it doesn't
[4:54] have the cards yet. [music] At 25, the
[4:57] game drags on to round 34 and the others
[4:59] catch up.
[5:01] But maybe it only beats regulars.
[5:04] Against three experts, it still won 53%,
[5:07] more than twice the fair share. I also
[5:10] built 500 different tables of four, each
[5:12] playing its own way and kept the 281
[5:15] that score like real four-player games.
[5:17] [music] Without a hoarder, they all take
[5:19] between 38 and 45 rounds. Against every
[5:22] one [music] of them, the hoarder won
[5:24] more than its fair share. But how much?
[5:26] Ranged from about one game in three
[5:28] [music] to nine and 10. In the middle,
[5:30] two and three. What decides it is how
[5:33] many points the others have when the
[5:35] game [music] stops. The redder the
[5:36] table, the more points the others had
[5:39] and the less the hoarder won. The
[5:41] toughest was my long route table which
[5:43] never takes a face up locomotive. When
[5:45] the hoarder ends that game, those
[5:47] [music] players already have 73 points,
[5:49] not 55. There, it [music] wins just 32%.
[5:54] And what if the table sees it coming? A
[5:56] hand of 40 cards is hard to miss.
[5:58] [music] The best reaction my program
[6:00] found stops drawing tickets and races
[6:02] for the long routes as soon as anyone
[6:04] holds 14 [music] cards.
[6:06] But 14 is low, so that table reacts
[6:08] early in every game, hoarder or not.
[6:11] Even so, the hoarder won almost seven in
[6:14] 10. Reacting only to a really big hand
[6:17] didn't help at all. None of the
[6:19] reactions I tested goes after the exact
[6:21] routes it's [music] saving for though,
[6:23] so a sharper table might do better.
[6:26] Before trusting any [music] of this, I
[6:28] checked it against outside data. First,
[6:31] the thesis. With players similar to
[6:33] theirs, my hoarder won 83% [music]
[6:36] against 85 in the thesis. Then real
[6:38] scores from four-player games that
[6:40] groups loved online. [music] Those
[6:42] records have the scores, but no seats,
[6:45] no tickets, and no gain length. And
[6:47] length is exactly what decides this. So
[6:50] here are the [music] two ends. In my
[6:51] program, the other players lose as much
[6:54] from a short game as my regular does,
[6:56] and the hoarder wins 83%. [music]
[6:58] But if real people scored by round 30
[7:01] what they score in a whole game, it's 92
[7:03] [music] points would beat only about
[7:04] five real winners in 100.
[7:07] For real people, the answer is somewhere
[7:09] in between. My simulator can't know how
[7:11] many points people have by [music] round
[7:13] 30, and no public data records it. But
[7:15] two of the plans coming up, the fast
[7:17] [music] builder and hoarder finish, hold
[7:19] up at both ends. In my program, they win
[7:22] three games in four or more against
[7:24] regulars. And even in that worst case,
[7:26] [music] their scores beat about one real
[7:28] winner in five, close to the regulars
[7:30] one in four.
[7:32] So who beats it? Another hoarder for a
[7:35] start. Put two hoarders with two
[7:37] regulars, and together they still take
[7:39] nine games in 10. The real threat came
[7:42] out of a free search with no plan to
[7:44] stick to. I'll call it the fast builder.
[7:47] It lays trains from round one, keeps
[7:49] just two tickets, finishes them, and
[7:51] against regulars, it's the one who wins
[7:53] the game. It wins 74% there. [music] Put
[7:56] one hoarder against three fast builders,
[7:59] and the hoarder wins only one game in
[8:00] 10. Their average scores are the same,
[8:03] about 84. But the hoarder's score barely
[8:05] moves, and with three scores that swing
[8:07] a lot, one of them usually ends up
[8:09] higher. One catch, though. A table of
[8:12] four fast builders scores below real
[8:14] tables, and nothing in the real data
[8:16] shows people playing like that.
[8:18] And then I gave the search a different
[8:20] idea to start from. Horde the same way,
[8:23] drawing until round 21 with up to 46
[8:25] cards, then finish your tickets. I'll
[8:27] call it Horde and Finish. Against three
[8:30] regulars, it won 85 and 1/2 %, right
[8:33] between the two pure hoarders at 83 and
[8:36] 87. But at the long route table, the one
[8:39] that held the hoarder to 32, Horde and
[8:41] Finish won 64. Here's what surprised me.
[8:45] When I forced the hoarder itself to
[8:47] finish its two cheapest tickets, it fell
[8:49] from 83 % to 51. The game stretched from
[8:52] round 30 to almost 36. You can't just
[8:56] bolt the cheapest tickets onto a horde.
[8:58] Horde and Finish doesn't keep the
[9:00] cheapest ones. It's a plan built for it.
[9:03] Horde and Finish does have one weak
[9:05] spot. At a table with a pure hoarder,
[9:07] the hoarder ends the game at round 30
[9:09] before its tickets are done. There, it
[9:11] wins only 34 %, and the hoarder wins 60.
[9:15] So I ran one more search against four
[9:18] different tables at once, including that
[9:20] one. The planet found draws cards only
[9:22] until round 18, then finishes its two
[9:25] tickets. At the table with a pure
[9:27] hoarder, it won three games in four, and
[9:29] the hoarder fell to 23 %. [music] It
[9:32] usually had its tickets done before the
[9:34] hoarder could end the game. The price is
[9:36] that it wins less against plain
[9:38] regulars, [music]
[9:38] 78 %, where the tweaked hoarder won 87.
[9:42] But it was the only plan that won more
[9:44] than half its games at all seven tables
[9:46] of my tournament, including a mixed
[9:48] table and one where the deck runs dry by
[9:50] round 16. Against three fast builders,
[9:53] it won [music] about half. The hoarder
[9:54] had won one in 10. And every time I ran
[9:57] the search against tougher [music]
[9:58] tables, it never picked ignoring the
[10:00] tickets. Its best plan always drew cards
[10:03] for about 18 [music] to 21 rounds, then
[10:05] finished two tickets.
[10:08] Now the [music] questions every guide
[10:09] argues
[10:10] Should an ordinary ticket player wait
[10:12] before building? [music] In my
[10:14] simulator, yes. Even them. Though my
[10:17] players rarely take the routes you're
[10:18] saving up for. [music] A regular that
[10:20] drew cards for 22 rounds before its
[10:22] first train went from 25% to 43 [music]
[10:26] and that game still ran about 41 rounds.
[10:28] With a hoarder at the table though,
[10:30] [music] the weight has a limit. Waiting
[10:32] until round 18 gains about 9 percentage
[10:34] points. Until 22, [music] barely one.
[10:37] And until 25, it loses five. The face up
[10:40] locomotive is tempting [music] because
[10:42] it's wild. But taking it uses up your
[10:44] whole draw. Never taking it did better
[10:47] or tied at every table. The regular
[10:49] gained about 4 percentage points just by
[10:51] leaving it there. As a rule of thumb
[10:53] anyway. Some turns you'll need exactly
[10:56] that card. [music]
[10:56] Tickets. Keeping all four of your
[10:59] starting tickets cost wins at every
[11:01] table. Drawing more mid game only
[11:03] [music] paid off with trains to spare.
[11:05] Against a table with a hoarder, a
[11:07] regular that never drew another ticket
[11:09] did even better. Against [music] strong
[11:11] players though, never drawing cost.
[11:15] Blocking people or stretching for the
[11:17] longest path, the way my players [music]
[11:18] do it, cost wins at every table.
[11:21] Remember, even the blocker won more once
[11:23] it stopped [music] blocking. A block
[11:25] picked by hand at just the right moment,
[11:27] I didn't test. Racing to end [music] the
[11:29] game? I split the race into its two
[11:32] parts. Not drawing more tickets helped a
[11:34] regular against a hoarder by about 14
[11:37] percentage points. But not by ending the
[11:39] game sooner. The hoarder still ends it
[11:41] at round 30. The regular just isn't
[11:43] stuck with half finished tickets.
[11:45] Grabbing [music] any route to speed
[11:47] things up, even ones and twos, cost wins
[11:49] at every table. And with two, three, or
[11:52] five players? Against everyday players,
[11:55] the hoarder still won far more than its
[11:57] fair share. From nine games in 10 with
[11:59] two to nearly eight [music] in 10 with
[12:01] five. The big exception is five players
[12:03] at the long route table where its edge
[12:05] almost disappears.
[12:08] So, can you win ticket to ride without
[12:10] finishing a single ticket? In my
[12:12] simulator? Yes, and by a lot, against
[12:15] tables whose games run long. How well
[12:17] that holds against real people, nobody
[12:19] can say yet because no one records how
[12:22] many [music] points people have by round
[12:23] 30. But it's the clock that wins, not
[12:26] the empty tickets.
[12:27] If you want one [music] plan to take to
[12:29] your table, draw cards until about round
[12:31] 18, keep two tickets, and finish them.
[12:34] That's the plan that held up at every
[12:36] table I simulated. And whatever you
[12:38] play, [music] leave the face-up
[12:39] locomotive where it is. Don't keep all
[12:41] four starting tickets and don't go out
[12:44] of your way to block. Oh, and by the
[12:46] way, if you want to [music] try the game
[12:47] or you're missing a few trains and need
[12:49] a new copy, it's linked in the
[12:50] description. It's an affiliate link, so
[12:53] buying through it supports [music] the
[12:54] channel at no extra cost to you. You
[12:56] asked for this one, so keep the requests
[12:58] coming. The next game gets picked from
[13:00] the comments. Catan, [music] Risk, and
[13:02] Monopoly got the same treatment and
[13:04] they're all right here. Subscribing
[13:06] costs zero cards. Unlike that face-up
[13:09] locomotive, it's [music] worth taking.
