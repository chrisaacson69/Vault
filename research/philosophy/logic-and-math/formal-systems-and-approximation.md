---
status: active
created: 2026-09-10
published: true
layout: layouts/page.njk
title: "Formal Systems and Approximation"
---
# Formal Systems and Approximation
> Euclidean geometry is the worked example of what a formal system *is*: axioms chosen, theorems derived, objects idealized, reality approximated. Every move that broke it has an exact counterpart in logic — including the one nobody notices, that a proposition is as idealized as a point.

**Links:** [Logic and Mathematics](./README.md), [The Absoluteness Claim](./the-absoluteness-claim.md), [The Translation Problem](./the-translation-problem.md), [The Consistency Defeater](./the-consistency-defeater.md), [Aristotelian Logic](./aristotelian-logic.md), [Non-Classical Logics](./non-classical-logics.md), [Gödel Against Himself](../../../notes/godel-against-himself.md), [The SQL Argument](./the-sql-argument.md), [Theorems With Absurd Readings](./theorems-with-absurd-readings.md), [Logics In Production](./logics-in-production.md)

---

## Why Geometry Is The Right Vehicle

Geometry is the best teaching instrument available for the claim that logic is a built system, and it beats every alternative for three reasons:

1. **It is finished history.** Nobody contests it. There is no live scientific dispute to hide behind, unlike [quantum logic](./quantum-logic.md).
2. **It carries no ideological charge.** An audience that will fight you over logic-and-God will concede every step of the geometry story without noticing where it leads.
3. **The structure is identical, not analogous.** The parallel postulate was a self-evident absolute for two thousand years, the greatest philosopher of the modern era staked his epistemology on it, and it turned out to be a local approximation. That is precisely the claim being made about the three laws.

This page is the worked version. It exists to be *used* — the argument it supports lives in [The Absoluteness Claim](./the-absoluteness-claim.md).

## What A Formal System Actually Is

Four parts, and Euclid's *Elements* (c. 300 BC) is the first complete instance in history:

| Part | In Euclid | In classical logic |
|---|---|---|
| **Primitives** | point, line, plane — undefined, taken as given | proposition, truth value, negation |
| **Axioms/postulates** | 5 postulates + 5 common notions | identity, non-contradiction, excluded middle (+ inference rules) |
| **Inference rules** | the constructions and deductions of Greek mathematics | modus ponens, substitution, etc. |
| **Theorems** | 465 propositions across 13 books | every tautology and valid form |

The critical property: **the theorems are true *of the system*.** They follow from the axioms with total rigour. Whether they are true *of the world* is a completely separate question that the system itself cannot answer — and that is the entire lesson.

## The Fifth Postulate

The first four postulates are terse and obviously acceptable:

1. A straight line can be drawn between any two points
2. A finite line can be extended indefinitely
3. A circle can be drawn with any centre and radius
4. All right angles are equal

Then the fifth, which does not read like the others at all:

> If a straight line falling on two straight lines makes the interior angles on the same side less than two right angles, the two straight lines, if produced indefinitely, meet on that side on which the angles are less than two right angles.

### Euclid Was Uncomfortable With It

This is the detail that makes the story land, and it is not a modern reinterpretation:

- **It is stated differently.** P5 is wordy, conditional, and about behaviour *at infinity* — it asserts something you can never verify by construction, because it requires producing lines "indefinitely." P1–P4 are all finite, checkable acts. P5 is a claim of a different logical type, dressed as a postulate.
- **He avoided using it.** Euclid proves his first **28 propositions** without it. Proposition I.29 is the first that invokes P5. A mathematician who thought it as obvious as the others would have used it whenever convenient; he plainly worked to postpone it.
- **Antiquity noticed too.** Proclus (5th c. AD) records the unease explicitly and reports Ptolemy's attempt to *prove* P5 from the other four — which is only worth attempting if you suspect it is a theorem masquerading as an axiom.

### Two Thousand Years Of Failed Proofs

The attempts continued unbroken until the 18th century, and the last of them is the best story in mathematics.

**Girolamo Saccheri (1733)**, in *Euclides ab omni naevo vindicatus* ("Euclid Cleared of Every Flaw"), tried proof by contradiction: assume P5 is false, derive an absurdity, and P5 is vindicated. He assumed the negation and worked out theorem after theorem — and **derived a large part of hyperbolic geometry.** No contradiction ever came, because there isn't one.

He had non-Euclidean geometry in his hands and rejected it, writing that the results were "repugnant to the nature of the straight line." He could not find a contradiction, so he substituted an aesthetic judgment for one and published it as a proof.

