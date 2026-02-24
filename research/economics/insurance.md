# Insurance
> Insurance has exactly one legitimate function — hedging catastrophic, low-probability events. Everything else it does makes things worse.

**Status:** stub
**Created:** 2026-02-23
**Links:** [Economics](./README.md), [Risk and Entrepreneurship](./risk-and-entrepreneurship.md), [Value and Profit](./value-and-profit.md), [Monopoly Project](../../projects/monopoly/README.md), [Bilateral Trade Valuation](../gaming/bilateral-trade-valuation.md)

## The One Thing Insurance Does Right

Insurance is a mechanism for transferring tail risk — events that are rare but catastrophic if unhedged. This is the *only* scenario where pooling risk creates genuine value.

The structure is simple:
- **Low probability**: most participants never experience the event
- **High severity**: those who do experience it face ruin without coverage
- **The premium**: the cost of participating in the pool, which buys protection against ruin

The many who don't experience the event fund the few who do. Everyone is better off ex ante because the expected cost of the premium is less than the expected cost of unhedged ruin.

### Worked Example: Monopoly Cash Reserves

The [Monopoly AI project](../../projects/monopoly/README.md) produced a concrete demonstration of this principle. When analyzing optimal cash reserves (the "insurance premium" against landing on an opponent's developed property):

**The liquidity curve is sharply convex:**

| Shortfall Size | Effective Cost | What Covers It |
|---------------|---------------|----------------|
| $50–$200 | 0.10–0.16x | Mortgage buffer (cheap) |
| $300–$500 | 0.17–0.53x | Mortgage + some house selling |
| $600 | ~1.0x | **Crossover point** |
| $750+ | 2.3–6.2x | House selling, bankruptcy risk |

For small, routine shortfalls: the cost is trivial (0.1x). Insurance adds no value here — you can self-insure for essentially nothing.

For catastrophic shortfalls ($750+): the cost explodes to 2–6x. This is where "insurance" (holding cash reserves) earns its keep. Without it, a single bad roll causes liquidation spirals that lose the game.

The optimal strategy uses a flat 1.0x risk loading across all shortfall sizes — which overcharges on routine events and uses the surplus to fund catastrophic protection. This is exactly how insurance premiums work. And it's the *only* version that produced statistically significant improvement (Z=2.28 vs static reserves).

## The Problem: Mission Creep

Insurance gets applied far beyond its legitimate domain. When insurance covers **high-probability events**, it stops being risk transfer and becomes a **shared payment pool with overhead**.

- Health insurance covering routine checkups and prescriptions
- Car insurance covering minor fender benders
- Home warranties covering appliance breakdowns

These events aren't rare. They're expected costs of living. "Insuring" against them is like "insuring" against needing groceries — you're just prepaying through a middleman who takes a cut.

The Monopoly data shows this clearly: for shortfalls under $200, the effective cost is 0.1x. Self-insuring (holding your own small reserve) costs almost nothing. Running those through a shared pool adds administrative overhead, adverse selection, and moral hazard — all for an event you could handle yourself at 10% of the cost.

## The Free Rider Problem

When insurance pools cover routine, high-probability events, they become shared pots of money. Shared pots invite over-consumption:

- "I'm paying premiums, so I should use the coverage" — even for things you'd skip if paying out of pocket
- No price signal at point of consumption — the disconnect between paying (monthly premium) and consuming (at the doctor/mechanic) destroys the feedback loop that keeps markets efficient
- Those who consume more are subsidized by those who consume less, with no mechanism to correct the imbalance

This is textbook moral hazard: insulating people from the cost of their choices changes their behavior in ways that increase total cost for everyone.

## The Risk Class Paradox

Insurance pools face a fundamental tension in how they classify risk:

**If risk classes and premiums become perfectly specific to the individual:**
- Your premium reflects YOUR expected cost
- You're just prepaying for your own anticipated expenses through a middleman
- What risk are you actually sharing? None. It's a savings account with overhead.

**If risk classes are broad and premiums are pooled:**
- Low-risk participants subsidize high-risk participants
- Risk-avoiders are penalized for their prudence
- Risk-takers are rewarded for their recklessness
- This inverts the natural incentive structure — you want society to reward risk avoidance, not punish it

There is no middle ground that resolves both problems simultaneously. The more actuarially accurate you get, the less "insurance" you're providing. The more you pool risk, the more you distort incentives.

## Connection to Risk and Entrepreneurship

From [Risk and Entrepreneurship](./risk-and-entrepreneurship.md): "Risk cannot be eliminated — only managed." Insurance is one tool for risk management, but it's a narrow tool with a narrow domain:

- **Legitimate**: catastrophic, low-probability, high-severity events where self-insurance is impractical (house fire, major medical emergency, liability lawsuit)
- **Illegitimate**: routine, predictable expenses where self-insurance is trivially cheap (oil changes, dental cleanings, minor repairs)

The entrepreneur's relationship with risk is instructive. The entrepreneur doesn't insure against business failure — they accept the risk, manage it through judgment and structure, and earn profit as the reward for bearing it correctly. Insurance for routine events eliminates this feedback loop: you never learn to manage risk if someone else always absorbs the cost.

## Open Questions
- Where exactly is the line between "catastrophic tail" and "routine expense"? The Monopoly data suggests it's where the liquidity curve crosses ~1.0x — the point where self-insurance becomes expensive. Can this be generalized?
- How do mandatory insurance requirements (health, auto) interact with the free rider problem? Does mandating participation in a flawed pool make the distortions better or worse?
- What would a market look like if insurance were restricted to its legitimate domain (catastrophic events only)?
- How does the insurance critique connect to the broader price system argument? Insurance premiums that don't reflect individual risk are distorted price signals.

## Tags
[economics](../../tags/economics.md), [risk](../../tags/risk.md), [insurance](../../tags/insurance.md)
