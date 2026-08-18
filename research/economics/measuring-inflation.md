---
status: active
created: 2026-08-05
published: true
layout: layouts/page.njk
title: "Measuring Inflation — Why Disaggregation Doesn't Save You"
---
# Measuring Inflation
> **The deepest result on this page:** real demand is **non-homothetic** (the poor spend different *proportions*, not just less) — and that single fact produces *both* the empirical heterogeneity **and** the theoretical impossibility. It makes household baskets differ (inflation inequality) **and** it breaks Hulten's path-independence condition, so the Divisia line integral is path-dependent and **no canonical price level exists**. The heterogeneity is not noise around a true price level that better measurement would find; it is *why there is no true price level to find.*
>
> Different households face different inflation — measured, not theoretical (Kaplan & Schulhofer-Wohl: an annual **interquartile range of 6.2–9.0 percentage points**). The obvious fix is to personalize the basket, but push it to the endpoint and **the problem is still there**: one person still buys many goods, and their own basket re-populates over a lifetime. **The Weighting Problem is scale-invariant** — disaggregation relocates it, never dissolves it. Escaping the basket entirely (gold, or better, **time-price in physical units** — Nordhaus's lumen-hours) solves aggregation but still owes quality adjustment, and cannot price a good that didn't exist. The deepest finding here: **"inflation" names two different phenomena** — *currency depreciation* (prices rise) and *real resource cost* (costs fall) — which move in **opposite** directions over long horizons. Most arguments about whether people are better off are two parties measuring different ones.

**Links:** [Inflation](./inflation.md) — parent page (causes); **this page answers its Open Question #2**, [The Weighting Problem](../philosophy/epistemology/weighting-problem.md) — the formal principle this is an instance of, [Absolutes and Differentials](../philosophy/epistemology/absolutes-and-differentials.md) — basket choice sits upstream of nearly every absolute-vs-differential political dispute, [Weinstein × Murphy: Gauge Theory Applied to Economics](../debates/weinstein-murphy-gauge-theory-economics.md) — "the price level" is a fiction; the connection-on-a-bundle resolution, [The Productivity–Pay Gap](./productivity-pay-gap.md) — where a deflator mismatch produces ~39% of a famous "finding", [Value and Profit](./value-and-profit.md) — subjective value as the root, [Measuring Growth](./measuring-growth.md), [Equation of Exchange](./equation-of-exchange.md)

## 1. The heterogeneity is real and large

Not a rhetorical point — it has been computed:

- **Kaplan & Schulhofer-Wohl**, *Inflation at the Household Level* ([NBER w22331](https://www.nber.org/system/files/working_papers/w22331/w22331.pdf); *JME*): household-level inflation rates with an **annual interquartile range of 6.2–9.0 percentage points**, running systematically higher for **lower-income, larger, and older** households.
- **Jaravel (2019)**: scanner data 2004–2015; the top/bottom quintile income gap grows ~16% (2002–2019) but **~23%** once each group's own inflation is used, and **~2.3 million more Americans** fall below the poverty line on their own price index. Mechanism: **innovation and product entry concentrate at the high end**, so richer baskets get more competition and lower measured inflation.
- **Contested**: national-accounts approaches reach different conclusions ([BLS 2025](https://www.bls.gov/osmr/research-papers/2025/pdf/ec250040.pdf)); the scanner evidence covers only ~10–15% of household expenditure. See also [Minneapolis Fed (2024)](https://www.minneapolisfed.org/article/2024/lower-income-higher-inflation-new-data-bring-answers-at-last).

**The immediate consequence:** a 6–9 point IQR means the headline CPI describes *almost nobody's* actual experience. It is a central tendency of a wide distribution being reported as if it were a measurement of a thing.

## 2. The disaggregation ladder — and where it ends

The natural repair is to stop averaging over dissimilar people. Follow it down:

| Level | Fixes | Still broken |
|---|---|---|
| **One national CPI** | — | Assumes everyone buys the same basket |
| **Group indices** (income, age, region) | Between-group heterogeneity | Groups are heterogeneous *inside* |
| **Household-level** (K&S-W actually did this) | Between-household heterogeneity | Households contain different people with different consumption |
| **Individual-level** — the endpoint | Everything between people | **See below** |

### What breaks at the endpoint — and what doesn't

Chris's question: *push it to the individual and then what have you got?* Three things go wrong, and the third is the one that matters:

1. **Comparability degrades.** If every person has their own deflator, "real income inequality" has no common unit — you are comparing quantities measured in different numéraires, and the comparison silently inherits whichever basket you chose.
2. **Policy targets become incoherent.** A 2% target on *whose* index? The central bank needs a single number that, by construction, no longer refers to anything.
3. **The aggregation problem survives intact.** ← the key point.

> **One person still buys many goods.** So computing *their* inflation still requires weighting food against rent against healthcare — an aggregation across goods, with a subjective weighting function. And their own basket changes between periods, so comparing their cost of living across time still forces the Laspeyres/Paasche choice: **weight by past-self's basket or present-self's?**
>
> **You have reproduced the entire index-number problem at n = 1.**

**This is the answer to "how far does it go?"** — it goes all the way down and the problem is waiting at every level. **The Weighting Problem is scale-invariant.** Disaggregation buys real accuracy about *between-group* differences, and buys exactly nothing against the underlying objection, because aggregation was never a consequence of grouping people. It is a consequence of people buying more than one thing.

*(The reductio's true target: anyone who says "the personalized index is the real inflation rate" has not escaped subjectivity — they have hidden it one level down, where it is harder to audit.)*

## 3. The formal statement — and the one real resolution

[The Weighting Problem](../philosophy/epistemology/weighting-problem.md): *objective measurements do not produce objective composite judgments; the aggregation function is always subjective.* Price indices are the cleanest economic instance — objective prices, objectively measured quantities, and no objective way to combine them.

[Weinstein's gauge-theoretic framing](../debates/weinstein-murphy-gauge-theory-economics.md) is the most serious attempt at a resolution, and it is worth understanding precisely because it **concedes the reductio and routes around it**: there is no canonical global basket (no preferred frame), but there may be a canonical way to *transport* between baskets — a connection on a fiber bundle. Under the correct derivative, the claim goes, all index numbers agree. That is not "we found the true basket"; it is "the disagreement between baskets is a coordinate artifact, and here is the machinery that removes it."

Whether that programme delivers is open. But note its shape: it does not answer the reductio by disaggregating. It answers by giving up on a privileged basket and formalizing the comparison instead.

## 4. Beyond the basket — numéraire, time-price, and physical units

Two problems survive §2 that personalization makes *worse*, not better:

**(a) The basket doesn't just re-weight, it re-populates.** A person at 22 buys food and clothes; at 35, houses and cars. That isn't a shift in weights — it's a different category set. So a personal index across a lifetime faces the same incommensurability as an index across people, with the added indignity that there's no one else to average against.

**(b) Goods appear and vanish.** Everyone tracks gas prices; nobody prices a pound of coal any more. This is the **new-goods problem**, and it is genuinely among the least-solved issues in index theory — the [Boskin Commission](https://en.wikipedia.org/wiki/Boskin_Commission) named new-goods bias alongside substitution, quality, and outlet bias. A concrete measure of the damage: the BLS telecommunications index was biased by **0.8–1.9 percentage points per year over 1988–97** simply from omitting cellular phones. Not a rounding error — a whole technology missing from the basket while it transformed the category.

**And relative price movement is the market working, not noise.** Prices *should* move to reconcile inputs with outputs; that is the mechanism, not a defect in it. Which sharpens the difficulty: the enterprise is trying to isolate a *general* level change from *informative* relative changes, using data in which only the relative changes are directly observable.

### The gold-numéraire move — what it buys and what it doesn't

Chris's example: a bar of gold buys a far better house in 2026 than in 1903. Priced in gold, housing has become cheaper — while priced in currency it has become dramatically dearer.

| | |
|---|---|
| ✅ **Escapes aggregation entirely** | One numéraire, no basket, no weighting function. The §2 reductio doesn't touch it |
| ❌ **Doesn't escape quality** | *"The house you buy today is much, much better"* is a **quality** claim. Houses-per-gold-bar improved partly because houses improved — plumbing, wiring, insulation, HVAC, square footage. You still owe a hedonic adjustment |
| ❌ **Gold isn't a fixed rod** | Mining output, jewelry and industrial demand, central-bank holdings and speculation all move gold's own real price. You have swapped a basket for a single volatile commodity — *simpler*, not more objective |

So the numéraire move solves the aggregation problem and leaves the comparability problem untouched.

### The stronger version — time-price in physical units

The version that gets both is **Nordhaus (1996), "Do Real-Output and Real-Wage Measures Capture Reality? The History of Lighting Suggests Not"** ([NBER, in *The Economics of New Goods*](https://www.nber.org/system/files/chapters/c6064/c6064.pdf)). Two moves at once:

1. **Measure the *service* in a physical unit** — lumen-hours, not "a lamp." Quality change is absorbed because illumination is invariant across an oil lamp, a gas jet, and an LED.
2. **Denominate in labor hours** — a numéraire that is comparable across eras in a way no currency is.

The results are among the most striking in economic measurement:

- **>50 hours** of labor per 1,000 lumen-hours pre-Neolithic → **~5.4 hours** by 1800.
- Price per 1,000 lumens: **$785 in 1800 → $0.23 by 1992** (2018 dollars) — a **99.97%** fall.
- Conventional price indices **overstate price growth and understate output growth by a factor of 900–1,600** since the start of the 19th century.

**This is "relative purchasing power" done rigorously** — exactly the thing Chris identifies as what people actually care about.

> **Structural convergence worth noting:** Nordhaus's lumen-hours and Fix's useful-work/energy productivity measure (see [The Productivity–Pay Gap §5](./productivity-pay-gap.md)) are the **same move** — escape monetary aggregation by denominating in physical units. One applied to prices, one to productivity, arrived at independently and from opposite political directions.

**What time-price still doesn't solve:** *whose* wage (median, mean, unskilled — the §1 distributional problem returns), and the new-goods problem in its hardest form. **What is the 1903 time-price of an MRI?** Undefined — infinite, strictly. You cannot form a ratio for a good that did not exist, and no amount of methodology creates one.

### The family, and the systematic bias it exposes

Three variants, in descending order of rigour:

| Approach | Unit | Example | Weakness |
|---|---|---|---|
| **Service-unit price** (Nordhaus) | Physical output of the *service* | Lumen-hours; computations/sec | Needs an invariant physical unit |
| **Time-price** (Simon / Pooley & Tupy) | Hours of work | 50 commodities, 1980–2025 | The **denominator** — see below |
| **Useful work / energy** (Fix) | Joules deployed productively | Productivity, not prices | Programme, not yet a series |

**Nordhaus ran the method twice, and got the same shape both times.** In [*Two Centuries of Productivity Growth in Computing*](https://www.cambridge.org/core/journals/journal-of-economic-history/article/two-centuries-of-productivity-growth-in-computing/856EC5947A5857296D3328FA154BA3A3) (*JEH*, 2007): computer performance rose by a factor between **1.7 trillion and 76 trillion** since manual computing; the price of computation fell from ~**$500 per MCPS** to ~**$6 × 10⁻¹¹**; and after WWII, computer power fell **47% per year relative to wages**.

> **The systematic finding — this is the generalizable result:** in *both* lighting and computing, **performance-based price declines are markedly larger than the official statistics report**, because official measures track the **good or its components** while the physical unit tracks the **service delivered**. Wherever a service has been supplied by a *succession* of technologies, official price statistics **overstate inflation** — and they do so in a consistent direction, which makes it a bias, not noise.

**The Simon Abundance Index is the weakest member and should be cited carefully.** Tupy & Pooley find time prices for 50 foundational commodities fell **70.9% between 1980 and 2025** — an hour of work in 1980 now buys what ~18 minutes buys. But the denominator is **GDP per capita per hour, not wages**, and those are materially different (non-wage compensation, hours worked, workforce composition); the global framing is exposed to the top of the distribution; and it blurs *physical* availability with *economic* availability. The lumen and computation results do not depend on any of that — **prefer them.**

### The deep limit — the physical unit is itself a choice

This is where the method stops being an escape and becomes an improvement of a different kind.

**Lumen-hours privileges illumination.** But a candle also provides ambiance, portability, and operation without a grid; a gas lamp provides heat. Declaring lumens *the* unit is a judgment about **what the good is for** — which is the Weighting Problem, relocated to the choice of unit.

> So physical units do **not** escape subjectivity. They make the value judgment **explicit and auditable** instead of burying it in a weighting scheme. That is a genuine advance — an argued choice can be contested; a hidden one cannot — but it is a different advance from "we found the objective measure."

**The limit shows up in practice, not just in theory.** Healthcare's candidate unit is the **QALY**, and it is contested for exactly this reason: choosing quality-adjusted life-years embeds disputed judgments about disability and age. The method's boundary is visible wherever the "service" is genuinely plural in what it's for.

**Where it works:** light, computation, transport (passenger-miles), communication (bits), energy (kWh), bulk calories — services with one dominant physical output, delivered by successive technologies.
**Where it fails:** housing, healthcare, education, entertainment, anything positional — goods whose value is irreducibly multi-dimensional.
**Where it cannot even start:** novel capabilities. Physical units compare *continuing services* across eras; they say nothing about goods that did not previously exist.

### The soldier's pack — the problem isn't monetary at all

Chris's example (2026-08-05): **the weight a foot soldier carries has been roughly constant for 2,000+ years.** Composition changed completely — armour to body armour, rations to MREs, more ammunition, radios, batteries, water purification — but what a man can carry over sustained distance has not moved.

The invariant here is not a technology; it is a **human constraint**, and it functions as a *budget*. Which yields the generalization:

> **The index-number problem is not a monetary problem. It is a bundle-comparison problem, and it appears wherever a fixed budget is spent on a changing composition.** Money is merely the most common budget. The soldier's pack is the identical problem denominated in kilograms.

And the question "is the modern soldier better equipped?" is *exactly* the index question — unanswerable from the weight, answerable only by valuing the contents, which requires a weighting function. Strip out currency, inflation, and central banks entirely, and the problem is still there in full. It was never about money.

*(This is also a [conservation-of-complexity](../../notes/conservation-of-complexity.md) case: the limit is real, the workaround — lighter materials — is genuine, and the freed capacity is immediately spent rather than banked. The load never falls.)*

### Quality adjustment runs both ways — the old-house asymmetry

Chris's caution on the housing example: a 1903 house has things a 2026 house doesn't — masonry that is still standing, repairable construction, materials not chosen for cost. Trade-offs run in **both** directions.

This exposes a real asymmetry in practice: **hedonic adjustment reliably counts features gained and rarely counts attributes lost** (durability, repairability, material longevity). So quality adjustment may bias *toward overstating* improvement — the **opposite** direction from the Nordhaus service-vs-good bias, which understates it.

**Two biases, opposite signs, no known net.** Anyone claiming to know which dominates is asserting past the evidence. This is the honest reason to distrust confident "real" figures in either direction — and it is why the discipline in §6 is about stating assumptions rather than finding the true number.

### The payoff — "inflation" names two different things

Chris's closing question — *does this mean the true price of a house has gone down? Probably, but the currency metric says the opposite* — identifies a genuine conflation, and it is the most useful thing on this page:

| Sense | What it measures | Long-run direction |
|---|---|---|
| **(a) Currency depreciation** | The declining purchasing power of the monetary unit | Prices **rise** |
| **(b) Real resource cost** | Labor/resources required to obtain a given standard of living | Costs **fall** |

**Both are true at once, and over long horizons they move in opposite directions.** Technology drives (b) down while monetary expansion drives (a) up. The gold-and-house case is simply where the divergence is widest.

#### "Inflation is always zero — all that changes is shape"

Chris's formulation (2026-08-05), from the tradeoff principle: you can never get something for nothing, only choose among alternatives; technology redistributes goods and services rather than conjuring them. **In one precise sense this is exactly right, and in another it must not be taken.**

| Sense | Verdict |
|---|---|
| **There is no scalar price *level* to be nonzero — only composition changing along a path** | ✅ **Correct, and it is the formal result.** This is non-exactness (§5): no potential function exists, so there is no *level* to have a value. Chris's folk statement and Hulten's theorem are the same claim |
| **Real gains are therefore illusory — nobody is better off** | ❌ **Refuted by the data.** ~5.4 labour-hours per 1,000 lumen-hours in 1800 → effectively nothing today; computation down by a factor of 10¹³ or more. The budget genuinely expanded |

**The distinction that keeps them apart:** the tradeoff principle governs the **shape of the frontier at a moment** — on the frontier, more X means less Y. Technology **moves the frontier outward over time**. Those are different claims, and collapsing them yields the strong reading, which the lumen and computing series refute directly.

So: *no price level* ✅. *No progress* ❌. The pack weight is fixed; what the soldier can do with it is not.

---

This is not a measurement error to be corrected. It is **two distinct real phenomena sharing one word** — and most disputes about whether people are "better off" are two parties each measuring a different one and assuming the other is lying. When people say *inflation* they almost always mean **(a)**. When they argue about living standards, wages, or poverty, the load-bearing quantity is **(b)** — and it is routinely measured with an instrument built for (a).

## 5. The other measures — and why the good ones inherit the problem

### The practical alternatives

| Measure | Formula | Weights | Scope | Fixes |
|---|---|---|---|---|
| **CPI-U** | Modified **Laspeyres** | Annual (biannual before 2023) | Out-of-pocket consumer spending only | — the baseline everyone cites |
| **C-CPI-U** (2002–) | **Törnqvist** (superlative) | Adjacent-period expenditure | As CPI-U | **Cross-category substitution** |
| **PCE** (Fed's target since 2000) | **Fisher-Ideal** (superlative) | Updated monthly/quarterly | Broader — includes items bought *on behalf of* households (employer-paid medical, imputed items); sourced from **businesses**, not consumers | Substitution + scope. Runs **~0.4pp below CPI** |
| **Median / trimmed-mean CPI** (Cleveland Fed) | Robust central tendency | — trimmed excludes top and bottom **8%** by expenditure weight | As CPI | **Outlier volatility.** Median CPI forecasts future inflation better than core |

Note what the "fixes" column does *not* contain: none of them addresses **new goods**, and none addresses **heterogeneity across households**. PCE's lower reading is substantially a substitution-capture artifact, not a truer number.

### Divisia — the theoretically clean one, and its fatal property

The **Divisia index** is the continuous-time limit: a **line integral** through price–quantity space. It dissolves the Laspeyres/Paasche choice entirely, because it never picks a base period — it integrates along the actual path.

**And that is exactly where it breaks.** Divisia is **path-dependent in general** (Hulten, 1973): the index value depends on the *route* the economy took through price–quantity space, not merely the endpoints. Traverse a closed loop — return to the very same prices and quantities you started from — and the index **does not return to its starting value.** It can end anywhere.

**Hulten's path-independence condition:** the integrand must be homogeneous and, up to a scalar, a **gradient** — i.e. the differential form must be *exact*, so closed loops integrate to zero. Economically, that condition is **homothetic demand**: everyone spends the same *proportions* regardless of income.

> **Answering the vault's standing question — is Divisia an improvement or just another basket choice?** *Neither.* It eliminates the discrete basket choice and replaces it with **path dependence**, which is the same indeterminacy in continuous form. And superlative indices (Fisher, Törnqvist — i.e. **PCE and C-CPI-U**) are conventionally understood as discrete approximations to Divisia, so **the best official measures are approximations to an object that is ill-defined for real demand.** *(The superlative→Divisia approximation result is Diewert's; verify the citation before leaning on it.)*

### The synthesis — one root under both problems

Real demand is **not** homothetic. Engel curves aren't linear: the poor spend a different *share* on food and rent, not merely a smaller amount. And that single fact produces both halves of this page:

| Non-homothetic demand ⇒ | |
|---|---|
| **Income-varying baskets** | → different households face different inflation → **§1's 6–9pp IQR, Jaravel's result** |
| **Hulten's condition fails** | → the Divisia line integral is path-dependent → **no canonical price level exists** |

**The empirical fact and the theoretical obstruction are the same phenomenon seen from two directions.** The heterogeneity isn't noise around a true price level that better measurement would reveal — *the heterogeneity is why there is no true price level to reveal.* This is also why the representative-consumer framework fails here: aggregation bias under non-homothetic preferences isn't a modelling shortcut gone wrong, it's the obstruction itself. ([Fed 2025, *Non-homothetic Demand Shifts and Inflation Inequality*](https://www.federalreserve.gov/econres/feds/files/2025085pap.pdf); [Jaravel 2021](https://researchonline.lse.ac.uk/id/eprint/123931/1/Inflation_inequality.pdf).)

### Why this is the gauge-theory connection, precisely

§3 flagged Weinstein's programme as the serious attempted resolution. Now it can be stated exactly:

- A **path-dependent line integral** is the definition of a connection with **nonzero curvature**. Traversing a closed loop and not returning to your starting value *is* nonzero **holonomy**.
- So "the price level is a fiction" isn't rhetoric — it is the statement that **the price 1-form is not exact**, i.e. there is no global potential function whose gradient it is. There is no price *level*; there are only price *differences along paths*.
- "The correct derivative makes all index numbers agree" is then the search for a **flat connection** — a gauge in which the curvature vanishes and path-dependence disappears.
- And the **Cantillon effect is the economic name for that curvature**: the *order* in which new money reaches prices changes the outcome, not just the endpoints. See [Equation of Exchange](./equation-of-exchange.md) and [Weinstein × Murphy](../debates/weinstein-murphy-gauge-theory-economics.md).

Gauge theory isn't imported metaphor here. It is the standard mathematics for exactly this failure mode, and the economics reached the same wall from the other side in 1973.

## 6. What to actually do — three disciplines, no true number

Since there is no correct index, "measure it honestly" means something other than "find the right one":

**(a) Match the deflator to the question.** This is the practical rule and it does the most work. Deflating *wages* → a consumption basket. Deflating *output* → an output price index. Comparing the two → **you may not use different deflators on each side**. That single rule accounts for roughly 39% of the [productivity–pay gap](./productivity-pay-gap.md) — a famous "finding" that is substantially an artifact of answering a production question with a consumption deflator.

**(b) Report the distribution, not the point estimate.** Given a 6–9pp IQR, publishing one number is a *loss of information disguised as precision*. The honest object is the distribution: median plus spread plus which groups sit where. This is also the only form in which the heterogeneity result and the aggregate result can both be true without contradiction.

**(c) State the basket and the base period, always.** Every real quantity is "real *relative to* a stated basket at a stated time." Claims that omit both are not measurements; they are assertions wearing a unit.

## 7. Why this matters beyond pedantry

Almost every politically-charged economic claim is a **real** quantity — real wages, real GDP growth, real median income, the productivity–pay gap, real poverty thresholds. Every one is a nominal series divided by a chosen index. So the basket choice is upstream of the entire argument, and it is **the least-audited step in the chain**.

Two lessons follow, and they point in opposite political directions, which is the test that the principle is being applied honestly:

- The **official poverty threshold** is indexed by CPI-U, which most of this literature says overstates inflation for some purposes — biasing the threshold upward over time and the measured decline in poverty downward. (Meyer & Sullivan's bias-corrected CPI-U-RS is exactly this adjustment; see the [debate prep](../debates/poverty-exploitation-prep.md).)
- The same CPI **understates** inflation for low-income households per Jaravel — biasing their measured real gains *upward*.

**Both cannot be waved away, and neither can be selectively deployed.** A framework that applies measurement skepticism only where the result is convenient is running the [Ricardian Vice](../debates/keen-pbd-postkeynesian-capitalism.md) the vault already indicts.

## Open Questions
- **Does the gauge-theoretic programme actually deliver?** "The correct derivative makes all index numbers agree" is a strong claim. Is there a worked example on real price data, or is it currently a research direction?
- **Resolve Jaravel vs. the national-accounts critique.** Scanner data covers ~10–15% of expenditure; BLS (2025) disputes the generalization. Materially affects the poverty and real-wage stories.
- ~~**Is a Divisia index a genuine improvement or another basket choice?**~~ **Answered — §5.** Neither: it removes the discrete basket choice and replaces it with **path dependence**, which is the same indeterminacy continuously. Path-independence requires **homothetic demand** (Hulten 1973), which is false. Remaining sub-question: **verify Diewert's superlative→Divisia approximation result** before relying on the claim that PCE and C-CPI-U inherit the defect.
- **Does the gauge programme have a *worked* flat connection?** §5 establishes that path-dependence = curvature and that Weinstein is looking for a flat gauge. Whether one exists for real price data — or whether non-homotheticity makes the curvature irreducible — is the live question. If irreducible, "no canonical price level" is a theorem, not a complaint.
- **What does hedonic adjustment do to the distribution, not just the mean?** Quality adjustment is concentrated in goods (electronics) whose share differs sharply by income — so hedonics may itself be a driver of measured inflation inequality.
- ~~**Is there a defensible *non*-basket measure?**~~ **Yes, with a stated boundary — §4.** Nordhaus ran it twice (lighting, computing) with the same result: performance-based measures show far larger price declines than official statistics, because official measures track the *good* while physical units track the *service*. It works for single-dominant-output services, fails for multi-dimensional goods (housing, healthcare, education), and cannot start on novel capabilities. **And it does not escape subjectivity** — choosing the unit *is* the value judgment, merely made explicit and auditable rather than hidden.
- **Quantify the systematic bias.** If official statistics understate improvement wherever a service passed through successive technologies, **how much of the consumption basket is in that category?** Light and computing are dramatic but small shares. If the affected share is large, aggregate real-income growth is materially understated; if small, the lesson is rhetorical rather than macroeconomic. **This is the load-bearing unknown for the whole non-basket programme.**
- **Is there a principled way to choose the physical unit?** QALYs show the problem live — the choice embeds contested judgments. Is there a criterion better than "the dominant purpose, argued in the open"?
- **The new-goods problem is the hard residual.** What is the 1903 time-price of an MRI? No method produces a finite answer. Is there any principled treatment, or is cross-era comparison simply undefined once the good set diverges enough? This bounds *every* long-run "are we better off" claim, including the ones this vault makes.
- **Does the (a)/(b) split dissolve the Austrian–mainstream inflation dispute?** If "inflation" names currency depreciation *and* real resource cost, and those move oppositely, then much of the argument catalogued in [Inflation](./inflation.md) may be two schools measuring different quantities. Test the reframing against the positions there.

## Tags
[economics](../../tags/economics.md), [epistemology](../../tags/epistemology.md), [scope-confusion](../../tags/scope-confusion.md)
