"""Debug step-by-step trace of selector run."""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))
from nobunaga_vm import NobunagaVM

vm = NobunagaVM()
vm.load_sram("traces/b2-startbattle.dmp")
vm.switch_bank(2)
vm.vm_pc = 0x967A
vm.cpu.pc = vm.DISPATCHER_ADDR

print("Step-by-step CPU trace (extended):")
for i in range(400):
    pc = vm.cpu.pc
    op = vm.mem.read(pc)
    info = f"PC=${pc:04X} op=${op:02X}  A=${vm.cpu.a:02X} X=${vm.cpu.x:02X} Y=${vm.cpu.y:02X}  C={int(vm.cpu.c)}"
    info += f"  VM PC=${vm.vm_pc:04X} ptr0=${vm.mem.read_word(0x00):04X}"
    print(f"  {i:3} {info}")
    try:
        vm.cpu.step()
    except Exception as e:
        print(f"  ERROR: {e}")
        break
