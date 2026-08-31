---
status: active
created: 2026-02-12
published: true
layout: layouts/page.njk
title: "Economics"
permalink: /research/economics/
---
# Economics
> A major area of interest — understanding how value, trade, and systems of exchange work.

**Links:** [Vault Index](../../INDEX.md), [Claude Opus 4.6 Research](../claude-opus-4-6.md), [Computation and Information Theory](../computation-and-information.md)

## Why This Matters
Economics is foundational to understanding how AI agents interact with the real world. If an AI is going to run a business, manage resources, or make decisions that involve trade-offs, it needs to understand the principles that govern exchange — not just the accounting, but the theory underneath.

The [Claudius vending machine experiment](../claude-opus-4-6.md) is a concrete example: the AI failed not because it couldn't do math, but because it had no model of value, utility, or why profit exists.

## Sub-Topics

### Fundamentals
- [Value and Profit](./value-and-profit.md) — utility theory, mutual benefit, and why profit emerges from trade
- [Risk and Entrepreneurship](./risk-and-entrepreneurship.md) — uncertainty, time preference, and why profit is the reward for correct bets
- [Variance Is Not Luck](./variance-is-not-luck.md) — variance is universal and neutral; **luck is a property of an agent's engagement with it**, not of the world. Carries the *if everything is luck, nothing is luck* reductio (a predicate true of every case explains no case), the **irreducible ≠ decisive** split that portfolio theory opens, "you have to buy the ticket," and the determinism pincer — plus an honest account of where variance genuinely *does* dominate

### Positional Goods & Poverty Definitions
- [Positional Goods — Where the Pie Stops Growing, and Why](./positional-goods.md) — growing-pie is true for almost everything and false for a specific class: goods whose value depends on your share *relative to others*, so producing more cannot help everyone at once. **Chris's addition — positionality has two sources and only one is real:** *naturally* fixed (rank, prime location, elite slots) vs. **manufactured** by policy that caps a supply which could otherwise grow. **Land is fixed; housing is not** — you can build up. Doctors are not fixed; *licensed* doctors are. The empirical payoff: price a 1963 basket today and the cheap column (food, clothing, appliances, communications) is the non-positional goods while the expensive column (housing, healthcare, education, childcare) is almost exactly the restricted list — so **the cost-of-living complaint is evidence of where growth was *blocked*, not evidence against growing-pie**. Separates the rival Baumol account with a discriminator (*does cost track labor-intensity or entry barriers?* — housing goes against Baumol) and puts the CPI-basket fight **downstream** of the split
- [Subsistence vs. Participation](./subsistence-vs-participation.md) — the two definitions of poverty, and why one **ratchets**. Subsistence (minimum to sustain life) is fixed across history; participation (minimum to function in your society) is **Adam Smith's**, not modern goalpost-moving — concede the pedigree and attack the *measurement*. **Chris's ratchet objection:** participation is a *negotiated state*; if everyone lost internet tomorrow employers would revert to paper, so "X is required" holds only because X is common and X spreads because it's required — a self-supporting loop where **everyone eventually needs everything**, and a bar growth can never clear. Same defect as relative poverty, reached from the other side. The steelman that survives is a **scope** split: conventional necessities are *collectively negotiable but individually binding*, which is why the camps never resolve. Carries the abolished-vs-unfashionable discriminator and the credential-inflation reading of Turchin

- [The Inequality Optimum — Why "Eliminate It" Is Not the Goal](./inequality-optimum.md) — the **normative layer** the vault was missing. Opens with a refutation from revealed preference: **eliminating inequality is achievable, has been achieved, and is universally rejected** — levelling by destroying the top works (Mao, Pol Pot, hunter-gatherer reverse-dominance hierarchies), so *the stated goal is not the operative goal*. Replaces the target with a **curve**: some dispersion is functional (it prices capability and pays for risk — it *is* the system working), too much buys unrest, so both "inequality is bad" and "inequality doesn’t matter" assert a monotone and are wrong. **The normative question turns out to be hostage to the measurement question** — which side of the optimum we are on is quantitative, and returns you to the 40% of income invisible to tax returns. Holds the **subtraction-not-substitution** guard hard (establishes the objective is underspecified, refuses to name a hidden motive) and generalises the **achievable-and-refused test**

### Measurement
- [Measuring Growth — Net Worth vs Transactions](./measuring-growth.md) — GDP counts activity, not improvement; the Stooges, the manure joke, and the broken window all expose the same flaw

### Risk Management
- [Insurance](./insurance.md) — the one thing insurance does right (catastrophic tail hedging) and everything it does wrong (free riders, risk class paradox, mission creep)

