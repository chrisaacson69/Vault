---
status: active
created: 2026-06-18
published: true
layout: layouts/page.njk
title: "Battleship: 30 Billion Boards, and the Best-Response vs. Minimax Split"
---
# Battleship: 30 Billion Boards, and the Best-Response vs. Minimax Split
> A **closed-form specimen of [symmetry-breaking](../philosophy/dynamics/symmetry-breaking.md)**: Ballpark Figures enumerated all **30,093,975,536** legal Battleship placements and showed that *uniform* random placement on the *asymmetric* 10×10 substrate crystallizes a sharply non-uniform structure (center 21% vs corner 8%) — and that **non-arbitrary optimal play emerges from it**, all the way down into the one choice that looks purely free. **Guessing** is a best-response against that *fixed* structure (deep skill gradient: 63 → 45 turns, beats a human **86%**). **Placement** is a minimax against an *adversary*, and he *proves in extensive form* the optimum is ~uniform random — i.e. even the apparently-arbitrary layer is uniquely forced (be maximum-entropy or get exploited). The portable claim: **structure creates norms** — given a structure + a telos, optimal solutions emerge from what looked like complete randomness, and there is no escape into arbitrariness even where the structure seems to permit it.

**Links:** [Symmetry Breaking](../philosophy/dynamics/symmetry-breaking.md) (the mechanism this is a closed-form specimen of), [The Four Trunks](../philosophy/the-four-trunks.md), [The Constitutive/Elective Distinction](../philosophy/morality/constitutive-elective.md), [The Dominance-Frontier Lens](../dominance-frontier-lens.md), [Randomness as the Termination Mechanism (N≥3)](./n3-termination-and-randomization.md), [Capability Without Leverage](./capability-without-leverage.md), [NA1 — A Game-Design Crucible](./nobunaga-crucible.md) (the *epistemic-axis twin* + the *binding-constraint-determines-depth* thesis this sharpens), [Catan — 47k Empirical](./catan-47k-empirical.md) (placement-equilibrium flatness rhymes with opening-barely-above-random)

