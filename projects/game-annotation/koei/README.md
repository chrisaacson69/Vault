---
status: active
created: 2026-07-21
---
# KOEI tools — the shared engine toolchain

> **Tools node, not a title index.** One studio, one bytecode-VM engine lineage, two consoles. What
> lives here is the **toolchain and the reversed engine knowledge** shared across every KOEI target.
> The titles themselves are filed under the console they run on: [nes/](../nes/README.md) ·
> [snes/](../snes/README.md).

**Links:** series hub → [Game Annotation](../README.md) · project SDK → [projects/CLAUDE.md](../../CLAUDE.md) ·
theses → [KOEI's portable VM](../../../research/gaming/koei-snes-portable-vm.md),
[AI & combat evolution — a five-decompiler study](../../../research/gaming/koei-ai-combat-evolution.md),
[The Rosetta Stone Method](../../../method/rosetta-stone-method.md)

## Why the tools get their own node

The family axis and the system axis **cross**. The engine is one thing carried across two consoles, so
filing the toolchain under either NES or SNES would split it — and would strand the finding that only
exists *because* both sides were reversed. Per
[Author Web, Derive Hierarchy](../../../method/author-web-derive-hierarchy.md): keep the crossing edge
as a link; don't pick a branch and cut the other.

**A new title is a profile, not a new toolchain.** That is the whole design — and it's why the walk
skills bind to *this* node rather than to any one repo.

## `koei-nes` — the Famicom engine layer

| Field | Value |
|-------|-------|
| Logical name | `koei-nes` *(private)* · `github.com/chrisaacson69/koei-nes` |
| Sibling path | `../koei-nes` (resolved via `.claude/local-paths.md`) |
| Layout | `assets/` · `docs/` · `tools/` |
| Depends on | `nes-render` (generic render core) |
| Used by | all seven NES title repos → [nes/](../nes/README.md) |

Toolchain: the **`koeivm/` package** — `cpu6502.py`, `dream.py` (goto-free structuring),
`gates/cfg_gate.py` + `gates/stack_audit.py` (the deterministic guards), `cli/decompile_all.py` /
`cli/decompile_merged.py` — plus `data_xref.py`, `disasm6502.py`, `dump_data.py`,
`RECORD_SCHEMAS.md`, and **`games.toml`** (the per-title profile registry).

## `koei-snes` — the 16-bit sibling

| Field | Value |
|-------|-------|
| Logical name | `koei-snes` *(public)* · `github.com/chrisaacson69/koei-snes` |
| Sibling path | `../koei-snes` |
| Depends on | `snes-decompiler` (generic teardown substrate) |
| Used by | the SNES title repos → [snes/](../snes/README.md) |

Title-agnostic, profile-driven via its own `games.toml`: `vm_disasm` / `vm_walk` / `vm_opcodes` /
`syscall_probe` / `native_floor`, plus the tools promoted during the ROTK2 SNES reversal —
`data_walk` / `gen_mlb` / `gen_source` / `vm_lift` / `vm_struct`.

**Engine fully reversed:** native kernel (bank `$00`, `$800C–$B20A`), 256-entry VM (218 named opcodes +
47 extended 32-bit ops), the 69-syscall hardware ABI, and the resource-archive loader — all decoded
from ROM and cross-checked against the NES.

## The portable-VM finding (why both sides were worth doing)

Reversing the same engine on both consoles makes **each the other's oracle**:

- VM opcodes **byte-for-byte identical** (NES 219 / SNES 218)
- Same resident-library + command-app architecture; bank→overlay is a hardware-forced mechanism swap
- **Province record stride 25 on both**; the lone data change is the officer record 21→34
- 69 vs ~31 syscalls — the SNES delta is DMA / Mode 7 / SPC700, i.e. a **faithful port + facelift**

The bytecode targets a virtual address space behind a stable syscall ABI: **architecture-agnostic by
design.** The cross-check even caught a stale "49×24" NES memory that actually belonged to NA1's fiefs.

## Method — the pipelines bound to this toolchain

`/label-walk` (subs) · `/data-walk` (ROM tables, RAM vars) · `/var-walk` (frame slots) ·
`/nobunaga` (the NA1 tool surface). All are the same multi-pass shape — **scan → symbol-table → link →
typecheck** — over a `mesen-labels.toml` symbol table, with a deterministic regen guard gating writes.

⚠️ **Known defect (2026-07-21):** the three walk skills hardcode
`PROJ = C:\Users\Chris.Isaacson\Vault\projects\game-annotation\nobunaga` — an old machine's username,
and a path the project left in June 2026. A family-level skill was forced to name one member, so it
named one, and it rotted. The fix is a **member argument resolved via `.claude/local-paths.md`**, not a
replacement constant.

⚠️ **Neither engine repo is cloned on this machine** (2026-07-21).

## Tags
[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [snes](../../../tags/snes.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [games](../../../tags/games.md)
