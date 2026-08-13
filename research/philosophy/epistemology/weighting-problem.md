---
status: active — formalizing
created: 2026-02-25
published: true
layout: layouts/page.njk
title: "The Weighting Problem"
---
# The Weighting Problem
> Objective measurements do not produce objective composite judgments. The aggregation function is always subjective.

**Links:** [Epistemology](./README.md), [Reading Outcome Statistics](./reading-outcome-statistics.md), [Value and Profit](../../economics/value-and-profit.md), [Scope Confusion](../morality/scope-confusion.md), [Art Objectivity Debate](../../debates/art-objectivity-noerr-strange.md), [Is the Algorithm Fair?](../../debates/wordwar-algorithm-fair-cruz-hamm.md) — the compression case below, and its first dated specimen, [Value/Utility via Evolutionary Game Theory (Evo-Cap)](../../evolutionary-capitalist/value-utility-evolutionary-game-theory.md), [Gauge Theory Applied to Economics (Weinstein x Murphy)](../../debates/weinstein-murphy-gauge-theory-economics.md)

## The Principle

When evaluating anything with multiple measurable attributes, three distinct operations occur:

| Step | Operation | Can it be objective? |
|------|-----------|---------------------|
| 1. **Measurement** | Determine the value of each attribute | Yes — instruments, counts, frequencies |
| 2. **Selection** | Choose which attributes are relevant | No — requires a judgment about what matters |
| 3. **Weighting** | Assign relative importance to each selected attribute | No — requires a valuing mind |

The composite judgment inherits the subjectivity of steps 2 and 3 regardless of how objective step 1 is. Using objective inputs does not make the output objective. The aggregation function — the formula that turns multiple measurements into a single ranking or yes/no determination — is where subjectivity enters and cannot be removed.

### The Core Argument

If a domain has N objective metrics, and any two rational agents can assign different weights to those metrics and reach different conclusions, then the composite determination is not purely objective. The *existence* of persistent expert disagreement in a domain (art critics, legal scholars, moral philosophers, economists) is diagnostic: if the determination were objective, convergence would be expected.

Contrast with domains where convergence *does* occur: measurement of physical constants, mathematical proofs, simple categorization (is this a parrot?). These domains either have a single metric or have a non-arbitrary aggregation procedure.

## Where It Shows Up

### Economics — Subjective Value Theory
The weighting problem *is* subjective value theory, expressed in epistemological terms. A good has multiple objective properties (weight, durability, color, scarcity). The *value* of the good is not derivable from those properties — it depends on which properties the evaluator cares about and how much. This is Menger's insight: value is ordinal, subjective, and exists in the mind of the holder. See [Value and Profit](../../economics/value-and-profit.md).

The baseball card parable from the [art debate](../../debates/art-objectivity-noerr-strange.md): a book says the card is worth $300 (objective measurement of market consensus). But "your card is only worth what someone's willing to pay for it" — the actual value depends on the buyer's weighting function.

### Law — Balancing Tests and Sentencing
Legal standards routinely require weighing multiple factors:
- **Sentencing guidelines** — severity, prior record, remorse, circumstances. Each measurable; the composite sentence is a judgment call.
- **Reasonable person standard** — what would a reasonable person do? Requires weighting competing considerations (caution vs. autonomy, cost vs. safety).
- **Constitutional balancing** — strict scrutiny weighs government interest against individual rights. Both are "objective" in some sense; the balance is not.

This connects to [Legal Theory](../morality/legal-theory/README.md): if legal determinations require subjective weighting, then the aspiration to "objective law" has a ceiling. Restitution (making the victim whole) may be the legal domain most resistant to the weighting problem — the metric is singular (restore what was lost). Retribution and deterrence are where weighting enters.

### Morality — Competing Values
The moral framework faces the weighting problem when values conflict:
- Liberty vs. safety (the classic political spectrum axis)
- Individual rights vs. collective welfare
- Mercy vs. justice
- Present generation vs. future generations

