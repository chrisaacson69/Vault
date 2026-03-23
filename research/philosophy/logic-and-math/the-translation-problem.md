# The Translation Problem
> Formal logic is only as good as the translation from reality into symbols. That translation is where most reasoning actually fails — and it's the part logic can't help with.

**Status:** active
**Created:** 2026-03-23
**Links:** [Logic and Mathematics](./README.md), [Aristotelian Logic](./aristotelian-logic.md), [The Formal Revolution](./formal-revolution.md), [The Birthmark and the Search for Truth](../epistemology/the-birthmark.md), [The Weighting Problem](../epistemology/weighting-problem.md), [Scope Confusion](../morality/scope-confusion.md)

**Further reading:** [van Dalen — *Logic and Structure*](https://www.logicmatters.net/tyl/booknotes/vdalen/) — a standard textbook that takes these foundational issues seriously, though they're poorly known outside academic logic

---

## The Problem

Before logic can operate, you have to do something logic can't help with: **translate reality into propositions.**

Classical propositional logic takes as input variables — P, Q, R — that represent propositions. It then manipulates these variables according to formal rules (AND, OR, NOT, IF-THEN) and produces valid conclusions. The formal machinery is pristine. But the machinery only works on symbols. Getting from the messy, ambiguous, context-dependent real world to clean symbols is a non-trivial act of interpretation that happens *before* logic starts.

This is the gap that most people — including most philosophy debaters — don't see. They argue as though "translating a claim into a proposition" is obvious and uncontroversial. It isn't. It's where most reasoning actually goes wrong.

## Problem 1: What Counts as "the Same Proposition"?

### The Biconditional Collapse

Consider P ↔ Q (P if and only if Q). In classical logic, this means P and Q have the same truth value. It functions as logical equivalence — mathematically identical to P = Q in Boolean algebra.

But this produces absurdities:

| P | Q | P ↔ Q |
|---|---|-------|
| "Snow is white" (T) | "2+2=4" (T) | **TRUE** |
| "Snow is white" (T) | "The earth orbits the sun" (T) | **TRUE** |
| "Dogs bark" (T) | "Shakespeare wrote Hamlet" (T) | **TRUE** |

All true statements are "equivalent" to all other true statements. All false statements are "equivalent" to all other false statements. The entire universe of propositions collapses into two bins: the true bin and the false bin. P ↔ Q, pushed to its conclusion, reduces to P = P — the law of identity applied to truth values, with all content erased.

This is technically correct in Boolean algebra. And it's completely useless for actual reasoning, because it throws away everything except the one-bit signal of true/false. The proposition "Snow is white" *means* something different from "2+2=4" even though both are true. Classical logic has no apparatus to express this difference.

### Extensional vs. Intensional Identity

The issue has a name: the **extension/intension** distinction.

- **Extension:** what a proposition *picks out* in the world — its truth value, the set of possible worlds where it's true
- **Intension:** what a proposition *means* — its cognitive content, its informational contribution, what it's *about*

Classical propositional logic is purely **extensional**. It only sees truth values. Two propositions with the same truth value are interchangeable in any formula without changing the formula's truth value (the principle of substitutivity).

But actual reasoning is **intensional**. We care about *what things are about*, not just whether they're true. "The morning star is bright" and "the evening star is bright" have the same truth value (both refer to Venus), but they contribute different information — one tells you something about what you see at dawn, the other about what you see at dusk. Substituting one for the other changes the *meaning* even though it preserves the *truth value*.

Frege saw this (sense vs. reference). But classical propositional logic, which Frege helped build, doesn't encode it. The formalism deliberately discarded meaning to get clean algebra. This was a pragmatic choice, not a deep truth about how reasoning works.

## Problem 2: Cross-Language Identity

"Snow is white" (English)
"La neige est blanche" (French)
"Schnee ist weiß" (German)
"雪は白い" (Japanese)

Are these four propositions or one?

**Extensionally:** One. They're true in exactly the same circumstances. Any world where snow is white makes all four true; any world where snow isn't white makes all four false. They're the same proposition expressed in different symbol systems.

**Intensionally:** It depends. A monolingual English speaker understands the first and not the others. The cognitive content is different even if the truth conditions are identical. The French version carries implications about French culture and the French concept of *neige* that the English version doesn't.

**For formal logic:** This doesn't matter — you assign one variable P and move on. But for *actual reasoning*, the translation from natural language to formal variable is doing real work. When you say "let P = 'Snow is white,'" you're making a decision that:
- This English sentence successfully identifies a unique proposition
- This proposition has a determinate truth value
- The same variable P would apply to the French version
- All contextual ambiguity has been resolved

Each of these is an assumption, not a given.

## Problem 3: Ambiguity and Homonyms

"She saw a bat flying."

Before you can assign this to a variable, you need to know which proposition it expresses:

- P₁: She observed a flying mammal (the animal, Chiroptera)
- P₂: She observed a piece of sporting equipment airborne (baseball bat, cricket bat)

P₁ and P₂ have different truth conditions, different implications, and different relationships to other propositions. They happen to be expressed by the same sentence. Classical logic requires you to have already resolved this ambiguity before you start reasoning. But resolving it requires:

- **Context:** What was she doing? At a cave, or at a baseball game?
- **World knowledge:** Bats (mammals) fly under their own power. Bats (sporting equipment) only fly if thrown.
- **Pragmatic inference:** What did the speaker probably mean?

None of this is formal. All of it is essential. The hardest part of reasoning isn't the logic — it's getting to the point where logic can start.

### Scope Ambiguity

Even without homonyms, structural ambiguity is everywhere:

"Every student read a book."

- ∀x∃y (Student(x) → (Book(y) ∧ Read(x,y))) — Every student read SOME book (possibly different books)
- ∃y∀x (Book(y) ∧ (Student(x) → Read(x,y))) — There's ONE book that every student read

Same English sentence, two different logical forms, two different truth conditions. The first is true if each student read any book at all. The second is true only if there's a specific book they ALL read. Predicate logic can express both, but it can't tell you which one the speaker meant. That's interpretation, not logic.

**Vault connection:** This is [scope confusion](../morality/scope-confusion.md) at the linguistic level. When people argue past each other about moral claims, they're often making the same kind of scope error — using the same words to express different propositions and not realizing it. "Helping people is good" can mean "helping people in general tends to produce good outcomes" (weak, true) or "every act of helping is morally required regardless of cost" (strong, false and self-destructive). Same sentence, different scope, different proposition.

## Problem 4: The Material Conditional's Indifference

The material conditional P → Q compounds the translation problem by being indifferent to *connection* between P and Q:

| P | Q | P → Q |
|---|---|-------|
| T | T | T |
| T | F | F |
| F | T | T — *regardless of any connection between P and Q* |
| F | F | T — *regardless of any connection between P and Q* |

"If the moon is made of cheese, then 2+2=5" is TRUE because the antecedent is false. "If pigs fly, then water is wet" is TRUE because the consequent is true. Neither conditional has any *connection* between its parts. They're "true" only in the technical, truth-functional sense.

In natural language, "if...then" almost always implies a connection — causal, logical, evidential. "If it rains, then the ground gets wet" implies rain CAUSES wetness. "If x is a mammal, then x is warm-blooded" implies a logical relationship. The material conditional captures none of this. It reduces "if...then" to a truth table with no requirement of relevance.

**Why this matters:** When someone constructs a logical argument, the premises are connected by material conditionals. But the *reason* the argument is persuasive is usually the *connection* between premises — a connection the formalism doesn't encode. If you challenge the connection ("why does P lead to Q?"), you're asking a question that propositional logic literally cannot express. The work is being done by interpretation, not by the formal machinery.

**Logics that address this:**
- **Relevance logic** — requires that P and Q share propositional variables (they must be *about* related things)
- **Strict implication** (C.I. Lewis) — P strictly implies Q if it's *impossible* for P to be true and Q false (modal connection)
- **Counterfactual conditionals** (David Lewis) — handles "if P were true, Q would be" by evaluating the closest possible worlds where P is true

Each of these was developed specifically because the material conditional doesn't capture what humans mean by "if...then." The fact that we needed three different fixes tells you how deep the problem goes.

## Problem 5: The Act of Formalization Is Interpretive

Putting it all together: the act of translating reality into formal logic requires:

1. **Identifying propositions** — deciding what counts as a single, well-formed statement
2. **Disambiguating** — resolving homonyms, scope ambiguity, context dependence
3. **Assigning identity** — deciding whether two expressions are "the same" proposition
4. **Choosing connectives** — deciding that "if...then" maps to →, when it might better map to strict implication or counterfactual
5. **Choosing quantifier scope** — deciding whether "every student read a book" means ∀∃ or ∃∀

Every one of these steps requires *judgment* — the thing the Birthmark essay calls interpretation, the thing Wilson's king's ransom analogy says you need experts for. Formal logic operates downstream of interpretation. It processes what interpretation gives it. And interpretation is where the real reasoning happens.

This means: **logic doesn't tell you what's true. It tells you what follows from what you've already decided is true.** The "already decided" part — the translation from reality to symbols — is philosophy, not logic. It's epistemology, semantics, pragmatics, and domain knowledge. It's exactly the pre-logical layer that most debaters skip.

## What This Means for the Vault

### Logic is a tool, not a foundation

The translation problem confirms the vault's structural realism position: logic is a tool we build to model reality, not a mirror that reflects it automatically. The tool has precision and power, but it requires a skilled operator to aim it correctly. Garbage in, garbage out.

### TAG has a pre-logical problem

The Transcendental Argument for God says: "You use logic, you can't account for it, therefore God." But before you can "use logic," you have to translate your claims into formal propositions — and that translation is an interpretive act that logic itself can't guide. If logic requires God, then the pre-logical interpretation that logic depends on requires... what? More God? This is a regress that TAG doesn't address.

### Debates are mostly translation failures

Most philosophical disagreements aren't about logic at all. Both sides accept modus ponens. Both sides accept non-contradiction. They disagree about *what the propositions are* — which is a translation problem, not a logic problem. When Wilson and an atheist argue about morality, they're not disagreeing about logical validity. They're disagreeing about how to translate moral intuitions into formal claims. The logic is shared. The interpretation is where the conflict lives.

### The emergence thesis applies here too

The act of translation — turning messy reality into clean propositions — is something human brains do effortlessly and computers do terribly. LLMs can manipulate propositions once formed but struggle with the grounding step of connecting language to reality (the [LLM Grounding Problem](../../llm-grounding-problem.md)). This is because translation requires embodied understanding of what propositions are *about* — the sensorimotor grounding that the Birthmark essay identifies as the foundation of knowledge.

## Open Questions

1. **Can the translation step itself be formalized?** Montague grammar (1970s) attempted to formalize the mapping from natural language to logic. It works for toy examples but breaks on real language. Is this a solvable problem or a fundamental limit?
2. **Is intensional logic the answer?** Systems that track meaning, not just truth values, exist (possible-worlds semantics, hyperintensional logic). Do they solve the translation problem or just move it?
3. **How much of philosophical disagreement is actually translation disagreement?** If most debates are about what the propositions are rather than what follows from them, should we spend less time on logic and more on semantics?
4. **Does AI need to solve this to reason well?** Current LLMs skip the translation step entirely — they operate on patterns in language, not on formalized propositions. Is this a feature (they handle ambiguity naturally) or a bug (they have no formal rigor)?

## Tags
[philosophy](../../../tags/philosophy.md), [logic](../../../tags/logic.md), [epistemology](../../../tags/epistemology.md)
