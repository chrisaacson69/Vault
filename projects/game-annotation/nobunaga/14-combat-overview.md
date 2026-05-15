---
status: active
created: 2026-05-14
---
# Chapter 14 — Combat: Structure, Strings, and the Day Loop

> Chapter 13 stitched together the strategic loop and noted that two wars were *folded into* the AI's turn. This chapter opens the war door. A targeted Mesen `$EB7A` trace across one full battle — Oda invading a revolt-weakened province — surfaces combat's call-graph shape, while a string sweep across the ROM reveals the in-battle command set, the unit types, the failure modes, and the day counter. Together they give us the *map of combat* — entry point, inner loop, the 3-unit-type model, the 5-verb tactical menu, and the four ways a battle ends — without yet decoding the per-cell damage formula. That formula lives inside `$828B` and is the next chapter's static walk; this chapter gives every later chapter their anchor.

**Links:** [Chapter 13 — Turn Loop](./13-turn-loop-and-harvest.md) · [Chapter 11 — Strategic Engine](./11-strategic-engine-complete.md) · [Nobunaga README](./README.md) · [project_nobunaga_combat_fief_maps](../../../../.claude/projects/C--Users-Chris-Isaacson-Vault/memory/project_nobunaga_combat_fief_maps.md)

## The combat shape, from the trace

41 474 `$EB7A` events over ~4 900 frames of one battle decompose into three phases:

```
1) Entry / war announcement   (Fr ≈ 12780)
2) Tactical-map setup loop    (Fr 12789 – 12930, ~25 iterations)
3) Combat inner loop          (Fr 12930+, continuous until battle ends)
```

Phase 1 is one-time setup: a single `$81FC` call announces the invasion. (`$81FC` is *not* a separate sub; it's a label **+500 bytes into the bank-0 bytecode sub `$8003`** that the AI's war path jumps to. The whole combat-init body lives in `$8003`.)

Phase 2 iterates the tactical grid: a six-call pattern `$82DB → $DC88 → $DC66 → $83C6 → $DC88 → $DC66` per cell, ~25 cells visible in the visible iterations. The per-fief map data — where the doughnut-fief, the chokepoint fiefs, and every terrain type come from — is what `$82DB` reads. Chapter 15's static walk of `$82DB` locates that data; for now we know the shape: a cell-by-cell setup pass.

Phase 3 dominates the trace. `$828B` fires **1 005 times** in the visible battle, supported by `$829A` (212), `$82A9` (95), `$82B9` (86) — its sub-handlers. The inner loop runs *continuously* with no input gaps; combat doesn't pause between unit actions. Two clean exchanges Chris observed (day 4 attacker 8 → 6, defender 5–6 → 0–2; day 5 attacker 5 → 3, defender 6 → 2) are folded inside this continuous activity — the trace alone can't separate them. Their *damage formula* is `$828B`'s body, a chapter-16 read.

The damage *primitive* is already visible though. `$827E → $838F → $D70D` is a recurring triple — and `$D70D` is the **percentage operator** decoded all the way back in chapter 9. So:

> **The combat damage primitive is the same percentage-operator-plus-RNG-roll that drives the harvest, the develop commands, and the revolt's economic ripple.** One arithmetic primitive, four jobs. Combat is more numerous applications of it; not a different math.

## The tactical command menu — 5 verbs

Bank 2 `$B501–$B518` holds five packed null-terminated strings:

| Verb | Address |
|---|---|
| `Attack` | `$B501` |
| `Bribe` | `$B508` |
| `Flee` | `$B50E` |
| `Pass` | `$B513` |
| `View` | `$B518` |

Five tactical verbs against the strategic layer's twenty-one. Two are interesting:

