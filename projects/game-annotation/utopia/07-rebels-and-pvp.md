---
status: active
created: 2026-05-05
updated: 2026-05-05
---
# Utopia — Rebels and PvP Friction
> The clever score-driven trigger that makes the AI rebel against you when you fail (or succeed too quietly). The 250-attempt placement loop with fort-rejection. Why rebels are item #7 even though they're the only thing you can buy that targets the *opponent's* island. The two paths: mercenary (purchased, 30 gold) vs computer-generated (your own popularity collapsing), and how the game distinguishes them.

**Links:** [Utopia README](./README.md), [Memory Map](./01-memory-map.md), [Building Economy](./05-building-economy.md), [MOBs and World](./06-mobs-and-world.md), source: [`source/utopia.asm`](./source/utopia.asm)

## What rebels are

A rebel is a building-tile (item #7) placed on the *opposing player's* island. Once placed, it sits there as a destroyed tile (the original island/building is replaced by a rebel marker), and it counts in `REBL_n` — except, per Chapter 1, the count is *never read*. The mechanical effect is purely the destruction it causes: the tile that *was* a fort/factory/crop/etc. is now a rebel and contributes nothing to score.

So rebels are **destruction with a marker.** The marker is the rebel-tile graphic (item #7), which lets the player visually identify "yes, you've been rebelled." The 1-square fort-defense check (`FORT_NEAR_CARD`) excludes tiles near forts from rebel placement — so a fort-protected island is rebel-resistant.

## Two kinds of rebels — same mechanism, different trigger

Rebels can arise two ways:

1. **Mercenary** — a player buys item #7 from the keypad (cost: 30 gold). The buy commit (`L_5877` from Chapter 5) catches `CURSEL == 7` early and special-cases it via `L_594C`:

```asm
L_594C: PSHR    R5
        MVII    #$0001, R1          ; \_ flag this as a mercenary
        MVO     R1,     RBLTYP      ; /  (RBLTYP = 1)
        JSR     R5,     L_595A      ; toggle CURPLR (target the OTHER player)
        CLRR    R0
        MVO     R0,     RBLTRY      ; reset placement try counter
        J       L_5BE8              ; → start placement loop
```

Note the **CURPLR toggle** — when the buyer purchases a rebel, the placement code targets the *opposite* player's island. This is the only purchase that flips ownership intent. Cost: 30 gold (cheaper than a fort, far cheaper than a hospital).

2. **Computer-generated** — emerging from the round-scoring sequence after the score is computed for both players. The rebel-decision logic at `L_5BB5` runs once per player per round:

```asm
L_5BB5: CLRR    R0                  ; \_ reset retry counter
        MVO     R0,     RBLTRY      ; /
        MVII    #PRSC_0,R1          ; \_ load previous round's score
        ADD     CURPLR, R1
        MVI@    R1,     R0          ; /
        MVII    #RSCO_0,R1          ; \_ load THIS round's score
        ADD     CURPLR, R1
        MVI@    R1,     R2          ; /

        SUBR    R2,     R0          ; \_ delta = previous - current
        CMPI    #$000A, R0          ;  |  (positive = score fell)
        BGE     L_5BE8              ; / "fell by ≥ 10 → rebel!"

        SDBD                        ; \_ "rose by ≥ 10?"
        CMPI    #-10,   R0          ;  |
        BLE     L_5C50              ; / "→ remove a rebel"

        CMPI    #$001E, R2          ; \_ "current < 30?"
        BLT     L_5BE8              ; / "→ rebel!"

        CMPI    #$0046, R2          ; \_ "current ≥ 70?"
        BGE     L_5C50              ; / "→ remove a rebel"
```

Decoded: the scoring system **judges your popularity** and adjusts rebel pressure accordingly:

| Condition | Action |
|---|---|
| Score *dropped* by ≥ 10 vs last round | Spawn a rebel |
| Score *rose* by ≥ 10 | Remove a rebel |
| Score < 30 (objectively bad) | Spawn a rebel |
| Score ≥ 70 (objectively good) | Remove a rebel |
| Otherwise (steady, mid-range) | No change |

This is **dynamic AI threat scaling driven by your own performance** — exactly what we ruled out as missing in Chapter 4 ("no adaptive difficulty"). It IS there, but only at the *round* level, not the per-tic level. The per-tic world (weather, fish, pirates) is fully stationary; the rebel system is the one piece that responds to you.

Why design it this way? Two reasons jump out:
- **Negative-feedback loop on success.** A player who's running away with the lead gets free rebel-removal (popular leaders earn loyalty); a player who's collapsing gets piled on (failure breeds more failure). This compresses the score gap between players over a long game.
- **Threshold thresholds, not gradients.** The trigger uses comparisons (`≥ 10`, `< 30`, `≥ 70`) not slopes — easy to compute, fits in a few CMPI/BGE instructions, and gives the rebel system a clear "was I right at the edge?" signal.

For mercenaries, `RBLTYP = 1` records the path; for computer-generated, `RBLTYP = 0`. The difference matters because the mercenary path explicitly toggles CURPLR (target opponent) while the computer-generated path uses CURPLR = "the player whose round score we're evaluating" (target self). **Same placement code; different victim, set by who's calling.**

## The 250-attempt placement loop

Once a rebel decision is made (mercenary purchase or computer-generated), placement runs at `L_5BE8`:

```asm
L_5BE8: MVI     RBLTRY, R0
        CMPI    #$00FA, R0          ; tried 250 times yet?
        BGT     L_5BE1              ; yes: give up
        INCR    R0
        MVO     R0,     RBLTRY

        ; Pick a random tile on the target player's island
        MVI     CURPLR, R0
        TSTR    R0
        BNEQ    L_5BFC
        MVII    #LFT_ISLE_OFS_TBL,R3 ; player 0's island
        B       L_5C00
L_5BFC: MVII    #RGT_ISLE_OFS_TBL,R3 ; player 1's island

L_5C00: MVII    #$001D, R0          ; \_ rand(0..29) → which island tile?
        JSR     R5,     X_RAND2     ; /
        ADDR    R0,     R3
        MVI@    R3,     R2          ; \_ get BACKTAB position
        ADDI    #$0200, R2          ;  |
        JSR     R5, GET_TILE_NO     ; / get tile type

        CMPI    #$0007, R1          ; \_ already a rebel? skip
        BEQ     L_5BE8
        CMPI    #$0001, R1          ; \_ is it a fort? skip (forts are immune)
        BEQ     L_5BE8

        PSHR    R2
        MVO     R1,     CURSEL      ; remember what we're nuking
        JSR     R5, FORT_NEAR_CARD  ; \_ is there a fort within 1 square?
        PULR    R2
        TSTR    R1
        BNEQ    L_5BE8              ; / yes: skip (fort defense extends)

        ; ... actually nuke the tile ...
```

The placement is **probabilistic with rejection**. Each iteration picks a random island tile (one of ~30 land tiles per island), checks three rejection criteria:

1. Already a rebel? Skip — don't double-stack.
2. Is it a fort? Skip — **forts are immune to rebel placement** (forts are also immune to weather destruction earlier — they're the only fully indestructible building).
3. Is there a fort within 1 square? Skip — **fort defense extends one tile in every direction**.

If all checks pass, the tile is destroyed: item count decremented (the building it *was*), the tile's color-stack-advance bit toggled, the "you've been smited" sound effect plays. The rebel marker is then deposited at the same tile.

If 250 attempts pass without a successful placement, give up (`L_5BE1`). For computer-generated rebels, this just means "no rebel this round — your defenses were too strong." For mercenary purchases, the 30 gold is *still gone* but the rebel didn't appear — **a wasted purchase if the opponent has too many forts.**

## The strategic shape of fort defense

Combining everything:

- **Forts cost 50 gold.** No score contribution.
- **Each fort makes itself + 8 neighboring tiles immune to rebel placement.**
- **Each fort makes itself + 8 neighboring tiles immune to pirate predation** (Chapter 6).
- **Each fort makes itself + 8 neighboring tiles take less weather damage** (the fort-near check at `L_56BC` skips the 125-point damage accumulator — fort-protected tiles are weather-immune, although the source needs a closer read to confirm vs reduced).
- **One fort can cover up to 9 tiles** (a 3×3 square centered on it). With 30 land tiles per island, **3-4 well-placed forts can cover the entire island.**

So forts are the **insurance product**: high upfront cost, no income, but they cap downside risk from three different threat types. The decision to build a fort vs another factory/hospital is a risk-tolerance question. **A late-game player with maxed-out scoring should usually have built 3-4 forts** to lock in their lead against rebel decay and weather catastrophes.

This also explains why the AI's rebel system targets *unfortified* tiles only — without the fort exclusion, every rebel decision would just destroy an arbitrary building, regardless of player defense. The fort-rejection makes investment in defense matter.

## Mercenary rebels as a buy-target attack

Mercenary rebels are the only thing in the game that lets a player *directly attack* the opponent. Cost analysis:

- **Mercenary rebel**: 30 gold, destroys 1 building on opponent's island, fails silently if opponent has forts.
- **Opponent's lost building**: an arbitrary tile, on average worth one of the 9 building types weighted by how many they have. Average opponent building value ≈ 30-50 gold (mid-tier).
- **ROI**: 30 gold spent for ~30-50 gold of opponent damage = roughly break-even attacker, *unless* the destroyed building was strategically critical (a hospital, hurting their pop growth) or unless the opponent's defenses prevent placement (then -30 gold for nothing).

So mercenary rebels are a marginal-EV attack against undefended opponents and a pure waste against fortified ones. **The best time to buy mercenary rebels is when you've scouted the opponent has < 3 forts** — and there's no scouting in Utopia, so **you're guessing.** This is the closest thing to PvP information warfare the game has.

The AI's computer-generated rebels are *not* in this same category — they're a system penalty for poor performance, not an attack. From the score-driven trigger logic, the AI cannot strategically target you with rebels; it just evaluates each player's score change and spawns rebels on whoever fell behind.

## Removing rebels — popularity rewards

When a player's score rises by ≥ 10 from the previous round, or when they reach ≥ 70 in absolute terms, control reaches `L_5C50` (rebel removal). The mechanism (not shown in detail above): walk the player's island, find a rebel tile (#7), restore the underlying island terrain. **One rebel removed per qualifying round.** Multi-round high performance progressively cleans up your island.

This creates a positive-feedback loop on success: doing well → fewer rebels → cleaner island → more buildable tiles → more buildings → higher score → fewer rebels. **The game rewards momentum.** A player who breaks above 70 is rapidly de-rebelled and can start growing into the freed tiles.

Combined with the negative-feedback loop on failure, the rebel system is the **single mechanic** that makes Utopia games converge rather than diverge. Without it, a small early advantage compounds into a runaway lead. With it, momentum is rewarded but not absolute — a struggling player can recover if they string together good rounds.

## Curiosities

**Computer-generated rebels target the player whose score was just computed.** Mercenary rebels target the *opposite* player. The same `L_5BE8` placement code handles both — the only difference is the value of `CURPLR` when entering. **One placement engine, two trigger paths, completely different game-effects.**

**The 250-attempt limit exists because the placement could fail silently.** With ~30 tiles per island and various rejection criteria, the probability of a single random pick succeeding is significantly less than 1. 250 attempts gives the engine a high chance of placing successfully when valid tiles exist, while bounding the worst case (a player with 3-4 forts covering everything) so the engine doesn't infinite-loop.

**Forts are the only fully indestructible building.** The rebel placement explicitly skips forts (`CMPI #$0001, R1; BEQ L_5BE8`). Combined with the fort-near-MOB check on weather damage, forts are the only building that nothing in the game can destroy. (Unverified: whether a hurricane sitting on a fort eventually destroys it via the 125-damage threshold — needs another source read.)

**The score-driven AI rebel logic is independent per player.** Both players have their score evaluated separately and rebels spawned (or removed) on each independently. This means **two players with similar scores get similar rebel pressure** — the game doesn't preferentially attack the leader; it attacks the failing player and rewards the rising one.

## What this clarifies for later chapters

- **Chapter 8 (round/scoring orchestration)**: the rebel-decision logic is *part* of the round-scoring sequence — it runs after scores are computed but before display. The full per-round sequence is: tic engine → end-of-round trigger → award gold → update population → compute scores → crop mortality → rebel adjustment → display rounds. Chapter 8 will trace the full sequence.

## LLM-interpretation log

| Source of understanding | Where it carried |
|---|---|
| **Source labels alone** | `RBLTYP`, `RBLTRY`, `FORT_NEAR_CARD`, `L_5BB5` (rebel decision), `L_5BE8` (placement loop). The structural role of each block is clear from labels. |
| **Source comments** | The mercenary vs computer-generated distinction (the `RBLTYP` comments). The "you've been smited!" SFX comment confirms the destruction-via-rebel path. The fort-rejection check is uncommented but obvious from the call to `FORT_NEAR_CARD`. |
| **CP1610 ISA knowledge required** | None new. The placement loop uses random + index + rejection-test patterns we already know. |
| **External hardware knowledge required** | None. |
| **Disagreements with source** | None. The score-driven AI logic is one of the most readable sequences in the game — straight CMPI/BGE chains with obvious thresholds. |

Net: **the rebel system is the cleverest game-design idea in Utopia, hiding behind the most readable code.** The score-driven trigger is the only adaptive mechanism in the game — and it pulls double duty (negative feedback on failure, positive feedback on success). For 1981, this is sophisticated AI design hidden in 50 lines of CP1610.

## Tags

[games](../../../tags/games.md) · [strategy](../../../tags/strategy.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [llm-limitations](../../../tags/llm-limitations.md)
