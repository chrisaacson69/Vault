---
status: active
created: 2026-07-07
---
# SNES — system node

> The 65C816 substrate and the titles decompiled on it. Sibling of [nes/](../nes/README.md). The shared
> KOEI toolchain lives in [koei/](../koei/README.md), because the engine spans both consoles.

**Links:** series hub → [Game Annotation](../README.md) · toolchain → [KOEI tools](../koei/README.md) ·
system tools → [snes/tools](./tools/README.md) · project SDK → [projects/CLAUDE.md](../../CLAUDE.md) ·
method → [Breaking Down an SNES Cart](../../../research/gaming/snes-cartridge-teardown.md)

## The three layers

```
snes-decompiler     generic teardown substrate      ← target-agnostic   → tools/
   ↑
koei-snes           KOEI SNES VM engine layer       ← family-specific   → ../koei/
   ↑
<title>-decompiler  per-title decompilation                             → below
```

## Titles

| Folder | Repo | Cart | Status |
|---|---|---|---|
| [rot3k2-snes/](./rot3k2-snes/README.md) | `rot3k2-snes-decompiler` | ROTK2 (USA), LoROM 1 MiB, SRAM 32 KiB | ✅ complete — ~1,316 routines across 26 modules |
| [gemfire-snes/](./gemfire-snes/README.md) | `Gemfire-snes-decompiler` | Gemfire (USA), LoROM 1 MiB, SRAM 8 KiB | ✅ complete — 591 routines across 11 overlay modules |
| _(no folder yet)_ | `na1-snes-decompiler` | NA1 (USA), **HiROM** 512 KiB, SRAM 8 KiB | 🔬 recon+ — **the engine exception: no bytecode VM.** Compiled straight to native 65C816 instead of the shared VM, so the koei-snes VM tools do not apply; needs a native 65816→C decompiler. See [na1-snes-native-port](../../../research/gaming/na1-snes-native-port.md). |

⚠️ **rot3k2-snes and gemfire-snes are not cloned on this machine** (2026-07-21) — see `.claude/local-paths.md`.

Both titles also shipped on NES, which is what makes this node the *other half* of the portable-VM
proof: [rot3k2](../nes/rot3k2/README.md) and [gemfire](../nes/gemfire/README.md) are their oracles.

## Why NES and SNES are separate nodes

The NES work reused one 6502 + a few mappers across seven titles. The SNES **forces re-detection per
cart** — mapping, CPU width, coprocessors — and needs a different (M/X-width-aware) disassembler. So
this is its own substrate package, not a leaf of `koei-nes`. See the teardown page's
architecture-break table.

What the two consoles *share* is the KOEI engine, and that shared part is deliberately filed neither
here nor under NES but in [koei/](../koei/README.md).

## Tags
[snes](../../../tags/snes.md) · [65816](../../../tags/65816.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [assembly](../../../tags/assembly.md) · [games](../../../tags/games.md)
