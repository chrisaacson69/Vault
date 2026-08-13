---
status: active
created: 2026-08-06
published: true
layout: layouts/page.njk
title: "AI as a Cognitive Tool — Outsource Computation, Never Verification"
---
# AI as a Cognitive Tool
> Offloading a capacity does atrophy it. That establishes a *trade*, not a verdict — and the trade is safe where you keep the ability to check the output. But verification is not a floor: it gets tooled and atrophies too, until the verifier only runs the tool and swaps the part. So the real obligation isn't "never offload verification" — it's **keeping someone in the system who can still tell the verification layer has failed, and rebuild it.**

**Links:** [The Three-Layer Method](./karpathy-three-layer-method.md), [The Cyborg Model](./cyborg-model.md), [Repairing LLM Code](./repairing-llm-code.md), [Planner-LM Composites](./planner-lm-composites.md), [The Weighting Problem](./philosophy/epistemology/weighting-problem.md), [Reading Outcome Statistics](./philosophy/epistemology/reading-outcome-statistics.md)

**Parent:** [The Three-Layer Method](./karpathy-three-layer-method.md)'s rule is *"outsource thinking, not understanding."* This page sharpens it into something operational and says what to do when someone argues the tools are making us stupider.

## The Rule

> ### Outsource computation. Never outsource verification.

The standard worry — **cognitive offloading causes atrophy** — is true and insufficient. The standard reply — **the extended mind means offloading is just relocation** — is true and insufficient. Each is half of the answer, and the missing condition is the same in both cases: *can the user tell when the tool is wrong?*

