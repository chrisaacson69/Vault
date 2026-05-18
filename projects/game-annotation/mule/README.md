---
status: complete — chapters 1-8 done; ch 7.5 resolved by conversation 2026-05-06 (skipped)
created: 2026-05-05
updated: 2026-05-06
---
# M.U.L.E. (Atari 800)
> Dani Bunten Berry / Ozark Softscape, 1983. The first console-class economic-strategy game with a *trading* layer — auctions for both land and produced goods, asymmetric information across players, market-clearing every round. The companion piece to [Utopia](../utopia/README.md) in the Game Annotation Series's mechanical-complexity arc, isolating the design variable: **what does adding an auction layer do to a Utopia-style economic spine?**

**Links:** [Game Annotation Series](../README.md), [Utopia](../utopia/README.md), [bringerp's M.U.L.E. Decompilation Document v0.41](http://bringerp.free.fr/RE/Mule/mule_document.html), source: [`source/mule.asm`](./source/mule.asm) (49,981 lines, 6502, sparsely-annotated disassembly), [CoM Spell Counter-Graph](../../../research/gaming/master-of-magic/com-counter-graph.md), [MoM Tier System and MIRR](../../../research/gaming/master-of-magic/tier-system-and-mirr.md)

## Why M.U.L.E. as the Utopia pair

Two early console-class economic-strategy games, both 1981–83 era, both probabilistic-world systems with random events and per-round scoring. **What's structurally different** is the trading layer. Utopia is a purely-solo economic engine — no opponent interaction except mercenary rebels. M.U.L.E. inserts an auction *every round* for goods, plus auctions for land at the start. **Specialization is enabled by the auction**: in Utopia you must do everything (fish + crops + factories + defense) because nobody trades; in M.U.L.E. you can corner food production and trade for energy + ore via auctions, *if the prices clear right.*

The pairing isolates this variable cleanly:

```
Utopia                     M.U.L.E.
- Solo economic engine     - Solo economic engine + auctions every round
- Per-tic random events    - Per-tic + per-round random events
- Score formulas exposed   - Price formulas exposed (per Kroah doc)
- 3 nested time scales     - 4 nested time scales (BTU/PTU/ATU/CTU)
- 1981 / Intellivision     - 1983 / Atari 800
- 4,075 lines / CP1610     - 49,981 lines / 6502
```

The hypothesis to test: **the auction layer turns the strategic decision space from "compute the answer" to "compute the answer given what others will compute."** Game-theoretic, not just optimization-theoretic. With Utopia's frontier mapped (build order is largely deterministic; tactical play is rich), M.U.L.E.'s frontier should expand back at the strategic layer — the auction prices depend on opponent actions, which depend on opponent strategies, and so on.

## Strategic axes worth flagging up front

These came up in conversation while scoping the project; they shape what the chapters need to surface:

- **Self-sufficient vs specialist duality.** M.U.L.E. enables two viable paths — produce everything yourself (no auction dependence) or corner one good (need auctions for the rest). Utopia has no auction so self-sufficiency is *forced*. The strategic-frontier expansion vs Utopia is largely about whether specialist paths are comparable to self-sufficient paths.
- **Asymmetric demand pressure across goods.** Food and energy are *consumed* every round (mandatory buyer-side load); ore (smithore + crystite) is purely speculative. A food/energy specialist has guaranteed buyers; an ore specialist has only price-betting against other ore players. **Whether the frontier is flat (multiple viable specialties) or peaked (one dominant specialty) is a chapter-7 empirical question.**
- **Wampus mini-game uncertainty.** Bringerp documents Wampus hunting as part of the player turn, but it's unclear whether the original 1983 Atari 800 release matches all later ports (C64, NES). If Wampus is bonus-variance like Pub gambling, it just adds volatility. If it interrupts production timing meaningfully, it's a tactical decision worth its own analysis. Flagged for chapter 8.

## Source

`source/mule.asm` — 49,981 lines of memory-dump-style 6502 disassembly. Format: `<address> <label>:.<directive> <value> ; <comment>`. Most labels are auto-generated (`byte_X`, `word_X`); ~72 semantic labels exist (Atari OS shadows, font tables, a few game-state names). Sparse French annotations from the Kroah RE effort identify some zero-page bytes' meanings.

`source/mule-original.zip` — preserved original archive.

**The bringerp document is the load-bearing reference.** Kroah's v0.41 (2009) documents game logic at the algorithm level — time units, map generation, AI, production formulas, store price dynamics, auction structure. Approach to the chapters is hybrid:

- **Memory/display/input chapters** (1-3): source-first, since bringerp covers these less.
- **Time scales, production, store** (4-6): scaffold from bringerp, cross-reference specific addresses in `mule.asm`, layer the Utopia comparison.
- **Auction system** (7): source-first — this is the project's reason to exist; we want our own independent reading.
- **Synthesis** (8): bringerp + framework; close with the Utopia↔M.U.L.E. comparison.

This is the **inverse** of the Utopia situation: there we had richly-annotated source and wrote the high-level layer; here we have sparsely-annotated source and an existing high-level document, so we curate and cross-reference.

## Atari 800 hardware — brief notes

The Atari 800 (1979) uses three custom chips alongside the 6502:

- **ANTIC** — programmable display processor with display lists (per-line display mode, scrolling, DMA control). Different from Intellivision STIC (which has only one mode) and from NES PPU (which has fixed nametables + scrolling).
- **GTIA** — color/graphics generator that takes ANTIC's output and produces final pixels with color machinery.
- **POKEY** — sound + keyboard scan + serial bus + random number generator. The RNG is hardware (not software like Intellivision EXEC's `X_RAND2`).

For this project, **most ANTIC/GTIA setup is glue code** — display list construction, color register loads, character table pointers. The chapters will lean on bringerp + a brief external Atari hardware reference rather than spelunking each ANTIC instruction.

## Chapters (8, with a reserved 7.5 slot for strategic-frontier analysis)

1. [Memory map & data model](./01-memory-map.md) — 4-player parallel arrays (stride 1 byte), 4-good encoding (Food/Energy/Smithore/Crystite = 0/1/2/3), the Kroah-named structural backbone (currentPlayer, level, numRound, typeAuction); **byte-meaning-by-context squeeze** (byte_91 = current auction good OR remaining lands for sale, etc.) — most aggressive zero-page reuse we've seen
2. [ANTIC/GTIA display system](./02-display-system.md) — Atari programmable display lists (mixed character modes per region), display list at $1E75 (mode 2 header → mode 6 playfield → mode 2 footer), custom char set at $1800, screen data at $B500 in cartridge ROM — **per-tile state changes via color overlay, not character replacement**
3. [Input & cursor dispatch](./03-input-and-cursor.md) — the cursor as unified player-input abstraction (drives both map navigation AND auction bidding), `cursorWait` per level, **difficulty as cursor reflex pressure** rather than game-state difficulty
4. [The four nested time scales (BTU/PTU/ATU/CTU)](./04-time-scales.md) — Kroah's framework: BTU = 1/15s base, **PTU varies by RACE** (Humans -2 BTU, Flappers +2 BTU — race is implemented as a time-pressure stat), ATU **divided by 4 when nobody moves** (auction stall protection), CTU for land-grant cursor speed; vs Utopia's 3 scales
5. [Production & resource economy](./05-production-economy.md) — EBPC × terrain (River = Food peninsula; Mountains = Smithore mines), **two named economic theories**: "learning curve" (+1 per 3 same-type) + "economies of scale" (+1 if adjacent same-type) — Bunten the economist designed this; **Energy is universal multiplier** (no Energy = random exploitations zero out); production variance scales WITH level
6. [The Store & price dynamics](./06-store-and-prices.md) — one supply/demand formula `price × (0.25 + 0.75 × ratio)` parameterized across 4 very different price regimes; **Food/Energy stable** (player inventory dampens — anti-corner protection), **Smithore volatile** (no inventory dampening + ±$28 random variation), **Crystite is a casino** (`50 + rand(0..99)`, pure noise), Energy spoils slower than Food (3/4 vs 2/4 retention)
7. [The auction system](./07-auctions.md) — both lands auctions (between rounds at Standard/Tournament) and goods auctions (every round, four goods); **player status auto-assigned by inventory** (Seller/Buyer is public information); **the Energy Surplus Table** as forward-commitment device (3 surplus = 1-4 expansion plans next round); cursor-as-bid mechanic with $1/pixel for most goods, $4/pixel for Crystite; auction sets next round's market price; mule price = 2 × Smithore price (Smithore corner = mule corner); **scoring is dominated by money** (1pt/$), so auctions are where the game is won or lost; deep multi-agent game theory (signal-reading, ATU/4 stalling, English-auction strategy) **comparable to modern Catan/Power Grid in 32KB cartridge**
8. [Random events, AI, & synthesis](./08-events-ai-synthesis.md) — random player events with **explicit rubber-banding** (no good events for first-place player, no bad events for last 2) — anti-runaway built into RNG itself; Wampus = hidden-state timing mini-game where **clicking quickly makes it appear quickly** (Tw = Ta/4 PTU); 8 round events with **declining-probability RNG** (per-event caps prevent monoculture); 3-phase AI (Development → Assay → Gambling) is competent but readable; **closes with full Utopia↔M.U.L.E. comparison** — Daglow + Bunten as a 1981-83 design school, the mechanism-vs-equilibrium gap as the recurring framework theme, the zero-sum auction paradox as the open empirical question

**Reserved 7.5 — resolved 2026-05-06 (skipped, framework already captures the finding).**

The open empirical question (does expert M.U.L.E. play converge to specialist or balance?) was informally resolved by reasoning rather than data lookup. **Conclusion: the equilibrium is conditional on player pool quality and variance threshold.** Against AI / easier modes, "balance + Crystite lottery" is locally stable. At Tournament with skilled humans, three forces break that local stability — increased production variance, mandatory-auction-engagement (skilled opponents actively pressure prices), and reactive-over-pre-planned play (like Power Grid). Bunten built the auction mechanism for the tournament-skilled pool; against weaker opposition the auction's strategic value goes unrealized and balance dominates by default. **The mechanism-vs-equilibrium gap is conditional on pool quality + variance threshold, not absolute** — generalization saved to memory.

## Method (carry-over from Utopia)

The chapter pattern that worked across Adventure, Mappy, and Utopia:

1. Memory map first — establishes vocabulary
2. Display next — encoding tricks surface here
3. Input/dispatch — sets the rhythm
4. Main loop — game's heartbeat, probability budgets
5. Game economics — the strategic decision space (transparency thesis acid test)
6. World/AI — non-player entities, often the densest mechanical chapter
7. Adversarial systems — the cleverest design ideas
8. Round/game orchestration + synthesis — full sequence + project closure

For M.U.L.E., the auction takes the slot the rebel system held in Utopia (chapter 7) — the game's most distinctive design idea. Random events + AI compress into chapter 8 with the synthesis. **One chapter relabeled, structure intact.**

## What this project will produce

- 8 chapter pages in `projects/game-annotation/mule/`
- A reserved 7.5 strategic-frontier page (yours)
- An updated `feedback_dominance_frontier_lens` memory entry with the M.U.L.E. case data
- A back-link from the Utopia README closing the pair
- A back-link from the Game Annotation Series README updating to "3 games complete + 1 paired comparison"
- Anti-NA work: the M.U.L.E. project also serves as the **last paired comparison** before NA's solo deep-dive. After M.U.L.E., the framework is calibrated; NA becomes its own ambitious project (256 KB line-by-line on familiar NES territory).

## Tags

[games](../../../tags/games.md) · [strategy](../../../tags/strategy.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [llm-limitations](../../../tags/llm-limitations.md)
