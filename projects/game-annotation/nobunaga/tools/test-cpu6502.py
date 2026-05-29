"""
Smoke test: run the $E9F6 setA_imm4 handler directly from ROM and verify
it sets regA correctly.

The handler is `setA = opcode & 0x0F`. Test with opcode $47 -> regA should = 7.

Bytes at $E9F6:
  $E9F6: 8A           TXA            ; A = X (= opcode byte)
  $E9F7: 29 0F        AND #$0F
  $E9F9: 85 08        STA $08        ; regA_lo = A
  $E9FB: 84 09        STY $09        ; regA_hi = Y (= 0)
  $E9FD: 4C 67 E8     JMP $E867      ; back to dispatcher
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from cpu6502 import Memory, CPU6502

ROM_PATH = Path(__file__).parent.parent / "Nobunaga's Ambition (USA).nes"


def test_setA_imm4():
    rom = ROM_PATH.read_bytes()
    mem = Memory(rom)
    cpu = CPU6502(mem)

    # Set up dispatcher state: X = opcode byte, Y = 0
    cpu.x = 0x47
    cpu.y = 0
    cpu.pc = 0xE9F6

    # Run until we hit JMP $E867
    target = 0xE867
    for _ in range(20):
        if cpu.pc == target:
            break
        cpu.step()
    else:
        raise RuntimeError("Didn't reach $E867")

    # Check that regA ($08/$09) was set to $0007
    regA_lo = mem.read(0x08)
    regA_hi = mem.read(0x09)
    regA = regA_lo | (regA_hi << 8)

    print(f"After running $E9F6 with X=$47:")
    print(f"  $08 = ${regA_lo:02X}")
    print(f"  $09 = ${regA_hi:02X}")
    print(f"  regA = ${regA:04X}  (expected $0007)")
    assert regA == 7, f"Expected regA=7, got {regA}"
    print("PASS")


def test_setA_imm4_value_10():
    """opcode $4A -> regA = 10"""
    rom = ROM_PATH.read_bytes()
    mem = Memory(rom)
    cpu = CPU6502(mem)
    cpu.x = 0x4A
    cpu.y = 0
    cpu.pc = 0xE9F6
    for _ in range(20):
        if cpu.pc == 0xE867: break
        cpu.step()
    regA = mem.read(0x08) | (mem.read(0x09) << 8)
    print(f"\nTest 2: setA with $4A -> regA = ${regA:04X} (expected $000A)")
    assert regA == 10, f"Expected 10, got {regA}"
    print("PASS")


def test_clearA_special():
    """opcode $40 has its OWN handler at $EA00 (not shared $E9F6).
    Bytes: 84 08 84 09 4C 67 E8 (STY $08; STY $09; JMP)
    Result: regA = 0 (since Y = 0 at dispatch entry).
    """
    rom = ROM_PATH.read_bytes()
    mem = Memory(rom)
    cpu = CPU6502(mem)
    # First write some garbage so we can verify clearing
    mem.write(0x08, 0xFF)
    mem.write(0x09, 0xFF)
    cpu.x = 0x40
    cpu.y = 0
    cpu.pc = 0xEA00
    for _ in range(20):
        if cpu.pc == 0xE867: break
        cpu.step()
    regA = mem.read(0x08) | (mem.read(0x09) << 8)
    print(f"\nTest 3: $40 (clearA) -> regA = ${regA:04X} (expected $0000)")
    assert regA == 0, f"Expected 0, got {regA}"
    print("PASS")


if __name__ == "__main__":
    test_setA_imm4()
    test_setA_imm4_value_10()
    test_clearA_special()
    print("\nAll 6502 emulator smoke tests passed.")
