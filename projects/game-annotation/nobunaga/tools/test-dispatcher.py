"""
Test the full VM dispatcher cycle.

Place a real VM bytecode in RAM, point VM PC at it, jump CPU to the
dispatcher at $E867, and verify the opcode executes correctly.

Test sequence:
  - bytecode at $0700: $47 (setA_imm4 with value 7)
  - VM PC ($06/$07) = $0700
  - CPU PC = $E867 (dispatcher entry)
  - Step CPU; expect regA = $0007 after dispatcher runs one cycle
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from cpu6502 import Memory, CPU6502

ROM_PATH = Path(__file__).parent.parent / "Nobunaga's Ambition (USA).nes"


def test_one_dispatch_cycle():
    rom = ROM_PATH.read_bytes()
    mem = Memory(rom)
    cpu = CPU6502(mem)

    # Put bytecode $47 (setA = 7) at $0700
    mem.write(0x0700, 0x47)
    mem.write(0x0701, 0x42)  # next opcode = setA = 2 (so we know if it runs again)

    # Set VM PC ($06/$07) = $0700
    mem.write(0x06, 0x00)
    mem.write(0x07, 0x07)

    # Clear regA so we see the change
    mem.write(0x08, 0xFF)
    mem.write(0x09, 0xFF)

    # CPU starts at dispatcher entry
    cpu.pc = 0xE867

    # Step until CPU returns to $E867 (one full opcode cycle)
    steps = 0
    initial_dispatch = True
    while steps < 100:
        cpu.step()
        steps += 1
        if cpu.pc == 0xE867 and not initial_dispatch:
            break
        initial_dispatch = False

    regA_lo = mem.read(0x08)
    regA_hi = mem.read(0x09)
    regA = regA_lo | (regA_hi << 8)
    vm_pc = mem.read(0x06) | (mem.read(0x07) << 8)

    print(f"After 1 dispatch cycle (took {steps} CPU steps):")
    print(f"  regA = ${regA:04X}  (expected $0007)")
    print(f"  VM PC = ${vm_pc:04X}  (expected $0701, advanced past the $47 opcode)")

    assert regA == 7, f"Expected regA=7, got {regA}"
    assert vm_pc == 0x0701, f"Expected VM PC=$0701, got ${vm_pc:04X}"
    print("PASS")


def test_two_dispatch_cycles():
    """Run two consecutive opcodes: $47 then $44 -> regA should end as $0004."""
    rom = ROM_PATH.read_bytes()
    mem = Memory(rom)
    cpu = CPU6502(mem)

    mem.write(0x0700, 0x47)  # setA = 7
    mem.write(0x0701, 0x44)  # setA = 4
    mem.write(0x06, 0x00); mem.write(0x07, 0x07)
    cpu.pc = 0xE867

    # Run for 50 steps (should be enough for 2 dispatch cycles)
    dispatches = 0
    last_pc = None
    for _ in range(100):
        cpu.step()
        # Count returns to $E867
        if cpu.pc == 0xE867 and last_pc != 0xE867:
            dispatches += 1
            if dispatches >= 2:
                break
        last_pc = cpu.pc

    regA = mem.read(0x08) | (mem.read(0x09) << 8)
    vm_pc = mem.read(0x06) | (mem.read(0x07) << 8)
    print(f"\nAfter 2 dispatch cycles:")
    print(f"  regA = ${regA:04X}  (expected $0004)")
    print(f"  VM PC = ${vm_pc:04X}  (expected $0702)")
    assert regA == 4
    assert vm_pc == 0x0702
    print("PASS")


def test_immediate_load_word():
    """Test $8A: LOADL imm2 -> regA = next word from bytecode."""
    rom = ROM_PATH.read_bytes()
    mem = Memory(rom)
    cpu = CPU6502(mem)

    # bytecode: $8A $34 $12 -> regA = $1234
    mem.write(0x0700, 0x8A)
    mem.write(0x0701, 0x34)
    mem.write(0x0702, 0x12)
    mem.write(0x06, 0x00); mem.write(0x07, 0x07)
    cpu.pc = 0xE867

    # Run until dispatcher returns
    last_pc = None
    for _ in range(100):
        cpu.step()
        if cpu.pc == 0xE867 and last_pc != 0xE867:
            break
        last_pc = cpu.pc

    regA = mem.read(0x08) | (mem.read(0x09) << 8)
    vm_pc = mem.read(0x06) | (mem.read(0x07) << 8)
    print(f"\nTest $8A LOADL imm2: regA = ${regA:04X} (expected $1234), VM PC = ${vm_pc:04X} (expected $0703)")
    assert regA == 0x1234
    assert vm_pc == 0x0703
    print("PASS")


def test_op_A8_store_abs():
    """The critical test: $A8 STORE abs writes regA to fetched absolute addr.
    bytecode: $A8 $00 $07 -> writes regA to $0700.
    """
    rom = ROM_PATH.read_bytes()
    mem = Memory(rom)
    cpu = CPU6502(mem)

    # Pre-set regA
    mem.write(0x08, 0x42)
    mem.write(0x09, 0x13)  # regA = $1342

    # Bytecode: $A8 $00 $07 -> STORE abs $0700 = regA
    mem.write(0x0710, 0xA8)
    mem.write(0x0711, 0x00)
    mem.write(0x0712, 0x07)
    mem.write(0x06, 0x10); mem.write(0x07, 0x07)
    cpu.pc = 0xE867

    last_pc = None
    for _ in range(100):
        cpu.step()
        if cpu.pc == 0xE867 and last_pc != 0xE867:
            break
        last_pc = cpu.pc

    stored_lo = mem.read(0x0700)
    stored_hi = mem.read(0x0701)
    stored = stored_lo | (stored_hi << 8)

    print(f"\nTest $A8 STORE abs $0700:")
    print(f"  $0700 = ${stored_lo:02X}, $0701 = ${stored_hi:02X}, word = ${stored:04X}")
    print(f"  Expected: $1342 (regA value)")
    assert stored == 0x1342, f"Expected $1342, got ${stored:04X}"
    print("PASS — $A8 is definitively STORE abs, not LOAD abs")


if __name__ == "__main__":
    test_one_dispatch_cycle()
    test_two_dispatch_cycles()
    test_immediate_load_word()
    test_op_A8_store_abs()
    print("\nAll dispatcher tests passed. The VM runs.")
