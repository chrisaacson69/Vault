---
status: active
created: 2026-08-03
published: true
layout: layouts/page.njk
title: "Arithmetic Scarcity and the 3D Problem"
permalink: /research/gaming/arithmetic-scarcity-3d/
---
# Arithmetic Scarcity and the 3D Problem
> Fast arithmetic was **priced, not assumed** — an option box on minicomputers, a separate chip on early PCs, absent entirely on 8-bit CPUs. Real-time 3D is the workload that can't route around it, so games became the forcing function. Four distinct strategies emerged, the choice between them was economic rather than technical — and the cycle never ended: EAE → 8087 → GPU → NPU is one pattern running four times.

**Links:** [Battlezone (1980) — 3D Without a Multiply Instruction](./battlezone-mathbox.md) *(specimen #1, grounded)*, [Stellar 7 (1983) — The Same Game Without the Coprocessor](./stellar7-software-3d.md) *(specimen #2, grounded — the control)*, [Gaming](./README.md), [Breaking Down an SNES Cart](./snes-cartridge-teardown.md), [Computation and Information Theory](../computation-and-information.md), [The Dominance-Frontier Lens](../dominance-frontier-lens.md)

**Status:** hub page. Specimens #1 (Battlezone) and #2 (Stellar 7) are fully grounded in primary source, and together form a near-controlled A/B. Strategies 3 and 4 are **stubs** — the claims are sourced, but no disassembly has been walked. Marked inline so the difference stays visible.

---

## The economics, before the games

The instinct that "dedicated multiply/divide wasn't worth the silicon budget" is correct, and it holds *much* later than the 8-bit era. The evidence is that vendors kept selling arithmetic as a **separately-priced option** long after they could have integrated it.

> **The full sixty-year timeline lives on its own page: [Arithmetic as a Purchase](../arithmetic-as-a-purchase.md)** — IBM sold multiply on the 1401 for **$325/month**; the IBM 1620 ("CADET — Can't Add, Doesn't Even Try") had **no ALU at all** and did arithmetic by table lookup in core; the SNES shipped its multiplier as **memory-mapped registers using Battlezone's exact protocol**; and Nintendo later sold the coprocessor *inside the cartridge*, pricing arithmetic **per game**. The table below is the short version.

| Machine | Multiply/divide status |
|---|---|
| **IBM 1401** (1959) | Hardware multiply/divide is an **extra-cost option at [$325/month](https://www.columbia.edu/cu/computinghistory/1401.html)** (~246 SMS cards). |
| **IBM 1620** (1959) | **No ALU.** All arithmetic by [table lookup in core memory](https://www.cs.auckland.ac.nz/historydisplays/FirstFloor/IBM1620/IBM1620Main.php) — you loaded the addition tables into low memory before it could add. |
| **PDP-8** (1965) | The [Extended Arithmetic Element](https://homepage.cs.uiowa.edu/~jones/pdp8/faqs/) (EAE) is an **optional purchase**. No EAE = no MQ register, no multiply, no divide. |
| **PDP-11/20, /05, /04** | [EIS](https://gunkies.org/wiki/PDP-11_Extended_Instruction_Set) (multiply, divide, multi-bit shift) **not available at all**. |
| **PDP-11/40, /03** | EIS **optional** (the [KE11-E](https://gunkies.org/wiki/KE11-E_Extended_Instruction_Set) board). |
| **PDP-11, later models** | EIS **standard**. |
| **6502 / 8080 / 8085 / Z80** | **None.** Not slow — absent. (6809 has 8×8→16 `MUL`, still no divide.) |
| **8086 / 8088** (1978) | Integer `MUL`/`DIV` present, but **microcoded**: [118-133 clocks](http://www.righto.com/2023/03/8086-multiplication-microcode.html) for 16-bit multiply, 144-162 for divide — ~24-30× an `ADD`. |
| **8087** (1980) | Floating point as a **separate chip**. [~19 µs](https://en.wikipedia.org/wiki/Intel_8087) single-precision multiply vs ~1,600 µs emulated — **~84×**. |
| **80486DX** (1989) | FPU finally integrated. Twenty-four years after the PDP-8's option box. |

Two things fall out of this table:

**1. The 8086 is the interesting case, not the counterexample.** It has the instruction and doesn't have the hardware — the multiply is a microcode loop, not an array multiplier. Intel spent the *opcode* and declined the *transistors*. So "not worth the silicon budget" is exactly right; the ISA just hides it. Anyone writing an 8086 inner loop in 1981 was still avoiding `MUL` for the same reason a 6502 programmer avoided it: it costs 25 adds.

**2. The coprocessor is one architectural idea, reused.** The 8087 [decodes its own instructions in parallel with the CPU](https://www.pcjs.org/documents/manuals/intel/8087/), so the 8086 keeps executing while it works. That is *structurally the same move* as Atari's math box, five years earlier and one layer down: a parallel unit with its own sequencer, fed through a narrow port, that the host can overlap against. Battlezone even exploits the overlap explicitly — it fires the second half of a rotation before testing the first half's result.

**The through-line:** for roughly three decades, "can this machine multiply quickly?" was a purchasing decision. Real-time 3D is the first mass-market workload where the answer had to be yes and the budget said no. That collision is what produced the strategies below.

---

## The four strategies

Every real-time 3D system built under arithmetic scarcity picks one — or blends them. They are not "clever tricks"; they are four different resources to spend *instead of* CPU arithmetic.

| | Strategy | Spends | Constrains | Specimen |
|---|---|---|---|---|
| **1** | **Buy the math** | silicon / BOM cost | *nothing* | Battlezone |
| **2** | **Compute it anyway** | CPU cycles → vertex budget | the **representation** | Stellar 7, Elite |
| **3** | **Constrain the geometry** | design freedom | the **world** | Doom, Wolf3D |
| **4** | **Precompute at art time** | ROM / art-asset budget | the **content** | Ultima dungeons, Wing Commander |

Read left to right and it's a spectrum from *paying money* to *paying honesty*. Strategy 4 isn't doing 3D at all; it's doing a convincing lookup table of 3D. That's not a criticism — for a dungeon crawl it's the correct engineering answer, and it's the only one of the four that runs on literally anything.

**Refinement forced by the Stellar 7 specimen** (originally column 4 read "preserves full geometric freedom" for strategies 1 *and* 2): reading the source shows strategy 2 does **not** preserve geometric freedom. Stellar 7 buys its speed by storing vertices in polar coordinates — which means objects can only rotate about Y, meshes are biased toward vertical-edged boxes by the optimization that makes them cheap, and geometry visibly breaks at close range because per-vertex culling replaced clipping.

So **strategies 2, 3, and 4 are the same move applied at different layers** — reduce what must be computed, by constraining the representation (Stellar 7), the world (Doom), or the content (Ultima). Only **strategy 1 escapes the trade entirely**, which is presumably why it's the one that won: every GPU ever built is strategy 1.

---

### 1. Buy the math — Battlezone (1980) ✅ *grounded*

Four cascaded AMD 2901 bit-slices + microcode ROM = a 16-bit coprocessor, memory-mapped so that **the address you write to is the opcode**. One store to `$1871` performs rotate + translate + perspective-divide. The 6502 never multiplies at all: grep the whole 12 KB ROM and there is no software multiply or divide routine anywhere.

Cost: **≈220 cycles/vertex** (counted from the listing) against a ~96,000-cycle frame budget. Software would be ~5-8k/vertex — sixteen vertices per frame, less than one tank. Without the coprocessor there is no game.

**→ Full breakdown: [Battlezone (1980) — 3D Without a Multiply Instruction](./battlezone-mathbox.md)**

Also in this family: Tempest and Red Baron (same 2901 board); *Star Wars* (1983) with a later custom-TTL math box; the 8087 lineage on PCs; and eventually every GPU ever made. **The strategy never died — it won.**

---

### 2. Compute it anyway — Stellar 7 (1983) ✅ *grounded* / Elite (1984) 🔲 *stub*

**Stellar 7 is the controlled experiment** — a Battlezone-alike on an Apple II, same genre, same CPU family, 1.023 MHz instead of 1.5, and *every* piece of helper hardware removed. Frame budgets land within 7% of each other (~102,300 cycles vs ~96,000), so the comparison is close to clean.

It contains exactly what Battlezone lacks: a 695-byte `Divide16` and a fully-unrolled 181-byte `Multiply16_8`. Estimated **~2,000 cycles/vertex against Battlezone's counted ~220** — about 9×, with near-identical budgets.

But the headline isn't the software multiply. Slye stored mesh vertices in **polar coordinates** — (distance, angle, Y) — which makes the entire model rotation a single `ADC` on the angle. The multiplies that remain are just the polar→Cartesian conversion: **two, where the math box does four.** Plus a second-order trick: consecutive vertices sharing a (distance, angle) pair — i.e. vertical edges — skip rotation, translation, *and* the X projection. A cube costs four transforms, not eight.

**→ Full breakdown: [Stellar 7 (1983) — The Same Game Without the Coprocessor](./stellar7-software-3d.md)**

**Elite (1984) — the prediction held.** It does *not* go polar. Ship blueprints store [Cartesian x/y/z](https://elite.bbcelite.com/deep_dives/ship_blueprints.html) (sign-magnitude: absolute values plus sign bits, packed into six bytes with face associations), and the transform is a genuine [3×3 rotation matrix](https://elite.bbcelite.com/deep_dives/calculating_vertex_coordinates.html) built from three orthonormal orientation vectors — `sidev`, `roofv`, `nosev` — transposed to invert it, in `LL9` parts 6-7. Elite pays the full matrix cost per vertex and keeps arbitrary 3-axis orientation, which Stellar 7 and Battlezone both give up.

So **Elite is the pure strategy-2 point and Stellar 7 is the 2/3 hybrid**, exactly as predicted. But Elite doesn't just eat the cost — it attacks the multiply from a *third* direction (below). *(Deep dives read; full source not yet walked line-by-line.)*

---

---

## The sharpest result: three ways to make a multiply cheap

The three grounded 6502-family specimens turn out to attack the *same* problem along three orthogonal axes. This is the finding the hub exists for:

| Specimen | Axis attacked | Mechanism | Price paid |
|---|---|---|---|
| **Battlezone** | unit **cost → ~0** | buy a 2901 coprocessor | BOM cost |
| **Stellar 7** | operation **count ↓** | polar vertex storage — rotation becomes one `ADC` | Y-axis-only rotation, boxy meshes, broken near-clipping |
| **Elite** | unit **cost ↓** | [logarithm tables](https://elite.bbcelite.com/deep_dives/multiplication_and_division_using_logarithms.html) — `a*q = 2^(log a + log q)`, so multiply becomes add-and-index | table RAM |

### The head-to-head: RAM-for-cycles vs. less-work

Elite ships **both** multiply routines in different builds, which makes it its own control. Counted from the source, same author, same CPU:

| Routine | Build | Cost | Operation |
|---|---|---|---|
| [`MULT1`](https://elite.bbcelite.com/cassette/main/subroutine/mult1.html) — shift-and-add | cassette / disc | ~164 cyc + 6 `JSR` = **~170** | signed 8×8 → 16-bit |
| [`FMLTU`](https://elite.bbcelite.com/6502sp/main/subroutine/fmltu.html) — log tables | 6502 Second Processor | ~55 cyc + 6 `JSR` = **~61** | unsigned 8×8 → high byte |

**≈2.8× faster, for 1 KB of RAM** — four page-aligned 256-byte tables (`log`, `logL`, `antilog`, `antilogODD`). The whole multiply is: index `logL` twice, add, index `log` twice, add, index `antilog`. No loop, no shifting.

*(Caveat: not a pure apples-to-apples — `FMLTU` is unsigned and returns only the high byte. But it's the routine `LL9` actually calls in the vertex transform, so it is the honest per-vertex number.)*

Now set that against Stellar 7's move, normalized per vertex:

| | Mechanism | Saves | Costs |
|---|---|---|---|
| **Stellar 7** | polar storage → rotation is one `ADC` | **halves the multiply *count*** (2 instead of 4 for a 2D rotation) — ~380 cyc/vertex | **0 bytes.** The polar mesh is *smaller* — 3 bytes/vertex vs Elite's 6 |
| **Elite** | log tables → multiply is an add + index | **cuts unit *cost* ~2.8×** — ~109 cyc × 9 multiplies (3×3 matrix) ≈ ~980 cyc/vertex | **1 KB of RAM** |

The answer to "which is the better buy" is that **they're not competing — they're orthogonal factors of the same product.** Per-vertex cost is `N × C`: Stellar 7 attacks `N`, Elite attacks `C`, Battlezone drives `C` to ~0 with silicon. You could stack all three. Nobody in this sample did — Stellar 7 ran on a 48K Apple II and could have afforded log tables on top of its polar meshes.

Two asymmetries worth noting:

1. **Stellar 7's saving is free and Elite's isn't** — which makes the representation trick strictly the better *first* move. But it's capped: you can only halve the count once, whereas cheaper multiplies scale with however many you have.
2. **Elite needs more multiplies precisely because it kept what Stellar 7 gave up.** A full 3×3 matrix is the price of arbitrary 3-axis orientation. Elite spends 1 KB buying back speed it spent on capability — which is exactly the trade Stellar 7 declined.

And the tell for the whole thesis: **log tables only appear in the advanced builds.** The base BBC Micro didn't have the RAM, so cassette and disc fall back to [shift-and-add](https://elite.bbcelite.com/deep_dives/shift_and_add_multiplication.html). Same game, same author, same CPU — *the algorithm changes when the memory budget changes.* Arithmetic speed was a purchase here too; the currency was RAM instead of silicon.

**The NES port makes Elite a three-substrate specimen.** Verified in the ROM ([`elite-decompiler`](../../projects/game-annotation/elite/README.md)): all four tables survive at `$C100/$C200/$C300/$C400` — page-aligned in **bank 7, the fixed bank**, permanently mapped — with `FMLTU` at `$F770` and 26 indexed reads of those pages in that bank's listing. The apparent problem (a cartridge has ROM but barely any RAM) dissolves twice: on a 6502 `lda log,x` costs 4 cycles from ROM exactly as from RAM, and the only real risk — a bank switch per lookup — is removed by siting the tables in the always-mapped bank. The budget even inverts: 1 KB is **0.8% of the NES's 128 KiB ROM** against roughly **2% of the BBC's entire 48 KiB of RAM**. So one algorithm crosses shift-add → RAM tables → fixed-bank ROM tables intact, and the constraint that dictated the choice on the BBC simply stopped applying.

**Only Battlezone's answer costs nothing in capability.** Stellar 7 pays in geometric freedom, Elite pays in memory. Buying the hardware is the one move that's free at the design level — which is the entire reason the coprocessor keeps coming back.

---

## The deeper unification: it's all memoization, cut at different depths

Lookup tables trade RAM for cycles. So do pre-rendered sprite banks. **These are the same technique** — memoize a pure function over a discretized domain, then index instead of compute. What varies is only *how far down the pipeline you cut*:

| Cut depth | What's cached | Domain size | Quantization error |
|---|---|---|---|
| one arithmetic op | Elite's `log`/`antilog`; sine, cosine, arctan tables | 256 entries | sub-LSB — **invisible** |
| a coordinate conversion | Stellar 7's `rotate_tab` (polar→Cartesian) | 256 angles | **invisible** |
| visibility ordering | Doom's BSP tree (built by the node compiler) | per level | **none** — it's exact |
| a whole rendered frame | Wing Commander's [38 views per ship](https://www.wcnews.com/news/update/17309); Ultima's dungeon blocks | 38 angles | **visible** — sprite popping |

**The law: the deeper you cut, the more you save and the more visible the error becomes.** Sprite popping isn't a Wing Commander flaw; it's the characteristic artifact of memoizing so far down the pipeline that the discretization becomes perceptible. Cache a multiply and nobody can tell. Cache a whole frame at 38 angles and everybody can.

That collapses most of the taxonomy: strategies 2, 3, and 4 aren't really different *kinds* of answer. They're **one answer — precompute and index — applied at four depths.** Only strategy 1 is categorically different, because it's the only one that makes the computation genuinely cheap rather than avoiding it.

### Wing Commander traverses the whole taxonomy by itself

The series is a complete cycle in miniature:

- **WC1/WC2** (1990/91) — 38 pre-rendered views per ship, scaled at runtime. **Strategy 4.**
- **WC3** (1994) — software texture-mapped polygons, real 3D, [because 3D cards didn't exist yet](https://www.hardcoregaming101.net/wing-commander/) and the CPU had finally gotten fast enough to eat it. **Strategy 2.**
- **What came next** — 3dfx ships in 1996, and everyone moves to **strategy 1** and never comes back.

One franchise, three strategies, six years — driven entirely by which resource was cheapest at the time. That's the hub's thesis running in fast-forward inside a single product line.

---

### 3. Constrain the geometry — Wolfenstein 3D (1992), Doom (1993) 🔲 *stub*

The insight here isn't a faster multiply; it's **deciding what the level editor will refuse to build**, so the expensive math stops being reachable.

- **Wolfenstein 3D** takes it furthest: [walls are axis-aligned and on a fixed grid](https://twobithistory.org/2019/11/06/doom-bsp.html) — north-south or east-west only, corridors at integer widths. That's what makes a per-column raycast into a uniform grid tractable.
- **Doom** relaxes the axis-alignment (arbitrary wall angles, varying floor and ceiling heights) but keeps the constraints that matter arithmetically: **walls are always vertical, floors and ceilings always horizontal, and no room may sit above another.** No rotation about X or Z ever happens, so the general 3×3 rotation collapses to a 2D problem plus a vertical scale.

**A correction worth carrying:** Doom is [commonly called a raycaster, and isn't one](https://twobithistory.org/2019/11/06/doom-bsp.html) in the Wolf3D sense. Visibility comes from a **BSP tree built offline by the node builder** — the level designer's compile step does the sorting work that a renderer would otherwise redo 35 times a second. Doom then traverses that tree front-to-back and traces per screen *column*. It's precomputation (strategy 4) applied to *visibility* rather than to pixels, wrapped around a per-column renderer.

That makes Doom the most interesting entry in the taxonomy: it's the only one that spends a **fourth** resource — *build time* — and it's the one whose constraint list reads like a design document rather than an optimization.

*(Grounding available: id released the Doom source in 1997. Not yet walked. The claim to verify first is the exact form of the per-column perspective divide and how much of it is table-driven.)*

---

### 4. Precompute at art time — Ultima dungeons, Wing Commander 🔲 *stub (partly grounded)*

The floor of the taxonomy: **do no transform math at runtime at all.**

The Ultima I-V dungeon view [isn't rendered in 3D in any sense](https://tvtropes.org/pmwiki/pmwiki.php/Main/FauxFirstPerson3D) — it composites pre-drawn 2D building blocks, selected by what's in the adjacent map cells and layered by distance, over a fixed floor/ceiling backdrop. Wireframe in I and II, filled color in III and IV, textured in V. The "perspective" is the artist's, baked into the sprites; the code is a lookup and a blit.

Wing Commander's sprite banks are the same idea with a continuous parameter: the 3Space engine behind WC1, WC2, Academy, and Privateer stores each ship as [**38 views**](https://www.wcnews.com/news/update/17309), angled and scaled at runtime. The transform happened — once, on a much bigger machine, before the disk shipped. **WC3 (1994) abandoned it** for software texture-mapped polygons, which puts the whole series' arc inside this taxonomy (see below).

**Why this belongs in a serious taxonomy:** it's the strategy with the best cost/benefit for its actual use case, and it scales *down* infinitely. It's also the only one that fails in a specific, visible way — angular quantization (sprite popping) and the inability to represent anything the artist didn't draw. The cost isn't cycles; it's that the world can only contain what's already in ROM.

*(Grounding: not started. The interesting measurable is the ROM/art budget curve — how many pre-rendered angles before the asset cost exceeds what a software transform would have cost in cycles.)*

---

## The cycle didn't end — it has a period

The math box did not lose. It's the ancestor of everything, and the pattern it started still runs on a two-phase loop:

**Phase A — a workload arrives that the CPU can't afford, so the capability ships as a separately-priced discrete unit.**
**Phase B — the workload becomes universal, so the unit gets absorbed onto the die and stops being a purchase.**
**Then a new workload arrives, and it's phase A again.**

| Workload | Phase A (discrete, priced) | Phase B (integrated, assumed) |
|---|---|---|
| Integer/scalar math | PDP-8 EAE, PDP-11 KE11 | EIS standard on later PDP-11s |
| Avionics multiply/divide | **F-14 CADC / MP944** (1970) — see below | — (classified, no phase B) |
| Floating point | **8087** (1980) | **80486DX** (1989) |
| 3D transform + raster | Atari math box (1980) → discrete GPUs | integrated GPUs / AMD's **APU** |
| Neural inference | **TPU**, **NPU** (datacenter + discrete accelerators) | on-die neural engines in current laptop/phone SoCs |

**The earliest phase A found so far is a decade before the 8087, and it was classified.** The F-14 Tomcat's [Central Air Data Computer](https://www.tomshardware.com/pc-components/cpus/the-mp944-was-the-real-worlds-first-microprocessor-and-key-to-the-flight-of-the-f-14-tomcat-but-it-lived-in-the-shadow-of-the-intel-4004-for-nearly-30-years) — Ray Holt and Steve Geller with AMI, design started 1968, **completed June 1970**, beating the Intel 4004 by a year — is a 20-bit pipelined multi-microprocessor at 375 kHz. Its 28-circuit chipset breaks out as 1 PMU, 1 PDU, 1 SLF, 3 RAS, 3 SLU, and 19 ROMs, ~74,442 transistors: **the multiply and divide units are separate, dedicated chips.** It was classified by the Navy until **1998**, which is a large part of why the popular "first coprocessor" story starts at the 8087 instead. *(Confirming the PMU/PDU expansions from primary CADC documentation is a to-do, not yet done.)*

Meanwhile the **Apollo Guidance Computer** (Block II) had [hardware `MP` and `DV` instructions](https://www.liquisearch.com/apollo_guidance_computer/design/instruction_set) — `MP` leaves the high product in A and the low in LP; `DV` takes a double-precision dividend in A/L and returns a correctly-signed remainder in L, which Block II specifically reworked to cut execution time. So the LM was multiplying in hardware in the mid-60s. **Guidance and avionics got the silicon first; consumer computing waited fifteen years and then had to reinvent it as an option box.**

**One terminology note, and it sharpens the point:** *APU* — AMD's "Accelerated Processing Unit" — is CPU + GPU on **one die**. That's not a new coprocessor; it's **phase B for graphics**, the exact same move the 486DX made for floating point. The AI-engine acronym is **NPU** (Neural Processing Unit — Apple's Neural Engine, the NPU in Intel Core Ultra and Snapdragon X), with **TPU** being Google's datacenter-scale version.

So the APU is evidence *for* the thesis rather than another instance of it: graphics finished its cycle and got absorbed, which is precisely what freed the "expensive coprocessor" slot for AI silicon to occupy.

**And "pay-to-play" is the durable observation.** Renting an H100 by the hour is the PDP-8's EAE option box with a credit card attached. The specific arithmetic changes — multiply, then floating point, then transform-and-light, now matrix multiply at low precision — but the structure is identical every time: *the operation that matters most is the one you cannot afford to do on the general-purpose part, so someone sells it to you separately.* Sixty years, four workloads, same business model.

### The current phase-A workload is local inference

"AI ready" is the marketing term for a machine with an NPU, and it is conspicuously vague about what it buys — which is itself the tell. Every prior phase-A moment looked the same: *the capability is real, the workload is nascent, and nobody can yet tell you how many of the units you need.* "Math box" was equally opaque to a 1980 arcade operator.

What makes it the same problem rather than a loose analogy is that **inference is running the exact same playbook, on the same axes:**

| The 3D move | The inference move |
|---|---|
| buy the math (coprocessor) | NPU / TPU / rented GPU hours |
| cut unit cost (log tables) | **quantization** — fewer bits per multiply |
| cut operation count (polar meshes) | **sparsity, MoE, distillation** — restructure so fewer multiplies are required |
| memoize and index (sine tables, sprite banks) | **KV-cache; retrieval instead of parametric recall** |
| constrain the world (Doom's BSP) | **fixed schemas, constrained decoding, precompiled tool contracts** |

The memoization law transfers intact, too: cache a KV block and nobody can tell; cache too far down the pipeline — a whole canned answer — and the seams show, exactly like sprite popping.

**And this is why the vault is a working instance of the pattern, not just a commentator on it.** "Accumulated state IS the verification layer" is memoization applied to reasoning: a grounded artifact is a *cached result you index instead of recomputing*, which is precisely why [reuse/convert beats rebuild](../karpathy-three-layer-method.md). The [context-cache hierarchy](../../notes/context-cache-hierarchy.md) is the depth question — how far down do you cut before the quantization shows? And [planner-LM composites](../planner-lm-composites.md) are strategy 1: put the expensive operation on dedicated machinery instead of asking the general-purpose part to do everything.

The open question stays open, one level up: **if inference is the current phase-A, what's the phase-A after it?**

## The thesis this hub exists to test

**The strategy chosen is predicted by which resource was cheapest for that team, not by which was technically best.**

- Atari sold a $3,000 cabinet and could amortize a coprocessor board across the BOM → **buy it**.
- Acornsoft shipped a cassette for a fixed consumer machine with no expansion → **compute it**.
- id shipped to a PC market where the CPU was fast but wildly variable and RAM was the binding constraint → **constrain the geometry and precompute the visibility**.
- Origin and Richard Garriott had artists and floppy capacity but a CPU with no hope → **precompute the pixels**.

If that holds, the taxonomy isn't a list of tricks — it's a [dominance frontier](../dominance-frontier-lens.md) over four resources, and each game is a rational point on it. The falsifiable version: **find a game that picked a strategy its resource position didn't favor, and explain why.** (Candidate counterexample to chase: home-computer ports of arcade vector games, which inherited strategy-1 designs onto strategy-2 hardware and had to degrade — what got cut, and did it get cut in the order this model predicts?)

## Open questions

- **The measured coprocessor gap is ~9×, not 25-35×** — and the difference is the interesting part. Battlezone counts ~220 cycles/vertex; a naive software port would be ~5-8k (25-35×); Stellar 7 actually lands near ~2,000 (≈9×). **The polar-coordinate representation recovered most of the gap.** That's the strongest quantitative result the hub has: choosing the right representation was worth roughly 3× — comparable to buying hardware — but it was paid for in geometric freedom, not cash.
- **Where exactly does Doom's perspective divide happen,** and how much of the renderer is table-driven vs computed? That determines whether Doom is really strategy 3 or a strategy-3/4 hybrid.
- **The art-budget crossover for strategy 4** — at what angular resolution does pre-rendering stop being cheaper than transforming?
- **Did anyone blend 1 and 3?** A coprocessor *and* constrained geometry should be strictly dominant; the absence of examples (if it is an absence) would be informative.
- **Does Elite's log-table multiply beat Stellar 7's polar trick on cycles?** Both recover speed without hardware, by opposite means (cheaper operation vs fewer operations). A head-to-head cycle count would say whether *representation* or *algorithm* was the better buy on a 6502 — and whether the answer flips with available RAM.
- **What is the next phase-A workload?** The EAE → 8087 → GPU → NPU loop predicts one exists right now: something done expensively in software on hardware not designed for it, waiting for a discrete accelerator and a price tag.
- **Run the search backwards — what was the *first* multiply?** First pass says the answer is earlier and more military than the consumer story admits: the AGC had hardware `MP`/`DV` in the mid-60s, and the F-14 CADC shipped **dedicated PMU/PDU chips in 1970**. Open sub-questions: (a) did any early guidance or fire-control computer use **log/antilog tables** the way Elite does — the technique long predates computers (Napier 1614; every slide rule is an analog antilog table), so the question is when it first went into ROM; (b) how far back does shift-and-add go as the *documented* fallback; (c) what did the analog era do, since a resolver or a servo multiplier solves this without arithmetic at all.
- **Survivorship caveat on the whole taxonomy.** This hub catalogues four strategies *that shipped*. Invention runs at roughly 99 failures per success, so the strategies that didn't work leave no specimen and the taxonomy is a survivor list read as if it were a design space. Worth naming explicitly before treating the four as exhaustive — the same "new chip design will replace everything" fanfare that surrounds every current accelerator surrounded plenty of dead ones.
- **One negative specimen, anecdotal.** *(Unverified — a YouTube commenter's account, recorded because failures in this space almost never leave a trace at all.)* A hobbyist attempted an Atari *Star Wars* port on a 6502 home machine (C64, per the account), **used none of the four strategies**, and it did not work. That is the shape the survivorship caveat predicts is invisible: the strategies are not stylistic flavour on top of a workable naive implementation — **the naive implementation is not workable**, which is precisely why every shipped specimen picked one. Chris pointed them at Elite and Stellar 7, i.e. at strategies 2 and 2/3. If a reproducible write-up of an attempt like this ever surfaces, it is worth far more to this page than another success would be.

## Sources

- [PDP-8 FAQs](https://homepage.cs.uiowa.edu/~jones/pdp8/faqs/) (Doug Jones) — EAE as an optional purchase
- [PDP-11 Extended Instruction Set](https://gunkies.org/wiki/PDP-11_Extended_Instruction_Set) / [KE11-E](https://gunkies.org/wiki/KE11-E_Extended_Instruction_Set) — model-by-model availability
- Ken Shirriff, [Reverse-engineering the multiplication algorithm in the Intel 8086](http://www.righto.com/2023/03/8086-multiplication-microcode.html) — the microcode, and the cycle counts
- [Intel 8087](https://en.wikipedia.org/wiki/Intel_8087) + [8087 manuals at PCjs](https://www.pcjs.org/documents/manuals/intel/8087/) — parallel instruction decode, the ~84× figure
- Sinclair Target, [How Much of a Genius-Level Move Was Using Binary Space Partitioning in Doom?](https://twobithistory.org/2019/11/06/doom-bsp.html) — Wolf3D's grid constraint, Doom's BSP, the raycasting conflation
- [Faux First-Person 3D](https://tvtropes.org/pmwiki/pmwiki.php/Main/FauxFirstPerson3D) — the Ultima I-V compositing technique and its evolution
- Andy McFadden, [Battlezone disassembly](https://6502disassembly.com/va-battlezone/) — specimen #1's primary source
- Andy McFadden, [Stellar 7 disassembly](https://6502disassembly.com/a2-stellar7/) — specimen #2's primary source
- Mark Moxon, [Elite on the 6502](https://elite.bbcelite.com/) — the pure strategy-2 point. Deep dives used here: [ship blueprints](https://elite.bbcelite.com/deep_dives/ship_blueprints.html) (Cartesian vertex format), [calculating vertex coordinates](https://elite.bbcelite.com/deep_dives/calculating_vertex_coordinates.html) (3×3 matrix from orientation vectors, `LL9`), [multiplication and division using logarithms](https://elite.bbcelite.com/deep_dives/multiplication_and_division_using_logarithms.html) (`FMLTU`, `LL28`), [shift-and-add multiplication](https://elite.bbcelite.com/deep_dives/shift_and_add_multiplication.html). Full source not yet walked line-by-line

## Tags

[6502](../../tags/6502.md), [assembly](../../tags/assembly.md), [reverse-engineering](../../tags/reverse-engineering.md), [games](../../tags/games.md), [game-design](../../tags/game-design.md), [mathematics](../../tags/mathematics.md), [history](../../tags/history.md), [ai](../../tags/ai.md)
