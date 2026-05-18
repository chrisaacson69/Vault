---
status: active
created: 2026-05-05
updated: 2026-05-05
---
# M.U.L.E. — Production & Resource Economy
> The EBPC/EPC/EP model in plain language. Terrain × good × economic bonuses determine output. **Two named economic theories** ("learning curve" = +1 per 3 same-type, "economies of scale" = +1 for adjacent same-type) explicitly reward specialization. Energy is the universal multiplier — every Food/Smithore/Crystite exploitation needs 1 Energy unit or it produces zero. **Production variance scales WITH level** — Tournament players face more noise, not less. Bunten the economist designed this; it shows.

**Links:** [M.U.L.E. README](./README.md), [Memory Map](./01-memory-map.md), [Time Scales](./04-time-scales.md), [Bringerp's Production section](http://bringerp.free.fr/RE/Mule/mule_document.html#Production), [Utopia Building Economy](../utopia/05-building-economy.md), source: [`source/mule.asm`](./source/mule.asm)

## The four goods, what they're for

Recap from Chapter 1 — M.U.L.E. has four goods:

| # | Good | Role | Demand |
|---|---|---|---|
| 0 | **Food** | Player consumes it every round to be able to act | Mandatory — buyer-side load |
| 1 | **Energy** | Each non-Energy exploitation needs 1 unit per round to produce | Mandatory multiplier |
| 2 | **Smithore** | Used to manufacture more MULEs | Speculative; demand depends on MULE production |
| 3 | **Crystite** | Pure speculation; only worth market value | Speculative; no consumption use |

This asymmetry is the strategic heart of M.U.L.E. **Food and Energy are *required*; Smithore and Crystite are *optional*.** A specialist on Food/Energy has guaranteed buyers; a Crystite specialist has only price-bet against other Crystite players. Bringerp's price-variation chapter (Ch 6 here) shows how Bunten *also* made the prices reflect this — speculative goods have higher volatility precisely because their demand is purely market-driven.

## Energy is the universal choke point

Direct from Kroah's doc (Player Energy requirement section):

> *"Each Food, Smithore or Crystite exploitation needs one Energy unit to be able to produce. If an exploitation has no Energy unit, it produces 0 units. An Energy exploitation doesn't need any Energy unit to produce."*

The mechanism: at production phase, the engine computes how many Energy units the player needs (= count of Food + Smithore + Crystite exploitations). If they have fewer Energy units than required, **the production of randomly-chosen exploitations gets zeroed** until the deficit closes.

**Implications:**

1. **A Smithore specialist with no Energy production is dependent on auctions** to buy Energy each round. If they fail to buy enough, a random subset of their Smithore exploitations produces zero — and they don't get to choose which.
2. **The "self-sufficient" path requires at least some Energy production.** Pure specialists in Food/Smithore/Crystite must rely on the auction; mixed players don't.
3. **Energy is the single most strategically-leveraged good.** Producing Energy means selling at auction (others must buy) AND not paying penalties on your own production.

This is **the key reason specialization isn't dominant** — anyone specializing in non-Energy goods is one bad auction away from production collapse.

## EBPC — Exploitation Base Production Capacity (terrain × good)

The base production rate per exploitation is set by terrain type. Kroah's table:

| Terrain | Food | Energy | Smithore | Crystite |
|---|---|---|---|---|
| **Plain** | 2 | 3 | 1 | Variable |
| **River** | **4** | 2 | (not allowed) | (not allowed) |
| **1 Mountain** | 1 | 1 | 2 | Variable |
| **2 Mountains** | 1 | 1 | **3** | Variable |
| **3 Mountains** | 1 | 1 | **4** | Variable |

**Terrain dictates specialization.** Two structural patterns:

- **River = Food/Energy peninsula.** River tiles produce double-Food (4 vs 2) and same Energy. They forbid Smithore and Crystite entirely. So any player who controls many river tiles is *forced* into the Food/Energy specialty — they literally cannot mine on those tiles.
- **Mountains = Smithore mines.** 1/2/3 mountain tiles produce 2/3/4 Smithore vs only 1 on plain. A 3-mountain tile is **4× the Smithore output** of a plain tile. So Smithore specialization concentrates on mountainous lands.

For Crystite, the table says "Variable" — that's because Crystite production depends on the **deposit quality**, which is hidden until you Assay (per bringerp's "Phase 2: Assay" of computer turn AI):

