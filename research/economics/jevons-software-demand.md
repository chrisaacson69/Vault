---
status: active
created: 2026-09-16
published: true
layout: layouts/page.njk
title: "Jevons for Software — Why Cheaper Code May Mean More Spend, Not Less"
---
# Jevons for Software
> Agentic coding collapses the price of producing code. The naive reading is that software spend falls. The **Jevons paradox** says the opposite is possible: when the price of a good falls, the quantity demanded can rise by *more* than the price fell, and total spend goes **up**. The entire argument reduces to one empirical parameter — the **price elasticity of demand for software** — and it says nothing on its own about whether *developers* capture the new spend. Software has climbed this ladder for seventy years and has never once produced the "less software" outcome; the caveats are about *when the ladder ends*, not whether the rung exists.

**Links:** [Economics](./README.md), [Arithmetic as a Purchase](../arithmetic-as-a-purchase.md) (**the vault's own sixty-year Jevons specimen — multiply got cheap and was consumed by orders of magnitude more**), [The Theory of the Firm](./theory-of-the-firm.md) (Coase — cheaper internal production moves the build/buy boundary inward), [The Cyborg Model](../cyborg-model.md) (which input *didn't* get cheap), [The Contract Model vs. the Substrate Model](../contract-vs-substrate.md) (the verification layer as the un-automated component), [Career Strategy](../../career/strategy.md) (where the conclusion lands), [Lemonade Stand Agents](./lemonade-stand-agents.md) (what agents still can't buy cheaply: unit-economic judgment)

> **Thesis page** (portable). Sparked 2026-09-16 by a YouTube explainer Chris watched that made the argument by name — *Jevons paradox* — and with the coal case as its empirical anchor. **The video itself is unsourced here** (YouTube is blocked on the network the discussion happened on, so no title, URL, or transcript was captured; nothing below is attributed to it beyond "it made the Jevons argument with coal"). Chris's own framing: *"a nice mix of economics and AI agency, probably more obvious than anything."* The vault's contribution is not the paradox — it is separating the three claims that ride on it and naming the one that actually matters.

---

## 1. The paradox, and the one parameter it turns on

William Stanley Jevons, *The Coal Question* (1865): Watt's engine used far less coal per unit of work than Newcomen's, and Britain's coal consumption *rose*. Efficiency lowered the effective price of steam power; steam power became worth applying to things it had never been worth applying to; the new applications consumed more coal than the efficiency saved.

The arithmetic is just **spend = P × Q**. Let P fall by some fraction. Q responds according to the price elasticity of demand, ε:

| Regime | |ε| | What happens to Q | What happens to P × Q |
|---|---|---|---|
| Inelastic | < 1 | rises, but by less than P fell | **falls** — the naive prediction |
| Unit-elastic | = 1 | rises exactly as much as P fell | unchanged |
| Elastic | > 1 | rises by more than P fell | **rises** — Jevons |

The energy-economics literature calls the general phenomenon the **rebound effect** and reserves **backfire** for the |ε| > 1 case where the rebound exceeds 100%. Jevons is backfire. So the argument "cheaper coding → more software spend" is exactly the claim **|ε_software| > 1** — an empirical claim about a demand curve, not a theorem. Anyone making the argument owes a reason to believe demand for software is elastic; anyone rejecting it owes a reason to believe it is not.

## 2. Why the prior favors elasticity

**The industry has been running this experiment for seventy years and the result has come out the same way every time.** Assembler → compilers → high-level languages → libraries and open source → cloud → frameworks. Each rung cut the cost per delivered feature by a large factor, and each time total software spend — and, for most of that history, total developer employment — grew. Agentic coding is the next rung on a ladder that has never yet delivered the "less software" outcome. That is a strong base rate, and it puts the burden on the pessimist.

The vault already holds the same curve for a different good. [Arithmetic as a Purchase](../arithmetic-as-a-purchase.md) traces fast multiplication from a **$325/month line item on the IBM 1401** to a free instruction, and the demand side of that page is Jevons unlabeled: multiply did not get *saved*, it got *spent* — on 3D, on spreadsheets, on everything that was never worth a multiply before.

**Where the extra Q comes from is the long tail of software that was never worth writing.** Internal tools. One-off automations. The spreadsheet that should have been an app. Reverse-engineering harnesses for thirty-year-old cartridges. Personal software with an audience of one. The threshold "is this worth a developer's month?" excluded almost all conceivable software; lower the threshold by an order of magnitude and the volume below it is enormous. **This vault is a local specimen.** The decompiler tool banks, the beat-grid benchmark, the `raw/` immutability hook, the derive-tools that regenerate `tags/` — none of it would have been produced at 2023 prices. It exists because the price crossed a threshold, which is the Jevons mechanism observed from the inside.

The most recent high-profile invocation was aimed at AI *compute*, not coding: when DeepSeek R1 (January 2025) undercut the assumed price of inference, Satya Nadella's public response was "Jevons paradox strikes again" — cheaper tokens would mean vastly more tokens consumed, not a smaller market. The same frame, one layer down the stack.

## 3. The three claims that ride on the paradox — and only the first is delivered

The argument as usually made bundles three claims. The paradox supports one.

**(a) Total spend on software rises.** This is what Jevons delivers, *conditional on elasticity*. It is the claim the video made, and it is the claim the seventy-year base rate supports.

**(b) Spend on developers rises.** Jevons says the *good* gets consumed more. Whether the humans who used to produce it capture the new spend depends on **what share of the new cost structure is human labor vs. agent inference** — a completely separate question. James Bessen's two cases bracket it:

- *ATMs and bank tellers.* ATMs cut the tellers needed per branch, which made a branch cheaper to open, so banks opened more branches, and US teller employment **rose** from the 1980s through roughly 2010 even as ATMs went from zero to hundreds of thousands. Cheaper unit → more units → more of the complementary labor.
- *Power looms and weavers.* Nineteenth-century automation cut the labor required per yard of cloth by roughly 98%, and because cloth demand was that elastic, weaver employment **rose for most of the century** — then fell, once people had about as much cloth as they wanted.

Both are consistent with P × Q rising. They diverge on the labor share, and they diverge *over time*. So "+spend" does not imply "+coders"; that inference needs its own argument about complementarity, and the conclusion "developer jobs are safe" is not something the elasticity argument can deliver by itself.

**(c) The regime is permanent.** It is not. **Elasticity is a phase, not a constant.** Demand is elastic while a large stock of latent, unmet uses sits just below the price threshold; it turns inelastic as those uses are exhausted. The weaving case is the whole arc in one industry — Jevons regime, then saturation, then displacement. The live question for software is therefore not "is demand elastic?" but **"how far from saturation is it?"** — and the honest answer is that the long tail *looks* vast and nobody has sized it.

## 4. The caveat the argument usually skips: only one input got cheap

Software is a **bundle**: specification, generation, verification, integration, maintenance. Agentic coding collapsed the price of **generation**. The other components did not fall nearly as fast — and the vault's own standing thesis is that verification in particular is the binding constraint ([the two oracles](../repairing-llm-code.md), [the substrate model](../contract-vs-substrate.md), the kernel rule that verification independence means dropping to a *lower artifact*).

Two consequences follow:

1. **The effective price drop for *software* is much smaller than the price drop for *code*.** If generation was 40% of the bundle and fell 90%, the bundle fell 36%, not 90%. The quantity response is damped accordingly. Headline claims about the collapse in the cost of code overstate the shift along the software demand curve.
2. **The bottleneck migrates to the un-automated components** — Baumol's cost-disease logic applied within a single product. As generation approaches free, the share of cost (and of value) held by specification and verification approaches 100%. This is Autor's complementarity point (*Why Are There Still So Many Jobs?*, 2015) in a specific form: automation of one task in a bundle raises the value of the tasks it cannot do.

This is where the page connects to [Career Strategy](../../career/strategy.md). Whoever owns the verification and specification layer is holding **the input that did not get cheap**, in a market where the total volume of software is — if the elasticity claim holds — about to rise sharply. That is a considerably more specific and more defensible position than "developers will be fine."

## 5. What each side owes

| Claim | What it needs to be true | What would falsify it |
|---|---|---|
| Spend rises | \|ε\| > 1 over the relevant range | measured software spend falling as agent adoption rises, controlling for the cycle |
| Developer employment rises | human labor is a strong complement to agent generation (ATM case, not loom case) | employment falling while spend rises — the loom outcome |
| The regime persists | the latent long tail is large relative to current output | saturation signatures: falling marginal value of new software, ε drifting toward 1 |
| The career conclusion (§4) | verification/specification stays hard to automate | agents acquiring reliable, independent verification — at which point the whole bundle is cheap and the argument reverts to pure elasticity |

## 6. Open Questions

- **How far is software from saturation?** The whole argument's durability rests on the size of the latent long tail, and no one has sized it. Is there a proxy — the ratio of "spreadsheets doing app work" to apps, the count of internal-tool requests that die in backlogs — that would put a number on the unmet stock?
- **ATM case or loom case?** Which historical analog does software labor actually resemble, and what is the *observable* that would tell them apart early — before the employment series itself turns?
- **Is verification already Jevons-ing too?** If cheaper generation induces more software, it also induces more verification demand. Does the un-automated component grow in absolute terms even as its unit cost holds — the tellers-per-branch effect applied to reviewers? This would make §4's career conclusion stronger, not just defensible.
- **Does the vault itself show the damping in §4.1?** The tool bank is the specimen for *induced* software. The session logs are a record of how much of each tool's cost was generation vs. verification. That ratio is measurable here and would ground the "bundle" claim with an *n* instead of an argument.
- **Recover the source.** The video's title/URL were not captured (network block). When Chris has them, capture the transcript to `raw/videos/` and cite it; until then this page's provenance is "an explainer that used the term and the coal case," relayed.

## Tags
[economics](../../tags/economics.md) · [ai](../../tags/ai.md) · [agents](../../tags/agents.md) · [software-engineering](../../tags/software-engineering.md) · [career](../../tags/career.md)
