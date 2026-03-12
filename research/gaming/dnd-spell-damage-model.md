# D&D Spell Damage Model — Math as Game Design Tool
> Using the central limit theorem, proof by induction, and bimodal distributions to build a spell comparison metric. Same instinct as BattleValue, different game.

**Status:** complete — video analysis
**Created:** 2026-03-11
**Source:** [The Math of D&D Spells](https://www.youtube.com/watch?v=yrgbi1xPESc) — The Gorilla of Destiny (PhD student, D&D science books)
**Transcript:** [dnd-math-spells-transcript.txt](../../logs/dnd-math-spells-transcript.txt)
**Links:** [BattleValue](./battle-value.md), [Gaming](./README.md), [Logic and Mathematics](../philosophy/logic-and-math/README.md), [Newcomb's Paradox](../philosophy/newcombs-paradox.md)

## The Model

The video builds a spell damage predictor from first principles, starting simple and layering in complexity:

### Step 1: Mean of NdS

For N dice with S sides, the expected damage is:

```
μ = N × (S + 1) / 2
```

Derived via the Gauss pairing trick: sum 1 through S by pairing first+last (1+S), second+second-last (2+(S-1)), etc. Each pair sums to S+1. There are S/2 pairs. Works for odd S too — the unpaired middle value is exactly (S+1)/2.

**Example:** Fireball = 8d6 → μ = 8 × 7/2 = **28**

### Step 2: Standard Deviation of NdS

Requires the sum-of-squares formula:

```
1² + 2² + ... + S² = S(S+1)(2S+1) / 6
```

He proves this by **induction** rather than asserting it:
1. Assume true for S → show true for S+1 (algebraic manipulation)
2. Verify base case S=1 (trivially true — "a one-sided die, which I'm pretty sure is just a ball with a one drawn on it")
3. Therefore true for all positive integers

The standard deviation for a single die:
```
σ² = E[X²] - (E[X])² = S(S+1)(2S+1) / (6S) - ((S+1)/2)²
```

For N dice, multiply by N (variance of independent sums).

### Step 3: Central Limit Theorem

As N → ∞, the sum of independent dice rolls converges to a normal distribution. At N=8 (Fireball), the fit is already very good — a million simulated rolls overlay almost perfectly with the normal curve defined by the derived μ and σ.

This is the "unreasonable effectiveness" problem in miniature: a theorem about infinity gives accurate predictions for 8 dice.

### Step 4: Bimodal Hit/Save Model

D&D spells have a save mechanic — the target can halve damage by making a saving throw. This creates a **bimodal distribution**: a weighted sum of two normals.

- **Full damage distribution:** N(μ, σ) — when the target fails the save
- **Half damage distribution:** N(μ/2, σ/2) — when the target succeeds

The probability density function is:
```
f(x) = h × N(μ, σ) + (1 - h) × N(μ/2, σ/2)
```

Where h = **hit rate** = (DC - save_bonus - 1) / 20

### Step 5: Unified Expected Damage

The overall expected damage combines everything:
```
E[damage] = h × μ + (1 - h) × μ/2
```

The overall standard deviation requires a correction for the distance between the two distribution means:
```
σ_total² = h × σ² + (1 - h) × (σ/2)² + h(1-h)(μ - μ/2)²
```

This gives a single comparable number per spell — plug in your DC and the enemy's save bonus, compare spells.

## What the Model Misses

The model compares spells on **single-round expected damage**. This inherently biases toward burst damage:

- **Cloud Kill** (5th level, concentration, 1 min / 10 rounds) does 5d8 per round to anything in the area. Single-round ED is lower than Fireball, but over 2+ rounds it overtakes. The comments and comparison results in the video both show "Fireball always wins" — because the metric was built for Fireball's strength.
- **Area denial** — Cloud Kill forces enemies to leave or keep eating damage. This constrains tactical options in ways no expected-damage number captures.
- **Duration and action economy** — a sustained spell costs one action for multiple rounds of effect. Burst costs one action for one round.
- **Target count and positioning** — AoE effectiveness depends on how many enemies are clustered.

The model answers "which spell does more damage this round?" — a narrower question than "which spell should I cast?"

## Vault Connections

### BattleValue Parallel

This is structurally the same problem as [BattleValue](./battle-value.md): reduce complex combat to a single comparable number.

| | BattleValue | D&D Spell Model |
|---|---|---|
| **Input** | Attack, HP | Dice (NdS), DC, save bonus |
| **Output** | BV = √(Attack × HP) | E[damage] = h × μ + (1-h) × μ/2 |
| **Efficiency metric** | BV / Cost | E[damage] / spell slot level |
| **What it captures** | Combat product | Expected single-round output |
| **What it misses** | Initiative, range | Duration, area denial, action economy |

Both are lossy compressions that sacrifice detail for decision-making speed. The metric is useful *because* it throws away information, not in spite of it. And in both cases, when the metric stops matching player experience (everyone knows Cloud Kill is good, everyone knows initiative matters), that's the signal to build a better model.

### Structural Realism Case Study

The [logic and math page](../philosophy/logic-and-math/README.md) argues that mathematics is a human construction that models real patterns. This video is a clean illustration:

- The **dice distributions** are real — roll 8d6 a million times and you get a bell curve whether or not anyone models it
- The **normal distribution formula** is the map — a human-built approximation that works shockingly well
- The **CLT** is an asymptotic result (N → ∞) applied at N=8 — the map predicts the territory better than it "should"
- He doesn't *discover* that Fireball beats Cloud Kill in burst damage — he *constructs a model* that makes the comparison systematic

This also illustrates logic-and-math open question #4: "does the process of building-and-testing formalisms converge on something?" The proof by induction for sum-of-squares is the meta-tool — a construction that validates other constructions. Induction lets you extend a finite check to all integers, which is remarkable if you think about what that means for a "mere" human construction.

### The Hearthstone Connection

Card games like Hearthstone have a related problem: developers use an internal cost model (mana curve vs. stats/effects), and players try to reverse-engineer it to find "bargain" cards — units whose BV/Cost (or stat-equivalent/mana-cost) exceeds the norm. The difference from D&D: card game design has a human designer choosing to break their own rules for balance or flavor. Dice physics don't have a designer making Fireball "feel good."

The BattleTech Simulator project is the same pattern applied to tabletop wargaming: compare empirical combat performance (Monte Carlo) to the official BattleValue2 rating and find where the published ratings are wrong.

## Pattern: Reduce, Compare, Iterate

The same instinct appears independently across games and domains:

| Domain | Metric | What it compresses |
|--------|--------|--------------------|
| BattleTech | BV = √(A × HP) | Combat to a scalar |
| D&D spells | E[damage] | Dice + saves to a scalar |
| Hearthstone | Stat-equivalent / mana | Card value to a ratio |
| Economics | ROI | Investment quality to a ratio |
| MOO1 | BV/Cost fleet composition | Unit roster to an efficiency ranking |

Each metric is useful, each is incomplete, and each invites the same next step: identify what the metric misses and build a better one. The process *is* the point — the vault's position on structural realism applied to game design.

## Tags
[games](../../tags/games.md), [mathematics](../../tags/mathematics.md), [game-theory](../../tags/game-theory.md), [strategy](../../tags/strategy.md)
