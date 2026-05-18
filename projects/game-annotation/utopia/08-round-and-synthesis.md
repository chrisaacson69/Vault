---
status: complete
created: 2026-05-05
updated: 2026-05-05
---
# Utopia — Round Orchestration and Project Synthesis
> The full per-round sequence from per-tic-tic-tic-…-end-of-round through scores → crop mortality → rebel adjustment → display → next round → end-of-game. The SCORES vs TOTALS toggle and how it produces the round-summary screen. The synthesis: Utopia's strategic frontier is small, the tactical space is rich, and the source quality earned the project's hypothesis. Closing thoughts on what the Utopia case proves about the dominance-frontier framework, and the M.U.L.E. comparison that's now ready for the next session.

**Links:** [Utopia README](./README.md), all chapters [01](./01-memory-map.md) [02](./02-display-and-tiles.md) [03](./03-input-and-dispatch.md) [04](./04-tic-engine.md) [05](./05-building-economy.md) [06](./06-mobs-and-world.md) [07](./07-rebels-and-pvp.md), [Game Annotation Series](../README.md), [CoM Spell Counter-Graph](../../../research/gaming/master-of-magic/com-counter-graph.md), source: [`source/utopia.asm`](./source/utopia.asm)

## The full round sequence

After seven chapters of mechanics, the round structure is the assembly of all of them. From the moment a round begins to the moment the next one starts, the engine flows through:

```
Round begins:
  REMSEC = TRNLEN
  CURTRN += 1
  TICSEC = 0

  ┌─────────────────────────────────────────────────────────┐
  │ 20 Hz tic loop runs for TRNLEN seconds:                 │
  │   - per-tic weather/fish/pirate spawn rolls             │
  │   - per-tic random velocity tweaks                      │
  │   - per-tic island-collision check (4 MOBs)             │
  │   - per-tic STAT_TIC (count to 20 for second boundary)  │
  │   - per-tic STAT_UPD_FULL (refresh status bar)          │
  │   - per-tic L_54E8 (sinking-ship animation)             │
  │   - WTHR_V_LAND fires when weather over island          │
  │   - PARK_FISH/UNPARK_FISH fire on fish-boat overlap     │
  │   - L_54F8 fires when pirate over fishing boat          │
  │   - INC_GOLD fires for fishing & rain-on-crop           │
  │ End-of-round triggered when REMSEC reaches 0            │
  └─────────────────────────────────────────────────────────┘

End of round:
  L_5FEF: end-of-round tone
  L_59CD: scoring orchestrator runs:
    For each player:
      - Award gold (factories, fishing baseline, productivity bonus, +10 stipend)
      - Update population (births, deaths, capped at 9999)
      - Compute round score (housing, GDP, food, schools+hospitals welfare)
      - Add round score to total score (SCOR_n)
      - Update RSCO_n / PRSC_n
    Crop mortality: walk both islands, 33% chance per crop dies
    For each player:
      - Rebel adjustment (score-driven trigger):
          score fell ≥10 OR < 30  → spawn rebel
          score rose ≥10 OR ≥ 70  → remove rebel
          else                     → no change

  L_5429: round-summary display:
    Show RSCO_n for both players (right-justified, color-coded)
    Show "SCORES" header
    Loop with delay (X_RAND2 calls without consumption — pure delay)
    SC_TOT toggle: "TOTALS" mode
    Show SCOR_n for both players
    Loop again
    L_5475: clear flags, BARINH=0, return to main loop

Next round:
  REMSEC = TRNLEN
  CURTRN += 1
  ... (or end of game if CURTRN ≥ NUMTRN)

End of game (L_547E):
  Disable hand controllers (G_035D = $1906)
  Disable timer task (TICINH = 1)
  Display "FINAL SCORE"
  Kill all MOBs (X_KILL_MOBS)
  Return to EXEC ROM (PULR R7)
```

Three things to notice:

1. **The tic engine and the round transition are independent loops.** The 20 Hz tic runs whatever it runs — only when REMSEC drops to 0 does the round transition kick in. Inside the transition, the tic clock continues but `TICINH = 1` disables further tic processing while end-of-round logic completes (this is what the boot init also uses to suppress tics during setup screens).

2. **Scoring is the gate to the round-display loop.** Until L_59CD finishes, no display update shows the new scores. The round transition is a logical atomic unit — the player sees the world running, then a hard cut to the score summary, then resumes for the next round.

3. **End-of-game is graceful but unsalvageable.** The engine returns to the EXEC by `PULR R7` from the main routine. The state of MOBs, RAM, and BACKTAB is wiped via `X_KILL_MOBS` and the EXEC's normal teardown. **There's no "play again" option** — quitting requires a console reset. The game ends at game-end, period.

## The SCORES vs TOTALS toggle

