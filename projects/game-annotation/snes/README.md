---
status: active
created: 2026-07-07
---
# SNES teardown — `snes-decompiler`

> Pointer page (process-table entry) for the SNES reverse-engineering substrate. A **new architecture
> family** alongside the NES KOEI line — 65C816, LoROM/HiROM, PPU modes, SPC700 — target-agnostic for now.

**Links:** the method → [Breaking Down an SNES Cart](../../../research/gaming/snes-cartridge-teardown.md) ·
the NES siblings → [game-annotation series](../README.md) · project SDK → [projects/CLAUDE.md](../../CLAUDE.md).

## Identity (resolve by logical name, never hardcode a path)

| Field | Value |
|-------|-------|
| Logical name | `snes-decompiler` |
| GitHub | `github.com/chrisaacson69/snes-decompiler` *(local, not yet created/pushed)* |
| Sibling path | `../snes-decompiler` (resolved per-machine via vault `.claude/local-paths.md`) |
| Entry point | `CONTEXT.md` → the vault teardown page → `tools/` |
| Depends on | the SNESdev Wiki (grounding); no shared code lib yet |

## Status — substrate live; **first target = ROTK2 SNES, recon #0 done**

- ✅ `tools/mapper.py` — LoROM/HiROM/ExHiROM offset↔address + `.smc` copier stripping (self-tested).
- ✅ `tools/header_parse.py` — mapping auto-detect + header dump + RESET entry point (self-tested, then **validated on a real commercial cart**).
- ✅ **First target chosen: `rot3k2-snes-decompiler`** (ROTK2 USA, SNES). Recon #0 read the ROM cleanly — LoROM, 1 MiB, 32 KiB battery SRAM, RESET `$800C`, plain-ASCII printf text engine (same family as the NES version), command-prompt string table located in bank `$01`. Chosen because KOEI shipped ROTK2 on **both** MMC5 NES and SNES → the fully-decompiled NES [`rot3k2-decompiler`](../nobunaga/README.md) is the oracle (port comparison, not a cold read).
- ⬜ Gating tool: a 65C816 (M/X-width-aware) disassembler from RESET `$800C`. Then string pointer table → command dispatch, record tables (NES schema as hypothesis), classify native-vs-VM.

### Shared engine layer — `koei-snes`

KOEI shipped the same **bytecode-VM engine** across its SNES strategy titles, so it
graduated into **`koei-snes`** (logical name; `../koei-snes`) — the SNES sibling of the
NES `koei-nes` shared engine. It holds the reversed VM + native kernel knowledge and the
title-agnostic toolchain (`vm_disasm`/`vm_walk`/`vm_opcodes`/`syscall_probe`/`native_floor`,
profile-driven via `games.toml`), plus the opcode reference and the
[NES-vs-SNES comparison](../../../research/gaming/snes-cartridge-teardown.md). Depends on
`snes-decompiler`; the title repos depend on it. **Engine fully reversed:** native kernel
(bank $00, `$800C-$B20A`), 256-entry VM (218 named opcodes + 47 extended 32-bit ops), the
69-syscall hardware ABI, the resource-archive loader — all decoded from the ROM and
cross-checked against the NES.

### Targets

| Target | Repo (logical name) | Cart | Status |
|--------|--------------------|------|--------|
| ROTK2 SNES | `rot3k2-snes-decompiler` | ROTK2 (USA), LoROM 1 MiB, SRAM 32 KiB | ✅ **RE-WALKED & COMPLETE** — the Gemfire pass exposed an offset-0 walker bug (decoded each routine's 5-byte `JSR $23E6` trampoline as bytecode → mis-shifted/mis-keyed names). Trampoline profile backported + **all 26 code modules re-walked: ~1,316 bytecode routines named** (strategic core + AI + the hex tactical engine & its 13 sub-overlays, which were never decompiled before + endgame), 4 data blobs documented. Damage ranged severe (comroot/AI: 110 corrections) to none. Old files kept as `*.offset0-backup.toml`. |
| **Gemfire SNES** | `Gemfire-snes-decompiler` | Gemfire (USA), LoROM 1 MiB, SRAM 8 KiB, RESET $800F | ✅ **COMPLETE** — engine (218+48 opcodes, 82 syscalls, 88 native routines) + **all 591 bytecode routines named across 11 WRAM overlay modules** (root+command+comusr1/2+comcmp-AI+settei+event+senzen/sensou/sengo+ending) + data-walk. Key finding = the per-routine **native `JSR $3287` trampoline** (body at +5), profile-driven. See [research page](../../../research/gaming/gemfire-snes-decompiled.md). |
| **Nobunaga's Ambition SNES** | `na1-snes-decompiler` | NA1 (USA), **HiROM** 512 KiB, SRAM 8 KiB, RESET $8009 | 🔬 **RECON+ — the ENGINE EXCEPTION: no bytecode VM.** First **HiROM** KOEI SNES title, and the one that compiled the C source **straight to native 65C816** instead of to the shared VM (proven 3 ways: no fetch loop, no 256-entry table, native `main`). 60-syscall graphics BIOS @ `$9550`; native 32-bit mul/div lib @ `$C1:F800`; printf text (556 strings). **The koei-snes VM tools do NOT apply** — instead built a native **65816→C decompiler** (`snes-decompiler/tools/native_decompile.py`, reuses the DREAM structurer). See [research page](../../../research/gaming/na1-snes-native-port.md). |

## Why a separate family (not another KOEI-NES entry)

The NES work reused one 6502 + a few mappers across eight titles. The SNES forces re-detection per cart
(mapping, CPU width, coprocessors) and a different disassembler — so this is its own package, not a leaf
of `koei-nes`. See the teardown page's architecture-break table.

## Tags
[snes](../../../tags/snes.md) · [65816](../../../tags/65816.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [assembly](../../../tags/assembly.md) · [games](../../../tags/games.md)