> **This is the exact failure mode the absoluteness claim runs on.** No contradiction is available, so intuitive repugnance is offered in its place. "I can't imagine it being otherwise" gets promoted to "it cannot be otherwise." Saccheri is what that looks like from the outside, with the verdict already in.

## The Break, And Why Consistency Is The Whole Point

- **Gauss** worked it out first and published nothing, writing to Bessel that he feared "the clamour of the Boeotians." The most authoritative mathematician alive judged the result too socially costly to state.
- **Lobachevsky (1829)** and **Bolyai (1832)**, independently, published consistent geometries in which P5 fails and infinitely many parallels pass through a point.
- **Riemann (1854)**, in his habilitation lecture, generalized the whole business: geometry is the study of manifolds with a metric, and Euclidean space is one special case among unboundedly many.
- **Beltrami (1868)**, then Klein and Poincaré, built **models** — hyperbolic geometry realized inside Euclidean space (the pseudosphere, the disk).

That last step is the one that matters logically, and it is usually skipped:

> **A model gives a *relative consistency proof*. If Euclidean geometry is consistent, then hyperbolic geometry is consistent — exactly as consistent, no more and no less.** The alternative is not a sloppy approximation of the real thing. It is a peer.

This is the precise answer to "but the alternatives are just made-up." So is Euclid. Both are axiom sets; each is consistent if the other is; the mathematics has no preference between them. Preference comes from *application*, which is empirical, which brings us to the verdict.

## The Verdict: Reality Chose The Other One

Kant made Euclidean geometry the centrepiece of the *Critique of Pure Reason*: space is the a priori form of outer intuition, and geometry is therefore **synthetic a priori** — substantive knowledge about the world, guaranteed in advance of any experience, unrevisable by observation. It is the strongest claim of absoluteness ever made for a formal system by a serious philosopher.

In 1915 General Relativity made spacetime curvature the mechanism of gravity, and in 1919 Eddington measured it. **The geometry of the universe we live in is not Euclidean.** Kant's paradigm case of unrevisable a priori truth was revised by observation.

Note carefully what did *not* happen. Euclidean geometry was not refuted, discarded, or shown to be nonsense. Every theorem still follows from the axioms; every draughtsman and machinist still uses it; it remains one of the great achievements of the species. What was refuted was the claim that it is **the** geometry, absolute and unrevisable. It turned out to be an excellent local approximation whose axioms hold to superb precision at human scale and fail where gravity is strong.

> That is the entire shape of the argument about logic, already completed once, in a case nobody disputes.

## The Second Lesson: The Objects Are Idealizations

The geometry story has a second half that is usually treated as a separate point but is really the same one, and it is the half that transfers to logic in a way almost nobody notices.

Consider what geometry's primitives actually are:

- A **point** has zero dimensions. Nothing physical has zero dimensions.
- A **line** has zero width and infinite length. Nothing physical has either.
- A **circle** is the locus of points exactly equidistant from a centre, to infinite precision. Nothing physical is exact to infinite precision.
- A **plane** is perfectly flat and unbounded. Nothing physical is flat below the atomic scale.

