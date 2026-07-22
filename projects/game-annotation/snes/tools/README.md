---
status: active
created: 2026-07-21
---
# SNES system tools — `snes-decompiler`

> The **target-agnostic** substrate for taking apart *any* SNES cart: 65C816, LoROM/HiROM detection,
> PPU modes, SPC700. KOEI-specific tooling lives in [koei/](../../koei/README.md).

**Links:** system → [SNES](../README.md) · KOEI toolchain → [koei/](../../koei/README.md) ·
method → [Breaking Down an SNES Cart](../../../../research/gaming/snes-cartridge-teardown.md)

## Identity

| Field | Value |
|-------|-------|
| Logical name | `snes-decompiler` |
| GitHub | `github.com/chrisaacson69/snes-decompiler` *(local, not yet created/pushed)* |
| Sibling path | `../snes-decompiler` (resolved via `.claude/local-paths.md`) |
| Entry point | `CONTEXT.md` → the vault teardown page → `tools/` |
| Depends on | the SNESdev Wiki (grounding); no shared code lib |
| Used by | `koei-snes`, and thence the SNES title repos |

⚠️ **Not on GitHub and not cloned here** (2026-07-21) — this one exists only as a local working copy on
some machine. Highest-risk item in the ecosystem: it has no remote to recover from.

## Status

- ✅ `tools/mapper.py` — LoROM/HiROM/ExHiROM offset↔address + `.smc` copier stripping (self-tested)
- ✅ `tools/header_parse.py` — mapping auto-detect + header dump + RESET entry point (self-tested, then
  **validated on a real commercial cart**)
- ⬜ Gating tool: a 65C816 (M/X-width-aware) disassembler

## Tags
[snes](../../../../tags/snes.md) · [65816](../../../../tags/65816.md) · [reverse-engineering](../../../../tags/reverse-engineering.md)
