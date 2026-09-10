---
status: active
created: 2026-09-10
published: true
layout: layouts/page.njk
title: "The SQL Argument"
---
# The SQL Argument
> The most widely deployed logic on Earth has three truth values, `NULL = NULL` is not true, and you can verify it tonight. The opener — plus the epistemic rescue and the one question that makes it cost something.

**Links:** [The Absoluteness Claim](./the-absoluteness-claim.md) — the hub, [Logic and Mathematics](./README.md), [Formal Systems and Approximation](./formal-systems-and-approximation.md), [The Consistency Defeater](./the-consistency-defeater.md), [The Translation Problem](./the-translation-problem.md), [Non-Classical Logics](./non-classical-logics.md), [Quantum Logic](./quantum-logic.md), [Gödel Against Himself](../../../notes/godel-against-himself.md)

---

Tier 1 of the [example set](./the-absoluteness-claim.md#the-example-set). This is the opener — the strongest available, because it comes from the domain audiences most associate with cold hard logic and because it can be demonstrated live on a laptop.

It is also the example with the most sophisticated rebuttal, which is why it gets its own page: the rescue is *correct as far as it goes*, and the whole value of the example lies in what it costs him to give it.

SQL uses three truth values — TRUE, FALSE, and UNKNOWN — and it runs global finance, logistics, and medicine. Anyone with a database can verify all of this in about two minutes:

- `NULL = NULL` returns **UNKNOWN**, not TRUE. The law of identity, declining to hold, in the ANSI standard.
- `WHERE x = 5 OR x <> 5` **does not return every row.** Excluded middle, failing, in a query you can run right now.
- `NOT UNKNOWN` is **UNKNOWN**. Negation stops being an involution.
- And the standard is *internally inconsistent about identity*: `=` says two NULLs are not equal, `GROUP BY` and `DISTINCT` collapse them as though they are, and `UNIQUE` constraints permit several. **Three different identity behaviours for the same value, in one specification.**

Nobody thinks the database is irrational. They think it is **correct** — because "we do not know" is a real state of the world that binary logic has no way to represent.

**The first rescue, and why it concedes:** *"NULL isn't a proposition, it's an epistemic marker — this isn't really logic."* That reply is fair, and it gives the game away. To model a world containing missing information, engineers had to **build a different logic**, standardise it, and teach every programmer alive its counterintuitive rules. The three-valued logic was not a philosophical indulgence. It was the cheapest way to be correct.

This is the strongest opener available, because it comes from the domain the audience most associates with cold hard logic, and because it can be demonstrated live.

## The real rescue: epistemic vs. alethic

The serious version of the reply is worth stating in full, because it is the one a prepared opponent will give:

> *"You use NULL because you don't know something. But everything is in principle knowable. Just because we don't currently know the state doesn't mean it isn't already either true or false. Your UNKNOWN is a fact about your records, not about reality. Excluded middle is a claim about **truth**, not about **knowledge** — and it survives untouched."*

**Concede the distinction immediately, because it's real.** Epistemic indeterminacy (we don't know) is not alethic indeterminacy (there's no fact of the matter). Most NULLs are genuinely the first kind: the customer *has* a phone number, we just failed to record it. That NULL says nothing about bivalence.

Then notice that the rescue smuggled in a premise doing enormous work: **"everything is in principle knowable"** — that every proposition already has a determinate truth value now, whether or not anyone can access it. That is not a neutral background assumption. It is a substantive metaphysical thesis, and it has to be argued for. Three places it comes under pressure, in ascending order of how hard it is to escape:

**1. Future contingents — the one that bites.**

> *"So what you're going to have for breakfast next Tuesday — that's knowable now?"*

Obviously not. And the opponent's rescue requires him to say it *is* — that "Chris eats eggs next Tuesday" already has a determinate truth value today, fixed, merely inaccessible. This is **Aristotle's sea battle** (*De Interpretatione* 9) with a schema attached: NULL is the database's sea battle. Aristotle flagged the problem himself, and Łukasiewicz built three-valued logic in 1920 on exactly this reading. The two available answers both cost something:

| | The claim | What it costs |
|---|---|---|
| **Bivalence holds** | Next Tuesday's breakfast is already true-or-false, just unknown | Future free choices are settled before they're made → **theological determinism**. Hard to combine with libertarian free will, moral responsibility, and the free-will theodicy that answers the problem of evil |
| **Bivalence fails** | Undetermined futures have no determinate truth value yet | **Excluded middle is not absolute** — which is the thing being defended |

**This fork is the point, and against a presuppositionalist it is unusually sharp**, because free will is not a side commitment for him — it is load-bearing theology. He has to pick, and both horns are his problem rather than yours.

*Honesty flag:* there are sophisticated escapes, and you should name them before he does. Boethius (God sees all of time timelessly, so foreknowledge isn't causal), Ockhamism (soft facts about the future), and Molinism (middle knowledge of counterfactuals of creaturely freedom) all try to hold foreknowledge and freedom together. Two things to note about them: each was invented *precisely because* the naive combination doesn't work, which concedes the problem is real; and the Boethian answer in particular relativizes the truth-value to a **timeless** vantage — which means it is *not* knowable in principle by any agent inside time. The premise "everything is in principle knowable" does not survive that answer either.

**2. Mathematical independence — no theology, no physics.** Is the Continuum Hypothesis true? It is *provably* neither provable nor refutable from ZFC. A Platonist says it has a determinate truth value we cannot reach; a formalist says there is no fact of the matter. **That dispute is live among working mathematicians**, which means "every proposition has a determinate truth value" is a contested position in the one field that ought to be its home turf. It is Platonism, and Platonism needs defending — see [Gödel Against Himself](../../../notes/godel-against-himself.md), where the vault argues against it while conceding Gödel held it.

**3. Physical indeterminacy — supporting only, and flagged soft.** Standard quantum mechanics says a measurement outcome on a superposed state is not merely unknown but undetermined, and the Bell and Kochen–Specker results constrain the hidden-variable escapes severely. This is real physics, but the *philosophical* reading is disputed and deterministic interpretations exist (Bohmian mechanics, many-worlds). **Use it as corroboration, never as the load-bearing step** — see [Soft Tier](./the-absoluteness-claim.md#soft-tier-real-but-contested) below.

**Where this leaves the example.** The opponent is right that most NULLs are epistemic. But to keep excluded middle *absolute* he must defend "everything is in principle knowable" across all three cases — and the first one asks him to trade away free will. The SQL demo gets him to state the premise out loud; the breakfast question shows what it costs.

## Open Questions

1. **Does the example survive a determined logician?** The "NULL isn't a proposition" rescue is stronger than it first appears. Is three-valued SQL genuinely a logic, or bookkeeping over a classical substrate? Kleene's strong three-valued logic is a real system and SQL's `AND`/`OR`/`NOT` tables match it — but SQL's *inconsistent identity behaviour* (`=` vs `GROUP BY` vs `UNIQUE`) may indicate engineering compromise rather than a coherent alternative logic. Worth deciding, because it changes whether this leads or supports.
2. **Is the free-will fork actually binding?** The breakfast question assumes libertarian free will is held strongly enough that theological determinism is a real cost. Orthodox theology has resources (the Boethian timeless vantage; a synergy account of grace and will). Check his stated position before deploying — the fork is only sharp if the horn hurts.
3. **Is there a cleaner everyday case of alethic indeterminacy?** Future contingents work but invite theology. Mathematical independence works but needs set theory. Is there a mundane third case — something in law, measurement, or institutional fact — where there is demonstrably no fact of the matter yet, with nothing metaphysical to argue about?

## Tags
[philosophy](../../../tags/philosophy.md), [logic](../../../tags/logic.md), [epistemology](../../../tags/epistemology.md)
