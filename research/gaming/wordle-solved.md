---
status: active
created: 2026-10-12
discussion: folded-in
---
# Wordle — Solved for the List, Compressed for the Human
> Ballpark Figures' fourth specimen, the [hangman](./hangman-solving-both-sides.md) sequel. The exact solve is a 2022 result over a **fixed 2,315-word answer list**, so the perfect tree proves the game is beatable, not how a person should play it. The value is in the **human-sized compressions** cut from it: a two-word policy (SLANT → PRICE), a gray-count rule of thumb, and the first memorizable strategy that **guarantees a win in six** (LEDGE PAWNS ROCKY THUMB). Along the way, five words with 25 distinct letters turn out to be worse than four words that keep common repeats.

**Source:** [Ballpark Figures — "I Solved Wordle*"](../../raw/videos/2026-10-11%20ballpark-figures-i-solved-wordle.md) — <https://www.youtube.com/watch?v=h-Rusd72W7U> (44:04, 2026-10-11; auto-caption transcript)

> ⚠ **Sourcing note.** The words come from auto-captions, which mangle them. SALET is captioned "salad"/"salot" and is identified by its description ("a type of medieval helmet") and its 3.42 average. Where a caption is ambiguous, the caption text is shown rather than a guessed spelling.

**Links:** [Hangman — Solving Both Sides](./hangman-solving-both-sides.md) (**the parent** — same tier-list pipeline, same creator; this page corrects two of its claims), [Yahtzee — 259 Trillion → 405 Million](./yahtzee-solved.md), [Battleship — 30 Billion Boards](./battleship-board-analysis.md), [The Hollow Opponent](./hollow-opponent-perceived-depth.md)

---

## What "solved" means here — and Chris's framing

The exact method is dynamic programming over the color groups (first done by mathematicians in early 2022). It is defined over the **curated answer list**, not over English. Best opener **SALET, 3.42 guesses on average**, always winning within five (PARSE is marginally better after a late-2022 list change; list edits move results in the 2nd–3rd decimal).

Chris's read, recorded as the discussion that matters:

- **The perfect tree isn't something a human can use.** Every move depends on the exact coloring before it: SALET alone splits into 148 groups, and the full tree is over 2,000 cases to memorize. It is valuable as **proof that the game can be solved, plus a yardstick for how good play can get**, not as a strategy.
- **Humans actually win by guessing well**: they keep picking plausible words until one lands on the answer. The video measures exactly that player: *random compatible answers* (perfect at matching the clues, no strategy) averages **4.08 guesses and wins >98%**.
- **That calibrates the scoreboard.** Perfect play averages 3.42 and lands almost always on **3 or 4**. So a **2 is mostly luck** even for a computer, and a human who **consistently gets 4** is playing about as well as perfect clue-matching. Strategy only buys the gap from ~4.1 down to 3.4.

## The ladder of human-sized strategies

| Strategy | Avg guesses | What a human must hold in memory |
|---|---|---|
| Uniform random from 2,315 | 2,315 (0.26% win) | nothing |
| Random, but take the last remaining word | 6.9 | nothing |
| Random **compatible** answer | 4.08 (>98%) | perfect clue-matching only |
| SLATE, then compatible | 3.82 (~99%) | 1 word |
| 2-word opener (PARSE CLINT / CRANE SPILT), then compatible | ~3.7 | 2 words, fixed |
| **SLANT; if mostly gray → PRICE; then compatible** | **3.67** | 2 words + one branch |
| Optimal tree | 3.42 (always ≤5) | ~2,000 cases |

His two building blocks are **simplification** (one rule covering many situations) and **randomness**. Randomness is not there to stay unpredictable, since the New York Times editor isn't trying to trick you. It makes any partial strategy complete and easy to analyze. SLANT/PRICE gets within a quarter of a guess of optimal with two words to learn, and it is his own daily strategy.

**The gray-count rule.** He groups the 243 possible colorings into **19 classes** by how many greens, yellows and grays they show, and reads the optimal tree's habits off those classes. 0 grays → always guess a compatible word. 1 gray → compatible ~85% of the time. 2 → a toss-up. 3–4 → five new letters to gather information. All grays → compatible, since every new word now carries only fresh letters anyway. From the third guess on, go for the answer. This is the [hangman tier list](./hangman-solving-both-sides.md#the-robustness-gradient--and-why-the-human-readable-artifact-wins) move again: a compression made for people, cut out of the exact tree.

## 25 distinct letters is the wrong goal

The popular claim is that five words covering 25 distinct letters guarantee a win on guess six. It is wrong twice:

- **No five fixed words can guarantee it.** The best 25-letter set still leaves **72 answers** (~3%) that can't be told apart. PUREE, PURER, RUPEE and UPPER all look identical.
- **Repeated common letters beat rare ones.** In the tier list, a second E is worth more than any J, K, Q, X or Z. The best five-word set uses doubled E, L, O and T and skips J/K/Q/X/Z entirely, leaving only **16 answers** unsolved.