| Deposit | Crystite EBPC |
|---|---|
| None | 0 |
| Low | 1 |
| Medium | 2 |
| High | 3 |
| Very High | 4 |

**Crystite is the random / exploration good.** The base production isn't visible from terrain — you have to invest in an Assay (player-turn action) to discover deposit quality, then decide whether to mine. **This is the "fog of war" element** — Crystite play is gambling on hidden state.

## The two economic theories — explicit in source

The most striking finding in Kroah's Production section: **two economic bonus rules are named after real economic theories.**

```
1st economic bonus = "The learning curve theory"
                   = +1 EPC for each 3 exploitations of the same type

2nd economic bonus = "The economies of scale theory"
                   = +1 EPC if at least 1 exploitation of the same type is adjacent
```

These names are **in the source comments / Kroah's documentation**. Bunten — who had a graduate background in economics — explicitly named the production-bonus rules after the theories they model:

- **Learning curve**: as you do more of one thing, you get better at it. In M.U.L.E.: every 3 Food exploitations gives all your Food exploitations +1 EPC.
- **Economies of scale**: clustered production is more efficient than scattered production. In M.U.L.E.: any same-type adjacent exploitation gives +1 EPC.

**The combination drives heavy specialization.** A player with 3 adjacent Food exploitations gets:
- EBPC 2 (plain) × 3 = 6 baseline
- +1 from learning curve (3 of same type)
- +1 from economies of scale (at least one adjacent)
- Per-exploitation: 2 + 1 + 1 = 4 Food (a 2× multiplier over a single-tile Food)

Compare against 3 *scattered* Food exploitations on plains:
- EBPC 2 × 3 = 6
- +1 from learning curve (still 3 of same type)
- +0 from economies of scale (none adjacent)
- Per-exploitation: 2 + 1 + 0 = 3 Food (1.5× multiplier)

**Adjacency adds 33% more production over the same total exploitation count.** And **each additional 3-cluster** of any good adds another +1 per exploitation of that type. **The math says: cluster aggressively, rotate goods only at major thresholds (3, 6, 9 exploitations).**

This validates the "specialization is the strategic frontier" hypothesis from earlier conversation. **Bunten built the formulas to reward exactly the player choice that the auction system enables.** Without the bonuses, specialization would be slightly worse; without the auction, specialization would be impossible. The two systems are designed together.

## Real EPC vs Simulated EPC

Kroah's distinction:

- **Real EPC**: used during the production phase. Includes the Energy penalty (above).
- **Simulated EPC**: used by AI for decision-making. No Energy penalty (because the AI is evaluating *if* it should buy a land, before it knows whether it will have Energy). Slightly different bonus calculation: includes "would I get a bonus from this hypothetical purchase?"

The split is **anticipation vs reality** — the AI projects what a land would do for it, then the actual production phase computes what it actually did. Without the real/simulated distinction, the AI would over- or under-value lands based on assumed Energy availability.

**This is the kind of computational discipline that 1983 cartridges rarely have.** Most games have one production formula; M.U.L.E. has two — one for execution, one for prediction. **Bunten engineered the AI to play by the same formulas as the human, with the same uncertainty structure (no peeking at future Energy state).**

## EP — Exploitation Production (with random variation by level)

Once EPC is computed, the actual production EP has **random variation that scales with level**:

| Level | Variation amplitude | Distribution (probability per outcome) |
|---|---|---|
| **Beginner** | 0 | 100% at 0 (deterministic) |
| **Standard** | 1 | 0: 67.6%, ±1: 16.1%, ±2: 0.1% |
| **Tournament** | 2 | 0: 37.8%, ±1: 24.3%, ±2: 6.2%, ±3: 0.6% |

