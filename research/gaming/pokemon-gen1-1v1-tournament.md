---
status: active
created: 2026-10-12
discussion: folded-in
---
# Pokémon Gen 1 — 170,000 Sampled Battles a Fixed Policy Could Solve Exactly
> Gym Leader Matt ranks all 151 Gen 1 Pokémon with a round robin of ~170k simulated 1v1 battles on an engine built from the **pokered disassembly**. The engine grounding is sound. But his battle AI is a **fixed priority policy**, so by the [D&D tournament page's](./dnd-monster-tournament-markov.md) own argument every matchup is an absorbing Markov chain with an *exact* win probability, and 15 samples per pair is noise where there could be a number. Two flaws sit on top: the AI was **tuned until the ranking looked healthy**, and the best-of-one bracket, the *noisiest* measurement, is presented as the one that "truly" crowns a winner. A free oracle he didn't use: **evolution dominance**, checked here from the disassembly.

**Source:** [Gym Leader Matt — "I Simulated 170,000 Battles to Rank All Generation 1 Pokémon"](../../raw/videos/2026-10-09%20gym-leader-matt-170k-battles-gen1.md) — <https://www.youtube.com/watch?v=PvMYjcQg75M> (51:32, 2026-10-09; auto-caption transcript)
**Data:** [pret/pokered](https://github.com/pret/pokered) `data/pokemon/base_stats/*.asm` + `evos_moves.asm` (fetched 2026-10-12; Red/Blue only, so Yellow-only learnsets are not covered)

**Project:** [Pokémon G1 Battle Solver](../../projects/pokemon-g1-battle-solver/README.md) — this page's critique turned into code (started 2026-10-12; `tools/dominance.py` reproduces the 48/56 counts below).

**Links:** [D&D Monster Tournament — Exact Markov Chains](./dnd-monster-tournament-markov.md) (**the method this video should have used** — fixed policy ⇒ Markov chain), [Risk — The Attrition Constant](./risk-attrition-odds.md) (the exact-chain treatment carried through), [The Dominance-Frontier Lens](../dominance-frontier-lens.md) (the evolution-dominance prune), [Wordle — Solved](./wordle-solved.md) and [Hangman — Solving Both Sides](./hangman-solving-both-sides.md) (Ballpark Figures: exact solving and the "trust in the list" parameter), [Catan — 47k Empirical](./catan-47k-empirical.md) (another large-sample ranking), [Transpilation as Grounding](../transpilation-as-grounding.md) (disassembly as oracle)

---

## What he built

- **Engine:** G1R Deluxe, built on the pokered disassembly and compared against Pokémon Showdown. Gen 1 quirks are real: the 1/256 miss on every move, sleep lasting 1–7 turns with no action on the wake-up turn, Explosion silently halving the target's defense, and the badge-boost glitch.
- **Field:** all 151, each pair 15 games with sides swapped. 11,325 pairs × 15 = **169,875** battles. Battles reaching 50 turns are draws.
- **Normalization:** level set by growth rate (to approximate a solo run): slow 50, medium-fast 53, medium-slow 54, fast 58. Equal stat experience, perfect DVs, all badges. Banned: Toxic, Mimic, the Double Team TM (level-up Double Team stays). Allowed: sleep, and Explosion (which his solo runs ban).
- **AI, "the brain":** one hand-built priority checklist on both sides: secure a KO → handle an incoming Explosion → exploit sleep/speed → heal/set up/substitute → **highest-damage move** (the most common decision, ~25%).
- **Movesets:** picked by hand at first, then cross-checked against Smogon, and finally chosen by simulating every available move and keeping whichever helped most against this field.
- **Rating:** a "modified" Bradley-Terry (Elo-style) rating, then a best-of-one, single-elimination bracket of the top 16.

## What's sound

Grounding the engine in the disassembly, swapping sides, a complete round robin, picking movesets by their result *against the field*, and splitting win rates by top-10 and bottom-50 so a reader can see how much a rank depends on beating weak opponents. **Sleep dominance (10 of the top 16) is real, not an artifact of the model.** Competitive Gen 1 play caps sleep with a sleep clause because it is that strong, and a 1v1 format with no switching only makes it stronger. This is *not* the [HeroClix Hercules case](./dnd-monster-tournament-markov.md#-the-hercules-warning--and-a-confound-this-project-must-design-around).

## The flaws

**1. The AI was tuned until the results looked right.** Mew was #1 until the AI learned to play around Explosion. Earlier builds had seven Explosion users in the top 10, and the tuning stopped when "the metagame feels much healthier." Each fix may be justified individually. But stopping when the ranking matches your expectations biases the ranking toward those expectations. The ranking is really of each Pokémon *with its tuned moveset and the AI as of the final build*.

**2. The noisiest measurement is called the most decisive.** "The only way to truly see who's the best" is presented as a best-of-one bracket. Each Pokémon already has ~2,250 round-robin games. The bracket was decided by an AI misplay (Gengar skipping Hypnosis against Venomoth) and a critical hit plus a sleep turn (Jynx over Mewtwo). Jynx winning is one random draw. The honest version: simulate the bracket 10⁴ times and report each Pokémon's chance of winning it.

**3. The anecdotes are mostly noise.** "Lost to Pidgey" and "lost to Rattata" are 1-in-15 events in a game with a 1/256 miss on every move and frequent crits. Fifteen games is plenty for the *aggregate* rating but not for any single pairing, where the win rate is uncertain by about ±13 percentage points.

**Smaller issues:**
- **The Elo layer adds nothing to the ordering.** In a complete, balanced round robin the Bradley-Terry ranking is the ranking by total wins. It only adds a scale for the gaps, and the "modified" draw handling isn't explained.
- **The ranking depends on who's in the field.** Each rating is an average against all 151, about 80 of which he himself calls filler, so consistently beating weak Pokémon is rewarded. This parallels hangman's lesson that the word list is the hidden assumption.
- **The level rule is an extra handicap.** It is neither a competitive ranking (equal levels) nor a solo run. The fast growers Clefable (#6) and Chansey (#11) start 8 levels above the slow growers.
- **Explosion success rates are biased by when the AI uses it.** The AI fires a "desperation explosion" when it is losing anyway, so the success rate mixes Explosion's strength with the position it was used in. The right measure is how much each Explosion changes the chance of winning.

## The method he skipped: a fixed policy can be solved exactly

The [D&D page's](./dnd-monster-tournament-markov.md#the-core-insight-the-flaw-is-the-enabling-assumption) central claim: *a fixed policy collapses a Markov decision process into a plain Markov chain.* The brain is exactly that: a deterministic priority list on both sides. Only the dice (damage rolls, accuracy, crits, sleep duration, the 1/256 miss) are random. So each of the 11,325 matchups has an exact win/draw/loss probability, solvable as an absorbing chain over (HP × HP × status × sleep counters × stat stages × PP × reflect/substitute). That state space is larger than D&D's, but it is solved one matchup at a time and the per-matchup chains are small.

What exact solving buys:
- **Every pairing gets a number instead of 15 coin flips.** No more "lost to Pidgey" noise.
- **Explosion gets measured properly**, by how much it changes the chance of winning, instead of a success rate biased by when the AI chose to use it.
- **Bracket odds come out exactly** without simulating anything.
- **A free check on the engine:** an exact chain and a Monte Carlo run of the same policy must agree, so the engine and the solver verify each other. This is the [Risk](./risk-attrition-odds.md) pattern of independent methods confirming the same answer.

The remaining question is the one the D&D page also raises: how much does the *fixed* policy cost compared with optimal play? Solving a two-player game in which both sides choose is the harder next step.

## Evolution dominance: a check he didn't run (computed from pokered)

Chris's hunch: evolution should create *strict dominance*. Within a line, the growth rate (and so the level in this tournament) is shared, so an evolved form with ≥ every stat, the same types and a superset of moves cannot do worse **under optimal play**. Checked mechanically over all 72 evolution edges in the disassembly:

- **48 / 72 are strictly clean:** stats ≥ in all five, same types, nothing lost from the level-up or TM/HM learnset.
- **+8 more if moves learned before evolving carry over** (they do in the games): Clefairy, Exeggcute (loses Sleep Powder, Stun Spore and others by level-up), Gloom, Growlithe, Jigglypuff, **Pikachu → Raichu** (loses Agility/Quick Attack by level-up), Vulpix, Weepinbell. That makes **56 / 72 dominated**.
- **16 are not dominated**, either because the evolution **changes type** (Charizard, Dragonite, Butterfree, Gyarados, Nidoqueen/king, Dewgong, Cloyster, Starmie, the three Eeveelutions, Poliwrath) or because it **loses a stat**: Caterpie→Metapod and Weedle→Kakuna (atk, spd), Metapod→Butterfree (def 55→50), Kakuna→Beedrill (def 50→40), and **Poliwhirl→Poliwrath (spd 90→70, gains Fighting)**.

**Three uses:**
1. **A check on the AI and the movesets.** Among the 56 dominated pairs, a pre-evolution ranking above its evolution beyond what noise allows means the *AI or the moveset* is wrong, not the Pokémon. That is checking against something more basic than the simulation, which is what verification should mean. Nothing narrated in the video violates it (e.g. Haunter #9 < Gengar #3, Kadabra < Alakazam #7). The full ranking table wasn't shown, so it can't be checked yet.
2. **The exceptions are the interesting cases.** Poliwrath is the textbook one. It is slower and picks up a weakness (Matt: "he wishes that he didn't have" the Fighting type), and still outranks Poliwhirl. Raw stat gains outweighed the costs here, which is a genuine finding rather than something that follows from dominance.
3. **His own "next time, only final stages" idea is a dominance prune.** Cutting dominated Pokémon from the field is the [dominance-frontier](../dominance-frontier-lens.md) move. It also addresses the field-composition problem, since the filler is mostly dominated forms.

*Caveat:* dominance holds under **optimal** play. Under a heuristic AI, an extra move can in principle *hurt* (the brain might pick a worse option it now has access to). So an inversion is a sign that the AI is miscalibrated, not proof of it.

## The ground truth he has and didn't use

The tournament exists as a faster stand-in for his multi-year solo-run rankings, and about half of those are done. The obvious validation is to correlate the 1v1 ratings with his ~75 completed solo-run results. He doesn't. He also lists the large disagreements himself (Abra, Jynx, Tangela, Pikachu, Rhydon), which suggests the two formats measure different things. Without that correlation, "speed up the process" isn't backed by evidence.

## Chris's read

He doesn't know Pokémon well enough to judge the domain claims, so the critique stays on method, which is where it holds up. He suspects the video is partly **performative**: storyline-driven commentary over a bracket that is mostly chance. That fits flaw 2: the entertainment format is presented as the scientific one. He also flagged the evolution-dominance structure before any data was pulled, and the disassembly confirmed it for 56 of 72 edges.

## Open Questions

- **Does Matt publish the full ranking table** (video description / Patreon / a sheet)? If so, the dominance-inversion check runs today.
- **What does the exact-chain state space actually come to** with Gen 1's sleep counter, stat stages, PP, Substitute/Reflect and the badge-boost glitch? Is it tractable per matchup, as estimated above?
- **What does the fixed policy cost?** Solving a few matchups as true two-player simultaneous-move games would give the policy's cost relative to optimal play, the measurement the [D&D page](./dnd-monster-tournament-markov.md) plans as its Deliverable 2.
- **Yellow learnsets:** pokered is Red/Blue. Matt uses Red/Blue/Yellow movepools (for example level-up Double Team). The dominance check needs `pret/pokeyellow` merged in before any edge flagged only for lost moves counts as settled.

## Tags

[games](../../tags/games.md) · [game-theory](../../tags/game-theory.md) · [simulation](../../tags/simulation.md) · [methodology](../../tags/methodology.md) · [game-ai](../../tags/game-ai.md)
