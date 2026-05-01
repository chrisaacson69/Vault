# nes
> Files about the Nintendo Entertainment System / Famicom — 2A03, PPU (2C02), APU, mappers, and the games written for them.

- [NES Research](../research/nes/README.md) — platform overview; 2A03 vs 6507 comparison; the storytelling-vs-logic axis
- [PPU Reference](../research/nes/ppu-reference.md) — Picture Processing Unit (Ricoh 2C02): registers, NMI, OAM, scrolling, frame timing
- [APU Reference](../research/nes/apu-reference.md) — Audio Processing Unit: 5 channels, envelope/sweep/length-counter autonomy
- [Mappers Reference](../research/nes/mappers-reference.md) — NROM through MMC5; what cartridge logic enables
- [Mappy (Famicom/NES)](../projects/6502-annotation/mappy/README.md) — Namco, 1984; NROM-128
  - [Reset & Frame Structure](../projects/6502-annotation/mappy/01-reset-and-frame-structure.md) — NMI vs WSYNC, the canonical NES main-loop pattern
  - [Object Records & States](../projects/6502-annotation/mappy/02-object-records-and-states.md) — 16-byte records, 23-state machine via word-table indirect jump
  - [PPU Pipeline & Background-as-Sprites](../projects/6502-annotation/mappy/03-ppu-pipeline.md) — OAMDMA, dual buffers, the joypad's seven footguns, garbage NOPs as audio safeguards
  - [Trampolines & Physics](../projects/6502-annotation/mappy/04-trampolines-and-physics.md) — bounce as 6-state machine, asymmetric mechanic in 3 instructions
  - [Cat AI & Doors as Weapons](../projects/6502-annotation/mappy/05-cat-ai.md) — fat cat hides in items, multi-cat combo, byte-meaning dispatcher
  - [Game State & Mode Orchestration](../projects/6502-annotation/mappy/06-game-state.md) — demo IS the game, 16 rounds in 64 bytes, Pac-Man lineage
  - [Music & Sound Engine](../projects/6502-annotation/mappy/07-music-engine.md) — 25-voice mixer; engine is small because the chip is large
  - [Level Data & Bonus Rounds](../projects/6502-annotation/mappy/08-level-data-and-bonus-rounds.md) — layered level data, mansion-as-nametable, engine-vs-content separation
