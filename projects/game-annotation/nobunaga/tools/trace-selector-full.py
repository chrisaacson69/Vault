"""Full per-VM-opcode trace of the selector run."""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))
from nobunaga_vm import NobunagaVM

def find_cf_handler():
    rom = (Path(__file__).parent.parent / "Nobunaga's Ambition (USA).nes").read_bytes()
    lo = rom[0x10 + 15*0x4000 + (0xF026 - 0xC000) + 0xCF]
    hi = rom[0x10 + 15*0x4000 + (0xF126 - 0xC000) + 0xCF]
    return lo | (hi << 8)


vm = NobunagaVM()
vm.load_sram("traces/b2-startbattle.dmp")
vm.switch_bank(2)
vm.vm_pc = 0x967A
vm.cpu.pc = vm.DISPATCHER_ADDR
vm.mem.write(0x7BE8, 0)
vm.mem.write(0x7BE9, 0)

cf_handler = find_cf_handler()
print(f"CF handler at ${cf_handler:04X}; stopping there.\n")

# Trace each VM op
print("VM opcode trace:")
for i in range(50):
    if vm.cpu.pc != vm.DISPATCHER_ADDR:
        # Run CPU until we're at dispatcher OR at CF handler
        for _ in range(500):
            if vm.cpu.pc in (vm.DISPATCHER_ADDR, cf_handler):
                break
            vm.cpu.step()

    if vm.cpu.pc == cf_handler:
        print(f"  Hit CF handler (VM PC will become caller-restored)")
        # Step through CF to see where we end up
        for _ in range(200):
            if vm.cpu.pc == vm.DISPATCHER_ADDR:
                break
            vm.cpu.step()
        print(f"  After CF: VM PC = ${vm.vm_pc:04X}, regL = ${vm.regL:04X}")
        # Look up what bank we'd need
        continue

    # Disasm one op
    pre_pc = vm.vm_pc
    pre_L = vm.regL
    pre_R = vm.regR
    disasm, ilen = vm.disasm_at(pre_pc)
    print(f"  ${pre_pc:04X}  {disasm}")

    # Step one VM op
    vm.cpu.step()  # past dispatcher entry
    for _ in range(500):
        if vm.cpu.pc == vm.DISPATCHER_ADDR or vm.cpu.pc == cf_handler:
            break
        vm.cpu.step()

    print(f"          regL=${vm.regL:04X} regR=${vm.regR:04X}  (was L=${pre_L:04X} R=${pre_R:04X})")

print(f"\nFinal: regL=${vm.regL:04X}")
print(f"Scratch after run:")
for a in [0x6FF6, 0x6FF8, 0x6FFA, 0x6FFC]:
    print(f"  ${a:04X} = ${vm.mem.read_word(a):04X}")
