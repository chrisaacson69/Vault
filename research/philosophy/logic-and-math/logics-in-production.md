---
status: active
created: 2026-09-10
published: true
layout: layouts/page.njk
title: "Logics In Production"
---
# Logics In Production
> Rival consistent logics are not thought experiments — they verify safety-critical code, drive subways, and were built by independent civilizations. If you can ship another one, the laws are a design choice.

**Links:** [The Absoluteness Claim](./the-absoluteness-claim.md) — the hub, [Logic and Mathematics](./README.md), [Formal Systems and Approximation](./formal-systems-and-approximation.md), [The Consistency Defeater](./the-consistency-defeater.md), [The Translation Problem](./the-translation-problem.md), [Intuitionistic Logic](./intuitionistic-logic.md), [Non-Classical Logics](./non-classical-logics.md), [Eastern Logical Traditions](./eastern-logic.md), [Malpass vs Dyer 2019](../../debates/malpass-dyer-tag-logic.md)

---

Tier 4 of the [example set](./the-absoluteness-claim.md#the-example-set). This is the tier that kills **"singular"** — the quiet word premise 1 needs most, and the one nobody defends because nobody notices it is doing work.

Ordered by how well each survives a determined opponent. **4A is much stronger than the rest and should carry the tier**; 4B is included with its own refutation attached, because overclaiming it is the likeliest way to lose an exchange here.

Ordered by how well each survives a determined opponent. The first is much stronger than the others and should carry the tier.

## 4A — Proof assistants: excluded middle as an optional axiom (strongest)

Coq and Lean are the machines that verify safety-critical software and major theorems. Their kernels are **constructive**: excluded middle is not built in. It ships as an axiom you must explicitly invoke — `classic` in Coq's `Classical` module, `Classical.em` in Lean. **A law of logic, sitting in a library, as an opt-in import.** You can check this in five minutes.

That could be dismissed as bookkeeping if the choice made no difference. It makes a precise, provable difference:

- **Intuitionistic systems have the *existence property*: if you can prove `∃x P(x)`, then there is a specific term `t` you can exhibit with `P(t)`.** Classical systems do not have it. Same for the *disjunction property* (prove `A ∨ B` and you can say which).
- Via **Curry–Howard**, a constructive proof of `∃x P(x)` literally *is* a pair — the witness and a proof about it — so it compiles to a program that produces the answer. Coq extracts running OCaml from such proofs. **A proof that leans on the `classic` axiom cannot be extracted to executable code**; extraction hits the axiom and stops. This is not philosophy. It is a build failure.

**The one-line demonstration.** Classical logic proves *there exist irrational numbers `a`, `b` with `a^b` rational* like this: consider `√2^√2`. Either it is rational — then take `a = b = √2` — or it is irrational, in which case take `a = √2^√2` and `b = √2`, giving `a^b = √2^2 = 2`. Done.

Notice what just happened. **We proved such a pair exists without determining which pair it is.** The proof case-splits on a proposition it never decides. Excluded middle handed us an existence claim with no witness attached, and that is exactly what the constructivist declines to accept — not out of scepticism, but because for his purposes an existence claim you can't cash is worthless.

**Why this survives where the others don't:** there is no approximation anywhere in it. Nobody can say "that's just an engineering convenience over an underlying classical truth," because the difference is a *theorem about what the systems can produce*, and the consequence is mechanical — code extracts or it doesn't.

**Honesty flag.** Constructive mathematics is *weaker*: you lose real theorems, which is why Lean's Mathlib is classical throughout and most mathematicians work classically. So never argue "constructive is correct." Argue the thing that's actually true and actually fatal to premise 1: **the choice is real, consequential, and made per purpose — by the most rigorous people alive, for reasons of what they need to get out the other end.** That is a design decision, not a discovered absolute. See [Intuitionistic Logic](./intuitionistic-logic.md).

## 4B — Fuzzy control: weaker than it looks, and here's the walk-through

The Sendai subway, ABS, autofocus, washing machines. The tempting claim is "engineers dropped bivalence and got better machines." The objection that must be answered first: *ABS being inexact doesn't make it illogical — the wheel either is or isn't slipping, and you use degrees only because your sensors are imprecise.* **That is the sorites/epistemicism rescue wearing an engineering hat**, and if it stands, the example proves nothing. Step by step:

**Step 1 — Build the crisp controller.** Define slipping as slip ratio λ > 0.2. Rule: if λ > 0.2, release the brake; otherwise hold full pressure. Pure bivalence, one sharp threshold.

**Step 2 — Give it perfect information.** Stipulate a noise-free sensor reporting λ exactly. The epistemic rescue is now unavailable by construction: we are uncertain about nothing.

**Step 3 — Watch it fail anyway.** Near the threshold it chatters. λ = 0.201 → release → λ falls to 0.199 → full pressure → λ rises → release. A limit cycle at the boundary, oscillating indefinitely. This is a standard, named control pathology, and it is happening **with perfect information.** So the failure is not epistemic.

**Step 4 — Diagnose it.** The problem was never that we don't know λ. It is that the *correct braking force is a continuous function of λ*, and a binary predicate can only encode a step function. **The information is lost at the predicate, not at the sensor.**

**Step 5 — See what the fuzzy controller actually does.** "Slip is high" has degree 0.55 at λ = 0.21. Several rules fire *simultaneously and partially* — "if slip is high, release a lot" at 0.55, "if slip is medium, release a little" at 0.45 — and their outputs are blended. At no point does the system compute "slipping: TRUE." The degree is not a placeholder for a hidden binary fact; **it is multiplied into the output.**

**Step 6 — The decisive test.** If degrees were merely epistemic hedging, then with perfect information the fuzzy controller should collapse onto the crisp one. **It doesn't** — it stays smooth and stays better. The degrees survive perfect information. That is Zadeh's distinction: **vagueness** (the boundary is genuinely undefined) rather than **uncertainty** (the boundary exists and we don't know it). It does not revert to sorites, because sorites-epistemicism is a claim about ignorance and we removed all ignorance in Step 2.

**Step 7 — Now the caveat that costs the example its rank.** A competent opponent replies:

> *"Fine. You've shown a binary predicate is the wrong tool for a continuous control law. But the fix is a real-valued function, and real-valued functions are perfectly classical mathematics. PID controllers do exactly this and contain no fuzzy logic whatever. You've refuted step functions, not classical logic."*

**That reply is correct, and it must be conceded.** Classical mathematics handles continuity fine. Fuzzy control is not a counterexample to the three laws.

**Step 8 — What genuinely survives.** This: when engineers had to turn a **vague human predicate** — "slip is high," stated in words by an expert driver — into machinery, they could not do it with true/false. They had to grade the predicate, and the grading survives perfect information. So fuzzy control is evidence about **vague predicates in natural language**, which makes it evidence about *Surface A, the translation layer*, not about the failure of classical logic. It is the [Translation Problem](./the-translation-problem.md) with a factory attached.

**Deploy it accordingly** — as a demonstration that the gap between language and propositions is real enough to have an industry, not as a refutation of excluded middle. Overclaim it and you get Step 7 read back to you.

## 4C — Independent civilizations

Nagarjuna's catuskoti (c. 150 AD, four truth values) and Jain syadvada (seven) reached paraconsistency and rejected bivalence roughly 1,800 years before the West, motivated by Buddhist and Jain philosophy with no contact with Greek logic. See [Eastern Logical Traditions](./eastern-logic.md).

The force here is a dilemma about *divine implantation*: if God wrote the laws on every heart, **which civilization got the correct implant?** Greeks two values, Indians four, Jains seven. If the answer is "the deep structure they all converge on," that is the vault's own convergence position — and it is evidence of multiple observers modelling one reality, not of one source broadcasting one message. (Handle with care: convergence is also the opponent's best line of retreat. See Open Question 2.)

## Cut from this tier: multi-level flash

An earlier draft cited TLC/QLC NAND — 8 or 16 voltage levels per cell — as "a sixteen-valued logic in every SSD." **Removing it: it's the base-15 trap in different clothing.** Sixteen voltage levels encode four classical bits; it is a *representation* choice with no change of axioms, and any hardware engineer will say so. Recording it here so it doesn't get reinvented.

## Open Questions

1. **Does 4A need the extraction detail to land, or is that too technical?** "Excluded middle is an optional import" is checkable in five minutes and needs no theory. "Constructive proofs extract to programs and classical ones don't" is the part that makes it *consequential* rather than cosmetic — but it requires Curry–Howard. Is there a shorter route to the consequence?
2. **Is the √2^√2 example the best nonconstructive existence proof for a lay audience?** It is short and airtight, but it needs comfort with irrational exponents. Alternatives: the pigeonhole-style "two people in London with the same number of hairs" (constructive, so no good), or a game-theoretic "a winning strategy exists" (intuitive, but the nonconstructiveness is harder to see).
3. **Which of the fuzzy-control chain is load-bearing?** Steps 1–6 defeat the epistemic rescue; Step 7 concedes the real-valued-function reply. Does the argument still earn its place at Step 8, or should it be demoted to a footnote on [The Translation Problem](./the-translation-problem.md)? Currently kept because the *walk-through itself* teaches the vagueness/uncertainty distinction better than anything else in the set.
4. **Is convergence a liability here?** 4C uses independent civilizations reaching non-classical logics against divine implantation. But convergence on deep structure is also the opponent's best retreat, and the vault's own position. Deploying 4C may open a door — see hub Open Question 2.

## Tags
[philosophy](../../../tags/philosophy.md), [logic](../../../tags/logic.md), [epistemology](../../../tags/epistemology.md)
