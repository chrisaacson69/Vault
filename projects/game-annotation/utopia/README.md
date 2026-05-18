---
status: complete — 8 chapters
created: 2026-05-04
updated: 2026-05-05
---
# Utopia (Intellivision)
> Don Daglow, 1981. Mattel Electronics. The first console real-time-strategy game and arguably the first console strategy game with persistent multi-round economy. Two players manage rival islands — building factories, crops, schools, hospitals, fishing boats, PT boats, and forts — while the world rolls weather, fish, pirates, and rebels at them. The game is balanced asymmetrically across rounds via score accumulation, not eliminated-by-attack.

**Links:** [Game Annotation Series](../README.md), source: [`source/utopia.asm`](./source/utopia.asm) (4,075 lines, CP1610 assembly), [CoM Spell Counter-Graph](../../../research/gaming/master-of-magic/com-counter-graph.md), [MoM Tier System and MIRR](../../../research/gaming/master-of-magic/tier-system-and-mirr.md)

## Why Utopia first in the mechanical-complexity arc

- **First-of-its-kind strategy.** Utopia (1981) predates Civilization by a decade. Its economic decisions are real and matter — the design space includes investment timing, risk management (pirates and rebels), and player-vs-environment vs player-vs-player tension.
- **The annotated source is in hand.** 4,075 lines of CP1610 with rich pre-existing labels (`SCOR_0`, `RBLTRY`, `FORT_NEAR_MOB`, etc.) and per-line comments. We won't need to spelunk Intellivision EXEC ROM or MOB hardware in detail — the source labels carry most of the meaning.
- **Mechanical-complexity comparison target.** Pairs with Nobunaga's Ambition (1986 NES port) as the second half of the arc. Utopia exposes its mechanics through play (visible buildings, visible weather); NA hides them and drives optimal play to TAS-exploit assassination. The pair tests how source-level transparency scales as mechanical depth grows.
- **Connects to the dominance-frontier work.** Utopia's economic decisions (build-fort vs build-school vs build-hospital, when to fish, when to send a PT boat) are a small dominance graph that should be fully extractable from source. This is the inverse of the CoM analysis: instead of mapping a game whose mechanics are documented, we're producing the documentation by reading the engine.

## Source

`source/utopia.asm` — already labelled disassembly. CP1610 assembly. Memory layout starts in the $15D range for game state. MOB (Movable Object Block) hardware allocation: weather (0,1), players (2,3), pirates (4,5), fish (6,7).

## Chapters (8, mirroring the Adventure/Mappy pattern)

1. [Memory map & data model](./01-memory-map.md) — `$15D-$1A4` variables; per-player score / population / gold; the 9-building × 2-player array trick (`$16D + item_type*2 + player`); MOB allocation map; the `MVO` + `SWAP` 16-bit-store idiom
2. [Display & tile system](./02-display-and-tiles.md) — STIC display-word format, BACKTAB at `$0200–$02EF`, the two-table island unpack, the **bit-14 ownership trick** (one bit of the display word encodes which player owns each tile — used by every collision/event lookup), `GET_TILE_NO` / `GRAM_OR_GROM` as the BACKTAB API, GRAM init loads 33 cards at boot
3. [Input & control dispatch](./03-input-and-dispatch.md) — the 5-entry dispatch table makes Utopia event-driven (no polling); the two-key build menu (item-then-Enter) with `$14` as the no-selection sentinel; the bit-14 ownership check on every boat pickup; action buttons share one 12-instruction printer; `BARINH` as soft mutex between gold-bar and stat-overlay; `RAZZ` as universal error response
4. [The tic engine](./04-tic-engine.md) — TICTSK at 20 Hz; the **probability budget of the world** (1% weather, 1% pirates, 5% fish, 1-in-12 hurricane); spawn-at-four-corners utility shared by fish and pirates; 4-MOB collision loop with look-ahead-by-one; an explicit author-confessed Y-axis bug that shipped uncorrected; STAT_TIC collapses 20 Hz into 1 Hz game time + end-of-round transitions; INC_GOLD resolves Chapter 1's "is gold 16-bit?" question (it is, the SWAP idiom is used on increment)
5. [Building economy](./05-building-economy.md) — every formula exposed: 9 prices (Crop=3 to Hospital=75), 5 income streams (factory baseline + fishing baseline + productivity bonus + stipend + in-round fishing), population model (fertility/mortality with Hospital as the only true win-win), 3 score components clamped at 30 each, 33% per-round crop mortality, the +10 stipend as anti-tilt floor; Don Daglow had modern game-design instincts in 1981
6. [The world (MOBs)](./06-mobs-and-world.md) — fishing as a navigation problem (50-tic threshold, +1 gold per cycle); pirates as random mortgage on parked boats; weather damage as a 125-point accumulator (hurricane=5/tic, storm=1/tic, rain=0); rain on crops gives +1 gold per 12 ticks (validates "hope for rain"); the neighbor-table fort defense (4 entries × ±1 = 8-direction coverage in 12 instructions); harbor as architectural throttle on boat acquisition
7. [Rebels & PvP friction](./07-rebels-and-pvp.md) — the **score-driven adaptive AI trigger** (the only adaptive mechanism in Utopia): score fell ≥10 → spawn rebel, rose ≥10 → remove rebel, < 30 → spawn, ≥ 70 → remove; mercenary vs computer-generated rebels share placement code with `CURPLR` flip; 250-attempt placement loop with fort-rejection; forts are the only fully indestructible building; closed-loop dynamic difficulty in 1981
8. [Round structure & synthesis](./08-round-and-synthesis.md) — full per-round sequence (tic loop → end-of-round → score → crop mortality → rebel adjustment → display); SCORES vs TOTALS toggle with delay loop using `X_RAND2` without RNG advance; end-of-game gracefully poisons the dispatch table; **project synthesis**: 4 CP1610 idioms total, source quality let us read the engine without ISA dive, the M.U.L.E. comparison is now ready as the next paired study

## What we expect to find

- **A small dominance graph** for building decisions: forts cost X, generate Y; factories cost A, generate B; the optimal mix probably depends on round length and weather pattern. This is the strategic-decision frontier that, once extracted, lets us test "can we math our way through Utopia?" at the same depth we did for CoM.
- **The "rebel placement = 250 tries" comment** suggests probabilistic placement with terrain rejection — a tiny Monte Carlo loop. Worth examining for what it says about how 1981 designers handled placement validity without a real RNG.
- **Asymmetric economic decisions** (forts protect, factories generate, schools/hospitals support population, PT boats raid) — likely scoring-tradeoff balanced rather than counter-graph balanced. Different design philosophy from a CoM-style spell game.

## LLM-interpretation log

Each chapter will end with notes on where the source labels carried sufficient meaning vs where CP1610 ISA / Intellivision MOB conventions had to be looked up. The hope, given the source quality, is that we read most of this game as a strategic engine without needing to learn the 16-bit ISA in depth. That hypothesis is itself the test.

## Tags

[games](../../../tags/games.md) · [strategy](../../../tags/strategy.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [llm-limitations](../../../tags/llm-limitations.md)