When a round ends, the player gets a two-screen summary:

```asm
L_5429: CLRR    R1
        JSR     R5, DISP_ROUND_U    ; \_ display round totals for both
        MVII    #$0001, R1          ;  |  players
        JSR     R5, DISP_ROUND_U    ; /

L_5432: ...                          ; print "SCORES" or "TOTALS" based on $192

        MVI     SC_TOT, R1
        TSTR    R1
        BNEQ    L_5448              ; if SC_TOT=1, print TOTALS
        JSR     R5, X_PRINT_R5
        STRING  "SCORES"             ; if SC_TOT=0, print SCORES
        ...
        B       L_5452

L_5448: JSR     R5, X_PRINT_R5
        STRING  "TOTALS"
        ...

L_5452: SDBD                         ; \_ delay loop using X_RAND2 calls
        MVII    #$30D4, R4           ;  |  but NOT consuming the random
L_5456: ...                          ; /  numbers (the comment notes this)

        MVI     SC_TOT, R1
        TSTR    R1
        BNEQ    L_5475               ; if we already showed TOTALS, exit
        MVII    #$0001, R1           ; \_ next iteration: TOTALS mode
        MVO     R1,     SC_TOT       ; /
        ...
        JSR     R5, DISP_SCORE       ; show SCOR_n for player 0
        JSR     R5, DISP_SCORE       ; show SCOR_n for player 1
        B       L_5432               ; loop back, print "TOTALS" header

L_5475: CLRR    R1
        MVO     R1,     SC_TOT       ; reset the toggle
        MVO     R1,     BARINH       ; allow gold-bar display again
        MVI     CURTRN, R1
        B       L_53FD               ; → end-of-game check
```

So the round-summary screen actually shows **two consecutive states**:

1. **First**: round scores for both players (RSCO_n) labeled "SCORES"
2. **Then** (after delay loop): total scores for both players (SCOR_n) labeled "TOTALS"

The `SC_TOT` flag drives the toggle. Each state has a delay loop that calls `X_RAND2` repeatedly — *without consuming the result*. The source comment is explicit: `; Delay loop that calls RAND repeatedly, but does not actually advance random number generator.` This is **timing without state mutation** — a "pause for human readability" that doesn't perturb the RNG. The X_RAND2 call must be RNG-state-preserving when called a certain way, or the delay is observed via clock cycles rather than RNG output. Clever.

The result is the player sees: ROUND SCORE (3 sec) → TOTALS SCORE (3 sec) → next round. The human-readable pacing is literally baked into the round transition.

## End-of-game — minimal closure

When CURTRN reaches NUMTRN:

```asm
L_547E: SDBD                        ; \
        MVII    #$1906, R0          ;  |- Disable hand controllers (write
        MVO     R0,     G_035D      ; /  poison value to dispatch slot)

        MVII    #$0001, R0          ; \_ Inhibit timer task
        MVO     R0,     TICINH      ; /

        CLRR    R3
        MVII    #$02CC, R4          ; \
        JSR     R5, X_PRINT_R5      ;  |
        STRING  "FINAL  SCORE"      ;  |- The fat lady doth sing
        DECLE   $0000               ; /

        JSR     R5, X_KILL_MOBS     ; Bye bye, MOBs
        PULR    R7                  ; Return to the EXEC
```

Six steps: poison the dispatch table (controllers do nothing now), inhibit further tic processing, print "FINAL SCORE" header, kill all MOBs (clear sprites), return to EXEC. **No "play again" prompt.** The player has to reset the console.

The "FINAL SCORE" header overlays on top of the existing display — the islands and any remaining buildings stay visible, with the final score numbers shown below. The player gets to admire (or mourn) their final state for as long as they want, then resets.

The poison value `$1906` for the dispatch table deserves a note: it's the address of an empty/null dispatch table elsewhere in ROM. Writing it overrides `CTRL_DISPATCH_TBL`. **The dispatch table from Chapter 3 is itself a pointer-controlled redirection** — point it at a real table during gameplay, point it at empty during end-game, and the EXEC simply finds nothing to call back when input arrives.

## Project synthesis — what the Utopia case proves

Across 8 chapters and ~4,075 lines of CP1610 source, what did we learn about the project's central question?

### The hypothesis held

**Source quality lets us read this game at the engine level without learning the CP1610 ISA in depth.** The only mechanical CP1610 patterns required throughout were:
- The MVO + SWAP idiom for 16-bit storage to 8-bit memory (Chapter 1)
- The SLLC + BOV idiom for high-bit testing (Chapter 2, recurring everywhere)
- The SDBD prefix for two-byte memory access (Chapter 2, then ambient)
- The SLR R, 2 + SLR R, 1 = shift-by-3 idiom for tile decoding (Chapter 2)

