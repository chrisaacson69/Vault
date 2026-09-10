---
status: active
created: 2026-09-10
published: true
layout: layouts/page.njk
title: "Theorems With Absurd Readings"
---
# Theorems With Absurd Readings
> Never hand logic an error to correct — hand the audience a valid theorem whose plain-language reading nobody believes. Then "you translated badly" is unavailable, because you translated nothing.

**Links:** [The Absoluteness Claim](./the-absoluteness-claim.md) — the hub, [Logic and Mathematics](./README.md), [Formal Systems and Approximation](./formal-systems-and-approximation.md), [The Consistency Defeater](./the-consistency-defeater.md), [The Translation Problem](./the-translation-problem.md), [Intuitionistic Logic](./intuitionistic-logic.md), [Non-Classical Logics](./non-classical-logics.md), [Aristotelian Logic](./aristotelian-logic.md)

---

Tier 3 of the [example set](./the-absoluteness-claim.md#the-example-set), and the methodological core of the whole approach.

The [method error](./the-absoluteness-claim.md#the-method-error-why-the-obvious-attacks-fail) that sinks most attempts is arguing from **mistakes** — constructing a contradiction out of natural-language premises and watching it get dismantled. Soundness guarantees that game is lost before it starts. The fix is to argue from **theorems**: results the opponent's own system produces, by rules he endorses, whose ordinary-language reading is plainly false. He cannot blame the translation, because there wasn't one.

The methodological upgrade. Never hand logic an error to correct. Hand the audience a **valid theorem whose plain-language reading is absurd** — then "you translated badly" is unavailable, because you did not translate anything. It is their theorem, derived by their rules.

## The drinker paradox, in full

**The theorem.** In classical predicate logic, for any non-empty domain:

```
∃x (Dx → ∀y Dy)
```

Read in English: **there exists someone such that, if that person is drinking, then everyone is drinking.** Raymond Smullyan popularized it as a pub sentence: there is a customer in the bar such that, if *he* is drinking, everybody in the bar is drinking. One specific person whose drinking habits determine the entire room's.

It is not a paradox in the sense of an unresolved puzzle. It is a **theorem** — provable, valid, uncontroversial among logicians. The trouble is entirely in what it appears to say.

**The proof.** Two cases, by excluded middle on "is everyone drinking?"

*Case 1 — everyone is drinking.* Then `∀y Dy` is true. Pick literally anyone in the pub, call him `a`. The conditional `Da → ∀y Dy` has a true consequent, and a conditional with a true consequent is true regardless of its antecedent. So `a` witnesses the claim. ✔

*Case 2 — someone is not drinking.* Call that person `b`, so `Db` is **false**. The conditional `Db → ∀y Dy` has a false antecedent, and a conditional with a false antecedent is **vacuously true** — that's row 3 and row 4 of the material conditional's truth table. So `b` witnesses the claim. ✔

Excluded middle says those two cases are exhaustive. In both, a witness exists. Therefore `∃x(Dx → ∀y Dy)`. ∎

**What makes it absurd.** Three things collide:

1. **The material conditional ignores connection.** `Db → ∀y Dy` is "true" for the teetotaller not because his abstinence has any bearing on the room, but purely because his antecedent is false. Natural-language "if…then" almost always implies a *connection* — causal, evidential, explanatory — and the material conditional encodes none of it. See [The Translation Problem](./the-translation-problem.md), Problem 4.
2. **Excluded middle licenses a case split with no witness in hand.** The proof establishes that *someone* has this property without ever telling you who. In Case 2 the witness is "whoever isn't drinking" — no name, no identification, and you cannot point at him. This is the non-constructive existence claim that [intuitionistic logic](./intuitionistic-logic.md) refuses.
3. **The quantifier scope is not what the English suggests.** English hears "there is a special person whose drinking is decisive." The formula says only that the sentence `Dx → ∀y Dy` has at least one satisfying instance. Nothing distinguishes that instance; it isn't special; in Case 1 *everyone* satisfies it.

**Why it is the right weapon.** No translation is being performed and no premise is being asserted, so every rescue available against the fly example is unavailable here:

- *"You translated badly"* — nothing was translated. This is a theorem of his system, in his notation.
- *"Your premises are false"* — there are no premises. It's a validity, true in every model.
- *"That's not what logic means"* — then say which inference step is invalid. There are three (excluded middle, disjunction elimination, existential introduction) and he accepts all of them.

The only honest reply is the correct one: **"yes, that's a theorem, and its natural-language reading is misleading."** Which is the concession — that a system can be perfectly valid and still emit sentences whose plain reading nobody believes. Validity is not truth about the world. Once that's on the table, "the laws of logic are absolute and therefore describe reality" has lost its bridge.

**How to deploy it.** Don't present it as a gotcha; present it as a question you'd like answered. *"Your system proves there's a man in this pub whose drinking implies everyone's. I didn't translate anything — that's your theorem. Is it true? And if it's true, what does 'true' mean here?"* Then let him explain that the material conditional doesn't track real connections — because that explanation **is** the argument that logic is a formalism which approximates reasoning rather than mirroring it. He makes the case for you, in his own words, and it is much more persuasive that way.

This is the good version of what the fly-in-the-car attempt was groping toward — the same mechanism (vacuous implication) arriving as a theorem instead of an error.

**Explosion — the one aimed directly at the argument.** In classical logic, from a single contradiction, *everything* follows (*ex falso quodlibet*):

```
1. P            (assumed)
2. ¬P           (assumed)
3. P ∨ Q        (from 1)
4. Q            (from 2, 3)
```

Q is anything at all. "God exists." Also "God does not exist." So a classical system containing one contradiction anywhere contains a valid proof of God — and a valid proof of no God — and both are worthless.

Which means the force of "logic proves God" rests entirely on an unstated premise: **that your system is consistent.** You cannot establish that from inside it. That is the Gödel point delivered without Gödel — no self-reference, no strange loops, nothing that smells like a trick. Just: *you are assuming your own consistency, and if you are wrong, your logic proves God trivially.*

## Open Questions

1. **What is the best third theorem?** The drinker paradox and explosion cover the material conditional and triviality. Candidates for a third: Curry's paradox (too self-referential, breaks the no-strange-loops constraint), the Banach–Tarski theorem (vivid — one ball cut into two of equal size — but it leans on the axiom of choice rather than on the three laws), or the nonconstructive existence proof on the [production page](./logics-in-production.md). Which lands best with a lay audience?
2. **Does the "is it true?" delivery actually work?** The recommended move is to ask the question and let the opponent explain that the material conditional doesn't track real connections — so he makes the case himself. Untested. He may simply say "yes, and so what," which needs a prepared follow-up.
3. **Is there a theorem whose absurd reading bears on *identity* specifically?** Both current items target excluded middle and the conditional. Law 1 is only reachable through the [tautology framing](./the-absoluteness-claim.md#law-1--identity-a-is-a-is-a-tautology) and the conferred-identity cases, neither of which is a theorem with an absurd reading.

## Tags
[philosophy](../../../tags/philosophy.md), [logic](../../../tags/logic.md), [epistemology](../../../tags/epistemology.md)
