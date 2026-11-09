---
source: https://www.youtube.com/watch?v=4fbmWkPNcBQ
author: Board Odds
channel: https://www.youtube.com/@BoardOdds
title: "The Best Guess Who Strategy, Simulated on 300 Million Games"
clipped: 2026-11-08
published: 2026-10-28
type: youtube
duration: "16:16"
transcript: auto-generated captions (asr, en-orig), via yt-dlp json3
---

[0:00] Your opponent flips down one more face
[0:02] and stops. One card is still standing on
[0:04] their side of the board. They know who
[0:06] you are, but they can't say it yet.
[0:08] Under the official rules, naming a face
[0:10] takes your whole turn. They just spent
[0:12] this turn on a question, so the name has
[0:14] to wait, and you get one last move
[0:16] before they say it. You've got four
[0:18] faces up, Anita, George, Max, Susan.
[0:22] What do you do? Almost everybody does
[0:24] the sensible thing. They ask a good
[0:26] question, a great one even, the kind
[0:28] that cuts four faces down to two. Then
[0:30] the other side of the table says the
[0:31] name, and that great question turns out
[0:33] to be the last thing they did all game.
[0:35] The right move feels wrong. Stop asking.
[0:38] Pick one of your four faces and name it.
[0:40] Right now. Most of the time you'll miss,
[0:43] but a miss only loses a game that was
[0:44] already gone, and every so often that
[0:47] guess steals it back. That small,
[0:49] slightly reckless decision turned out to
[0:51] be one of the biggest edges in the whole
[0:52] game, bigger than the famous trick. You
[0:55] know the one. Don't ask about one
[0:56] feature, ask about several at once, like
[0:59] does your person have red hair, a hat,
[1:01] or glasses? So that every answer knocks
[1:03] out exactly half the board. In a video
[1:05] from 2016, Mark Rober said that strategy
[1:08] theoretically will win you more than 96%
[1:11] of your games.
[1:12] So I built nine computer players. I gave
[1:14] one of them that trick. I gave another
[1:16] one nothing but the habit you just saw.
[1:18] And I made them all play each other on
[1:20] the classic 24 face board, 317 million
[1:23] 800,000 games. Here's what came back.
[1:26] The split-in-half trick is real. It's
[1:28] just not 96% and it has a hole in it.
[1:31] And the plain habit from that four-face
[1:33] moment, using only ordinary questions,
[1:35] beats the famous trick head-to-head. By
[1:37] the end, you'll know which question to
[1:39] open with, the exact moment to stop
[1:41] asking and start naming, which popular
[1:43] habit plays worse than the random
[1:45] player, and the one rule your family
[1:47] should settle before anybody flips a
[1:48] card. So why believe a computer about a
[1:51] game of faces? Here's the short version.
[1:54] The board is the classic one, Alex,
[1:56] Alfred, Anita, Anne, Bernard, Bill, and
[1:59] the rest of the gang, all the way to
[2:00] Susan and Tom. What each face looks like
[2:03] comes from two independent public data
[2:05] sets, both put together by fans and
[2:07] shared on GitHub. They agree on almost
[2:10] everything. They argue about two faces
[2:12] that matter here, whether Ann has a big
[2:14] nose, and whether Max's hair is brown or
[2:17] black. My main results use the first
[2:19] data set. Then I ran a full check on the
[2:21] second one, and I'll tell you what
[2:23] moved. The questions are the ones you'd
[2:25] ask at the kitchen table. Is it a woman?
[2:27] Hat, glasses, beard, mustache, rosy
[2:30] cheeks, bald, blue eyes, big nose, and
[2:33] five hair colors: black, red, white,
[2:36] blonde, and brown. I left out big mouth
[2:38] and earrings for a reason you'll see in
[2:40] a minute. Then the rules, which come in
[2:42] two flavors. In the official version,
[2:45] you take turns. On your turn, you either
[2:47] ask one yes or no question, or you name
[2:49] a face. Name the right one, and you win.
[2:52] Name the wrong one, and you lose. And
[2:54] naming takes your whole turn. That's the
[2:56] rule from the opening.
[2:57] Lots of families play a house version
[2:59] instead, where you win the moment you've
[3:01] narrowed it down to one face. That's the
[3:03] version Mark Rober describes. The first
[3:05] person to narrow it down to one wins.
[3:08] Everything you hear first uses the
[3:09] official rule. The house rule got its
[3:11] own 12.8 million games, and its own
[3:14] chapter near the end. Now, how do I know
[3:16] the simulator isn't fooling me? Check
[3:19] one. I made an exact copy of the normal
[3:21] player and sat it across from the
[3:22] original. Two identical players should
[3:25] split the games evenly. The copy won
[3:27] 50.02%.
[3:29] Under the house rule, 50.05.
[3:32] Check two. The perfect player works from
[3:34] an exact solution of every position in
[3:36] the game. That solution says that when
[3:38] both sides play perfectly, the player
[3:40] going first wins exactly five games in
[3:42] nine. That's 55.56%.
[3:45] Then I let two perfect players actually
[3:47] play millions of times. The first player
[3:50] won 55.54.
[3:52] Under the house rule, 63.20 simulated
[3:55] against 63.19 exact. And that sits
[3:58] inside the range Mihai Nica proved for
[4:00] the house rule version in a 2016 paper,
[4:03] somewhere between five and eight and two
[4:05] and three.
[4:06] The margin of error on any single result
[4:08] in the main run is about 0.05 points.
[4:12] When two numbers are closer than that,
[4:14] call it a tie.
[4:15] Now the nine players.
[4:17] Random asks about any feature that still
[4:19] tells it something. That's the fool,
[4:21] like a very young kid.
[4:22] Normal asks about the single feature
[4:24] that splits its remaining faces most
[4:26] evenly. That's a thoughtful family
[4:28] player, and it's the yardstick for
[4:29] everything else.
[4:31] Smart also sticks to single features,
[4:33] but it picks the one with the best
[4:34] chance to win the whole game. It watches
[4:36] how close the opponent is, and it names
[4:38] a face when that's the better bet.
[4:40] However is the famous trick. Combine
[4:42] questions, so every answer removes
[4:44] exactly half, and it only names a face
[4:47] when it's sure. Perfect can ask anything
[4:49] at all, and it plays every position from
[4:51] that exact solution. Then three habit
[4:53] players. Each one is a normal player
[4:55] with exactly one change. Gender first
[4:58] always opens with, "Is it a woman?"
[5:00] Guess at two names one of its last two
[5:02] faces instead of asking one more
[5:04] question, and last chance names a face
[5:06] the moment the opponent is down to one.
[5:08] The ninth player is normal's copy, the
[5:10] fairness check you just heard about.
[5:13] Every player played every other player,
[5:14] half the games going first and half
[5:16] going second. The main run under the
[5:18] official rule was 298 million 600,000
[5:22] games. Before we watch them play, look
[5:24] at the board itself. It's built to make
[5:26] you ask bad questions. Count the faces
[5:29] wearing a hat. Five, glasses five,
[5:32] >> [music]
[5:32] >> mustache five, bald five, blue eyes,
[5:35] rosy cheeks, big nose five each. Red
[5:38] hair, white hair, blonde brown, five
[5:40] each. Women five. Almost every feature
[5:43] sits on exactly five of the 24 faces. In
[5:45] the first data set, the exceptions are
[5:47] beard and black hair with four each.
[5:50] Mark Rober says every single attribute
[5:52] applies to exactly five people. For most
[5:54] features, that holds in both data sets.
[5:57] Not for all of them though. The second
[5:59] data set puts big nose on six faces and
[6:01] brown hair on four. And big mouth, one
[6:04] of the two I left out, sits on 10.
[6:06] Earrings on two or three, depending on
[6:08] which data set you ask. Neither one
[6:10] belongs to the board's five of each
[6:11] design. Now, think about the most
[6:13] natural first question. Five faces on
[6:16] one side, 19 on the other. Most of the
[6:18] time the answer is no, and you flip down
[6:20] five. That's progress, but slow
[6:22] progress. And at a family table, it's
[6:25] slow for everybody.
[6:26] So, what does a game between two normal
[6:28] players look like? A normal player needs
[6:30] 5.16 questions on average to find a
[6:32] face, and sometimes as many as eight. A
[6:35] whole game between two of them takes
[6:36] 10.25 turns in total. That's about five
[6:39] turns each. And when both players race
[6:42] at the same speed, [music]
[6:43] the one who started is a full question
[6:45] ahead. Between two normal players, the
[6:47] one going first wins 60.30% of the time.
[6:51] That's a bigger first player edge than
[6:52] the experts get. Two random players,
[6:55] 57.21.
[6:57] Two perfect players, 55.54,
[7:00] which is exactly that five and nine edge
[7:02] that math says nobody can get rid of. At
[7:04] a normal table, the coin toss for who
[7:06] starts quietly decides a lot of games.
[7:09] >> [music]
[7:09] >> Now, the famous trick. Halva finds a
[7:11] face in 4.67 questions on average, and
[7:14] it never needs more than five. A third
[7:16] of the time it's done in four,
[7:18] two-thirds of the time in five. Compare
[7:20] that with normal's 5.16 and up to eight,
[7:23] or random at 5.66 and up to 12. So,
[7:26] head-to-head, Halva should crush a
[7:28] normal player, right? It beats normal
[7:30] 62.56%
[7:32] of the time. That's a real edge, but
[7:34] it's nowhere near almost always. In the
[7:36] 96% in Mark Rober's newer video, the
[7:39] claim is about a series. If you play
[7:41] best of five, you'll win 96% of your
[7:43] games. So, I played best of five series,
[7:46] first to three wins, with the start
[7:48] alternating.
[7:50] Halva beat normal in 76.87%
[7:52] of the series. Under Rober's own rule,
[7:55] where you win the moment you know,
[7:57] 76.97.
[7:59] What about the strongest player in the
[8:00] study against a normal one? Perfect wins
[8:03] the best of five 80.53%
[8:05] of the time. Under the house rule,
[8:08] 85.25,
[8:10] the highest best of five number anywhere
[8:11] in my tables is 91.89.
[8:14] And that's Halva against the worst habit
[8:16] player in the study under the house
[8:18] rule.
[8:19] So, I couldn't reproduce 96% against a
[8:21] normal player. Nothing in the simulation
[8:23] got near it.
[8:24] 77% is still a lot. It's just a
[8:27] different number.
[8:28] And there's a reason the trick tops out
[8:29] where it does. Remember the opening?
[8:32] Halva never names a face until it's
[8:34] sure. So, picture Halva going second. It
[8:36] is asked three beautiful questions. It's
[8:38] down to three faces, and the opponent
[8:40] has just flipped down to one.
[8:42] Halva asks a fourth beautiful question,
[8:44] and loses.
[8:46] When two Halvas play each other, the one
[8:47] going second wins just 22.21%
[8:50] of the time. Under the house rule,
[8:52] 22.23.
[8:54] The one going first wins almost four
[8:56] games in five.
[8:57] Now, put two perfect players in the same
[8:59] seats. The one going second wins 44.46%.
[9:03] About twice as often. The difference is
[9:05] one move. When the opponent is down to
[9:07] one face, perfect knows it's facing its
[9:09] last chance. So, it names a face from
[9:12] whatever it has left, even with several
[9:13] faces still standing. Which brings us to
[9:16] the most useful player in this video.
[9:18] Last chance is a normal player, same
[9:20] ordinary one feature questions, with
[9:22] exactly one change. When the opponent is
[9:24] down to one face, it names a face now.
[9:28] Against normal, it wins 64.91%.
[9:31] The famous trick, remember, got 62.56.
[9:34] Against Halva, head-to-head, Last Chance
[9:36] wins 56.70%.
[9:39] And against Smart, it's a tie. Smart
[9:41] wins 49.75%.
[9:43] So, nearly all of Smart's cleverness
[9:45] comes down to this one habit. Now, look
[9:47] [snorts] at where the edge lives. Going
[9:49] first against a normal player, the
[9:50] strong players are bunched together.
[9:52] Last Chance wins 73.30%.
[9:54] Halva, 73.80.
[9:56] Perfect, 73.20. For comparison, a normal
[10:00] player in that seat wins 60.30.
[10:03] Now, switch seats. A normal player going
[10:05] second against another normal player
[10:07] wins 39.70%.
[10:09] Put Last Chance in that chair and it
[10:11] wins 56.53.
[10:14] Perfect 58.97.
[10:16] From the backseat, one habit turns a
[10:18] losing position into a winning one. In a
[10:20] best of five against normal, last chance
[10:23] wins 79.29%.
[10:25] That's better than the famous trick's
[10:27] 76.87
[10:29] and it never asks the kind of questions
[10:31] some families called cheating. If your
[10:33] table bans red hair or a hat or glasses,
[10:36] you can still use this one.
[10:37] To be clear, it's not the best player.
[10:40] That's perfect, which is in effect the
[10:42] famous split plus this habit. Perfect
[10:44] beats last chance 55.44%
[10:47] of the time and Halva 58.36.
[10:50] Here's the full table, the average win
[10:52] rate against all nine players. Perfect
[10:55] 61.68.
[10:56] Last chance 58.79.
[10:59] Halva 55.77.
[11:01] Smart 55.54.
[11:04] Gender first 46.29.
[11:06] Normal 46.02
[11:09] and its copy lands on exactly the same
[11:10] number. Random 41.30.
[11:14] And dead last, below the random player,
[11:16] Guess It 2 38.61.
[11:19] Remember that name. So, what does
[11:21] Perfect Guess Who actually look like?
[11:23] Because every position was solved
[11:24] exactly, I can show you. The first
[11:26] question, any question whose yes group
[11:29] covers eight to 12 faces gives the
[11:31] player going first the same 55.56%.
[11:35] A normal five-face question gives 53.47.
[11:38] So, opening with is it a woman cost you
[11:41] about two points against a perfect
[11:43] opponent. Not a disaster, just a leak.
[11:46] And naming a face on your very first
[11:48] turn? That wins 4.17%.
[11:51] One in 24. After that, the splits get
[11:53] stranger. With six faces left, Perfect
[11:56] doesn't ask about three of them. It asks
[11:58] about two. With three faces left, it
[12:00] asks about one. And it names a face in
[12:03] exactly three situations. When it's down
[12:05] to one face itself,
[12:07] >> [music]
[12:07] >> when the opponent is down to one face,
[12:09] or when both players have exactly two
[12:11] faces left. That third one is a narrow
[12:13] exception, which brings us back to the
[12:15] player in last place.
[12:17] Guess at two does what lots of us do
[12:19] with two faces left. It gets impatient
[12:21] and it guesses. That made it the worst
[12:23] player of all nine, 38.61%
[12:26] overall, below random at 41.30.
[12:30] Against a normal player, it wins 39.62.
[12:33] Why so bad? A guess at two loses half
[12:35] the time right now. Asking one more
[12:37] question only costs you if the opponent
[12:39] finishes in that one turn, and most of
[12:41] the time they don't. Under the house
[12:43] rule, it gets even worse, 35.21 overall
[12:47] and only 31.96 against normal.
[12:50] So, at two faces, ask one more question.
[12:53] Unless your opponent is down to one,
[12:55] then name a face.
[12:56] And the most famous opening in the game,
[12:58] gender first, always starting with is it
[13:01] a woman? Against normal, it wins 50.13%.
[13:04] No effect at all. On this board, women
[13:06] are just another five-face feature, like
[13:08] hats or glasses. Now, the rule that
[13:11] changes almost everything. What if your
[13:12] family plays that you win the moment you
[13:14] know? Games get shorter. Two normal
[13:16] players take 8.25 turns in total instead
[13:19] of 10.25, and the first player's edge
[13:21] with perfect play grows from 55.56%
[13:25] to 63.19.
[13:27] The best strategy shifts, too. There is
[13:29] no last chance anymore because the
[13:31] moment your opponent narrows it down,
[13:32] they've already won. So, smart, whose
[13:34] edge was mostly that habit, drops to
[13:36] 52.14 overall. Halver rises to 58.99.
[13:42] Perfect beats normal 68.83%
[13:44] of the time, and Halver beats normal
[13:46] 62.62.
[13:48] And perfect gets bolder. When it's
[13:50] behind, it stops asking safe, even
[13:52] questions and asks narrow ones instead.
[13:55] A small group of faces that would put it
[13:56] ahead if the answer is yes.
[13:58] That's the bold play from Mihai Nica's
[14:00] paper. When you're losing a race, you
[14:02] don't catch up by running at the same
[14:03] pace.
[14:04] So, the whole video hangs on one line of
[14:06] the rules. Under the official rule, the
[14:08] last chance habit is the big win. Under
[14:11] win the moment you know, the The comes
[14:13] from splitting the board and from bold
[14:15] narrow questions when you're behind. A
[14:17] few honest limits before the takeaways.
[14:20] This is the classic 24 face board. Newer
[14:22] editions have different faces and
[14:24] different features. The faces come from
[14:26] two fan data sets that disagree on a few
[14:28] people and I ran both. The overall
[14:31] averages moved 1.19 points at most.
[14:34] Perfect went from 61.68 to 61.88.
[14:38] Single match-ups moved by up to 3.13
[14:40] points. However, against normal for
[14:43] example, went from 62.56
[14:46] to 60.31.
[14:47] Smart and Halver swap places in the
[14:49] ranking, but they're within about a
[14:51] point of each other either way.
[14:53] Big Mouth and Earrings were never asked
[14:55] and my computer players never bluff,
[14:57] never answer wrong, and never misread a
[14:59] face. Anyone who has played against a
[15:01] 6-year-old knows that's a big
[15:02] assumption. The official rule here is
[15:04] the commonly published one. Hasbro's
[15:06] rulebook site wasn't reachable from my
[15:08] research setup, so check the rule sheet
[15:10] in your own box. And whether combined
[15:12] questions are allowed depends on your
[15:14] table. Halver and Perfect use them. Last
[15:16] Chance, Smart and Normal don't. So,
[15:19] here's what to take to your next game
[15:20] night. One, when your opponent is down
[15:22] to one face, name a face now. Waiting
[15:25] means losing. Two, don't guess at two
[15:27] faces. Ask one more question unless rule
[15:30] one applies. Three, ask about as close
[15:32] to half the board as you can. If your
[15:34] table allows combined questions, ask
[15:36] about eight to 12 faces on the first
[15:38] turn, then split in half after that. If
[15:40] it doesn't, any five face feature is
[15:42] fine. The order doesn't matter. Four,
[15:45] agree on the rule before the first card
[15:46] flips. And if you play win the moment
[15:48] you know when you're behind, ask narrow
[15:50] questions. Back to that opening. One
[15:53] card standing on your opponent's side.
[15:55] Four faces on yours. Anita, George, Max,
[15:58] and Susan. Now you know the move. Point
[16:00] at one, say the name, and watch their
[16:02] face. The full list of limits is in the
[16:04] pinned comment. And tell me which rule
[16:06] your family plays. [music] Does naming a
[16:08] face cost you a turn or do you win the
[16:10] moment you know? If you want the next
[16:12] board game put through a few hundred
[16:13] million games, subscribe.
