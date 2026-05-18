---
status: active
created: 2026-05-05
updated: 2026-05-05
---
# M.U.L.E. — The Auction System
> Why this chapter exists. Lands auctions (start of game + between rounds at Standard/Tournament) and Goods auctions (every round, all four goods). The cursor-as-bid mechanic from Chapter 3 finally pays off. **Player status (Seller/Buyer) is auto-assigned by inventory** — you reveal your strategic position before you bid. The **Energy surplus table** is the cleverest tactical commitment device in 1983 game design — holding 3 surplus signals 1-4 expansion plans. Auction time is 70 ATU per good — a Tournament auction phase can run 5-10 minutes per round. Most of M.U.L.E.'s gameplay depth lives here.

**Links:** [M.U.L.E. README](./README.md), [Memory Map](./01-memory-map.md), [Time Scales](./04-time-scales.md), [Production Economy](./05-production-economy.md), [Store & Prices](./06-store-and-prices.md), [Bringerp's auction sections](http://bringerp.free.fr/RE/Mule/mule_document.html#GoodsAuctions), [Utopia Rebels & PvP](../utopia/07-rebels-and-pvp.md), source: [`source/mule.asm`](./source/mule.asm)

## Why this chapter is THE chapter

The Game Annotation Series's mechanical-complexity arc was scoped to isolate one variable: **what does adding an auction layer do to a Utopia-style economic engine?** Chapters 1-6 set up everything Utopia *also* has — terrain, production, prices, time pacing, per-player parallel arrays. Chapter 7 is the difference. **Everything in chapters 1-6 makes specialization theoretically possible; this chapter is what makes it actually viable.**

Without an auction, M.U.L.E. would collapse to Utopia: players forced to do everything themselves because there's no way to trade. With an auction, a Food specialist can produce 30+ Food/round, sell the surplus to other players, and buy Energy/Smithore/Crystite from specialists who chose those. **The auction is the trading layer that turns a four-good production engine into a four-strategy decision space.**

## Two auction systems, both running on the same cursor mechanic

M.U.L.E. has two distinct auctions, both using the cursor-bid mechanic from Chapter 3 but with different structure:

### Lands Auctions
- Run between rounds (Standard/Tournament; Beginner has none)
- Random number of plots offered: distributed around 1, with amplitude 1 (Standard) or 2 (Tournament)
  - Standard: 16% / 68% / 16% / 0.1% chance of 0/1/2/3 plots
  - Tournament: 31% / 38% / 24% / 6% / 0.6% / 0.01% of 0/1/2/3/4/5 plots
- Two-phase: **player-offered land auction set** (lands players sold) THEN **colony land auction set** (random plots from the colony)

### Goods Auctions
- Run every round (after production phase) for each good
- Each good's auction proceeds independently
- Order: Food → Energy → Smithore → Crystite (per the goods encoding from Ch 1)
- Auction skipped for a good if no units exist anywhere (player-held + production + store)
- Crystite auction has a special end-effect: **store Crystite stock zeroed afterward** (the store doesn't stockpile Crystite)

Both run on the **70 ATU available time** — at Tournament's 25 BTU/ATU = `70 × 25 × 1/15s = 116 seconds per auction`. Multiple goods × multiple auctions per round = **5-10 minutes of real-time auction phase per round**. **The auction phase is most of the game's wall-clock time.**

## The cursor as bid mechanic — finally explained

Chapter 3 introduced the cursor as the unified player input, used both for map navigation AND auction bidding. Now we can show how auction bidding works:

**During a goods auction**:
- Each player's cursor is positioned on a vertical price scale (visible on screen)
- Cursor up = higher bid; cursor down = lower bid
- Cursor moves at CTU rate (3-8 BTU/step depending on level)
- Bid increment: **$1 per pixel** for Food/Energy/Smithore, **$4 per pixel** for Crystite (and lands)
- Pressing button = "commit to this price"
- When a Buyer's cursor matches a Seller's cursor → **trade executes at that price**

**During a lands auction**:
- Same mechanic, but cursor controls bid on the auctioned plot
- Increment: $4 per pixel
- Available time: 70 ATU
- Starting bid: $160 first auction; subsequent auctions = previous-set average − $60

**The cursor IS the bid.** No keypad input. No "type your number." Just navigate the cursor to the price you're willing to commit at and press the button. Combined with the **CTU-level speed scaling** (Tournament cursor moves 5×/sec vs Beginner's 1.9×/sec), this means:

- **Tournament players need millisecond-precise reactions to commit at exact price points.**
- **Beginner players have 5× more time to think while the cursor moves.**

Same strategic decision (what price to commit at), wildly different tactical execution.

## Player status — auto-assigned by inventory

The most important auction mechanic: **before each goods auction, the engine assigns each player as Seller, Buyer, or Non-Participant based on their current inventory.** Players cannot opt out of this classification.

### Smithore and Crystite (simple rule)
- **Seller** if you have ≥ 1 unit
- **Buyer** if you have 0 units

### Food and Energy (Surplus-based rule)
- **Seller** if you have ≥ 1 unit in **Surplus** (= held quantity above Requirement for next round)
- **Buyer** if you have 0 in Surplus

The Requirement calculation is what makes this clever:
- **Food**: Requirement = next round's consumption needs (linked to your food consumption rate)
- **Energy**: Requirement = `non-Energy exploitations × 1 + 1` (the +1 reserves for new expansion)

**You become a Buyer not when you're "out" but when you're *insufficient for next round*.** The game forces buyers to top up before they get penalized. **The auction is mandatory participation calibrated to need.**

### What this means strategically

**Player status is public information.** Other players can see who's a Buyer and who's a Seller for each good. This means:

- **A Smithore Buyer reveals they have 0 Smithore.** Anyone holding Smithore knows they have a guaranteed buyer.
- **A Food Buyer reveals they're under-stocked on Food.** Other Food holders know there's pressure on prices.
- **A Smithore Seller is trying to offload.** Other Sellers compete for the same buyers; this is information about supply.
- **Specialty is visible.** A Food specialist who's repeatedly a Seller of Food and a Buyer of everything else has telegraphed their strategy.

**Information asymmetry only exists in *quantity*** — you know that other Smithore holders are Sellers, but not how much they have. This is the auction's incomplete-information dimension.

## The Energy Surplus Table — the cleverest tactical commitment device of 1983

From Kroah's Energy section, the table for surplus-vs-expansion strategy:

| Surplus units held | Min new exploitations next round (no penalty) | Max new exploitations next round (no spoilage) |
|---|---|---|
| 0 | 0 | 1 |
| 1 | 0 | 2 |
| 2 | 0 | 3 |
| **3** | **1** | **4** |
| 4 | 2 | 5 |
| 5 | 3 | 6 |

**Holding 3 Energy surplus is the optimal commitment.** It signals "I'm going to expand 1-4 exploitations next round" — flexible but bounded. The computer AI chooses 1 surplus by default (most cautious — accepts 1 spoilage in worst case but minimizes Energy committed).

Read what this *means* strategically:

- **Your Energy surplus is a signal of your expansion plans.** Holding 5 = "I'm expanding 3-6 exploitations next round" — telegraphing aggressive growth.
- **Holding more Energy than needed = spoilage cost.** Energy spoils at 1/4 per round, so excess Energy carries a 25% holding tax.
- **Holding less Energy than needed = production penalty.** Random exploitations get zeroed (Chapter 5).
- **The optimum is "hold exactly enough for your planned expansion + 1."** This is a *forward-commitment* — you have to decide now what you'll build next round.

Combined with public Buyer/Seller status, **Energy holdings are a leak of strategic intent.** A player with high Energy surplus is planning expansion; a player with low surplus is consolidating. **Other players read this and adjust their bids accordingly.** A Smithore Seller seeing all opponents at low Energy surplus knows mule demand will be low next round → Smithore prices will fall → bid lower now.

This is **deep strategic interaction in a 1983 cartridge.** The Energy decision isn't just about avoiding penalties — it's about strategic signaling and reading other players' signals.

## Auction price-setting — last-sale becomes the new market price

After each goods auction:
> *"At the end of each auction, the price of the good is updated if at least one unit was sold. The new price equals the average price of the units sold."*

Two consequences:
1. **The auction sets the next round's market price.** What players paid in this round's auction becomes the store's price for the next round.
2. **No-trade auctions don't update prices.** If a good has no Sellers (everyone holds zero) or no Buyers (everyone has Surplus), the auction skips and prices roll over from the formula update (Chapter 6).

This is **player-driven price discovery within the supply/demand framework.** The Chapter 6 formula sets the *floor and ceiling* (price minimums + spoilage-driven supply); the auction sets the *actual transaction price* within those bounds.

**Implication**: a player who manipulates auctions affects future store prices. If a Smithore Seller bids stupid-low to dump inventory, they tank Smithore prices for next round (hurting their own future earnings). If they hold the line, prices stay high (helping all Sellers, hurting all Buyers — including themselves if they need to buy back).

## Mule construction — Smithore as the meta-good

At end of round, the store builds mules from Smithore:
- Store max: 14 mules
- Each mule = 2 Smithore
- New mule price = `2 × Smithore_price`, rounded down to nearest 10
- Average Smithore = $50 → average mule = $100

**Smithore prices directly drive mule prices.** A Smithore corner doesn't just spike Smithore — it spikes mule prices (the universal capital good for installing exploitations). **Smithore specialists soft-tax everyone else through mule prices.**

## Lands auctions — colony plot economics

Bringerp's calculation for the AI's land valuation:

```
land_rating = best_exploitation_rating(land)
            + rand(0..7)
land_rating *= rounds_remaining
```

Where the per-good ratings are:
- Food: 3
- Energy: 2
- **Smithore: 6**
- Crystite: 12.5 + round/2

**Smithore is rated 2-3× higher than Food/Energy.** Crystite ratings increase mid-game (because you're closer to liquidating). Late-game, all ratings drop because `rounds_remaining` is the multiplier.

Land prices:
- First-ever auction: starts at $160
- Subsequent in same set: previous-set average − $60
- If unsold: price ends at `bid_start/2 + $52` (consolation pricing for unsold colony plots)

**Strategic insight**: AI overvalues Smithore lands and Crystite lands relative to Food/Energy. A human player who knows this can buy Food/Energy lands at competitive prices while AI bids up Smithore lands. **Land auctions are the AI's biggest blind spot** — they can't internalize that Crystite is RNG and Smithore is volatile, so they pay premiums for both.

## Scoring — what actually counts

End-of-game scoring per Kroah:

```
Score = Money_points + Land_points + Goods_points

Money_points = $1 = 1 point
Land_points  = each plot's value:
                500 + outfit_price (each plot)
                +25 if plot has Food exploitation       (= 525)
                +50 if Energy exploitation              (= 550)
                +75 if Smithore exploitation            (= 575)
                +100 if Crystite exploitation           (= 600)
Goods_points = 35 per Mule + current_price per unit of each good
```

**Money dominates.** $5,000 saved = 5,000 points; an exploitation only adds 25-100 points over base 500. **The most efficient point source is liquid cash.**

But getting cash requires either selling inventory (which costs you the inventory's points) or earning enough to keep both. **The optimal endgame is cash + held inventory + multiple plots — diversification at scoring layer.**

End-of-game ratings (`rating = round((score - 10000) / 20000)`, clamped 0-6):

| Rating | Score range | Message tone |
|---|---|---|
| 0 | 0-19,999 | "failed... Dismally. Federation debtors' prison!" |
| 1 | 20-39k | "failed... no more trade ships" |
| 2 | 40-59k | "survived" |
| 3 | 60-79k | (presumably "thrived") |
| 4 | 80-99k | (presumably "succeeded") |
| 5 | 100-119k | (presumably "exceeded") |
| 6 | 120k+ | (presumably "extraordinary") |

The 20K bands and 10K offset suggest tuning — the developers wanted a typical game to land in the 50-100k range. Working backward: that's roughly $50-100k in money + ~5,000-10,000 in land/goods. **Score is dominated by money, which is dominated by skilled auction trading.** The auctions are literally where the game is won or lost.

## Strategic depth — what falls out

With everything exposed, the depth becomes legible:

### Reading other players
- **Energy surplus** signals next-round expansion intent
- **Buyer/Seller status** signals current inventory position per good
- **Bid behavior** signals price expectations (high bid = thinks price will rise; low bid = thinks price will fall)
- **Mid-auction non-movement** signals (a) high-confidence-current-price OR (b) trying to slow ATU/4 to get more time

### Strategic timing
- **Crystite auction is the lottery moment** (RNG-driven price + zeroed store stock means each round is independent gamble)
- **Smithore auctions at low Energy surplus across players** = mule demand low next round = bid low
- **Food auctions during Beginner phases** = predictable; auctions during Tournament phases = volatile
- **Late-game ATU/4 stalling** = waiting out opponents whose time is running out

### Specialization viability ranking (preliminary, before Ch 7.5)
- **Food specialist (River cluster, ~14 production/round)**: stable income, capped upside, score from money accumulation
- **Energy specialist (Plain cluster + own consumption)**: covers own needs, sells surplus, less reliant on auction outcomes
- **Smithore specialist (3-Mountain cluster)**: high variance, can corner mule prices, late-game value drops
- **Crystite specialist**: pure gambling; only works on lucky Assays + RNG-favorable rounds

**The asymmetric demand (Food/Energy mandatory, Smithore/Crystite speculative) plus the auction mechanic means**: Food/Energy specialists have more reliable income but capped upside; Smithore/Crystite specialists have lottery-style upside with severe downside risk. **Strategic frontier is curved (concave for the speculative goods, convex for the necessities).** Ch 7.5 will add concrete numbers.

### Auction game theory in 1983
- **Bid below your true value to leave room for negotiation**: classic English-auction first-mover principle
- **Watch the time bar**: ATU pressure forces commitment
- **Stall when ahead, move when behind** (the ATU/4 idle-trick)
- **Move late, but not last**: late commitments capture better prices, but you risk timing out
- **Public auction ≠ public information**: prices are visible but quantities are not — players can hold large positions without revealing them

This is **a real auction game** — not a pretend trading menu. Bunten built genuine multiplayer market mechanics in 32 KB of cartridge. **The strategic depth is comparable to modern Catan, Power Grid, or Stockpile** — board games specifically designed for auction-driven economic strategy. M.U.L.E. predates them all.

## Comparison to Utopia — the variable isolated

| Aspect | Utopia | M.U.L.E. |
|---|---|---|
| Player interaction | None except mercenary rebels (one-shot purchase) | Auction every round (continuous interaction) |
| Information available | Full (both islands visible) | Asymmetric (prices visible, quantities private) |
| Strategic decision space | Build order (largely deterministic given exposed mechanics) | Build order × Auction game theory (state-dependent) |
| Tactical decision space | Fishing position, weather reaction | Cursor timing, bid strategy, signal reading |
| Specialization viable? | No (no trading) | Yes (auction enables corner strategies) |
| Game-theoretic depth | Low (zero-sum race against fixed weather) | High (dynamic equilibrium between 4 players' strategies) |

**The auction is precisely the mechanism that turns a static optimization problem (Utopia) into a multi-agent game-theoretic system (M.U.L.E.).** Same production engine, same time pacing, same scoring philosophy. The auction layer is the difference.

## Curiosities

**The Crystite store stock zeros at end of Crystite auction.** The store is a clearing house, not a stockpile, for Crystite specifically. **Players cannot "buy from the store" Crystite outside the auction window** — even if they had infinite money, the store has zero Crystite supply between rounds (only player-to-player transactions exist). Combined with Crystite's RNG pricing, this makes Crystite a single-window-per-round opportunity.

**The "Mule price = 2 × Smithore price rounded down to 10" rule** has a quirk: at Smithore $49, mule = $90 (not $100). At Smithore $54, mule = $100. Round-down means the rounding boundary is exactly at multiples of 5. **A Smithore Seller has incentive to push price to ≥$50 (next breakpoint = $100 mule).**

**The lands-auction starting price formula** (`previous_set_average − $60`) creates a *deflationary trend* — successive lands sell for less. By round 5+, lands can start at $50-100, far below the $160 first-ever auction.

**The Energy Surplus Table is the highest-information density strategy advice in the game.** A player who memorizes it can perfectly tune their Energy holdings for any expansion plan. **It's the kind of insight that took the 1983 community years to discover; here it is, computable in a 6-row table.**

**Auction time of 70 ATU is per *good*, not per *auction phase*.** Four goods × 70 ATU each = up to 280 ATU = 280 × 25 BTU = 7000 BTU = ~7.8 minutes per auction phase at Tournament. **A 12-round Tournament game's auction phases alone = ~90 minutes**. M.U.L.E. is a long game.

## What this clarifies for later (synthesis chapter)

- **The auction layer is the strategic-decision-space expansion vs Utopia.** Quantifiable: 4 goods × auction-state per good = 4× the per-round decisions.
- **Specialization is enabled by auctions** but not *required* — self-sufficient strategies remain viable, just lower-ceiling.
- **Reading other players** is a real layer — Energy surplus, Buyer/Seller status, bid behavior all signal strategic intent.
- **Money dominates scoring** — the auction is where money is made or lost.

## LLM-interpretation log

| Source of understanding | Where it carried |
|---|---|
| **Source labels alone** | `playersGoodReq`, `typeAuction`, `nbLandsToSellByPlayers`, `cursorWait`, `playersButtonPushed`. The auction state machine is rooted in zero page; the per-auction logic lives in cartridge ROM at addresses we'd need to chase further. |
| **Source comments (French)** | Some — the typeAuction values, the goods encoding, references to "Surplus" in player-status discussion. |
| **Bringerp's documentation** | **The chapter.** All the auction mechanics, player status rules, the Energy Surplus table, the price-setting via auction, the lands rating formula, the scoring breakdown. Without bringerp this chapter would be 5× the work. |
| **6502 / Atari ISA knowledge** | None new. |
| **External economics knowledge** | The auction-as-price-discovery framework is recognizable from real microeconomics. The English-auction first-mover dynamics, the information-asymmetry-in-quantities pattern, the "anti-corner protection via inventory dampening" — all standard market-design vocabulary applied to a 1983 cartridge. |
| **Disagreements with source** | None. The bilingual French/English text is consistent and the formulas are precise. The scoring table values (525 / 550 / 575 / 600) are exact. |

Net for the project hypothesis: **the auction system is M.U.L.E.'s defining design and the entire reason we did this paired comparison.** Now exposed, the strategic-decision-space expansion vs Utopia is fully visible. Chapter 7.5 (your contribution) has the data to do the dominance-frontier analysis cleanly.

## Tags

[games](../../../tags/games.md) · [strategy](../../../tags/strategy.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [llm-limitations](../../../tags/llm-limitations.md) · [economics](../../../tags/economics.md) · [game-theory](../../../tags/game-theory.md)
