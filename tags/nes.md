# nes
> Files about the Nintendo Entertainment System / Famicom — 2A03, PPU (2C02), APU, mappers, and the games written for them.

- [NES Research](../research/nes/README.md) — platform overview; 2A03 vs 6507 comparison; the storytelling-vs-logic axis
- [PPU Reference](../research/nes/ppu-reference.md) — Picture Processing Unit (Ricoh 2C02): registers, NMI, OAM, scrolling, frame timing
- [APU Reference](../research/nes/apu-reference.md) — Audio Processing Unit: 5 channels, envelope/sweep/length-counter autonomy
- [Mappers Reference](../research/nes/mappers-reference.md) — NROM through MMC5; what cartridge logic enables
- [Mappy (Famicom/NES)](../projects/game-annotation/mappy/README.md) — Namco, 1984; NROM-128
  - [Reset & Frame Structure](../projects/game-annotation/mappy/01-reset-and-frame-structure.md) — NMI vs WSYNC, the canonical NES main-loop pattern
  - [Object Records & States](../projects/game-annotation/mappy/02-object-records-and-states.md) — 16-byte records, 23-state machine via word-table indirect jump
  - [PPU Pipeline & Background-as-Sprites](../projects/game-annotation/mappy/03-ppu-pipeline.md) — OAMDMA, dual buffers, the joypad's seven footguns, garbage NOPs as audio safeguards
  - [Trampolines & Physics](../projects/game-annotation/mappy/04-trampolines-and-physics.md) — bounce as 6-state machine, asymmetric mechanic in 3 instructions
  - [Cat AI & Doors as Weapons](../projects/game-annotation/mappy/05-cat-ai.md) — fat cat hides in items, multi-cat combo, byte-meaning dispatcher
  - [Game State & Mode Orchestration](../projects/game-annotation/mappy/06-game-state.md) — demo IS the game, 16 rounds in 64 bytes, Pac-Man lineage
  - [Music & Sound Engine](../projects/game-annotation/mappy/07-music-engine.md) — 25-voice mixer; engine is small because the chip is large
  - [Level Data & Bonus Rounds](../projects/game-annotation/mappy/08-level-data-and-bonus-rounds.md) — layered level data, mansion-as-nametable, engine-vs-content separation
- [Nobunaga's Ambition (NES)](../projects/game-annotation/nobunaga/README.md) — Koei, 1989; MMC1/SOROM 256 KB; solo deep-dive
  - [Ch 1: Boot, Vectors, and the BRK Dispatcher](../projects/game-annotation/nobunaga/01-boot-and-dispatch.md) — 23-entry software-task table at $C173, bytecode-VM hypothesis
  - [Ch 2: Zero-Page Memory Map](../projects/game-annotation/nobunaga/02-zero-page-map.md) — shared pointer pool at $00-$0F; byte-meaning-by-context at $68/$69 and $83-$86; ZP-shadow pair $90-$AF/$0700-$071F
