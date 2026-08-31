---
status: active
created: 2026-08-03
published: true
layout: layouts/page.njk
title: "Battlezone (1980) — 3D Without a Multiply Instruction"
permalink: /research/gaming/battlezone-mathbox/
---
# Battlezone (1980) — 3D Without a Multiply Instruction
> The 6502 has no MUL and no DIV. Battlezone renders a perspective-projected 3D battlefield at 15.6 Hz anyway — because Atari bolted on a 16-bit bit-slice coprocessor and moved *every* real multiply and divide off the CPU. Grounded in Andy McFadden's complete commented disassembly.

**Links:** [Arithmetic Scarcity and the 3D Problem](./arithmetic-scarcity-3d.md) *(hub)*, [Stellar 7 (1983) — The Same Game Without the Coprocessor](./stellar7-software-3d.md) *(the control: same genre, same CPU, no math box)*, [Gaming](./README.md), [Breaking Down an SNES Cart](./snes-cartridge-teardown.md), [NA1 — A Game-Design Crucible](./nobunaga-crucible.md), [Computation and Information Theory](../computation-and-information.md), [Atari 2600 / TIA Reference](../atari-2600/tia-reference.md)

**Primary source:** Andy McFadden's [Battlezone disassembly](https://6502disassembly.com/va-battlezone/) — full commented listing + a dedicated [math box page](https://6502disassembly.com/va-battlezone/mathbox.html). Captured to `raw/articles/battlezone/`. Atari's [original sources](https://github.com/historicalsource/battlezone) were released in October 2021.

---

## The framing

**Battlezone's constraint is total, and that's the narrow case.** The 6502 has no multiply and no divide at all — not slow ones, none. (Same for the 8080/8085 and Z80; the 6809 has an 8×8→16 `MUL` but still no divide.) That's why this game is the cleanest specimen of the broader pattern: there is no "just eat the cost" option available to it.

The broader pattern — **fast arithmetic was priced, not assumed** — is the hub page: [Arithmetic Scarcity and the 3D Problem](./arithmetic-scarcity-3d.md). Short version: the 8086 *did* ship `MUL`/`DIV`, but microcoded at 118-133 clocks for a 16-bit multiply, ~24-30× an `ADD` — Intel spent the opcode, not the silicon. Floating point stayed a separate purchase (the 8087) into the mid-80s, and minicomputers sold multiply as an option box before that (PDP-8 EAE; PDP-11 EIS unavailable on the 11/20 and 11/05, optional on the 11/40, standard only later). Battlezone sits at the extreme end of that same economics.

**Star Wars (1983) had a math box, but not this one.** McFadden's page is explicit that the 2901-based math box was built for **Battlezone, Red Baron, and Tempest**. The 1983 *Star Wars* board used a later, more capable math box built from discrete TTL — a PROM-sequenced matrix processor with a 74LS384 serial multiplier and a 15-step restoring divider — not four cascaded 2901s. Both games are "arcade 3D via a math coprocessor," which was the real insight; the specific silicon differs.

**The vector-display objection is half right, and the half that's wrong is the interesting half.** A vector display *does* hand you rasterization for free — no framebuffer, no line-drawing loop, no fill. Battlezone doesn't even clip: the hardware has a window circuit that blanks vectors straying outside the bounds. But rasterization was never where the multiplies were. **Every multiply in a 3D pipeline lives in the vertex transform**, upstream of rasterization, and a vector display doesn't help there at all. Battlezone still has to rotate, translate, and perspective-divide every vertex of every visible object, every frame. That's the work the math box exists to do.

Which makes the comparison to *Elite* (1984, 6502, no coprocessor) the sharp one — same transforms, one twentieth the silicon, and it also has to rasterize. Battlezone is the **buy-the-math** answer; Elite is the **compute-it-anyway** answer; Doom constrains the geometry until the math collapses; Ultima's dungeons dodge it entirely. All four strategies, and the economics under them, are laid out in [Arithmetic Scarcity and the 3D Problem](./arithmetic-scarcity-3d.md) — this page is that hub's specimen #1.

---

## The hardware

| Component | Role |
|---|---|
| **6502 @ 1.5 MHz** | Game logic, AI, sound sequencing, self-test. Never multiplies. |
| **"Math box"** — 4× AMD **2901** 4-bit ALU slices @ 3 MHz + its own ROM | 16-bit multiply, add, divide, and composite 3D operations. |
| **AVG** (Analog Vector Generator) + Vector State Machine | Fetches a *bytecode* display list from `$2000-$3fff` and drives the CRT beam directly. |
| **POKEY** | Controller input, 4-voice sound, RNG. |
| Discrete analog | Engine rumble, cannon, explosion. |

Memory map is tight — 1 KB of RAM total (`$0000-$03ff`, including zero page *and* stack), 12 KB of program ROM at `$5000-$7fff`, and 8 KB of vector-generator space at `$2000-$3fff` (first half RAM, second half ROM). About half the AVG ROM isn't vector data at all — it holds the shape vertex tables and math tables.

### The 2901, briefly

The AMD 2901 is a **4-bit bit-slice**: an ALU, a 16-word dual-port register file, a Q register, and shift/carry hooks designed so you can cascade slices into any width you want. Four of them = a 16-bit datapath. The 2901 is not a CPU — it has no instruction fetch. A separate microcode ROM and sequencer drive it, which is exactly what the math box board provides. That's why the "math box" isn't a general-purpose FPU: its microcode implements the *specific* composite operations a 3D game needs, and nothing else.

---

## The interface: an 8-bit port that computes

The math box is memory-mapped as **32 write addresses** (`$1860-$187f`) and three read addresses:

```
$1800  MB_STATUS      (read)  bit 7 = busy
$1810  MB_RESULT_LO   (read)
$1818  MB_RESULT_HI   (read)
$1860.. command/data registers (write)
```

**The address you write to *is* the opcode; the byte you write is the operand.** Writing to `$1868` (`MB_SET_R4L`) stores a byte into the low half of internal register R4. Writing to `$1871` (`MB_SCREEN_X`) stores a byte into R5's high half *and then kicks off a full model-transform-plus-perspective-divide*. There is no separate "go" register — the last byte of the operand set is the trigger. This is the whole reason the register-load order in the 6502 code looks arbitrary: it isn't, the final store has to land on the function address.

Sixteen internal 16-bit registers, R0-RF; the first twelve are host-settable, the last four are scratch.

Waiting for a result is four instructions:

```asm
5b80: 2c 00 18   MbWaitForResult  bit MB_STATUS      ;check status
5b83: 30 fb                       bmi MbWaitForResult ;branch if busy
5b85: ad 10 18                    lda MB_RESULT_LO   ;low byte in A
5b88: 60                          rts
```

Sixteen cycles when the result is already there. The game does *not* always poll — in some paths it just burns a known number of cycles, which is safe only because starting a new operation aborts the one in flight.

### The function table

32 entries. Most are plain register loads. Six do real work:

| Addr | Name | What it computes |
|---|---|---|
| `$186b` | `MB_ROT_Z` | `R4-=R2; R5-=R3;` → `(R0*R4) - (R1*R5)` |
| `$1871` | `MB_SCREEN_X` | `R7 = (R0*R4)-(R1*R5)+R2;` `R8 = (R1*R4)+(R0*R5)+R3;` → `R8/R7` |
| `$1872` | `MB_ROT_X` | `(R1*R4) + (R0*R5)` — the companion half of `$186b` |
| `$1874` | `MB_DIVIDE_B7` | `RB / R7` |
| `$187d` | `MB_CALC_DIST` | `R2=abs(R2-R0); R3=abs(R3-R1);` falls into ↓ |
| `$187e` | `MB_CALC_HYPOT` | `≈ sqrt(R2² + R3²)` |

Read `MB_SCREEN_X` again and notice what it is: **two 2-term dot products, two adds, and a 16-bit divide, from a single 6502 store.** That's a rotation, a translation, and a perspective divide as one instruction. The API is deliberately shaped so the 6502 sets up the object *once* and then streams vertices — the math box keeps the object's position in R2/R3 and adds it itself.

Per McFadden, `$1c` (midpoint-subdivision clipping) was added for *Malibu Grand Prix* by Ed Logg, and `$1d/$1e` (distance) for *Battlezone* by Ed Rotberg. The board accreted features per-game.

---

## What the 6502 keeps for itself

This is the part I find most instructive: **grep the entire 12 KB of game code and there is no software multiply routine and no software divide routine.** Not a shift-add loop, not a table-based one. Every arithmetic operation the 6502 performs itself is one of:

- a power-of-two shift (`ASL`/`LSR`/`ROL`/`ROR`),
- a shift-and-add composite for a nice rational constant,
- or a **table lookup**.

Example — computing forward-motion deltas at `$6310`. It needs `0.75 × sin(θ)`, which becomes `(x>>1) + (x>>2)`:

```asm
6314: 20 4e 5e   jsr CalcSine       ;sin(theta), signed 1.15
6317: 8a         txa                ;high byte only  ->  effectively /256
6318: c9 80      cmp #$80           ;arithmetic shift right (see below)
631a: 6a         ror A
631b: 85 1d      sta ]move_x        ;  x >> 1
631d: c9 80      cmp #$80
631f: 6a         ror A              ;  x >> 2
6320: 18         clc
6321: 65 1d      adc ]move_x        ;  (x>>1) + (x>>2) = 3/4 x
```

The `CMP #$80 / ROR A` pair is the standard 6502 idiom for an **arithmetic** shift right: the 6502 has `LSR` (shifts in a 0) but no `ASR`, so you set carry from the sign bit via the compare and rotate it in. McFadden flags that this doesn't round negatives correctly (should `INC` before shifting), so heading can be off by one — a real, shipped consequence of the missing instruction.

### Sine: a 65-entry quarter-wave table

Angles are a **binary-fraction byte**: `$00-$ff` maps to 0-359°, so angle arithmetic wraps for free and `cos(θ) = sin(θ + $40)` is a single `ADC #$40`. The table stores only the first quadrant, 65 signed 16-bit entries of `32768·sin(α)`, and the code folds the other three quadrants in:

```asm
5e4b: 18 69 40   CalcCosine    clc / adc #$40    ;cos = sin shifted 90°
5e4e: 10 13      CalcSine      bpl CalcSineHalf  ;0-179°, use table directly
5e50: 29 7f                    and #$7f          ;180-359°: fold and negate result
...
5e63: c9 41      CalcSineHalf  cmp #$41          ;0-90°?
5e67: 49 7f                    eor #$7f          ;91-179°: reflect about 90°
5e6b: 0a aa                    asl A / tax       ;16-bit entries
5e6d: bd 77 5e                 lda sine_tab,x
```

130 bytes of table plus ~30 bytes of folding logic replaces a transcendental function. Values are **signed 1.15 fixed point** — one sign bit, fifteen fraction bits.

### Arctangent: octant folding + a 256-byte table

Enemy AI needs "what heading do I turn to, to shoot the player?" That's `atan2`. Battlezone's version is `CalcAngleToPlayer` at `$6810`:

1. Compute `|Δx|` and `|Δz|`, remembering both signs.
2. Compare them and **divide the smaller by the larger** — on the math box, `MB_DIVIDE_B7` — so the quotient is always in `[0,1)`. This is the whole trick: it confines the problem to the first 45°.
3. The quotient is a `0.8` fraction; use it directly as an **index** into `arctan_table` (`$3785`), which returns an angle `$00-$20` (0-45°).
4. Fix up the octant from which side was larger, then the quadrant from the two sign bits — via a **jump table pushed onto the stack and reached with `RTS`**:

```asm
68b4: b9 bf 68   lda sign_fix_tab+1,y   ;push handler address hi
68b7: 48         pha
68b8: b9 be 68   lda sign_fix_tab,y     ;      ... lo
68bb: 48         pha
68bc: 8a         txa
68bd: 60         rts                    ;"return" into the sign-fix routine
```

Full `atan2` for the cost of one hardware divide, one table index, and a negate.

### Distance: an approximation of an approximation

Collision detection needs `sqrt(dx² + dz²)`. The math box's `$1e` doesn't compute a square root — it evaluates the octagonal-boundary distance approximation. The published form is `0.41·min + 0.941246·max`; **the math box uses `0.375·min + 1.0·max`**, because 0.375 = 3/8 is two shifts and an add. An approximation chosen so that the approximation is cheap.

---

## The pipeline, reordered

Textbook order is Model → View → Project. Battlezone runs **View first**, deliberately, so it can cull before paying for vertices.

### Stage 1 — View transform + cull (`VLGenerate`, `$5946`)

Once per frame, load the *player* into the math box: `R0 = cos(θ)`, `R1 = -sin(θ)`, `R2 = viewer Z`, `R3 = viewer X`. Then for each candidate object (enemy, its treads and radar dish, projectiles, explosion chunks, saucer, 21 fixed obstacles, attract-mode logo), write its world X/Z into R4/R5 — the final store hitting `MB_ROT_Z`, which subtracts the viewer position *and* rotates in one go.

The cull, at `VLAddIfVis` (`$5b1f`), is pure 6502 and pure sign-testing:

```asm
5b25: ad 18 18   lda MB_RESULT_HI
5b28: 8d 72 18   sta MB_ROT_X       ;start the *next* op before testing this one
5b2b: 30 52      bmi :Return        ;Z negative -> behind viewer
5b2d: 2a         rol A
5b2e: 30 4f      bmi :Return        ;overflow -> too far
5b32: 4a 4a      lsr A / lsr A
5b34: f0 49      beq :Return        ;inside near plane ($03ff)
5b38: c9 7b      cmp #$7b           ;far plane $7aff
5b3a: b0 43      bcs :Return
...
5b5f: a5 1d      lda ]abs_pos_x     ;left/right: cull if |X| > Z
5b61: c5 1b      cmp ]view_pos_z
```

Note line `5b28`: it **fires the second half of the rotation (`MB_ROT_X`) before testing the first half's result**. That's the overlap McFadden points at — the one place the game genuinely runs the 6502 and the math box concurrently.

The frustum test is `|X| > Z` — a 90° FOV, one compare, no trig. The actual FOV is 45°, so it's loose by design: the test uses object *centers*, and a tight test would pop objects out while they were still half on screen. (Side effect: saucers are audible off-screen, because "audible" is gated on this same 90° test.)

Survivors land in a list at `$0200` as four values — type, facing, view-space X, view-space Z.

### Stage 2 — Model transform + projection (`TxfrmObject`, `$5d4a`)

Per object: `θ = player_facing - object_facing + 180°`, then `R0 = -cos θ`, `R1 = sin θ`, `R2/R3 = object Z/X`. Then the vertex loop streams the mesh:

```asm
5dad: a4 18      :VertexLoop ldy ]mesh_offset
5daf: b1 3b                  lda (]obj_ptr),y   ;vertex Z lo
5db1: 8d 68 18               sta MB_SET_R4L
       ... R4H, R5L ...
5dc1: b1 3b                  lda (]obj_ptr),y   ;vertex X hi
5dc3: 8d 71 18               sta MB_SCREEN_X    ;<-- fires the whole transform
5dc7: 20 80 5b               jsr MbWaitForResult
5dca: 18 49 ff 69 01         clc / eor #$ff / adc #$01   ;negate -> mirror screen
5dcf: 95 3d                  sta screen_coords,x
```

**Four stores and the vertex is transformed and projected.** Screen Y is a second call (`MB_DIVIDE_B7`) because Y isn't part of the Y-axis rotation — the 6502 adds the object's altitude itself, since that's just an add.

### Stage 3 — Draw-command generation

Shapes are drawing *programs*, not edge lists: one byte per step, 3-bit opcode + 5-bit vertex index (hence the 32-vertex cap; the transform code lowers it to 26). Opcodes: draw point, set intensity, move dark, center-then-move, draw to vertex, emit scaled AVG commands (used only by the projectile explosion), no-op. Ordering commands rather than listing edges minimizes wasted beam travel — the vector-display equivalent of overdraw.

Output is AVG bytecode into one of two 2 KB buffers (`$2000`/`$2800`), each starting with a jump instruction the NMI handler rewrites to flip buffers. Distant objects get lower intensity — which both sells the depth cue *and* draws faster, since beam speed is intensity.

---

## What it bought them, numerically

Counting cycles in the vertex inner loop (`$5dad-$5e02`, assuming the math box result is ready when polled): **≈ 176 cycles of 6502 time, plus ~45 in `CalcScreenY`, so roughly 220 cycles per vertex** for two fully perspective-projected screen coordinates.

What's inside those 230 cycles, arithmetically: four 16×16 multiplies, four adds, and two 16-bit divides.

A conventional 6502 shift-add 16×16→32 multiply runs on the order of 700-800 cycles; a 16-bit restoring divide is comparable or worse. So the same vertex done in software is **somewhere around 5,000-8,000 cycles** — call it a 25-35× speedup at the routine level. *(The 220 is counted from the listing; the software figure is a standard-implementation estimate, not measured.)*

Put it against the budget. The main loop is gated to one iteration per 16 NMIs = **15.625 Hz**, so ~96,000 cycles per game frame at 1.5 MHz. At 220 cycles/vertex that's ~430 vertices if the CPU did nothing else — and it has to run tank AI, missile steering, collision, sound, and the draw-command generator in the same budget. At ~6,000 cycles/vertex it's **sixteen vertices per frame.** A single slow tank has more than that.

That's the whole argument for the math box in one number: without it there is no game.

---

## Design lessons that survive the era

- **Reordering the pipeline to cull first is the highest-leverage optimization in the whole engine.** Everything else is constant-factor. Doing the cheap view transform on object *centers* to decide who deserves the expensive per-vertex work is the same instinct as modern frustum/occlusion culling, and it's why the loose 90° test is *correct* despite being wrong — the cull only has to be conservative.
- **The coprocessor API is co-designed with the call site.** `MB_SCREEN_X` isn't "multiply"; it's "the exact composite this game's inner loop needs." Object position stays resident so the bus carries only vertices. The bottleneck being addressed is as much the 8-bit *interface* as the arithmetic.
- **Errors are budgeted, not eliminated.** The 1.15 fractions are shifted 16× instead of 15×, halving every rotated coordinate — so the *art* has X/Z pre-doubled to compensate. The divider iterates 10 times instead of 16, scaling screen coordinates by 1/64 — which is free, because it's a fixed scale. The distance function approximates an approximation. Every one of these is a deliberate trade of accuracy for shifts, absorbed downstream in data rather than fixed in code.
- **Table lookup is the universal substitute.** Sine, arctangent, obstacle placement, per-type altitudes, chunk meshes, the sign-fix dispatch — when you can't compute, you index. The 6502's `lda table,x` is 4 cycles, and that's the machine's real math instruction.

---

## Open threads

- **The A/B is now run.** [Stellar 7 (1983)](./stellar7-software-3d.md) is the same genre on a 1.023 MHz Apple II with no math box and a near-identical frame budget — it costs ~2,000 cycles/vertex against this game's ~220. It closed most of the gap not by writing a faster multiply but by **storing vertices in polar coordinates**, making the model rotation a single `ADC`. Elite remains the outstanding third point.
- **The multi-million-point bug.** Documented by players (4,537,000 from a near-simultaneous saucer + missile kill), and McFadden explicitly says he hasn't found it in the scoring code. Live target with a full listing available.
- **The two empty object-table slots** (`$22`, `$23`) — cut content, or alignment?
- **The math box ROM itself is not disassembled here.** McFadden's listing covers the 6502 side and the AVG bytecode; the 2901 microcode is documented from Atari's released internal sources but not walked. That's the lower artifact if a claim about function semantics ever needs settling.

---

## Sources

- Andy McFadden, [Battlezone (1980) Disassembly](https://6502disassembly.com/va-battlezone/) — overview, memory map, gameplay mechanics, bug list
- Andy McFadden, [Atari Math Box](https://6502disassembly.com/va-battlezone/mathbox.html) — function table, fixed-point primer, transform derivations
- Andy McFadden, [Battlezone Objects](https://6502disassembly.com/va-battlezone/objects.html) — shape table, vertex/command format
- [Atari's released Battlezone sources](https://github.com/historicalsource/battlezone) (October 2021)
- Jed Margolin, [The Secret Life of Vector Generators](https://www.jmargolin.com/vgens/vgens.htm)
- [Arcade-StarWars_MiSTer](https://github.com/Videodr0me/Arcade-StarWars_MiSTer) — documents the 1983 Star Wars math box as custom TTL (74LS384 serial multiplier + 15-step restoring divider), i.e. not 2901-based
- [MAME bzone driver](https://github.com/mamedev/mame/blob/master/src/mame/drivers/bzone.cpp) — math box behavior simulated rather than emulated
- Local captures: `raw/articles/battlezone/`

## Tags

[6502](../../tags/6502.md), [assembly](../../tags/assembly.md), [reverse-engineering](../../tags/reverse-engineering.md), [games](../../tags/games.md), [game-design](../../tags/game-design.md), [mathematics](../../tags/mathematics.md)
