---
status: active
created: 2026-07-08
---
# KOEI's portable VM, proven from both sides — the SNES ROTK2 reversal

> The first KOEI **SNES** title reverse-engineered (Romance of the Three Kingdoms II, 1990/SNES),
> decoded independently of its NES twin and then **compared**. The payoff: KOEI's strategy engine is a
> genuinely **portable bytecode VM** — same instruction set carried across two consoles — and the SNES
> release is a **faithful port + facelift**, not a mechanics rewrite. Reversing the VM from *both* sides
> of a port makes each reconstruction the other's oracle.

**Links:** [How KOEI's NES AI & combat evolved](./koei-ai-combat-evolution.md) (the five-decompiler NES
study this extends to the SNES line) · [SNES cartridge teardown](./snes-cartridge-teardown.md) (the
method entry point) · [L'Empereur — the two-tier turn](./lempereur-two-tier-turn.md) · [DREAM goto-free
structuring](../reverse-engineering/dream-goto-free-structuring.md) (the decompiler-output experiment) ·
[The Rosetta Stone Method](../../method/rosetta-stone-method.md) (the meta-lesson: this corpus is a
hardware-learning stone).
Code: sibling repos `koei-snes` (shared SNES engine, the SNES sibling of `koei-nes`), `snes-decompiler`
(65C816/hardware substrate), `rot3k2-snes-decompiler` (the title).

## What was built
Full reversal of the KOEI SNES engine + game: **512 named bytecode routines across 10 code modules**
(root 146, comroot=AI 117, settei 82, kisetsu 75, excsub1-6 = 92 event scripts), 218 opcodes named,
69 syscalls mapped, ~238 strings of game text recovered, layered `.src` source, and a **Mesen `.mlb`**
(484 labels). Two decompiler-output experiments kept: a **C lift** (bytecode→pseudo-C) and a
**DREAM-style structurer** (65-75% of routines already goto-less from conditional structuring alone).

## The architecture (SNES)
- **Bytecode VM** in WRAM over a native kernel in bank `$00`; a 22-byte-param-block syscall ABI.
- **WRAM overlay slots** replace NES bank-switching: `root` resident at `$7E:2000`; a `$7200` slot
  time-shares comroot(AI)/settei/kisetsu; a `$C300` slot holds excsub1-6.
- **Three inter-module channels:** control = `call.ind` overlay invocation; state = shared `$F800+`
  globals; code = overlays call **resident root as a shared library** (do_syscall/memcpy/…).
- `cbmdata1`/`sdata` are DATA resources (combat tables, sound), not code.

## Did the mechanics change? No — faithful port + facelift
Cross-checked against the NES `rot3k2-decompiler`:
1. **VM opcodes are byte-for-byte identical** — `$E9` hostcall, `$AC` call, `$DD/$EA` call.ind, `$CF`
   ret, `$D5/$D9` switch, `$D6` jmp, `$D8` brz, `$B7` 32-bit prefix, `$00-3F` frame matrix all at the
   same byte. Counts: NES **219** vs SNES **218**.
2. **Architecture is the same shape** — NES bank-1 strategic library + command-app banks + battle
   library ≡ SNES resident root + overlay command-apps. Bank-per-app → overlay-per-app is a
   hardware-forced *mechanism* swap over an identical design.
3. **Data model mostly identical** — province record **stride 25 on both** (41 provinces); the one real
   change is the **officer record growing 21→34 bytes** (34 = the NES *ruler* stride).
4. **Where the effort went:** the facelift — **69 SNES syscalls vs ~31 NES** (DMA, Mode 7, byte-plane
   VRAM, SPC700). Presentation was rebuilt; the strategy brain was ported.

Why it holds: the bytecode targets a **virtual 16-bit address space + stable syscall ABI**; all
memory-architecture difference (banking vs overlays) is pushed into the native kernel and a couple of
dispatch syscalls. The bytecode is architecture-agnostic *by design* — which is exactly why the opcode
numbers line up. Dead code (unreached blocks) is the fingerprint of recompiling shared source for a
richer kernel (e.g. a manual `num_to_ascii` left in but bypassed by a display syscall).

## Method note
"Compare, don't derive" — decoded each SNES handler on its own, used the NES only as a cross-check.
Because both sides were reconstructed independently, the byte-for-byte opcode match and stride-25
province match are *confirmations*, and even caught a stale NES memory (the old "49×24" was NA1's fief
schema, not ROTK2). The `koei-snes` toolchain is profile-driven and transferred to new modules with
zero changes — the compounding-through-reuse thesis, now demonstrated across an architecture boundary.

## Roadmap
Next cross-gen twins: **Gemfire** (NES side already done & public — a direct repeat of this experiment)
and **Uncharted Waters** (the genre swerve — trade/exploration, the real test of whether the VM is a
*general* game engine, not strategy-specific). After: **pure SNES titles** — do they finally spend the
kernel's teeth (Mode 7, SPC700) once they're not porting? The portable VM is the fixed baseline against
which KOEI's ambition (PTO landing, Operation Europe over-reaching) can be read directly.

## Tags
[reverse-engineering](../../tags/reverse-engineering.md) · [snes](../../tags/snes.md) · [koei](../../tags/koei.md) · [game-design](../../tags/game-design.md)
