# nobunagas-ambition
> Files about Koei's *Nobunaga's Ambition* (NES, 1989 US release) — 256 KB MMC1/SOROM strategy cartridge; the solo deep-dive of the game-annotation series.

- [Nobunaga's Ambition (NES) project](../projects/game-annotation/nobunaga/README.md) — project README with cartridge facts and chapter map
  - [Ch 1: Boot, Vectors, and the BRK Dispatcher](../projects/game-annotation/nobunaga/01-boot-and-dispatch.md) — iNES header decode, reset/NMI/IRQ trace, 23-entry BRK software-task dispatcher at $C173, bytecode-VM hypothesis
  - [Ch 2: Zero-Page Memory Map](../projects/game-annotation/nobunaga/02-zero-page-map.md) — full ZP map from harvested disassembly; shared scratch-pointer pool at $00-$0F; byte-meaning-by-context at $68/$69 and $83-$86; parallel buffers at $0090-$00AF + $0700-$071F