**That rule is right about where the line falls and wrong that it holds still.** Verification is itself a capacity, so it is subject to the same dynamic it was invoked to solve — see [§ The Rule Is a Frontier, Not a Floor](#the-rule-is-a-frontier-not-a-floor), which is the load-bearing qualification on this whole page. Read the rule as naming *what matters*, not as promising a stable floor.

## Why Verification Carries the Weight

Two jobs, and it is easy to notice only the first:

1. **It makes offloading safe.** A tool you cannot check is a tool whose failures you cannot see. Every argument about hallucination, sycophancy, and error propagation reduces to this: not *the tool is wrong sometimes* — all tools are — but *can the user tell?*
2. **It preserves the skill.** This is the half the atrophy argument misses. Checking the work is not a separate activity from the work; it is the same activity performed in the other direction. Someone in a quantitative field who never computes by hand but constantly sanity-checks magnitudes has not lost arithmetic — the fact-checking **is** the practice, and it is the part that mattered.

So the historian who confirms the book exists and the quote is on the right page is not indulging nostalgia for manual labour. They are running verification, and it is the same act whether the draft came from a card catalogue, a research assistant, or a model.

## The Rule Is a Frontier, Not a Floor

The obvious objection to the rule above is that it exempts verification from its own logic. It shouldn't, and it doesn't survive doing so.

**Verification is a capacity, so it gets offloaded like any other** — onto diagnostic computers, scanners, test suites, linters, CI. And when it does, the verifier's job degrades to a recognisable shape: **run the tool, replace the part.** Nobody wires motherboards any more. Car mechanics rarely go past a surface reading of what the diagnostic says.

The failure mode is specific and worse than not checking at all:

> *Why are my shocks leaking oil? Don't care — just replace them.* And the broken spring that wrecked them goes unseen.

You fix **the symptom the tool reports**. The question the tool wasn't built to ask stops being asked — and because a check *did* occur, the gap is invisible. Unchecked work announces itself; tool-checked work with an unasked question does not.

### What this costs the rule

The page's own [car reductio](#the-car-reductio) turns out to eat it. If atrophy establishes a trade rather than a verdict, that applies to *verification atrophy too* — and mostly we accept the trade, correctly. Not wiring motherboards is fine. Surface-level diagnostics are fine almost always. There is no argument here for hand-verifying everything, which would just be the atrophy argument wearing different clothes.

So **"never outsource verification" is not achievable and not even desirable.** What survives is weaker, and it's a maintenance obligation rather than a prohibition:

> **Verification tooling drifts, misses things, and goes stale. Someone in the system has to be able to notice that and *retool*.**

That is the [mechanic-in-the-system](#the-car-reductio) point applied one level up — to the mechanics themselves. And the shocks example is the warning that this layer has *already* degraded in places: when the diagnostic culture becomes part-swapping, the capacity to ask "but why did it fail?" is the thing that went missing.

### The tell

Since the atrophy is invisible from inside, it needs a signature. The reliable one: **symptom-fixing without cause-finding.** A system where failures get resolved but never explained is one whose verification layer has degraded into tool-execution, regardless of how much checking is nominally happening.

### Worked specimen — this vault

Not hypothetical, and the examples are first-person:

- **Tag counts** were once hand-maintained, drifted, and are now recomputed by `tools/tag-counts.py` from the actual back-links. The standing rule is *never hand-increment; the count is a derived report variable* — verification correctly moved into a tool.
- **The link checker missed URL-encoded paths.** It reported `raw/videos/2026-06-09%20karpathy-….md` as broken because it never decoded `%20`. The file existed. Two links were nearly recorded as defects on the strength of a tool's output — the exact failure above, caught only because the result looked wrong. The fix was to **retool** (decode before testing), not to check links by hand.
- **`raw/` immutability** moved from a request in prose to an enforced `PreToolUse` hook — verification promoted from human discipline to tooling, which is the *right* direction and also creates a new thing that can silently stop working.

Each is the pattern working as intended. The third bullet is also the standing risk: every one of those tools is now a place where a missed check would be invisible.

## The Car Reductio

The move to defeat: *offloading a capacity atrophies it, therefore the offloading is bad.*

The premise is true of the automobile. Cars did atrophy human walking and endurance, measurably and at scale. Nobody concludes we should therefore walk everywhere — because the mobility bought is worth more than the capacity lost.

**Atrophy establishes a trade, not a verdict.** Whoever invokes it still owes the comparison. This kills the pure form of the argument, and it applies to writing (memory), calculators (arithmetic), and every other case where the objection sounds decisive on its own.

It also disposes of the sharpest-sounding version — *"I could ship a program I don't know how to debug."* That is the position of every driver alive. What it argues for is **a mechanic somewhere in the system**, not every driver machining their own pistons. The question is never *does anyone still hold the skill* but *is the skill reachable when the thing breaks*.

**The exception that proves the rule:** the trade is only available to someone who *had* the capacity. A child offloading before the capacity forms isn't trading — there is nothing to trade with, and nothing for verification to run against. That is the real content of the garbage-in-garbage-out worry: the failure is not atrophy of a capacity but **a capacity that never forms**, leaving a user who cannot detect bad output. Sequencing is therefore a genuine design constraint, and it is why calculator access in schooling is **staged by grade level** rather than granted or refused wholesale.

## Wheelchair and Car

Why arguments about "the average user" go in circles: **the same tool is assistive for some users and amplifying for others.**

- A **wheelchair** restores a floor — it gives mobility to someone who had none.
- A **car** raises a ceiling — it gives more to someone who could already walk.

AI is both, and which one it is depends entirely on who is holding it. So "is this tool a crutch?" is malformed. It *is* a crutch, and that is good: crutches are excellent. It is also an engine.

This dissolves a recurring standoff. One side describes the floor rising — for their median user the realistic alternative isn't reading journals, it's talk radio or nothing. The other describes ceiling users who no longer make the climb that would have made them formidable. **Both are looking at real people; they are describing different halves of one distribution, and each argues a point estimate where a distribution is needed.**

Note that the ceiling is not flattened. Capability still compounds — those with more of it extract more from the same tool — so leverage on cognitive ability *increases* rather than levels.

## Productivity, Not Intelligence

Most arguments here ask the wrong question. **These tools change output, not IQ.**

Population intelligence moves on health, nutrition, disease burden, and genetics. It does not move on tool availability. Which produces a diagnostic worth applying to any "technology X will make us smarter" claim:

> **Trace the arrows.** If the causal chain runs *tool → productivity → development → nutrition and disease → cognition*, then the claim is about **material conditions**, and the tool is incidental to the cognitive part. The argument is true and it is not about the tool.

The template for what actually happens is **Excel**. It did not make accountants smarter. It made them enormously more productive, and expertise in the tool became a valuable skill in its own right. Nobody argues Excel made us dumber — and the reason is precisely the rule at the top: the user still has to know whether the number is right.

## Fix the Instrument, Not the Tool

When a tool makes an existing measurement stop working, that is **instrument failure**, and the repair belongs at the instrument.

The clean case: students using AI may score *better* on an assessment while being *less prepared* for what the assessment was built to predict. That is not a claim about students. It is a claim that the assessment has decoupled from its target. Banning the tool restores the measurement only until the ban fails, which it does.

The repair is to assess what the tool cannot supply — **live reasoning under questioning**, which is why oral, in-person examination is AI-proof, and also why it is expensive. Note that this is the *same capacity* the rule at the top says must be preserved. An assessment that tests verification is automatically robust to tools that only do computation.

**The constraint: installed-base resistance.** A reform can be correct on the merits and still fail, because the people who must implement it were trained on the prior method and cannot verify the new one. **Common Core mathematics** is the worked example — a defensible attempt to teach *why* arithmetic works that ran into teachers and parents who could not check the new method against their own understanding, and lost. So "change the assessment" is a real answer with a real cost, not a free move. Expect the transition to be slow and to fail loudly in places where it is correct.

## What This Does *Not* Claim

- **Not that offloading is always fine.** The rule has a condition, and §Car Reductio names exactly who fails it: anyone who never had the capacity to verify with.
- **Not that atrophy is imaginary.** It is real, measurable, and often worth it. The claim is that naming it doesn't finish the argument.
- **Not that the tools are neutral.** They have defaults — toward agreement, toward fluency, toward confident wrongness. Sycophancy and prior-confirmation are real, but they are functions of prompting and of whether the user is asking to be *checked* or to be *agreed with*. That is the same verification discipline applied to the conversation instead of the output.
- **Not a productivity guarantee.** "It raises productivity" is a claim about people who learn the tool. Excel raised the ceiling for those who learned Excel.

## Specimens

- [Is AI Making People Dumber? (Word War — Charsky vs. Bunn)](./debates/wordwar-ai-making-people-dumber-charsky-bunn.md) — **first dated specimen, 2026-08-06.** Both positions argued well and neither has this rule. The Neg runs the Extended Mind defence and an **interpretive double bind** (intelligence is *innate* ⇒ the affirmative lacks its empirical claim; *functional* ⇒ the affirmative loses outright) — sound, but incomplete without the verification condition. The Aff runs atrophy, *phronesis*, and the staged-calculator observation, correctly identifying that **something** must be preserved but naming it *practice* rather than *verification capacity*. The round also supplies the productivity/intelligence diagnostic in the sharpest possible form: the Neg's two population channels **both route through nutrition and development**, so his own best case implies the direct cognitive effect is ~nil — winning the debate as posed while conceding the interesting question.

## Open Questions

1. **How much verification is enough?** "Can check the output" is a gradient, not a binary — spot-checking magnitudes differs from full re-derivation. Is there a principled threshold, or is it task-specific all the way down?
2. ~~**Does verification capacity itself atrophy?**~~ **Answered — yes**, and by a sharper mechanism than the automation-complacency version originally posed here. Verification gets *tooled*, and the verifier degrades to running the tool and swapping the part; see [§ The Rule Is a Frontier, Not a Floor](#the-rule-is-a-frontier-not-a-floor), which is now the page's central qualification. Open successors: **how do you tell a healthy verification layer from a degraded one from the inside** (the symptom-fixing tell is a signature, not a measure), and **who pays for retooling** — it is pure cost until the day it isn't, which makes it the first thing cut.
3. **The pipeline problem.** The sharpest version of the harm isn't to any current user: if juniors never build the capacity, the **future supply of people able to verify** shrinks, and the harm lands a generation later on people who made no choice. Sequencing (§Car Reductio) is the partial answer; whether it is sufficient at scale is open. Raised but undeveloped in the specimen as "we've eaten our seed corn."
4. **Where is the line for genuinely novel work?** Verification presupposes a standard to check against. For genuinely new results — where no prior answer exists — what plays the verification role? Possibly the same thing as always (does it survive contact with reality), which would mean the rule is just the scientific method restated.

## Tags

[ai](../tags/ai.md), [epistemology](../tags/epistemology.md), [philosophy](../tags/philosophy.md)
