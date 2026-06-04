#!/usr/bin/env python3
"""Oracle validator for value-diamond TERNARY folding — the part the CFG gate cannot see.

A value-diamond (`regA = cond ? a : b`, rendered as two value-loading arms that converge)
is folded by the decompiler into a C ternary, and `vm_cfg.bytecode_cfg` CONTRACTS the same
diamond so the CFG gate stays green. But because the contraction happens on BOTH the raw and
structured sides, the gate proves only that the control-flow is consistently collapsed — it
does NOT check the ternary's VALUE or POLARITY (which arm is the true-branch). A flipped
polarity (`cond ? b : a`) would pass every structural gate while inverting the meaning — the
same blind spot that hid the compare-opcode inversion ([[feedback_foundation_discipline_early]]).

So the oracle is the only witness. This probe runs known folded-ternary subs through the live
ROM handler and asserts the observed result matches the rendered ternary. The cleanest fixtures
are `min_word`/`max_word` (bank 15): each is a pure two-arg function whose ENTIRE body is one
value-diamond, so a polarity regression flips min<->max and is caught immediately.

Usage: py -3 tools/probe-ternary-folds.py [-v]   (exit 1 on any mismatch)
"""
import argparse
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))
from nobunaga_vm import NobunagaVM
import vm_cfg

FP, SP = 0x0500, 0x04C0
VM_RETURN = 0xCF


def call2(bank, body, a1, a2):
    """Run a 2-arg sub body to its own RETURN; return regL (the result). Stops AT the
    top-level vm_return (result is in regL there) so it never executes the return target."""
    vm = NobunagaVM()
    vm.switch_bank(bank)
    vm.vm_fp, vm.vm_sp = FP, SP
    vm.mem.write(FP + 0x0B, a1 & 0xFF); vm.mem.write(FP + 0x0C, (a1 >> 8) & 0xFF)
    vm.mem.write(FP + 0x0D, a2 & 0xFF); vm.mem.write(FP + 0x0E, (a2 >> 8) & 0xFF)
    vm.vm_pc, vm.vm_call_depth = body, 0
    vm.cpu.pc = vm.DISPATCHER_ADDR
    for _ in range(4000):
        if vm.mem.read(vm.vm_pc) == VM_RETURN and vm.vm_call_depth == 0:
            return vm.regL
        if not vm.step_one_vm_op(max_cpu_steps=4000):
            break
    return vm.regL


# (label, bank, body_addr, reference fn over (a,b)). body_addr = the sub's `// (body @ $X)`.
FIXTURES = [
    ("min_word", 15, 0xCB63, min),
    ("max_word", 15, 0xCB74, max),
]
PAIRS = [(3, 6), (6, 3), (9, 2), (2, 9), (5, 5), (0, 7), (7, 0)]


def main():
    ap = argparse.ArgumentParser(description="Oracle validator for ternary value-diamond folds")
    ap.add_argument("-v", "--verbose", action="store_true")
    args = ap.parse_args()

    bad = 0
    print("Ternary-fold oracle check (value-diamond polarity vs the live ROM handler):")
    for name, bank, body, ref in FIXTURES:
        misses = []
        for a, b in PAIRS:
            got, want = call2(bank, body, a, b), ref(a, b)
            if got != want:
                misses.append((a, b, got, want))
        if misses:
            bad += 1
            print(f"  {name}: BAD  " + "; ".join(f"({a},{b})->{g} want {w}" for a, b, g, w in misses))
        elif args.verbose:
            print(f"  {name}: OK  ({len(PAIRS)} pairs match {ref.__name__})")
    if not args.verbose and bad == 0:
        print(f"  all {len(FIXTURES)} ternary fixtures match the oracle")

    if bad:
        print(f"\nFAIL: {bad} ternary fixture(s) disagree with the live ROM handler "
              f"(polarity regression?).")
        sys.exit(1)
    print("\nPASS: folded ternaries compute the oracle-correct value (polarity verified).")


if __name__ == "__main__":
    main()
