---
status: active
created: 2026-08-24
discussion: folded-in
---
# Hangman: Solving Both Sides — and the One Parameter That Separates Two Methods
> Ballpark Figures solves hangman's guessing side *exactly* (backward induction, certified bounds) and then does what a Wordle solver structurally cannot: solves the **chooser**. Set against 3Blue1Brown's entropy-based Wordle bot, the two methods turn out to differ in exactly one parameter — **how much they trust the word list** — and the most robust artifact the exact solver produced is the one built for humans to read.

**Sources:**
- [Ballpark Figures — "I Tried to Solve Hangman"](https://www.youtube.com/watch?v=ApdLgfgfh5o) (38:48, 2026-08-23). Author's own script: [`raw/videos/2026-08-23 hangman-ballpark-figures-SCRIPT.md`](../../raw/videos/2026-08-23%20hangman-ballpark-figures-SCRIPT.md) (verbatim from `animations/Script.md` in [github.com/Ballpark-Figures/hangman](https://github.com/Ballpark-Figures/hangman)) · companion blog: [`raw/articles/…substack.txt`](../../raw/articles/2026-08-23%20hangman-ballpark-figures-substack.txt) (re-fetch from <https://ballparkfigures.substack.com/p/hangman>) · repo config: [`…repo-CLAUDE.md`](../../raw/videos/2026-08-23%20hangman-ballpark-figures-repo-CLAUDE.md)
- [3Blue1Brown — "Solving Wordle using information theory"](https://www.youtube.com/watch?v=v68zYyaEmEA) (30:38, 2022-02-06). Author's own transcript: [`raw/videos/2022-02-06 wordle-3blue1brown-transcript.txt`](../../raw/videos/2022-02-06%20wordle-3blue1brown-transcript.txt) (re-fetch from <https://raw.githubusercontent.com/3b1b/captions/main/2022/wordle/english/transcript.txt>)

> ⚠ **Sourcing note.** The hangman script is a *pre-production draft* — it carries `FILL IN`, `TALK HERE`, and `CONFIRM THIS` markers. Verbatim prose is trustworthy; blanks are not. Quantities below come from the blog post and the repo's committed data notes, not from script placeholders.

**Links:** [Battleship — 30 Billion Boards](./battleship-board-analysis.md) (**the parent specimen** — same creator; this page *inverts* half its conclusion), [Yahtzee — 259 Trillion → 405 Million](./yahtzee-solved.md) (same creator, the state-space-collapse sibling), [Symmetry Breaking](../philosophy/dynamics/symmetry-breaking.md), [The Dominance-Frontier Lens](../dominance-frontier-lens.md), [Monopoly — Frontier Trade Theory](./monopoly/frontier-trade-theory.md) (the frontier form of the same collapse-the-search-space thread), [Catan — 47k Empirical](./catan-47k-empirical.md), [The Hollow Opponent](./hollow-opponent-perceived-depth.md)

---

## The structural fact that generates everything else

Checked mechanically across both full texts:

- The Wordle transcript contains **zero** occurrences of *nash*, *equilibrium*, *adversary* — or even **the word *opponent***.
- The hangman script and blog contain **zero** occurrences of *entropy* or *Shannon*.

Neither author is avoiding the other's vocabulary. They are describing different objects. **Wordle as presented has no second player**, so the entire problem is a decision problem against a fixed prior — best-response, no minimax. Hangman has someone sitting across the table, so half the video is a game-theoretic search with no Wordle counterpart.

This is the [best-response vs. minimax split](./battleship-board-analysis.md) reappearing with **language** as the substrate instead of geometry — and 3b1b's Wordle video is a pure instance of the *guessing* half, with no placement half available to it.

### But Wordle does have a chooser

3b1b says so in passing: the ~2,315 answers are "a human curated list, I think specifically by the game creator's girlfriend." That is a real mixed strategy over words, chosen by a person — optimized for *fun*, not for difficulty. Wordle isn't a puzzle by nature; it is a two-player game in which one side has been playing **cooperatively** and nobody modelled it.

Both authors reach that fork. Ballpark names it — via Jan Misali, that the hangman chooser "isn't really trying to win as much as they are trying to make the game interesting" — and then says *"I am going to completely ignore that fact for the rest of the video."* 3b1b never names it. **Same fork, opposite branch**, and that single choice generates every other difference below.

## Proxy objective vs. true objective

| | 3b1b / Wordle | Ballpark / Hangman |
|---|---|---|
| Optimizes | expected **information** (entropy) — a proxy | expected **misses** / win probability — the objective |
| Method | greedy on entropy, 1-ply (2-ply at best) | exact backward induction over the decision tree |
| Endgame | needs a patch — entropy will spend the last guess on a word that cannot win | falls out as the recursion's base case |
| Result | 4.124 → 3.6 (with prior) → 3.43 (with answer list + 2-ply) | optimal or certified-bounded for every word length |

Ballpark identifies *why* the proxy is nearly free in his game: there are many ways for a letter to be in a word but only one way for it not to be, so the hit-maximizing guess is usually already the information-maximizing guess. **That coincidence is why greedy is near-optimal in hangman and merely decent in Wordle.** Wordle's 3⁵-way feedback partition pulls the two apart, which is exactly where 3b1b has to build machinery — a fitted regression `f(bits) → expected remaining guesses` — to decide when to stop learning and go for the win.

He also settles a standing claim: Jan Misali conjectured greedy was optimal for hangman. Verdict — **"wrong in theory, but mostly correct in practice."** The exact solve's headline gain over greedy is **~6% at length 11 (0.500 → 0.469 misses, exact)**.

## Why hangman is solvable and Wordle isn't — the size illusion

Hangman *looks* bigger (34,483 words, lengths 1–20+) and Wordle *looks* tiny (five letters). Tractability runs the other way, and the reason is **branching, not size**:

- **Hangman** branches ≤26 ways per node and positions collapse hard — the same remaining-word set reached by a different guess order is one position. Memoize on the word set, prune letters that cannot appear, seed with greedy for early cutoffs, and most lengths solve exactly.
- **Wordle** branches 243 ways per node across ~13,000 candidate guesses, over a 6-guess horizon. 3b1b's ceiling is two plies.

This is the vault's recurring **collapse-the-search-space** thread ([Yahtzee](./yahtzee-solved.md) 259T → 405M; [Battleship](./battleship-board-analysis.md) 30,093,975,536 enumerated; [Monopoly's frontier](./monopoly/frontier-trade-theory.md)) — and hangman contributes the sharpest version of its lesson: **what determines tractability is the branching factor and the rate at which distinct paths reconverge, not the nominal size of the space.** Ballpark expected the easy video precisely because he measured size (six orders of magnitude below Battleship) rather than shape.

