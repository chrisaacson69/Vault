---
status: active
created: 2026-03-23
---
# Aristotelian Logic
> The first formal system of reasoning — and the default assumption in almost every philosophy debate today.

**Links:** [A History of Logic](./history-of-logic.md), [Logic and Mathematics](./README.md), [HoP Ep 3: Heraclitus](../history-of-philosophy/03-heraclitus.md), [HoP Ep 4: Parmenides](../history-of-philosophy/04-parmenides.md), [The Fallacy Fallacy](../the-fallacy-fallacy.md)

---

## What Aristotle Did

Before Aristotle (~350 BC), people reasoned. They argued, debated, persuaded. The Sophists taught rhetoric. Socrates used dialectic. Plato used dialogue. But none of them formalized the *rules* that valid arguments follow.

Aristotle's achievement was **abstraction**: he separated the *form* of an argument from its *content*. The insight that "All men are mortal; Socrates is a man; therefore Socrates is mortal" is valid not because of anything about Socrates or mortality, but because of the *structure* All-A-are-B, C-is-A, therefore C-is-B. Plug in anything and the structure holds.

This is arguably the most important intellectual achievement in human history. Every formal system since — Boolean algebra, predicate logic, computer programming, mathematical proof — descends from this move.

## The Organon

Aristotle's logical works, collectively called the *Organon* ("instrument" or "tool" — note: he conceived of logic as a tool, not a revelation):

| Work | Subject | Key contribution |
|------|---------|-----------------|
| **Categories** | Types of being | 10 categories: substance, quantity, quality, relation, place, time, position, possession, action, passion |
| **On Interpretation** | Propositions | How statements can be true or false; the square of opposition |
| **Prior Analytics** | The syllogism | Formal deductive reasoning from premises to conclusions |
| **Posterior Analytics** | Scientific demonstration | What counts as knowledge vs. mere opinion; the role of first principles |
| **Topics** | Dialectical reasoning | Probable reasoning (not certainty); how to argue well even without proof |
| **Sophistical Refutations** | Fallacies | Catalog of invalid argument forms — the original fallacy taxonomy |

**Note on Sophistical Refutations:** This is where formal fallacy identification begins. But see [The Fallacy Fallacy](../the-fallacy-fallacy.md) — naming a fallacy isn't a rebuttal. Aristotle would have agreed; his goal was to understand *why* certain argument forms fail, not just to label them.

## The Three Laws

Aristotle identified three principles he considered foundational to all reasoning. These are the laws that most people mean when they say "logic":

### 1. The Law of Identity: A is A

A thing is what it is. Everything that exists has a specific nature, specific properties, a specific identity.

**Examples:**
- A rock is a rock, not a non-rock
- The number 7 is 7, not 8
- If a proposition is true, it is true

**What it does:** Establishes that things have definite natures. Without identity, you can't make any statement at all — there would be nothing stable to make statements *about*.

**Seems obvious. Why does it matter?** Because Heraclitus (see [HoP Ep 3](../history-of-philosophy/03-heraclitus.md)) challenged it: if everything is in constant flux, nothing has a stable identity. The river you step in now is not the river you step in a moment later. Aristotle's Law of Identity is partly a response to this challenge — asserting that despite change, things retain identity at any given moment ("at the same time and in the same respect").

**Where it gets contested:** Quantum mechanics. A photon in superposition is genuinely in an indeterminate state — it doesn't have a definite position until measured. Is it "itself" before measurement? This is why quantum logic exists (see [history-of-logic](./history-of-logic.md)). At the quantum level, identity isn't as clean as Aristotle assumed. At the macro level we live in, it works perfectly.

### 2. The Law of Non-Contradiction: A cannot be both B and not-B

A proposition cannot be both true and false at the same time and in the same respect.

**Examples:**
- A ball cannot be entirely red and entirely not-red simultaneously
- You cannot be both in Denver and not in Denver right now
- The statement "it is raining" cannot be both true and false at this moment in this location

**The qualifiers matter:** "At the same time" and "in the same respect." A ball CAN be red on top and blue on bottom — that's not a contradiction because it's red and not-red in *different respects*. You CAN be in Denver at noon and not in Denver at 6pm — different times. Most alleged contradictions in everyday arguments dissolve when you add the qualifiers.

**This is the law that does the most work in debates.** When Wilson or anyone says "your view is contradictory," they're invoking non-contradiction. When the vault identifies [scope confusion](../morality/scope-confusion.md), it's often showing that an apparent contradiction dissolves when you distinguish the scope (the "in the same respect" qualifier).

