# Property Allocation as an Evolutionary Equilibrium: A Comparative Advantage Bidding System
> He reinvents the price system, calls it something new, and doesn't notice the central planner hiding behind the curtain.

**Status:** complete
**Created:** 2026-03-13
**Source:** [YouTube video](https://www.youtube.com/watch?v=inZEc3GLzD8) (5:48, uploaded 2026-02-17, 11 views)
**Links:** [Channel Overview](./README.md), [Hierarchy of Ownership](./hierarchy-of-ownership.md), [Value and Profit](../economics/value-and-profit.md), [Nash Bargaining Problem](../gaming/nash-bargaining-problem.md), [Computation and Information Theory](../computation-and-information.md), [The Godel Governance Problem](../philosophy/the-godel-governance-problem.md)

## His Argument (Steel-Manned)

Property should be allocated to maximize total productivity, and this requires accounting for opportunity costs — not just gross output.

### The Mechanism

1. Two parties compete for an asset. The current holder produces X with it.
2. If displaced, the holder reallocates capital/labor elsewhere and produces Y. The real cost of displacement is X - Y (net productivity loss).
3. The challenger also has alternative uses. Their bids elsewhere reveal those alternatives.
4. A transfer is justified **only if** total system output increases after accounting for the displaced party's net productivity loss.
5. Crucially: **the highest gross bidder doesn't automatically win.** A lower bidder can retain the asset if their comparative advantage is stronger — losing it causes them a greater net loss than the gain from transferring it.

### The Equilibrium

When no further reallocation can increase total output after accounting for all participants' alternatives, the system reaches "evolutionary equilibrium." This is continuous, not static — assets migrate over time as opportunity costs shift.

## Vault Assessment

### The False Premise: "Prices Don't Account for Opportunity Cost"

His entire framework rests on the implicit claim that the existing price system fails to incorporate opportunity costs — that property allocation through markets is blind to alternatives. This is flatly wrong.

**Prices ARE opportunity costs made visible.** Every bid, every offer, every market price is an expression of what the bidder is *giving up* to acquire this asset instead of something else. A bid of $500k on a property means the buyer values it more than the $500k worth of alternatives they're forgoing. The seller's ask price reflects what they'd need to make it worth surrendering the property's future returns. The entire price discovery process is opportunity cost discovery. That's what prices *are*.

He's built a 6-minute video proposing a system to solve a problem that the price mechanism already solves — and solved first.

### The Core Problem: He Just Described the Market

Everything he describes is what a functioning price system already does. This is not a new discovery — it's a rediscovery, missing the mechanism that already implements it.

**His "evolutionary equilibrium" is Pareto efficiency.** "No reallocation can increase total output after accounting for all participants' alternatives" is a restatement of Pareto optimality. The First Welfare Theorem already proves that competitive markets converge to Pareto efficiency under standard conditions. He's named an existing result.

**The [Nash Bargaining Problem](../gaming/nash-bargaining-problem.md) already formalizes this.** The vault's analysis: bilateral trade outcomes depend on each party's outside option (BATNA). The outside option IS the opportunity cost he's describing. Nash bargaining theory already shows that surplus is divided according to relative alternatives. His "comparative advantage bidding" is Nash bargaining with extra jargon.

### The Hidden Central Planner

The critical question he never answers: **who calculates the comparative advantage rankings?**

In his system, a "lower bidder can rightfully retain the asset" if their comparative advantage is stronger. But who determines this? Who measures "net productivity loss" across all participants? Who decides that the higher bidder's money doesn't count because the lower bidder's displacement cost is larger?

There are only two options:

1. **The market does it through prices** — in which case his system reduces to "let the market work," which is not new and doesn't require his framework
2. **An authority calculates and enforces it** — in which case this is central planning wearing a comparative advantage costume

He seems to want option 2 without admitting it. The moment you override a willing buyer and willing seller because a third-party calculation says the reallocation is net-negative for "total system output," you need a planner. This is the [Godel Governance Problem](../philosophy/the-godel-governance-problem.md): who runs the bidding system, and what prevents them from becoming the monopoly?

### The Calculation Problem

His displacement cost calculation is computationally irreducible (see [Computation and Information Theory](../computation-and-information.md)):

- To know if displacing Alice is justified, you need to know her "next best use" output
- Her next best use depends on what's available, which depends on what everyone else is doing
- What everyone else is doing depends on their allocations, which depend on the same calculation applied to them
- This is an n-body problem — you can't solve it without running the actual economy

Markets solve this through **iteration**: prices adjust, participants respond, prices adjust again, converging toward equilibrium through millions of independent decisions. No one needs to calculate the global optimum. His system appears to require solving it analytically — which is Hayek's knowledge problem. The information needed to compute "total system output" is dispersed across millions of minds and cannot be aggregated by any central process.

### The Subjective Value Problem

He uses "productivity" and "output" throughout as if these are objectively measurable. But output in what units? Physical goods? Dollar value? Utility?

- If dollar value: then the highest bidder in dollars already wins in a market, and his system adds nothing
- If physical output: who compares apples to steel? You need a common unit, which is... price
- If utility: subjective and unmeasurable, so the calculation can't be performed

Every road leads back to prices as the only workable aggregation mechanism — which is the market he's trying to replace.

### The Smuggled Utilitarianism: Self-Agency Erased

This is the deepest problem and it connects directly to his channel name: "Evolutionary Capitalism-**Utilitarianism**."

His allocation rule — "a transfer is justified only if total system output increases" — is aggregate utility maximization wearing economic language. Every time he says "net productivity loss," "total system output," or "aggregate output maximization," he's saying "what's best for society" without using those words.

The consequences are severe:

1. **Your property isn't yours.** Under his system, you hold an asset only as long as no one else can demonstrate a stronger "comparative advantage" in using it. Your ownership is conditional on a continuous group-welfare calculation. This isn't property rights — it's a revocable license from the collective.

2. **Everyone else's wishes are smuggled into your property.** When he says the allocation must account for "the productivity adjustments of all affected parties," he's importing every other person's preferences, plans, and opportunity costs into the question of whether YOU keep YOUR asset. Your property decisions are no longer yours to make — they're subject to a system-wide optimization function.

3. **Self-agency disappears.** In a property rights system, you decide what to do with your property. You might use it "inefficiently" by someone else's measure — run a hobby farm instead of a strip mall — and that's your right, because it's YOUR property. Under his system, that "inefficient" use is a misallocation that the comparative advantage mechanism should correct. Your preferences about your own life don't enter the calculation. Only "total system output" matters.

4. **This is the [Sheriff Problem](../debates/utilitarianism-sheriff-counterexample.md) applied to property.** The vault has already shown why aggregation-based morality breaks: you can always sacrifice the individual for the group total. His system does exactly this — if displacing you from your land increases "total system output," the displacement is "justified." The individual is subordinated to the aggregate.

He started by critiquing Rothbard for subordinating self-ownership to land ownership. His alternative subordinates *both* self-ownership and land ownership to group utility. He's replaced one hierarchy with a worse one.

### What He's Actually Circling Around

Strip away the novel terminology and he's asking a real question: **can we do better than first-come-first-served (Lockean homesteading) for initial property allocation?**

This is a legitimate question. The vault's conflict avoidance framework says first use is the *least arbitrary* norm, not the *optimal* one. There may be better allocation rules. But his proposed alternative — comparative advantage bidding with net productivity calculations — either reduces to the existing market mechanism or requires an omniscient planner. The market is already the continuous comparative advantage discovery process he's describing. He's built an elaborate description of what prices do.

## The Vault's Position

Property rights are the **rules of the game** (who can exclude whom, how transfers work). Property allocation is the **outcome of the game** (who ends up with what). Free markets use property rights + voluntary exchange to produce efficient allocation. He's trying to design the allocation directly, which inverts the relationship — you'd need to override voluntary exchange when it produces the "wrong" allocation, which requires authority, which is governance, which is the Godel problem.

The market already accounts for comparative advantage, opportunity costs, and net productivity. It does so without requiring anyone to calculate "total system output." That's the whole point.

## Tags
[philosophy](../../tags/philosophy.md), [economics](../../tags/economics.md), [libertarian-law](../../tags/libertarian-law.md)
