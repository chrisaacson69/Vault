"""Verify LOADL_quick #12 (opcode $0C) reads from FP+11."""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))
from nobunaga_vm import NobunagaVM

vm = NobunagaVM()

# Set FP = $0500, then write $69AE at FP+11 = $050B
vm.vm_fp = 0x0500
vm.mem.write_word(0x050B, 0x69AE)

# Bytecode: $0C (LOADL_quick #12 — should read arg 1 = $69AE)
vm.mem.write(0x0700, 0x0C)
vm.vm_pc = 0x0700
vm.cpu.pc = vm.DISPATCHER_ADDR

# Run one opcode
op = vm.step_one_vm_op()
print(f"After LOADL_quick #12:")
print(f"  regL = ${vm.regL:04X}  (expected $69AE if FP+11 ordering)")
print(f"  VM PC = ${vm.vm_pc:04X}  (expected $0701)")

# Also verify $0F = arg 4 reads from FP+17
vm.vm_fp = 0x0500
vm.mem.write_word(0x0511, 0xCAFE)  # FP+17 = $0511
vm.mem.write(0x0710, 0x0F)
vm.vm_pc = 0x0710
vm.cpu.pc = vm.DISPATCHER_ADDR
op = vm.step_one_vm_op()
print(f"\nAfter LOADL_quick #15 (opcode $0F):")
print(f"  regL = ${vm.regL:04X}  (expected $CAFE if FP+17 ordering)")
