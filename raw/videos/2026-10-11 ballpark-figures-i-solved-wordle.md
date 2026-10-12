---
source: https://www.youtube.com/watch?v=h-Rusd72W7U
author: Ballpark Figures
title: "I Solved Wordle*"
clipped: 2026-10-12
published: 2026-10-11
type: youtube
duration: "44:04"
transcript: auto-generated captions (asr), via tools/fetch-youtube-transcript.py
---

[0:00] How should we start a game of Wordle?
[0:04] Well, if we pick a word, then a computer
[0:05] can calculate how many guesses we'll
[0:07] need on average if we play the rest of
[0:09] the game perfectly. For start, that's
[0:11] about 3.6 guesses per game.
[0:14] Some words will win faster
[0:18] and some slower.
[0:26] As we check [music] more words, a
[0:27] pattern starts to emerge.
[0:35] until eventually we've checked every
[0:37] fiveletter [music] word we're allowed to
[0:38] play. All 12,972
[0:42] valid Wordle guesses ranked from best to
[0:45] worst.
[0:48] Your favorite opening is on here
[0:49] somewhere. Hopefully, it's over here to
[0:51] the left. The most popular openers
[0:53] usually are.
[0:55] Here are some of the words that usually
[0:56] show up in the daily top 10.
[0:58] And then we have the two most popular
[1:00] opening words of all. A you and audio.
[1:06] Sorry, I said a Jew and audio.
[1:11] Huh, that's weird.
[1:13] Where are those words?
[1:16] Hello.
[1:18] Oh, there they are. But we found our top
[1:21] two [music] opening words. But not only
[1:22] are they not the best, they're not even
[1:24] average.
[1:25] The internet has no shortage of
[1:27] information about Wordle, but a lot of
[1:28] that information has led us astray.
[1:30] We're going to do the best thing we can
[1:32] do when we don't know what information
[1:33] to trust. We're going to do the math.
[1:35] We'll talk through how a computer can
[1:37] play Wordle perfectly, but also find
[1:39] some lessons on how to improve our own
[1:40] play. We'll learn how to pick an opening
[1:42] word, but we'll also learn why it's the
[1:44] second guess and not the first that
[1:46] makes the biggest difference in the
[1:47] game. Along the way, we'll crack some
[1:49] popular misconceptions about Wordle.
[1:50] We'll figure out why a four vowel opener
[1:52] is just going to slow you down. We'll
[1:54] also see why a lot of simple strategies
[1:56] that people say are guaranteed to win
[1:58] don't actually work. But I'm going to
[2:00] show you a new one that really does. Is
[2:03] this video going to make it more fun to
[2:04] play Wordle? Maybe. Is it going to make
[2:07] it more fun to think about Wordle? I
[2:09] certainly hope so. I spent 2 months on
[2:10] this. So, without further ado, let's
[2:13] begin. As a quick reminder, Wordle is a
[2:16] word guessing game where you have six
[2:18] chances to guess a fiveletter word.
[2:20] After each guess, you're given some
[2:21] information about the accuracy of each
[2:23] letter in your guess. If the letter is
[2:25] in the correct location, it's marked
[2:27] green. If the letter is in the word but
[2:29] not where you placed it, it's marked
[2:30] yellow. Otherwise, it's marked [music]
[2:32] gray. If you guess a letter multiple
[2:35] times, then all the greens are marked
[2:36] along with a yellow for each additional
[2:38] time the letter appears in the word
[2:40] going from left to right. Notice how the
[2:42] second E is marked green and the first
[2:44] one is marked yellow, [music]
[2:45] but the last one is gray, meaning the
[2:47] answer has two E's. After each guess,
[2:50] you're given more information about the
[2:52] final word. If you can guess the word
[2:54] correctly within six guesses, you win
[2:56] the game. Now, Whle is simple enough,
[2:58] but what do we have to do if we want to
[3:00] play the game as well as possible? It
[3:02] starts with something that I'm sure I'll
[3:03] be saying a lot around here. Every game
[3:05] becomes a math game once you have enough
[3:06] skill. In Wordle, that skill is the
[3:09] ability to think of words that match a
[3:10] certain pattern of green and yellow
[3:12] letters. Without that skill, we have no
[3:13] chance of winning. But having the skill,
[3:15] it turns out, is not quite enough. Take
[3:17] a look at this example. Here's a
[3:19] sequence of guesses we can make where
[3:21] every word is an actual wordal answer
[3:23] that matches all the clues leading up to
[3:24] it. We're making good use of our word
[3:26] guessing skill, but these guesses go on
[3:29] and on and on.
[3:32] In a game we should be able to beat in
[3:34] six guesses, we end up using almost
[3:35] three full games worth of guesses, 16 in
[3:39] total. While we need to be able to guess
[3:41] words in order to beat Wordle, it turns
[3:42] out that that alone is not enough. We're
[3:44] going to need some strategy. that starts
[3:46] with reframing how we think about the
[3:48] game. It's less of a word game and more
[3:50] of a puzzle. Let's go back to a
[3:52] refresher on Wordle, but phrased in a
[3:54] slightly different way. Wordle is a
[3:56] puzzle where we have six guesses to
[3:58] narrow down a set of possible answers.
[4:00] There are about 2300 answers and about
[4:03] 13,000 guesses that we're allowed to
[4:05] make. Every guess divides up the
[4:07] possible answers into groups. After each
[4:09] guess, we're told what group the answer
[4:11] belongs to. [music] Each guess we can
[4:13] make divides up the group slightly
[4:14] differently. If we can use these
[4:16] groupings to narrow down and guess the
[4:18] answer in six attempts, then we win the
[4:20] game. Now, I'm literally being cryptic
[4:22] here, so let's go through what on earth
[4:23] I'm actually talking about. As you
[4:25] [music] might have guessed, the 13,000
[4:27] possible guesses are just the words that
[4:29] you're allowed to type into a game of
[4:30] Wordle. [music] Similarly, the 2300
[4:33] answers are just the possible mystery
[4:34] words for every day the game is played.
[4:37] The creator of the game, Josh Wle,
[4:39] created these lists along with his
[4:40] partner and wrote them into the source
[4:41] code of the game. They included enough
[4:43] answers for about 7 years of games, and
[4:45] the mystery words have only just
[4:46] recently started repeating. The New York
[4:48] Times has tweaked the list a few times,
[4:50] but not much has changed overall. Now,
[4:52] the groups of words I've been talking
[4:54] about might be a bit less clear. [music]
[4:56] The groups, it turns out, correspond to
[4:57] the various sequences of green, yellow,
[4:59] and gray letters that you can get when
[5:00] you guess a [music] particular word.
[5:02] When you get this information back after
[5:04] your guess, that tells you which group
[5:06] must contain the mystery word. So, what
[5:08] can we say about these groups? Well, the
[5:10] number of possible colorings is 3 * 3 *
[5:14] 3 * 3 * 3 or 243.
[5:20] [music] But not all of these are
[5:21] actually possible. Take a look at this
[5:23] coloring here. What sort of a word could
[5:25] have it? [music] Well, it has to start
[5:27] with a C, end with an R, and have O's in
[5:30] the second and fourth positions. It also
[5:32] has to have an L in it, but that [music]
[5:34] L can't be in the third position. This
[5:36] is impossible since we already know that
[5:38] every letter except for the third one is
[5:40] not an L. It turns out that any coloring
[5:43] with four greens [music] and a yellow is
[5:44] impossible for this reason. Meaning that
[5:46] the actual number of valid colorings is
[5:48] 238.
[5:50] However, while all of these 238
[5:52] colorings can be reached in some way
[5:53] [music] using words on our list, there's
[5:55] no individual guess that can produce
[5:57] anything close to this. The word that
[5:59] produces [music] the most colorings
[6:00] turns out to be trace, which can be
[6:02] colored in 150 ways based on the
[6:04] possible word answers. These color
[6:06] groupings are going to form the basis
[6:07] for our entire strategy. It's not enough
[6:10] to be able to guess words. We have to be
[6:12] able to narrow down those words as
[6:13] efficiently as possible. If only one
[6:15] word matches the patterns that we've
[6:17] seen so far, then solving the puzzle is
[6:19] as easy as matching those patterns. But
[6:21] if we get to our last guess and still
[6:22] have multiple options remaining, no
[6:24] amount of word matching skill is going
[6:25] to be able to help us. We're going to
[6:27] work through the game guess by guess to
[6:29] figure out how to win as often as
[6:31] possible and as quickly as possible.
[6:33] That's going to start with maybe the
[6:34] most controversial topic in Wordle. How
[6:36] do we choose our first guess? Well, the
[6:38] color groupings we've seen so far give
[6:40] us some candidates for the best opening
[6:41] word. We've seen one of these candidates
[6:43] already. Trace produces the largest
[6:45] number of groups or equivalently has the
[6:48] smallest average group size. One
[6:50] consequence of this is that if you want
[6:51] to maximize your chances of winning in
[6:53] two guesses, trace is the best choice.
[6:56] But this doesn't seem quite right. Since
[6:57] by definition more words end up in
[6:59] larger groups, it might make more sense
[7:01] to weigh those groups more heavily. We
[7:03] can ask a slightly different question.
[7:05] On average, how many possible words
[7:06] remain after we make our first guess?
[7:09] The word which minimizes this is wrote,
[7:11] which is barely even a word, but leaves
[7:13] about 60 answers on average. But what if
[7:15] this isn't right either? We might care
[7:17] instead about the single group that
[7:19] takes us the longest to narrow down. If
[7:21] we want to minimize the size of the
[7:23] largest color group, that is a fiveway
[7:25] tie. These five words, including arise
[7:28] and raise, leave just 168 possible
[7:30] answers on all gray, which is the
[7:32] [music] most common outcome. If we just
[7:34] care about not getting all gray on our
[7:36] first guess, then Ori and Yuri each
[7:39] leave all grays on just 114 of our 2300
[7:42] words.
[7:47] That's four different ways of coming up
[7:48] with a new opener, and they lead us to
[7:50] nine different answers. I'm sure we
[7:52] could come up with other ways of
[7:53] analyzing these group sizes and they
[7:54] would all lead us to slightly different
[7:56] conclusions. But all these measurements
[7:58] have one problem in common. They're
[8:00] supposed to be figuring out the best way
[8:01] to start a game of Wordle, but none of
[8:03] them look past the very first move. If
[8:05] our goal is to take as few moves as
[8:06] possible, then the number of moves is
[8:08] the thing that we'll have to optimize.
[8:10] So, how do we figure out which words
[8:12] help us the most as the game goes on?
[8:15] We'll use a method of searching for the
[8:16] best strategy first implemented by
[8:18] several mathematicians in early 2022. It
[8:21] involves an approach called dynamic
[8:22] programming that we've seen in various
[8:23] forums in my videos on Yatsi and
[8:25] hangman. We essentially reduce our
[8:27] problem of narrowing down 2,000 words to
[8:29] easier problems of narrowing [music]
[8:31] down smaller groups of words. To figure
[8:33] out our best opening word, we're going
[8:35] to have to examine not only the groups
[8:36] produced by the first word, but
[8:38] subgroups produced by later guesses.
[8:41] [music]
[8:44] Given our initial guess, we look at
[8:46] every group that gets produced. If our
[8:48] first guess is one of the possible
[8:50] answers, then there's an all green group
[8:52] that's already finished in one guess.
[8:55] We'll usually also have at least a few
[8:57] groups with only one word in each. Here,
[8:59] we can just guess the remaining word and
[9:00] finish [music] in two.
[9:04] If a group has two words in it, we can
[9:06] just guess them in order, finishing in
[9:07] two and a half guesses on average.
[9:12] As the groups get bigger, we start
[9:13] having real decisions to make.
[9:16] Sometimes the best thing to do is
[9:17] guessing one of the remaining words now.
[9:24] But sometimes it's better to choose a
[9:25] different word that narrows down our
[9:26] options faster. Different groups will
[9:29] require different approaches.
[9:32] For the largest groups, we'll have to go
[9:34] further. We'll have to break down each
[9:35] of the subgroups created by each
[9:37] possible [music] second guess and
[9:38] analyzing those separately. This way, we
[9:41] can find which words minimize the
[9:42] average number of guesses without
[9:43] risking losing the game.
[9:48] By the time we're done, we'll have a
[9:50] tree mapping out the best possible
[9:52] decision [music] for every situation
[9:54] we'll ever encounter for a given opening
[9:56] word. When we choose the opener with the
[9:58] fewest average moves, we'll not only
[10:00] [music] have the best first word, we'll
[10:02] have the optimal strategy for the entire
[10:04] game of Whle.
[10:07] So, how do we turn a massive data
[10:08] visualization into a usable strategy?
[10:11] Well, let's just start with another
[10:12] massive data visualization. Here's a
[10:14] histogram of the average number of
[10:15] guesses needed for every single opening
[10:17] word. [music] Now, before I go further,
[10:19] I want to emphasize that the choice of
[10:21] the first word is actually not that
[10:23] important to Wordle strategy. [music]
[10:25] To prove to you that I don't think it's
[10:26] that important, I'll break one of the
[10:27] biggest rules of YouTube retention and
[10:29] just tell you the best word. Now, it's
[10:31] salad, a type of medieval helmet. The
[10:34] game takes about [music] 3.42 guesses on
[10:36] average when we start with salad.
[10:38] This is where I'll stop to say that
[10:39] [music] changes to the word list will
[10:41] sometimes change the answers to things
[10:42] that I say here. Since late 2022,
[10:45] there's actually a slightly better
[10:46] opening word, parse. It hasn't really
[10:49] been used in hundreds of years and is
[10:50] slightly inappropriate, but [music] it
[10:52] seemed wrong not to mention it. Anytime
[10:54] an actual number has changed from words
[10:56] being added or removed, it's usually in
[10:58] the second or third [music] decimal
[10:59] place. So, no meaningful parts of the
[11:01] strategy actually change that much.
[11:03] Anyway, with all that said, if we
[11:05] restrict ourselves to only guessing the
[11:07] more normal words [music] that can
[11:08] actually appear as wordle answers, the
[11:10] best choice is slate, which is in
[11:12] [music] fifth place on this list.
[11:15] So, why do I say that the first word
[11:16] isn't important? We'll talk more about
[11:18] this later, but for now, I'll just add
[11:19] in the x-axis [music] on this chart.
[11:22] Salot wins the race for the best word by
[11:24] about 1 1,000th [music] of a guess on
[11:26] average. There are eight words within a
[11:28] hundredth of a guess and almost 1,500
[11:31] words within a tenth [music] of a guess.
[11:32] In fact, the majority of the list is
[11:34] within 2/10 of a guess of [music] the
[11:36] best possible word. For a lot of the
[11:39] analysis in this video, I'll be looking
[11:41] at the strategy we get from the top
[11:42] thousand opening words [music] rather
[11:44] than just salad. It barely changes our
[11:46] average guesses and does a better job of
[11:48] getting at the [music] general
[11:49] principles of the game. I'm also not
[11:51] expecting everyone to just start using
[11:52] salad overnight, so this will hopefully
[11:54] be more helpful. Here's some more
[11:56] highlights from this chart. [music] The
[11:58] worst possible opening word is kayak, an
[12:00] alternate spelling of kayak. I suspect
[12:02] that this was included less out of a
[12:03] respect for Inuit [music] culture and
[12:05] more out of a desire to have a word with
[12:06] two Q's and a J for use in word games.
[12:09] Many of the words we've talked about so
[12:10] far finished [music] fairly high on this
[12:11] list, as do many of the most popular
[12:14] openers according to the New York
[12:15] [music] Times. But this is also a chance
[12:17] to break one of the most popular
[12:18] misconceptions about Wordle because the
[12:21] two most popular openers in all of
[12:22] Wordle do not appear where we [music]
[12:24] might expect. Here is a Jew and here's
[12:27] audio. For comparison, here are the
[12:29] average and median guesses across all
[12:32] opening words. A majority of the words
[12:34] on this list are better than a due in
[12:36] audio. Here are the average and median
[12:38] for actual answers [music] when they're
[12:39] used as opening words. What does this
[12:41] all mean? It tells us that if we were to
[12:43] just start every game by guessing
[12:45] yesterday's [music] answer, it would be
[12:46] a better strategy than the two most
[12:48] common opening words in the game. But
[12:51] how does this happen? The thought behind
[12:53] a Jew and audio makes so much sense.
[12:55] Almost every word has vowels, so
[12:57] covering four with one guess seems like
[12:58] a great approach to the game. After all,
[13:00] we saw earlier that four vowel words
[13:02] could minimize our chances of getting
[13:03] all grays. It turns out to be no
[13:06] coincidence, though, that these words
[13:07] aren't great openers. There are three
[13:09] main things that prevent a word from
[13:11] being a good opener. But to figure out
[13:13] what they are, we're going to have to
[13:14] take a step back and look at the
[13:16] alphabet as a whole. My last video was
[13:18] about hangman. A lot of folks posted in
[13:20] the comments of that video that I should
[13:21] try to apply the things that I found
[13:22] there to a video on Wordle. This was
[13:24] very convenient since I posted this poll
[13:26] three days before the hangman video came
[13:28] out. Now, I realized that making a
[13:30] 38minute video about Hangman to prepare
[13:32] for a video about Wordle is sort of a
[13:34] crazy thing to do, but you can probably
[13:36] tell there wasn't a lot of sanity
[13:37] involved in the making of this channel.
[13:39] Thankfully though, this means that I
[13:40] don't have to subject you to another 15
[13:42] minutes of ranking the alphabet, and I
[13:43] can [snorts] just show you the results.
[13:45] If you do want to see more on letter
[13:46] breakdowns, I'd recommend checking out
[13:47] that video. One of the main takeaways
[13:50] from the hangman video was this tier
[13:52] list. I ranked the letters of the
[13:53] alphabet based on which letters are
[13:55] usually used first in an optimal hangman
[13:57] strategy. We can use the same approach
[13:58] for our Wordle strategy to get a similar
[14:00] tier list, but it has some changes that
[14:02] illustrate how fiveletter words differ
[14:04] from the rest of the dictionary. The I,
[14:06] which mostly appears in longer words, is
[14:08] much less useful in Wordle. While the S
[14:10] also drops slightly because Wordle
[14:12] doesn't use plurals ending in S as
[14:13] answers. Certain other letters like L
[14:16] and H do much better in fiveletter
[14:17] Wordle answers than in the dictionary as
[14:19] a whole. Keeping this tier list in mind,
[14:22] we can go back to our histogram. Which
[14:24] properties of words make them bad first
[14:26] guesses. The first is not surprising.
[14:28] Low tier [music] letters. If we guess a
[14:30] rare letter, it's unlikely to be in the
[14:32] answer. So, we're probably not going to
[14:33] get much information from [music] it.
[14:35] Here are words with one low tier letter.
[14:37] Here's two, and here's three. [music]
[14:40] The second bad property is also what you
[14:42] might expect, duplicate letters. Even if
[14:44] a letter is common, guessing it twice in
[14:46] one word usually doesn't give extra
[14:48] information unless the letter also
[14:50] appears twice in the answer. Let's see
[14:52] what happens if we add duplicate [music]
[14:53] letters to our tier list. No matter how
[14:55] common a letter is on its own, the
[14:57] second instance of the letter is always
[14:58] low tier. And most duplicates are worse
[15:00] than any [music] individual letter.
[15:02] Going back to our chart, we can see what
[15:04] happens when we get a duplicate letter.
[15:05] [music] Here's two duplicates, and
[15:07] here's three. Not surprisingly, we get
[15:10] less information from the duplicate
[15:11] [music] letters. But the third bad
[15:14] property is much more surprising. The
[15:16] other thing that keeps words from the
[15:18] top of this list is a large number of
[15:19] vowels. Here are words with [music]
[15:21] three distinct vowels and here are words
[15:23] with four. These aren't exactly bad, but
[15:26] they aren't good either. [music] Almost
[15:28] every one of the top words contains just
[15:30] one or two vowels. Now, unlike rare or
[15:33] duplicate [music] letters, lots of
[15:34] vowels don't make a word bad on its own.
[15:36] To understand why we want to avoid
[15:38] these, we have to look later into the
[15:39] game.
[15:41] This is a chart of how often we need
[15:43] each number of guesses when we use the
[15:44] optimal salot strategy. Notice how in
[15:47] the vast majority of games, we need
[15:48] either three or four guesses. To put
[15:51] this another way, we usually need two or
[15:53] three guesses to figure out the answer
[15:55] before guessing it. Our strategy is
[15:57] based on getting as much information as
[15:59] possible out of those two or three
[16:00] guesses. So, what does this have to do
[16:02] with vowels? Well, we already saw from
[16:04] our tier list with duplicates that if we
[16:06] want to get more information, we
[16:07] probably want to be using as many
[16:09] different letters as possible. If we're
[16:11] often using three guesses to figure out
[16:13] our word, we need to be prepared to
[16:14] spread our vowels out across those three
[16:16] guesses if we want to avoid wasting a
[16:18] letter on a repeated vowel. If we use
[16:21] four vowels in the same word, this
[16:22] becomes very difficult to do. There are
[16:24] six vowels in the English language. Yes,
[16:26] I'm counting Y. But if you put four
[16:28] vowels in your first guess, that leaves
[16:29] only one each for the next two guesses.
[16:32] Plus, in the case of a due and audio,
[16:34] one of those extra vowels is a Y, which
[16:36] is pretty rare as the only vowel in a
[16:37] word. Even with three vowels in the
[16:39] first guess, this means that you often
[16:41] need a one vowel word [music] or a
[16:42] repeat in your next two guesses. We can
[16:45] see how this plays out if we start
[16:46] trying other word lengths. We've already
[16:48] seen that the best opening word in
[16:49] Wordle is salad with two vowels. Wordle
[16:51] only allows fiveletter words, but
[16:53] there's a popular variant called hello
[16:54] Wordle that has a wider range of
[16:56] lengths. As the words get longer, the
[16:58] average guesses go down. Since we're now
[17:00] getting more information with each
[17:01] guess, we should expect to see the
[17:03] number of vowels in the best opening
[17:04] word change to reflect this. When we go
[17:07] up to six letters, the average guess
[17:09] count is still well above three at 3.18.
[17:12] Fair enough. The ideal opener of carne
[17:14] only has two vowels. The number of
[17:17] vowels goes up to three precisely
[17:18] [music]
[17:18] when our average number of guesses drops
[17:20] below three with saltian at length
[17:22] seven.
[17:24] We get a fourth vowel at length 9 and
[17:26] start repeating vowels at length 10.
[17:29] Going down to length four, we often need
[17:31] more than three guesses to narrow down
[17:32] the answer. And our best opener has two
[17:34] vowels, usually followed with one vowel
[17:36] words if it misses. By length three,
[17:38] we're usually using just one vowel per
[17:40] guess.
[17:44] Now, I've been talking about the best
[17:46] possible strategies, but this might be
[17:48] the point where you start to wonder
[17:49] whether any of this makes sense in a
[17:50] real game. The optimal strategy was
[17:52] designed to be used by a computer. If we
[17:55] actually wanted to use it ourselves, we
[17:56] have to memorize over 2,000 different
[17:58] scenarios and which word to play in
[17:59] every single one. So, when I say things
[18:01] like we shouldn't use that many vowels,
[18:03] it's natural to wonder whether that
[18:04] actually makes sense for a human player.
[18:07] Sure, a computer that knows all the
[18:08] words might not need vowels, but surely
[18:10] they're more helpful for us, right? I
[18:13] actually want to challenge this a bit,
[18:14] and I'm going to do it with a little
[18:15] game. Here are two fiveletter words. I'm
[18:19] going to show you three letters of each
[18:20] one. I'll tell you that there's only one
[18:22] possible wordal answer that matches
[18:24] those exact letters. See if you can
[18:26] guess the words in 15 seconds. Ready?
[18:29] Go.
[18:40] [music]
[18:48] Now, if you're like most of the people
[18:49] I've shown this to, you probably had an
[18:51] easier time guessing befit than isolate.
[18:53] I'm not even sure I know what befit
[18:55] means, but it seems much more
[18:57] straightforward once we have the B, F,
[18:58] and T. You can probably guess why I
[19:01] showed these to you. It was much easier
[19:02] to guess two vowels given three
[19:04] consonants than the other way around. In
[19:06] fact, there are entire written languages
[19:08] based around the idea that we can
[19:09] usually figure out what a word is
[19:11] without most of the vowels. Vowels are
[19:13] helpful, but the fact that there are so
[19:15] few of them actually makes them easier
[19:16] to guess later in the game. Now, we've
[19:19] talked through what makes for a good
[19:21] opening word, but as I said earlier, the
[19:22] opening word is actually not that
[19:24] important. It's the next few guesses
[19:26] that really determine how well we can do
[19:28] in a game of Wordle. That is because the
[19:30] way the guesses interact with one
[19:32] another is often more important than the
[19:34] guesses themselves. We're now going to
[19:36] try to build out a full strategy that we
[19:37] can actually use when we play. But in
[19:39] doing this, we're going to run into some
[19:41] issues. Learning a good opening word
[19:43] works well enough, but even on a second
[19:45] guess, things get complicated quickly.
[19:47] Salad divides the answers up into 148
[19:49] different color groups, which means that
[19:51] if we wanted to actually play [music]
[19:52] perfectly, we would need to learn 148
[19:55] different cases just for how to handle
[19:56] the second guess. Learning the whole
[19:58] strategy would require learning
[20:00] thousands of different decisions
[20:01] corresponding to every possible
[20:03] situation we might encounter during
[20:04] [music] a game. But the same is true of
[20:06] every strategy. A strategy is basically
[20:09] just a set of rules for choosing a move
[20:10] in every situation. And whirl game is
[20:13] going to involve a lot of those
[20:14] situations, no matter how you play. Now,
[20:16] we're [music] going to use two main
[20:17] approaches for reducing these strategies
[20:19] down to something usable. One is
[20:21] simplification, coming up with rules to
[20:23] make the same decision in many different
[20:25] but similar situations. The more cases
[20:27] you can group together, the less you
[20:29] have to remember. The other is
[20:31] randomness. As we've seen in my videos
[20:33] on Battleship and Hangman, randomness is
[20:35] sometimes the only reliable way to stay
[20:36] [music] unpredictable to your opponent.
[20:38] And we're opponent is a New York Times
[20:40] editor who is not trying to trick you.
[20:42] The randomness is not going to improve
[20:44] your strategy, but it gives us some
[20:45] useful things. One is that it makes it
[20:48] easier to come up with complete
[20:49] strategies. If we haven't covered a
[20:51] certain situation, we can always just
[20:52] make a random choice. The other is that
[20:54] if we use randomness correctly, [music]
[20:56] we can come up with strategies that are
[20:58] much simpler and easier to analyze
[21:00] without sacrificing too much
[21:01] performance. We're going to use these
[21:04] two basic building blocks of
[21:05] simplification and randomness. See how
[21:07] close we can get to our optimal strategy
[21:09] without making things [music] too
[21:10] complicated. So, let's start building
[21:13] some strategies. We already have the
[21:15] best one, which takes 3.42 guesses on
[21:17] average and not only always wins, but
[21:19] always wins in at most [music] five
[21:20] guesses. It's hard to learn, though. So,
[21:22] we'll see if we can get close using a
[21:24] more reasonable strategy. What's at the
[21:26] other end of the spectrum? We want a
[21:28] strategy that is as simple as possible,
[21:29] even if it's [music] really terrible.
[21:31] We've been talking about randomness. So,
[21:33] let's start there. If we choose all
[21:35] words completely at random from the 2315
[21:38] possible answers, we'll take an average
[21:40] of well, 2315 guesses and win.26% of the
[21:44] time. If we don't allow repeat guesses,
[21:46] the win rate stays about the same, but
[21:48] the average guesses drop to [music]
[21:50] 1158. We can obviously do better than
[21:52] that, though. Let's see if we can meet
[21:54] in the middle and we work our way in
[21:55] [music] from the ends to find a strategy
[21:57] that is both good and simple. But what
[22:00] if we guess randomly, but after every
[22:01] guess, we check if we've narrowed
[22:03] [music] things down to a single word. We
[22:05] then guess the word once it's the only
[22:06] option. If we do this, we take an
[22:08] average of 6.9 [music] guesses and win
[22:10] more than half the time. With just one
[22:13] more tweak, we can get a strategy that I
[22:15] think is a good approximation of how a
[22:16] lot of people actually play. We just
[22:19] choose a compatible answer each time.
[22:21] For each guess, we just choose a word
[22:23] that hasn't been ruled out by our
[22:24] previous guesses. To make my
[22:26] calculations easier, we'll say that
[22:27] we're choosing at random from the
[22:28] answers that are left. [music] If you
[22:31] like switching up your opening word,
[22:32] especially if you play on hard mode,
[22:34] this could be pretty close to how you
[22:35] actually play. It sort of represents a
[22:38] player who is perfect at word matching
[22:39] skill, but doesn't think at all about
[22:41] strategy. This is still a random
[22:43] strategy, but through this simple tweak,
[22:45] our average guesses are down to about
[22:47] 4.08. 08 and we're winning over 98% of
[22:50] the time. So even random guessing if
[22:52] done correctly can get us surprisingly
[22:54] far, but it certainly has its limits.
[22:57] This brings us to sort of game within a
[22:58] game. We want to find a middle ground
[23:00] between an okay strategy where we don't
[23:02] make a single decision and a perfect
[23:04] strategy where we make thousands of
[23:05] decisions. The next thing to work on is
[23:07] simplification. What are the most
[23:09] important decisions that we have to make
[23:11] in a game of Wordle? And how do we make
[23:13] them? We'll start with a decision that
[23:15] we've already talked about, the opening
[23:17] word. Let's go one step away from a
[23:19] random strategy. Start with a word of
[23:21] our choice and then pick random
[23:23] compatible words after that. Turns out
[23:26] that we once again get a slightly
[23:27] different best opener. This time it's
[23:29] [music] slate, which brings our average
[23:31] guesses down to 3.82 and our win rate
[23:33] close to 99%. This one opener followed
[23:36] by random compatible guesses is now
[23:38] [music] performing better than hundreds
[23:40] of other openers do, followed by perfect
[23:42] play. But as I said before, the first
[23:44] guess is not really the most important.
[23:46] [music] And now we have the tools to
[23:48] show why. Here's what we get if we use
[23:50] the optimal strategy for every guess
[23:52] except for one, where we use a random
[23:54] compatible guess instead. If the guess
[23:56] doesn't matter much, then we should see
[23:58] performance pretty close to our optimal
[24:00] average guesses of 3.42.
[24:02] If the guess is really important, then
[24:04] picking randomly will lose us a lot of
[24:05] guesses on average. So what do we get?
[24:08] Well, the optimal strategy always
[24:10] finishes by the fifth guess. [music] And
[24:12] by the time we get there, we only have
[24:13] one option left anyway. Choosing
[24:15] randomly doesn't change anything.
[24:17] Choosing randomly on the fourth guess
[24:19] also only affects a very small number of
[24:21] cases. We've actually already calculated
[24:23] the number we get for the first guess.
[24:25] That's just the average of all the guess
[24:27] values we get when we start with every
[24:28] possible opener. So that leaves the
[24:31] second and third guesses here. There's
[24:33] still the potential to narrow down our
[24:34] answers quite a bit with a good guess,
[24:36] but fewer chances to make up for
[24:37] mistakes if we make them. So what
[24:39] numbers do we get here?
[24:41] Bringing in a random third guess still
[24:43] doesn't cause a huge change, but a
[24:44] random [music] second guess does, making
[24:47] it the most important guess in the game
[24:49] to get right. Most bad first guesses can
[24:51] be corrected with a good second guess.
[24:53] But a bad second guess is a permanent
[24:55] waste of a turn. This causes a problem
[24:58] for us humans. The second guess is more
[25:00] important, but also much more difficult
[25:02] than the first one. The problem is that
[25:03] we have to come up with a different
[25:05] guess for every possible coloring of the
[25:07] first word.
[25:08] Well, actually, we don't have to.
[25:12] One way around the complexity of later
[25:14] guesses is the multi-word opener. We
[25:16] always have a second guess or even a
[25:17] third ready to go. We lose the
[25:19] flexibility of being able to adapt our
[25:21] later guesses to the information that we
[25:23] have, but we gain the ability to use
[25:25] those guesses as efficiently as
[25:26] possible, putting every letter in the
[25:28] best possible place to get the most
[25:30] [music] information. So, we'll try a new
[25:32] approach. We'll try a few pre-chosen
[25:34] words to start and then choose random
[25:36] compatible words for the rest of the
[25:37] game. As a reminder, a one-word opener
[25:40] of slate gave us 3.82 turns on average
[25:42] with a win rate of about 99%. If we
[25:45] start with a pair of words, the best I
[25:47] could find was parse Clint or crane
[25:49] spilt [music] if we want our guesses to
[25:50] be possible answers. Each of those takes
[25:53] about 3.7 turns on average and wins
[25:55] about 99 12% of the time.
[25:57] We could already know that three openers
[25:59] will [music] never beat this since we'll
[26:00] almost always need a fourth guess. But
[26:02] it turns out that we can almost always
[26:04] win in four this way. We get dance horse
[26:07] blimp [music] or bland cops right. By
[26:10] the time we get to four openers, we're
[26:11] almost always getting the word in our
[26:13] next guess and beat in the game almost
[26:14] every time.
[26:16] With five openers, we [music] get the
[26:18] chance to clear up another common
[26:19] misconception about Wordle. You may have
[26:21] seen some claims going around about
[26:23] using five words with 25 different
[26:25] letters to get a [music] guaranteed win
[26:26] on your sixth guess. There are two
[26:28] things wrong with this. One is that
[26:30] there is actually no way to guarantee a
[26:32] win with five fixed words. The other is
[26:34] that using 25 different letters is not
[26:36] even the best way to choose five fixed
[26:38] words. Here's the best group of five
[26:40] words we can use with 25 different
[26:42] letters. If we use these five words,
[26:44] there will still be a full 72 different
[26:46] [music] words that we just can't solve
[26:48] or about 3% of all possible answers. As
[26:52] an example, the words puree, purer,
[26:54] rupee, and upper are impossible [music]
[26:56] to tell apart using these five words.
[26:59] Remember our tier list with the double
[27:00] letters in it? Sometimes two of one
[27:02] letter can actually be more useful than
[27:04] one of a lower tier letter. If we
[27:06] instead use these five words, then only
[27:08] 16 words go unsolved, less than 1%.
[27:11] Notice the two E's, L's, O's, and T's,
[27:14] even as J, K, Q, [music] X, and Z aren't
[27:16] used at all. Unfortunately, this is
[27:18] probably the best we can do, and we
[27:20] can't get a guaranteed win this way. If
[27:23] we were allowed one more guess, it would
[27:24] be possible to narrow down the word with
[27:26] six guesses. There are many ways to do
[27:28] this, including one involving six valid
[27:30] whalle answers as guesses.
[27:32] I did a lot of research in trying to
[27:34] make this video and as far as I can
[27:35] tell, there's actually no public
[27:37] strategy designed to be straightforward
[27:39] for a human that can guarantee a win in
[27:41] a game of whle. Or I should say there
[27:43] wasn't one until now. The idea here is
[27:47] that while our average guesses were best
[27:48] with [music] a two-word opener, the
[27:50] probability of winning was maximized
[27:52] with a three or four word opener. With
[27:54] five words, we would have to split up
[27:55] all the answers perfectly, but with too
[27:57] few words, we'd leave groups that are
[27:59] too big to narrow [music] down. I ran a
[28:02] search for four word openers with
[28:03] reasonable looking words that could
[28:04] narrow down the answers enough that two
[28:06] random guesses would allow us to solve
[28:08] what's left. I even included a larger
[28:10] list of about 4,000 words for your last
[28:12] two guesses just to make sure that the
[28:14] strategy didn't rely on knowing exactly
[28:15] which words are valid answers. And after
[28:18] a few days of searching, I found a
[28:20] solution.
[28:22] Here's our winning strategy. We use the
[28:24] words ledge, pawns, rocky thumb. We then
[28:28] use random compatible answers for the
[28:30] last two guesses. As long as you use any
[28:32] valid compatible word for your fifth
[28:34] guess, you are mathematically guaranteed
[28:36] to either solve the puzzle or narrow it
[28:38] down to a single option for your sixth
[28:40] guess. It's now actually possible for a
[28:42] person to say that they can beat Wordle
[28:44] every time. Now, on one hand, we just
[28:47] found a simple strategy that always
[28:48] beats Wordle. On the other hand, this is
[28:50] sort of anticlimactic. We guarantee to
[28:53] win by finding a strategy that almost
[28:55] always takes five or six guesses.
[28:57] Multi-word openers can help us win, but
[28:59] if we want to win faster, they only help
[29:01] us so much. Adding a second word to our
[29:03] opener improved our strategy by about a
[29:05] tenth of a guess on average, and going
[29:07] beyond that improved our win rate at the
[29:08] expense of extra guesses. But there are
[29:11] a few places where these longer openers
[29:12] can be really valuable. One is
[29:15] speedrunning. It really should have
[29:16] occurred to me that there was an active
[29:18] Wordle speedrunning community before I
[29:19] started this project. But once I got the
[29:21] chance to talk to a member of the
[29:22] community, I learned that they had done
[29:24] a lot of the same work I was trying to
[29:25] do in optimizing the game. In
[29:27] speedrunning, multi-word openers are
[29:29] very helpful. It's often faster to type
[29:31] than it is to think. So pecking out
[29:33] three or four quick words and then
[29:34] filling out the rest of the board from
[29:36] there is one of the best strategies to
[29:37] get a fast time. But another use for
[29:40] these multi-word openers is for one of
[29:41] my favorite variants of Wordle. And it
[29:43] looks a little like this. This is
[29:47] Octoal. Well, technically this is. It's
[29:50] a game where you have to solve eight
[29:51] different Wordle puzzles using the same
[29:53] set of guesses. You have 13 guesses in
[29:55] total. Eight to actually guess the
[29:57] answers, plus another five for incorrect
[29:59] answers or gathering information. There
[30:01] are all kinds of variants like this for
[30:03] guessing different numbers of words. The
[30:04] number of words is usually a power of
[30:06] two, which is a weird side effect
[30:07] [music] of the fact that nice things on
[30:09] the internet tend to be created by
[30:10] programmers. These games seem like they
[30:12] should be a lot harder than regular
[30:14] Wordle, but as we've seen with longer
[30:16] word lengths in both Wordle and Hangman,
[30:18] the increase in complexity is more than
[30:20] canceled out by the increase in
[30:21] information you get with each guess. The
[30:24] more words you have, the more likely
[30:25] you'll be able to solve one of them
[30:27] early, and the more information you'll
[30:29] get from your correct answers in solving
[30:30] the other words. It turns out that
[30:32] multi-word openers are quite useful in
[30:34] these multi-wordal games. While two or
[30:36] three guesses don't always narrow down
[30:37] the word in a typical game of fertile,
[30:39] they become very likely to narrow down
[30:41] at least one of the words once you have
[30:43] enough of them at a time. This then
[30:45] starts a chain reaction, allowing you to
[30:47] finish the rest of the game without
[30:48] another miss.
[30:51] So, here's [music] our approach. We
[30:53] choose either one, two, or three opening
[30:56] words. From there, we figure out which
[30:58] of our boards has the fewest options
[31:00] left, and we guess there. We keep going
[31:02] until [music] we finished the game.
[31:08] [music]
[31:10] Here's a plot of how we do. On the
[31:12] x-axis is the number of Wordle words
[31:14] we're trying to solve, and on the y-axis
[31:16] is the average number of misses that we
[31:18] get. We've already seen that a
[31:20] three-word opener is worse than [music]
[31:21] one or two, even for a single game. But
[31:23] one and two cross paths right around the
[31:26] 18 wordle mark. Up to 16, it's usually
[31:29] best to use a pair of words like [music]
[31:31] clamp tribe. And after that, it's
[31:33] usually best to start with a single word
[31:35] like rotan or plant. Even if you often
[31:39] get another miss after your single
[31:40] opener, it's still better than the
[31:42] almost guaranteed miss from a fixed
[31:43] second guess. For comparison, here's a
[31:46] near optimal strategy I created that
[31:48] tries to find the best next guess across
[31:50] all words at once. Our simple strategy
[31:52] with a one or two-word opener comes
[31:54] pretty close to this. We just came up
[31:56] with a pretty simple strategy that is
[31:58] surprisingly close to perfect in most of
[31:59] these multi-word games. In practice
[32:02] though, we just did something a little
[32:03] tricky and swept it under the rug. We
[32:05] assume that we could just look at a
[32:07] bunch of whle boards and figure out
[32:08] which one had the fewest options left.
[32:10] This, of course, is easier said than
[32:12] done. So, we'll have to do something to
[32:13] simplify this process a bit. While
[32:15] analyzing all the words can often be a
[32:17] bit too much of a challenge, we have
[32:19] something a bit more straightforward. We
[32:20] can look at the colors. These colorings
[32:23] are going to unlock the ability for us
[32:24] to improve our later guesses. Up to this
[32:27] point, we've been stuck between a
[32:28] perfect strategy with 148 possible
[32:30] guesses for the second word or a much
[32:33] simpler one that chooses the same word
[32:34] every time. Breaking things down by
[32:36] color will help us to make smarter
[32:38] decisions about when to gather
[32:39] information and when to go for the win.
[32:42] We've talked about how there are 243
[32:44] possible sequences of greens, yellows,
[32:46] and grays, but many of them are pretty
[32:47] similar. There are five ways to get four
[32:50] greens, and a gray, for example, or a
[32:52] full 30 ways to get two greens, two
[32:54] yellows, and a gray. In total, there
[32:56] [music] are 21 possible combinations of
[32:58] the three colors. And if we throw out
[33:00] the combination that's impossible, and
[33:01] the one that means the game is over,
[33:03] that leaves 19 possible color
[33:05] combinations to analyze. So, how do we
[33:07] go about analyzing these color
[33:09] combinations? Well, it turns out that
[33:10] starting on our second guess, the
[33:12] optimal strategy usually does one of two
[33:14] things. It either picks a word
[33:16] compatible [music] with the previous
[33:17] guesses, or it picks five completely new
[33:19] letters.
[33:21] Keep in mind [music] that with these top
[33:22] thousand openers, we're only getting all
[33:24] grays about 13% of the time. So, we're
[33:27] often choosing five new letters even
[33:29] when we already know some of the letters
[33:30] in the word. So, how do our colors tell
[33:32] us what to do? Well, let's take a look
[33:34] at some of these combinations. If we get
[33:36] three greens and two yellows, then we're
[33:38] guaranteed to have just one answer left.
[33:40] This is a mathematical fact. The only
[33:42] way for this to happen is if we switch
[33:44] the two yellow letters. If we get two
[33:47] greens and three yellows with one of our
[33:48] top thousand openers, then we are also
[33:50] guaranteed to have just one answer left.
[33:52] This is not a mathematical fact. In
[33:55] theory, it's possible to have two
[33:56] different rearrangements of the yellows
[33:57] that could work here, but that just
[33:59] never happens for any of our top
[34:01] thousand opening words. In fact, there's
[34:03] only one opener in the entire [music]
[34:05] list of 13,000 words that can get this
[34:08] combination and still have two answers
[34:09] remaining. Beard, with three yellows in
[34:12] the middle, can become beard or bread.
[34:15] Cases with no grays rarely have more
[34:17] than one option remaining, and cases
[34:19] with one gray usually [music] don't have
[34:21] more than a handful, but the options go
[34:23] up as the grays go up.
[34:26] If we get all five grays, we'll have
[34:28] over 300 answers remaining on average.
[34:31] So, this allows us to make sense [music]
[34:33] of how our optimal strategy handles each
[34:35] situation. If we don't get a single
[34:37] gray, the optimal strategy says to
[34:39] always guess [music] a compatible word.
[34:41] If we get all grays, the strategy says
[34:43] to do this, too, but for a very
[34:44] different reason. If we get all grays,
[34:46] then it makes sense that we're not going
[34:48] to reuse one of those letters. If we get
[34:51] only one gray, then we almost always
[34:52] guess compatible words, usually about
[34:54] 85% of the time. If we get two grays,
[34:58] then it's a tossup. we guess compatible
[35:00] words about half the time, [music]
[35:01] slightly more than half if we have at
[35:02] least one green. If we get three or four
[35:06] grays, then we mostly just focus on
[35:08] getting [music] more information,
[35:09] usually by guessing five new letters. By
[35:12] our third guess, we're usually trying to
[35:14] guess the word, no matter what we get on
[35:16] the first two. And by the fourth guess,
[35:17] we're going for the answer pretty much
[35:19] every time. So now we know when we
[35:21] should be going for the answer and when
[35:22] we should be going for more information.
[35:24] But that still leaves a pretty big
[35:25] question open. How do we actually get
[35:27] more information? As much as I've been
[35:30] trying to avoid it, this is a place
[35:31] where I have to remember that Wordle is
[35:33] in fact a word game and not just a math
[35:35] puzzle. Let's take a look back at our
[35:37] alphabet tier list. One nice thing about
[35:39] it is that the top and [music] high
[35:40] tiers have five letters each. This makes
[35:42] a lot of sense when we look at how our
[35:44] optimal strategy uses these [music]
[35:45] letters. Across our top thousand opening
[35:48] words, each of our top tier letters
[35:50] appears in the first guess at least half
[35:51] the time. And each of our top and high
[35:54] tier letters appear in the first two
[35:56] guesses a majority of the time. So this
[35:58] leads to some nice strategies. Just make
[36:00] sure to have an opening word that uses
[36:02] five of the top 10 letters. And then if
[36:04] that gives you mostly grays, [music] be
[36:05] prepared with a second word that uses
[36:07] the other five letters. Using this main
[36:10] approach in a computer search, I was
[36:11] able to find a simple strategy that is
[36:13] pretty close to optimal. We start with
[36:16] slant. If you get mostly greens and
[36:18] yellows, then just guess compatible
[36:20] answers until you get a word. If you get
[36:22] mostly grays, then guess the price
[36:24] followed by compatible answers again
[36:26] until [music] you get the word. And
[36:28] that's it. This gives you an average
[36:30] guess count of 3.67, less than a quarter
[36:33] of a guess off of the optimal strategy
[36:35] with just two words to learn. After
[36:38] years of using the same openers, the
[36:40] slant price strategy is what I've
[36:41] personally been using since I found it
[36:43] while working on this video. On one
[36:45] hand, it's within one guess every four
[36:47] games of the optimal strategy. On the
[36:49] other hand, it only requires memorizing
[36:51] two words, [music]
[36:51] so it doesn't feel so optimized that
[36:53] it's taking away from playing the game.
[36:55] Now, you can probably tell that I've
[36:57] been obsessed with Wordle for the past
[36:59] few months, maybe even more than I get
[37:00] with most of my videos. I put in a ton
[37:02] of work in analyzing every little thing
[37:04] about this game, as well as a bunch of
[37:06] variants that I don't have time to talk
[37:07] about here. If you made it this far,
[37:09] there's a decent chance that you're a
[37:11] little obsessed, too. So, I put a bonus
[37:13] video on my Patreon where I talk through
[37:14] all the things I couldn't fit in here.
[37:16] Don't worry, the video is free along
[37:17] with everything else in the Patreon, but
[37:19] it just seemed like a good place to put
[37:20] that sort of thing. The video goes
[37:22] through other parts of the game like the
[37:23] best way to get the Sea of Greens
[37:24] achievement and an analysis of the new
[37:26] world in one miniame. I went through
[37:28] what happens if you change the word list
[37:29] or even allow random nonsense strings
[37:31] instead of just words. There's an
[37:33] analysis of how we come up with hard
[37:34] words to guess in the style of my
[37:36] Hangman and Battleship videos. There's
[37:38] work on other languages, on the game
[37:40] show lingo, and a bunch of fun other
[37:42] Wordle variants. Almost everything that
[37:44] people mentioned in the comment section
[37:46] of my poll was analyzed at least a
[37:47] little bit. So, please check that out if
[37:49] you're interested. Um, but for now,
[37:51] there's one more important thing for us
[37:53] to cover in this video because we've
[37:55] been talking about how helpful it is to
[37:56] just ignore all of your previous letters
[37:58] and guess five new ones in a lot of
[38:00] situations. But for a lot of you
[38:02] watching, that's pretty useless
[38:04] information because depending on how you
[38:06] play Wordle, ignoring information might
[38:08] not be allowed.
[38:11] In hard mode, the rules of Wordle are
[38:13] the same, [music] but you're required to
[38:14] play words that are still compatible
[38:16] with the information you've been given
[38:17] so far. Well, this technically isn't
[38:19] quite true. The actual rule is that if a
[38:22] letter comes up green, you have to put
[38:23] it in the same place [music] in future
[38:24] guesses. And if a letter comes up
[38:26] yellow, you have to put it somewhere in
[38:28] the word in future guesses. This leaves
[38:30] out a few small things. There's nothing
[38:31] stopping you from putting gray letters
[38:33] back into the word or from putting
[38:35] yellow letters in places they aren't
[38:36] allowed to be. One consequence is that
[38:38] you're allowed to just reuse your last
[38:40] failed guess over and over, even though
[38:41] it obviously can't be the [music] word.
[38:44] This doesn't come up much, but there are
[38:45] occasionally cases where you would want
[38:47] to keep a yellow letter in the same
[38:48] place to avoid locking it in, or to use
[38:50] a word with a gray letter to get more
[38:52] information [music] elsewhere. Given
[38:54] what we said about ignoring letters
[38:55] we've gotten to hunt for information,
[38:57] we'd [music] have to expect average
[38:58] guesses to go up in hard mode. Here's
[39:00] that histogram of average guesses by
[39:02] word in normal Wordle. And here's what
[39:05] we get when we switch to hard mode. The
[39:07] change is actually surprisingly little.
[39:09] [music] Salot is still the best word,
[39:11] and its average guesses increase only
[39:13] slightly from 3.42 to 3.51. [music]
[39:16] The best actual answer is now trace.
[39:18] Although, there's a pretty big change
[39:20] here. Despite being one of the best
[39:21] openers in the game, is [music] actually
[39:23] impossible to guarantee a win with
[39:25] trace. No matter what strategy you use,
[39:28] some words are going to take as many as
[39:29] [music] eight guesses to solve. In
[39:32] normal mode, the game can be solved in
[39:33] at most five guesses using every single
[39:35] opening [music] word. In hard mode, just
[39:37] 22% of openers can be solved in five,
[39:40] and about one in every seven openers
[39:41] can't even guarantee a win in six. Among
[39:44] good openers, the failure rate is
[39:46] actually higher [music] with 23 of the
[39:48] top 100 and almost 20% of the top 2,000
[39:50] openers failing to guarantee a win. Some
[39:54] words require as many as 10 guesses
[39:55] [music] to guarantee a solve. And when
[39:57] we look at these words, we can sort of
[39:58] see why. It turns out that there are
[40:00] nine answers ending in ig ght. Each of
[40:04] [music] those words takes nine guesses
[40:06] to guarantee a solution. And words that
[40:08] are just outside of that family, or
[40:10] words in that families that aren't valid
[40:11] answers end up taking 10. This turns out
[40:14] to be one of the biggest differences
[40:15] between normal and hard mode. In hard
[40:17] mode, the hardest words to guess are not
[40:19] the words with uncommon letters or weird
[40:21] placements, [music] but words that are
[40:22] too similar to too many others, forcing
[40:25] you into a long guess sequence you can't
[40:26] [music] get out of. Here are some
[40:28] families of similar words that cause
[40:30] trouble in hard mode. I've included the
[40:32] [music] maximum number of guesses needed
[40:33] to solve words in the family along with
[40:35] the size of the family. In addition to
[40:38] ig ght [music] and o n d at the top,
[40:40] notice how many times we see an eer
[40:42] appear on this list. This is what dooms
[40:45] words like trace. It not only has an e
[40:47] and an r, but it also has the a t and
[40:49] [music] c from the ATC family, making it
[40:52] more likely to get stuck in one of the
[40:53] tougher families of words. For
[40:56] comparison, [music]
[40:56] here's a list of the top openers that
[40:58] can finish in five. Notice how they all
[41:00] avoid overlapping too much with our
[41:02] problem families. [music] There are no
[41:04] ERS or even S's and very few of certain
[41:07] common letters like C [music] unless the
[41:09] T is absent.
[41:11] So, how do we handle later guesses in
[41:13] hard mode when we can't use new letters
[41:15] every [music] time? It turns out the
[41:16] principles stay pretty much the same
[41:19] across our top thousand openers. We
[41:21] still use each top tier letter in most
[41:22] of our openers. [music] And each high
[41:24] tier letter appears by the second guess
[41:26] about half the time. After your first
[41:28] guess, you can find a word that uses all
[41:30] your yellows and greens, [music] plus as
[41:32] many high tier letters as you can, and
[41:34] you'll probably be in good shape going
[41:35] forward. So [music] that's Wordle. Just
[41:38] by reframing the problem, we can turn a
[41:40] simple word game into something much
[41:42] deeper. While optimizing a daily puzzle
[41:44] game might risk taking away some of the
[41:46] fun of it, I've gained a lot more
[41:47] appreciation for [music] what makes
[41:48] Wordle such an interesting challenge.
[41:51] Math usually aligns with our intuition,
[41:52] [music] but its most fascinating uses
[41:54] are often times where it doesn't. When
[41:57] we find that two vowels are better than
[41:58] four, or that four words [music] with 19
[42:00] letters are better than five words with
[42:02] 25. It can make us rethink beliefs that
[42:04] we took for granted. Working through a
[42:06] problem can lead us to insights that
[42:08] millions [music] of people playing
[42:09] billions of games couldn't find. And
[42:11] there's no fun lost in that.
[42:14] Now, if you spent some time watching
[42:15] this channel, you know that my goal is
[42:17] to take a ton of research and maths and
[42:19] analysis and use it to make decisions
[42:20] like how to choose your second Wordle
[42:22] guess or which boxes to zero out in a
[42:24] game of yatsi. So, it always makes me
[42:26] happy to see when people put this same
[42:28] type of analysis into decisions that
[42:30] actually matter. That's why I'm thrilled
[42:31] to announce that the first sponsor of
[42:33] Ballpark Figures is 80,000 Hours. The
[42:36] folks at 80,000 Hours have devoted over
[42:37] a decade to answering a single question.
[42:40] How can we use our jobs to do the most
[42:42] good over your career? A typical person
[42:44] might work for 40 years. And if you're
[42:46] working for 50 weeks a year and 40 hours
[42:48] a week, that comes out to 80,000 hours
[42:50] over the course of your career. So
[42:52] spending some time figuring out how to
[42:53] use those hours better is probably worth
[42:56] it. And 80,000 hours is a nonprofit that
[42:58] provides loads of free resources to help
[43:00] with the process. Their website applies
[43:02] detailed analysis to questions like,
[43:04] "How many lives does a typical doctor
[43:06] save?" or how does your impact vary over
[43:08] the different problems you could work
[43:09] on? They also have a podcast that I
[43:11] found fascinating even when I haven't
[43:13] been thinking about a career change.
[43:14] Their guests include Ellie Hassenfeld
[43:16] who does what I try to do but for
[43:17] improving global health, Emily Oster,
[43:19] who does what I try to do but for
[43:21] parenting, and Nate Silver, who does
[43:22] what I try to do well, with my life in
[43:24] general, honestly. I was especially
[43:26] excited when ADK reached out about
[43:28] sponsoring a video since I've gotten a
[43:29] lot of help from them over the years,
[43:31] including from their one-on-one coaching
[43:32] when I was trying to figure out my job
[43:33] after grad school. I'm sure a lot of you
[43:35] are thinking about some of the same
[43:36] things I was. So, I really hope they
[43:38] might be able to help some of you. If
[43:39] any of this interests you, I would
[43:40] definitely recommend signing up for
[43:41] their mailing list. Everything is free,
[43:43] including this entire book of career
[43:45] advice that they will just send you if
[43:47] you sign up for the mailing list. You
[43:49] can sign up at 80,000our.org/bballpark,
[43:51] which I've linked in the description.
[43:53] Again, everything is free, so the link
[43:54] is really just so they know whether or
[43:56] not to sponsor me again, but I
[43:57] legitimately recommend that you check
[43:59] them out, especially if you've been
[44:00] thinking about your career. Thanks again
[44:02] to 80,000 Hours for sponsoring this
[44:04] video. And with that, I bid you a deal.
