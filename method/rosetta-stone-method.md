---
status: active
created: 2026-07-08
published: true
layout: layouts/page.njk
title: "The Rosetta Stone Method"
---
# The Rosetta Stone Method
> To learn unfamiliar hardware, don't read the chip manuals first — find a **portable program you already understand running on it**, and let the *known semantics* decode the *unknown silicon*. The same logic across N machines is a Rosetta stone: the known "script" cracks the unknown ones. It inverts the usual order — you know the code, and the code teaches you the hardware.

**Links:** [The Anchor Method](./anchor-method.md) (the known semantics *is* the anchor — a cross-platform crib is a grounding anchor for hardware learning) · [KOEI's portable VM, proven from both sides](../research/gaming/koei-snes-portable-vm.md) (the case study) · [KOEI AI & combat evolution](../research/gaming/koei-ai-combat-evolution.md) (the NES corpus) · [SNES cartridge teardown](../research/gaming/snes-cartridge-teardown.md) · case studies: `rot3k2-decompiler` (NES) + `rot3k2-snes-decompiler` (SNES), `koei-nes`/`koei-snes`.

## The move
Normal order for learning a console: grind the CPU manual, the video chip, the sound chip
first, then read code cold. The Rosetta order flips it:
1. Take a title (or program) whose **logic you already know** from another platform.
2. On the new hardware, **find the interpreter/engine first** — it *has* to be there.
3. **Anchor the unknown against the known**: the opcode table, the syscall/ABI convention,
   the record schemas. Byte-for-byte agreement is a hard checkpoint; divergence is a
   finding, not a failure.
4. **Follow a syscall into the hardware** — the known "draw text" / "play music" semantics
   annotates the unfamiliar video/sound chip for you. The machine reveals itself by being
   pinned to meaning you already carry.

You are never decoding blind, because you always know what the code *must* be doing.

## The precondition (and why it's the real lesson)
This only works if the corpus is a **portable engine** — logic compiled to a machine-
independent target (a bytecode VM) with a per-platform kernel + stable syscall ABI. Then
the "same text, different scripts" property genuinely holds. A studio that **hand-ports
each release in native assembly** gives you N *unrelated* programs — the logic tangled
into each machine, no bilingual anchor. So the method depends on someone else's
**portability discipline**; it's a property of the corpus you exploit, not one you can
manufacture. (KOEI is the exemplar: a bytecode VM whose opcode numbers line up byte-for-
byte across 6502/65C816, only the kernel + syscalls rewritten — see the case study.)

## Relation to the Anchor Method
Same spine, applied to *learning* instead of *building*. The enemy of reversing new
hardware is decoding drift — plausible-but-wrong readings with nothing to check them
against. The known-semantics crib is the **anchor**: every hypothesis about the new chip
must keep satisfying "does this match what the game already does?" The cross-platform
sibling is a *free oracle* — reconstruct both sides and each confirms the other (the SNES
opcode match wasn't assumed, it was a confirmation, and it even caught a stale memory).

## Generality
Any cross-platform engine is a stone: LucasArts **SCUMM**, Infocom's **Z-machine**,
Sierra's **AGI/SCI**, and KOEI's strategy VM. The corpus becomes a **hardware-learning
ladder** — a 68000 (big jump from 6502/65C816) stops being intimidating when you walk in
already knowing the destination. Pick your rungs by *distance*: the same game on the
farthest-apart machines teaches the most, because the constant logic isolates exactly what
the hardware forced to change.

## Tags
[methodology](../tags/methodology.md) · [reverse-engineering](../tags/reverse-engineering.md)