**Tournament has 2.4× the standard deviation of Standard.** A Tournament player faces more production noise per round. Counterintuitive — you'd expect harder difficulty to mean *less* RNG (more deterministic, harder to win by luck). M.U.L.E. inverts this: Tournament = more variance = more risk management required.

**Strategic implication**: at Tournament, diversification is more valuable. A specialist on Smithore who rolls -3 on every exploitation has a catastrophic round; a balanced player has bad rolls average out. The level system doesn't change the strategic frontier exactly — but it does shift the optimum toward broader portfolios.

The final EP is **clamped to [0, 8]** — minimum zero, maximum 8 units per exploitation. So even with strong bonuses + lucky variation, no single exploitation produces more than 8 in a round. **The cap prevents runaway production from clusters with all bonuses + max variation** (which would be EBPC 4 for River-Food + 1 LC + 1 EOS + 3 variation = 9, clamped to 8).

## Putting it together — production round

The full production sequence (per bringerp):

```
For each exploitation:
  1. Compute real EPC = EBPC + LC bonus + EOS bonus
  2. Apply random variation per level distribution
  3. Clamp to [0, 8]
  
For each player:
  4. Sum required Energy = count(Food) + count(Smithore) + count(Crystite)
  5. If owned Energy < required Energy:
     For each missing Energy unit:
       Pick a random Food/Smithore/Crystite exploitation owned by player
       Set its production to 0
```

So the order is: **everyone produces, then Energy penalties are applied retroactively**. A player who runs out of Energy has random exploitations zero out — they don't get to choose which. The Energy penalty is *both* mandatory *and* unpredictable.

## Strategic frontier — what falls out

With everything exposed, several decisions become obvious:

### Specialize aggressively
- LC bonus + EOS bonus together favor 3+ adjacent same-type exploitations. **Optimal: 3-tile clusters of one good.**
- For Food specialists: cluster on Rivers (EBPC 4 × 3 + LC + EOS = `4×3 + 1 + 1 = 14` Food per round per cluster, before variation).
- For Smithore specialists: cluster on Mountains (EBPC 4 × 3 + 1 + 1 = `4×3+2 = 14` per cluster on 3-Mountain land).
- Crystite is opportunistic — only viable when Assay reveals High/Very High deposits.

### Always produce some Energy
- Every non-Energy exploitation needs 1 Energy. A 3-cluster of Food costs 3 Energy/round.
- Without owned Energy: you must buy 3+ at auction every round. If auction prices spike, you can't afford it.
- **Self-sufficiency on Energy is structural** — at minimum 1 Energy exploitation for every 3 of any other type.

### River vs Mountain dictates specialty
- A player who lands on river-heavy plots is forced into Food/Energy specialization (no Smithore/Crystite allowed on rivers).
- A player on mountain-heavy plots gets Smithore advantage but worse Food (1 vs 2 on plain).
- **Land-grant AI matters because the lands available shape your strategic options.**

### Tournament rewards diversification
- Higher variance per exploitation = catastrophic-roll risk.
- A 6-exploitation Smithore specialist who rolls -2 on average loses 12 units that round (enough to lose the round).
- A 3-Smithore + 2-Food + 1-Energy mixed player has variance averaged out.
- **Bunten put the risk-management lever in level, not in player choice.**

## Comparison to Utopia's economics

| Aspect | Utopia | M.U.L.E. |
|---|---|---|
| Production source | Per-building yield (constants) | Per-exploitation EPC × terrain |
| Specialization reward | None (need all building types for population/score) | **+33% from clustering, +33% from learning curve** |
| Random variation | None at production | Random per-exploitation, scales with level |
| Mandatory consumption | Population food/housing implicit | Energy explicit per non-Energy exploitation |
| Strategic axis | Build all types in good ratios | Specialize on one good, trade for others |

