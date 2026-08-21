---
status: active
created: 2026-08-05
published: true
layout: layouts/page.njk
title: "The Productivity–Pay Gap — An Identity Mistaken for a Finding"
---
# The Productivity–Pay Gap
> *(Canonical source: [Blair Fix, "Debunking the Productivity-Pay Gap"](https://economicsfromthetopdown.com/2020/01/17/debunking-the-productivity-pay-gap/).)*
> **Output ≡ income.** So "labor productivity" is deflated *income* per hour, and the famous chart compares **total factor income per hour** against **labor income per hour** — two quantities whose ratio *is labor's share*. The gap therefore **is the labor-share decline, restated**: an accounting identity, not a discovery. This is why the deflator-repair literature misses: it treats the comparison as meaningful-but-mismeasured when it is **category-broken**. Correct every deflator perfectly and you have still only recomputed labor's share while calling it a finding about what workers deserve. A specimen of [accounting identities read as behavioral models](./accounting-identities-as-domain-matching.md).

**Links:** [Economics](./README.md), [Accounting Identities as Domain-Matching](./accounting-identities-as-domain-matching.md) — **the parent thesis; this is a specimen**, [Poverty in America Is a Sign of Exploitation (prep)](../debates/poverty-exploitation-prep.md) — where this is Aff's likeliest single chart, [The Weighting Problem](../philosophy/epistemology/weighting-problem.md) — why "real output" needs a basket choice, [Absolutes and Differentials](../philosophy/epistemology/absolutes-and-differentials.md) — **the hub this is a specimen of**: "labor's share fell" is a *differential*, "workers aren't paid what they produce" an *absolute*, [The Supply Omission](./the-supply-omission.md) — the same "delete the inconvenient half" shape, [Value and Profit](./value-and-profit.md), [Measuring Growth](./measuring-growth.md)

## 1. The circularity — why the comparison can't do the work asked of it

> **This section is [Blair Fix's argument](https://economicsfromthetopdown.com/2020/01/17/debunking-the-productivity-pay-gap/) — the canonical treatment for this page.** Everything below restates it; §5 gives his additional machinery. Where other sources conflict with Fix on the *structure* of the error, Fix governs.


**"Productivity" in this chart is defined through income.** Output = price × quantity, summed — which is gross income. Deflate it, divide by hours, and you have labor productivity. The numerator was never a physical fact about work; it is a monetary aggregate wearing a physical name.

So the chart's two series are:

- **"Productivity"** = *all* factor income per hour, deflated by an output index
- **"Pay"** = *labor* income (a subset) per hour, deflated by a consumption index

The ratio of a total to one of its components **is that component's share.** Which yields:

> **"Productivity grew faster than pay" ≡ "labor's share of income fell."**
>
> These are the same sentence. The first one just sounds like a claim about desert.

That equivalence is the entire trick, and it is why the chart is so compelling: it converts a **distribution** statement into what sounds like a **fairness** statement, without adding any evidence. Nothing in the identity says whether workers are paid what they produce — the identity cannot speak to that question at all, because "what they produce" was measured in dollars they were paid.

### The empirical demonstration — Fix's Figure 2

This is not merely an a priori accounting point; it is visible in the data. **Fix's Figure 2, "US Net Domestic Product and National Income"** ([BEA Table 1.7.5](https://apps.bea.gov/iTable/)) plots the **sales side** (NDP) against the **income side** (NI) of the national accounts. The two series track **nearly identically** — Fix's own gloss: *"There are some small differences between Net Domestic Product and National Income (some business taxes, for instance). But in practice, the two quantities are nearly identical."*

Because the national accounts are double-entry, every sale booked as "output" has a matching income entry. **The chart is the proof that "output" is income relabelled** — and therefore that a productivity series built on output is an income series wearing a physical name. Cite this figure when someone insists productivity is a physical measure of what workers make.

**Consequence for the repair literature:** adjusting deflators, swapping wages for total compensation, matching worker coverage — all of it is arguing about *how large* the share shift was. None of it touches the fact that a share shift is all there ever was. The repairs concede the frame. **Don't lead with them.**

## 2. National income is the right measure of pay

If the question is whether labor's compensation tracked what labor produced, both sides must sit in the **same accounting frame**. National income does that: it is the income side of the identity, so labor compensation and total factor income are commensurable by construction — no cross-frame deflator smuggling, no coverage mismatch between "production workers" and "all output."

The BLS hourly-earnings series used in the standard chart is not that. It is a narrow wage series that **BLS itself flags as an older construct with known reliability limits**, and it is being asked to carry a conclusion about the whole economy's distribution.

> **The one-line version:** *"He's comparing a wage survey to a national accounts aggregate and calling the difference exploitation. Put both in national income and the picture changes — because now you're comparing like to like."*

⚠ **Grounding gap — still open.** Fix's Figure 2 does *not* fill this one: it demonstrates NDP ≈ NI (the §1 identity), not that labor compensation from the national accounts tracks output. The claim here is a **consistency** claim — measure pay as *compensation of employees within the national accounts* rather than via a separate wage survey — and it needs its own support. This is the §4 repair move done correctly, so the sources there are the nearest evidence, but a direct national-accounts compensation-share series would be better.

## 3. What is actually true — and what it isn't

Precision here is what separates this from motivated reasoning:

| Claim | Status |
|---|---|
| Workers aren't paid for what they produce | **Unsupported** — the chart cannot address this; it's the identity misread |
| The specific ~60% vs ~17% chart shows a broken link | **False** — it shows a share shift, restated |
| Labor's share of national income declined | **True** |
| Wage dispersion rose, gains concentrated at the top | **True** |
| **Wage** gap at or near historic peak | **Likely true** — split the two gaps; they are not at the same place |
| **Wealth** gap at Gilded Age levels | **Not yet** — rising, but below the historic peak |

**The positive account of the dispersion** is largely skill-biased: workers whose skills complement modern capital and technology capture more; those whose don't, capture less. That is a story about *changing relative marginal products*, which is the opposite of a story about pay being severed from productivity. **It is productivity differentiation, not productivity–pay decoupling.**

And note the scope: rising dispersion is a **top-half** phenomenon — income inequality's rise is 90∶50, not 50∶10, and bottom-half *consumption* inequality actually fell (figures in the [debate prep](../debates/poverty-exploitation-prep.md)). So even granting every true row above, none of it reaches poverty.

## 4. The repair literature — useful only as a secondary line

Deploy this **after** §1, never instead of it. On their own terms, the standard chart stacks four mismatches, each pushing the same direction:

| Mismatch | The chart does | Should do |
|---|---|---|
| **Coverage** | Production/non-supervisory workers' pay vs. **all** workers' output | Same population both sides |
| **Wages vs. compensation** | Hourly **wages** only | **Total compensation** — benefits were >20% of employee income by 2012 and grew faster |
| **Deflator** | **CPI** for pay, output deflator for productivity | Consistent deflators |
| **Gross vs. net** | **Gross** output, including capital consumption | **Net** — depreciation is income to no one |

A decomposition (de Rugy, via FEE) attributes ≈96% of the gap to measurement choices: **~45%** coverage, **~39%** deflator, **~12%** irregular payment forms. Corrected, total compensation tracks net productivity (Lawrence: 1970–2000).

**The one repair-literature result worth leading with anyway** is **Stansbury & Summers**: had productivity grown at earlier postwar rates, median and mean compensation would have been ~41% higher in 2016. That is a *pro-linkage* finding from the left — pay responds to productivity, and slow pay growth reflects the **productivity slowdown**, not a severed link. FEE and AEI are dismissible as motivated; Summers is not.

## 5. Fix's machinery — the canonical source in full

[Blair Fix, *Economics from the Top Down*](https://economicsfromthetopdown.com/2020/01/17/debunking-the-productivity-pay-gap/) is the governing treatment. Three components:

1. **"Productivity is just income relabelled."** Output = price × quantity = gross income; productivity = that, per hour. The measure is monetary all the way down. → §1.
2. **The aggregation problem.** Because *prices* do the aggregating, **identical physical output yields different measured "real" productivity depending on which year's prices you hold constant.** There is no basket-independent real output — [the Weighting Problem](../philosophy/epistemology/weighting-problem.md) in another costume. This is the part the repair literature cannot answer, because it is not a calibration error; it is the absence of the quantity being calibrated.
3. **Symmetric indictment.** He charges mainstream *and* heterodox economics with the same sin, which is what makes him usable in a hostile room — he is not defending anyone's team.

**His conclusion — *"it's really a gap between two types of income"* — is §1, not a concession.** It reads like a concession only if the labor-share residual is something *separate* from the gap. Under the identity framing it is the **same fact**, which is the whole point: the gap was never evidence *for* the share shift, it was the share shift wearing a different label.

### Fix's decomposition — the "why" behind the apparent gap

Having shown the gap *is* a share statement, Fix decomposes the share movement into two mechanisms (his Figures 3 and 4 — **not** a quintile breakdown):

- **Figure 3 — labor's share of national income**, declining since ~1970. *"Since 1970, US workers have received a declining share of this income. Consequently, their wages have declined relative to the average US income."*
- **Figure 4 — the top 1% of wage/salary earners' income share**, rising steadily since 1970. Modelling production workers as the **bottom 80% of earners**, their *relative* income falls by roughly **50% between 1970 and 2012**.

His summary mechanism: redistribution **toward capital owners *and high-earning managers***.

**That second clause is the one to notice.** Redistribution toward high-earning managers is movement *within* labor income — it is dispersion among wage earners, not extraction from labor as a class. It is the same **top-half** phenomenon the consumption data shows (90∶50 rising, 50∶10 flat-to-falling), arriving from an entirely independent direction and an opposed political starting point. Two hostile methodologies, one location.

### ⚠ Relative share vs. absolute level — do not conflate these

Three findings on this page look contradictory and are not. Keeping them straight is load-bearing:

| Source | Measures | Finding |
|---|---|---|
| **Fix** (Figs 3–4) | **Relative share** of a growing total | Bottom **80%** lost ~50% of relative income, 1970–2012 |
| **Meyer & Sullivan** | **Absolute level** + dispersion | Bottom-half consumption inequality **fell** (50∶10 −3%); consumption poverty 13.0% → 2.8% |

**Both are true.** The bottom 80% can lose *share* while gaining *consumption*, because the total grew. **Losing share ≠ getting poorer** — and that distinction is the distribution-vs-desert point in its most concrete form.

🚩 **A third claim is in circulation and has been checked to exhaustion: it is in NEITHER source.** The claim — *"only the bottom quintile lost out; all other quintiles stayed the same or improved"* — was attributed first to Fix, then to FEE. Both articles were inventoried chart-by-chart:

- **FEE** has six figures, all economy-wide aggregates: (1) Warren's wages-vs-productivity 1979–2020, (2) EPI total compensation vs productivity, (3) adjusted data, (4) capital consumption allowances since 1988, (5) Sherk's depreciation since 1973, (6) final aligned series.
- **Fix** has labor's share (Fig 3) and top-1% wage/salary share (Fig 4).

**Neither contains any quintile, decile, or income-group disaggregation.** The claim also conflicts with Fix (loss spread across the bottom **80%**) and with Meyer–Sullivan (bottom did *not* lose in absolute terms).

**Treat as unsourced. Do not deploy.** If the underlying memory is of **Census Historical Income Tables** (mean income by quintile), those typically show *every* quintile rising in real terms over long horizons with the bottom rising least — which supports *"all improved, bottom improved least"* but **not** *"the bottom lost."* Ground it against Census directly before using either version.

**Where Fix goes further than this page follows him:** he treats the share shift as the important phenomenon and proposes rebuilding productivity on **useful work (energy)** rather than money. That's a live research direction (see Open Questions), not a counter-argument to §1 — and adopting his diagnosis does not commit you to his politics.

**Rhetorical note:** because Fix is anti-neoclassical, citing him pre-empts the "you're just quoting libertarian think tanks" dismissal that FEE and AEI invite. In an adversarial room he is the strongest card in the deck, and it is not close.

## 6. The sibling myth — and where the analogy breaks

Chris pairs this with the **gender pay gap**, and the rhetorical shape is genuinely the same:

> **A raw aggregate difference is computed, then deployed as a causal claim about unfairness, with no composition controls and no mechanism.** The number is real; the thing it is asserted to prove is not in it.

Both also share the tell: when someone corrects the comparison, the response is rarely "here is why the correction is wrong" — it is *"you're defending injustice."* The argument is protected by its moral charge rather than its evidence.

⚠ **But they fail differently, and conflating the failure modes hands an opponent a free correction:**

| | Productivity–pay gap | Gender pay gap |
|---|---|---|
| **Error type** | **Identity misread** — compares a total to its own component; the two series are the *same quantity* | **Composition** — two genuinely different populations, genuinely different aggregate earnings |
| **Is the raw number meaningful?** | **No.** It restates labor's share | **Yes.** Aggregate earnings do differ |
| **Where the claim fails** | The comparison never measured desert at all | The raw figure doesn't isolate *why* — occupation, hours, tenure, continuity |
| **Residual after correction** | None to explain — there was no second quantity | A residual typically remains; its interpretation is **contested** |

**So say it precisely:** the productivity–pay gap is a myth in the strong sense — the comparison is category-broken. The gender gap is a myth in the *weaker but still fatal* sense — **the raw gap does not measure discrimination**, and most of it is composition. Claiming "no gap exists" overshoots and is easy to refute; claiming "the raw gap doesn't show what it's used to show" is unassailable.

**The theoretical kill (Chris):** *if women were genuinely cheaper for equal work, why would any firm hire men?* A persistent unexploited wage discount is an arbitrage opportunity, and a competitive market does not leave one lying on the table for decades. To claim it does is to claim the market is systematically inefficient at the one thing it is best at — pricing an input. This is Becker's result: discriminating firms bear a cost and are outcompeted by those that don't.

*(Known counters, for completeness: the arbitrage runs slowly where productivity is hard to observe, mobility is low, or employers hold monopsony power. Those are arguments about the **speed** of the correction, not its direction — and they cut against a gap that has persisted for generations, not for it.)*

⚠ *The gender-gap figures are **not grounded in this vault**. Do not cite specific cents-on-the-dollar numbers, raw or adjusted, without doing that work first. The theoretical argument above needs no figures, which is part of why it's the better one to run.*

**Candidate promotion:** the shared shape — *raw aggregate comparison deployed as a causal claim about unfairness* — looks portable well beyond these two, and may deserve its own thesis page the way [The Supply Omission](./the-supply-omission.md) was promoted out of the Keen debate. It is a close relative of [accounting-identities-as-domain-matching](./accounting-identities-as-domain-matching.md) but distinct: that page is about misreading an identity's *terms as levers*; this would be about misreading an *unconditioned difference as a mechanism*.

## 7. Do real wages at the bottom still grow?

**Kyle Fee, "Dollars and Cents: Real Hourly Wage Growth across the Lower Half of the Wage Distribution"** (Federal Reserve Bank of Cleveland, Community Development, 2026-02-18; DOI 10.26509/frbc-cd-20260218), covering **2015:Q1–2025:Q3**:

> Purchasing power for the **bottom 40 percent** of workers rose about **4.5 percent from 2019 to 2024**, after accounting for elevated inflation.

**Use it precisely — it is narrower than it first looks:**

| | |
|---|---|
| **Supports** | Real wages at the bottom grew over a recent window, net of inflation |
| **Does not support** | Any multi-decade claim; the 1979-onward narrative is untouched |
| **Coverage** | Bottom **40%** — a bottom-decile figure is not verifiable from the public summary |
| **Productivity comparison** | **None.** The report does not compare wages to productivity at all |
| **Tier** | Community Development publication, not peer-reviewed — below Meyer/Sullivan |

⚠ **The report contains its own counterweight**, and an opponent will use it: elevated inflation eroded nominal gains, and a survey of Fourth District community organizations reports LMI financial well-being *continuing to decline*. A May 2026 companion piece is titled **"Paychecks Are Growing, but Are Lower-Wage Workers Better Off?"** — cite the first without knowing the second and you can be answered from the same institution.

### Why "keeping up as a whole" is stronger than it sounds

Chris's summary — *real wages are still growing and keeping up with productivity; maybe not for every individual, but as a whole* — is right, and §1 explains why it is **nearly definitional**. Total compensation and total output are the same pie measured twice. Aggregate compensation *cannot* durably decouple from aggregate output, because the latter *is* the former plus the other factor shares.

So the aggregate claim is safe, and **the entire live question is composition** — who within labor, and labor versus capital. That is exactly where Fix's Figures 3–4 and the top-half consumption findings point. The argument should be stated that way: not "the aggregate held up *despite* the critics," but *"the aggregate had to hold up; the only real question was ever distribution, and that question has a different answer than the chart implies."*

### ⚠ Inflation inequality — the strongest counter to this page's own §7

**"Effective inflation" differing by income is an established literature, not a coined term.** Do not dismiss it as a made-up metric — it has a real evidentiary base and it cuts against part of the argument here.

- **Kaplan & Schulhofer-Wohl**, *Inflation at the Household Level* ([NBER w22331](https://www.nber.org/system/files/working_papers/w22331/w22331.pdf), later *JME*): household inflation rates diverge sharply — an **annual interquartile range of 6.2–9.0 percentage points** — running higher for **lower-income, larger, and older** households.
- **Jaravel (2019)**, scanner data 2004–2015: the top/bottom quintile **income** gap grew ~16% from 2002–2019, but **~23%** once disparate inflation rates are included; and **~2.3 million more Americans** would fall below the poverty line measured against their own inflation. Mechanism: **innovation and product entry concentrated at the high end**, so high-income baskets see more competition and lower measured inflation.

**It strengthens §1 and weakens §7 simultaneously — hold both:**

| | Effect |
|---|---|
| **On §1 (circularity)** | **Strengthens.** If inflation is genuinely heterogeneous, there is no single correct deflator *at all* — Fix's aggregation critique one level deeper. The EPI chart gets worse |
| **On §7 (bottom-decile real gains)** | **Weakens.** CPI-deflated real wage series for the bottom would *overstate* gains. The Cleveland Fed +4.5% is directly exposed |
| **On consumption-poverty collapse** | **Pressure.** Jaravel's 2.3M figure runs against the story in the [debate prep](../debates/poverty-exploitation-prep.md) |

**Honest limits on the counter** (state these, don't hide behind them): the scanner data covers food, household supplies, and beauty/personal care — roughly **10–15% of total household expenditure** — and is generalized beyond that. Refining work using national accounts reaches different conclusions ([*Rethinking Inflation Inequality*](https://www.bls.gov/osmr/research-papers/2025/pdf/ec250040.pdf), BLS 2025; also [Macroeconomic Dynamics](https://www.cambridge.org/core/journals/macroeconomic-dynamics/article/abs/rethinking-inflation-inequality-evidence-from-national-accounts/B94DCFFCC60FAD544F9A45A6939CC9E8)). See also [Minneapolis Fed, 2024](https://www.minneapolisfed.org/article/2024/lower-income-higher-inflation-new-data-bring-answers-at-last).

> **The principle doesn't have a side.** "We measure inflation badly" is this page's own argument. It does not stop applying at the conclusions we prefer — and a version of the case that only deploys measurement skepticism against the other side is the [Ricardian Vice](../debates/keen-pbd-postkeynesian-capitalism.md) the vault already indicts.

### The inflation question isn't a separate harder problem — it's the same one

Chris flags CPI accuracy as the deeper issue. It isn't downstream of this page; **it is §4's deflator mismatch**, which the FEE decomposition puts at ~39% of the gap. Choosing a price index is choosing a basket, and there is no basket-independent "real" anything — [the Weighting Problem](../philosophy/epistemology/weighting-problem.md), the same result driving Fix's aggregation critique.

→ **Worked out in full: [Measuring Inflation — Why Disaggregation Doesn't Save You](./measuring-inflation.md)**, which also supplies the governing rule for this page: **match the deflator to the question.** Deflating wages → consumption basket; deflating output → output index; comparing the two → *you may not use a different deflator on each side.* The productivity–pay chart's central error is answering a production question with a consumption deflator. See also [Inflation](./inflation.md) and the Boskin discussion in [Weinstein × Murphy](../debates/weinstein-murphy-gauge-theory-economics.md).

## Sourcing status

⚠ **Built from fetched article summaries, not immutable `raw/` captures.** Figures attributed below are **as reported by these secondary sources** — trace to the underlying papers before staking anything on a specific number.

- ⭐ **[Debunking the "Productivity-Pay Gap"](https://economicsfromthetopdown.com/2020/01/17/debunking-the-productivity-pay-gap/)** (Blair Fix) — **CANONICAL.** The structural argument (§1, §5). Governs where sources conflict on the nature of the error.
- **[The Myth of the Pay-Productivity Gap](https://fee.org/articles/the-myth-of-the-pay-productivity-gap/)** (FEE) — best walkthrough of §4. Secondary. **Figure inventory** (verified 2026-08-05, so the article's structure needn't be re-derived): 1 — Warren's wages-vs-productivity 1979–2020; 2 — EPI total compensation vs productivity; 3 — adjusted data; 4 — capital consumption allowances since 1988; 5 — Sherk's depreciation since 1973; 6 — final aligned series. **All aggregate; no disaggregation by quintile or income group.**
- **[Mythbusting Is Hard](https://www.aei.org/economics/mythbusting-is-hard-the-continuing-confusion-about-the-supposed-gap-between-pay-and-productivity/)** (AEI) — weakest; carried here only for Lawrence and Stansbury–Summers.
- **Kyle Fee, [Dollars and Cents](https://www.clevelandfed.org/publications/cd-reports/2026/20260218-real-hourly-wage-growth-across-lower-half-of-wage-distribution)** (Cleveland Fed, 2026-02-18) — §7. *Direct URL 403s to automated fetch; findings above are from the abstract and listing pages ([RePEc](https://ideas.repec.org/p/fip/c00034/102455.html), [Fed in Print](https://fedinprint.org/item/c00034/102455)). **Read the PDF before citing specifics.***

## Down-links (specimens this page fed, and what they sent back)

- **[Econ Nerds — "Three Myths about Inequality"](../debates/econ-nerds-inequality-myths.md)** (2026-08-21) — an explainer that reaches this page's PSZ/Auten–Splinter conclusion the long way round, and **confirms the Open-Questions call not to compute our own Gini.** The video's framing is *"the truth is probably somewhere in between"*; this page's is better and should be preferred — the dispute is **definitional, not computational**, so splitting the difference between two estimates is a *frame choice presented as a finding*. The review adds the number the video states but never exploits: **~2/5 of national income never appears on tax returns**, so **the imputation rule *is* the result** and both teams are largely reporting priors about where unseen income sits — the same **underdetermination** shape as [the STV rules finding](../debates/voting-paradox-worked-examples.md) (*the quota picks the council; the imputation picks the trend*). It also records that the exchange has gone **another round** since: PSZ's 2024 comment alleging specific errors in A–S's untaxed-income allocation, and A–S's reply. Chris's standing verdict: *"I doubt this is resolved — 40% of missing data is a lot of slack."* And the review confirms this page's **Piketty-concession card is still the strongest one on the board** — *"even Piketty's own Ginis put the wealth gap below the Gilded Age peak"* — precisely because it wins **without** settling the imputation fight at all.

## Open Questions
- **Recreating Piketty's Ginis ourselves — probably not worth it, and here's why.** The disagreement is **definitional, not computational.** Piketty–Saez–Zucman and Auten–Splinter don't dispute the arithmetic; they dispute pre- vs post-tax, pre- vs post-transfer, the unit of analysis (household vs. tax unit vs. adult), capital-gains treatment, and how to allocate imputed and undistributed income. Computing our own Gini means making those same choices — so we'd reproduce whichever answer our choices imply and become a third disputant rather than an arbiter. **This is [the Weighting Problem](../philosophy/epistemology/weighting-problem.md) again: the basket determines the result.** The tractable version is not "compute a Gini" but "state which definitional choices drive the divergence, and what each implies" — that *is* a genuine contribution and it's a reading task, not a data task.
- **Ground a real quintile series — the source is Census, not FRED** (which is why nothing surfaced there). **Table H-3, "Mean Household Income Received by Each Fifth and Top 5 Percent,"** on [Historical Income Tables: Income Inequality](https://census.gov/data/tables/time-series/demo/income-poverty/historical-income-inequality.html), built from CPS ASEC and available in real dollars. This is the gap the misremembered chart stood in for, and it speaks to *absolute* levels by group — the variable neither canon source covers, and the one that most directly answers "did the poor get poorer."
- **Resolve the inflation-inequality tension.** Jaravel's scanner-data result covers only 10–15% of expenditure and the national-accounts work disputes it. Which is right materially affects §7 and the consumption-poverty story. **This is the highest-value open item on the page** — it is the one place where the evidence currently runs against the argument.
- **§2 still needs direct grounding.** Fix's Figure 2 landed in §1 (it demonstrates NDP ≈ NI, not compensation-tracks-output). What §2 wants is a **compensation-of-employees series from the national accounts** set against net output on the same basis. Chris's formal linkage papers, if they work the labor-share identity explicitly, would close this.
- **Trace Stansbury & Summers directly** — currently held second-hand through AEI.
- **Gilded Age comparison — split the two gaps.** Chris's read (2026-08-05): the **wage** gap is at or near peak levels; the **wealth** gap is still below Gilded Age levels but trending toward it. Keeping these separate is what makes the claim defensible — they are frequently conflated, and the conflation is how "we're back to the Gilded Age" gets asserted from wage data alone.
  - **Provenance — confirmed as Piketty** (Chris, 2026-08-05), via Gini coefficients for wage and wealth inequality, and **Piketty argues the opposite conclusion.** A figure conceded by the leading advocate of the other side is worth more than one from an ally: *"even Piketty's own Ginis put the wealth gap below the Gilded Age peak."* Preserve the provenance whenever the number is used — it is most of the number's value.
  - Still genuinely contested in the literature: Piketty–Saez–Zucman vs. Auten–Splinter differ sharply on top-share trends once tax and transfer treatment is handled. **Do not assert a precise level without doing that work.**
- Does a **physical** productivity measure (Fix's useful-work/energy approach) show a gap? If not, that's the strongest possible form of the argument — linkage demonstrated without any monetary aggregate.
- How much of the labor-share decline is **housing/imputed rent and self-employment mismeasurement**? The residual shrinks further under some treatments.

## Tags
[economics](../../tags/economics.md), [free-markets](../../tags/free-markets.md), [epistemology](../../tags/epistemology.md), [scope-confusion](../../tags/scope-confusion.md)
