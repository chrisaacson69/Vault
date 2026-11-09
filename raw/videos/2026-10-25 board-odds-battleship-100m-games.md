---
source: https://www.youtube.com/watch?v=b1c0Yg9t6EM
author: Board Odds
channel: https://www.youtube.com/@BoardOdds
title: "The Best Battleship Strategy, Tested on 100 Million Games"
clipped: 2026-11-08
published: 2026-10-25
type: youtube
duration: "15:00"
transcript: auto-generated captions (asr, en-orig), via yt-dlp json3
---

[0:00] Everybody at the table has a battleship
[0:01] strategy. Your uncle fires at random
[0:04] until he hits something, then pokes
[0:06] around it. Your sister only shoots every
[0:08] other square, like a chessboard.
[0:11] Somebody always hides their ships along
[0:14] the edge, and there's always one person
[0:16] who lines their ships up side by side so
[0:19] they can keep each other company. So, I
[0:21] turned four of those shooting habits and
[0:23] six of those hiding habits into computer
[0:25] players and made them play 100 million
[0:27] games. In the main tournament, the best
[0:30] pairing won 77.6%
[0:32] of its games. The worst won 12.7.
[0:35] And what separated them wasn't a clever
[0:37] trick. It was a handful of common
[0:39] habits, and you've probably got a few of
[0:42] them. You know who you are. Along the
[0:44] way, the spot everybody tells you to
[0:46] hide in turns out to do nothing against
[0:48] most players and to be the best spot on
[0:50] the board against the smartest one. And
[0:52] a simple shooter with good hiding turns
[0:54] out to beat a genius with bad hiding.
[0:56] First, a quick word on whether you can
[0:58] trust a battleship game played by a
[1:00] computer. I'm using the classic rules. A
[1:03] 10 by 10 grid, five ships two squares
[1:06] long, three, three, four, and five. 17
[1:11] ship squares in all. One shot per turn.
[1:15] And when a ship goes down, the other
[1:17] player is told.
[1:18] No salvo rules, no extras. Before I
[1:21] trust any result, I need to know the
[1:23] simulator is honest. So, I ran four
[1:26] checks where I already knew the right
[1:27] answer. Check one.
[1:30] Two normal players, the kind who fire at
[1:32] random until they get a hit and then
[1:34] hunt around it, play each other 3
[1:36] million times.
[1:38] Neither should have an edge. The first
[1:39] one won 49.96%.
[1:42] Fair. Check two. A player with randomly
[1:45] placed ships against that normal player
[1:47] should be an even match. This is the
[1:49] standard everything else gets compared
[1:50] with. I got 49.98%.
[1:53] Check three is the one that matters
[1:55] most. A shooter who fires completely
[1:57] blind can't be affected by where the
[1:58] ships are hidden. So, I made one shoot
[2:01] at all six hiding styles.
[2:03] It needed 95.4 shots against every one
[2:06] of them.
[2:07] The same number six times.
[2:10] If my ship placement had a bug, this is
[2:12] where it would show.
[2:14] Check four. I worked out each shooter's
[2:16] head-to-head odds from its shot counts
[2:18] alone, then compared them with the
[2:19] matches I actually simulated. The
[2:22] stronger shooter, 76.4% worked out,
[2:25] 76.35 simulated. The middle one, 67.8,
[2:30] then 67.85.
[2:32] The blind one,
[2:34] 1.1,
[2:35] then 1.13.
[2:37] They agree.
[2:39] The margin of error is about plus or
[2:40] minus 0.06 points on each 3 million game
[2:44] test, and about 0.02
[2:46] on the 70 million game tournament. When
[2:48] two numbers are closer than that, call
[2:50] it a tie. Now, the part I need to be
[2:52] honest about.
[2:54] My computer players never learn your
[2:55] habits from one game to the next. And
[2:58] nobody can run my best shooter in their
[2:59] head. Hold on to those two, because I'm
[3:02] coming back to them at the end. Now,
[3:04] meet the four shooters. They all get the
[3:06] same board and the same rules. They only
[3:08] differ in how they choose the next shot.
[3:10] I tested each one against randomly
[3:12] placed ships and counted how many shots
[3:14] it needed to sink the whole fleet. At
[3:17] the bottom, random. It fires at any
[3:19] square it hasn't tried. On average, it
[3:22] needs 95.4 shots on a board with 100
[3:26] squares.
[3:27] A blind shot hits one time in six, and
[3:30] that's all it has going for it.
[3:32] In 17% of its games, it takes the entire
[3:35] board. And in 38 million tries, it never
[3:39] once finished in under 41 shots.
[3:42] Next, hunter. This is the normal player,
[3:44] the person at your table, and the
[3:46] baseline for the whole video. It fires
[3:48] at random until it hits something, then
[3:51] hunts around the hit, and follows the
[3:53] line once it has two. 59.8 shots on
[3:57] average. It's also the wildest of the
[3:59] four. The fastest tenth of its games
[4:02] finish in 41 shots or fewer, and the
[4:04] slowest tenth take 80 or more. Then,
[4:07] checkerboard. It only shoots squares of
[4:09] one color,
[4:11] like a chessboard, so every ship, even
[4:13] the smallest, has to sit across at least
[4:15] one of them. 51 shots on average, and
[4:18] the steadiest shooter of the four.
[4:21] Nearly every one of its games, 99.4%
[4:24] is over within 70 shots.
[4:27] And at the top, Heatmap. After every
[4:29] shot, it works out where the ships left
[4:31] could still fit, then fires at the
[4:33] square that fits the most of them. That
[4:35] sends it to the middle first.
[4:37] 46.6 shots on average. The fastest tenth
[4:41] of its games are done in 35.
[4:43] And here's the number I like most. Every
[4:45] one of its 38 million games finished
[4:48] within 85 shots.
[4:50] The other three sometimes needed a
[4:51] hundred. Let's talk about perfect games.
[4:54] That means all 17 shots hit with no
[4:56] misses at all. Heatmap managed 761 of
[4:59] them in 38 million games, about one in
[5:01] 50,000.
[5:03] The normal player did it once in about
[5:05] 500,000. So, Heatmap plays a perfect
[5:07] game roughly 10 times as often. Here's
[5:10] how the difference looks in a real game.
[5:12] The normal player fires into open water,
[5:14] miss after miss, with no plan. Then,
[5:18] finally, a hit. Now it turns careful. It
[5:22] tries the squares around that hit, finds
[5:24] a second one, and now it knows which
[5:26] line the ship lies on. So, it follows
[5:28] that line until the ship goes down. Then
[5:30] it goes back to firing at random.
[5:32] Heatmap never goes back to random.
[5:35] After every single shot, hit or miss, it
[5:37] redraws its picture of where the ships
[5:39] can still be.
[5:40] A miss in the middle of the board isn't
[5:42] wasted. It rules out every ship position
[5:45] that crossed that square. It feels like
[5:47] it's reading your mind. It's just doing
[5:49] arithmetic faster than you can.
[5:51] Now, put them against each other.
[5:54] Random wins 1.1% of its games against
[5:57] the normal player.
[5:58] Checkerboard beats the normal player
[6:00] 67.8%
[6:02] of the time. Heatmap beats it 76.4,
[6:05] and Heatmap beats Checkerboard 64.2.
[6:08] Why only 64 against Checkerboard when it
[6:11] beats the normal player 76?
[6:14] Because Checkerboard is already close to
[6:15] it.
[6:16] The difference is speed. 67% of
[6:19] Heatmap's games are over within 50
[6:21] shots.
[6:22] For Checkerboard, it's 46%.
[6:25] That's the whole edge.
[6:27] That's a ranking.
[6:29] It doesn't tell you much about hiding,
[6:31] though. So, here's how I tested that.
[6:34] The shooters stay the same and I change
[6:36] only where the ships hide.
[6:37] One style at a time. The number to beat
[6:40] is 50%. That's what randomly placed
[6:42] ships win against the normal player. So,
[6:45] any hiding style above it helps and any
[6:47] style below it hurts. But, before the
[6:49] hiding results,
[6:51] the most important finding in the video,
[6:53] in the 70 million game tournament, the
[6:55] four shooters finished anywhere from
[6:57] 12.8%
[6:58] to 71.2%,
[7:00] a gap of 58 points. The six hiding
[7:03] styles finished from 44.1 to 54.4,
[7:08] a gap of 10. How you shoot matters about
[7:10] six times more than where you hide. So,
[7:12] if you only fix one thing, fix your
[7:14] shooting.
[7:15] No hiding style saves a blind shooter.
[7:18] With any of them, random wins 12.7 to
[7:20] 12.8%.
[7:22] But, hiding is where the surprises are.
[7:24] So, here are the styles. Random
[7:26] placement, the baseline. Spread out,
[7:28] where no ship touches another. Edges,
[7:31] cold squares, which means the layout on
[7:33] the least likely squares.
[7:35] Center
[7:37] and touching. For each one, I'll give
[7:39] you two things.
[7:41] How often it wins against the normal
[7:42] player
[7:43] and how many shots sooner or later your
[7:45] fleet falls against the three shooters
[7:46] that aren't blind. A plus means you
[7:48] survive longer. A minus means you fall
[7:51] sooner. Mistake one, touching ships. It
[7:54] feels natural. You put your ships next
[7:56] to each other, tucked in a corner of
[7:58] your territory, and you figure you're
[7:59] hard to find.
[8:01] You are not. The touching players among
[8:03] you, I'm sorry. Against the normal
[8:05] player, touching won 40.5%.
[8:09] That's almost 10 points under the
[8:10] baseline.
[8:11] And look at how much faster the shooters
[8:13] finish. Against the normal player, your
[8:15] fleet falls 5.3 shots sooner. Against
[8:18] checkerboard, 4.5 sooner. And against
[8:21] heat map,
[8:22] 7.5.
[8:24] The reason is simple. Hitting one ship
[8:26] leads the shooter straight into the next
[8:27] one. You've built a chain, and the first
[8:30] hit is the end of it. Mistake two,
[8:32] hiding in the middle.
[8:34] You'd think the middle is the safest
[8:36] place.
[8:37] It's the biggest target, so nobody
[8:39] expects you to sit there.
[8:41] And nobody does expect it, except one
[8:44] shooter.
[8:45] Against the normal player, center 142.6%
[8:49] Against checkerboard, it costs you 3.2
[8:52] shots.
[8:53] But against heat map, it's the worst
[8:55] thing you can do.
[8:56] 11.7 shots sooner. Heat map needed only
[8:59] 34.9 shots to sink a fleet hiding in the
[9:02] center. That's the fastest it sinks any
[9:05] style. And the reason is the one you
[9:07] already know. Heat map goes to the
[9:08] middle first. You hit exactly where it
[9:11] starts.
[9:12] Mistake three, hiding on the least
[9:14] likely squares. Fine. So, the middle is
[9:16] a trap. What about the opposite? Work
[9:19] out which squares are least likely to
[9:20] hold a ship and hide there. That's cold
[9:23] squares.
[9:24] Against the normal player, 49.9%
[9:28] Basically, the baseline. Against
[9:29] checkerboard, it costs half a shot. The
[9:32] only place it helps is heat map, 3.4
[9:35] shots better.
[9:36] But even that is weak. Heat map
[9:38] recalculates after every miss, so the
[9:40] cold squares don't stay cold for long. A
[9:43] smart idea, tested, and it fades. So,
[9:46] the middle loses.
[9:48] Hiding in odd places barely helps.
[9:51] Now, the one everybody swears by,
[9:53] mistake four,
[9:55] believing the edge advice. Everybody has
[9:57] heard it. Hide on the edges. Nobody
[10:00] checks the middle. Here's the twist.
[10:02] Against the normal player, edges 149.0%
[10:06] just under the baseline. The advice does
[10:08] nothing.
[10:09] The border has only 36 squares and 17
[10:12] ship squares fill almost half of them.
[10:14] So, a hunter who hits one edge ship is
[10:16] already standing next to the others.
[10:18] But then, I ran it against Heat Map and
[10:21] the edges are the best spot of all, six
[10:23] shots better. Heat Map searches the
[10:25] middle first, so the border gets visited
[10:27] last.
[10:29] Think about it from the shooter's side.
[10:31] A normal player has no idea where you
[10:33] are, so the edge is just another square.
[10:36] Heat Map has a strong opinion
[10:38] and its opinion says middle. By hiding
[10:40] on the border, you're betting that its
[10:41] opinion is wrong.
[10:43] Against that shooter, you win the bet.
[10:45] That's why the advice never goes away.
[10:47] It works, but only against strong
[10:50] players. Against your uncle, it does
[10:52] nothing. So, the rule was never hide on
[10:54] the edges.
[10:55] It's hide from the person who's actually
[10:57] shooting at you and the best habit I
[10:59] found in the whole video is the plainest
[11:01] one. Spread out. No ship touches
[11:04] another.
[11:05] It's the only style that helps against
[11:07] every smart shooter. 2.2 shots better
[11:09] against Hunter, 1.9 against
[11:11] Checkerboard, 3.1 against Heat Map, and
[11:14] against the normal player, it won 54.3%
[11:17] the best of all six styles.
[11:20] Here's why.
[11:21] When one of your ships sinks, a hunter
[11:23] searches around it
[11:25] and there's nothing there.
[11:26] It has to start the whole search again.
[11:28] So far, every result has been one
[11:30] shooter against one hiding style. The
[11:33] tournament mixes everything.
[11:35] Every shooter was paired with every
[11:37] hiding style and the pairs played each
[11:40] other 70 million games in all. That's
[11:43] where the real winner shows up. At the
[11:45] top, Heat Map with Spread Out, 77.6%.
[11:50] Then, Heat Map with Edges, 76.1.
[11:53] Heat Map with Cold Squares, 75.2.
[11:57] All the way down to Heat Map with
[11:58] Center, 62.4.
[12:00] Bad hiding cost the best shooter about
[12:02] 15 points. Same shooter, same rules, and
[12:05] only the hiding changed.
[12:07] At the other end, the normal player with
[12:09] touching ships, 45.9.
[12:12] And Random with anything 12.7 to 12.8.
[12:16] But here is the twist I like the most.
[12:18] Check a board with spread out 170.7%.
[12:23] That beats heat map with bad hiding,
[12:25] which sits between 62.4
[12:28] and 62.8. So a simple shooter with good
[12:30] hiding beats a genius with bad hiding.
[12:33] The genius isn't wasted though. Heat map
[12:36] with good hiding still wins the most,
[12:38] but the gap between those two shooters
[12:39] is smaller than the gap between good
[12:41] hiding and bad. Most of us spend all our
[12:44] time thinking about shots, but hiding
[12:46] well is worth about 15 points to the
[12:47] best shooter in the game. What about
[12:49] going first?
[12:51] In Battleship, the first shooter wins
[12:53] 50.9% of the time. In 1.8% of games,
[12:57] both players need the same number of
[12:59] shots and the player who went first wins
[13:02] those. That's worth about one point.
[13:05] Not nothing, but far from the thing that
[13:07] wins a game. So here are six things to
[13:09] take to your next game night. Never fire
[13:12] blindly. Even basic hunting around a hit
[13:14] turns a 1% player into a 50% player.
[13:18] It's the cheapest improvement in the
[13:19] whole game.
[13:21] While you're searching, shoot a
[13:22] checkerboard pattern. 67.8%
[13:25] against a normal player. And it asks
[13:27] nothing of you except to count squares.
[13:30] Start in the middle and keep track of
[13:32] where the ships left could still fit.
[13:34] That's the heat map idea. It won 76.4%.
[13:38] Never let your ships touch. One hit
[13:40] should never lead to the next ship and
[13:42] spread them apart so that a sunk ship
[13:45] leaves the shooter with nothing nearby.
[13:47] If you're facing a strong player, the
[13:49] edges help. If you're facing a casual
[13:51] one, they don't.
[13:53] And don't fight over who goes first.
[13:55] It's worth about a point. Now, the
[13:58] limits because I promised I'd come back
[14:00] to them. Nobody runs a heat map in their
[14:02] head. The human version of what I just
[14:04] told you, a checkerboard pattern plus
[14:06] the middle first, wasn't simulated. So
[14:09] I'm not giving it a number. And you
[14:11] shouldn't trust anyone who does. Real
[14:12] people don't place their ships at random
[14:14] either. That's why I tested six hiding
[14:16] styles, but my computer players don't
[14:19] learn your habits across games. A person
[14:21] across the table will. And a person who
[14:23] sees you hide on the edge twice will
[14:25] check the edge first. A simulation can't
[14:27] capture that, and I'd rather say so than
[14:29] pretend.
[14:30] I only tested classic rules. No salvo,
[14:33] where you fire several shots at once.
[14:35] And I tested edges and spreading out as
[14:37] two separate ideas. I never tried them
[14:40] together. My computer players never
[14:42] noticed that you always put a ship on
[14:44] the same spot.
[14:45] They never get a feeling.
[14:47] And they never grin when they hear the
[14:49] word hit. That half of Battleship is
[14:51] still yours, and nothing I built has
[14:53] touched it. So, tell me in the comments,
[14:56] which board game should I put through
[14:57] 100 million games next?