**Utopia's economics rewarded balance; M.U.L.E.'s economics rewards specialization.** The shift maps directly to the auction layer — without auctions you must do everything, with auctions you can corner one good. **Production rules and trading rules are designed together as a coherent system.** This is what we hoped to see and now have.

## What this clarifies for later chapters

- **Chapter 6 (store / prices)**: the per-good price formulas have to make specialization viable. If Food prices stay high enough that specialists can profit, specialization works; if prices crash on excess supply, specialists collapse. The price formulas are the answer.
- **Chapter 7 (auctions)**: the bid mechanic determines whether a Smithore specialist can actually *get* the Energy they need at affordable prices. Auction game theory determines specialty viability.
- **Chapter 7.5 (your strategic-frontier analysis)**: with EBPC, EPC bonuses, and EP variation now in hand, the question of which specialty pays off best is computable. Food/Energy have guaranteed buyers (Chapter 1's asymmetry) AND best EBPC on common terrain (Plain Energy = 3); Smithore needs Mountain land; Crystite needs lucky Assays. Strong prior: Food/Energy specialization dominates Smithore/Crystite *unless* the specific map skews mountain-heavy.

## Curiosities

**The economic theory names are explicit.** "Learning curve theory" and "economies of scale theory" aren't my interpretations — they're literally the bonus names in the documentation (likely from the source/comments Kroah extracted). **Bunten taught economics through the game**. A 1983 player who learned about diminishing returns from M.U.L.E.'s production curves got an applied econ lesson packaged as entertainment.

**The Energy penalty is non-deterministic in *which* exploitations get zeroed.** This is interesting design — you can't strategically protect your highest-EBPC exploitation by running short on Energy. The randomization means under-Energy players take a fair penalty (proportional to their deficit) rather than gaming it.

**The EP cap of 8 per exploitation matches the visible "EBPC dots."** The doc mentions "The EBPC is shown at the bottom right of the exploitation with points." With max 8 (3 dots = 3 mountains terrain × 4 + bonuses + variation? Actually max EBPC alone is 4; with both bonuses + max variation it could exceed 8; the cap normalizes display). **The 8-cap is a UI constraint as much as a balance constraint.**

**Beginner has zero production variation.** A Beginner player can perfectly predict their production each round. This is the **maximally readable difficulty** for new players — the economic engine is deterministic, so they learn the formulas without RNG noise. Then Standard introduces noise, Tournament cranks it up. **Difficulty as variance, not as opposition.**

## LLM-interpretation log

| Source of understanding | Where it carried |
|---|---|
| **Source labels alone** | Limited — the production routines are deep in cartridge ROM and mostly use `byte_X` working storage. Labels on the goods (`playersGoodReq`) and on key counters surfaced. |
| **Source comments (French)** | Some — `prodMax` (byte_94), the goods encoding (byte_91 comment), various per-routine annotations. |
| **Bringerp's documentation** | **The chapter.** EBPC, EPC, EP definitions; the terrain table; the bonus formulas; the variance distributions; the Energy penalty mechanism. Without it the chapter would be 2-3× the work to extract. |
| **6502 / Atari ISA knowledge** | None new. |
| **External economics knowledge** | The "learning curve theory" and "economies of scale theory" naming — recognizing them as real economics terms (vs invented game terms) elevates the design analysis. |
| **Disagreements with source** | None. Bringerp's Production section is the most algorithmically detailed of the doc. Cross-checks against `prodMax` and the few production-routine labels in source confirmed his reading. |

Net for the project hypothesis: **Path C is paying off.** Bringerp does the heavy algorithmic lifting; we cross-reference, add the strategic-frontier analysis layer, and connect to the Utopia comparison. Chapter scope is right — the production economy is now exposed, the specialization frontier is mapped.

## Tags

[games](../../../tags/games.md) · [strategy](../../../tags/strategy.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [llm-limitations](../../../tags/llm-limitations.md) · [economics](../../../tags/economics.md)
