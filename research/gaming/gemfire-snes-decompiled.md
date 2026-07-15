---
status: active
created: 2026-07-10
---
# Gemfire (SNES) fully decompiled — the 2nd KOEI SNES title, engine to application

> The **2nd KOEI SNES title reverse-engineered** (Gemfire, 1992/SNES), taken all the way down: the
> shared bytecode VM, 82 syscalls, the native kernel, ~773 game strings, and **all 591 bytecode
> routines across 11 WRAM overlay modules — every symbol named**. Repeating the ROTK2-SNES experiment
> on a second title did what a second pass is *for*: it surfaced a systematic error in the first.

**Links:** [KOEI's portable VM, proven from both sides](./koei-snes-portable-vm.md) (the ROTK2-SNES
experiment this repeats) · [SNES cartridge teardown](./snes-cartridge-teardown.md) (method entry) ·
[L'Empereur — the two-tier turn](./lempereur-two-tier-turn.md) (the NES `$E2E3` trampoline this
generalizes) · [KOEI AI/combat evolution](./koei-ai-combat-evolution.md) · method →
[The Rosetta Stone Method](../../method/rosetta-stone-method.md).
Code: `Gemfire-snes-decompiler` (title), `koei-snes` (shared engine), `snes-decompiler` (CPU substrate).

## The architecture, confirmed a third way
Gemfire is the same **portable bytecode VM** (byte-identical opcode numbers to ROTK2) running WRAM
**overlay modules** over a resident native kernel. What this decomposition added:

- **Per-routine native trampoline (the key structural finding).** `call.n` does **not** set the VM PC
  — it `JML`s natively to `$7E:target`, where each bytecode routine is prefixed by `JSR $3287` (the
  module launcher) + a 2-byte inline param. The launcher reads the param, sets the PC to `target+5`,
  and re-enters the VM. So a routine's call target points at a **native stub**; the bytecode body is at
  `+5`. This is the SNES cousin of L'Empereur's NES `$E2E3` native-call trampoline — a **shared KOEI
  convention**, now profile-driven (`routine_sig`/`routine_body_offset`) so one walker handles both
  titles (ROTK2 = `JSR $23E6`/offset that its own decompiler had missed).

## The module map — a shared library + mode overlays
`root` is the resident **shared library** (146 routines: UI, records, print, dispatch); the overlays are
thin mode-specific handlers that compose it. All bytecode (0 kernel-resident) lives in these 11 modules:

| Module | Routines | Role |
|---|---:|---|
| root | 146 | resident library — `main`, `call_overlay`, `print_string`, record accessors, `draw_*` |
| command | 28 | field-turn command menu |
| comusr1 / comusr2 | 31 / 31 | user actions — war+domestic+system / diplomacy+personnel+items |
| **comcmp** | 40 | **the strategic AI** — assess allegiances → score vs ROM weight tables → dispatch → execute |
| settei | 20 | new-game setup (scenario / family / advisor) |
| event | 63 | calendar/turn engine + story events + 5 seasonal disasters |
| senzen / sensou / sengo | 31 / 136 / 45 | pre-battle deploy / **battle engine** / post-battle resolution |
| ending | 20 | victory cutscene player |

**Data model** (back-inferred by data-walk): `lord_table $C331` (stride 36), `unit_table $C0B1`,
`castle_table $C039`, `battle_troops $C795`, `active_lord_ids $C773`; `game_state_flag $C771`,
`cur_month $C007`; AI `allegiance_table $FDAA` + `decision_slots $FDD0`; `battle_grid $FF00`. ROM:
AI weights `$8056`/dispatch `$8066`, combat strength `$A862`, 5×5 range templates `$AAD8`.

## The payoff: the second pass caught the first's mistake
Comparing the independently-named `root` against ROTK2-SNES's, only the low-level **primitives** matched
byte-for-byte (record accessors, `do_syscall`, `num_to_ascii`) — root's *application* logic is
title-specific, exactly the portable-VM thesis. But the compare **validated the derivation and exposed
a systematic bug in ROTK2's decompiler**: it walked at offset 0, decoding each routine's 5-byte
trampoline as bytecode, so its names were mis-shifted (`rec_ptr_F424` is actually a `rec_idx`;
`calc32_2459` has no 32-bit ops). Backporting the trampoline profile makes ROTK2 walk 180 routines
cleanly — **and ROTK2 was then re-walked in full** (all 26 code modules, ~1,316 routines, incl. the
hex tactical engine + 13 sub-overlays that had *never* been decompiled; 4 data blobs documented). The
offset-0 damage varied severe (comroot/AI: 110 corrections + 67 undiscovered routines) to none — you
cannot tell which without re-walking. This is **"accumulated state IS the verification layer"** made
concrete: doing the walk a second time is how the errors surface.

## The layered source — the deliverable both titles now ship
The symbol tables were the hard part; with them, the readable **source** falls out in three layers,
mirroring how the program is built: **assembly** (`native.asm` — the native 65C816 kernel/VM engine),
**bytecode** (`<module>.src` — per-module labelled listing, `call.n`/`hostcall`/immediates resolved
by name), and **C** (`<module>.c` — the register-machine lifted to expressions). Gemfire ships 11
modules + `native.asm`; ROTK2 ships 29 + `native.asm` (its stale offset-0 `.src` regenerated). One
driver — `koei-snes/tools/gen_layers.py` — produces all of it, reading each module's ROM location and
WRAM base **from the ROM's own `$00:F800` resource archive** (16-byte `[name][bank][addr][len]`
entries + the module's `JMP base+3` header) rather than any hand-kept table: the manifest is derived
from ground truth, so it can't drift, and the same driver ports to every future KOEI SNES title. (It
also re-proved `cbmdata1` is *data* — 0 trampolines in the blob — not the "194 routines" the pre-fix
tools imagined.)

## The syscall delta (Gemfire vs ROTK2-SNES)
82 syscalls vs 69 — the ~13 additions are almost entirely a **battle-animation / window-effect** layer
(`sys_effect_request`/`_place`, scroll-path builders, `WBGLOG/WOBJLOG` window logic, HDMA windows),
matching the archive's `sntanm1-5`/`sendisp` battle-anime blobs. The strategy brain is the shared VM;
the additions are facelift — the portable-VM thesis holding at the syscall level too.

## Tags
[reverse-engineering](../../tags/reverse-engineering.md) · [snes](../../tags/snes.md) · [koei](../../tags/koei.md) · [game-design](../../tags/game-design.md)
