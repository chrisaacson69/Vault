---
status: active
created: 2026-08-04
published: true
layout: layouts/page.njk
title: "Arithmetic as a Purchase — Sixty Years of Paying for Multiply"
permalink: /research/arithmetic-as-a-purchase/
---
# Arithmetic as a Purchase — Sixty Years of Paying for Multiply
> IBM sold multiplication on the 1401 for **$325 a month**. Thirty years later Nintendo sold it inside a cartridge. The ability to multiply quickly has been a *line item* for the entire history of computing — and the three ways of coping with not affording it recur, unchanged, from core memory to the NPU.

**Links:** [Arithmetic Scarcity and the 3D Problem](./gaming/arithmetic-scarcity-3d.md) *(the games-side hub this generalizes)*, [Battlezone](./gaming/battlezone-mathbox.md), [Stellar 7](./gaming/stellar7-software-3d.md), [NES Mappers Reference](./nes/mappers-reference.md) *(the MMC5 multiplier)*, [Nobunaga's Ambition (SNES) compiled native](./gaming/na1-snes-native-port.md) *(vault-internal specimen)*, [Computation and Information Theory](./computation-and-information.md)

**Status:** timeline / evidence page. Well-grounded on the entries below; gaps flagged inline. Built to test one claim — *fast arithmetic was priced, not assumed* — against the widest span of hardware available.

---

## The mainframe era: the price tag literally exists

The strongest evidence for the thesis is that you can read the invoice.

**IBM 1401 (1959) — multiply/divide was an extra-cost option at [$325/month](https://www.columbia.edu/cu/computinghistory/1401.html).** The base machine's arithmetic was serial add-to-storage logic with no multiply or divide at all. The option added roughly **246 SMS cards across two gates** — decimal multiplication and division in hardware, which is *harder* to build than binary. If you didn't buy it, you wrote loops.

**IBM 1620 (1959) — the machine that couldn't add.** Nicknamed [**CADET**, "Can't Add, Doesn't Even Try"](https://www.cs.auckland.ac.nz/historydisplays/FirstFloor/IBM1620/IBM1620Main.php). The Model I had **no conventional ALU whatsoever**. All arithmetic was table lookup in core memory: addition and subtraction indexed a 100-digit table at `00300-00399`, multiplication a 200-digit table at `00100-00299`. You had to *load the addition tables into low memory* before the machine could add. Division was a software subroutine; hardware divide (repeated subtraction) was an option. The Model II, three years later, gained a real adder — **but multiplication stayed a table lookup.**

This is the single most important specimen on the page. **The 1620 is Elite's log tables implemented as an entire CPU** — memoize the operation over a discretized domain and index it, because the table is cheaper than the circuit. IBM shipped a commercial mainframe on that trade in 1959, and it was explicitly a cost-reduction decision.

**IBM System/360 (1964) — floating point as a feature checkbox.** Binary floating point and variable-length packed decimal were *separate optional features*; FP was unavailable on the low-end models (30 and below) and standard only at the high end (65, 67, 75). One architecture, one instruction manual, and which arithmetic you actually got depended on the model and the order form. *(Exact per-feature pricing not yet sourced — to-do.)*

**CDC 6600 (1964) — the opposite answer, and the ancestor of the GPU.** Rather than sell arithmetic as an option, Seymour Cray built [ten parallel functional units](https://en.wikipedia.org/wiki/CDC_6600) — **two floating-point multipliers, one floating-point divider**, a fixed-point adder, two incrementers, a Boolean unit, a shifter, a branch unit — and let them run concurrently. That's not "buy the multiply," it's "buy *several* multiplies and overlap them," which is the idea every vector unit, GPU shader array, and systolic tensor core would later industrialize.

So by 1964 all four strategies are already visible in commercial hardware: **buy it** (1401 option), **memoize it** (1620), **restrict who gets it** (S/360 model tiers), **parallelize it** (6600).

---

## Guidance and military: the silicon went there first

**Apollo Guidance Computer, Block II (mid-1960s)** — hardware [`MP` and `DV` instructions](https://www.liquisearch.com/apollo_guidance_computer/design/instruction_set). `MP` leaves the high product in A and the low in LP; `DV` takes a double-precision dividend in A/L and returns a correctly-signed remainder in L. Block II specifically *reworked both to cut execution time*. The Lunar Module was multiplying in hardware while commercial buyers were still renting the capability.

**F-14 CADC / MP944 (1970)** — Ray Holt and Steve Geller with AMI; design started 1968, [completed June 1970](https://www.tomshardware.com/pc-components/cpus/the-mp944-was-the-real-worlds-first-microprocessor-and-key-to-the-flight-of-the-f-14-tomcat-but-it-lived-in-the-shadow-of-the-intel-4004-for-nearly-30-years), beating the Intel 4004 by a year. A 20-bit pipelined multi-microprocessor at 375 kHz; its 28-circuit chipset breaks out as **1 PMU, 1 PDU**, 1 SLF, 3 RAS, 3 SLU and 19 ROMs — ~74,442 transistors, with **multiply and divide as separate dedicated chips**. Classified by the Navy until **1998**, which is most of why the popular "first coprocessor" story starts at the 8087 a decade later. *(Confirming PMU/PDU expansions from primary CADC documentation is still a to-do.)*

**The pattern:** aerospace bought arithmetic outright because the alternative was falling out of the sky. Everyone else rented, deferred, or faked it.

---

## The micro collapse: back to nothing

The 8-bit microprocessor era is a genuine *regression* in arithmetic capability relative to the mainframes and avionics that preceded it — the price of putting a CPU on one cheap die.

| Part | Multiply | Divide |
|---|---|---|
| 6502, 8080/8085, Z80 | **none** | **none** |
| 6809 (1978) | 8×8→16 `MUL` | none |
| 8086/8088 (1978) | present but **microcoded**: [118-133 clocks](http://www.righto.com/2023/03/8086-multiplication-microcode.html) for 16-bit | 144-162 clocks |
| 65C816 (1984) | **none** | **none** |

The 8086 is the instructive one: Intel spent the *opcode* and declined the *transistors*, so a 16-bit multiply cost ~25 additions and working programmers avoided it exactly as 6502 programmers did. Floating point stayed a separate purchase — the **8087** (1980, [~84× faster](https://en.wikipedia.org/wiki/Intel_8087) than emulation) — until the **80486DX** integrated it in 1989. Twenty-four years after the 1401's option box, and the capability finally stopped being something you ordered.

---

## The demand side: what actually ends phase A

Cheaper silicon explains how integration becomes *possible*. It doesn't explain *when* it happens. The trigger is a **killer app that makes the capability universal** — at which point shipping the machine without it stops being a saving and starts being a defect.

The 8087 era is the clean case. Floating point was a specialist's purchase until **VisiCalc, Lotus 1-2-3, and AutoCAD** turned arithmetic into something an ordinary business customer bought a computer *in order to do*. Spreadsheets and CAD were the first mass software where the machine's math speed was the product. Once "recalculate the model" and "regenerate the drawing" were what people were waiting on, an FPU stopped being an option box — and the 80486DX integrated it.

That gives the cycle a proper mechanism:

**Phase A** — workload arrives, capability ships discrete and priced.
**→ killer app** — the workload becomes something customers buy the machine *for*.
**Phase B** — capability integrates and becomes assumed.

And it yields a falsifiable read on the present: **"AI ready" is vague about what it buys because the killer app hasn't arrived yet.** Nobody can tell you how many TOPS you need because there is no equivalent of "recalculate the spreadsheet" — no everyday task where the local NPU is the thing you're waiting on. Until one exists, inference stays phase A: discrete, priced, and rented. The prediction is that integration follows the app, not the transistor budget.

---

## The console era: the math box returns, and now you pay per game

This is where the story gets literal about pay-to-play, and where the vault has its own primary-source evidence.

### The NES: a memory mapper that is also a multiplier

The 6502 has no multiply, so the MMC5 — the most elaborate mapper ASIC Nintendo built — supplies one: an [8×8 unsigned multiplier at `$5205`/`$5206`](https://www.nesdev.org/wiki/MMC5), write the operands, read the 16-bit product back from the same two addresses. It's the one entry on this page that **breaks the standard protocol**: the result is combinational and readable on the *next CPU cycle*, no trigger-and-wait (mapper 90's makes you wait 8). That costs ASIC area and makes it behave less like a coprocessor than like an instruction that happens to live at an address.

**Verified against the vault's own decompiled ROMs** — three of the five KOEI MMC5 titles use it: NA2 (1988) has a **VM opcode** backed by it (`vm_op_mul16` `$E2F2`) plus `calc_nametable_addr`; ROTK2 (1990) uses it for struct indexing (`record_ptr = $71D4 + A*$22`); L'Empereur (1991) builds a **32-bit multiply-accumulate** on top of it (`mul32_mmc5` `$EFCB`). Three findings from the source that a spec sheet wouldn't give you:

- **Software composes upward from the 8-bit primitive** — 8×8 in hardware becomes 16-bit and then 32-bit in software. Exactly what KOEI did again on the SNES.
- **Divide stayed in software.** NA2's `vm_op_udiv16` is explicit: *"MMC5 has no hw divide; only multiply moved to `$5205/6`."* The VM carries a hardware multiply and a software divide **side by side in one instruction set**.
- **The commonest use is addressing, not math** — `base + index × stride`, `col + row × 32`. The mapper's multiplier mostly does struct and tile lookup.

**A PRG-only ROM scan of all five KOEI MMC5 titles settles it: the multiplier is the busiest register on the chip.** Write/read counts on `$5205/$5206` — NA2 **28/24**, ROTK2 **36/31**, Bandit Kings **26/23**, L'Empereur **33/32**, Gemfire **14/12** — more traffic than PRG/CHR *bank switching* in every title, and with a near-1:1 write:read ratio that is the signature of genuine use (write two operands, read two product bytes). For a strategy series built on record tables and stat formulas, `base + index × stride` is the hot path, and that is exactly what the mapper accelerates. **KOEI took the multiplier, banking, vertical split, ExRAM and fill mode — but not the expansion audio and not the scanline IRQ** (`$5203`, the IRQ compare register, is never written in any of the five). Details and method on the [mappers reference](./nes/mappers-reference.md).

*(Two corrections are recorded there rather than quietly fixed, because both wrong answers looked like findings: a first pass grepped the decompiler repos and measured the **corpus** rather than the ROMs; a second scanned the ROMs but included **CHR-ROM**, 33-50% of each file and pure tile graphics, which inflated every count and manufactured a spurious "expansion audio grows across the line" trend.)*

### The SNES shipped its multiplier as a memory-mapped peripheral

The 65C816 has **no multiply instruction**. So the SNES's 5A22 provides one as [MMIO registers](https://snes.nesdev.org/wiki/Multiplication) — and the interface is worth reading carefully:

```
$4202 WRMPYA   operand A (8-bit unsigned)
$4203 WRMPYB   operand B  <- writing here STARTS the multiply
$4216/$4217    RDMPYL/H   16-bit result, ready after 8 CPU cycles
```

Divide is the same shape — dividend `$4204/$4205`, divisor `$4206`, quotient in `RDDIV $4214/$4215`, remainder in `RDMPY $4216/$4217`, up to 16 cycles.

**That is Battlezone's math box protocol exactly, ten years later and shrunk onto the CPU die:** write the operands to a port, the *last write is the trigger*, wait a known cycle bound rather than polling, read the result from a separate address. Same API shape, same "you may compute during the wait if you know the bound" contract.

The payoff is real — without the hardware, an optimised 8×8 multiply runs **~80 cycles** and a division **~151**, against 8 and 16. Roughly **10×**, which is the same order as Battlezone's coprocessor advantage.

**Vault-internal confirmation:** the [Nobunaga's Ambition SNES reversal](./gaming/na1-snes-native-port.md) found KOEI's **native math library at `$C1:F800`** — 32-bit signed multiply and divide built as *restoring division over zero-page registers wrapping those exact `$4202/$4204/$4214/$4216` units*. A shipped commercial game composing a 32-bit software layer on top of an 8-bit hardware primitive. That's this page's thesis decompiled from a real ROM rather than read off a spec sheet.

### And then Nintendo sold the coprocessor inside the cartridge

| Chip | What it is | Games |
|---|---|---|
| **DSP-1** | An [NEC μPD77C25 DSP pre-programmed with 3D math routines](https://jsgroth.dev/blog/posts/snes-coprocessors-part-1/) — fast trig and the matrix work behind advanced Mode 7 | Pilotwings, Super Mario Kart, ~16 titles |
| **Super FX** | [Argonaut's custom RISC processor](https://en.wikipedia.org/wiki/Super_FX) rendering polygons into its own adjacent framebuffer RAM | Star Fox, Stunt Race FX |

**The DSP-1 is the Atari math box reborn with the serial numbers filed off** — a separate chip carrying fixed, pre-programmed 3D math routines, fed operands by a host CPU that can't do the work itself. Thirteen years after Battlezone, same architecture, same reason.

And the economics are the purest expression of the thesis anywhere on this page: **the chip is in the cartridge, so the arithmetic is priced per title.** Not per machine, not per customer — per *game*. Buying Star Fox meant buying a processor.

### Then it became the whole point of the machine

The PlayStation's [**Geometry Transformation Engine**](https://frds.github.io/ps1-gte) is a MIPS coprocessor doing matrix transforms, vector arithmetic, perspective projection, and depth cueing — the exact job list from Battlezone's math box function table, now the console's headline feature rather than an option. Within a generation the coprocessor stopped being an add-on and became the product.

---

## What recurs

Across sixty years and four eras, the same small set of moves:

| Move | 1959 | 1980 | 1990 | Now |
|---|---|---|---|---|
| **Buy dedicated silicon** | 1401 multiply option ($325/mo) | Atari math box; 8087 | **MMC5's `$5205`**; DSP-1, Super FX (per cartridge) | NPU / TPU / rented GPU hours |
| **Memoize and index** | **IBM 1620 tables** | Elite's log/antilog tables | sine tables everywhere | KV-cache; retrieval over parametric recall |
| **Restructure so less is needed** | — | Stellar 7's polar meshes | Mode 7's constrained 2D affine transform | sparsity, MoE, distillation |
| **Parallelize** | **CDC 6600's ten units** | — | — | tensor cores, GPU shader arrays |

Two observations that only appear at this timescale:

**1. The interface shape is astonishingly stable.** Write operands to a port, let the final write trigger, wait a known bound, read a result register. That protocol is Battlezone's `$1860-$187f`, the SNES's `$4202`, and — at a different scale and with a queue in front of it — a GPU command buffer. The thing being computed changed completely; how you ask for it barely moved. **The MMC5 is the instructive exception**: combinational, zero-latency, no handshake — which is what a coprocessor looks like when you stop caring about ASIC area, and which is also why it reads as an instruction rather than a device.

**2. Capability regresses whenever a new cheap substrate appears.** The 6502 could do less arithmetic than a 1959 mainframe *or* a 1966 spacecraft. Every time computing found a cheaper physical substrate — SMS cards to MOS to a single die to a phone SoC — the first generation on it lost the arithmetic and had to re-earn it. Which suggests the current NPU moment is not novel: it's the fifth time this has happened, and the thing to watch is when inference acceleration stops being a purchase.

## Open threads

- **Weitek, 68881/68882, NS32081** — the mid-80s FPU aftermarket is unresearched here and is probably the densest single era for "arithmetic as a priced add-on."
- **S/360 feature pricing** — the per-feature dollar figures would make the 1401's $325/month less of a lone data point.
- **The analog era.** A resolver or servo multiplier performs rotation with *no arithmetic at all*. Where does that sit in a taxonomy built around operation counts? It may be a fifth strategy — *change the physics* — with no digital analogue.
- **When did log tables first go into ROM?** The technique predates computing entirely (Napier 1614; every slide rule is an analog antilog table), and the 1620 proves the idea was in commercial hardware by 1959 — but the first *stored-program* log-multiply is unlocated.
- **Dump the native 6502 floor for the four non-NA2 MMC5 repos.** The probe above closed a false anomaly but exposed a real corpus gap: `bk`, `rot3k2`, `GemFire` commit only VM bytecode and `LEmp` no `source/` at all, so *no cross-title question about native code can currently be answered by grep*. Emitting a 6502 listing for each would settle the `0 callers` question and make the whole family greppable — cheap, since the toolchain already exists in `na2-decompiler`.
- **What is the killer app that ends the NPU's phase A?** The 8087 needed VisiCalc, 1-2-3, and AutoCAD before the 486DX absorbed it. Naming the equivalent — or establishing that none exists yet — is the sharpest available test of the demand-side mechanism.
- **Survivorship caveat.** This page lists hardware that shipped. Invention runs at roughly 99 failures per success, so a timeline of survivors reads like a design space when it is really a selection record.

## Sources

- [The IBM 1401](https://www.columbia.edu/cu/computinghistory/1401.html) (Columbia) — the $325/month multiply-divide option, 246 SMS cards
- [IBM 1620 / CADET](https://www.cs.auckland.ac.nz/historydisplays/FirstFloor/IBM1620/IBM1620Main.php) (Auckland) + [Columbia's 1620 page](https://www.columbia.edu/cu/computinghistory/1620.html) — table-lookup arithmetic, table addresses, Model II
- [CDC 6600](https://en.wikipedia.org/wiki/CDC_6600) — the ten functional units
- [AGC instruction set](https://www.liquisearch.com/apollo_guidance_computer/design/instruction_set) — `MP` / `DV`
- [MP944 / F-14 CADC](https://www.tomshardware.com/pc-components/cpus/the-mp944-was-the-real-worlds-first-microprocessor-and-key-to-the-flight-of-the-f-14-tomcat-but-it-lived-in-the-shadow-of-the-intel-4004-for-nearly-30-years) — 1970, PMU/PDU, classified to 1998
- Ken Shirriff, [8086 multiplication microcode](http://www.righto.com/2023/03/8086-multiplication-microcode.html) — the cycle counts
- [NESdev: MMC5](https://www.nesdev.org/wiki/MMC5) + [8-bit Multiply](https://www.nesdev.org/wiki/8-bit_Multiply) — the `$5205`/`$5206` multiplier and its combinational readback
- [SNESdev: Multiplication](https://snes.nesdev.org/wiki/Multiplication) / [Division](https://snes.nesdev.org/wiki/Division) — register map, cycle counts, software-fallback comparison
- [SNES coprocessors: DSP-1 and friends](https://jsgroth.dev/blog/posts/snes-coprocessors-part-1/), [Super FX](https://en.wikipedia.org/wiki/Super_FX)
- [PS1 Geometry Transformation Engine](https://frds.github.io/ps1-gte)
- **Vault-internal:** [Nobunaga's Ambition (SNES) compiled native](./gaming/na1-snes-native-port.md) — the `$C1:F800` math library, decompiled; [NES Mappers Reference](./nes/mappers-reference.md) — the MMC5 multiplier section, grounded in the `na2` / `rot3k2` / `LEmp` decompiler label tables and asm sources

## Tags

[history](../tags/history.md), [assembly](../tags/assembly.md), [mathematics](../tags/mathematics.md), [reverse-engineering](../tags/reverse-engineering.md), [6502](../tags/6502.md), [65816](../tags/65816.md), [snes](../tags/snes.md), [ai](../tags/ai.md)