So geometry is not a description of physical space. **It is a system of idealized objects that physical space approximates well enough to be useful.** A pencil dot approximates a point. A taut string approximates a line. The theorems transfer to the world exactly as far as the approximation holds, and no further. (The vault's [Geometry Test](../../../notes/godel-against-himself.md) uses this against Platonism; here it is doing different work.)

Nobody finds this troubling, and nobody says "the pencil dot proves geometry is false." The relationship between idealization and instance is understood, accepted, and unremarkable.

### Now Say The Same Thing About Logic

Classical logic's primitive is the **proposition**: an item bearing exactly one determinate truth value, context-independent, unambiguous, with sharp application conditions.

Nothing anybody ever says is one of those.

| | Geometry | Logic |
|---|---|---|
| **Idealized primitive** | point: zero extension | proposition: exactly one determinate, context-free truth value |
| **Physical instance** | pencil dot, taut string | a sentence uttered by a person |
| **The gap** | nothing has zero width | no sentence has one determinate context-free truth value |
| **Sources of the gap** | thickness, granularity, measurement error | ambiguity, homonymy, vagueness, indexicals, scope, tense, future contingents, speaker intent |
| **What bridges it** | measurement and tolerance | interpretation and judgment |
| **Where it works** | superbly, at human scale | superbly, for most arguments |
| **Where it breaks** | strong gravity, cosmological scale | vague predicates, unsettled futures, self-reference, translation across languages |

This is what the "loose connection between language and propositions" *is*. It is not a quirk of sloppy speech to be tidied up. **It is the same category of gap as the one between a pencil dot and a point** — the unavoidable distance between an idealized formal object and the physical situations it models. The [Translation Problem](./the-translation-problem.md) catalogues the specific failures; this page names what kind of thing they are.

And it makes the pre-logical layer respectable rather than merely awkward. Measurement is not a defect of geometry; it is the discipline that connects geometry to the world, and engineers who ignore tolerances kill people. Interpretation is not a defect of logic; it is the discipline that connects logic to the world, and debaters who ignore it argue past each other all night.

### The Dilemma This Creates

Here is why the second lesson is not a side note. Put the two halves together and the absoluteness claim has to choose:

**Either logic is an idealization that reality approximates** — in which case it is a human construction of exactly the kind geometry is, its objects do not exist in nature, and the interesting question is how good the approximation is in a given domain. That is the vault's position, and it needs no divine ground, any more than Euclid's postulates do.

**Or logic is a set of absolute laws that reality obeys** — in which case vague predicates, unsettled futures, and the permutation-invariance of identical particles are not approximation gaps. They are **counterexamples**, and they have to be answered rather than tolerated.

The absoluteness claim habitually takes the first horn to explain away the hard cases ("of course natural language is loose, that's not logic's fault") and the second horn to reach God ("the laws are universal, invariant, immaterial"). **Those are different claims and they are not compatible.** The looseness is either logic's problem or reality's. Pick one.

> A law that reality obeys has no need of tolerances. A system with tolerances is not a law reality obeys.

## The Strongest Reply: "There's Still Underlying Truth"

Expect this, because it is the best defence of the absoluteness claim available and it is not a dodge:

> *"Even if we get the language wrong, there is still an underlying truth, and it's driven by logic. Our sloppiness in encoding a proposition doesn't touch the proposition, or the logical relations it stands in. You've found a flaw in **us**, not in logic."*

**Concede the true part immediately, and concede it generously**, because the page overclaims if it doesn't: **the translation problem does not show that logic is invalid.** Every inference rule still holds. Nobody's misuse of the word "bat" refutes modus ponens. If the argument is heard as "language is vague, therefore logic is broken," it deserves to lose.

What the reply does is take a specific, expensive position. Read what it commits him to: **a determinate realm of propositions**, each with a determinate truth value, standing in determinate logical relations, existing independently of any language that expresses them. That is propositional realism — and it has to be paid for.

### It confuses a blurry photograph with an indeterminate scene

The reply models the gap as **encoding noise**: reality is sharp, our words are a lossy channel, clean up the channel and the sharpness is recovered. That is exactly right for *ambiguity*. "She saw a bat" really does express one of two perfectly sharp propositions, and context picks it out. Noise, recoverable.

But the hard cases are not noise. **They are cases where there is no sharp scene to photograph**, and a noiseless channel does not help when the source itself is indeterminate:

- **Vagueness.** Which sharp proposition does "Chris is tall" express? If a determinate one, **name the centimetre.** There is no answer, and the absence is not a fact about English — translate it into any language, or into pure predicate logic, and the boundary is still missing. **Vagueness is a property of the concept, not of the word.** You cannot fix it by moving upstream to propositions, because the concept travelled with you.
- **Future contingents.** "There will be a sea battle tomorrow." The looseness is not in the sentence — the sentence is perfectly clear. What is missing is a fact for it to correspond to.
- **Mathematical independence.** The Continuum Hypothesis is stated with total precision, in a formal language, with no linguistic slack whatever. Whether it has a truth value is still disputed by the people best placed to know.

So the reply must either accept that some propositions lack determinate truth values — which is the concession — or insist that all three cases secretly have sharp answers nobody can access. That second option is **epistemicism**, and taken across the board it is a very large bill: an unknowable precise boundary for every vague predicate in every language, a settled fact about every unmade choice, and a determinate answer to CH. None of that is a claim about language. It is a claim about reality, offered without evidence, to protect a rule.

### He has just chosen a horn — and given up the excuse

This is the part worth having ready, because it is structural rather than a matter of intuition.

"There is still underlying truth driven by logic" is the **second horn** of the dilemma above: logic as a law reality obeys, not an idealization reality approximates. He is entitled to that horn. But taking it costs him the move he was using two minutes earlier:

> **He can no longer explain away the hard cases as "language being loose."** Vagueness, unsettled futures, and independent propositions are no longer tolerable approximation gaps between an ideal system and a messy world. On the horn he just chose, they are **counterexamples to a law** — and they have to be answered, not excused.

The absoluteness claim needs both horns and it can only stand on one. It uses *"logic is an idealization, of course reality is messier"* to absorb every awkward case, and *"logic is universal, invariant, immaterial"* to reach God. Once you make the choice explicit, one of those two sentences has to go.

### And the realm itself needs the accounting he demands of others

The last move is his own criterion, applied where he is now standing. He cannot exhibit a single language-independent proposition — every one he can point at arrives dressed in a sentence, in some language, including the formal ones. The determinate realm is *posited* to protect the rule, then the rule is used to prove the realm's ground.

So: **what accounts for the determinacy?** If the answer is God, then the argument's engine has become its own conclusion, and we are at the circle presuppositionalism openly accepts. That is not a knockdown — but it is parity, and parity is fatal to an argument whose distinctive claim was that *only* theism can account for its preconditions. See [The Consistency Defeater](./the-consistency-defeater.md), Reply A.

> **Note the pattern, because it is the most useful thing on this page.** Every strong reply available to him — "consistency is guaranteed by God's nature," "the underlying propositions are determinate," "the deep structure all logics converge on is what needs grounding" — funnels into the same place: *God grounds it.* That answer is coherent and he will not be embarrassed by it. But once **every** road leads there, the argument has stopped being a proof and become a statement of the commitment it started from. The work is then to show the road is open to everyone, not to close it.

### What actually survives, stated precisely

Not "logic is wrong." This:

> Logic is a formalism over idealized objects. Getting from the world to those objects is an interpretive act that logic cannot perform and does not govern. Therefore logic does not *directly* describe reality — it describes reality **as we have rendered it**, and the rendering is ours.

That is a limit on premise 1's reach, not on logic's validity. Premise 1 needs the laws to be absolute features of reality itself. What the idealization argument shows is that they are absolute features of *a system we built to model reality* — which is exactly the status of Euclid's postulates, and exactly as much divine grounding as those require.

## Which Geometry Is God's?

The theological form of the question is worth stating, because it is the same question as *which logic is God's* and it is much harder to wriggle out of when it is about geometry.

If Euclidean geometry were divinely grounded — universal, invariant, immaterial, the very structure of the divine mind — then God built a universe that does not satisfy it. Spacetime is curved. The available replies map one-to-one onto the replies about logic:

- **"Euclidean geometry isn't really absolute, only some deeper geometry is."** Then self-evidence was never a guide to absoluteness, and the confident intuition that carried P5 for two thousand years was worthless as evidence. Why trust the same intuition about excluded middle?
- **"God grounds all the geometries."** Then "absolute" names a family of mutually inconsistent axiom sets, and the word has stopped doing any work.
- **"Geometry isn't the sort of thing that needs grounding."** Agreed — and it is the same sort of thing as logic.

## Open Questions

1. **How far does the idealization parallel actually run?** Geometry has a mature theory of *how* physical instances approximate ideal objects: measurement, tolerance, error bars. Logic has nothing comparable for how sentences approximate propositions — fuzzy logic and probability each capture a fragment. Is a general theory of translation-tolerance possible, or is judgment irreducible? Connects to [The Translation Problem](./the-translation-problem.md) Open Question 1 (Montague grammar).
2. **Is there a Beltrami model for the non-classical logics?** Relative-consistency models were what made non-Euclidean geometry undeniable rather than merely unrefuted. Intuitionistic logic has Kripke semantics and Heyting algebras, which do this job — is the parallel exact enough to use rhetorically, or does it require too much machinery to land?
3. **Did the two-thousand-year gap have a cause?** P5 was doubted from antiquity, yet the break took until 1829. Was the obstacle notational, institutional, or the sheer authority of *Elements* as the model of certain knowledge? Bears on the same question about logic — Nagarjuna had four-valued logic in 150 AD and the West took until the 20th century (see [Eastern Logical Traditions](./eastern-logic.md), Open Question 1).
4. **Was Kant wrong, or wrongly scoped?** A sympathetic reading: he correctly described the geometry *built into human spatial cognition*, and mistook a fact about cognition for a fact about space. If that reading holds, it is the strongest available steelman for the absoluteness claim about logic — the three laws as constitutive of human reasoning rather than of reality — and the reply is different from the one this page gives. See [The Absoluteness Claim](./the-absoluteness-claim.md) Open Question 2.

## Tags
[philosophy](../../../tags/philosophy.md), [logic](../../../tags/logic.md), [mathematics](../../../tags/mathematics.md), [epistemology](../../../tags/epistemology.md)