The fix is to *stop at four* fixed words and leave the last two guesses free: **LEDGE PAWNS ROCKY THUMB** plus any compatible fifth guess **guarantees** the sixth is forced. It is the first human-memorizable guaranteed win he could find published. *Four words with 19 letters beat five with 25.* The guarantee was searched with the last two guesses allowed from a wider ~4,000-word list, so it doesn't depend on knowing exactly which words are answers. That is the same protection against a wrong word list that the hangman page credits to 3b1b's entropy bot.

**Objective choice shows up again.** A two-word opener gives the best *average*. Three- or four-word openers give the best *win probability*. "The best strategy" depends on which of the two you are scoring.

## Finding the most important guess by knocking one out

To find which guess carries the leverage, he plays optimally except for **one** random compatible guess and measures the cost at each position. Guesses 4 and 5 cost almost nothing (one word is usually left by then). The opener costs little (about 1,500 openers are within 0.1 guess of SALET). **The second guess costs the most.** A bad first guess can be repaired, and a bad second guess wastes a turn for good. It is also the hardest guess to play by hand, which is why a fixed second word (PRICE) is such a cheap fix.

## The vowel budget

ADIEU and AUDIO are **below the median opener**, which means guessing yesterday's answer beats them. Three things make an opener bad: low-tier letters, duplicates, and **too many vowels**. The last one only shows up when you look ahead. You need two or three guesses to gather information, so six vowels (counting Y) have to be spread across them. The pattern holds across word lengths (Hello Wordle): the best opener reaches **three vowels exactly when the average drops below 3 guesses** (length 7), four at length 9, and repeats vowels at length 10. Consonants carry the information, and vowels can be filled in later (B_F_T → BEFIT is easy, _SO_A_E is hard), which is the same reason some writing systems leave vowels out.

**Tier-list transfer, as hangman predicted.** He rebuilt the [hangman alphabet tier list](./hangman-solving-both-sides.md) for Wordle with the same pipeline. I drops (it mostly appears in long words), S drops (no S-plural answers), and L and H rise. The new element is that **a duplicate letter is ranked as its own tier entry**, and it is always low tier.

## Hard mode: word families become traps

Being forced to reuse your hints barely moves the average (SALET 3.42 → 3.51) but **destroys guarantees**. Only 22% of openers can still guarantee a win within five, about one in seven can't guarantee six, and TRACE, a top opener, can need 8 guesses. The nine **-IGHT** answers each need 9 guesses to guarantee a solve, and their near-neighbours need 10. The hardest hard-mode words aren't the ones with rare letters but the ones **too similar to too many others**: -IGHT, an O-N-D family, an A-T-C family, and many E-R families (spelled out letter by letter in the captions). The good hard-mode openers avoid overlapping those families.

This is the [hangman chooser's weapon](./hangman-solving-both-sides.md#the-choosers-counter-move-collapse-the-space-as-a-weapon) occurring naturally. In hangman the adversary *forces* a suffix to collapse the game. In hard-mode Wordle, English already contains the families, and the rule that takes away the five-new-letters escape is what turns them into traps.

## Variants as tests of the method

- **Octordle family:** more boards make the game *easier* per board, for the same reason longer words do in hangman and Hello Wordle: more information arrives with each guess. A two-word opener (CLAMP TRIBE) is best up to ~16 boards, and a single word (captioned "rotan" / PLANT) wins from ~18 boards up. A simple "guess on the board with the fewest options left" policy lands near his near-optimal multi-board solver.
- **Opener metrics are all myopic.** Most groups (TRACE), smallest expected remaining group (captioned "wrote", *"barely even a word"* — likely ROATE), smallest worst-case group (ARISE/RAISE…), fewest all-gray results (two four-vowel words, captioned "Ori"/"Yuri"): four heuristics, nine different "best" words, and none of them looks past the first move.
- Bonus Patreon video (free, not ingested): adversarial "hard words to guess" (the open question on the [hangman page](./hangman-solving-both-sides.md#open-questions)), nonsense-string lexicons, other languages, *Lingo*, Wordle Unlimited.

## Open Questions

- **Adversarial Wordle is partly answered.** He says the chooser-side analysis is in the Patreon bonus video. Does it find a suffix collapse like hangman's `-ING`, or are hard mode's natural families already that answer? *(Bonus video not ingested.)*
- **Does LEDGE PAWNS ROCKY THUMB survive the NYT list edits?** His other results moved only in the 2nd–3rd decimal, but a *guarantee* is binary. One added answer that collides could break it.
- **Hard mode as a constraint lens:** the rule forces you to keep playing on known hints and blocks exploration. Is there a general claim here, that removing the explore move turns harmless clusters into worst cases? Check against the [dominance-frontier lens](../dominance-frontier-lens.md) before treating it as new.

## Tags

[games](../../tags/games.md) · [game-theory](../../tags/game-theory.md) · [mathematics](../../tags/mathematics.md) · [strategy](../../tags/strategy.md)
