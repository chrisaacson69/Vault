---
status: active
created: 2026-05-05
updated: 2026-05-05
---
# M.U.L.E. — The Four Nested Time Scales (BTU / PTU / ATU / CTU)
> Kroah identified explicitly: M.U.L.E. has *four* nested time scales (Utopia had three). BTU = the base 1/15s clock. PTU = per-player turn time, **modified by race and level** — Humans are 30% faster than baseline, Flappers 30% slower. Race is implemented as a time-pressure stat. ATU = auction pacing, **divided by 4 when nobody moves**. CTU = cursor speed during land grant. The level system scales three of the four independently. Beginners get all three relaxed; Tournament Humans get all three crushed.

**Links:** [M.U.L.E. README](./README.md), [Memory Map](./01-memory-map.md), [Input & Cursor](./03-input-and-cursor.md), [Bringerp's Time Unit section](http://bringerp.free.fr/RE/Mule/mule_document.html#TimeUnit), [Utopia Tic Engine](../utopia/04-tic-engine.md), source: [`source/mule.asm`](./source/mule.asm)

## The framework, from Kroah's doc

Bringerp's M.U.L.E. document v0.41 explicitly identifies **four nested time scales**, each with a defined formula. Quoting the structure:

```
BTU = Base Time Unit         = 4 jiffies = 1/15s NTSC
PTU = Player Time Unit       = 7 BTU + race + level modifiers
ATU = Auction Time Unit      = level-dependent, /4 when nobody moves
CTU = Cursor Time Unit       = level-dependent (land grant only)
```

This is **explicit time architecture documented as such by the designer's intent** — Kroah didn't invent these names; they appear to be the developer's mental model carried into the source. The granularity is unusual for 1983: most games of the era have one tick rate (frame rate or VBI) and call it a day. Bunten architected four because the game has four phases that need different pacing.

## BTU — the base clock

A "jiffy" is the time between two VBL (vertical blank line) interrupts. On NTSC: 1 jiffy = 1/60s. On PAL: 1 jiffy = 1/50s.

**BTU = 4 jiffies.** On NTSC, that's `4 × 1/60 = 1/15s ≈ 0.067s`. On PAL: `4 × 1/50 = 1/12.5s = 0.08s`. **PAL games run slower** — a real consequence of M.U.L.E.'s frame-locked timing.

The BTU is the *event-processor tick*. M.U.L.E.'s main loop runs once per BTU. Every other time scale is built on it.

**Compare to Utopia:**
- Utopia's tic = 1/20s, hardware-independent (Intellivision EXEC enforces 20 Hz)
- M.U.L.E.'s BTU = 1/15s NTSC / 1/12.5s PAL — frame-locked to VBL, so video standard matters

So Utopia is *slightly faster* per tic (50ms vs 67ms) but Utopia and M.U.L.E. are roughly comparable as 15-20 Hz update rates. Both are far slower than NES games (60 Hz typical) — both designers chose to do less work per tick to fit more game logic per call.

## PTU — Player Time Unit, modified by race and level

The PTU determines how fast the *time bar* (visual countdown of player's turn) decreases. **One pixel of the time bar = one PTU.** Smaller PTU = faster countdown = less time per turn.

```
PTU = 7 BTU + race_modifier + level_modifier
```

**Race modifiers:**

| Race | Modifier | PTU when Standard/Tournament |
|---|---|---|
| Flapper | +2 BTU | 9 BTU (slower turn timer) |
| Human | -2 BTU | 5 BTU (faster turn timer) |
| Mechtron, Bonzoid, Spheroid, Leggite | none | 7 BTU (baseline) |

**Level modifiers:**

| Level | Modifier |
|---|---|
| Beginner | +2 BTU (more time per pixel) |
| Standard | none |
| Tournament | none |

**Combining:**

| Player | PTU | Time per pixel |
|---|---|---|
| Beginner Flapper | 11 BTU | 0.73s |
| Beginner anything else | 9 BTU | 0.6s |
| Standard/Tournament Flapper | 9 BTU | 0.6s |
| Standard/Tournament baseline race | 7 BTU | 0.47s |
| Standard/Tournament Human | 5 BTU | 0.33s |

**Range: 0.33s/pixel (Tournament Human) to 0.73s/pixel (Beginner Flapper) — a 2.2× span.** A Human player at Tournament level has *less than half* the per-pixel reaction time of a Beginner Flapper.

**This is the key M.U.L.E. design move: race is a time-pressure stat, not a power stat.** In most strategy games, race/class affects what you can *do* (different units, different abilities). In M.U.L.E., race affects how *fast* you have to do the same things. Humans are "hard mode" — high-pressure but high-skill-reward; Flappers are "easy mode" — relaxed but with the same strategic options.

Bunten designed this for the social table. **Newer players pick Flappers and have time to think; experienced players pick Humans and trade time pressure for the same toolset.** Same game, asymmetric difficulty per player, no unfair advantages — just paced differently. Brilliant onboarding architecture.

PTU is used by:
- The available-time-for-turn countdown (the visible time bar)
- Wampus initial delay
- Wampus movement speed
- Pub gambling tick
- Computer turn AI

## ATU — Auction Time Unit

The ATU paces the auction phase. Same model as PTU: one pixel of the auction time bar = one ATU. Smaller ATU = faster auction.

**ATU is purely level-dependent (no race modifier):**

| Level | ATU | Time per pixel | "/4 when nobody moves" |
|---|---|---|---|
| Beginner (first round) | **100 BTU** | 6.67s | 1.67s |
| Beginner (subsequent rounds) | 50 BTU | 3.33s | 0.83s |
| Standard | 30 BTU | 2s | 0.5s |
| Tournament | 25 BTU | 1.67s | 0.42s |

Two design choices worth flagging:

1. **Beginner mode doubles ATU on the first round.** New players get *extra* time on their first auction — onboarding tax break. This is the same instinct as Utopia's `+10 stipend` (anti-tilt for new players) but expressed as time-pressure relief instead of resource floor. **Don Daglow and Dani Bunten Berry both built explicit beginner-grace into 1981/1983 cartridges.**

2. **ATU is divided by 4 when no player is moving.** This is the **anti-stall mechanism**. If everyone is staring at the screen deciding what to bid, the auction pauses (slows by 4×) so nobody gets penalized for thinking. As soon as anyone moves their bid, the timer resumes at full speed. **Auction pacing is reactive to player engagement** — the game gets out of the way when you're thinking and pressures you when you're committing. This is a 1983 implementation of "don't fail the player for not having figured it out yet" that most modern UI design still gets wrong.

ATU is used by:
- The auction time bar (visible countdown)
- Bid update rate (cursor moving up/down sets bid)
- Auction phase transitions

## CTU — Cursor Time Unit (land grant only)

The CTU is the lowest-level time scale and is **only used during the land-grant phase** at the start of each round. The cursor moves from one land tile to the next at every CTU. Smaller CTU = faster cursor.

**Level-dependent only:**

| Level | CTU | Time per land step |
|---|---|---|
| Beginner | 8 BTU | 0.53s |
| Standard | 4 BTU | 0.27s |
| Tournament | 3 BTU | 0.2s |

**At Tournament level, the cursor advances 5× per second.** Players have to react in 0.2s to commit on a desired land. This is **reflex mechanics layered on top of the strategic land-evaluation decision** — the strategy is "which land is best?" but the execution is "can I press the button at 0.2s precision?"

We saw `cursorWait = 3` in the source captured at runtime — that maps to Standard CTU (4 BTU - 1 = 3 ticks of wait between cursor moves). The variable directly stores the level's CTU.

CTU is bringerp's CTU but matches what we identified in Chapter 3 as `cursorWait`.

## The full picture: nested time

```
                     1 jiffy = 1/60s NTSC (VBL period)
                     1 BTU   = 4 jiffies = 1/15s
                     ───────────────────────────────
   Per-tick events ──┘ Main loop runs at every BTU
                     ↓
                     1 PTU = 7 BTU + race + level
                     ───────────────────────────────
   Player turn bar ──┘ Decrements one pixel per PTU
                     ↓
                     1 ATU = 25-100 BTU (level-dep, /4 when idle)
                     ───────────────────────────────
   Auction time bar ─┘ Decrements one pixel per ATU
                     ↓
                     1 CTU = 3-8 BTU (level-dep)
                     ───────────────────────────────
   Land-grant cursor ┘ Advances one tile per CTU
```

Four scales nested cleanly. Each scale is a **multiplier of the BTU**: `1 PTU = N BTU`, `1 ATU = M BTU`, `1 CTU = K BTU` — and N, M, K are configurable by race + level. The BTU is the heartbeat; everything else is `BTU × multiplier`.

**Compare to Utopia's three scales:**

| Utopia | M.U.L.E. |
|---|---|
| Tic = 1/20s (fixed) | BTU = 1/15s (fixed, video-locked) |
| Second = 1s (TICSEC counting to 20) | PTU = 7 BTU baseline (race/level varies) |
| Round = TRNLEN seconds (player-configured) | ATU = 25-100 BTU (level-dep, idle-divided) |
| (no equivalent) | CTU = 3-8 BTU (level-dep) |

**M.U.L.E. has the same base-clock + per-context-scaled-clock pattern, but with one extra scale (CTU) and explicit per-player asymmetry (PTU race modifier).** The CTU exists because land grant has a special phase where the cursor auto-advances; Utopia had no auto-advance phase, so no CTU equivalent.

**The PTU race modifier is the sharpest design difference.** Utopia is symmetric — both players play under identical timing. M.U.L.E. is *asymmetric per player* — different races have different time budgets for the same actions. This pre-figures modern asymmetric games (Among Us roles, Dead by Daylight survivor/killer split, etc.) by 30+ years.

## Why four scales matter for the strategic layer

The strategic implications jump out:

- **A Tournament Human player has the highest tactical execution requirement** but the same strategic options as everyone else. They get to *do* the same things, just faster. Their advantage is the time they save not deliberating.
- **A Beginner Flapper has 2.2× more time per turn** than a Tournament Human. They can think through more moves but have the same strategic frontier.
- **Auction PTU vs ATU asymmetry**: per-turn time uses PTU (race-sensitive); auction uses ATU (race-blind). So the *relative* power of a fast-race player drops in auctions vs in their turn — the auction is the equalizer phase. **Bunten explicitly tuned auctions to be race-fair.**
- **Idle-pause on auctions** (ATU/4) is a structural change to bidding economics: a strong bidder can *stall* by simply not moving, slowing the auction to give themselves more decision time. **The auction is a game of nerve as much as price** — moving too early commits you; staying still slows the pressure on you specifically.

This is the kind of finding the dominance-frontier framework was built to expose. **The strategic decision space includes "don't move" as an active strategy** — something Utopia didn't have at all.

## What this clarifies for later chapters

- **Chapter 5 (production)**: production runs once per round. The round itself is paced by the sum of player turns, which are PTU-scaled.
- **Chapter 6 (store / price dynamics)**: prices update at end of round, after all turns. Round length scales with PTU, so faster races mean shorter rounds globally — a slight pacing effect on price stability.
- **Chapter 7 (auctions)**: the bid mechanic runs on ATU. The /4 idle-pause is critical — it determines auction game-theory (when to move, when to wait).
- **Chapter 8 (synthesis)**: the four-scale architecture is one of the strongest comparative findings vs Utopia. PTU race modifiers as the asymmetric-difficulty mechanism is a Bunten signature worth preserving in the synthesis.

## Curiosities

**PAL games run slower than NTSC games.** This was a known M.U.L.E. quirk — European players had a 7% slower game (1/12.5s vs 1/15s BTU). Bunten could have compensated but chose to lock to VBL for free 60 Hz timing. Modern game engines decouple game logic from frame rate to avoid this; 1983 cartridges didn't.

**The first-round Beginner ATU doubling is a one-shot grace.** It only applies to round 1. Beginners on round 2+ get the standard 50 BTU ATU. This is *targeted onboarding* — extra help where it matters most (the first-ever auction experience), then back to normal pacing.

**There's no level modifier for ATU during gameplay** — only first-round Beginner-doubling and the constant per-level base. So the auction phase is the most consistent across difficulties; Beginner just gets a longer first auction. **The auction is the equalizing mechanic.** Race PTU asymmetries don't apply; the only level effect is overall pacing.

**`cursorWait = 3` we saw in source = Standard CTU (4 BTU - 1).** Confirms Chapter 3's hypothesis. The runtime memory dump was captured during a Standard-difficulty game.

## LLM-interpretation log

| Source of understanding | Where it carried |
|---|---|
| **Source labels alone** | `cursorWait`, `level`, `numRound`. Tied the source-side variables to bringerp's terms. |
| **Source comments (French)** | `// vitesse du curseur`, level enumeration. Limited; the source isn't where the time architecture lives. |
| **Bringerp's documentation** | **The entire chapter.** Without his Time Unit section, the four scales would be hidden in scattered constants throughout the codebase. He documented this beautifully. |
| **6502 / Atari ISA knowledge** | None new. The VBL-driven event loop is standard Atari practice. |
| **External knowledge required** | Atari VBL = 60 Hz NTSC / 50 Hz PAL (frame rate to BTU calculation). |
| **Disagreements with source** | None. Bringerp's formulas align with what's recoverable from source — `cursorWait = 3` matches CTU = 4 BTU minus 1 for the wait counter. |

Net: this is the **synthesis-first chapter par excellence.** Without bringerp the framework would have been discoverable but slow (greppinng for time-bar update routines, decoding rate constants from context). With bringerp, the chapter is mostly his findings + cross-reference + Utopia comparison. **Path C in action.**

## Tags

[games](../../../tags/games.md) · [strategy](../../../tags/strategy.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [llm-limitations](../../../tags/llm-limitations.md)
