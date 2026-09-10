---
status: active
created: 2026-09-10
published: true
layout: layouts/page.njk
title: "The Consistency Defeater"
---
# The Consistency Defeater
> Never claim his system is inconsistent — he's right to reject that. Claim something he can't reject: a proof of God is worth exactly your confidence that the system never contradicts itself, and that confidence is the one thing the system cannot supply about itself. His own criterion then convicts his own argument.

**Links:** [The Absoluteness Claim](./the-absoluteness-claim.md), [Gödel's Incompleteness](./godel-incompleteness.md), [Non-Classical Logics](./non-classical-logics.md), [Formal Systems and Approximation](./formal-systems-and-approximation.md), [Gödel Against Himself](../../../notes/godel-against-himself.md), [TAG Debate — Nicks vs Allen](../../debates/god-precondition-knowledge-nicks-allen.md), [The Regress Problem](../epistemology/the-regress-problem.md), [The SQL Argument](./the-sql-argument.md), [Theorems With Absurd Readings](./theorems-with-absurd-readings.md), [Logics In Production](./logics-in-production.md), [Malpass vs Dyer 2019](../../debates/malpass-dyer-tag-logic.md), [The Parity Move](../epistemology/the-parity-move.md)

---

## The Objection This Page Exists To Answer

The move looks like this: classical logic explodes — from any contradiction, everything follows — so a proof of God is only informative if the system is consistent, and consistency can't be established from inside. Therefore the proof rests on an ungrounded assumption.

And the immediate reply from the other side is correct:

> *"I can prove God from within my system. You're just assuming it's inconsistent — with no argument at all."*

He is right, and if that is what you were arguing you have lost. **You cannot show his system is inconsistent, you have no reason to think it is, and asserting it is exactly the kind of unsupported claim the whole method here is built to avoid.** Nobody has ever found a contradiction in classical logic, and the working assumption of every mathematician alive is that there isn't one.

So the argument has to be built somewhere else. This page builds it, in a form that never asserts inconsistency and never requires the audience to follow a mathematical proof.

## Step 1: What Explosion Actually Establishes

The relevant fact about classical logic (*ex falso quodlibet*):

```
1. P            (assumed)
2. ¬P           (assumed)
3. P ∨ Q        (from 1, disjunction introduction)
4. Q            (from 2 and 3, disjunctive syllogism)
```

Q is unrestricted. Any sentence whatsoever. "God exists." Also "God does not exist." Also "the moon is made of cheese."

Read what that means for the *value* of a proof rather than for its validity:

> **In a classical system, "X is provable here" carries information about X only on the condition that the system is consistent.** In an inconsistent system every sentence is provable, so provability tells you nothing about any particular sentence.

This is not an accusation. It is a fact about what proofs are worth, and it applies identically to every classical system including the vault's own reasoning. Nobody has to concede anything embarrassing to accept it. **State it as neutral bookkeeping, because it is.**

## Step 2: The Printing Machine

The argument from here needs no arithmetic, no self-reference, and no Gödel. It is a machine and four questions, and it can be run on any audience.

> ### ⚠ Say what the machine is before you start
>
> **The machine is not God. The machine is his argument.**
>
> This must be stated explicitly and first, because otherwise the analogy gets heard as "God is a printer" and rejected on sight — reasonably, since a mechanical dispenser of truths is a caricature of anybody's theology. Nobody is going to sit still for it.
>
> What the machine stands for is the **derivation**: the axioms, plus the inference rules, plus the steps that end in *"therefore God exists."* TAG is a deductive argument — he supplied the premises and he supplied the rules. The printer is that apparatus, not its conclusion and not its subject.
>
> **If the misreading happens anyway, switch analogies rather than arguing about it.** Use a **pocket calculator**: you type in a sum, it displays 7. Does it ever give two different answers to the same sum? If it does, its displaying 7 tells you nothing. Can it verify itself — is there a button for "are you accurate"? No. You need a *second* calculator, and then that one needs checking. Nobody has ever mistaken a calculator for God, and the mapping to "formal system" is immediate because a calculator is *obviously a tool* — which is the vault's thesis about logic anyway.

**Imagine a machine that prints sentences. It has just printed "God exists."**

**Question 1 — Does that settle it?** Only if the machine is trustworthy. Obviously.

**Question 2 — What would make it untrustworthy?** If it ever printed both a sentence and its denial. Because of explosion, a machine that does that once will eventually print *every* sentence — including "God does not exist." A machine that prints everything has told you nothing by printing this.

So: **the proof is worth exactly your confidence that the machine never contradicts itself.** Not more.

**Question 3 — Can the machine certify itself?** Ask it: "are you reliable?" It prints: **"Yes, I am reliable."**

That is worthless, and everyone can see why without being told. A broken machine prints "yes" too — in fact a broken machine prints "yes" *and* "no," and prints them with the same authority it printed "God exists." **The self-certification is uninformative precisely in the case where you needed it.**

**Question 4 — So who certifies it?** You need a second machine, more trusted than the first, to vouch for it. And then the question is about the second machine. And the third.

> That is the whole content of Gödel's second theorem, with no mathematics in it. A system strong enough to be interesting cannot vouch for its own consistency; it can only be vouched for from outside, by something that then needs vouching for.

The regress is the point, and note where it sits: **not at the conclusion of his argument, but inside the machinery that produced it.**

### The objection to expect — and why it's a door, not a wall

Even with the framing above, the likeliest response is a version of *"a broken printer would be a false god — mine isn't broken, because God isn't the sort of thing that malfunctions."* It arrives as a quip and it is doing real work, so treat it seriously.

Notice what it actually says: **consistency is guaranteed by the nature of the thing being argued for.** That is not a rebuttal of Step 2 — it is an answer to Question 4 ("who certifies the machine?"), and the answer given is *God does, by being God.*

Which means the objection has walked straight into **[Reply A](#reply-a--god-grounds-consistency-god-is-self-attesting)** and should be handled there, not resisted here. Three things follow, and they are worth having ready:

1. **It concedes the structure of the argument.** He is no longer claiming consistency is *shown*; he is claiming it is *underwritten* — by a theological premise. Fine. But the proof of God now has a premise about God in the machinery that produces it. That is the circle, and he will not deny it, because presuppositionalism affirms it.
2. **It relocates the burden without discharging it.** "God's reasoning cannot be inconsistent" may well be true. It is not something he can establish from inside the system whose reliability is in question — which is the whole point of Question 3. The machine still printed "yes."
3. **It abandons the argument's distinctive claim.** Everyone gets to have an ungrounded foundation now. See Reply A for why parity is fatal to a uniqueness claim.

**Do not defend the analogy.** If he attacks the printer, switch to the calculator and re-ask Question 3. The analogy is disposable; the four questions are not.

## Step 3: The Actual Argument Is Parity, Not Inconsistency

Now the move that cannot be answered by "you're just assuming inconsistency," because it never mentions inconsistency.

The transcendental argument's whole engine is a **demand**:

> *You cannot account for the preconditions of your own reasoning. Therefore your reasoning is unjustified. I can account for them — God. Therefore only my position is justified.*

The demand is applied relentlessly, and the demand is the argument. So apply it once, symmetrically, at the one place it bites:

**Consistency is a precondition of his proof.** Without it his proof carries no information (Step 1). He cannot account for it from within his system — not through carelessness but because nothing strong enough to state his argument can (Step 2). If he accounts for it from a stronger system, that system needs the same accounting, and so on.

> **By his own criterion, his proof of God is unjustified.**

This is not a claim that he is wrong. It is not a claim that his system is inconsistent. It is a claim about **the symmetry of his own standard** — and it is unanswerable in the terms he set, because the only way out is to weaken the standard, which is the thing doing all the work.

The vault already runs this shape elsewhere: the boomerang against Eli in [Nicks vs Allen](../../debates/god-precondition-knowledge-nicks-allen.md) ("if pragmatic justification is insufficient for regularity, it's insufficient for your belief in God"), and the general principle that [every worldview hits Gödel or Agrippa](../epistemology/the-regress-problem.md). What is new here is the *location*: previous versions applied the parity test to his conclusion. **This applies it to his inference engine**, which is the one place he has claimed immunity.

## Step 4: His Three Replies, And What Each Costs

He has exactly three moves. Know all of them in advance.

### Reply A — "God grounds consistency. God is self-attesting."

The most likely reply, and the most honest one, because presuppositional apologetics **openly accepts circularity** — the doctrine is that ultimate commitments are necessarily circular and the Christian one is vindicated by "the impossibility of the contrary." He will not be embarrassed by the circle. Do not attack the circle.

Attack what accepting it costs:

> If circularity at the foundation is acceptable when you do it, it is acceptable when the naturalist does it. Your argument's distinctive claim was never "everyone has an unproved starting point" — that's uncontroversial. It was **"only theism can account for its preconditions."** The moment you grant yourself a self-attesting foundation, you have the same structure as the position you're refuting, one level up. **Parity is a loss for a uniqueness claim.**

Then close the door on the retreat: "the impossibility of the contrary" is not available here, because contrary systems *exist and are consistent*. Intuitionistic logic, paraconsistent logic, and three-valued logic are all built and running (see [The Absoluteness Claim](./the-absoluteness-claim.md), Tier 4). The contrary is not impossible. It is deployed.

### Reply B — "You're just asserting my system is inconsistent."

Answer plainly, because you aren't:

> "I've asserted nothing of the kind, and I don't believe it. I think classical logic is consistent. What I've said is that your *proof's informational value* is conditional on consistency, and that this condition is one you cannot discharge from inside. A bank asking whose account a cheque is drawn on isn't alleging forgery. I'm asking what backs the instrument."

Then hand the burden back where it belongs: **he is the one who introduced an absoluteness claim.** The default position — logic is a superbly reliable tool whose foundations rest on assumptions we cannot prove — requires no defence. His position requires that the foundations be *absolute*, and the consistency gap is a hole in exactly that claim, not in the tool.

### Reply C — "Gödel applies to arithmetic, not to logic."

The strongest reply, usually the sign of a well-prepared opponent, and it demands an honest technical answer because it is **partly right.**

The honest facts:

- **Pure first-order predicate logic is consistent, and provably so.** It is also *complete* — Gödel's **completeness** theorem (1929), a different result routinely confused with incompleteness. Nothing in the incompleteness theorems threatens pure logic.
- **The incompleteness theorems bite on any consistent, effectively axiomatized theory strong enough to encode arithmetic** — Peano arithmetic, or far weaker fragments. Such a theory cannot prove its own consistency.

So the question is which of those his system is. And that fork is a trap with no good exit:

> **Retreat to pure logic, and the "absolute laws" are tautologies** — formulas true in every model, which is what validity means. A tautology asserts nothing about the world; it is true no matter how the world is. There is nothing there to need a divine ground, and the argument has no content left to run on. This is the [Law-of-Identity-is-a-tautology](./the-absoluteness-claim.md) point arriving from the other direction.
>
> **Advance to anything substantive** — arithmetic, set theory, quantification over concepts, minds, universals and their grounding relations, which is what TAG's premises actually require — **and Gödel 2 applies.** Consistency becomes unprovable from inside, and Step 3 runs.

**There is no position that is both substantive enough to be worth grounding and weak enough to escape incompleteness.** The escape from Gödel is the escape from significance.

That is the deepest form of the argument, and it is worth holding in reserve for exactly this reply. Most opponents never reach it. A trained logician will — which is why the [Malpass debate (2019-05-22)](./the-absoluteness-claim.md) is the source worth reviewing before deploying this.

## Step 5: Delivering It

The failure mode is technical drift. Nobody is persuaded by theorem numbers. Sequence:

1. **Concede consistency up front.** "I think your system is consistent. I'm not arguing it isn't." This removes his best reply before he reaches for it and costs nothing.
2. **Run the machine.** Four questions, ninety seconds, no jargon. Let the audience get to "a broken machine also says yes" on their own — they will, and it is much stronger arriving that way.
3. **Apply his own standard.** "You've asked me all night to account for my preconditions. Consistency is a precondition of your proof. Account for it."
4. **Name what happens next, before he does it.** "You'll say God grounds it. Then we're both resting on something unproved, and your argument was that only you don't have to."
5. **Only if pressed, go to Reply C.** And go there precisely: completeness is not incompleteness, and the fork is substantive-or-safe, never both.
6. **Never say the words "Gödel proved logic is inconsistent."** He doesn't, it's the commonest misstatement of the theorem, and saying it forfeits the exchange to anyone who knows better. See [Gödel Against Himself](../../../notes/godel-against-himself.md).

And keep the frame: **this is not a proof that God doesn't exist, and it should never be presented as one.** It is a demonstration that *this argument* cannot deliver what it claims — that the tool being used to prove God rests on a commitment of the same kind it says only God can supply. Gödel himself was a theist who built an ontological proof; the theorems are not atheology. The vault's own author is a theist. The target is the argument's claim to uniqueness, not its conclusion.

## Why This Is The Crux

Everything else in [The Absoluteness Claim](./the-absoluteness-claim.md) attacks premise 1 from the outside — showing logic is plural, built, domain-scoped, revised. Those arguments are more accessible and should lead.

But they leave one line of retreat: *"fine, there are many logics, and the one true absolute logic is the one God grounds; the others are defective."* This page closes that retreat, because it applies **inside whichever system he picks.** Whatever he nominates as the absolute logic, if it is strong enough to state his argument, it cannot vouch for itself — and his own criterion then demands an accounting he cannot give.

Outside arguments show the laws aren't singular. This one shows that *no* choice of singular laws rescues the argument. That is why it is worth the extra work to make it land.

## Open Questions

1. **Does the substantive-or-safe fork survive a real logician?** The claim is that TAG's premises require arithmetic-or-stronger expressive power. That is plausible — grounding relations over universals look at least second-order — but it has not been shown rigorously here. Could TAG be formalized in a decidable fragment (some modal logic) that escapes Gödel while remaining substantive? If so the fork needs repair. **This is the page's weakest joint and the first thing to check against the Malpass debate.**
2. **Is Reply A's parity conclusion too generous?** The page concedes that presuppositionalism can accept circularity and then argues parity. A stronger line may exist: that self-attesting foundations are not all equal, and some circles are virtuous (constitutive) while others are vicious. The vault's [regress page](../epistemology/the-regress-problem.md) argues logic's axioms are *constitutive of reasoning* rather than assumed — if that's right, the naturalist's circle may be better than parity, not merely equal. Worth developing; it would convert a draw into a win.
3. **How does this interact with paraconsistent logic?** In a paraconsistent system explosion is blocked, so inconsistency does not trivialize the system and Step 1 fails. Does that make paraconsistency a *defence* of the argument (a proof of God survives local contradiction) or a deeper problem (the opponent must now choose a non-classical logic to save an argument premised on classical logic being absolute)? The second seems right and would be a nice trap, but it needs working out.
4. **Is the printing machine too lossy?** It conveys Gödel 2's *upshot* while eliding the mechanism (arithmetization, self-reference). An opponent who knows the theorem could accuse it of proving nothing. Is that a fair charge, and does the analogy need a mechanism component to survive scrutiny — without reintroducing the strange-loop inaccessibility it was built to avoid?

## Tags
[philosophy](../../../tags/philosophy.md), [logic](../../../tags/logic.md), [epistemology](../../../tags/epistemology.md), [religion](../../../tags/religion.md)
