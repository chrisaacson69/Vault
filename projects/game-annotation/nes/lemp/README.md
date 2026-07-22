---
status: active
created: 2026-07-21
---
# L'Empereur (NES, 1991)

> **Game 8** in the KOEI NES decompiler family. Read as a *transitional* specimen — same family engine,
> but the **country→province two-tier turn** that the 16-bit titles keep.

**Links:** system → [NES](../README.md) · toolchain → [KOEI tools](../../koei/README.md) ·
thesis → [L'Empereur — the two-tier turn (NES→SNES design hinge)](../../../../research/gaming/lempereur-two-tier-turn.md)

## Identity

| Field | Value |
|-------|-------|
| Logical name | `LEmp-decompiler` *(public)* · `github.com/chrisaacson69/LEmp-decompiler` |
| Sibling path | `../LEmp-decompiler` (resolved via `.claude/local-paths.md`) |
| Status | ✅ **all 18 code banks named, 0 errors**; docs + symbol table, no ROM |
| Engine | NA2-era VM, **GemFire-era syscalls** |
| Depends on | `koei-nes` → `nes-render` |

⚠️ **Not cloned on this machine** (2026-07-21).

## What it contributed

- **The `$E2E3` native-call trampoline** — a native ABI callable *from bytecode*. The headline engine
  finding, and the NES-side cousin of the per-routine trampolines later found on SNES.
- **The two-tier turn.** Bank 1 runs two loops: 15 countries via order-table `$6FF2` → `sub_8039`,
  then 46 cities via `$7002` → `sub_80C0`; the AI mirrors it in `ai_run_country_turn`. This is the
  structural shape the 16-bit titles inherit — hence "design hinge".
- Tax simplified to a policy-flag command; officer-holds-army retained since ROTK1.
- **1790 base year** — the revolutionary run-up, not just the famous wars.

## Tags
[nes](../../../../tags/nes.md) · [6502](../../../../tags/6502.md) · [reverse-engineering](../../../../tags/reverse-engineering.md) · [games](../../../../tags/games.md)
