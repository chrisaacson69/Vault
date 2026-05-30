# `decompiled/` — the engine as a readable codebase

> The "see the whole picture" payoff. Every bytecode subroutine in Nobunaga's
> Ambition, decompiled to readable C. Generated **once**, committed, read like
> source — never re-derived per session (the anti-drift thesis applied to the
> project's most valuable output).

## What's here

| File | Bank | Subs | Notes |
|---|---|---:|---|
| `bank_00.c` | 0 | 98 | boot + bytecode |
| `bank_01.c` | 1 | 131 | **the economy engine** — Grow/Build/Give/Dam/Tax effect handlers (`sub_87F0` = grow, etc.) |
| `bank_02.c` | 2 | 131 | combat + map |
| `bank_15.c` | 15 | 135 | kernel-side bytecode |

**That's the whole engine.** Banks 03–14 are **data** (graphics/maps/text/tables) — 0 bytecode subroutines (verified via the `JSR $E823` stub scan), so there is nothing to decompile there. The 4 files above are the complete bytecode surface: 495 functions, ~11.8k lines.

## How it's made

```
py -3 tools/decompile-all.py          # regenerate all 4 -> decompiled/
```

Pipeline (both execution-validated — see `../tools/README.md`, `../ROADMAP.md`):
`vm-disasm.py` (ROM → v2 VM-asm, correct lengths) → `vm_decompile.py` (asm → C, dispatch keyed on the opcode byte). **Deterministic:** fixed ROM → byte-identical C, so these are committed and only regenerated when a *tool* improves (not every session).

## Reading the C — caveats

- **`// TODO:` lines (~22%)** are opcodes the decompiler has a byte-length for but no semantic translation yet. The surrounding structure (control flow, handled ops, frame slots, host-calls) still carries the logic. TODO density drops as opcodes get decoded.
- **`/*stack underflow*/ regA`, `/* via argN */`** — the decompiler's heuristic for implicit args passed via frame-shadow writes (see the `math32_3arg` label comment about reading uninitialized stack). Not a bug in the C; a marker of an inferred value.
- **`local10 = (x / 0)`** and similar — artifacts of the same uninitialized-arg heuristic; cross-check against the emulator (`nobunaga_vm.py`) for ground truth, which is how every *verified* formula here was confirmed.
- Field accesses like `arg1->output` use the province-record field map (`vm_decompile.PROV_FIELDS`).

**Ground-truth rule:** the C is the map; the emulator is the territory. Every formula cited as "verified" in memory/chapters was validated by executing the handler in `nobunaga_vm.py`, not by reading this C alone.
