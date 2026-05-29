"""Run the selector with no stubs and detailed crash diagnostics."""
import sys, traceback
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))
from nobunaga_vm import NobunagaVM

vm = NobunagaVM()
vm.load_sram("traces/b2-startbattle.dmp")
vm.switch_bank(2)
vm.vm_pc = 0x967A
vm.cpu.pc = vm.DISPATCHER_ADDR
vm.mem.write(0x7BE8, 0)

vm.trace_enabled = True
try:
    ok = vm.run_until_outermost_return(max_ops=500)
    print(f"Result: ok={ok}, depth={vm.vm_call_depth}, regL=${vm.regL:04X}")
except Exception as e:
    print(f"CRASHED: {e}")
    print(f"CPU PC = ${vm.cpu.pc:04X}, VM PC = ${vm.vm_pc:04X}")
    print(f"call_depth = {vm.vm_call_depth}")
    print(f"$00-$0F state:")
    for a in range(0x00, 0x10):
        print(f"  ${a:02X} = ${vm.mem.read(a):02X}")
    print(f"\nLast 30 trace lines:")
    for line in vm.trace_log[-30:]:
        print(line)
