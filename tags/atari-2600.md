# atari-2600
> Files about the Atari 2600 / VCS — TIA, RIOT, 6507, beam racing, and the games written for it.

- [TIA Reference](../research/atari-2600/tia-reference.md) — Television Interface Adaptor specs needed to read 2600 source code
- [Adventure (Atari 2600)](../projects/game-annotation/adventure/README.md) — Warren Robinett, 1980; the canonical 4 KB action-adventure
  - [Memory Map](../projects/game-annotation/adventure/01-memory-map.md) — 128-byte RAM organization; 9-byte object records
  - [Display Kernel](../projects/game-annotation/adventure/02-display-kernel.md) — beam racing, VDEL01 double-buffer, two-line iterations
  - [Sprite Multiplexing](../projects/game-annotation/adventure/03-sprite-multiplexing.md) — man-as-ball, inter-frame rotation, per-frame TIA reconfiguration
  - [Movement & Collision](../projects/game-annotation/adventure/04-movement-collision.md) — TIA hardware collisions; TIA-names-as-offsets trick
  - [Bat AI](../projects/game-annotation/adventure/05-bat-ai.md) — shared AI engine, priority matrices, Fed-Up timer
  - [Dragon State Machine](../projects/game-annotation/adventure/06-dragon-state-machine.md) — chase/flee via slot order, difficulty as starting state
  - [Room Graph](../projects/game-annotation/adventure/07-room-graph.md) — 31 rooms, 3 game variants in 24 bytes
  - [The Easter Egg](../projects/game-annotation/adventure/08-easter-egg.md) — Robinett's signature; origin of the term