Each value can be articulated and even measured in specific contexts. The *priority ordering* between them when they conflict is the weighting function — and it's where all the political disagreement lives. See [Scope Confusion](../morality/scope-confusion.md): the enforceability gradient is an attempt to resolve the weighting problem for moral claims by tying enforcement scope to utility agreement. If everyone's weighting function converges (don't murder), it becomes law. If weightings diverge (drug policy), it stays at ethics or morality.

### Science — Theory Selection
When multiple theories fit the observed data, scientists choose between them using criteria: simplicity (Occam), explanatory power, predictive accuracy, elegance, unification. Each criterion can be articulated. The *weighting* of criteria is where scientific paradigm disputes live. Kuhn's "incommensurability" is partly a claim that scientists in different paradigms assign different weights to these criteria.

### Ranking & Recommendation — The Compression Case

*Sparked by the Word War round [Is the Algorithm Fair?](../../debates/wordwar-algorithm-fair-cruz-hamm.md) (2026-08-11), where the debate turned entirely on this and neither participant reached it.*

The other sections above show the weighting problem *arising* in a domain. This one shows it being **forced by a cardinality constraint** — which makes it the strongest case on the page, because here the aggregation function is not merely subjective, it is **mandatory**.

Chris's escalation ladder, using the mundane case of a list of products on a website:

| Result-set size | Adequate method | Criterion smuggled in |
|---|---|---|
| Small | List them all, alphabetically | Alphabetical order — arbitrary but harmless *because the user still sees everything* |
| Larger | Categories and a hierarchy | Which category boundaries; what goes on top |
| Large | Search | What counts as a match; how matches rank |
| Very large | Ranked feed | Engagement, margin, recency, novelty — an explicit objective function |

The mechanism: **once a result set exceeds what a human can inspect, it must be compressed into one that doesn't — and compression requires a loss function.** A loss function is a statement of what may be discarded, which is step 2 (selection) and step 3 (weighting) made operational and executable.

Two consequences:

1. **There is no neutral rung on the ladder.** Even alphabetical is a criterion; it merely *appears* neutral because at small N nothing is lost. Neutrality was never a property of the ordering — it was a property of the user still being able to see the whole set. Remove that and the neutrality goes with it, because there is nothing left for "unranked" to mean.
2. **"Unbiased ranking" is not being withheld. It does not exist.** A demand for it is a demand for an aggregation with no aggregation function. This is the page's core principle in its least deniable form: the subjectivity cannot be engineered away, because the engineering *is* the subjectivity.

Hence the operative question is never *"is the ranking neutral?"* but ***"whose loss function is it, and does it serve the goal it claims to?"*** — which is the [conditional-ought escape](#structural-realism-and-the-weighting-problem) doing real work: fix the goal and the optimal weighting becomes assessable; leave the goal contested and the fight is about goals, not about arithmetic.

#### The historical case — the web walked the whole ladder

Web search is the ladder run in real time on a set that grew by orders of magnitude, and every rung was climbed because the previous one broke. Chris's account, with the eras named:

| Era | Rung | What forced the next step |
|---|---|---|
| Early WWW | **Hyperlinks only.** You had to know the address or follow a link from a page that had it | No ranking problem — and no discovery either. Manual navigation doesn't scale past a set you can hold in your head |
| Directories (Yahoo!, later DMOZ) | **Categories and hierarchy**, human-curated | *"Even here one had to determine what category a page should be in"* — the judgment was explicit and performed by hand. Curation cannot keep pace with growth |
| Full-text crawlers (AltaVista, Lycos, Excite) | **Search**, ranked by term frequency and keyword match | The loss function was naive and therefore trivially gamed |
| Google (1998) | **Ranked results via PageRank** — the link graph as an authority signal | The modern "algorithm" proper |

*Two grounding notes on the sequence:* the category/hierarchy rung is **Yahoo!'s directory and DMOZ** rather than AltaVista — AltaVista was a full-text crawler, so it belongs on the search rung with a weak ranking criterion. And Google's breakthrough was ranking *quality* plus a clean interface rather than natural-language parsing as such (Ask Jeeves was the one explicitly marketing question-form queries). Chris's substantive point stands either way: you could type roughly what you meant and reach an obscure document inside an enormous corpus.

**Interface and loss function are independent axes** — a distinction the ladder can obscure, because each generation's front end got friendlier at roughly the same time its ranking got smarter. **Ask Jeeves is the counterexample that separates them:** its natural-language querying was largely a veneer over template matching, with *human-curated* answers behind the popular questions. That put it on the **directory rung wearing a search-rung interface** — and it is why it lost. The rung you occupy is set by *how the candidate set is compressed*, not by how the user is permitted to phrase the request; a better front door does not fix a compression strategy that can't scale.

**PageRank is the clearest possible illustration of this page's thesis.** It did not remove the judgment; it *chose* one — *authority = inbound links, weighted by the authority of the linker.* That is a substantive claim about what makes a page worth seeing, and it beat term-frequency because it was a **better** loss function, not because it was a neutral one.

#### The adversarial extension — why the loss function must be secret and moving

> **Chris:** "it also had to adapt to people trying to **game** the system (early algorithm heavily weighted terms and backlinks, so many pages had these in hidden text only the crawler could see)."

This adds a dimension the rest of the page doesn't have. In art, law, and morality the weighting is *contested* — people argue it should be different. In ranking, the weighted parties **attack the criterion itself**: keyword stuffing and white-text-on-white against term frequency, then link farms and paid links once PageRank made inbound links the currency.

Two consequences follow, and the second is not obvious:

1. **Any published loss function is immediately optimised against, which destroys it as a measure.** This is Goodhart's law with an adversary rather than mere drift — the criterion doesn't decay, it is deliberately dismantled.
2. **Therefore opacity is a structural requirement, not merely corporate secrecy.** A ranking system under adversarial pressure *cannot* publish its weights and continue to work. This matters because "why can't we see what's feeding our feed?" is the strongest complaint available to the critic — and its real answer is neither "trade secret" nor "too complicated," but that a legible criterion is a defeated one. The cost is real and lands on the honest ranked party, who cannot audit a judgment that materially affects them; that cost is the actual grievance, and it is a *governance* problem rather than a fairness-of-arithmetic one.

**The endpoint so far:** large language models compress the corpus into learned weights — the same operation again, one rung further, with the loss function now distributed across billions of parameters and correspondingly less legible even to its owners. The lossiness never went away; it got harder to inspect.

This generalises well past social media — search results, hiring filters, credit scoring, insurance underwriting, content moderation queues, university admissions, triage. Anywhere the candidate set is too large to inspect individually, the same forcing applies.

*It also sharpens an [open question](#open-questions) below:* if an ML system trained on human judgments converges on stable weights, that is not the discovery of a natural weighting function — it is the *inheritance* of the training distribution's weighting, now laundered through a mechanism that looks impartial. The convergence is real; its objectivity is not established by the convergence.

### Art — The Debate That Surfaced This
The [art objectivity debate](../../debates/art-objectivity-noerr-strange.md) is where this principle was derived in real time. Rob Noerr demonstrated it through multiple test cases:
- **Giza vs. Cholula** — Giza wins on more metrics; Cholula wins on sheer size. Who decides which matters?
- **Tom Brady vs. Michael Vick** — one metric (clutch accuracy) can outweigh five others. Why?
- **Football Hall of Fame** — same stats, different expert rankings.
- **Death metal vs. rap** — objective skill within each genre; genre preference is the weighting function.

## Tension With the Vault's Framework

This principle creates a genuine tension with the vault's epistemological commitments:

### The Convergence Argument Under Pressure
The [epistemology stub](./README.md) identifies convergence across independent observers as evidence of objectivity. The weighting problem challenges this: convergence on *measurements* (step 1) is strong evidence. But convergence on *weightings* (step 3) is weaker — it could indicate shared cognitive bias rather than tracking objective truth. Every culture developed rain dances too.

**However:** The convergence argument may survive in a modified form. If independent civilizations converge on the same *priority ordering* of values (don't murder > don't steal > don't lie > personal preference), that's convergence on a weighting function, which is harder to explain by shared bias alone. The ordering is too specific and too consistent to be coincidence. This might mean some weighting functions track real patterns even if weighting *in general* is subjective.

### Structural Realism and the Weighting Problem
Structural realism holds that reality has structure and our formalisms model that structure. The weighting problem asks: does reality have a *ranking structure*, or only a *measurement structure*? If reality contains objective measurements but no objective rankings, then structural realism is true but limited — it tells you what's there, not what matters.

**Possible resolution:** Reality might contain *conditional* rankings. "If your goal is X, then weighting W is optimal" could be an objective fact. This would make the weighting problem dissolve under specified goals and persist only when goals themselves are contested. This is the "conditional ought" structure already present in the [morality framework](../morality/README.md): "if you want to survive, then don't murder" is an objective conditional even if "you should want to survive" is not.

### What This Might Prove
Three possible outcomes:

1. **Subjectivity is irreducible at the composite level.** Measurements can be objective; rankings cannot. This doesn't destroy the vault's framework — it constrains where objectivity lives. Morality, law, and value have objective *components* but subjective *composites*.

2. **The conditional-ought escape works.** Weighting is subjective only because goals are subjective. If you fix the goal, the optimal weighting becomes objective. The remaining question is: can goals themselves be grounded? (This is the is-ought gap again.)

3. **Convergence of weightings is itself evidence of objective ranking structure.** The near-universal priority ordering of values across civilizations isn't explained by shared bias. It tracks real patterns in what works for survival and flourishing. Subjectivity exists at the margins (art, cuisine, lifestyle); the core is objective.

These aren't mutually exclusive. The answer might be: outcome 3 for the core, outcome 1 for the margins, and outcome 2 as the bridging principle.

## Formalization Needed

1. **Distinguish measurement-convergence from weighting-convergence.** When experts converge, is it on the measurements or on the weights? These provide different evidence for objectivity.

2. **Identify domains where weighting is non-arbitrary.** Are there domains where the aggregation function is determined by the structure of the problem? (Candidate: engineering — the weighting of bridge safety metrics is constrained by physics, not preference.)

3. **Test the conditional-ought escape.** If you specify a goal (maximize human flourishing, minimize suffering, maximize profit), does the optimal weighting become objectively determinable? If so, the weighting problem reduces to the is-ought gap: the measurements and the weightings can both be objective once you accept the goal.

4. **Catalog the weighting problem across vault domains.** Each instance (economics, law, morality, science, art) may have different characteristics. Some may be more resistant to the problem than others.

## Open Questions

- Is the weighting problem the *same* problem as the is-ought gap, or a sibling?
- Can machine learning find "natural" weighting functions from data? If an algorithm trained on all human art judgments converges on stable weights, does that constitute objectivity or just aggregated subjectivity?
- Does the weighting problem apply to single-metric domains? Or only multi-attribute ones? (Murder is wrong — is this a single-metric judgment or does it have hidden weights?)
- Where does the weighting problem sit relative to Agrippa's trilemma? Is the weighting function itself subject to the regress? (Why these weights? Because of these meta-weights. Why those meta-weights? ...) **Partial resolution:** The core weighting (convergent norms) escapes the regress via [performative grounding](../morality/README.md#the-resolution-performative-grounding-2026-02-28) — the actor questioning the weighting is already demonstrating it. The marginal weightings remain genuinely subjective, which is consistent with outcome 3 above.

## Tags
[philosophy](../../../tags/philosophy.md), [epistemology](../../../tags/epistemology.md), [economics](../../../tags/economics.md), [morality](../../../tags/morality.md)
