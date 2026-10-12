---
source: https://www.youtube.com/watch?v=PvMYjcQg75M
author: Gym Leader Matt
title: "I Simulated 170,000 Battles to Rank All Generation 1 Pokémon"
clipped: 2026-10-12
published: 2026-10-09
type: youtube
duration: "51:32"
transcript: auto-generated captions (asr), via tools/fetch-youtube-transcript.py
---

[0:01] I've spent years ranking Pokemon by how
[0:04] fast they can solo run Pokemon Red using
[0:06] just that one Pokemon [music] and no
[0:08] items in battle. But since I'm barely
[0:10] halfway done after half a decade, I
[0:13] decided to speed up the process.
[0:15] Building off of the Weedle simulation
[0:17] videos, I built a tournament. All 151
[0:19] Pokémon will compete in a 1v one round
[0:22] robin where each Pokémon faces each
[0:24] other Pokemon 15 times for around
[0:27] 170,000 battles. We'll run that. go over
[0:29] the results. So, I say join me as we
[0:32] take a journey to find the very best
[0:34] like no one ever was.
[0:37] [music]
[0:38] Before we dive into the results, we need
[0:40] to go over the fundamental differences
[0:42] between a solo run and this [music]
[0:44] tournament. In a normal solo run, one of
[0:47] the biggest factors is a Pokémon's
[0:49] growth rate. Your level at the end of
[0:50] the game can vary a lot depending on how
[0:52] quickly your Pokemon levels up. And that
[0:54] is something that doesn't naturally
[0:56] occur in a competitive tournament. Since
[0:58] growth rate is such an important part of
[0:59] a solo run, I wanted it to matter here,
[1:02] too. I took the rough experience that
[1:04] you would get if you beat the game with
[1:05] the minimum number of battles plus one
[1:07] extra battle, and I used that as the
[1:09] baseline. This means that the slow
[1:11] growth rate Pokémon are going to start
[1:13] at level 50, medium fast at 53, medium
[1:16] slow at 54, and fast at 58. stat
[1:19] experience uses the same baseline. So,
[1:20] no Pokemon has an advantage there. I'm
[1:22] not really going to go into the details,
[1:24] but every Pokemon roughly has 10 to
[1:26] 12,000 in each stat. Outside of that,
[1:28] every Pokemon has perfect DVs. Both
[1:30] sides of the field uses PP, and every
[1:32] contestant is treated as having all
[1:34] eight badges, so that means the badge
[1:36] boost glitch will be in play.
[1:42] There are a few moves I had to make
[1:44] decisions about. I've banned toxic,
[1:46] mimic, and double team, the TMs. Anyway,
[1:48] Pokemon that learn double team via level
[1:50] up can use it like Pikachu. We keep
[1:52] that. Toxic is just too slow for a
[1:54] tournament where the battles are just
[1:55] over in a few turns. And double team is
[1:57] just ridiculous with the badge boost
[1:59] glitch. And mimic was really annoying to
[2:01] get to work consistently in this format.
[2:04] Sleep, however, is completely legal. Gen
[2:06] one sleep is incredibly broken. It lasts
[2:08] anywhere from 1 to seven turns, and the
[2:11] last of those turns is the one where
[2:12] they wake up, and you just don't even
[2:14] get to take a turn then. And then
[2:15] there's explosion. Explosion has 170
[2:18] base power and silently halves the
[2:20] opponent's defense and the damage
[2:22] calculation, making it a disgusting 340
[2:25] effective power move on neutral targets.
[2:27] And this move isn't allowed in solo
[2:29] runs. But I wanted Pokémon that can
[2:30] learn it to have a unique weapon that
[2:32] they otherwise would not have because
[2:34] you will never see this move on my
[2:36] channel otherwise. More importantly, it
[2:38] gives some of the better Pokémon a way
[2:40] to fight back against the monster that
[2:42] is Mewtwo. And it really does create
[2:44] some really interesting situations in a
[2:46] 1v one format that I had to build my AI
[2:49] around. And speaking of AI, I do think
[2:51] it's kind of sad we live in a day and
[2:52] age where I'm kind of scared to say
[2:54] those two letters because someone will
[2:56] undoubtedly comment on my video now, but
[2:59] in this specific case, everybody pay
[3:01] attention. We mean the AI that the
[3:03] computer uses to battle in the game.
[3:05] Generation 1's original battle AI is
[3:07] notoriously bad, and it often makes
[3:10] decisions based on things like, hey,
[3:11] what's a move's type rather than whether
[3:14] the move actually makes sense to use,
[3:16] which is why you get situations like
[3:17] Laureliz Dong repeatingly using rest
[3:20] against Weedle. That obviously wasn't
[3:23] going to work for this. If I'm going to
[3:25] simulate 170,000 battles and use them to
[3:28] rank every Pokemon, I don't want to find
[3:30] out which Pokemon is the best at taking
[3:33] advantage of a 30-year-old computer
[3:35] game. I want the battles to be
[3:37] reasonable representations of what would
[3:39] happen if both Pokemon were being played
[3:41] by someone who actually knew what they
[3:43] were doing. So, I built my own AI and I
[3:45] call it the brain. And I'm very
[3:47] creative. The brain is essentially a
[3:49] priority checklist. It looks what's
[3:51] happening in the battle, and it kind of
[3:52] works its way down a list of possible
[3:54] decisions, starting with things like
[3:56] securing a knockout, uh, dealing with an
[3:59] incoming explosion, taking advantage of
[4:01] things like sleep or speed control. And
[4:04] if none of any of this applies above it,
[4:06] it falls back to healing, setting up,
[4:08] using substitute, and eventually it
[4:10] works its way down to where it just uses
[4:12] the move that does the most damage. That
[4:14] last rule is actually the most common
[4:16] decision that the brain makes at around
[4:18] 25% of the whole field. And this is
[4:20] obviously a very quick and simplified
[4:22] explanation. I could probably sit here
[4:24] all day and spend every single second
[4:26] talking about the different versions I
[4:28] had to build and the weird situations
[4:30] that I had to start to account for, but
[4:32] that's not going to be good for that
[4:33] retention time. You clicked for a
[4:34] tournament, and all you really need to
[4:36] know is that these Pokémon are going to
[4:38] be making decisions that make [music]
[4:39] sense for the most part.
[4:45] Now we can get into how the tournament
[4:46] works. Every Pokemon plays each other
[4:49] Pokemon 15 times, swapping between the
[4:51] player and computer side so that neither
[4:53] gets stuck in the same position. If a
[4:55] battle reaches 50 turns, it's a draw.
[4:57] Once all the battles are finished, we're
[4:59] going to take those roughly 170,000
[5:01] battles and use them to calculate a
[5:03] rating for every Pokémon. And I'm going
[5:05] to be using a modified Bradley Terry
[5:07] rating system. essentially an ELO system
[5:10] built around the results of these
[5:12] head-to-head battles. And most
[5:13] importantly here, I am not running
[5:15] original hardware through an emulator.
[5:17] I'm using the Gen 1 Remp or the the G1R
[5:20] Deluxe as it's called now as the
[5:23] foundation for the battles. Its code
[5:25] base is closely compared against the
[5:27] Pokey Red Disassembly and other
[5:29] established implementations like Pokémon
[5:31] Showdown. So, we're getting actual
[5:33] mechanics, quirks, and the overall
[5:35] essence of generation 1. It's just going
[5:37] to look a little bit different. And
[5:39] finally, here's how we're going to look
[5:40] at the results. Each Pokemon will get
[5:42] one of these cards showing its overall
[5:45] rankings, ELO, typing, moves, wins,
[5:47] loss, draws, the record, the percentage,
[5:50] the best win, the best loss. Pretty much
[5:52] everything you could ever want to know
[5:53] about a Pokémon is on this card. And
[5:55] we'll also take a look at some of the
[5:56] battles themselves because the numbers
[5:58] never really tell the whole story. With
[6:01] all 151 Pokémon fighting each other,
[6:04] there are some really interesting
[6:05] results waiting for us. So, with the
[6:07] tournament complete, the dust settled,
[6:09] let's start from the bottom, and let's
[6:11] see how things look. I have a real quick
[6:14] post editor Matt note here that I had to
[6:17] insert in before we get into the
[6:18] rankings. The substitute and minimize
[6:20] sprites that you're about to see are a
[6:22] little bit messed up. I hand drew all
[6:24] 151 of these sprites for this project
[6:27] along with the custom battle arena, but
[6:29] I somehow completely forgot about those
[6:31] two sprites. By the time I realized it,
[6:33] I was way too deep into this project to
[6:35] ever go back and just fix everything.
[6:37] So, I just wanted to point it out before
[6:39] you start seeing them. I am aware that
[6:41] they're messed up, and hopefully it
[6:43] doesn't affect your experience. Also, I
[6:45] want you guys to know that I put a
[6:47] monumental amount of work into this
[6:49] video. So, if you want to see more
[6:50] simulationbased Pokemon content like
[6:52] this, consider subscribing to the
[6:54] channel. Maybe give me some of those hot
[6:56] points. It really helps out a lot. I
[6:57] appreciate you guys. But let's get back
[6:59] uh to the rankings.
[7:05] Starting at the bottom, we got the Z
[7:06] tier. And this mirror solo running
[7:08] because these Pokémon can't beat the
[7:10] game. Kuna, Metapod, Magikarp, they all
[7:12] have negative ratings because they are
[7:14] abysmal in pretty much every way. But
[7:16] let's start this one out with a literal
[7:19] bang. You see, in generation one, every
[7:21] move, regardless of whether it's 100%
[7:23] accurate, has a 1 in 256 chance to miss.
[7:26] And we call that the Gen One miss. And
[7:28] Metapod had a faithful encounter with
[7:30] Mew, one of the best Pokemon in the
[7:32] tournament. In turn one, Mew says, "Hey,
[7:34] I'll just explode, win in one turn, get
[7:35] out of here, go to the next game." But a
[7:37] Gen One miss turns the tables. And here
[7:40] already we got the biggest upset in the
[7:42] whole tournament, an ELO difference of
[7:44] over 3,000. And you love to see it. This
[7:46] is what I love about generation one. And
[7:48] these Pokemon are exactly where you
[7:49] would expect. Magikarp, I thought it
[7:51] would be here. Then you got Caterpie and
[7:52] Weedle. They round out the negative ELO
[7:55] Pokemon. Weedle is the best of the
[7:57] Ztier. But let's be honest, I I don't
[8:00] possibly think I can have any more to
[8:01] say about Weedle at this point. Or can
[8:03] I? Zubat, however, is an upset machine.
[8:06] With Confuse Ray, all things are
[8:08] possible. So, jot that down. And even
[8:10] though it finds itself all the way down
[8:12] here, it does have one win against the
[8:14] top 10. It has three wins in the 11th
[8:16] through 40th place brackets and 58 wins
[8:19] on the 41st to 100th Pokémon. So, Zubat
[8:23] did pretty well for itself. And now we
[8:24] get to see those early game birds and
[8:26] critters. You got Pidgey, Spiro. They
[8:28] went 0 and5 against a combined 189
[8:31] opponents. They are not very good at
[8:32] all. And Rattata did manage a crazy
[8:35] upset on Gengar with super fang
[8:37] coverage, but it didn't fare that well
[8:39] against anyone else. Netheran female has
[8:41] one of the biggest upsets in the
[8:43] tournament. It stunned Zapdos in just
[8:45] five turns despite an ELO difference of
[8:47] around,00 points and it even has a win
[8:50] against Venusaur which is another pretty
[8:52] high up Pokemon. Ditto is really
[8:53] interesting to me because it's actually
[8:55] ranked higher here than it would be in a
[8:57] solo run. In a format that lasts only
[8:59] about three turns on average. Spending
[9:01] your first turn transforming while your
[9:03] opponent gets to hit you with whatever
[9:05] they want is just a losing recipe. Ditto
[9:07] is basically a walking mimic and this
[9:09] being so slow and putting you behind is
[9:11] another reason why the move is banned.
[9:12] And we can just finish up the F tier
[9:14] real quick. We got Growlithe, Nidaran,
[9:16] Mankey, and I guess Mankey does get to
[9:18] say it's the head of the F tier. The D
[9:20] tier is where I personally think things
[9:22] are a little bit boring. Not because I
[9:24] don't love the Pokémon. There are some
[9:25] pretty cool ones here, but because
[9:26] everything down here essentially has a
[9:28] better version somewhere else above it.
[9:31] You got Machop, Diglett, Krabby, Eevee,
[9:33] Shelder. They're just out here doing
[9:35] their very best. And Ekkins will get a
[9:37] quick highlight because it's the stall
[9:39] king of the tournament. It just doesn't
[9:41] have the stats to back it up. But it is
[9:43] a trapper and it uses rap to slither its
[9:46] way to a few victories. And as a result,
[9:48] it has 12 draws, which is by far the
[9:51] most in the entire tournament.
[9:54] Pidgeotto is the lowest rated evolved
[9:56] Pokémon that isn't a cocoon. It's not
[9:58] specifically terrible, but when you kind
[10:00] of add up the whole package, including
[10:02] losing to its own little brother,
[10:03] Pidgey, it's hard to feel any sympathy
[10:05] for this little guy. And speaking of
[10:07] sympathy, Beedrill is just in a sad
[10:10] state. It has the best bug move in the
[10:12] game, but it's only 25 base power, hits
[10:14] twice. Its physical bulk and special
[10:16] bulk are just terrible. And it carries
[10:19] Swords Dance in a format where you
[10:21] really don't have the luxury or the time
[10:23] to set up. And just to put it into
[10:25] perspective, we are going to need to go
[10:26] up 53 more ranks before we find another
[10:29] fully evolved second stage Pokémon.
[10:32] Farfetched is kind of the same problem.
[10:34] Its big claim to fame is getting an
[10:36] early swords dance. That's why it's any
[10:37] good at all in a solo run. But once you
[10:39] take that away, you're left with body
[10:41] slam, sand attack, fly, like it's pretty
[10:43] bad. But setup sweepers having to adjust
[10:46] to a 1v one format that's just this
[10:48] quick is one of the more interesting
[10:50] things about the tournament. We got
[10:51] Vulpix next. We'll quickly go through
[10:53] these. Kabuto, Goldine, Cubone, Doduo,
[10:56] Sandshrew, and then Hitmonchan. I don't
[10:59] think anybody thought Hitmonchan would
[11:00] be good. It's 14th in attack, 57th in
[11:02] speed. But like you already know, being
[11:04] a genuine one fighting type is a fate
[11:06] worse than death. Fighting is ranked
[11:08] 14th out of the 15 types, and body slam
[11:10] is actually its best move, not the stab
[11:13] submission. That's how bad submission
[11:14] is. Charmander rounds out the D tier,
[11:17] and coughing is going to start that D+
[11:19] area. Ryhorn, he's doing what he can
[11:22] with what he's got. It's not much.
[11:24] Dratini is our first dragon, and Grimer
[11:26] is another exploder. Meowth is
[11:28] interesting because it's actually the
[11:30] 36th fastest Pokemon and it has a 15-0
[11:33] record against Ghastly. And at 115th, we
[11:36] see Squirtle, our second starter. I'm
[11:38] not saying Bulbasaur is the best starter
[11:40] just yet, but I am saying we haven't
[11:41] seen it yet, and we've seen the other
[11:42] ones, so I guess I kind of am. Then you
[11:44] got Geodude, Psyduck, Tentacle, and
[11:46] Seal. And I do find it like a perfect
[11:48] show of symmetry that Nidarina and
[11:50] Nidarino landed right next to each
[11:52] other. You love to see it. And then we
[11:53] get to Pikachu. And this Pokemon does
[11:55] pretty well despite being abysmal in a
[11:58] solo run. It's one of the very few
[11:59] Pokemon that learned double team
[12:01] naturally. And how many times can you
[12:03] say that you've ever seen a Pikachu beat
[12:05] a Mewtwo? This right here, ladies and
[12:08] gentlemen, this is exhibit A as why the
[12:10] TM for double team is banned. Then we
[12:13] got Horsey, Almanite, Golbat,
[12:14] Bellsprout, but Paris actually has 27
[12:17] wins against the top 10. Kind of crazy.
[12:20] Spore, in my opinion, is the best move
[12:22] in the game, and naturally, it is only
[12:24] learned by this little guy and his
[12:26] evolution that we will see a little bit
[12:27] later. And there's just there's not a
[12:29] lot to really say about Onyx. It's
[12:31] seventh in physical bulk, but its attack
[12:33] stat is so pathetic. And even being an
[12:36] exploder can't save it from falling
[12:38] right below the top 100. And then we got
[12:40] Magnemite. And the king, the very top of
[12:43] the D tier is Ponyt. Oddish kicks off
[12:45] the C tier. And now we start to see some
[12:48] more interesting Pokémon. And you got
[12:49] Machoke, Licky Tongue, Hitmon Lee.
[12:51] Hitmon Lee is sixth in attack out of the
[12:53] entire field, but just like Hitmonchan,
[12:55] it's a fighting type in Gen One. That's
[12:57] the crime that it committed. Aerodactyl
[12:59] is another Pokemon I was really rooting
[13:01] for. It's the fourth fastest Pokemon in
[13:03] the entire tournament, but it just does
[13:05] not have great moves. If this thing
[13:07] learned Rocklide, it might raise it way
[13:09] above this, but it just doesn't. It
[13:11] doesn't even get it in Gen 2. I probably
[13:13] shouldn't say that. I have not checked.
[13:15] And then we get to Slowpoke, the channel
[13:16] mascot. And to no one's surprise, it is
[13:19] the slowest Pokemon in the whole format.
[13:21] Thunderwave and Amnesia are interesting
[13:23] tools, but it really just can't
[13:25] capitalize on them. And then we got
[13:26] Marowak. It's another interesting one
[13:28] because I feel like it has so many move
[13:30] options, but the reality is that it only
[13:32] has two moves. Marowak's thought process
[13:35] are earthquake everything. And if
[13:36] they're immune to earthquake, use
[13:37] Blizzard. Nothing else is good on this
[13:40] Pokemon. I have simulated the moves.
[13:41] It's a good time to talk about that and
[13:44] go into detail about why the learn sets
[13:46] got chosen. I picked the moves manually
[13:48] at first using my experience and
[13:50] knowledge of solo running, but this
[13:51] tournament forced a metag game, and some
[13:54] Pokémon needed completely different
[13:55] moves to be viable here. After testing
[13:58] some simulations, I started to look at
[14:00] move usage, and I started to cross
[14:01] reference Smogan's competitive learn
[14:03] set. Eventually, I did sim all the
[14:05] available moves to see which one
[14:06] actually gives each Pokemon the biggest
[14:08] gains in the tournament. So, when you
[14:10] see a learn set here, and you're
[14:12] wondering, why does a Pokemon have this
[14:14] or why doesn't he have that? There is a
[14:15] method to this madness. Everything is
[14:18] ultimately based around getting the
[14:19] highest performance in this specific
[14:21] tournament. Now, let's keep it moving
[14:23] on. We have Benonat, Jigglypuff,
[14:25] Charmeleon, Voltob, Dragon, Graler, and
[14:28] then we get to Scyther. Scyther is a
[14:30] cool Pokemon, but it's another Pokemon
[14:32] that I would say is known for Swords
[14:34] Dance in a format that doesn't really
[14:35] allow setting up. So, instead, it runs
[14:38] Slash for that guaranteed crit, and it
[14:40] gets double team naturally. It's [music]
[14:42] fast. It ranks number 13th out of
[14:44] everything. It has the 12th highest
[14:46] attack, but poor special bulk and an
[14:48] absolute horrible typing leaves it
[14:51] around that average 1500 ELO mark. Rydon
[14:54] is one of the most extreme examples of
[14:56] the difference between competitive
[14:58] Pokémon and a solo run format. It's
[15:00] second in physical bulk, fifth in
[15:02] attack, 12 in HP. Those are It sounds so
[15:04] good, but it's 134th in speed. And when
[15:07] water and grass are some of the most
[15:10] common toppings and blizzard is the
[15:12] second most used in the entire format,
[15:15] that speed becomes a massive problem.
[15:17] And now we're going to keep going
[15:18] straight into Abra, which is the
[15:20] opposite of Rydon. In a solo run, Abra
[15:23] is absolutely the bottom of the barrel
[15:25] because of things like the Brock split
[15:27] where you have to use struggle for a lot
[15:29] of the game. But take those shackles off
[15:31] and suddenly these raw stats matter.
[15:34] Sure, it does have the worst physical
[15:35] bulk in the entire tournament and the
[15:37] 148th ranked attack, but the special,
[15:40] the speed, they're pretty good. And it
[15:41] manages a 25% win rate against the top
[15:44] 10 of the whole tournament. So Abra
[15:46] Abra's kind of cooking in this one. From
[15:48] there, we have Staru. And then we got
[15:49] Bulbasaur, which is the highest ranked
[15:51] starter. And we'll talk specifics when
[15:52] we get to the evolve form, but being
[15:54] right next to war turtle tells you how
[15:57] well Bulbasaur is set up in this format.
[16:00] We got Porygon, who doesn't really have
[16:01] any stats to do anything noteworthy. And
[16:04] execute gets the distinction of being
[16:06] the only Pokemon that learns explosion
[16:09] but doesn't want to use it. And then we
[16:11] have Primeape, Pidgeot, Pinser, and
[16:13] finally, Arbok is at the very top of the
[16:16] C tier. Pinser specifically was one that
[16:18] I had high hopes for and I really messed
[16:20] with the learn set and I tweaked things
[16:22] but it's a bug type. That's all there is
[16:24] to it. This thing lost to Pidgey.
[16:26] Everybody point and laugh at him. Arbok
[16:28] meanwhile has great coverage. Rap does
[16:30] pretty good for itself being in a
[16:32] trapping role. It carves out a little
[16:34] niche for itself here. Getting up to the
[16:35] B minus tier. Gloom is a solid sleep
[16:38] user and Magmar, it's solid for what it
[16:40] is. We just played it not too long ago.
[16:42] Clefairy does a lot despite what its
[16:44] stats would suggest. And FOH being ahead
[16:47] of Pidgeot isn't surprising because it
[16:48] has access to Drill Peek. And what is
[16:50] cool is that this Pokemon wins on
[16:53] average in just 1.6 turns, making FO the
[16:57] fastest winner in the entire tournament,
[16:59] which is pretty crazy to see it this far
[17:01] down, but have a tournament leading
[17:03] statistic. Sea King is one of the few
[17:05] Pokémon that can actually afford to use
[17:07] an oo move. Horn drill only works when
[17:09] you're not slower than your opponent.
[17:11] And seeking speed gives it 77 targets
[17:14] where it can try. It also has agility to
[17:17] make that even better. And it does use
[17:19] horn drum on 8% of its turns. It has
[17:21] surf. It has blizzard. It even picked up
[17:23] a win against Mewtwo. So that's pretty
[17:25] cool. Flareon has the second ranked
[17:27] attack in the game, but unfortunately it
[17:29] can't do anything with it. And then we
[17:30] get to Doug Trio. Doug Trio is
[17:32] incredibly fast. It's three little
[17:34] sausages put together. Who knew it would
[17:36] be this fast? It's sixth in the entire
[17:38] tournament and it's got a stab
[17:39] earthquake. It went 15-0 against Gengar,
[17:42] Haunter, Nking, and Jolon. In fact, it
[17:46] never dropped a single game against any
[17:48] of the three ghost. And that's really,
[17:50] really impressive for this Pokemon. At
[17:52] 67th, we have Moltres. And this is a
[17:55] travesty, guys. Sit down, maybe grab
[17:57] yourself a tissue because we're about to
[17:59] hear a sad tale. It has legendary stats.
[18:02] Its coverage isn't that great. Its
[18:04] topping is very exploitable and it's
[18:06] only 46th in speed. Moltres loses 62% of
[18:10] the games when its opponent is faster
[18:12] than it. And it's just really, really
[18:14] sad to see it sitting all the way down
[18:16] here while the other legendaries are
[18:18] having a party way up higher on the
[18:20] leaderboard. Drowsy does very well for a
[18:22] base stage Pokemon and Butterfree is
[18:24] another sleep user that just does not
[18:26] have the stats to take advantage of it.
[18:28] And then we got Golem. Golem is the
[18:30] bulkiest Pokemon in the game in terms of
[18:32] physical bulk and ranks in the top 10 in
[18:35] attack. More importantly for this
[18:36] format, it has two distinct advantages
[18:39] over Rydon. It's 19 spots higher in
[18:42] speed, which matters a lot. And it gets
[18:43] access to explosion, and that's enough
[18:45] to make it the highest rated rock ground
[18:48] type in the tournament. And from there,
[18:49] we got Rapid Ash. The Pokemon fan club
[18:52] chairman just raised an eyebrow and just
[18:53] started paying attention. Then we got
[18:55] Weeping Bell. And we got Kingler to
[18:57] round out that B minus tier. And Kingler
[18:59] is one of those rare Pokemon that can
[19:00] actually make pretty solid use of Swords
[19:02] Dance. This thing has crazy defense,
[19:04] crazy attack. I think Kingler is a very
[19:06] interesting Pokemon. Starting with the B
[19:08] tier, we got Parasect. It's 143rd in
[19:12] speed, very slow, but against Spore, and
[19:13] we already know how powerful that is. I
[19:15] think it's the strongest move in the
[19:16] game. And if you cannot one-shot
[19:18] Parasect, you're going to be taking a
[19:19] nap and you're probably going to lose.
[19:21] Just ask Mewtwo. He would know. Muk is
[19:23] everyone's favorite Pokemon to spell
[19:25] backwards. It's still a pretty solid
[19:27] exploder. Then we have Sand Slash,
[19:29] Radicate, Arcanine, and Machamp. Machamp
[19:32] has the highest attack in the whole
[19:33] field. It has excellent coverage, but at
[19:35] this point, you already know what I'm
[19:36] going to say. It's a crime to be a slow
[19:39] fighting type in generation one. Just
[19:41] existing is hell. Polywag is an
[19:43] extremely high pick here for a base
[19:46] stage Pokemon, and there's really no
[19:47] mystery why. If there is, let me let me
[19:49] tell you. It has hypnosis, amnesia, and
[19:52] enough speed to actually make use of
[19:53] these tools. It's 32nd overall in speed,
[19:56] which is really fast. And I'm going to
[19:57] keep harping on it. Sleep is just really
[19:59] powerful. And the fact that we're seeing
[20:01] this at only 54th is going to tell us a
[20:04] lot about its evolutions coming up. Sie
[20:06] after that. And I don't want to call
[20:07] this guy out, but it did go 0 and 15
[20:09] against Pikachu. Like, how can you not
[20:11] beat a Pikachu a single time? The world
[20:13] may never know. Then you got Tentacru,
[20:15] Kabuto Ops, Wheezing, and then we get to
[20:17] Gyarados. Gyarados is a menace, iconic
[20:20] generation one Pokémon. It's top five
[20:22] material in solo run rankings. I had a
[20:25] really good run with it on an older
[20:26] video, but electric damage is so much
[20:29] more widely distributed in this format,
[20:31] so you can kind of see where it would
[20:33] run into problems. Golduck doesn't have
[20:35] a ton going for it, but I want to
[20:36] clarify the move pull here. I only
[20:38] pulled moves from the generation 1
[20:40] Pokémon games, Red, Blue, and Yellow.
[20:42] I'm aware of things like Amnesia Psyduck
[20:45] or like, I don't know, Dragon Rage
[20:46] Magikarp from Pokémon Stadium. In fact,
[20:48] I have a video on it, but that's not the
[20:50] version of generation 1 I'm trying to
[20:52] simulate. I wanted this tournament to
[20:53] follow the games themselves rather than
[20:55] obscure stadium moves. And if you scroll
[20:58] down and you see somebody say, "Why
[20:59] didn't Psyduck have amnesia?" You let
[21:01] them know what's up. Tell them I told
[21:02] you that you could say that. The Drio
[21:04] takes the crown for the best normal
[21:06] flying bird. To no one's surprise, it's
[21:08] a really good Pokémon. And Magneton is
[21:10] much higher than I expected. It has the
[21:12] fifth ranked special. And I think that's
[21:14] really easy to overlook because I feel
[21:16] like the perception is that it's pretty
[21:18] weak. And then Raichu was another
[21:19] electric type that really struggles in a
[21:21] normal playthrough but works so much
[21:23] better here in this 1v one setting. You
[21:25] got Ash's dad, Mr. Mom at number 43. And
[21:28] then Avysaur is getting very close to
[21:30] the starter evolutions. And now I think
[21:33] we need to slow it down for this one
[21:35] because I'm so happy about my boy Slowb
[21:38] Bro here. Slowb Bro is actually fourth
[21:40] in physical bulk if you didn't know.
[21:41] It's very bulky and despite being 144th
[21:45] in speed, speed was almost never a
[21:47] factor in its losses because it runs
[21:49] Thunderwave. With that physical bulk and
[21:51] access to Amnesia, it can become a
[21:53] complete wall. Thunderwave, lower their
[21:55] speed, raise your special, rest if you
[21:57] need it, and then you start attacking
[21:59] with a boosted psychic. It has a near
[22:01] 65% win rate, and I think Slowb Bro is a
[22:04] perfect example of a Pokémon that uses
[22:06] every tool that it has available to do
[22:08] the best that it possibly can. Right
[22:10] after that, we have Blastoise. It's the
[22:12] first final stage starter that we've
[22:13] seen. It's one of the few Pokemon that
[22:15] are willing to take withdrawal
[22:17] specifically for the badge boost glitch,
[22:19] and its stats are in a range where that
[22:21] 12.5% boost can actually flip some
[22:24] matchups or flip some speed ties or
[22:27] whatever the case may be. In a lot of
[22:28] ways, Blastoise embodies what I wanted
[22:31] this tournament to be. Dragonite is
[22:33] another very intriguing pick. It has
[22:35] crazy high attack. Not really many ways
[22:37] to use it, but it does have a niche.
[22:39] It's a very fast rap user that has
[22:41] access to agility and it can potentially
[22:44] win any fight. At nearly 1,800 ELO, it
[22:47] does it does fine for itself. It's a
[22:49] pretty fine placement, but Blizzard is
[22:51] so extremely common in this tournament
[22:53] and you're double weak to ice. It's just
[22:55] very risky to rely on rap. Moving up to
[22:57] the B+ tier, Alar is one of the Pokemon
[22:59] that I really personally underrated.
[23:01] It's double weak to grass, but it still
[23:04] wins 40% of those matchups. And it has
[23:07] the sixth best physical bulk and [music]
[23:09] the 14th best special. Pretty solid
[23:11] Pokemon. And speaking of solid, Kadabra,
[23:13] to no one's surprise, it's a middle
[23:15] stage, but it stats are really good.
[23:17] Then we have Snorlax, which everybody
[23:19] knows, iconic generation one Pokemon.
[23:21] It's one of the very few Pokemon that
[23:23] learns self-destruct, but not explosion.
[23:25] Uh, fun fact, the only other one is
[23:27] Mewtwo. But Snorlax has a huge move
[23:30] pool, monster attack. It can learn
[23:32] anything and it gets access to Amnesia.
[23:34] It's just too slow to use it. Snorlax's
[23:36] big claim in this tournament is going 9
[23:38] and six against Mewtwo, which is a
[23:40] pretty good split. In the next slot, we
[23:41] have Nintendo's favorite son, Charizard.
[23:44] Outside of Marowak, I think this one had
[23:46] the most move changes. Instead of just
[23:47] learning like Swords Dance like you
[23:49] would in a solo run, it's going to use
[23:51] Slash, Fire Blast, Earthquake, and
[23:52] Substitute for a much more immediate
[23:55] game plan to not have to set up.
[23:56] Charizard has a 44% win rate against the
[23:59] top 10 and it went 15 and0 against
[24:01] Alakazam. So Charizard has some nice
[24:03] little stats here, but not as nice as
[24:05] Gastly because Gastley is easily the
[24:07] best base stage Pokemon in the entire
[24:10] game. I think most of us knew that.
[24:11] Ghost typing gives it that normal
[24:13] immunity that's pretty huge. It has
[24:15] hypnosis, great moves. It even has
[24:17] access to explosion. It's really only
[24:19] held back by the ground weakness and the
[24:21] fact that it has a very pathetic 149th
[24:24] ranked physical ball. This thing is like
[24:26] a piece of paper. Next, we got Electrode
[24:28] and Electabuzz. And seeing two electric
[24:31] types this high messed with my brain a
[24:33] little bit. Electrode is the fastest
[24:35] Pokemon in the entire tournament. It has
[24:37] stab thunderbolt. It gets access to
[24:39] explosion. And outside of the ground
[24:40] types, it handles itself so much better
[24:43] than I could have ever thought. And
[24:44] Electabuzz isn't too far behind. It has
[24:46] the 11th highest speed. And it has this
[24:49] very, very rare psychic coverage that no
[24:52] other electric type really has. and it
[24:54] even went 13 and two against Mew. So,
[24:56] pretty impressive in its own right. And
[24:58] for the same reason I praise these
[24:59] Pokemon, I got to belittle Exeutor just
[25:02] a little bit because it's another
[25:03] Pokemon that's a competitive monster.
[25:05] It's really not that great in a solo run
[25:07] because it's very slow, but if you look
[25:09] at its overall kit, it has very high
[25:11] special bulk. It has sleep, it has
[25:13] explosion, it has a psychic resistance.
[25:16] It did lose to Pidgey, though. It's like
[25:18] the huge mark of shame on this Pokemon,
[25:20] so maybe that's why it's only 31st. You
[25:22] lost to a Pidgey brother. Ninetails came
[25:24] completely out of nowhere for me. I
[25:26] expected this Pokemon to be okay, be
[25:27] around the B tier. I've played it
[25:29] before, but being the highest rated fire
[25:31] type in Kanto was not on my radar. Was
[25:33] it on anybody else's bingo card? I doubt
[25:35] it. It has a very simple damaging set
[25:38] with really great coverage, it doesn't
[25:40] have that pesky flying subtyping like
[25:42] Charizard. But of course, the mark of
[25:44] shame. It still lost to Rattata. Bile
[25:46] plume is the lowest ranked fully evolved
[25:49] sleep powder user in the top 30 and it's
[25:51] 29 which kind of tells you how powerful
[25:53] that archetype is. And then let's go
[25:55] through these pretty fast here. We got
[25:57] Kangaskhan, Dong, Nqueen, Cloister. Now
[26:00] Kangaskhan's low special bulk really
[26:02] holds it back. And Dong is just a big
[26:04] tank with Surf and Blizzard. Both stab
[26:07] and NQ really feast in that lower 50
[26:10] area. Has a 98% win rate there. And
[26:13] Cloyster is that premier defensive wall.
[26:16] It has the third highest physical bulk,
[26:18] access to explosion. It has a unique
[26:20] trapping move and clamp. And then it has
[26:22] stab, surf, and blizzard. So, this thing
[26:24] has a lot of stuff. And before we gush
[26:26] over that, I have to get to my actual
[26:28] biggest surprise in the whole
[26:29] tournament. Jolon at number 24. Did
[26:32] anybody see this coming? Just like
[26:33] Electrode, it's really fast. It's the
[26:35] second fastest Pokemon in the entire
[26:37] game or in this tournament specifically,
[26:39] but it has an interesting toolkit.
[26:41] Thunderbolt's the old reliable option.
[26:43] Sand attack gives that disruption. And
[26:45] you got pin missile to help against
[26:47] psychic attacks. And then double kick
[26:49] actually gives you something to hit rock
[26:50] and ground types that give the other
[26:52] electric Pokemon so much trouble. And
[26:54] the problem really is consistency. Jolon
[26:57] has 33 losing records against lower tier
[27:00] Pokémon. And that's why this is the
[27:02] absolute max of this Pokemon. And then
[27:04] we got Poliwhirl up next. This is an
[27:06] extremely highly rated middle-stage
[27:08] Pokémon. But spoiler alert, it's not
[27:10] even close to the highest one in the
[27:11] tournament. but it has surf hypnosis,
[27:14] amnesia, great tools, the exact same
[27:16] thing that made Poliwag so good, except
[27:18] Poliworld just has better stats. Then we
[27:20] got Tangla. It's another Pokemon that
[27:22] has a completely dreadful, awful Brock
[27:25] split in a speedrun setting, but in this
[27:27] tournament, it's a bulky sleep powder
[27:29] user, and that's a very good archetype
[27:31] to be in. And this is another one of
[27:33] those Pokémon that I looked at it and
[27:34] said, "Wow, like is Tangler really that
[27:36] good?" Because it really showed up for
[27:38] this tournament. Lapras finishes up the
[27:39] B+ tier with Confuse Ray. It's got a lot
[27:42] of bulk, solid coverage, and it's
[27:43] followed by Wigglytuff, which has
[27:45] incredible HP, and the distinction of
[27:47] having the closest rivalry in the
[27:49] tournament, splitting Mewtwo 8 to 7,
[27:52] actually edging it out to get the most
[27:54] wins. But Wigglytuff is your top of the
[27:56] B tier. And now, I think we're getting
[27:58] to that point to where every Pokémon
[28:00] needs a shout out, except for Vaporeon.
[28:02] In fact, if you make a joke about
[28:04] Vaporeon in the comments, you will be
[28:06] silently hidden from the channel,
[28:08] banished to never talk again, because I
[28:10] refuse to believe that the Pokémon
[28:12] community cannot come up with a better
[28:14] joke. Be better and do better. That's
[28:16] all I got to say to you.
[28:20] That brings us to Nitto King. Uh, the
[28:22] speedrunner's choice has a tool for
[28:24] every occasion. Earthquake, Blizzard,
[28:26] Thunderbolt, the occasional rock slide.
[28:28] Pretty much can can hit anything for a
[28:31] lot of damage. and it averages just two
[28:33] turns of battle, only beaten by Mewtwo
[28:36] at 1.8. It has a 98% win rate against
[28:38] the lower 50 and a 91% win rate against
[28:41] the electric types. Pretty solid
[28:43] Pokemon. And then you got Articuno, the
[28:46] first legendary we've seen since
[28:47] Moltres. And I got to say this, a stab
[28:50] same type attack bonus Blizzard is no
[28:52] joke. It hits so hard and it uses
[28:55] Blizzard 63% of the time and it uses ice
[28:57] beam the other 27% of the time. So 90%
[29:00] of its turns are spent throwing out same
[29:03] type ice attacks. It did lose to Machop
[29:06] though, which is, you know, not
[29:07] something you want on your resume, but
[29:09] it is a thing that happened. Tauros is
[29:11] the quintessential normal type. Very,
[29:12] very strong Pokemon. If you know
[29:14] anything about competitive, you know
[29:15] Tauros. Stab body slam, stab hyperbeam,
[29:18] blizzard, earthquake. Best coverage that
[29:20] you can possibly have. Has an answer.
[29:22] Nothing walls it. And it wins 35% of its
[29:25] battles against the top 10. Star me runs
[29:27] four solid moves. Nothing fancy and it
[29:30] really makes great use of that 10th
[29:32] ranked speed and it swept 64 different
[29:34] Pokemon 15 and0. But let's get past it
[29:36] because Venomoth being the 14th best
[29:39] Pokemon in this tournament is complete
[29:40] insanity to me. I had to check and see
[29:42] if the simulations were right. Sleep
[29:44] powder is already one of the best moves
[29:45] in the game. But the difference between
[29:47] Venomoth and something like Butterfree,
[29:49] which is a lot lower down, is that
[29:51] Venomoth actually has the stats to
[29:53] capitalize. 40th in speed, 36th in
[29:55] special bulk, and it's 39th as a special
[29:58] attacker. Venomoth uses the best tools
[30:00] available and uses them very well for a
[30:02] very, very high finish. Zapdos is the
[30:05] top ranked legendary bird. Electric is a
[30:07] pretty solid top in this tournament and
[30:09] especially when you consider the flying
[30:10] top's actually pretty good here because
[30:12] it removes the earthquake factor at all.
[30:15] They just can't use it. You're immune to
[30:16] it now. So, you got Thunderbolt, Drill
[30:18] Peek, and some utility. Zapdos gets this
[30:21] far through sheer power rather than
[30:23] relying on status moves, which I think
[30:24] is pretty cool. And speaking of pretty
[30:26] cool, Polywrath might surprise some
[30:28] people because I think the general
[30:30] consensus is that Poliwhirl is generally
[30:32] just better in a solo run, but once you
[30:34] eliminate setup time, you can't really
[30:36] use Amnesia that much. Poliwrath wins
[30:38] with just the raw stat increase. It puts
[30:40] in some serious work here. Hypnosis,
[30:42] psychic, surf, body slam. So, it has
[30:45] solid answers for pretty much
[30:46] everything. and it's by far the highest
[30:48] rated fighting type. Although I would
[30:50] argue and I think you should argue that
[30:52] the fighting type here is a detriment.
[30:54] It's not a feature of Poliwrath and he
[30:56] wishes that he didn't have it. Nothing
[30:58] in the entire tournament swept Poliwrath
[31:00] 15-0. Although, and I got to call this
[31:02] out, this thing lost to Rattata. How'd
[31:05] that happen? What happened there? At
[31:06] number 11, we have Chansy. Chansy
[31:09] benefits enormously from not having to
[31:11] survive that brutal Pokemon red early
[31:13] game Brock battle. But this Pokemon is
[31:16] weird. It has the highest HP in the game
[31:18] by a mile, like a lot, the wide margin.
[31:21] And it's the best special wall in the
[31:22] game. And it has basically everything
[31:24] that's working in this tournament in
[31:26] this environment. It has sing for sleep,
[31:29] minimize for evasion, incredible special
[31:31] bulk, and it has ice beam and
[31:33] thunderbolt for coverage. And here's the
[31:35] big one here. Chanse is 15 and0 against
[31:38] Mewtwo. Mewtwo could not take a single
[31:41] game off of Chansy, and this is the only
[31:44] Pokemon that can make that claim. But
[31:46] now we're getting into the top 10 and
[31:47] you're going to notice a trend that
[31:49] we've been building towards the entire
[31:51] time. Sleep users. Hypno isn't really
[31:54] that special of a Pokemon. It's kind of
[31:56] bulky. It has hypnosis. It has psychic
[31:58] that it uses 55% of the time. It carries
[32:00] a 96% win rate against the bottom 50,
[32:03] 73% win rate against the next 60
[32:05] Pokémon, solid stats, psychic typing,
[32:08] access to sleep. It can almost carry you
[32:10] to the top alone. At number nine, we
[32:12] have Haunter. And don't let the fact
[32:14] that this is a middle evolution fool you
[32:16] because it has incredible special,
[32:19] incredible speed, the ghost type
[32:21] immunity to normal and it has psychic
[32:23] and thunderbolt coverage. It has access
[32:24] to explosion. If only the Gastly line
[32:27] wasn't part poison type. If they did not
[32:29] have to worry about earthquake in this
[32:30] tournament, we might see something
[32:32] completely different. And I'm going to
[32:33] quickly just skim over number eight,
[32:35] Victory Bell here. I'm going to come
[32:36] back because it has a direct comparison
[32:38] with a Pokémon we're about to see. So
[32:40] remember Victory Bell, we'll come right
[32:41] back. In the number seven spot, we have
[32:42] Alakazam. Everybody expected this thing
[32:45] to be pretty high up. It's the boogeyman
[32:46] of generation one. You have to plan
[32:48] around it. Psychic typing, third in
[32:50] speed, second in special attack, and
[32:52] just enough power to brute force its way
[32:54] through most battles just spamming
[32:55] psychic. It has seismic toss to give
[32:58] some sort of answer in the psychic
[32:59] mirror match, and it has reflect and
[33:01] recover to make it much more resilient.
[33:04] Very solid Pokemon. And then looking at
[33:06] the number six spot, we have Clefable.
[33:08] is a fast growth rate Pokemon, meaning
[33:10] it's one of the few Pokemon that reach
[33:12] level 58 in this tournament. And it has
[33:14] Sing, sleep inducing move, body slam,
[33:16] get stab, blizzard minimize. It's very,
[33:18] very similar to Chansy, but the big
[33:20] difference here is that Clefable doesn't
[33:23] have five base attack. Five base attack
[33:25] is miserable. That's going to lead us to
[33:27] number five where we have Venusaur. And
[33:29] we can kind of look back at Victory Bell
[33:31] because these two are basically two
[33:32] sides of the same coin. They have
[33:34] identical learn sets. Sleep Powder,
[33:36] Swords Dance, Razor Leaf, which always
[33:38] gets a crit in generation one, and they
[33:40] got hyperbeam. Victory Bell has much
[33:42] higher attack, ranking 13th of the
[33:44] entire field, but that doesn't really
[33:46] matter when you're already using Swords
[33:48] Dance. You can put something to sleep
[33:49] and use Swords Dance, and it doesn't
[33:50] really matter if your attack's higher.
[33:52] Venusaur makes use of being faster and
[33:54] having significantly higher physical
[33:56] bulk. Venusaur wins 47% of the time in
[33:59] the top 10 compared to Victory Bell's
[34:01] 35% and it has better records against
[34:03] Mew, Mewtwo, and the head-to-head
[34:06] ranking. Venusaur gets the victory 10
[34:08] out of the 15 times. They're extremely
[34:10] similar Pokémon, but Venusaur simply has
[34:13] better stats where it matters,
[34:14] especially speed. And all the way down
[34:16] here at number four, we have Jinx, which
[34:18] is undoubtedly the most improved Pokemon
[34:21] from its solo run counterpart. I know
[34:23] it's pretty good in competitive, but
[34:25] Jinx just struggles so much in a solo
[34:27] run because it has no moves for Brock,
[34:29] but in this tournament, it has every
[34:31] single thing that it needs. Lovely kiss
[34:34] is a signature move. It's a essentially
[34:36] a sleep powder clone. And when you
[34:38] combine that with stab blizzard, stab
[34:40] psychic, you got seismic toss for the
[34:42] mirror match. Now, it's only 25th in
[34:44] speed, 60th in HP, and 125th in physical
[34:47] bulk. But what it does have, it makes
[34:50] the most out of everything that it has
[34:52] available to it. And it's a very
[34:54] impressive performance here. Going into
[34:56] that top 10, we finally get to Gengar.
[34:59] Gengar is one of the only two A+ rated
[35:01] Pokémon in the entire field. And we've
[35:03] already seen what makes the Gastly line
[35:04] so good. Just a quick recap if you
[35:06] forgot. Ghost typing, explosion,
[35:08] hypnosis, and this one actually has the
[35:11] stats to actually take full advantage of
[35:12] it. Gengar has the best top 10 win rate
[35:15] by any Pokemon at almost 70%. It 15 and0
[35:19] sweeps. Jinx, Clefable, two top 10
[35:22] Pokemon. And we can just ignore that
[35:24] loss to Rattata. Rattata was out for
[35:25] blood and was really just taking out
[35:27] everybody. We get it, Rattata. Stop
[35:28] beating these top people. Now, finally,
[35:30] at number two, we have Mew. Now, for a
[35:32] period of time in testing, Mew was
[35:34] actually the top Pokémon. And that was
[35:36] before I made the AI changes to be aware
[35:38] of explosion and, you know, to kind of
[35:40] be able to play around it if it needed
[35:41] to. But Mew and Gengar are by far the
[35:44] best explosion users. An explosion wins
[35:47] Mew the battle 84% of the time that it
[35:50] decides to use it compared to something
[35:52] like Shelder that only wins like 20% of
[35:54] the time it explodes. When explosion
[35:56] isn't an option, you got Psychic,
[35:58] Thunderbolt, Ice Beam, it can just kind
[35:59] of carry you. And I do got to say this,
[36:01] earlier builds where Explosion was just
[36:03] running wild, there was a spot in time
[36:05] where seven of the top 10 Pokémon in
[36:08] this tournament were all explosion
[36:09] users. And I like to think I came a long
[36:11] way since then. The metag game feels
[36:13] much healthier now. But Mew is just
[36:15] still dominant with a 90% win rate. And
[36:18] we got one Pokemon left. And I think,
[36:20] you know, we all know what it's going to
[36:21] be.
[36:26] I put in so much work to make this field
[36:28] capable of standing up to the genetic
[36:30] freak, but you cannot hold Mewtwo down.
[36:33] It doesn't need sleep. It doesn't need
[36:35] defensive moves. It doesn't need a
[36:37] gimmick to win. It's going to use strong
[36:39] damaging attacks and you just need to
[36:41] hope you can put it to sleep or maybe
[36:43] hope it gen one misses. This Pokemon
[36:45] uses psychic 47% of the time and it
[36:48] cleanly sweeps. We're talking 15 and0
[36:52] 110 of the 150 Pokemon in this entire
[36:55] tournament. Despite my best efforts to
[36:57] help everybody out, explosion rule
[36:59] changes, Mewtwo still won 94% of the
[37:01] games that it was in. With a sample size
[37:03] this big and all the upsets that we've
[37:06] saw throughout the rankings, there was
[37:07] never really a question in my mind that
[37:09] Mewtwo was going to be the standard for
[37:11] a generation one Pokemon. And in fact,
[37:13] I'm of the opinion that generation 1
[37:15] Mewtwo is the strongest iteration of a
[37:17] Pokémon of all time. It stands alone
[37:20] with a grandmaster 2500 plus ELO at S
[37:24] rank. It's a very good Pokemon. That
[37:26] goes without saying. But what if I told
[37:27] you that we're not done? I think it's
[37:29] really neat to see these rankings and
[37:31] talk about all these stories. But did we
[37:33] really crown a winner? With a field this
[37:35] big, we did learn a lot. But the only
[37:37] way to truly see who's the best would be
[37:40] to push all the chips into the middle of
[37:42] the table and play a winner takes all
[37:44] sudden death best of one tournament
[37:46] against the top 16 Pokémon. The round
[37:48] robin determined the seating order. And
[37:50] I think we just take a look at the
[37:52] bracket.
[37:58] Ladies and gentlemen, welcome to the
[38:00] Sudden Death Solo Run Showdown bracket.
[38:03] I've set things up like a March Madness
[38:05] basketball bracket based on the top 16.
[38:08] And even though this was random, I
[38:09] absolutely love the matchups that we
[38:11] have here. We have Mewtwo versus Tauros,
[38:13] that's the one versus 16 matchup. Mew
[38:16] versus Star Me, that's the two and 15.
[38:17] Eight and nine is Victor Bell versus
[38:19] Haunter. Five and 12 is Venusaur versus
[38:22] Polywrath. Four versus 13, that is Jinx
[38:25] and Zapdos. Then you have a seven and 10
[38:27] matchup with Alkazam versus Hypno.
[38:29] Gengar versus Venomoth is the three
[38:31] versus 14 slot. And finally, Clefable
[38:33] versus Chansy is that six versus number
[38:36] 11 slot. Let me reiterate that these are
[38:39] a best of one. Anything goes and we just
[38:42] we truly do not know what happens here
[38:44] when the stakes are at their highest.
[38:46] Anything could happen. And I used a
[38:47] random number generator for the order of
[38:49] battles that we'll see. So I say we just
[38:52] get started with Venusaur versus
[38:53] Poliwrath.
[38:57] Kicking us off, we got two sleep users.
[38:59] Venusaur moves first, but it elects to
[39:01] go for damage, missing a Razor Leap. But
[39:03] Poliwrath misses a hypnosis, and we're
[39:06] back at square one. Venusaur goes for
[39:07] Razor Leap again, doing devastating
[39:10] damage, almost 98% of Poliwrath's HP,
[39:13] and it's in trouble. Hypnosis connects,
[39:15] but in a cruel twist of fate, Venusaur
[39:17] wakes up immediately. That's the risk of
[39:19] sleep. Polywrath goes for a psychic. It
[39:21] does a little over a third. It gets a
[39:23] special drop, but it doesn't matter
[39:25] because Venusaur is going to go for a
[39:26] massive overkill razor leaf. And that's
[39:29] the first winner in the bracket. Next
[39:31] round, we got two more sleep users.
[39:32] Haunter goes for an immediate hypnosis,
[39:34] but misses, giving Vitra Bell a shot
[39:37] with the more accurate sleep powder. It
[39:39] connects. And now we're going to see a
[39:41] big problem here. Victory Bell can only
[39:44] use the resisted Razor Leaf and it
[39:46] doesn't do a ton. It looks like it's
[39:47] going to be about a five hit in total
[39:49] and we would need to see a great roll
[39:51] for Haunter to stay asleep for that
[39:52] long, but Razor Leaf misses on the third
[39:54] turn. Haunter wakes up, lands a hypnosis
[39:56] of its own. And the big difference here
[39:58] is damage. Psychic is a clean twoot, and
[40:01] Haunter is progressing on. Up next, we
[40:04] got Jinx versus Zapdos. And this is a
[40:06] good old-fashioned damage race, what the
[40:08] AI brain calls it. Jinx is faster and
[40:10] all she needs to do here is hit a
[40:12] blizzard. She does massive damage and
[40:14] from that point, Zapdos would need a lot
[40:16] of luck, but Jinx swaps over to the more
[40:18] accurate psychic and seals a very fast
[40:20] round. Now, MW is going to get a chance
[40:22] to show everyone why it's the best
[40:24] explosion user in the format. Star me
[40:26] moves first, does some, you know, it
[40:28] does some damage, but Mew flexes its
[40:30] muscles. Turn one explosion, it gets the
[40:33] bad manners critical hit, and we're
[40:34] moving on just like that. Alakazam and
[40:37] Hypno has all the makings for a slow and
[40:39] methodical matchup between two specially
[40:41] bulky psychic users. Alakazam
[40:44] immediately goes for reflect to
[40:45] eliminate body slam as an option. And
[40:47] then Hypno goes for hypnosis. It
[40:49] connects, but Alakazam wakes up. And
[40:51] then Hypno sets up a reflect of its own.
[40:53] From there, Alakazam shows why it's
[40:55] known as a crit machine in a solo run.
[40:58] It crits with a psychic. Hypno cannot
[41:00] catch a break. It misses a hypnosis. And
[41:02] a second psychic crit in a row has Hypno
[41:05] reeling. But there's a reason why we see
[41:07] so many sleep users in the top 16. Hypno
[41:10] is going to land the hypnosis, get a
[41:12] great roll, and we're going to start
[41:13] seeing Psychic after Psychic get railed
[41:16] off relentlessly as Hypno is penciled in
[41:19] for the upset here. The final psychic
[41:21] does get a special drop. Alakazam wakes
[41:24] up, but that special drop matters
[41:26] because it means one more psychic will
[41:27] give Hypno the win. And Alakazam has an
[41:30] early exit from the tournament.
[41:31] Surprise, surprise, everybody. We got
[41:33] another sleep user battle with Gengar
[41:35] versus Venomoth. And Gengar plays a
[41:37] gambit here. Psychic is a very clean
[41:39] twoshot. It's going for the kill, but
[41:41] not going for hypnosis might cost the
[41:43] last remaining ghost type because
[41:45] Venomoth does land the sleep powder and
[41:47] it has a super effective psychic of its
[41:49] own to fight back. Gengar took Venomoth
[41:51] lightly, it appears. And ladies and
[41:53] gentlemen, Venomoth is going to land the
[41:55] three psychics necessary. Gengar is
[41:57] never going to wake up and we have a
[41:59] huge upset. The 14th seed just knocked
[42:01] off the three seed. And this is kind of
[42:03] the magic of a single elimination
[42:05] tournament. Up next, we got a battle
[42:07] between the pink normal types. Both are
[42:09] very similar, but in this case, Clefable
[42:11] outspeeds, lands the sing, but Clefable
[42:14] isn't aggressive. It's kind of pulling
[42:16] back on the reigns here. Two uses of
[42:18] minimize further widen the gap and makes
[42:20] Chansy have a huge uphill battle to
[42:22] fight. But what these minimizes do that
[42:24] was so important is it badge boost
[42:26] glitched Clefable's attack to allow body
[42:29] slam to be a very comfortable twoshot.
[42:31] And poor Chance he didn't even have a
[42:32] chance to use a single move in this
[42:34] tournament. I was actually kind of
[42:35] worried about Mewtwo because Tauros beat
[42:38] it a lot in the round robin nine times.
[42:40] But Mewtwo did not want to be outdone by
[42:43] MW's victory and it oneups everyone and
[42:45] gets a turn one critical hit psychic
[42:47] that just one-shotss Tauros. The poor
[42:49] bull never stood a chance. Mewtwo is
[42:51] looking in peak form right now from the
[42:53] jump right out the gates. And that's
[42:55] going to conclude round one.
[42:59] Going into round two, we saw some
[43:01] interesting things. The left side has
[43:03] two matchups with very clear top
[43:05] advantages, but the right side had two
[43:07] upsets. So, I'm really not sure what's
[43:09] going to happen at this point, but let's
[43:10] dive right back in.
[43:14] [music] Jinx is going to make a bold
[43:16] move. who forsake our lord and savior's
[43:17] sleep in favor of doing heavy damage
[43:19] with blizzard. But Gengar just made this
[43:21] mistake. Venusaur lands the sleep
[43:23] powder. Razor Leaf looks like it's right
[43:25] on the cusp of doing 15% damage. But
[43:27] Jinx will not be punished today. It
[43:29] wakes up. It uses psychic and it does
[43:31] get off the hook to advance to the
[43:33] semifinals. Venomoth feels like a
[43:35] Pokemon that just shouldn't even be
[43:36] here. But against Clefable, it does move
[43:38] first. It lands a sleep powder, but
[43:40] Clefable immediately wakes up. A second
[43:42] sleep powder hits. Venomoth goes on the
[43:44] offensive with a psychic and it even
[43:46] gets a special drop. But Clefable is
[43:48] just not tired and does not want to take
[43:51] a nap, but Venomoth insists and the
[43:53] third time is the charm. Venomoth is
[43:55] able to get in enough psychics that by
[43:57] the time Clefable wakes up the fourth
[43:58] time, it's only in time to see the
[44:00] inevitable death. And ladies and
[44:02] gentlemen, Venomoth, the fan favorite
[44:04] underdog, I'm just assuming that's what
[44:06] everybody thinks, is going to the
[44:08] semifinals. Mewtwo is back and this one
[44:10] gets kind of serious. And by serious, I
[44:12] mean a turn one psychic does only 97% of
[44:15] Haunter's health bar. So Mewtwo's
[44:16] falling off a lot. This level of damage
[44:19] triggered an existential crisis inside
[44:21] of Haunter, making it use the old
[44:23] desperation explosion claws in my AI
[44:26] brain, hoping for that very slim chance
[44:28] of victory. But Mewtwo just eats it for
[44:30] breakfast and moves on. Hypno has
[44:32] already dealt with one overpowered
[44:34] psychic type. Can it do it again? Mu
[44:36] starts with an ice beam, fishing for a
[44:38] freeze. It doesn't get it. Hypno's
[44:39] pretty bulky. doesn't do a lot, but it
[44:41] hits the hypnosis and Hypno does the
[44:44] smart thing. It sets up Reflect to deter
[44:46] the best explosion user in the format
[44:48] from stealing an easy victory. And from
[44:50] there, you know Hypno's game, slow,
[44:52] methodical, and grind it out to a
[44:54] victory. But two things are apparent
[44:56] here. Hypno got an extremely lucky sleep
[44:59] roll, but it cannot get a psychic crit
[45:01] or a special drop from psychic to save
[45:03] its life. And what this comes down to is
[45:06] that Mew wakes up finally at the very
[45:08] end with a sliver of health. And Mew
[45:10] only sees one way out of this. Just like
[45:11] Haunter last round, it's time for a
[45:13] desperation explosion. But we don't see
[45:16] a crit. And Hypno is showing that the
[45:18] other psychic types better take notice.
[45:25] After that round, the semi-finals are
[45:27] honestly a little bit shocking to me. I
[45:30] see why the left side is where it's at,
[45:31] but what is Viddleothth doing on my
[45:33] screen? My job is to be completely
[45:35] unbiased here and just present the data,
[45:37] but something primal inside of me has
[45:40] never wanted Venomoth to go to the
[45:41] finals more than I ever have in this
[45:43] moment. But that's enough stalling.
[45:45] Let's see how it all shakes out.
[45:52] [music]
[45:52] The first semi-final match is Mewtwo
[45:54] versus Jinx. Both have had extremely
[45:57] easy times thus far, and Jinx hasn't
[45:59] even used a lovely kiss or even tried
[46:01] for a sleep move. But I get a feeling
[46:03] that's about to change. The Mewtwo body
[46:05] slammed us slightly less than half and
[46:07] then we get to see our first lovely kiss
[46:08] of the bracket and it lands. Jinx gets
[46:11] to work with the nuke that is known as a
[46:13] stab Blizzard and we see a crit. Jinx
[46:16] just got the crit and Mewtwo is on its
[46:18] knee. It's reeling at the series of
[46:20] moves that just took place. Mewtwo is
[46:22] still asleep. A second Blizzard does not
[46:24] crit, but we see the genetic freak down
[46:26] to just a sliver of health. And at this
[46:28] point, Jinx just hands it off to Seismic
[46:30] Toss to secure the victory. And ladies
[46:32] and gentlemen, Jinx is moving on to the
[46:34] finals with a shocking upset of Mewtwo.
[46:37] I would like to think everyone is
[46:38] pulling for Venomoth at this point. It
[46:40] moves first, hits the sleep powder, and
[46:42] here we go again. But Hypno says, "No,"
[46:44] and it wakes up. Venomoth goes back to
[46:46] the powder that got it this far once
[46:48] again, but it misses. And Hypnos says,
[46:50] "I don't even need sleep for an
[46:52] insignificant little bug like you." And
[46:54] just look at this psychic damage. This
[46:56] didn't even crit. Venomoth is on the
[46:58] ground. The referee is getting close to
[47:00] the 10 count, but sleep powder connects.
[47:02] Could this be the turnaround? Are we
[47:04] giving our energy collectively to
[47:06] Venomoth as an audience so it can once
[47:08] again do the impossible? The answer is
[47:11] no. It tries to go for a double edge.
[47:13] And it's a little bit weird here because
[47:14] when you get to low HP with this little
[47:16] HUD, it doesn't update. But basically,
[47:18] Venomoth had enough HP left to do one
[47:20] double edge, take the recoil, and then
[47:22] it has to switch to psychic. And at that
[47:24] point, I really did like the potential
[47:26] story that was unfolding with Venomoth.
[47:28] But Hypno is advancing to the finals.
[47:34] [music]
[47:35] It's been a long journey so far. What
[47:37] started as 151 Pokémon doing around
[47:40] 170,000 battles has eventually
[47:42] culminated into just two Pokémon left.
[47:45] And very fittingly, they are two psychic
[47:47] types that have sleep inducing moves.
[47:49] And both of these Pokemon are
[47:51] responsible for knocking off the clear
[47:53] favorites of the tournament, Mewtwo and
[47:55] Mew. And we've came this far. Let's go
[47:57] ahead and close it out.
[48:02] [music]
[48:04] Jinx has a lot going on compared to
[48:06] Hypno. First and foremost, it has higher
[48:09] speed and a higher accuracy sleep move.
[48:12] Those two things alone can decide this
[48:14] battle. But can I interest any of you
[48:16] guys in a couple of stab blizzards for
[48:19] the road? Now, Hypno is taking a
[48:20] well-deserved nap. It's done very well
[48:22] for itself, but the ice cubes do a
[48:24] little too much damage for it to
[48:26] overcome. And the last memory that Hypno
[48:28] is going to have is being tossed in the
[48:30] air by the purple mommy, and that is
[48:32] going to crown a champion.
[48:36] [music]
[48:37] Did I know that Jinx was this good? I
[48:39] did in competitive, but in terms of a
[48:41] solo run, it's not really that great.
[48:43] And after everything played out, I'm
[48:45] pretty glad that Jinx got a spotlight to
[48:47] show how strong the combination of two
[48:49] great offensive tops and a high accuracy
[48:52] sleep move could actually be. So,
[48:54] congratulations to Jinx. And before we
[48:56] go, I would like to talk about a few
[48:58] statistics of the tournament because
[49:00] data is always cool to see. Breaking
[49:02] down the top 16 by top, Psychic leads
[49:05] the charge with six entrance, but Poison
[49:07] being second at five might surprise some
[49:09] people. It kind of surprised me.
[49:10] Although you could argue that any
[49:12] Pokemon that had the poison type
[49:14] probably didn't want it. But outside of
[49:15] that, the distribution is pretty normal.
[49:17] Three normal, two grass, two ghost, two
[49:19] water. The rest are at one each. Missing
[49:21] from the top 16 here are dragon, rock,
[49:24] ground, and fire. They didn't really
[49:26] even come close except for N King at the
[49:28] 18th spot in the round robin stage. And
[49:30] finally, the statistic that stands out
[49:32] the most to me is sleep users. We talked
[49:35] about that a lot. 10 of the top 16 use
[49:37] sleep. and I caught it before the
[49:39] tournament even began. Sleep is grossly
[49:41] overpowered. So, when you get a Pokemon
[49:43] that actually has some semblance of
[49:45] stats to back it up, they always say the
[49:47] cream will rise to the top, and it did
[49:49] here. If you cannot one-shot a sleep
[49:51] user, they always have a chance to win.
[49:53] Finally, let's go back and talk about
[49:55] the explosion users because I find it
[49:57] interesting and a bit predictable that
[50:00] the better Pokémon with better stats
[50:02] have the better explosion chance.
[50:04] Remember, desperation explosions are a
[50:06] thing. If the computer sees no way out,
[50:08] it'll just go for that hail mary win.
[50:10] And the field has a chance to predict
[50:12] explosions. But Gengar actually has the
[50:15] highest success rate in terms of
[50:17] percentage at 86%. Mew has many, many
[50:20] more wins with explosion overall, but
[50:22] it's a couple of notches lower at 84%
[50:24] and it just sharply drops off from
[50:26] there. Haunter, another top 16 Pokémon,
[50:29] was successful 68% of its explosions.
[50:32] And just going down the list, we can
[50:34] see, you know, how bad it gets when you
[50:35] get down to the pathetic Pokémon like
[50:37] Onyx or Geodude with a 23 and 22% chance
[50:40] of success. Now, Ditto is here. Fun
[50:43] fact, Ditto copied an attempt to use
[50:45] explosion seven times in the tournament,
[50:48] and it never one single time got a
[50:50] victory with it. And I think we can
[50:51] leave it at that. I had a lot of fun
[50:53] with this one, but honestly, I think it
[50:54] was a little bit too much work for me.
[50:56] If you made it this far, I really
[50:58] honestly and truly appreciate you taking
[51:00] the time out of your day to watch my
[51:01] little video. One thing I learned from
[51:03] doing this going into future tournaments
[51:06] is that they might be better served with
[51:08] only final stage Pokémon because I felt
[51:10] like about 80 Pokémon seemed like they
[51:12] were feeler. So, let me know what you
[51:14] think. And I think that's about it for
[51:16] me. Give me ideas where we're going to
[51:17] go next. Comment down below. I
[51:19] appreciate that a lot. And a special
[51:20] shout out to my channel members and
[51:22] patrons. The support really does mean a
[51:23] lot. And just as far as the channel
[51:25] goes, I just hope we can keep that reset
[51:27] momentum going. And I'll see you on the
[51:29] next one. Bye.
