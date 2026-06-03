#!/usr/bin/env python3
"""
probe-skill-impact.py — settle which DIRECTION the skill level (const_two $6D63)
pushes development gain, by running the Grow effect at several skill levels on
one identical pre-state. The decompiled C is lossy on the const_two arrangement;
the emulator is ground truth.

Usage:
    py -3 tools/probe-skill-impact.py [sram_pre] [amount]
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))
from nobunaga_vm import NobunagaVM

GROW = {"entry": 0x87F0, "body": 0x87F5, "frame_off": -4, "bank": 1}
CONST_TWO = 0x6D63
OUTPUT_OFF = 8  # province record field +8 = output (Grow's target)
WATCHED = {0xCBCD: ("sqrt_int", 1), 0xD6B8: ("math32_3arg", 3), 0xD70D: ("pct_op", 2)}


def run_grow(sram_path, skill, amount):
    vm = NobunagaVM()
    vm.load_sram(sram_path)
    vm.mem.write_word(CONST_TWO, skill)            # <-- override skill level
    sel = vm.mem.read(0x6F5F)
    base = 0x7001 + sel * 26
    out_pre = vm.mem.read_word(base + OUTPUT_OFF)

    captured = []
    original = vm.step_one_vm_op
    def hook():
        if vm.cpu.pc == vm.DISPATCHER_ADDR:
            op = vm.mem.read(vm.vm_pc)
            if op == 0xE9:
                tgt = vm.mem.read_word(vm.vm_pc + 1)
                if tgt in WATCHED:
                    name, n = WATCHED[tgt]
                    sp = vm.vm_sp
                    args = list(reversed([vm.mem.read_word(sp + 2*i) for i in range(n)]))
                    captured.append((name, args))
        return original()
    vm.step_one_vm_op = hook

    vm.switch_bank(GROW["bank"])
    fp = 0x05FF
    vm.vm_fp = fp
    vm.vm_sp = fp + GROW["frame_off"]
    vm.mem.write_word(fp + 11, base)
    vm.mem.write_word(fp + 13, amount)
    vm.vm_pc = GROW["body"]
    vm.cpu.pc = vm.DISPATCHER_ADDR
    err = None
    try:
        vm.run_until_outermost_return(max_ops=500)
    except Exception as e:
        err = f"tail:{e}"   # harmless outermost-return artifact; state already applied
    gain = vm.mem.read_word(base + OUTPUT_OFF) - out_pre
    return gain, err, captured


def main():
    sram = sys.argv[1] if len(sys.argv) > 1 else "traces/grow-test1-tokugawa-PRE.dmp"
    amount = int(sys.argv[2]) if len(sys.argv) > 2 else 100
    print(f"Grow on {sram}, amount={amount} — gain vs skill level (const_two):\n")
    print(f"  {'skill':>5} {'gain':>6}   math32_3arg(a, b, c)")
    for skill in (1, 2, 3, 4, 5):
        gain, err, cap = run_grow(sram, skill, amount)
        m = next((a for n, a in cap if n == "math32_3arg"), None)
        marg = f"({m[0]}, {m[1]}, {m[2]})" if m else "(not captured)"
        print(f"  {skill:>5} {('ERR' if gain is None else gain):>6}   {marg}" + (f"  [{err}]" if err else ""))


if __name__ == "__main__":
    main()
