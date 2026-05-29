"""
Classify each VM opcode by analyzing its handler's native 6502 code.

Strategy: handler bodies share common epilogue patterns. By matching the
SEQUENCE of distinctive bytes at the END of each handler (before JMP dispatch),
we can identify the operation:

  - LDA ($00),Y / STA $08 / INY / LDA ($00),Y / STA $09 -> LOAD WORD -> regA
  - LDA ($00),Y / STA $0C / INY / LDA ($00),Y / STA $0D -> LOAD WORD -> regB
  - LDA $08 / STA ($00),Y / INY / LDA $09 / STA ($00),Y -> STORE WORD from regA
  - JSR $EFD5 (fetch word) -> absolute addressing
  - JSR $EFA6 (fetch sbyte) -> near frame-relative
  - JSR $EFBF (fetch word) -> far frame-relative
  - JMP $F008 (push word) -> push to stack
  ... etc.

Then map to Sea-16 semantic name.
"""

from pathlib import Path

ROM = Path(__file__).parent.parent / "Nobunaga's Ambition (USA).nes"

def cpu_to_file(cpu, bank=15):
    if bank == 15:
        return 0x10 + 15 * 0x4000 + (cpu - 0xC000)
    else:
        return 0x10 + bank * 0x4000 + (cpu - 0x8000)


# Known helper subs (the "what gets called" gives us the addressing mode)
HELPERS = {
    0xEFD5: "fetch_word_imm",      # reads 2 bytes from bytecode -> ptr0 (absolute addr)
    0xEFEC: "fetch_word_imm_relfp", # reads 2 bytes + adds $04/$05 -> ptr0 (far frame offset)
    0xEFA6: "fetch_sbyte_relfp",   # reads 1 byte signed + adds $04/$05 -> ptr0 (near frame offset)
    0xEFBF: "fetch_word_raw",      # reads 2 bytes from bytecode (no ptr0 setup) -> regA?
    0xF008: "push_word_stack",     # push regA word to data stack
}

# Distinctive byte sequences at end of handler -> operation
# Look for last sequence before JMP $E867 (4C 67 E8)
OPERATION_PATTERNS = [
    # Load operations
    (b'\xB1\x00\x85\x08\xC8\xB1\x00\x85\x09\x4C\x67\xE8', "load_word_via_ptr0_to_A"),
    (b'\xB1\x00\x85\x0C\xC8\xB1\x00\x85\x0D\x4C\x67\xE8', "load_word_via_ptr0_to_B"),
    (b'\xB1\x04\x85\x08\xC8\xB1\x04\x85\x09\x4C\x67\xE8', "load_word_via_fp_to_A"),
    (b'\xB1\x04\x85\x0C\xC8\xB1\x04\x85\x0D\x4C\x67\xE8', "load_word_via_fp_to_B"),
    # Store operations
    (b'\xA5\x08\x91\x00\xC8\xA5\x09\x91\x00\x4C\x67\xE8', "store_word_from_A_via_ptr0"),
    (b'\xA5\x08\x91\x04\xC8\xA5\x09\x91\x04\x4C\x67\xE8', "store_word_from_A_via_fp"),
    # Push operations
    (b'\xB1\x00\xAA\x88\xB1\x00\x4C\x08\xF0',             "push_word_via_ptr0"),
    (b'\xB1\x04\xAA\x88\xB1\x04\x4C\x08\xF0',             "push_word_via_fp"),
    # Byte loads
    (b'\xB1\x00\x85\x08\xA0\x00\x84\x09\x4C\x67\xE8',     "load_byte_via_ptr0_to_A_zx"),
    # Byte stores
    (b'\xA5\x08\x91\x00\x4C\x67\xE8',                     "store_byte_from_A_via_ptr0"),
    # Direct
    (b'\x84\x08\x84\x09\x4C\x67\xE8',                     "clearA_set_to_Y"),     # for $40
    (b'\x29\x0F\x85\x08\x84\x09\x4C\x67\xE8',             "set_A_to_opcode_low_nibble"),  # for $41-$4F
    (b'\x29\x0F\x85\x0C\x84\x0D\x4C\x67\xE8',             "set_B_to_opcode_low_nibble"),  # for $51-$5F
]