**Where it gets contested:** Paraconsistent logic (see [history](./history-of-logic.md)) allows contradictions without the system exploding. The liar paradox ("this sentence is false") IS both true and false — and paraconsistent logicians argue this is fine as long as you block the principle of explosion. Also, Nagarjuna's catuskoti allows "both true and false" as a legitimate truth value. These aren't fringe positions — they're active research areas with real applications (database theory, legal reasoning).

### 3. The Law of Excluded Middle: either P or not-P

For any proposition, either it is true or its negation is true. There is no third option.

**Examples:**
- Either it is raining or it is not raining
- Either 7 is prime or 7 is not prime
- Either Caesar crossed the Rubicon or he did not

**What it does:** Forces binary truth values. Every meaningful proposition has a definite truth value — true or false, no middle ground.

**Where it's useful:** Mathematical proof by contradiction depends on this. To prove P, you assume not-P, derive a contradiction, and conclude P. This only works if P and not-P are exhaustive — if there's a third option, the proof fails.

**Where it gets contested:**

**Intuitionistic logic** (Brouwer, Heyting) rejects excluded middle. Their position: a statement isn't true until you can *construct a proof*. "Either Goldbach's conjecture is true or it's false" — the intuitionist says: "I don't know. Show me a proof or a counterexample. Until then, neither." This isn't agnosticism — it's a principled position that truth requires construction.

**Fuzzy logic** (Zadeh) replaces binary truth with continuous values 0–1. "The room is warm" isn't true or false — it might be 0.7 true. The excluded middle breaks because the middle is where most of reality lives.

**Practical example:** "Is this person tall?" A person who is 5'10" — are they tall or not tall? The excluded middle forces a binary answer. Reality doesn't have a sharp line. The sorites paradox (heap problem): if you remove grains from a heap one at a time, when does it stop being a heap? The excluded middle says there must be a precise grain that makes the difference. This seems wrong.

## The Syllogism

Aristotle's signature contribution: the formal structure of deductive argument.

**Structure:**
```
Major premise:  All M are P      (All men are mortal)
Minor premise:  All S are M      (All Greeks are men)
Conclusion:     All S are P      (All Greeks are mortal)
```

Aristotle identified **256 possible syllogistic forms** (4 figures × 64 mood combinations) and showed that only **24 are valid** (some counts vary by interpretation). The invalid forms are the formal fallacies.

### The Four Figures

The position of the middle term (M) determines the figure:

| Figure | Major premise | Minor premise | Example |
|--------|-------------|---------------|---------|
| 1st | M — P | S — M | All animals are mortal; all humans are animals; ∴ all humans are mortal |
| 2nd | P — M | S — M | No reptiles are mammals; all dogs are mammals; ∴ no dogs are reptiles |
| 3rd | M — P | M — S | All dogs are animals; all dogs are pets; ∴ some pets are animals |
| 4th | P — M | M — S | (Less intuitive — debated whether Aristotle recognized this) |

### Quantity and Quality

Each premise has:
- **Quantity:** universal (all, no) or particular (some, some...not)
- **Quality:** affirmative or negative

This gives four proposition types (the traditional AEIO labeling):
- **A:** All S are P (universal affirmative)
- **E:** No S are P (universal negative)
- **I:** Some S are P (particular affirmative)
- **O:** Some S are not P (particular negative)

### The Square of Opposition

Aristotle's relationships between these four types:

```
        A (All S are P) ←—contraries—→ E (No S are P)
        |                                |
   subalterns                       subalterns
        |                                |
        I (Some S are P) ←—subcontraries—→ O (Some S are not P)

  A ←——contradictories——→ O
  E ←——contradictories——→ I
```

- **Contradictories** (A/O, E/I): exactly one is true
- **Contraries** (A/E): both can't be true, but both can be false
- **Subcontraries** (I/O): both can't be false, but both can be true
- **Subalterns** (A→I, E→O): if the universal is true, the particular is true

**This is the logic most people intuitively use.** When someone says "that's a contradiction," they usually mean they've found an A/O or E/I contradictory pair. When they say "you can't both be right," they usually mean they've identified a contrary pair. Understanding the square makes you better at diagnosing exactly what kind of logical conflict exists.

## What Aristotle Got Right

1. **Form matters independently of content.** The structure of an argument determines its validity regardless of what it's about. This is the foundation of all formal reasoning.

