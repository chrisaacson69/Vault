---
status: active
created: 2026-10-11
published: true
layout: layouts/page.njk
title: "Data-First RE"
---
# Data-First RE — when the static↔runtime join is broken, start from state
> On a target where a runtime address can't be cheaply mapped to its place in the disassembly (DOS real mode with segment relocation, overlays, packed/loaded code), don't start by walking code. **Start from persistent state** (the save file), find it live in RAM, name it by perturbation, and only then use watchpoints to drop into the code that touches it. Name the data first; the code is reached *through* the data.

**Links:** [The Anchor Method](./anchor-method.md) (the save file and an independent reimplementation are the anchors) · [The Rosetta Stone Method](./rosetta-stone-method.md) (a reimplementation is a "known program" crib) · [Transpilation as Grounding](../research/transpilation-as-grounding.md) · [AI speedruns NES Zelda](../research/gaming/zelda-ai-speedrun-harness.md) (same lesson, other direction: the bot read the code too late) · specimen: [zappatic MOO1 stream](../research/gaming/moo1/zappatic-re-stream.md)

## Why this is a classification result, not a preference
*Classify the architecture first.* The vault's ROM projects (NA1, KOEI) are static images at fixed
addresses: a call tree is walkable and every runtime PC *is* a disassembly address. A DOS `MZ`
executable is not: the loader picks a base segment, applies relocations, and the program may load
further code (overlays, a second EXE — MOO1's `ORION.EXE` is a loader for `STARMAP.EXE`). The same
byte has one address in Ghidra and another, run-dependent one in the emulator. Every static↔runtime
hop costs a manual join, so a code-first walk pays that tax on every step.

**Data has no such tax.** A save file is position-independent truth, and a struct found by its
content (a planet name, a planted canary) is found regardless of where the loader put it.

## The loop
1. **Stride the save.** Find a repeated record (names are best), measure the stride, count records.
2. **Find it live.** Search RAM for the same bytes → base address of the live array.
3. **Overlay `unknownN` fields** (16-bit default on a 16-bit target), trim until record 2 aligns.
4. **Perturb and observe**, one variable at a time: poke → watch UI / end turn. *Snaps back* = derived, not state.
5. **Canaries both ways** to map RAM ↔ disk where layouts differ (reordered, reversed, repacked blocks).
6. **Only now go to code:** a write/read watchpoint on a *named* field lands in the routine that owns it.

## The oracle ladder (verification-independence)
A field named by perturbation is a hypothesis. Confirm it against an artifact that **didn't come from
the same probe**:

| Oracle | Gives | Independence |
|---|---|---|
| Save file + perturbation | layout, enums, stored-vs-derived | the probe itself |
| Independent reimplementation source (MOO1: 1oom) | names, offsets, *formulas* | built from the binary by others |
| Official strategy guide (MOO1: the OSG, Emrich & Hughes) | mechanics, AI rules in prose | written outside the code; 1oom credits it for mechanics + AI |
| Third-party RE (MOO1: zappatic's struct JSON) | layout | same method as ours, different hands |

The rungs are not interchangeable: a guide documents **intent**, the binary is **actual**, and a reimplementation that chose to reproduce-or-fix each bug (1oom's `list_gamediff`) **catalogues the gap** — so a guide-vs-probe disagreement is often a real bug, not noise. A domain expert who knows the bug lore is a rung of its own. Disagreement between rungs is the signal: the MOO1 stream's struct file summed to 59,014 bytes; 1oom
said 59,036; the 22-byte gap was a real unmapped tail (game-over/winner/election), not noise.

## Fixing the join instead of avoiding it (open)
The stream abandoned code because the join was manual. It needn't be: for a single relocated image
the delta should be one constant per run (load segment − Ghidra's base, 0x1000 by default),
recoverable from the PSP or one byte-pattern match. Overlays break this into one delta per overlay.
*Hypothesis for MOO1 — untested.* If it holds, data-first becomes data-*led*, with code fully reachable.

## Open Questions
- Is the MOO1 STARMAP image one relocation delta, or overlaid?
- Which DOS debugging stack gives watchpoints + scripting without building a front-end (DOSBox-X debugger, DOSBox-Staging, Ghidra + emulator bridge)? Survey what other DOS RE projects use before choosing.

## Tags
[methodology](../tags/methodology.md) · [reverse-engineering](../tags/reverse-engineering.md)
