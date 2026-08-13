---
status: active
created: 2026-08-03
published: true
layout: layouts/page.njk
title: "Stellar 7 (1983) — The Same Game Without the Coprocessor"
permalink: /research/gaming/stellar7-software-3d/
---
# Stellar 7 (1983) — The Same Game Without the Coprocessor
> Damon Slye built a Battlezone-alike on an Apple II with no math box. He didn't just write the multiply in software — he **stored vertices in polar coordinates so the model rotation became a single `ADC`**. The controlled experiment the taxonomy needed: same genre, same CPU family, opposite strategy.

**Links:** [Arithmetic Scarcity and the 3D Problem](./arithmetic-scarcity-3d.md) *(hub)*, [Battlezone (1980) — 3D Without a Multiply Instruction](./battlezone-mathbox.md) *(the coprocessor twin)*, [Gaming](./README.md)

**Primary source:** Andy McFadden's [Stellar 7 disassembly](https://6502disassembly.com/a2-stellar7/) — SourceGen project across all overlays, based on the 4am crack of the official release. Captured to `raw/articles/stellar7/`. Published 1983 by Penguin Software, copyright Dynamix. McFadden points at this game *from* the Battlezone math box page as the no-extra-hardware counterexample, which is exactly why it works as a control.

---

## Why this is the right control

Elite is the famous 6502 3D game, but it changes two variables at once — different genre, different renderer, different everything. Stellar 7 changes almost nothing except the one thing under study:

| | Battlezone (1980) | Stellar 7 (1983) |
|---|---|---|
| Genre | first-person wireframe tank combat | first-person wireframe tank combat |
| CPU | 6502 @ **1.5 MHz** | 6502 @ **1.023 MHz** (Apple II) |
| Math | **2901 coprocessor** | **software** |
| Display | vector CRT (free rasterization + free clipping) | raster, software line-drawing |
| Sound | POKEY + discrete analog (autonomous) | bit-banged speaker (**CPU must service it inline**) |
| Frame rate | 15.625 Hz game update | ~10 fps |
| Frame budget | ~96,000 cycles | ~102,300 cycles |

**The frame budgets are within 7% of each other.** Same problem, same era, near-identical cycle allowance, and every piece of helper hardware removed. Whatever Stellar 7 does differently is forced.

---

## The headline: rotation is an `ADC`