> A **specimen page** (dated, source-anchored). Source: [Ballpark Figures — "I Analyzed All 30,093,975,536 Battleship Boards So You Don't Have To"](https://www.youtube.com/watch?v=ZBdajiTz48k) (18:51, 2026-06-13). Transcript in `raw/battleship-ZBdajiTz48k.en.vtt`. Its **portable home is [symmetry-breaking](../philosophy/dynamics/symmetry-breaking.md)** (structure→norms); the *best-response-vs-minimax* gradient below is the game-theoretic mechanism, and the constitutive/elective reading is the philosophical payoff.

## The combinatorial hook

Boards are drawn **uniformly** at random — every legal placement equally likely. Yet the per-square occupancy heat map is wildly **non-uniform**: a center square is ~**21%** likely to hold a ship, a corner only ~**8%**.

The cause is pure counting. A length-*k* ship has more ways to pass *through* an interior square than a corner one (the carrier: 10 placements through the center vs. 2 in a corner). So a uniform distribution over the **joint** (whole boards) induces a sharply non-uniform distribution over the **marginal** (single squares). That gap — uniform joint, peaked marginal — *is* the entire strategy. It's worth holding onto as a standalone trap: "everything's equally likely" almost never implies "every cell is equally likely."

## Half 1 — Guessing: best-response against a fixed prior (steep gradient)

You are deciding against a distribution you don't control and that doesn't fight back. So you exploit it:

- **Greedy:** always guess the highest-probability remaining square → start dead center, spread guesses away from edges and from prior misses along the four cardinal directions (diagonals are free — ships don't go diagonal).
- **Post-hit targeting:** extend in the direction with the most open space; **hit-then-miss → don't guess across from the miss** (the perpendicular axis is now far more live).
- **Result:** hunt-target baseline ≈ **63** turns; greedy ≈ **45**; greedy beats a typical human **86%** of the time (6 of 7 games).

This is a decision problem, not a game: the prior is fixed, so there's enormous room to be smart. The heat map *is* the [dominance ordering](../dominance-frontier-lens.md) over guesses.

## Half 2 — Placement: minimax against an adversary (flat gradient)

Now flip sides. You're choosing a placement *distribution* against an opponent who will best-respond to whatever you do. The author hunts for the "holy grail" — a placement so good that even an opponent who **knows** it can't sink you faster. That's a minimax / Nash strategy.

The punchline: **optimal placement is barely better than uniform random.** The best he found nudges corner-placement to ~2× the random rate, slows the opponent ~**½ turn/game**, and wins **51.7%**. His own closing line: *"doing tons of work to build a fancy algorithm only to find out that randomness works almost as well."*

Why flat? The minimax equilibrium against an adaptive opponent is *near-maximal-entropy* — any structure you add is structure the opponent can exploit, so the un-exploitable strategy is the one that looks like noise. **Max-entropy being near-optimal is the flatness.**

## The principle this crystallizes

> **A sub-problem's skill gradient tracks the exploitability of the opponent model.**
> - Best-response **against a fixed distribution** → exploitable → deep skill gradient (guessing).
> - Minimax **against an adaptive adversary** → equilibrium is high-entropy → flat skill gradient (placement).

This *sharpens* [binding-constraint-determines-depth](./nobunaga-crucible.md): the binding constraint on Battleship skill isn't a resource — it's **which half you're in**. All the depth lives in the best-response half; the minimax half is a near-solved coin flip. Same game, two sub-problems, opposite verdict. It also explains the [Catan 47k](./catan-47k-empirical.md) finding that *opening placement predicts win rate barely above random* (27% vs 25%) — opening placement is the minimax half; in-game play is the best-response half.

## Structure creates norms — the philosophical payoff

This is why the video matters beyond games: it is a **closed-form proof of the [symmetry-breaking](../philosophy/dynamics/symmetry-breaking.md) mechanism**, the vault's account of how constitutive features arise. Map it onto that page's central move (*equal forces on an asymmetric substrate produce asymmetric outcomes*):

| Symmetry-breaking | Battleship |
|---|---|
| Symmetric forcing | uniform random placement (no bias injected) |
| Asymmetric substrate | the bounded 10×10 grid (edges truncate rigid ships) |
| Crystallized residue | the heat map (center 21% / corner 8%) |
| Load-bearing optimum | center-out greedy play, *forced* by the residue |

Every cosmological example on that page is gestural — we can't re-run the universe. Battleship is the version where the substrate is **fully enumerable** (30B boards) and the frozen structure is **computed exactly**. It is the page's best answer to its own Open Question #1 ("is there a quantitative measure of load-bearing?").

**The minimax half is the sharpest "conditional ≠ arbitrary" case in the vault.** Placement is where relativism plants its flag — *"place your ships wherever, it's a free choice."* The video disproves this by **theorem**: the structure reaches into the one spot that looks purely arbitrary and dictates a unique optimal form of the apparent randomness — maximal entropy. Randomness here is not the *absence* of structure; it's the *optimal response* to it. That snaps the relativist's slide (§140 of symmetry-breaking: *contingent → conditional → optional → arbitrary*) at "arbitrary" — the freest-looking layer turns out to be the most tightly determined.

**The constitutive/elective distinction falls straight out** ([constitutive-elective](../philosophy/morality/constitutive-elective.md)):
- **Constitutive** = "be maximum-entropy" — forced, unique, non-optional; deviate and the structure punishes you (you get sunk faster).
- **Elective** = *which particular* high-entropy board you sample — genuinely free, because every member of the equivalence class is equally optimal.

Both are real; neither is arbitrary in the sense the relativist needs. It is *bounded freedom inside a forced distribution* — the whole picture in a 10×10 box.

**NA1 is the same proof on the epistemic axis.** Battleship is structure→**norms** (optimal play *emerges*); the Nobunaga RE work is structure→**meaning** (what something *is* emerges): raw bytes → impose the 6502's structure → reset/NMI/BRK vectors → opcode semantics → the VM → how the game works → how to play it best. The bits *looked* arbitrary; the structure was latent and **discovered, not invented**. Discovery and norm-emergence are one propagation story on two axes — the relationship symmetry-breaking's Open Question #4 anticipates.

**The honest boundary.** Battleship proves the *mechanism* in closed form, but it hands you the **telos** ("win") for free — and real ethics is the fight over whether the goal is given. So this is a clean proof of the *conditional* (structure + telos → emergent non-arbitrary norms), not of the telos itself. The vault pays for the telos elsewhere: symmetry-breaking's **stability-relative-to-timescale** (§129) plus the **convergence/selection** trunk — a structure that ignores its emergent optimum gets *selected out* (sunk in Battleship, conquered in NA1, the Wilson force-doctrine's "fit → durable might"). **Battleship proves the clean half; selection supplies the goal Battleship gets for free.** Stated that way the claim survives the obvious objection ("but you stipulated the goal").

## Where it sits in the existing lenses

- **Randomness-axis** (memory `feedback_randomness_axis_lens`): Battleship's randomness/information lives on the **config axis** (the board setup), like Catan — but **hidden and static**. You can't *read* the config (Catan you can), so you **accumulate** information about it over time. That makes it **hidden-trackable** (`feedback_capability_value_and_information_design`) — the legitimate-soft-flaw category, not hidden-random. The whole guessing half is config-axis information accumulation.
- **Dominance frontier:** the heat map is the dominance graph over guesses; "random-start viability" appears directly as the corner-placement counter (viable but bounded — the spread-out greedy search still cleans up corners fast at endgame).
- **N≥3 termination:** Battleship is N=2 and zero-sum, so it *has* a clean minimax equilibrium — exactly the regime [n3-termination](./n3-termination-and-randomization.md) says you lose once N≥3 and coalitions appear. Battleship is the contrast case where the equilibrium exists and is computable.

## The economy of one turn

First-move advantage under mutual-greedy play = **51.6%**. Saving a single turn per game ≈ **+3 percentage points** ≈ one extra win per **30** games. The post-hit direction heuristic alone saves ~1 guess/ship. Small mechanical edges compound — the same "slots are the binding resource" intuition as the NA1 turn-economy work.

## Open thread

The author teases a *"slightly better way to win"* in a future video and admits in his write-up to many failed attempts at a placement strategy beating random. The interesting unsolved question: **how much of the ½-turn placement edge survives against a greedy opponent that adapts its prior mid-game** (he retunes the heat map for known-pattern opponents)? If placement edge ≈ guessing-prior-misspecification, the two halves aren't independent — and the "flat" verdict is only flat against a *non-adapting* greedy searcher.

## Tags

[games](../../tags/games.md), [game-theory](../../tags/game-theory.md), [strategy](../../tags/strategy.md), [philosophy](../../tags/philosophy.md), [morality](../../tags/morality.md)