**Four idioms total.** Every other CP1610 instruction (`MVI`, `MVII`, `ADDR`, `CMPI`, `BEQ`, `JSR`, etc.) is recognizable from 6502/general-CPU knowledge. The "deep ISA dive" we hedged about in the project README never became necessary.

What carried more weight than ISA: **the source's own comments and labels.** The author of `utopia.asm` (the disassembler, not Don Daglow — but they did rich annotation work) embedded subroutine labels, structural comments, and even a "him-a-cane" pun. Most of the chapter findings came from labels + comments + standard patterns we'd already established. **A well-annotated disassembly converts the chapter writing from reverse-engineering into curation.**

### The exposed-mechanics thesis

Chapter 5 was the acid test. The economic decision space — every formula, every constant, every clamp — extracted in 12 minutes of source reading what took the 1981 community decades to fold-knowledge-of-via-experiment. **Once exposed, the strategic decision space converges to a near-deterministic build order.** The user's observation lands: *"there isn't much space to explore, the build order is pretty static."*

This validates the [dominance-frontier framework](../../../research/gaming/master-of-magic/com-counter-graph.md) we built earlier:
- **Sparse counter-graph + small strategic frontier** = Utopia's mechanics.
- **Tactical depth (fishing positioning, weather reaction) > strategic depth** = exactly the Don Daglow design that made Utopia approachable but replayable.
- **The .260-hitter pattern** plays out at game-design scale: with formulas exposed, strategic deviations from optimal are rare and punishable; tactical execution is where the bell curve of player skill compresses.

The 1981 player faced *both* a mechanical-discovery challenge AND the tactical/play challenge. The 2026 reader of this annotation project gets only the second — but the second is rich enough to make the game replayable on its own.

### The score-driven rebel system

The biggest design surprise was Chapter 7. The rebel system is **the only adaptive mechanism in Utopia** — score-falling triggers rebel spawn, score-rising triggers rebel removal, with absolute-value thresholds at 30 and 70. This is **closed-loop dynamic difficulty** — modern game-design vocabulary for what Don Daglow built in 1981.