### Praxis
- [Agent Teams vs. the Theory](./praxis-agent-teams.md) — testing the framework against real Opus 4.6 deployments
- [The Lemonade Stand Experiment](./lemonade-stand-agents.md) — *(specimen)* the **vending machine 2.0** this framework asked for, run by a third party: Claude Opus 4.7 vs GPT-5.5, unlimited budget, real customers, physical build. $65 / $42 revenue, ~$10k lost each, price below average variable cost. **Corrects the "make the constraint visible" fix** — full ledger visibility, spent anyway, because the goal was *revenue not profit*: **the objective must encode the constraint, or the dashboard is decoration.** Also: spending *inhibition* as the new failure mode, a competitor pair colluding on a child-labour workaround, and product quality (GPT's custom flavours) losing to spectacle (Claude's Rube Goldberg machine)
- [LLMs as Praxeological Actors](./llm-praxeology.md) — aligned LLMs satisfy Mises's formal criteria for action; Rothbardian demonstrated preference in token generation; Austrian economics as the AI agent framework

### The Price System as Distributed Computation

A market economy is a massively parallel, distributed computing system. The price mechanism is its communication protocol — encoding supply, demand, scarcity, opportunity costs, and subjective valuations into a single number that propagates at the speed of transactions.

**Why this matters for economic theory:**

Hayek's insight in *The Use of Knowledge in Society* (1945) was that the knowledge required for economic coordination is dispersed across millions of actors, each holding local information no central authority can access. The price system solves this by letting each node process only its local data while the price signal aggregates the result.

Framed in computational terms (see [Computation and Information Theory](../computation-and-information.md)):

- Each market participant is a **computationally irreducible agent** — you can't predict their choices without running their deliberation (this is free will, see [measurement-causality](../philosophy/metaphysics/measurement-causality.md))
- The market is a **computationally irreducible system** of such agents — you can't shortcut the market's output without running the market
- Central planning attempts to simulate this distributed computation on a single serial node, with worse information, higher latency, and degraded fidelity at every translation step
- **This is not a practical limitation but a theoretical impossibility** — for the same formal reason you can't predict a conscious agent's choice without running the agent

The price system's advantages are structural, not incidental: massive parallelism, zero-latency proximity between information source and decision maker, distributed computational cost, and bandwidth compression (one price encodes what no report can).

### Data
- [US Spending Per Student](./us-spending-per-student.md) — inflation-adjusted K-12 per-pupil expenditure over time, cross-verified across federal and independent sources
- [K-12 Instruction vs. Administration Spending](./k12-instruction-vs-administration.md) — breakdown of where school dollars go: instruction, administration, support services, staffing trends, and what actually drives cost growth

### Theory
- [The Theory of the Firm and the Optimal Scale of Collectives](./theory-of-the-firm.md) — Coase's firm boundary (internal vs market transaction cost) generalized to every collective: firm → nation (Alesina-Spolaore) → empire. Optimal scale, not maximal; the inward/outward pressures are the doctrine-of-the-mean basin (symmetry-breaking); validated by christian-advantage's decentralization verdict. Pre-political: no scale is terminal, subsidiarity, the optimum moves with transaction-cost technology
- [Market Efficiency and Human Limits](./market-efficiency-and-human-limits.md) — the market gives society what it wants, but humans may not be smart enough to be good market participants; supply-and-demand analysis failures; GDP per capita as the real measure
- [Externalities: Fact-Check of the Decomposition Thesis](./externalities-fact-check.md) — do externalities decompose into information and coercion problems, or are they a genuine third category? Sourced review of Coase, Dahlman, Rothbard, Block, Winston
- [The Supply Omission — Why "Demand-Driven" Is Half an Argument](./the-supply-omission.md) — demand is unbounded, so the binding constraint is supply; any framework that centers demand and hides the supply ceiling has smuggled in its conclusion (state money-creation looks free). The infinite-demand + $1B reductios; S≡I as a loop not a lever; the anti-MMT scalpel; "delete the inconvenient half" as the shape it shares with the externalities/public-goods gerrymander. First specimen: the [Keen–PBD debate](../debates/keen-pbd-postkeynesian-capitalism.md)
- [The Productivity–Pay Gap — An Identity Mistaken for a Finding](./productivity-pay-gap.md) — **output ≡ income**, so "labor productivity" is deflated *income* per hour and the famous chart compares total factor income per hour against labor income per hour. The ratio of a total to one of its components **is that component's share** — so *"productivity grew faster than pay"* ≡ *"labor's share fell."* Same sentence; one sounds like a claim about desert. That equivalence is the trick, and it's why the deflator-repair literature misses: it argues about *how large* the share shift was, conceding that the comparison means something. Canonical source **Blair Fix** ("productivity is income relabelled" + the aggregation problem = [the Weighting Problem](../philosophy/epistemology/weighting-problem.md)) — anti-neoclassical, so he pre-empts the think-tank dismissal. **National income** is the right pay measure (same accounting frame) vs. a BLS wage series BLS itself flags. Rising dispersion is real, largely skill-biased, and **top-half** (90∶50, not 50∶10) — so it never reaches poverty. A specimen of [accounting identities as domain-matching](./accounting-identities-as-domain-matching.md)

