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
further code (overlays, a second EXE — MOO1's `ORION.EXE` (setup, new-game data) hands off to `STARMAP.EXE` (turn engine)). The same
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

The rungs are not interchangeable: a guide documents **intent**, the binary is **actual**, and a reimplementation that chose to reproduce-or-fix each bug (1oom's `list_gamediff`) **catalogues the gap** — so a guide-vs-probe disagreement is often a real bug, not noise. A domain expert who knows the bug lore is a rung of its own. **The cheapest binary rung: a table sweep.** Parse every hard-coded table out of the reimplementation's source and byte-search the original executables for it (both widths, both signednesses). A full hit makes that table binary-verified with no debugger and no address join; a near-hit with a few differing indices flags a reimplementation change; absence proves nothing (computed, packed, or archive data). MOO1: 23 of 53 1oom integer tables byte-identical in v1.3, and the hits sorted themselves by executable (setup data in `ORION.EXE`, turn logic in `STARMAP.EXE`) — a module map for free. Gotcha: C `uint8_t` tables were often 16-bit words in the original, so search widths the source doesn't declare. Disagreement between rungs is the signal: the MOO1 stream's struct file summed to 59,014 bytes; 1oom
said 59,036; the 22-byte gap was a real unmapped tail (game-over/winner/election), not noise.

## Fixing the join instead of avoiding it (verified 2026-10-16)
The stream abandoned code because the join was manual, but it's arithmetic. In **linear** addresses
(never raw seg:off): the root module is at `(PSP+0x10)×16 + (file_off − header)`, one constant per
run. Overlays add one term: Borland FBOV code loads at `<buffer>:0000`, so a runtime offset *is* the
offset into that overlay. Verified live on MOO1 (Steam DOSBox 0.74, both EXEs) by reading guest RAM
read-only from outside, with no debugger: PSP observed from its MCB, ~99.97% of relocations and
31/31 binary-verified tables at the predicted addresses, and zappatic's fleet-count write found at
overlay #71 + `0x1839`. **Data-first becomes data-led**: data still names things first, but code is now reachable.
The verifier is the loader's own relocation table, an oracle the formula didn't come from.
Evidence: moo1-re `notes/dos-address-join.md`, tool `tools/dos_addr.py`.

## Reading code without a decompiler (MOO1, 2026-10-17)
With the address join solved, a plain disassembler (Capstone, 16-bit) was enough — the reimplementation's
C *is* the decompilation, and the question is only whether the original's instructions agree with it.
- **Derive the data segment by voting.** Every binary-verified table must be referenced from code by its
  DS offset; try each candidate DGROUP base and count verified tables that appear as memory operands. MOO1
  STARMAP: one base explained 14/16 tables, the runner-up 7/16 — unambiguous, no debugger.
- **Fingerprint, then disassemble.** Linear-sweep disassembly desyncs in mixed code/data and silently
  misses routines. Search the *raw bytes* for the instruction encoding of the routine's distinctive
  constants (e.g. `83 /7 ib` with 0x60→0x5B→0x51→0x47), then disassemble backwards from the hit.
- **"Absent" tables are often stride-padded.** The sweep missed MOO1's AI weight table because the
  original rows were 15 words and the reimplementation kept 9. Found by code, the table matched value
  for value — and exposed a reimplementation bug (wrong column read) that no table comparison could have.

## Getting decompilers past Borland overlays (MOO1, 2026-10-17)
Decompilers load only an FBOV program's root module (half of STARMAP.EXE was invisible). Fix it by
**de-overlaying**: place every overlay at a fixed segment above DGROUP, turn each overlay's fixup block
into MZ relocations, and patch each 5-byte stub entry `INT 3Fh <off> 00` into `JMP FAR <off>:<seg>` —
one statically linked image, every call resolved. Validate against invariants the rewrite didn't use
(every fixup word is a root segment; every entry lands on a prologue; root bytes change only inside
entries). If the decompiler still aborts on the whole image, feed **each overlay as a raw blob at its
de-overlay segment with fixups applied for the decompiler's base** — root calls then carry the same
addresses as a root-only run, so per-overlay outputs join up and crashes stay local. MOO1: 987 typed
procedures across STARMAP (Reko 0.12.5), plus Reko's runtime ID — Borland C v3.

## Open Questions
- ~~Is the MOO1 STARMAP image one relocation delta, or overlaid?~~ **Resolved 2026-10-16** → [above](#fixing-the-join-instead-of-avoiding-it-verified-2026-10-16): both. One delta for the root (all data + 19 tables), plus 25 FBOV overlays (code only), each at `<buffer>:0000`.
- Which DOS debugging stack gives watchpoints + scripting without building a front-end (DOSBox-X debugger, DOSBox-Staging, Ghidra + emulator bridge)? Survey what other DOS RE projects use before choosing. *(Half answered 2026-10-16: the **address join** needs no debugger, since a read-only host-side RAM read plus the formula is enough. **Watchpoints** still need one. The Steam DOSBox is a stock 0.74 build with no debugger.)*

## Tags
[methodology](../tags/methodology.md) · [reverse-engineering](../tags/reverse-engineering.md)
