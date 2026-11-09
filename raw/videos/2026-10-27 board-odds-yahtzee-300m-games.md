---
source: https://www.youtube.com/watch?v=5tf4GqBPAqU
author: Board Odds
channel: https://www.youtube.com/@BoardOdds
title: "The Best Yahtzee Strategy, Simulated on 300 Million Games"
clipped: 2026-11-08
published: 2026-10-27
type: youtube
duration: "18:40"
transcript: auto-generated captions (asr, en-orig), via yt-dlp json3
---

[0:00] Everybody at the table has a Yahtzee
[0:01] strategy. Your uncle goes for a Yahtzee
[0:03] on every single turn because that's
[0:05] where the fun is. Your sister rolls
[0:07] twice, sees something that looks fine,
[0:09] and puts the cup down. Somebody saves
[0:11] the chance box for emergencies. And
[0:13] there's always one person who crosses
[0:15] out the Yahtzee box the moment a roll
[0:17] goes bad. [music] So, I turned those
[0:18] habits into computer players and made
[0:20] them play 300
[0:23] million games. The highest score in all
[0:26] of those games was 1,005 points. It came
[0:30] from the player who goes for a Yahtzee
[0:32] every turn.
[0:33] That same player loses to an ordinary
[0:36] family player about three games in four.
[0:39] Now, the strange part.
[0:41] The perfect player, the one that makes
[0:43] the best possible move every time, fills
[0:46] its Yahtzee box with 50 points in 33.73%
[0:51] of its games. The family player does it
[0:53] in 39.38.
[0:55] The perfect player gets fewer Yahtzees.
[0:58] And it still beats that family player
[1:00] about three games in four. So, where do
[1:02] the points come from? Not from the dice
[1:04] you're hoping for. They come from a few
[1:06] boring habits, and you've probably got
[1:08] some of them backwards. You know who you
[1:10] are. First, a quick word on whether you
[1:12] can trust a Yahtzee game played by a
[1:14] computer.
[1:15] I'm using the official Hasbro rules. 13
[1:18] rounds, five dice, up to three rolls a
[1:21] turn. A 35-point bonus if the top half
[1:24] of your card adds up to 63 or more. 100
[1:27] points for every extra Yahtzee once your
[1:30] Yahtzee box already holds 50.
[1:32] And the rule most families skip, the
[1:34] forced joker.
[1:36] >> [music]
[1:36] >> If you roll a second Yahtzee, it has to
[1:38] go in its matching top box if that box
[1:41] is still open. If it isn't, you may put
[1:44] it in any open box on the bottom half at
[1:46] full value. And if nothing down there is
[1:48] open, it scores zero in a top box.
[1:52] Now, the players. The perfect player
[1:54] knows the best move in every position
[1:56] the game can reach. That's just over 1
[1:58] million different scorecard states and
[2:01] every possible role inside each one. It
[2:03] has a single goal, the highest average
[2:06] final score. The normal player is my
[2:08] version of the family table. It keeps
[2:10] the dice that come up most. It stops
[2:12] rolling when it has a large straight or
[2:14] a full house. It keeps four in a row to
[2:16] chase a straight. It scores each roll in
[2:18] whichever box pays the most points right
[2:20] now. And when a roll is bad, it dumps it
[2:23] in ones, then twos, then Yahtzee, then
[2:26] threes in that order. Then a random
[2:29] player, which keeps random dice and
[2:31] picks a random open box. That's the
[2:33] floor. And five habit players, each one
[2:36] a normal player with exactly one change.
[2:39] Add it up. 10 million games for the
[2:41] perfect player, 40 million for the
[2:43] normal player, 30 million for the random
[2:44] one, 36 million for each habit test, and
[2:47] [music] 40 million more for a control,
[2:49] which I'll explain in a second. 300
[2:52] million games in all. Before I believe
[2:54] any result, I need to know the simulator
[2:56] is honest. So, I ran checks where the
[2:58] answer was already known. Check one.
[3:01] The control.
[3:02] That's the normal player against the
[3:04] second normal player
[3:06] with fresh dice. Neither should have an
[3:08] edge. The result was 49.99%.
[3:11] Fair. Check two. The perfect player's
[3:14] table says that from an empty card, the
[3:17] average final score is 254.588.
[3:21] An independent open-source solver gives
[3:23] the same number down to four decimal
[3:26] places. The famous published figure
[3:28] from Verhoeff in 1999 and Glenn in 2006
[3:33] is 254.59.
[3:37] That one uses a slightly looser reading
[3:39] of the Joker rule.
[3:40] >> [music]
[3:40] >> So, call it about 254.6.
[3:44] And when my perfect player actually
[3:46] played 10 million games, it averaged
[3:48] take 0.04.
[3:53] Check three.
[3:55] The swing.
[3:56] The typical spread of its scores was
[3:58] 59.6 points, and the median game was
[4:00] 248. Verhoeff's published numbers of
[4:03] 59.61
[4:05] and 248. Check four.
[4:09] My perfect player scores zero in the
[4:11] Yahtzee box in about two games out of
[4:13] three.
[4:15] Verhoeff's trivia page says almost
[4:16] exactly that. Now, one limit, because it
[4:19] matters later. The perfect player
[4:21] maximizes its average score. It isn't
[4:23] trying to beat you in particular.
[4:26] Against one opponent, a player far
[4:28] behind late in the game might take
[4:30] bigger risks.
[4:32] That's a different, harder question.
[4:35] And I didn't answer it.
[4:37] Hold on to that.
[4:38] I'm coming back to it. Let's start with
[4:40] the normal player, because everything
[4:41] else gets compared with it. It averages
[4:43] 208 points. The median game is 196. Drop
[4:48] the best tenth of its games and the
[4:49] worst tenth, and the rest run from 148
[4:52] to 275.
[4:54] In 9.15% of its games, it reaches 300.
[4:58] And it wins the 35-point bonus in only
[5:01] 2.88%
[5:03] of games.
[5:04] Put that number in your pocket. The
[5:06] random player averages 46.
[5:08] It beat the normal player once in every
[5:10] 8,665
[5:12] games. So, yes, trying matters. Here's
[5:17] the whole cast, one line each. Random,
[5:20] pure chaos.
[5:21] Stop after two rolls. Rolls twice,
[5:24] shrugs, and scores. Always chase
[5:27] Yahtzees.
[5:28] Keeps the most common face and goes for
[5:30] five of a kind. Every turn. Save chance
[5:33] for last. Holds the chance box back as
[5:36] an emergency exit. Scratch Yahtzee
[5:39] first.
[5:40] When a roll is worthless, it crosses out
[5:42] the Yahtzee box before anything else.
[5:44] The normal player, hunt the upper bonus.
[5:47] A normal player with one rule changed.
[5:49] I'll tell you which rule in a few
[5:51] minutes. And the perfect player.
[5:53] Here's how they finished, by average
[5:55] score, from last place to first. Last,
[5:58] [music] random.
[6:00] 46.01.
[6:02] Then, stop after two rolls. 161.83.
[6:07] Then, always chase Yahtzees. 164.70.
[6:11] Save chance for last. 200. 2.19. Scratch
[6:16] Yahtzee first. 200. 7.56.
[6:21] The normal player, 208.25.
[6:24] In second place, the normal player with
[6:26] one rule changed. 215.48.
[6:30] And in first, the perfect player.
[6:33] 254.61.
[6:35] About 46 points ahead of normal. So,
[6:38] where did those points come from? Not
[6:40] what you'd think. Let's start with the
[6:42] myth. Going for a Yahtzee on one turn
[6:44] means you keep the most common face,
[6:46] reroll the rest twice, and hope. How
[6:49] often does that work? 4.60% of the time.
[6:52] One turn in about 22. My simulation
[6:55] matches the textbook figure, 4.6029.
[6:59] So, the dice are fine. Now, do that on
[7:01] every turn.
[7:02] That's always chase Yahtzees.
[7:05] It averages 164.70.
[7:08] That's more than 43 points below the
[7:10] normal player. And it loses to the
[7:12] normal player about three games in four.
[7:14] You'd think it would at least get more
[7:16] Yahtzees. It doesn't. It fills the
[7:19] Yahtzee box with 50 in 38.89% of games.
[7:23] The normal player, who isn't even
[7:24] trying, gets 39.38.
[7:27] Here's where the points went. Chasing
[7:29] Yahtzees means ignoring everything else.
[7:32] The chaser leaves the small straight box
[7:34] empty in 67% of its games. The large
[7:37] straight box, 91%.
[7:40] The full house box,
[7:42] 29.
[7:43] The normal player leaves those same
[7:45] boxes empty in 10%, 30%, and 7%. So, a
[7:50] Yahtzee is a lottery ticket. And a
[7:52] lottery ticket has a typical result.
[7:55] Half of the chaser's games end at 147
[7:58] points or less. In 51.88%
[8:02] of them, it finishes under 150.
[8:05] But somewhere in 300 million games, one
[8:08] of those tickets paid out 1,005
[8:11] points. The perfect player's best game
[8:13] was 946.
[8:15] A Yahtzee is a nice thing to get. It's a
[8:17] terrible thing to aim for. Now, the
[8:19] perfect player average 254.61.
[8:24] Median 248.
[8:26] Its middle 80% of games run from 194 to
[8:30] 318. And it breaks 300 in 14.33% of
[8:35] games. The normal player does that in
[8:37] 9.15.
[8:39] Head-to-head, it beats the normal player
[8:41] about three games in four, 76.32%
[8:44] outright, with about four games in a
[8:47] thousand tied. Flip that around. The
[8:50] normal player beats the perfect player
[8:51] in 23.26%
[8:53] of games. Perfect player still loses
[8:56] about one game in four to an ordinary
[8:58] player. Luck is real.
[9:00] Out of 10 million games, the perfect
[9:02] player's worst was 70 points, and its
[9:04] best was 946.
[9:07] And remember, it scores zero in the
[9:09] Yahtzee box two games out of three.
[9:12] The perfect player does not chase the
[9:13] big boxes. So, what is it doing? Here is
[9:16] the gap, box by box. 46 points a game,
[9:20] and I'll show you where every one of
[9:21] them lives. The top section, ones
[9:23] through sixes. Perfect averages 62.78
[9:26] points there. Normal 42.52.
[9:30] That's 20 points more.
[9:31] Then, the bonus. You need 63, which is
[9:35] exactly three of every face. The perfect
[9:38] player wins it in 68.15%
[9:40] of games. The normal player 2.88. 35
[9:44] points times that gap is another 22.84
[9:47] points a game. Add the two.
[9:50] 43.1 of the 46.4 points of the gap.
[9:55] The top section is 93% of the
[9:57] difference. Look at the big faces. In
[10:00] sixes, perfect averages 19.19 points,
[10:04] which is more than three sixes every
[10:05] game. Normal 13.34.
[10:09] Fives, 15.69 against 10.58.
[10:13] Fours, 12.16 against 8.17.
[10:18] The rest of the card is small. Large
[10:20] straight, chance, small straight, and
[10:22] three of a kind add up to about 12.8
[10:25] points of advantage. And the perfect
[10:27] player gives some back.
[10:29] It scores about 4.3 less in four of a
[10:31] kind, 2.8 less in the Yahtzee box, 1.6
[10:35] less in extra Yahtzee bonuses, and under
[10:38] one point less in full house. About nine
[10:40] and a half points thrown away on
[10:42] purpose. The perfect player isn't the
[10:45] one with the best dice. It's the one
[10:47] that fills the top of the card. So,
[10:48] here's the habit I promised. Take the
[10:50] normal player. The number to beat is its
[10:52] 208.25.
[10:54] Anything above that helps. Anything
[10:56] below it hurts. Now, change one rule.
[11:00] Whenever a roll has three or more of a
[11:01] face, and that face's top box is open,
[11:04] it goes in the top box. Three fours go
[11:06] in fours. Three sixes go in sixes.
[11:10] That's all. A rolled Yahtzee still goes
[11:12] in the Yahtzee box while that box is
[11:14] open. I call it hunt the upper bonus.
[11:16] Result, 215.48.
[11:19] Seven points better. It wins the bonus
[11:21] in 20.30%
[11:23] of games instead of 2.88. And it beats
[11:26] the normal player 54.5%
[11:29] of the time, counting ties as half. That
[11:31] one rule gets you about a sixth of the
[11:33] way from normal to perfect. And it's the
[11:36] rule almost nobody follows. Notice what
[11:38] it isn't. It isn't perfect. The perfect
[11:41] player wins the bonus 68% of the time,
[11:44] and the hunter only 20.
[11:45] Doing it well still matters. So, what
[11:48] does doing it well look like? A warning
[11:50] first. Every example here comes from the
[11:53] first turn of a game on an empty score
[11:55] card. Later, the best move depends on
[11:57] what's still open.
[11:59] So, read these as on your first turn,
[12:01] not as laws. Each cost is how many
[12:04] points of final score you lose on
[12:06] average by choosing the other way.
[12:09] You roll three sixes,
[12:11] a two,
[12:13] and a one. Keep the three sixes.
[12:16] Keep the two as well and you lose 3.84
[12:19] points. Keep everything and you lose
[12:21] 6.98. You roll two fives, two sixes, and
[12:25] a two. Two pairs. Keep only the sixes.
[12:29] Keeping both pairs costs 2.97.
[12:32] Four ones and a four. Keep the ones and
[12:35] re-roll the four. Stopping there costs
[12:37] 10.11.
[12:39] Two, three, four, five, and a second
[12:43] five. Keep the four in a row and re-roll
[12:45] the pair. Keeping the pair of fives
[12:47] instead costs 1.86.
[12:50] Standing still costs 3.33.
[12:54] One, two, three, four, and a six.
[12:57] You already have a small straight. The
[12:59] perfect player keeps 1 2 3 4 and
[13:01] re-rolls the six anyway. Standing on the
[13:03] small straight costs 2.08. And now, the
[13:07] moment that surprised me most. You roll
[13:09] three threes and two fives. A full house
[13:12] on your first roll. 25 points right
[13:14] there. Most of us stop. The perfect
[13:17] player keeps the three threes and
[13:18] re-rolls the fives. It breaks a full
[13:20] house. Standing on it costs 5.74.
[13:24] Why? It's giving up a sure 25 for a shot
[13:27] at more threes, a Yahtzee, and a start
[13:30] on the bonus.
[13:31] But now give it the same dice on the
[13:33] last roll. Three threes and two fives.
[13:35] Nothing left to roll.
[13:37] Full house for 25 or threes for nine?
[13:40] Full house by 5.18.
[13:43] Same dice, opposite answer. What changed
[13:46] is how many rolls are left. Now where
[13:49] the dice go. Three sixes, a two, and a
[13:52] one. Sixes, 18 points. Not three of a
[13:56] kind for 21. That would cost 3.57.
[14:00] Three sixes, a five, and a four. Three
[14:03] of a kind, 27. Putting those in sixes
[14:06] for 18 costs 2.43. Same three sixes,
[14:10] different leftovers, different box.
[14:12] Three fours, a two, and a one. Fours, 12
[14:17] points. Three of a kind for 15 would
[14:19] cost 8.46.
[14:22] Three ones, a two, and a three ones.
[14:25] Three points. Three of a kind for eight
[14:28] costs 11.37.
[14:31] And junk. Two sixes, two fives, and a
[14:35] three. Adds to 25. Chance. Not ones for
[14:39] zero, which costs 8.06, but a one, a
[14:43] one, a two, a four, and a six.
[14:47] Ones for two points. Chance for 14 would
[14:50] cost 8.43.
[14:52] Five sixes goes in the Yahtzee box for
[14:54] 50. Yes, even the perfect player does
[14:57] that. Putting it in sixes for 30 would
[15:00] cost 41.36.
[15:02] Now, the habits that cost you.
[15:04] Stop after two rolls. This is the sister
[15:07] who rolls twice, see something fine, and
[15:09] puts the cup down. It averages 161.83.
[15:15] That's 46.4 points below normal. It's
[15:18] about as much as the whole gap between a
[15:19] normal player and a perfect one, only
[15:22] going the wrong way. It fills the
[15:23] Yahtzee box with 50 in just 12.52% of
[15:26] games. It reaches 300 in fewer than one
[15:29] game in a hundred.
[15:30] And it beats the normal player 23.4% of
[15:33] the time. The third roll is free.
[15:35] Skipping it feels efficient. It's most
[15:37] expensive habit in the video.
[15:39] Next, save chance for last. Chance feels
[15:42] like an emergency exit, so you keep it
[15:44] empty for a disaster. This player
[15:46] averages 202.19,
[15:48] which is six points below normal. It
[15:50] beats the normal player 46.1% of the
[15:53] time. It's a small mistake, and here's
[15:55] why.
[15:57] With chance held back, the next bad roll
[15:59] has to go somewhere else, usually into a
[16:01] box you still wanted. This player ends
[16:04] the game with four of a kind empty 10%
[16:06] of the time against seven. Small
[16:08] straight, 12 against 10. Large straight,
[16:11] 33 against 30.
[16:12] And the last one,
[16:14] scratch Yahtzee first.
[16:16] When a roll is worthless, cross out the
[16:18] Yahtzee box before you touch ones. 200
[16:22] 7.56.
[16:24] That's less than a point below normal,
[16:26] and it wins 49.6% of the time. That's
[16:29] almost a coin flip. So, the question
[16:31] every table argues about, should I
[16:33] scratch my Yahtzee box?
[16:35] Barely matters for a normal player.
[16:38] The real losses are somewhere else.
[16:40] Now, I know what you're thinking.
[16:43] Perfect play is a computer.
[16:45] Nobody can remember a million score card
[16:46] states. Fair.
[16:49] But, you can remember six rules.
[16:51] One.
[16:54] Early in the game,
[16:56] three of a kind goes in the top box,
[16:59] not in three of a kind, unless the other
[17:02] two dice are high. Two.
[17:04] Keep one pair, the higher one, not two
[17:08] pairs. Three.
[17:10] A full house on your first roll is a
[17:11] starting point, not a finish.
[17:14] Four. Keep an open-ended run of four,
[17:17] like two, three, four, five,
[17:21] over a pair. Five. A low junk roll goes
[17:24] in ones. A high junk roll goes in
[17:26] chance. Six. Never stop rolling early.
[17:29] Now, the limits.
[17:31] Because I said I'd come back to them,
[17:33] the perfect player maximizes its average
[17:35] score.
[17:36] It isn't trying to beat anyone.
[17:38] Against a particular opponent, someone
[17:40] far behind late in the game might take
[17:42] bigger risks than it does.
[17:44] I didn't test that. Normal is my
[17:46] definition of a family player.
[17:49] Real tables vary.
[17:51] Maybe your uncle is better than my
[17:52] normal player. I hope he is.
[17:55] These are the official Hasbro rules,
[17:57] with the forced joker.
[17:59] House rules, like placing a joker
[18:01] anywhere you like, change the perfect
[18:04] score slightly. That's why I keep saying
[18:06] about 254.6.
[18:09] And the 1,005-point game is a simulated
[18:12] game. It isn't a world record.
[18:14] The most a card can ever hold is 1,575.
[18:18] One more limit, and it's the human one.
[18:21] A computer never shakes the cup. It
[18:23] never groans at a bad roll. It never
[18:25] says come on, come on at three dice
[18:28] rolling across the table or argues about
[18:30] whether that die was cocked.
[18:33] That half of Yahtzee is still yours. So
[18:35] tell me in the comments
[18:37] which game should I simulate next?