### Cycles
- [Business Cycles](./business-cycles.md) — boom-bust cycles are natural market phenomena; government amplifies them through the political ratchet, moral hazard, prevented liquidation, and Cantillon distortion
- [Inflation](./inflation.md) — inflation has many causes; only monetary expansion is permanent; supply shocks, demand shifts, velocity, productivity, and technology-driven demand are real but transient
- [Measuring Inflation — Why Disaggregation Doesn't Save You](./measuring-inflation.md) — the measurement companion to the above, and the answer to its Open Question #2. Household inflation rates diverge by a **6–9 percentage-point interquartile range** (Kaplan & Schulhofer-Wohl), so headline CPI describes almost nobody. But personalizing the basket doesn't rescue it: an individual still buys many goods, and their own basket still changes between periods, so the Laspeyres/Paasche choice and the whole index-number problem **reappear at n = 1**. The Weighting Problem is **scale-invariant** — you cannot disaggregate your way out, because aggregation was never a consequence of grouping *people*, only of buying more than one *thing*. Replaces "find the right index" with three disciplines: match the deflator to the question (which is ~39% of the [productivity–pay gap](./productivity-pay-gap.md)), report the distribution, state the basket
- [The Equation of Exchange and the Transaction Multiplier](./equation-of-exchange.md) — MV = PT decomposed through C+I+G+NX; each GDP component has a different transaction multiplier; explains the velocity puzzle, Cantillon routing, and financialization
- [The GDP-Identity Tariff Fallacy](./gdp-identity-tariff-fallacy.md) — "tariffs raise GDP by closing the trade gap" misreads C+I+G+X−M as a behavioral model. Imports are already inside C/I/G; the −M is a correction, not a subtractor of GDP. Same "accounting identities are not models" pattern as Equation of Exchange and Measuring Growth. Includes inventory-lag complications, the second-order tariff effects that actually matter, and the downstream errors the misreading propagates (trade-deficit-as-debt, reshoring-boosts-GDP, etc.)
- [Accounting Identities as Domain-Matching](./accounting-identities-as-domain-matching.md) — the meta-pattern that ties Equation of Exchange + Measuring Growth + GDP-Identity-Tariff together. Macroeconomic identities have hidden domain restrictions that the notation hides; each level of relaxation reveals different things (financialization, asset-price inflation, the velocity puzzle, Wall-Street/Main-Street decoupling). The QE-and-CPI-vs-asset-inflation debate played out for a decade between people using different restrictions of the same identity, treating one as canonical and missing the structural fact. Practical reading: when a policy argument invokes an identity, ask which restriction; check whether moving one term forces another in the same identity to change; notice whose interests are served by privileging which restriction.
- [Lyn Alden on Long-Term Trade Deficit Unsustainability](./lyn-alden-trade-deficit-analysis.md) — careful multi-level engagement with Alden's *Trade Deficit Charade* article. She makes 6-7 distinct mechanism-level arguments; framework refines rather than refutes. Key additions: investment-vs-consumption import composition (Level 1 distinction Alden smooths); exorbitant privilege explicitly (Level 2 anomaly); r-vs-g arithmetic as the empirical sustainability test; Level 5 (geopolitical creditor-cooperation erosion) as the time-horizon-determining variable; "Hemingway gradually-then-suddenly" pattern. Chris's position: structurally Alden's right; the open empirical question is whether US growth is actually outpacing accumulation — "we might be sustaining import bloat through growth, but I am not sure we are." Initial map; further refinement planned.

### Taxation
- [Taxation and Unrealized Gains](./taxation-and-unrealized-gains.md) — you can't tax what doesn't exist yet; the double taxation of homeowners (property tax + capital gains); imputed rent as GDP fiction; LVT critique; tax transactions, not assessments

### Planned
- Business Models — how value is captured and sustained
- Architecture & Guardrails — how system design protects the profit signal (bridges to AI agent architecture)
- Agent Team Economics — compute costs vs. value created, optimal team structures

## Tags
[economics](../../tags/economics.md), [ai](../../tags/ai.md)
