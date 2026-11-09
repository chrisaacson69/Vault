---
source: https://www.youtube.com/watch?v=ijkDbdlpY6c
author: Let's Get Into It
channel: https://www.youtube.com/@LetsGetIntoItMedia
title: "How to win Clue (Cluedo board game BEST strategy) #SoME3 • Episode 1 • Coding a Clue Solver"
clipped: 2026-11-08
published: 2023-08-17
type: youtube
duration: "18:35"
transcript: auto-generated captions (asr, en-orig), via yt-dlp json3
---

[0:00] welcome to the channel it's so nice to
[0:03] have you here for my very first YouTube
[0:05] video ever this video is about the board
[0:08] game Clue and how the default strategy
[0:10] for playing it is all wrong by learning
[0:13] the tips and strategies in this video
[0:15] you'll be able to crush your friends at
[0:17] the game and finally prove to them who's
[0:20] smarter than them at this very specific
[0:23] contrived murder mystery board game so
[0:26] today our goals are first to learn the
[0:28] rules of Clue thoroughly second to learn
[0:31] the strategy you're supposed to use and
[0:33] use examples to learn why that's not the
[0:35] best and third I'll teach you how to
[0:37] play the game even better we'll come up
[0:40] with a nice notation system and a
[0:42] precise procedure you can use to deduce
[0:44] all the knowledge you can and solve the
[0:46] murder mystery before anybody else does
[0:49] [Music]
[0:52] I'm a software engineer with over 10
[0:55] years of experience in Silicon Valley
[0:56] I've always been a technical thinker
[0:58] throughout my whole life whether it's
[0:59] been graphing little games and programs
[1:01] on my calculator working through this
[1:04] exact problem one summer when my family
[1:06] got super into this game and of course
[1:08] throughout my whole career throughout my
[1:10] career I've honed what I think is my
[1:12] best skill at work which is analyzing
[1:14] problems and breaking them down into
[1:15] smaller chunks so we can build them
[1:17] piece by piece and that's exactly what
[1:20] we'll do in this video
[1:22] so with all that said I think we're
[1:24] ready to get problem solving so let's
[1:26] get into it
[1:30] [Music]
[1:35] so like I said the board game Clue is a
[1:38] logical deduction board and card game in
[1:41] the game players play Fancy characters
[1:43] invited to a fancy mansion for a dinner
[1:45] party and of course at this dinner party
[1:48] there's been a murder it's player's job
[1:50] to solve that Murder by asking questions
[1:52] and logically deducing who did the
[1:55] murder with what weapon in which room
[1:57] when I was growing up my family got
[1:59] super into this game one summer and it
[2:01] ended up being the second programming
[2:04] project I ever did in my life so now
[2:06] with a lot more programming experience
[2:07] under my belt I want to revisit this
[2:10] topic and hopefully do it better
[2:14] okay so how do you play
[2:16] foreign
[2:17] [Music]
[2:19] there are six suspects six weapons and
[2:22] nine rooms suspects are people like
[2:25] Colonel Mustard Professor Plum Mrs White
[2:28] Etc weapons are things like the knife
[2:30] revolver or the wrench and rooms are
[2:33] rooms like kitchen Ballroom Library
[2:37] Etc to set the game up you first take
[2:39] one card from each category and put them
[2:41] at random into a little case File nobody
[2:44] knows which three cards are in this case
[2:46] File and it's what defines the murder
[2:48] who did the murder with which weapon in
[2:51] which room you then take this little
[2:53] case File pouch and put it aside for the
[2:55] rest of the game
[2:57] until somebody thinks they've solved the
[2:59] murder and we'll get into that the rest
[3:01] of the 18 cards are shuffled all
[3:03] together and dealt to all the players
[3:05] each player can see the cards in their
[3:08] hand of course but they don't know what
[3:10] anybody else has players spend the rest
[3:12] of the game interns moving around the
[3:14] board and making suggestions AKA guesses
[3:16] about the murder in order to deduce by a
[3:19] process of elimination which three cards
[3:22] must be in that case File once a player
[3:24] thinks they've solved the murder they
[3:26] make an accusation saying who did the
[3:28] murder with which weapon in which room
[3:30] at which point they open the case File
[3:32] themselves to see if they're right if
[3:35] they were right they say ha and rub it
[3:37] in everyone's faces
[3:39] and if they're wrong they go into a
[3:41] corner and cry while everyone else
[3:43] continues the game
[3:44] there is also a game board in the middle
[3:47] of the table where players roll dice and
[3:49] walk around the mansion from room to
[3:51] room making these guesses but our clue
[3:53] solver won't really deal with that at
[3:55] all so let's just forget that for the
[3:57] rest of the series to keep our lives
[3:58] simple
[4:00] uh you wanna clean that drawing up a
[4:04] little bit
[4:06] great thanks
[4:13] [Music]
[4:17] okay so the Crux of the game is this
[4:19] logical deductions through making
[4:21] suggestions so how do you do that
[4:27] on a player's turn
[4:30] if they're on a room on the board but
[4:31] again let's forget about the board a
[4:33] player can make a suggestion by listing
[4:35] out the three cards they think might be
[4:37] in the murder a suspect a weapon and a
[4:39] room
[4:40] you know I'm not trying to point fingers
[4:43] or anything but I think maybe the murder
[4:45] was done by Colonel Mustard with the
[4:47] revolver in the ballroom once a player
[4:49] makes that suggestion the other players
[4:51] go in reverse order and are obligated to
[4:54] show one of the cards from that
[4:56] suggestion if they have it in their hand
[4:58] if they don't have any of the cards then
[5:00] they pass so as an example let's say
[5:02] that Anisha suggests Colonel Mustard
[5:04] with the revolver in the ballroom Cho
[5:07] gets the first chance to refute and she
[5:09] says she's unable to so she passes
[5:13] Bob says he can refute and shows Anisha
[5:16] a card
[5:17] if we're an outside Observer that's all
[5:19] we know Bob showed some card to Anisha
[5:21] but we don't know what it is so let's
[5:23] pretend for a second that we are Anisha
[5:25] and Bob showed us the revolver
[5:27] as Anisha we now know that the murder
[5:29] couldn't have been done with the
[5:30] revolver because that card is in Bob's
[5:33] hand and not in the case File it's a
[5:36] pretty simple process of elimination so
[5:38] to keep track of it all the game comes
[5:40] with little checklists in the Box for
[5:42] everyone to use to cross off the cards
[5:44] as they make suggestions and eliminate
[5:46] them
[5:47] [Music]
[5:51] so the checklist
[5:53] go ahead I'll give you a second
[5:59] go ahead take your time
[6:05] this is what the checklist that comes
[6:07] out of the box looks like I've shortened
[6:09] it up here to keep it small but it would
[6:12] have all 21 cards in the game listed out
[6:14] so again in the previous example if we
[6:16] are Anisha and Bob showed us the
[6:18] revolver we would go to this checklist
[6:20] and check it off saying nope it can't be
[6:23] the revolver
[6:25] it's also worth mentioning that right at
[6:27] the beginning when players are dealt
[6:28] their cards they can immediately cross
[6:30] off every single one of those from the
[6:32] checklist so the game proceeds like this
[6:34] in a pretty simple suggestion refutation
[6:37] process of elimination cross off a card
[6:40] one by one by one until you finally have
[6:42] three left and that's when you know who
[6:44] did the murder because those three cards
[6:46] must be the ones in the case File so
[6:48] pretty simple just process of
[6:50] elimination one by one
[6:52] why are we doing this again it turns out
[6:55] that the logic is actually a little more
[6:57] complex which we'll get to in a second
[7:02] okay so as I hinted before the logic
[7:05] gets a little bit more complicated so
[7:07] let's illustrate that with some examples
[7:09] for our first example let's once again
[7:11] say we're playing as Anisha and we have
[7:13] Colonel Mustard the wrench and the
[7:16] dining room
[7:18] Cho makes a suggestion of Colonel
[7:20] Mustard the knife and the dining room
[7:22] Bob is able to refute it and he shows
[7:25] her a card
[7:26] though we didn't see the card that Bob
[7:28] showed of course we know what it was we
[7:31] have Colonel Mustard and we have the
[7:32] dining room so the only card Bob could
[7:34] have used to refute was the knife
[7:39] so therefore we can cross off the knife
[7:41] on our checklist
[7:43] notice in this example we were able to
[7:45] eliminate a card even though we didn't
[7:47] see it ourselves but you can actually do
[7:49] even better than that
[7:51] in a different game let's say that
[7:53] someone suggests Professor Plum with the
[7:55] lid pipe in the library and Chelsea is
[7:58] able to refute showing a card
[8:00] later on somebody suggests Miss Scarlet
[8:03] with the lead pipe in the library and
[8:05] this time Chelsea is unable to refute
[8:07] in this case we now retroactively know
[8:10] which cards she used for that first
[8:12] guess
[8:13] it has to be Professor plum because she
[8:15] doesn't have the lead pipe and she
[8:16] doesn't have the library or else she
[8:18] would have been able to refute that
[8:19] second sedition
[8:21] notice in this case we never saw the
[8:24] card she used to refute and we're not
[8:26] basing it on the cards in our own hand
[8:27] so it's basically common knowledge now
[8:30] that Chelsea has Professor plum
[8:37] continuing the example let's say we have
[8:39] the kitchen in our hand
[8:41] somebody suggests Professor Plum with
[8:43] the rope in the kitchen
[8:45] we could refute with the kitchen but
[8:47] before it's our chance Beau refutes with
[8:49] a card
[8:50] again we immediately know what boat
[8:52] refuted with we have the kitchen we
[8:54] already know Chelsea has Professor Plum
[8:56] so Beau must have had the Rope
[8:59] in this example we're combining multiple
[9:01] bits of knowledge together to deduce new
[9:04] bits of knowledge the more knowledge we
[9:07] have the more we can deduce the more
[9:09] knowledge we have the more we can deduce
[9:11] Etc so as my family was playing this all
[9:14] summer and we were discovering these
[9:16] deduction rules we were having a hard
[9:18] time keeping track of it all
[9:20] and as a kid with nothing better to do
[9:22] that summer I came up with a better
[9:24] format for the checklist
[9:37] editor guy speed this up
[9:40] thank you
[9:41] [Music]
[9:50] basically in this new checklist we're
[9:52] tracking as much game state
[9:54] or knowledge State as possible
[9:57] not just what we've directly seen But
[9:59] every possible place that every card
[10:01] could possibly be
[10:04] this new checklist has two parts the
[10:06] checklist on top which tracks where all
[10:09] the cards are in all the players hands
[10:11] and the suggestion log underneath
[10:13] tracking all the suggestions that every
[10:15] player has ever made
[10:17] in the checklist on top we're tracking
[10:19] three states for every card and player
[10:22] for a particular card and player we can
[10:24] either definitely know that they have it
[10:27] in which case we put a y
[10:29] or we can definitely know that they do
[10:31] not have that card in which case we put
[10:33] an n
[10:35] otherwise it's an unknown and we leave
[10:38] it blank
[10:40] [Music]
[10:43] down at the bottom we're basically just
[10:45] taking notes about the suggestions who
[10:47] said what who refuted it Etc
[10:51] we can work with this checklist in rules
[10:53] that fall into two categories the first
[10:55] category I like to call consistency
[10:57] rules these rules deal with just the
[11:00] checklist on the top making sure that
[11:02] everything is logically consistent and
[11:03] makes sense for example if we have a y
[11:06] in one row then we know that everything
[11:08] else is an N because if one person has a
[11:11] card then nobody else can also if we
[11:14] know how many cards a player has and
[11:16] we've accounted for that many y's in
[11:18] that column then we can mark all the
[11:20] rest of them as ends for example if Bob
[11:22] has five cards and we've identified all
[11:24] five of them then we know he doesn't
[11:26] have any of the rest
[11:26] [Music]
[11:32] and for the case File we know that
[11:34] there's only one card of each category
[11:36] so if we have a y for one suspect in the
[11:39] case File we know the rest of the
[11:41] suspects have ends
[11:44] the second way we can work with the
[11:46] checklist is what I call deduction rules
[11:48] these concern the suggestion log at the
[11:50] bottom basically folding in new
[11:52] information as we can so let's see how
[11:55] this checklist works with our examples
[11:57] from before
[11:58] [Music]
[12:00] thank you in the second example we only
[12:02] gave Chelsea a name so let's just say
[12:04] she is playing against Alex and Beau
[12:08] so Beau suggests Professor Plum with the
[12:10] lead pipe in the library we write this
[12:13] in the suggestion log as follows
[12:15] we write Bo in the First Column because
[12:16] he was the person suggesting we write
[12:19] the three cards that he suggested
[12:21] and then in the columns for the other
[12:22] players we write what happened so right
[12:26] off the bat we can put a little squiggle
[12:27] under Bo's name there because he's the
[12:29] suggestor we're not going to be able to
[12:31] get any information about his cards
[12:33] and this wasn't in the example before
[12:35] but let's say Alex was unable to refute
[12:37] at that point we can put an X under his
[12:39] name indicating that he doesn't have any
[12:41] of those cards
[12:43] and then Chelsea is able to refute so we
[12:45] put a mini checklist under her name in
[12:48] this room
[12:49] later someone else let's say Alex
[12:51] suggests Miss Scarlett with the lead
[12:53] pipe in the library
[12:56] again right off the bat we can put a
[12:58] squiggly under Alex's name because he's
[13:00] the suggestor
[13:02] he's the suggestor and we won't be able
[13:05] to learn anything about his cards then
[13:07] immediately Chelsea passes she's not
[13:09] able to refute so we put an X under her
[13:11] name and then doesn't really matter but
[13:14] let's say Bo is also not able to refute
[13:16] usually in the game that would be a lot
[13:18] of information but let's just kind of
[13:19] scratch that out
[13:21] so we were able to quickly write down
[13:23] what happened and now it's time to
[13:24] process that information let's do this
[13:27] suggestion by suggestion in the first
[13:29] one it's easy Alex was not able to
[13:31] refute he has an X so we can go up to
[13:34] the checklist and quickly put an N for
[13:36] all the three cards that were suggested
[13:41] for Chelsea there's not really much we
[13:43] can do at this point we don't know if
[13:44] she does or doesn't own any of these
[13:46] cards so we just move on in the second
[13:48] suggestion we can also say that Bo and
[13:50] Chelsea don't have any of these cards so
[13:53] we can put six ends up on the checklist
[13:57] at this point we've gotten all the info
[13:58] we can out of the second suggestion so I
[14:00] like to put a little check mark there to
[14:02] say we don't need to look at it again
[14:04] but we have discovered some new
[14:06] information which means we might be able
[14:08] to deduce more so we gotta go through
[14:10] the list of suggestions again starting
[14:12] back at the first one we've already
[14:13] processed Alex's X so now it's time to
[14:16] look at Chelsea's cell
[14:18] for each of these three cards we check
[14:19] whether she has them and if she doesn't
[14:21] we cross it off this little mini
[14:23] checklist
[14:24] turns out we've crossed off two out of
[14:26] three of them so we can Circle the last
[14:28] one because that's the card she refuted
[14:30] with and then go back up to the
[14:32] checklist to put a y in that space
[14:34] at this point we've gotten all the
[14:36] information out of the first suggestion
[14:38] so we can put a check mark there and
[14:39] move on we should also quickly apply our
[14:42] consistency rules
[14:45] [Music]
[14:55] and as it turns out I wasn't thinking
[14:57] about this at all but in this example
[15:00] we've figured out the weapon and the
[15:03] room
[15:03] [Music]
[15:05] like I said when two people aren't able
[15:07] to refute a guess it gives you a lot of
[15:09] information especially when the third
[15:11] person also wasn't able to refute with
[15:14] very similar cards
[15:16] so finally let's just list out all these
[15:18] consistency and deduction rules we're
[15:20] going to be coding them up later so we
[15:22] might as well have a full list of them
[15:24] right now
[15:26] [Music]
[15:29] so first off for every row if there's a
[15:32] y somewhere in that Row the rest are
[15:34] ends
[15:35] basically a card can only exist in one
[15:38] place the inverses if a row has ends in
[15:42] every place except for one we know that
[15:44] last one must be a y
[15:47] in other words the card must exist
[15:49] somewhere
[15:50] next for every player since we know the
[15:53] number of cards they have if we've
[15:54] accounted for all of those with y's we
[15:57] know the rest of the column should be
[15:58] filled with ends
[16:00] likewise the inverse of that is if we've
[16:02] eliminated all but that number of cars
[16:05] arise with ends then we know the rest
[16:08] must be wise that almost never happens
[16:10] in real life but it's there for the case
[16:14] File We have basically the same thing
[16:16] except it's one card per category if
[16:19] there's a single Y in one category then
[16:20] we know the rest are ends if there's n's
[16:23] everywhere except for one spot in the
[16:25] category that last one must be a y
[16:27] and then our deduction rules
[16:30] for each guess for each player that was
[16:33] given the opportunity but unable to
[16:35] refute a guess we know they don't have
[16:37] any of those cards
[16:39] for each player that was able to refute
[16:41] a suggestion they must have one of those
[16:43] three cards if we're able to eliminate
[16:46] one of them we can cross it off the list
[16:49] once we're able to eliminate two we know
[16:51] they must have refuted with the third
[16:53] and therefore have the Third
[16:57] it's also worth the reminder that we can
[16:59] never get information about the
[17:00] suggestor since I could always
[17:02] technically make a suggestion for three
[17:04] cards they have already themselves and
[17:07] we don't get any information from
[17:09] players who didn't even get a chance to
[17:11] refute that suggestion
[17:13] so there we have all of our consistency
[17:15] and deduction rules listed out together
[17:18] we've accomplished a lot in this video
[17:20] we learned about clue the rules how to
[17:22] play how to deduce how to deduce better
[17:25] how to checklist better and we have a
[17:27] nice notation system to track all the
[17:29] knowledge that we have and process new
[17:31] suggestions in order to deduce new
[17:33] knowledge and finally listing out all
[17:36] the deduction rules and consistency
[17:38] rules that we'll be coding up later it
[17:40] also turns out that these induction
[17:42] rules can't get everything
[17:44] that's a little bit of a spoiler and
[17:46] we'll get there later if you enjoy this
[17:48] video please let me know in the comments
[17:50] hopefully I'm pointing in the right
[17:51] place give the video a like And
[17:53] subscribe so you don't miss the next one
[17:55] we can continue building off of our
[17:57] knowledge develop the data structures
[17:58] and algorithms we need and eventually
[18:00] make it into an actual web app there are
[18:03] so many places we can go with this topic
[18:05] building on top of each other until we
[18:07] build our web app and little sidebars
[18:09] that we can explore along the way here's
[18:12] a few that I can think of just to get
[18:13] you excited so again let me know which
[18:15] topics you want to explore and we'll get
[18:17] into it I'll see you down there and
[18:20] until next time
[18:22] bye bye
[18:23] [Music]
[18:26] foreign
[18:30] [Music]
