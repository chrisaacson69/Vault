---
status: active
created: 2026-05-05
updated: 2026-05-05
---
# M.U.L.E. — The Store & Price Dynamics
> One supply/demand formula, four very different price regimes. **Food and Energy** are stable because *player inventory counts as supply* — hoarding dampens prices. **Smithore** is volatile because there's no inventory dampening + a per-round natural variation. **Crystite is a casino** — `50 + rand(0..99)`, pure noise, no supply/demand at all. The store maintains a universal $35 buy/sell spread (except Crystite at $140). Energy spoils slower than Food (3/4 retained vs 2/4) — Energy is the better stockpile good.

**Links:** [M.U.L.E. README](./README.md), [Memory Map](./01-memory-map.md), [Production Economy](./05-production-economy.md), [Bringerp's The Store section](http://bringerp.free.fr/RE/Mule/mule_document.html#TheStore), [Utopia Building Economy](../utopia/05-building-economy.md), source: [`source/mule.asm`](./source/mule.asm)

## The universal supply/demand formula

Bunten's price-update model is one elegant equation, applied with different inputs per good:

```
new_price = old_price × (0.25 + 0.75 × ratio)
where ratio = total_supply / total_demand
```

- `ratio = 1`: price unchanged (`0.25 + 0.75 × 1 = 1.0`)
- `ratio = 2` (excess supply): price drops to `0.25 + 1.5 = 1.75 × old` ... wait, that's *higher*. Let me re-read.

Actually re-reading bringerp's text: `ratio` here means **demand/supply** — when supply exceeds demand, ratio < 1 and price falls. The formula is:

```
ratio = total_demand / total_supply (when phrased as "is there enough?")
new_price = old_price × (0.25 + 0.75 × ratio)
```

So:
- `supply == demand` → `ratio = 1` → no change
- `excess supply` (supply > demand) → ratio < 1 → price falls
- `shortage` (supply < demand) → ratio > 1 → price rises

The **0.25 + 0.75 weighting** is the dampening — only 75% of the price moves with supply/demand each round; 25% sticks at the old price. **One round of mismatch doesn't crash or spike prices fully** — it takes ~3 rounds of consistent imbalance for a price to converge to the new equilibrium. **Bunten built in price stickiness deliberately.**

For Smithore specifically, the ratio is **bounded `]0.25, 3.0]`** — capped to prevent extreme swings. No such bound on Food or Energy.

## Per-good price minimums (the floor)

| Good | Real-game minimum | AI-simulation minimum |
|---|---|---|
| Food | $30 | $10 |
| Energy | $25 | $10 |
| Smithore | $50 | $50 |
| Crystite | (no formula floor; min $20 after variation per source notes) | — |

**Floors prevent goods from becoming worthless.** Food can never drop below $30 even in massive oversupply. The AI's simulation uses lower floors for Food/Energy ($10) — meaning AI considers worst-case-cheap when planning, but the actual store always charges at least $25-30. **This makes the AI conservative in production planning** (assumes prices may crash) while the player faces a more stable real-game environment.

## Food price — the inventory-dampened good

Bringerp's algorithm for Food, in plain language:

1. For each player, compute end-of-round held quantity:
   - **Usage**: subtract this round's required Food (clamped at 0)
   - **Spoilage**: multiply remaining by `2/4` (= half spoils)
   - **Production**: add this round's produced Food
2. **Total supply = store quantity + sum of all player-held quantities** (after the 3 phases above)
3. Total demand = next round's required Food × 4
4. Apply the supply/demand formula with the Food floor ($30 real, $10 simulated)

**The critical detail**: player inventory counts as supply. **A player who hoards Food keeps the global Food price low** — even when the store is empty, if players collectively hold lots of Food, the price doesn't spike because the *available supply* (counting hoards) is high.

This is **anti-corner protection.** A would-be Food monopolist who tries to corner the market by holding all available Food can't drive up prices — their hoarding *suppresses* prices instead. Brilliant: the design discourages exactly the strategy that would break the auction system.

## Energy price — same model, slower spoilage

Same algorithm as Food, with two modifications:

- **Required is per-player** (not per-round-aggregate). Each player's Energy requirement is computed individually based on their non-Energy exploitation count (Chapter 5).
- **Spoilage = 3/4** (only 1/4 evaporates per round, vs Food's 1/2). Energy keeps better.
- **Total demand = sum of per-player needs + 4** (the +4 reserves Energy for next round's potential new exploitations).

**Energy is the stockpile good.** Half-life is roughly 4 rounds (`(3/4)^4 ≈ 0.32`) vs Food's 1 round (`(2/4)^1 = 0.5`). A player can save Energy across rounds; Food spoils too fast for long-term storage. **This subtly biases the auction toward "always sell Food now, always be willing to hold Energy."** Food sellers can't wait; Energy sellers can.

## Smithore price — supply/demand without inventory + natural variation

Smithore is structurally different. Bringerp's algorithm:

1. **Mule supply** = store mules + half of store Smithore (Smithore is the raw material; the store can manufacture mules from it).
2. **Mule demand** = `calcMuleReq()` for real-game; for AI simulation, fixed at 5.
3. Apply supply/demand formula (ratio bounded [0.25, 3.0]) with floor $50.
4. **Apply natural variation unless Beginner level:**
   - Binomial distribution amplitude 2, multiplied by 7
   - Variation values: -28, -21, -14, -7, 0, +7, +14, +21, +28
   - Probabilities: 0.013% / 0.562% / 6.248% / 24.303% / 37.748% / 24.303% / 6.248% / 0.562% / 0.013%
5. Floor at $20 after variation.

**Two key differences from Food/Energy:**
- **No player-inventory dampening.** Players holding Smithore doesn't lower prices. So a Smithore corner *does* drive up prices — the strategy that doesn't work for Food works for Smithore.
- **Random variation every non-Beginner round.** ±$28 is a big move ($14-$28 = ~30% swing on a $50-100 base price). **Smithore is the volatile industrial good.**

The next-round mule requirement formula:

```
mule_demand = min(8, max(0, free_lands_takeable_next_round (capped at 4)
                          + parcels_without_exploitation_needing_mule))
```

So as the game progresses and players settle on lands, mule demand drops — the *industrial age* gives way to the *production age*. **Smithore prices generally peak mid-game, when many players are still installing mules.** Late-game Smithore is worth less.

## Crystite price — pure noise, the casino

```
crystite_price = 50 + rand(0..99)
```

That's it. **No supply/demand. No production tracking. No inventory effect. Pure RNG between $50 and $149 each round.**

This explains why Crystite is the *speculative* good Chapter 1 flagged. There's no mechanic that lets you predict next round's Crystite price — it's a coin flip. **Crystite is a literal lottery layered on top of the production economy.**

Strategic implications:
- A Crystite specialist faces 3× price variance per round (worst case $50, best case $149 = 2.98× span).
- Holding Crystite is gambling — you can't tell if next round will pay more or less.
- The only stable Crystite strategy is to sell *immediately* when prices are high.
- **Crystite is the only good where market timing matters more than production efficiency.**

## Per-good store buy/sell spread

| Good | Store buy price | Store sell price | Increment per cursor pixel |
|---|---|---|---|
| Smithore | Current | Buy + **$35** | $1 |
| **Crystite** | Current (multiple of 4) | Buy + **$140** | **$4** |
| Food | Current - $15 | Buy + $35 | $1 |
| Energy | Current - $15 | Buy + $35 | $1 |

**The store as universal market-maker:**
- Buys from players, sells to players.
- Spread = profit margin to the store (= cost to players who buy and sell).
- Standard spread is $35; Crystite is $140 (4× wider) because of Crystite's volatility — store needs higher margin to handle the price risk.
- Food/Energy buy from players at a $15 discount below current price (additional margin); Smithore/Crystite buy at exactly current price (no buying discount).

**The increment per cursor pixel matters for auctions** (Chapter 7): cursor position sets the bid, and the bid moves $1/pixel for most goods, **$4/pixel for Crystite**. So Crystite bids move 4× faster — small cursor adjustments produce big price changes. **Crystite auctions are tactically twitchy** in a way other goods aren't.

## The four price regimes — a comparative summary

| Good | Demand pressure | Supply factor | Inventory dampening | Random variation | Crash floor | Spike potential |
|---|---|---|---|---|---|---|
| **Food** | Mandatory (player consumption) | Production + held | Yes | None | $30 | Capped by inventory |
| **Energy** | Mandatory (production multiplier) | Production + held (slow spoil) | Yes | None | $25 | Capped, but slower |
| **Smithore** | Industrial (mule production) | Store + half Smithore | **No** | ±$28 per round | $20 | Real (corner-able) |
| **Crystite** | None (pure speculation) | None | None | $50-$149 RNG | $50 | Random each round |

Four goods, four different price regimes. **Bunten built variance increasing from Food → Energy → Smithore → Crystite**, mirroring the demand-certainty decreasing in the same direction. **Risk and reward are explicitly designed to scale together.**

## Strategic frontier — the specialist viability map

With prices now exposed, the question of "which specialty pays off" gets a tentative answer:

### Food specialist
- Stable income (can never crash below $30)
- Capped upside (player hoarding suppresses spikes)
- Reliable demand (every player needs it every round)
- **Best path: River-cluster Food production for max EBPC × specialization bonuses**
- Risk: If everyone over-produces Food, price floor still holds at $30; you just sell less

### Energy specialist
- Slightly less stable than Food (player hoarding works but slower-moving)
- Better stockpile (4-round half-life vs Food's 1)
- Reliable demand (every non-Energy exploitation needs 1 unit)
- **Best path: Plain Energy clusters (EBPC 3 vs Mountain's 1)**
- Risk: Same as Food — capped upside

### Smithore specialist
- Volatile prices (±$28/round + supply/demand swings)
- Can be cornered (no inventory dampening) — strategic timing matters
- Demand drops late-game (mule requirement decreases)
- **Best path: 3-Mountain land clusters for max EBPC (4) × bonuses**
- Risk: If you hold Smithore and prices drop $28, that's $28 per unit gone

### Crystite specialist
- Pure casino (50-150 RNG)
- 4× volatile bid increments
- Requires Assay to know if a tile is worth mining (hidden state)
- **Best path: gamble on lucky Assays, sell immediately on high-roll rounds**
- Risk: A bad RNG run can crater your earnings

**Pre-empirical hypothesis (to be tested in Chapter 7.5):** Food specialization is the dominant safe strategy; Smithore the dominant aggressive strategy; Crystite the dominant gamble; Energy the dominant defensive strategy (covers your own production needs + steady income from selling surplus). Pure Crystite specialists likely lose to Food/Energy specialists on average, but win occasionally on hot RNG runs.

## Curiosities

**The supply/demand formula is one line.** `price × (0.25 + 0.75 × ratio)` is the entire pricing engine for Food/Energy/Smithore. Bunten wrote one function and parameterized it across goods. **Code reuse and conceptual reuse aligned** — the same equation works because the *concept* (market clearing) is the same.

**Crystite's RNG-only price is the design honesty move.** Bunten could have invented some pseudo-supply/demand model for Crystite. He chose pure RNG — admitting that speculative goods have no rational price discovery. **It's a lesson in market efficiency: not all goods have meaningful prices.**

**The Beginner difficulty removes Smithore variation entirely** (the natural variation step is skipped). So Beginner Smithore is purely supply/demand — much more predictable. Combined with the Production-variance-by-level finding (Beginner = 0 variation), **Beginner mode is mostly a deterministic game** — players learn the formulas without RNG noise. Then Standard adds production noise, Tournament adds production noise + Smithore price noise.

**Energy's $25 floor vs Food's $30 floor** suggests Bunten wanted Energy to be cheaper at the bottom — possibly to keep early-game costs manageable for players whose Energy needs scale linearly with their other exploitations. A new player buying Energy doesn't want to face a $30 floor when they're broke.

**The +4 in Energy demand** ("for future exploitations") is a *forward-looking* component. Energy demand assumes the player will install one more exploitation next round. This nudges Energy prices slightly higher than current need, **stabilizing supply for actual future expansion**.

## What this clarifies for later chapters

- **Chapter 7 (auctions)**: bids on each good run on the cursor mechanic with the $1 or $4 per-pixel increment. The bid floor is the store's buy price; the ceiling is the store's sell price. Players intermediate between these two via auction.
- **Chapter 7.5 (your strategic-frontier analysis)**: with EBPC × terrain (Ch 5) AND price formulas (Ch 6) both exposed, the cost-per-unit-produced and revenue-per-unit-sold of each strategy is computable. The Food vs Smithore vs Energy vs Crystite tradeoff becomes a literal spreadsheet exercise.
- **Chapter 8 (synthesis)**: the four-regime price design is a Bunten signature. The Crystite-as-RNG choice is design philosophy worth highlighting.

## LLM-interpretation log

| Source of understanding | Where it carried |
|---|---|
| **Source labels alone** | Limited — the price-update routines live in cartridge ROM at addresses with mostly auto-labels. The semantic anchors are the `playersGoodReq` array and `byte_91` (current auction good). |
| **Source comments (French)** | Almost everything — bringerp's text IS in French in this section, with full algorithm explanations and the variation-distribution tables. |
| **6502 / Atari ISA knowledge** | None new. |
| **Bringerp's documentation** | **The chapter.** All four price algorithms came from his text. Without it, deducing Crystite's `50 + rand(0..99)` from raw 6502 would require finding the right RNG call site and confirming nothing else affects Crystite price. He just states it. |
| **External economics knowledge** | The "supply/demand ratio with price stickiness" pattern is recognizable from real economics (sticky prices, partial-adjustment models). Bunten's `0.25 + 0.75 × ratio` is exactly the form economists use for partial-adjustment pricing. |
| **Disagreements with source** | None — bringerp's text is bilingual (French/English) but consistent. The numerical constants (spreads, floors, variation amplitudes) are precise. |

Net for the project hypothesis: **Bringerp's doc is doing the heavy lifting on the algorithmic layer; we add the strategic-frontier interpretation and the Utopia comparison.** This is the cleanest example of Path C in action — the mechanism is already documented; we explain what it *means* strategically.

## Tags

[games](../../../tags/games.md) · [strategy](../../../tags/strategy.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [llm-limitations](../../../tags/llm-limitations.md) · [economics](../../../tags/economics.md)