- **`Bribe`** in combat means the diplomacy subsystem (chapter 11's `$E510/$879F/$804C` cluster) reaches into the battle screen — you can spend gold mid-fight to flip an enemy unit. That's a strategic-layer mechanic surfaced as a tactical option.
- **`Flee`** is a separate verb from being *forced* out by attrition. The four ending strings (next section) cover the forced cases; `Flee` is voluntary withdrawal at the player's choice.

## The unit-type model — 3 types in 5 slots

Bank 15 `$F9AF` is a 3-entry pointer table into a packed string region:

| Type | String addr | String |
|---|---|---|
| 0 | `$F9B5` | `Rifles ` (note trailing space — 7-char fixed slot) |
| 1 | `$F9BD` | `Infntry` (abbreviated for the 7-char slot) |
| 2 | `$F9C5` | `Cavalry` |

So a fielded army is **5 unit slots × 1 of 3 types each + 1 commander**. Chris's read fits exactly: slot 1 is the commander (losing him ends the battle — see failure modes below), and slots 2–5 are a composition of Rifles / Infantry / Cavalry. The strategic-layer `Hire` command (chapter 11) chooses *type*; the army's *composition* (how many of each) is what produces the offensive-bonus / defensive-bonus asymmetry Chris flagged early in the project (offense: thin-leader + max Rifles/Cavalry; defense: invert).

## The four failure modes

Combat ends in one of four ways, each with its own message:

| Message | Address | Mechanic |
|---|---|---|
| `"this is truly unfortunate..."` | bank 2 `$B7B1` | **commander killed** → that side loses the battle |
| `"your men are exhausted!"` | bank 2 `$B7F3` | **morale/exhaustion zero** → forced rout |
| `"you have no rice!"` | bank 2 `$B8A9` | **supply attrition** → attacker forced out (the **doughnut-fief mechanic** in code) |
| `"you have no soldiers!"` | bank 2 `$B8BB` | **all units destroyed** → annihilation |

The supply-attrition string is the find. Chris flagged the doughnut-fief — "you can just run in circles until the attacker runs out of rice" — as a real defensive pattern very early in the project. That's exactly this string: when the attacker's rice supply hits zero, the game prints *"you have no rice!"* and the attacker leaves. It is not a soft penalty; it's a discrete ending. Defenders who can run out the clock force this outcome and lose nothing.

A fifth outcome — voluntary withdrawal — uses `"%s has retreated"` (bank 2 `$B96E`). And the per-day display uses `"Day %2d"` (bank 2 `$B56B`).

## What this gives us

After this chapter the combat picture is structurally complete *as a map*:

```
        AI war path (chapter 12 pipeline)
                  │
                  ▼
       [combat entry] $8003 / label $81FC  (bank 0)
                  │
                  ▼
       [map setup loop]  $82DB / $DC66 / $DC88 / $83C6
                  │       (per cell, reads per-fief map data — chapter 15)
                  ▼
       [day / round loop]   ──┐
            │                 │
            ▼                 │
       [inner loop]  $828B / $829A / $82A9 / $82B9
            │     uses  $827E / $838F / $D70D + $CA52/$CA46
            ▼
       [unit action] -> casualty math (chapter 16)
            │
            ▼
       [end-of-battle check]
            │
            ▼
       one of: commander dead / men exhausted / no rice / no soldiers / retreat / victory
                  │
                  ▼
       [resolution]  message + spoils + return to strategy (chapter 17)
```

## What's open

This chapter is deliberately a *map*, not a *walk*. The deep reads it enables:

- **Chapter 15 — the tactical map.** `$82DB` walked to find where per-fief map cell data lives in the ROM. That gives us terrain per cell, the doughnut/chokepoint topology baked in code, and the data structure the inner loop reads. Likely bank 12 candidates need re-examination (graphics tiles plausibly share a bank with map cell types).
- **Chapter 16 — the battle engine.** `$828B` walked, `$827E / $838F` decoded. The damage formula `(attacker_strength, defender_strength, terrain, unit_type, RNG) → (att_loss, def_loss)` validated against Chris's day-4 and day-5 exchange numbers (attacker lost 2, dealt 4 — a 1:2 ratio across both exchanges despite a strength reversal — suggesting a structural attacker-initiative bonus).
- **Chapter 17 — resolution.** What happens on each of the five outcomes: commander-death does *what* to the survivors? Province ownership change after annihilation. The cost the loser pays. The `$D70D`-percentage ripple seen in revolts — does the same shape fire after a combat?
- **Appendix items** — exact per-unit-type modifiers (Rifles vs Infantry vs Cavalry), terrain modifier table, supply-tick rate (how fast rice depletes), and the commander-death formula (does Charisma or another stat modify survivability?).

## Method note — the trace as map

The trace did *not* give the combat formula — that lives below the call-graph layer it exposes. What it gave was the right surface: every sub the battle uses, in roughly the right counts, with the dominant inner-loop entry pinned. Combined with the string sweep — which produced the menu, the unit-type table, the failure-mode messages, and the day counter — we have a complete *frame* for the next three chapters' work. The string sweep is itself worth recording as a method: when a runtime trace gives counts but not contents, the strings the same code displays *are the contents*. The game narrates itself if you ask the ROM rather than the trace.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [bytecode-vm](../../../tags/bytecode-vm.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)