It pulls double duty: negative feedback on failure (don't run away with a loss), positive feedback on success (recover momentum). Without it, scores would diverge over rounds; with it, scores converge. Combined with the +10 stipend (Chapter 5), Utopia has *two* anti-tilt mechanisms — both invisible to the player, both essential to the game's pacing.

### What the chapter discoveries collectively answer

The original Utopia README posed the question: **what mechanical patterns emerge as designers move from real-time action to turn-based strategy with hidden state?** The 8-chapter answer:

1. **Hidden state is enabled by clever encoding.** Bit 14 of the display word as ownership oracle (Chapter 2) is the design move. RAM is the binding constraint; BACKTAB has spare bits; use them.
2. **Event-driven input + per-tic world simulation** is the architectural split (Chapter 3 + 4). Modern ECS-shaped, in 1981.
3. **Probabilistic budgets** (1% weather, 5% fish, etc.) replace explicit timers. Each per-tic event is a die roll, easy to tune.
4. **Score formulas that scale inversely with population** (Chapter 5) prevent pop-stacking — a deliberate counter-intuitive design.
5. **Score-driven adaptive AI** (Chapter 7) prevents runaway games and rewards momentum.
6. **The 8 hardware sprites** are allocated symmetrically (2 of each thing — weather, players, pirates, fish — one per side) for fairness (Chapter 1 + 6).

Six patterns. **Each is recognizable in modern game design.** Don Daglow shipped them in a 4,075-line CP1610 cartridge in 1981.

## The M.U.L.E. comparison — ready to make

With Utopia fully exposed, the next paired comparison comes into focus.

[M.U.L.E.](https://en.wikipedia.org/wiki/M.U.L.E.) (Ozark Softscape, Dani Bunten Berry, 1983, Atari 800) is what we'd compare against in the Game Annotation Series's mechanical-complexity arc. The pairing question: **how does adding player-interaction (auctions) to a similar economic-strategy engine expand the strategic decision space?**

Utopia's design space looks like this:
```
Strategic decisions:    Compute optimal build order from formulas
Tactical decisions:     Position boats, react to weather, time defenses
PvP layer:              Mercenary rebels (one-shot purchase) only
Information:            Full (both islands visible)
Equilibrium:            Score-driven rebel dynamics converge games
```

M.U.L.E.'s design space (from memory; would need source reading to verify):
```
Strategic decisions:    Resource allocation across a 4-player auction
Tactical decisions:     Negotiation, bid timing, sabotage
PvP layer:              Auction-mediated competition (every round)
Information:            Asymmetric (commodity prices, others' inventories)
Equilibrium:            Round-by-round market-clearing
```

The hypothesis to test in M.U.L.E.: **the auction layer turns the strategic decision space from "compute the answer" to "compute the answer given what others will compute."** That's a fundamentally larger frontier — game-theoretic, not just optimization-theoretic. Adding it to a Utopia-style economic spine would isolate exactly the variable that makes M.U.L.E. famous for replayability while sharing the broader genre with Utopia.

Source-availability for M.U.L.E. is the gating question. The Atari 800 community has done substantial reverse-engineering work; an annotated disassembly may exist. If so, M.U.L.E. is the natural next chapter target. If not, raw disassembly is feasible — the 6502 idioms from Adventure and Mappy carry over directly (no new ISA to learn). NA stays in the queue but as a *third* comparison rather than the immediate next one.

## What the Utopia chapters establish for future game-annotation work

A method that compounded across 8 chapters:

1. **Memory map first** (Chapter 1). Without the variable layout, nothing else makes sense. This is where the per-game vocabulary establishes itself.
2. **Display next** (Chapter 2). How the world is *shown* often reveals how it's *stored* — and the encoding tricks (like Utopia's bit-14 ownership) come out here.
3. **Input/dispatch** (Chapter 3). The control architecture — event-driven vs polled — sets the rhythm of the chapters that follow.
4. **The main loop** (Chapter 4). Whatever runs every frame is the game's heartbeat. Probability budgets and per-tic accumulators surface here.
5. **Game economics** (Chapter 5). The decision space the player operates in. This chapter validates or refutes the project hypothesis.
6. **World/AI** (Chapter 6). Non-player entities and their lifecycles. Often the densest mechanical chapter.
7. **Adversarial systems** (Chapter 7). Rebels, raids, AI threats — usually the cleverest design ideas.
8. **Round/game orchestration + synthesis** (Chapter 8). The full sequence and the project closure.

This is the **template that worked for Adventure, Mappy, and now Utopia.** Adventure's chapters covered different topics (display kernel, sprite multiplexing, dragon AI, room graph, Easter egg) but followed the same beats: data → display → control → loop → mechanics → world → AI → synthesis. Mappy had its own variations. Three games, same skeleton.

For M.U.L.E. (or NA, or whatever comes next), this template is the entry point. The first read of the source can survey for: where's the memory map? what's the display loop? where's the input dispatch? what runs per-tic? what's the economic engine? Each question maps to a chapter, and the chapter pattern from prior games carries over.

## Curiosities

**The X_RAND2-without-consume delay loop.** The fact that `X_RAND2` can be called without advancing the RNG suggests it has a "peek" mode or that the call's overhead provides reliable timing. Either way, it's a clever way to use an EXEC ROM utility for timing without polluting the random state. **The delay loop literally consumes the RNG calls' time without their entropy.**

**The "FINAL SCORE" overlay leaves the islands visible.** The screen at game-end shows islands with all the buildings the players built, plus the final score numbers. **The state of the world is preserved as part of the closure** — the player doesn't see a wiped screen, they see what they built. This is gentle, mournful design — a small grace note that 1981 game designers chose to include.

**The dispatch-table poison `$1906` is a real address.** When end-of-game writes that to `G_035D`, the EXEC follows the pointer and finds an actual table that contains zero entries (or terminator words). Disabling controllers via redirection rather than a flag is clever — same mechanism as enabling, opposite endpoint. **Symmetry of design.**

**Don Daglow went on to design Earl Weaver Baseball, Neverwinter Nights (the original online multiplayer one in 1991), and many other genre-defining titles.** The patterns he used in Utopia — adaptive AI, probabilistic worlds, per-capita scoring, anti-tilt floors — became building blocks for an entire career of game design. Reading Utopia's source is reading the early playbook of someone who shaped the next 25 years of strategy games.

## LLM-interpretation log

| Source of understanding | Where it carried |
|---|---|
| **Source labels alone** | The full round sequence, end-of-game flow, SC_TOT toggle. |
| **Source comments** | The X_RAND2-as-delay confirmation ("does not actually advance random number generator"), the "fat lady doth sing" comment on end-of-game, the CTRL_DISPATCH_TBL poison value. |
| **CP1610 ISA knowledge required** | None new this chapter — everything covered in earlier chapters' idioms. |
| **External hardware knowledge required** | None new. |
| **Disagreements with source** | None. The closing chapter is the cleanest of all — every comment is accurate, every routine is well-named. |

Net for the project hypothesis, final accounting: **8 chapters, 4 unique CP1610 idioms learned, ~4,075 lines of source read, every formula and mechanic extracted.** The project shipped on its hypothesis. The source quality was the enabling factor; the chapter pattern was the methodology; the dominance-frontier framework was the analytical lens that made the findings cumulative rather than just a list.

## Tags

[games](../../../tags/games.md) · [strategy](../../../tags/strategy.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [llm-limitations](../../../tags/llm-limitations.md)
