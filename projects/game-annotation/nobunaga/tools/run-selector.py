"""Run the combat selector $9675 and stop at VM RETURN to read the result."""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))
from nobunaga_vm import NobunagaVM

# Find the CF (RETURN) handler address
def find_cf_handler():
    """opcode $CF maps to which handler?"""
    rom_path = Path(__file__).parent.parent / "Nobunaga's Ambition (USA).nes"
    rom = rom_path.read_bytes()
    lo = rom[0x10 + 15*0x4000 + (0xF026 - 0xC000) + 0xCF]
    hi = rom[0x10 + 15*0x4000 + (0xF126 - 0xC000) + 0xCF]
    return lo | (hi << 8)


def run_until_vm_return(vm, max_cpu_steps=10000):
    """Step the CPU until it enters the VM RETURN opcode handler.
    That's when the current sub is about to exit.
    """
    cf_handler = find_cf_handler()
    print(f"CF (RETURN) handler at ${cf_handler:04X}")

    for step in range(max_cpu_steps):
        if vm.cpu.pc == cf_handler:
            return step
        vm.cpu.step()
    return -1


def main():
    vm = NobunagaVM()
    vm.load_sram("traces/b2-startbattle.dmp")
    vm.switch_bank(2)
    vm.vm_pc = 0x967A
    vm.cpu.pc = vm.DISPATCHER_ADDR

    # Clear the $7BE8 "combat-already-active" flag so selector runs fully
    # (matches game state right when selector is normally called by setup chain)
    vm.mem.write(0x7BE8, 0)
    vm.mem.write(0x7BE9, 0)
    print(f"(cleared $7BE8 to allow selector to run full path)")

    print(f"Initial state (Hida v Shinano matchup):")
    print(f"  atk_prov ($6F5F) = ${vm.mem.read(0x6F5F):02X}")
    print(f"  def_prov ($6F63) = ${vm.mem.read(0x6F63):02X}")
    print(f"  scratch $6FF6 = ${vm.mem.read_word(0x6FF6):04X}")
    print(f"  scratch $6FF8 = ${vm.mem.read_word(0x6FF8):04X}")
    print(f"  scratch $6FFA = ${vm.mem.read_word(0x6FFA):04X}")
    print(f"  scratch $6FFC = ${vm.mem.read_word(0x6FFC):04X}")
    print()

    # Capture writes to $6FF6-$6FFC to see what the selector does
    vm.mem.trace_writes = True

    n = run_until_vm_return(vm)
    if n < 0:
        print("FAILED: never hit CF handler")
        return
    print(f"Hit VM RETURN after {n} CPU steps")
    print(f"  VM PC at CF moment = ${vm.vm_pc:04X}")
    print(f"  (selector's CF is at $9709, so VM PC should be $970A after fetch)")
    print()

    # Filter writes to scratch range
    print(f"All writes to $6FF6-$6FFE during selector execution:")
    for addr, val in vm.mem.write_log:
        if 0x6FF6 <= addr <= 0x6FFF:
            print(f"  ${addr:04X} = ${val:02X}")
    print()

    print(f"Final state:")
    print(f"  regL = ${vm.regL:04X}  <-- THIS IS THE DAMAGE RETURNED")
    print(f"  regR = ${vm.regR:04X}")
    print(f"  $6FF6 = ${vm.mem.read_word(0x6FF6):04X}")
    print(f"  $6FF8 = ${vm.mem.read_word(0x6FF8):04X}")
    print(f"  $6FFA = ${vm.mem.read_word(0x6FFA):04X}")
    print(f"  $6FFC = ${vm.mem.read_word(0x6FFC):04X}")
    print()
    print(f"Hida v Shinano predicted damage: 4 (per our earlier analysis)")
    print(f"Actual damage from running the code: {vm.regL}")


if __name__ == "__main__":
    main()