2. **Some argument forms are universally valid.** Barbara (AAA-1: All M are P, All S are M, ∴ All S are P) works for literally any M, S, P. This universality is the evidence that logic tracks real structure.

3. **Fallacies are structural.** An argument can fail because of its form, not just its premises. This enables systematic error detection.

4. **Logic is a tool.** Aristotle called it an *organon* — an instrument. He didn't treat it as a cosmic law or divine gift. He treated it as a technology for reasoning correctly. The vault agrees.

## What Aristotle Missed

1. **Relations.** "A is taller than B" can't be expressed in Aristotelian syllogisms. There's no way to put relational predicates into the All-S-are-P form. This had to wait for Frege's predicate logic (1879).

2. **Quantified infinity.** "For every number, there exists a larger number" requires quantifiers (∀, ∃) operating over infinite domains. Aristotle's "all" and "some" work for finite collections. Mathematical reasoning about infinity needed new tools.

3. **Propositional connectives.** "If it rains, then the ground is wet" — conditional reasoning — isn't a syllogism. Aristotle handled some conditional reasoning in Topics, but he didn't formalize it. The Stoics (Chrysippus) actually developed propositional logic, but it was lost and had to be reinvented in the 19th century.

4. **Self-reference.** "This statement is false" — the liar paradox — breaks Aristotle's framework. He was aware of it but didn't solve it. Nobody has, cleanly — it drove the development of type theory (Russell), Gödel's incompleteness, and paraconsistent logic.

5. **Non-binary truth.** The world contains vagueness, gradients, and indeterminacy that binary true/false can't capture. "Is this person tall?" needs more than two answers.

6. **Temporal logic.** "It will rain tomorrow" — is this true or false right now? Aristotle's "sea battle" problem: "There will be a sea battle tomorrow" seems neither true nor false today. He recognized the problem but had no formal solution. Temporal logic wasn't developed until the 20th century.

## Aristotle's Logic in Modern Debates

### Why it dominates online discourse

Most philosophy debate participants (Wilson, his opponents, libertarians, atheists) use Aristotelian logic exclusively and unconsciously. When Wilson says "your position is contradictory," he means it violates non-contradiction. When he says "you're assuming the excluded middle," he means Aristotle's third law. When anyone says "that's a fallacy," they're using Aristotle's framework from Sophistical Refutations.

This works fine for most arguments. The three laws hold at the macro scale, for non-self-referential propositions, about determinate properties. That covers 95% of debates.

### Where it's insufficient

The 5% where it breaks is exactly where the interesting philosophy happens:

- **TAG debates:** "Logic is immaterial, therefore God" assumes logic is one settled system. It isn't. Which logic? (See [Nicks vs Allen](../../debates/god-precondition-knowledge-nicks-allen.md))
- **Morality:** "Either an action is moral or immoral" — excluded middle. But what about morally neutral actions? What about actions that are moral in one scope and immoral in another? (See [scope confusion](../morality/scope-confusion.md))
- **Governance:** "The state both prevents monopoly and is a monopoly" — contradiction under non-contradiction. Under paraconsistent logic, it's a system operating with a contradiction. (See [Gödel Governance Problem](../the-godel-governance-problem.md))
- **Quantum mechanics:** Superposition violates identity. Complementarity violates excluded middle. Reality at the fundamental level requires non-Aristotelian logic.

### The vault's position

Aristotelian logic is an extraordinary first approximation. It works well enough for daily reasoning and most philosophical arguments. But treating it as the *complete* and *final* system of logic — as both Wilson and most of his opponents do — is like treating Newtonian physics as the final theory of motion. It works at the human scale. It breaks at the edges. And the edges are where the deepest questions live.

## Open Questions

1. **How much of Aristotle's logic is "hardwired" in human cognition?** Infants seem to expect non-contradiction (surprise at impossible events). Is this evidence that the three laws are structural features of reality, or just features of brains evolved at the macro scale?
2. **Could Aristotle have developed predicate logic?** He was aware of relational reasoning (Topics, Sophistical Refutations). What stopped him from formalizing it? Was it a conceptual limit or just a notational one?
3. **Is the square of opposition still useful?** Modern predicate logic subsumes it, but the visual structure makes logical relationships intuitive in a way that symbolic notation doesn't. There's a reason it was taught for 2,000 years.

## Tags
[philosophy](../../../tags/philosophy.md), [logic](../../../tags/logic.md), [epistemology](../../../tags/epistemology.md)
