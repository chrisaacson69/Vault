"""
Trace the combat damage selector $9675 running against our captured SRAM.

This is the proof-of-concept: load a battle state, run the selector,
see the actual damage value it returns.

Setup:
  - Load b2-startbattle.dmp (Hida v Shinano matchup, fiefs 5 vs 8)
  - Switch to bank 2 (where $9675 lives)
  - Set VM PC = $9675 (start of the selector body, actually $967A per disasm)
  - Run 30 opcodes and trace each
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from nobunaga_vm import NobunagaVM


def trace_selector(dmp_path, n_ops=30):
    vm = NobunagaVM()
    vm.load_sram(dmp_path)
    vm.switch_bank(2)  # $9675 is in bank 2

    # Selector body starts at $967A (after the sub-header words at $9675-$9679)
    vm.vm_pc = 0x967A
    vm.cpu.pc = vm.DISPATCHER_ADDR

    # Print initial state
    print(f"Loaded SRAM: {Path(dmp_path).name}")
    print(f"  $6F5F (atk prov) = ${vm.mem.read(0x6F5F):02X}")
    print(f"  $6F63 (def prov) = ${vm.mem.read(0x6F63):02X}")
    print(f"  $6FF6 = ${vm.mem.read_word(0x6FF6):04X}")
    print(f"  $6FF8 = ${vm.mem.read_word(0x6FF8):04X}")
    print(f"  $6FFA = ${vm.mem.read_word(0x6FFA):04X}")
    print(f"  $6FFC = ${vm.mem.read_word(0x6FFC):04X}")
    print()

    vm.trace_enabled = True
    print(f"Running {n_ops} VM opcodes starting at $967A...")
    print()
    ok = vm.run_n_ops(n_ops)
    print(f"Completed {'successfully' if ok else 'with errors'}\n")
    print("Trace:")
    for line in vm.trace_log:
        print(line)

    print("\nFinal state:")
    print(f"  regL = ${vm.regL:04X}")
    print(f"  regR = ${vm.regR:04X}")
    print(f"  $6FF6 = ${vm.mem.read_word(0x6FF6):04X}")
    print(f"  $6FF8 = ${vm.mem.read_word(0x6FF8):04X}")
    print(f"  $6FFA = ${vm.mem.read_word(0x6FFA):04X}")
    print(f"  $6FFC = ${vm.mem.read_word(0x6FFC):04X}")


if __name__ == "__main__":
    trace_selector("traces/b2-startbattle.dmp", n_ops=20)
