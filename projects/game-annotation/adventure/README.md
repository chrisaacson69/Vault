---
status: active
created: 2026-04-26
---
# Adventure (Atari 2600)
> Warren Robinett, 1980. 4 KB ROM, 128 bytes RAM, no frame buffer. The first console action-adventure, the first famous Easter egg, and a master class in fitting a world into nothing.

**Links:** [Game Annotation Series](../README.md), source: [`raw/adventure.asm`](../../../raw/adventure.asm)

## Why Adventure first

- **Tractable size.** ~2,800 lines of assembly, one ROM bank, no mappers.
- **Rich for its size.** 30 rooms, 3 castles, a maze, 4 enemies (3 dragons + bat), 8 carryable objects, 3 difficulty levels, an Easter egg.
- **Famous tricks worth explaining.**
  - Sprite multiplexing on a system that natively shows two players.
  - The bat as a roving disturber — pickup priority list, target switching.
  - The dragon state machine — idle, chase, attack, dead, *eaten-you*.
  - Robinett's hidden room (the first signed Easter egg in a commercial game).
- **Existing source is well-labeled.** `raw/adventure.asm` has meaningful subroutine names and per-line literal comments. Our work is the layer above: data structures, control flow at the system level, design intent.

## Source

`raw/adventure.asm` — rehosted from [johnidm/asm-atari-2600](https://github.com/johnidm/asm-atari-2600/blob/master/adventure.asm). Traceable to the canonical commented disassembly tradition (Joel D. Park's reconstruction of Robinett's source). DASM-compatible. ORG starts at `$F000`.

## Chapters

1. [Memory map](./01-memory-map.md) — every zero-page variable, what it means
2. [Display kernel](./02-display-kernel.md) — how `PrintDisplay` draws a frame under the beam, beam racing on a 6507 with no interrupts
3. [Sprite multiplexing](./03-sprite-multiplexing.md) — squeezing many visible objects out of 2 hardware sprites via inter-frame rotation, the man-as-ball trick, and per-frame TIA reconfiguration
4. [Movement & collision](./04-movement-collision.md) — TIA hardware does the geometry; the engine just reads the latches. Plus the `INC VBLANK,X` field-offset trick.
5. [The bat AI](./05-bat-ai.md) — strict priority list (Chalice > Sword > Bridge > Keys > Dragons > Magnet), 4-second Fed-Up timer, shared AI engine with the dragons, steal-on-overlap. The TIA-names-as-offsets trick extends to all 7 bytes of the bat's record.
6. [The dragon state machine](./06-dragon-state-machine.md) — three dragons share one engine; matrix slot order encodes chase vs flee with no extra bits; difficulty is *literally* the starting value of the bite countdown.
7. [Room graph & level differences](./07-room-graph.md) — 31 rooms, 4-way adjacency, three game variants encoded in 24 bytes via `$80`-flagged adjacency entries and `RoomDiffs`. Same 9-byte record format as the object table.
8. [The Easter egg](./08-easter-egg.md) — Object #4 at line 2511, gated by 8 instructions, origin of the term "Easter egg" in software. The architectural consistency that made it survive QA.

## LLM-interpretation log

Each chapter ends with notes on where reading the source alone was sufficient versus where the model had to consult external knowledge (TIA register semantics, the undocumented `SBC` carry trick, etc.). This is the data for the meta-question in the [series README](../README.md).

## Tags

[6502](../../../tags/6502.md) · [atari-2600](../../../tags/atari-2600.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md)