Battlezone stores mesh vertices as Cartesian X/Y/Z and pays four multiplies per vertex to rotate them. Stellar 7 stores them [as **(distance, angle, Y)**](https://6502disassembly.com/a2-stellar7/objects.html) — polar in the XZ plane, Cartesian only in Y. McFadden's note: *"This arrangement makes computation of rotation about the Y axis simpler."*

That's an understatement. Here is the entire model rotation, from `VertexXformLoop` at `$634b`:

```asm
63bc: b1 3a   lda (mesh_ptr),y   ;get vertex angle
63be: 85 30   sta ]prev1_angle
63c0: 18      clc
63c1: 65 33   adc ]obj_angle     ;<-- THE ROTATION. one add.
63c3: 20 00 0d jsr ROTATE_INT8   ;polar -> Cartesian
```

Rotating a polar coordinate about its own axis is **adding to the angle.** No trig, no multiply, no table. The multiplies don't vanish entirely — `RotateInt8` still has to convert (distance, angle) → (X, Z), which costs `dist·cos` and `dist·sin` — but that's **two multiplies where Battlezone's math box does four.** Slye moved the rotation out of the arithmetic domain and into the representation.

This is the finding that matters beyond this game: *the cheapest way to do an expensive operation is to choose a coordinate system in which it isn't required.*

### The second-order trick: shared vertical edges

Wireframe objects in this game are mostly boxes and hulls with vertical edges — pairs of vertices differing only in Y. The transform loop checks for exactly that:

```asm
6354: c5 31   :Cont  cmp ]prev0_dist   ;same distance as previous?
6356: d0 5e          bne :Match31
635c: b1 3a          lda (mesh_ptr),y  ;same angle as previous?
635e: c5 30          cmp ]prev1_angle
6360: d0 5c          bne :Match30
;   -> skip rotation, translation, AND the X projection entirely.
;      only Y changes, so only re-project Y.
```

The Obstacle (a cube) exploits this by construction: 8 vertices, but only **4 distinct (distance, angle) pairs** — all with distance `$6a` and angles `$20/$60/$a0/$e0`. A cube costs four rotations, not eight, and four divides instead of eight.

That's the same *data co-designed with code* pattern Battlezone uses when it pre-doubles X/Z in the art to cancel a shift — except here the payoff is a 2× throughput win on the most common shape in the game.

---

## What software arithmetic actually costs

The routines Battlezone does not contain, in full:

**`Divide16` (`$0810`) — 695 bytes.** Header comment: *"Computes `(val0 * 2^mult) / val1`. Used for perspective calculations. val0 is XC or YC, val1 is ZC, and the multiplier is 7 (128) for normal view, 9 (512) for zoom."*

Note what that signature is doing: **the fixed-point pre-shift is folded into the divide**, and the shift amount *is* the zoom control. Changing the field of view costs nothing — it's a different exponent. The routine pre-normalizes the dividend (left-shift until the high bit is set, decrementing the multiplier) to cut iteration count, then dispatches to one of four specialized paths in `DivideMain` (`$0900`) depending on whether the numerator and denominator fit in 8 bits. 695 bytes of code to replace one store to `$1874`.

**`Multiply16_8` (`$0c00`) — 181 bytes, signed 16×8.** It is **fully unrolled**: seven identical shift-add-rotate stages, no loop, no `DEX`/`BNE`. Classic space-for-speed:

```asm
0c37: 6a       ror A
0c38: 66 0d    ror ]result_lo
0c3a: 66 0c    ror ]tmp3
0c3c: 90 0a    bcc L0C48       ;bit clear -> skip the add
0c3e: a8       tay
0c3f: a5 0d    lda ]result_lo
0c41: 65 0a    adc ]tmp1
0c43: 85 0d    sta ]result_lo
0c45: 98       tya
0c46: 65 0b    adc ]tmp2
     ... ×7
```

**Estimated cost per vertex** (non-shared path): 2 multiplies inside `RotateInt8` (~400 cycles), 2 calls to `Divide16` (~800-1,600 depending on operand magnitude — the specialized paths make this highly variable), translations and stores (~150), plus four `jsr UpdateSound` calls (~100-200). Call it **~1,500-2,400 cycles/vertex, ≈2,000 nominal.**

*(Method: instruction-level counts for the multiply and the fixed overhead; the divide is estimated at ~50 cycles/iteration from the `DivideFinish` loop body × an iteration count that varies by path. Not traced — this is an estimate with a real error bar, unlike the Battlezone figure which was counted.)*

**Against Battlezone's counted ~220 cycles/vertex, that's roughly a 9× gap** — and the frame budgets are nearly identical. So the model predicts Stellar 7 pushes about one-ninth the vertices per frame. With the cube optimization that's on the order of a dozen simple objects, which is what the game actually shows.

---

## The costs the coprocessor wasn't hiding

Three more expenses appear that have nothing to do with multiply, and they're the ones a naive "just do it in software" estimate misses:

**1. Sound is in the render loop.** `jsr UpdateSound` appears **four times inside the vertex transform** (`$63b0`, `$63f9`, `$642a`, `$646b`). The Apple II speaker is bit-banged — there is no POKEY running autonomously, so audio timing must be serviced by hand at fine granularity, and the only code running finely enough is the renderer. Battlezone's sound is a write to a register.

**2. Clipping is now a visible bug.** Battlezone got clipping free — the AVG's window circuit blanks strays. Stellar 7 culls **per vertex** against the near plane and discards every edge connected to a culled vertex. McFadden documents the artifact directly: *"if you drive into a sandsled you'll see parts of the nearest skid disappear."* The correct fix is to project first and clip the *line* to the viewport, which nobody could afford.

**3. Rasterization is real work.** ROCK1 is titled "code and data tables for drawing lines and computing rotations" — a whole line-drawing engine that the vector display made unnecessary.

---

## What this does to the taxonomy

The hub's original strategy 2 was **"compute it anyway — spend CPU cycles, preserve geometric freedom."** Stellar 7 falsifies the second half of that. It does *not* preserve geometric freedom:

- Vertices are polar, so **objects can only rotate about Y** — same limit Battlezone has, but here it's baked into the data format rather than the math.
- The shared-edge optimization only pays for **vertical edges**, which biases every mesh toward boxy, extruded shapes.
- Per-vertex near-plane culling means **geometry visibly breaks** at close range.

So strategy 2 as practiced isn't "compute it anyway." It's **strategy 3 applied one level down** — constrain the *representation* instead of the *level geometry*, so the operation you can't afford stops being reachable. Doom constrains what the level editor can build; Stellar 7 constrains what a vertex can be. Same move, different layer.

That's a real refinement, and it's the kind that only falls out of reading the source: **"buy it / compute it / constrain it / precompute it" is not a flat list. Three of the four are the same idea — reduce what must be computed — applied at different layers of the stack, and only strategy 1 actually escapes.** Which is presumably why strategy 1 is the one that won.

---

## Open threads

- **Trace `Divide16` properly** and replace the estimate with a counted figure. The four-path dispatch means the cost distribution matters more than the mean — a near object (small Z) and a far one take different paths.
- **Does the polar trick have a cost at the art end?** Authoring meshes in (distance, angle) is painful for a human. Was there a tool, or are all the shapes hand-computed? The Obstacle's clean `$20/$60/$a0/$e0` angles suggest by-hand.
- **Elite is now a three-way comparison, not a two-way.** It's the same CPU with a different genre and — as far as I know — Cartesian meshes with a real rotation matrix. If so, Elite is the *true* strategy-2 point and Stellar 7 is a hybrid, which would make the taxonomy cleaner rather than messier.
- **Arcticfox** (Slye's sequel, Amiga → Apple II port) would show what the same author did with a 68000 available.

## Sources

- Andy McFadden, [Stellar 7 disassembly](https://6502disassembly.com/a2-stellar7/) — overview, unit/weapon tables, level dynamics
- Andy McFadden, [Stellar 7 Objects](https://6502disassembly.com/a2-stellar7/objects.html) — the polar mesh format and the shared-vertex optimization
- ROCK1 listing (`$0800-1FFF`) — `Divide16`, `Multiply16_8`, `RotateCoords`, `RotateInt8`
- ROCK2 listing (`$6000-ACFF`) — `VertexXformLoop` at `$634b`, the edge drawing loop
- Local captures: `raw/articles/stellar7/`

## Tags

[6502](../../tags/6502.md), [assembly](../../tags/assembly.md), [reverse-engineering](../../tags/reverse-engineering.md), [games](../../tags/games.md), [game-design](../../tags/game-design.md), [mathematics](../../tags/mathematics.md)
