# mmc1
> Files about Nintendo's MMC1 mapper (and its board variants: SNROM/SOROM/SUROM/SXROM) — the most common bank-switching ASIC on NES cartridges, with serial-write configuration and 5 registers selected by address range.

- [Mappers Reference](../research/nes/mappers-reference.md) — overview of MMC1 alongside NROM, MMC3, MMC5, and others
- [Nobunaga's Ambition (NES)](../projects/game-annotation/nobunaga/README.md) — 256 KB MMC1 (SOROM variant with 8 KB battery PRG-RAM)
  - [Ch 1: Boot, Vectors, and the BRK Dispatcher](../projects/game-annotation/nobunaga/01-boot-and-dispatch.md) — full MMC1 init sequence traced (control = $0E, 5-write serial commit pattern, $STA $FFF0 idiom for PRG bank register)
