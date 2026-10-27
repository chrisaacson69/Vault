---
status: active
created: 2026-10-27
---
# Taking emu-harness to the other three comparison titles
> Mappy went through the harness and came out with 100% code recall against the published disassembly.
> The plan: give each title its own repo when it gets a harness pass, keep `game-annotation` as the
> comparison layer, and add Adventure (2600), then Utopia (Intellivision), then M.U.L.E. (Atari 800).
> **Blocked on ROM dumps:** the sources alone aren't enough for an emulator to run.

**Links:** arcs → [The comparison studies](./README.md) · harness → [emu-harness](../emu-harness/README.md) ·
phase manual = emu-harness `PHASES.md` · hardware → [TIA (2600)](../../../research/atari-2600/tia-reference.md) ·
precedent → [Elite](../elite/README.md) (`verify_rom.py`) · project SDK → [projects/CLAUDE.md](../../CLAUDE.md)

## Where things stand (checked 2026-10-27)

| Title | What the chapters were built from | Harness |
|---|---|---|
| Adventure (2600) | commented disassembly, `raw/adventure.asm` (2,796 lines) | none |
| Mappy (Famicom) | the Japan ROM + the published disassembly | **all nine phases done** (`mappy/re-roadmap.toml`); discovery recall 100.0% (10,754/10,754 bytes) |
| Utopia (Intellivision) | original CP1610 source, `utopia/source/utopia.asm` (4,075 lines) | none |
| M.U.L.E. (Atari 800) | a **disassembly**, not original source: `mule/source/mule.asm` (49,981 lines) | none |

Mappy went through the harness only because `machines/nes` already existed.

## Decision 1: one repo per title once it has a harness pass

The harness has already settled this. Its `CLAUDE.md` says game adapters (RAM maps, goals, oracles) live
in **each game's own repo**, and every other harness title follows that (`*-decompiler`, `UW-decompile`,
`elite-decompiler`). Mappy is the exception: it is **61 of the 95 tracked files** in `game-annotation`,
while the other three titles are still chapters plus a source file.

- **Per-title repo:** holds the harness work (roadmap, labels, tools, listing). Mappy moves out first.
- **`game-annotation`:** keeps the chapters and the comparisons between titles, which are what it
  delivers. It links to each title's repo.
- **No empty repos.** Create a title's repo when its harness pass starts, not before.

## Decision 2: each title fills one plug-in slot

The harness keeps backends (emulators), machines (consoles) and CPUs as independent plug-ins. Each new
title is a question of which slot it fills:

| Title | CPU | Machine | Emulator | What it tests |
|---|---|---|---|---|
| **Adventure** | `m6502` reused (the 6507 is a cut-down 6502) | new `atari2600`: TIA + RIOT, 4 KB, no bank switching | BizHawk has a 2600 core. As far as we know Mesen 2 doesn't support the 2600 (check). | A second machine on a CPU we already support. It also pays the known debt in the harness `CLAUDE.md`: BizHawk needs a real Python client, and the shared contract moves into `core/`. |
| **Utopia** | **new `cp1610`** (10-bit instruction words) | new `intellivision` | BizHawk has an Intellivision core (IntelliHawk) | Whether the CPU slot really is pluggable. Nothing so far has tested that. |
| **M.U.L.E.** | `m6502` reused | new `atari800`. It's a computer that **loads from disk**, so matching the static code to what actually runs isn't free like it is on a cartridge. | Open. We don't think BizHawk covers the Atari 8-bit computers; Altirra is the usual reference. | A disk-loaded computer instead of a cartridge console. |

**Order:** Adventure (cheapest, pays down a debt), then Utopia (the CPU question), then M.U.L.E. (emulator
still unchosen).

## Method carried over from Mappy

1. **Byte-check the source against the ROM first.** Assemble the existing source/disassembly and compare
   it to the dump, the way `elite-decompiler/tools/verify_rom.py` does. Until that passes, the source is
   only a claim about the binary.
2. **The source is the grader, not the input.** Run the phases cold on the ROM, then score recall against
   the source afterwards. This is how Mappy's discovery gate was scored.
3. **Expect the phase manual to change.** The asset phase was written for the NES PPU. On the 2600 the
   display *is* code (the kernel draws in step with the TV beam), so the phase manual needs a 2600
   version of that phase.

## Next actions
- [ ] Chris: get ROM dumps for Adventure, Utopia and M.U.L.E. (the M.U.L.E. dump will be a disk image)
- [ ] Split `mappy/` out of `game-annotation` into its own repo (`/new-project`), leaving the chapters linked
- [ ] Adventure: classify + recon, starting with the assemble-and-compare check

## Open Questions
- Does any BizHawk core (or other scriptable emulator) cover the Atari 800 well enough for lockstep RAM traces? Altirra's scripting surface is unknown.
- Does Mesen 2 really have no 2600 core? Check the installed version before choosing a backend.
- Does the Utopia source assemble to the shipped cartridge byte-for-byte, or is it a pre-release build?

## Tags
[atari-2600](../../../tags/atari-2600.md) · [6502](../../../tags/6502.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [tools](../../../tags/tools.md) · [games](../../../tags/games.md)