## The chooser's counter-move: collapse the space as a *weapon*

Ballpark hill-climbs a word distribution — multipliers on single-letter blank patterns (`BALLPARK` = `B_______` × `_A___A__` × `__LL____` × …) — re-solving the guesser each iteration.

- **5 letters:** end in `-y` or `-s` ~**73%** of the time
- **6 letters:** `-ed`/`-er` ~**97%**; add `-es`/`-ing` and two words survive
- **7 letters:** strip `-ING` and **nothing is left**. Same at 8 and 9. *"ING is king."*
- It further avoids words with a *spare* I, N, or G, so the forced suffix leaks no extra information
- At length 16 the most-used word is `UNDERREPRESENTED` — "nice to know that my computer has a sense of irony"

The mechanism is an inversion worth naming. Longer words are *easier*; so the chooser's counter is to **collapse a 7-letter game into a 4-letter game** by forcing the tail — trading a large word list for a smaller, harder-conditioned one. Everywhere else in this cluster, state-space reduction is the *solver's* tool. Here it is the **adversary's weapon**: the same operation, pointed the other way.

## The flatness reversal — and what bounds an equilibrium

[Battleship's](./battleship-board-analysis.md) minimax optimum is ≈ **maximum entropy**: be uniform or be exploited. Hangman's is the **opposite** — a hard concentration on `-ING`. Why?

You would expect equilibrium to make the guesser *indifferent* across all 26 letters. It doesn't: only ~15–16 first letters end up in a virtual tie at length 7, and they are **just the already-good letters**. Ballpark's explanation is the payoff of the whole video: "Z just can't do the things that S, or N, or even P can do." Inflating Z-words restricts the lexicon so much that the rest of the word becomes *easier* to guess.

> **The indifference set of an equilibrium is bounded by the structure of the substrate.** Battleship's grid is homogeneous enough that indifference reaches everywhere — every ship is interchangeable across a uniform surface. English is *structurally lumpy*: letters have non-substitutable roles, so no re-weighting can equalise them.

This is the natural extension of the [symmetry-breaking](../philosophy/dynamics/symmetry-breaking.md) reading. Battleship showed **structure emerging from apparent nothing** — a uniform joint distribution inducing a sharply peaked marginal, and non-arbitrary optimal play falling out of it. Hangman is the complementary case: a substrate that is *already* lumpy, where the lumpiness is load-bearing and **cannot be optimized away**. Together they bracket the claim: structure creates norms, and the *amount* of structure sets how far strategic freedom can reach.

*(Source-internal inconsistency: the blog says "only 16 letters" in one paragraph and "top 15" in another. Read as ~15–16.)*

## The one parameter: confidence in the lexicon

The sharpest way to state the difference between the two methods is that they disagree about **exactly one thing**.

- Ballpark's optimal tree is a policy *conditioned on* an exact 34,483-word list and a uniform prior. Feed it an off-list word and it can reach a node with **zero consistent words** — the policy isn't suboptimal there, it's **undefined**. Model error is catastrophic, not graceful.
- 3b1b's bot spreads nonzero probability over 13,000 words and **deliberately refuses** the curated answer list: "it would be better to write a program that's a little more resilient and would play wordle against anyone, not just what happens to be the official website."

So the entropy bot guessing an impossible word — the thing that looks like a flaw — is **correct under uncertainty about the dictionary, and wrong only if you trust it.** It isn't a defect; it's the premium on the insurance. And in a game where, in Ballpark's own words, "people can't even agree on what a word is," dictionary mismatch is not a corner case — it is the normal condition of a real game between two humans.

Both authors concede the lexicon is the soft underbelly. Ballpark: "a hangman strategy is only as good as its word list" (wordfreq → drop non-letters → hunspell → hand/LLM filtering → 34,483; "phylogeny" makes the cut, "cookout" doesn't). 3b1b builds his prior from Google Books n-grams pushed through a sigmoid whose parameters he set by "licking my finger and sticking it into the wind."

### The distribution problem, and the escape only hangman offers

Both hit "what distribution does a human actually draw from?" and answer in mirror image. 3b1b **models** it (frequency + sigmoid cutoff). Ballpark **refuses** to, keeping uniform because any weighting just helps the guesser and the truth is "somewhere in between."

The reason he *can* refuse is structural and elegant: **in hangman the word distribution is not a modelling assumption, it is the opponent's strategy.** You don't estimate it — you solve for it. That option does not exist in Wordle.

## The robustness gradient — and why the human-readable artifact wins

Ballpark's video contains a gradient nobody states outright:

| Artifact | Depends on | Robustness to a wrong word list |
|---|---|---|
| Optimal decision tree | the exact 34,483-word list + uniform prior | **brittle** — can become undefined |
| Greedy strategy | roughly-right letter frequencies | moderate |
| **The alphabet tier list** | a letter *ordering* only | **most robust** |

And he tested it: re-weighting by frequency shuffles letters *within* tiers but barely across them; British English moves A past I and drops Z to the bottom (it loses `-IZE`).

> **The compression built for human legibility is also the model-error-hardened version of the policy.** The tier list is not a lossy concession to video format — it is the artifact that survives contact with a real opponent's vocabulary.

The tier list is itself *derived*, not hand-authored: rank letters by a pairwise "is α guessed before β across all words" relation, greedily grow a set minimizing misordered pairs against its complement, and cut a tier wherever one letter wins by a lot. Feed it any solved tree and it regenerates — he says he will reuse it for future word games. **Architecture as the product**: not an answer, a compression pipeline.

He is also honest that it **fails** against the optimized chooser — patterns become length-specific with "nothing worth explaining." The human-portable artifact is valid only against the *random* chooser. A stated negative result.

## Rigor: certified bounds vs. point estimates

3b1b reports simulation point estimates plus a back-of-envelope impossibility argument (start ~11 bits; best two-guess information ~10 bits; ~1 bit remains; so you cannot average 3).

Ballpark reports **certified intervals** via an α-cap sandwich: cap misses at α and solve → a *lower* bound; play the capped-optimal policy then fall back to greedy → an *upper* bound; and if the capped optimum never reaches α, the bound is tight and optimality is **proved**. Lengths 3–6 stayed open — and those points are **plotted in red**, so the chart itself distinguishes *solved* from *bounded*.

**The visualization carries the uncertainty.** That is a transferable standard, not a hangman detail.

## Rules design falls out of solving both sides

Because both sides are solved, he can compute what a Wordle video cannot: **what the rules should be.** Under near-optimal play the fair miss allowance runs **1–8 depending on word length — every number except 6**, which is the one everybody plays. The standard game is miscalibrated, and the correction is length-dependent.

Three thresholds worth keeping straight:
- **length ≥ 9** — always winnable inside 6 misses
- **length ≥ 12** — `I` becomes the optimal opener (top tier partitions the lengths: **A owns 1–4, E owns 5–11, I owns 12–20**)
- **length ≥ 17** — **zero misses guaranteed**: every 17-letter word in the list contains an I, each in a *distinct position*, so the position of the I alone identifies the word

## Open Questions

- **Does the flatness reversal generalize?** "Substrate homogeneity bounds the indifference set" is synthesis across the two videos, not a claim either author makes. What is the third test case — a substrate of intermediate lumpiness?
- **Adversarial Wordle.** Nobody appears to have applied Ballpark's `freq_search` to Wordle's answer list. Would it find a suffix collapse, or does Wordle's positional feedback defeat the mechanism? *(Absurdle is adjacent but a different object — adversarial *evaluation* with no commitment, vs. an adversarial *prior*. Verify what exists before treating this as open.)*
- **Is "collapse the space as a weapon" already in the vault under another name?** It is the mirror of the reduction thread running through Yahtzee, Battleship, and Monopoly's frontier.
- **The direct sequel is coming.** Ballpark's blog closes by saying his **next video is Wordle** — the same author applying solve-the-tree + adversarial-chooser to the exact game 3b1b treated with entropy. This page should have a slot for it.

## Tags

[games](../../tags/games.md) · [game-theory](../../tags/game-theory.md) · [game-design](../../tags/game-design.md) · [mathematics](../../tags/mathematics.md) · [strategy](../../tags/strategy.md)