def follow_branches(rom, cpu_addr, max_steps=20):
    """Walk forward from cpu_addr, following BCC ($90) backward branches.
    Returns set of (cpu_addr, length) byte windows that the handler may execute.
    Stops at JMP/RTS/dispatch."""
    visited = set()
    queue = [cpu_addr]
    windows = []
    while queue and len(visited) < max_steps:
        pc = queue.pop()
        if pc in visited:
            continue
        visited.add(pc)
        ofs = cpu_to_file(pc)
        # Collect bytes until we hit JMP (4C) or a control transfer we don't follow
        start_ofs = ofs
        i = 0
        while i < 96 and ofs + i < len(rom):
            b = rom[ofs + i]
            # JMP absolute = stop
            if b == 0x4C:
                i += 3
                break
            # RTS = stop
            if b == 0x60:
                i += 1
                break
            # BCC = follow branch (most common pattern)
            if b == 0x90:
                offset = rom[ofs + i + 1]
                if offset >= 0x80:
                    offset -= 256
                target = pc + (i + 2) + offset
                if target not in visited:
                    queue.append(target)
                # ALSO continue past the BCC (the fall-through path)
                i += 2
                continue
            # JSR = include the 3 bytes, continue
            if b == 0x20:
                i += 3
                continue
            # Branch BNE/BEQ - follow for completeness
            if b in (0xD0, 0xF0):
                offset = rom[ofs + i + 1]
                if offset >= 0x80:
                    offset -= 256
                target = pc + (i + 2) + offset
                if target not in visited:
                    queue.append(target)
                i += 2
                continue
            i += 1
        windows.append((ofs, i))
    return windows


def find_last_op(rom, cpu_addr, max_scan=128):
    """Find which operation pattern is reachable from this handler."""
    # Get all reachable windows
    windows = follow_branches(rom, cpu_addr)
    # Concatenate all bytes from all reachable windows
    all_bytes = b''
    for ofs, length in windows:
        all_bytes += rom[ofs:ofs+length]
    # Try to match each operation pattern
    matches = []
    for pat, name in OPERATION_PATTERNS:
        if pat in all_bytes:
            matches.append(name)
    if matches:
        return matches[0], 0
    return "unknown", -1


def find_helpers_called(rom, cpu_addr, max_scan=64):
    """Find JSR calls in the handler body. Return list of helper names called."""
    ofs = cpu_to_file(cpu_addr)
    window = rom[ofs:ofs + max_scan]
    helpers = []
    i = 0
    while i < len(window) - 2:
        if window[i] == 0x20:  # JSR
            tgt = window[i+1] | (window[i+2] << 8)
            if tgt in HELPERS:
                helpers.append(HELPERS[tgt])
            i += 3
        elif window[i] == 0x4C:  # JMP, stop
            break
        else:
            i += 1
    return helpers


def main():
    rom = ROM.read_bytes()

    lo_base = cpu_to_file(0xF026)
    hi_base = cpu_to_file(0xF126)

    handlers = {}
    addr_to_ops = {}
    for op in range(256):
        addr = rom[lo_base + op] | (rom[hi_base + op] << 8)
        handlers[op] = addr
        addr_to_ops.setdefault(addr, []).append(op)

    # Classify each unique handler
    classification = {}  # addr -> (op_name, helpers)
    for addr in sorted(addr_to_ops.keys()):
        op_name, _ = find_last_op(rom, addr)
        helpers = find_helpers_called(rom, addr)
        classification[addr] = (op_name, helpers)

    # Report opcode -> classification
    print("OPCODE CLASSIFICATION (Phase 1 pass)")
    print("=" * 78)
    print(f"{'op':>4}  {'addr':>5}  {'helpers':<35}  {'operation'}")
    print("-" * 78)
    for op in range(256):
        addr = handlers[op]
        op_name, helpers = classification[addr]
        helpers_str = ', '.join(helpers) if helpers else '-'
        print(f"  ${op:02X}  ${addr:04X}  {helpers_str:<35}  {op_name}")


if __name__ == "__main__":
    main()
