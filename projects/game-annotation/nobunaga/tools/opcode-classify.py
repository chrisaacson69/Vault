"""Auto-classify each opcode handler by its operand-fetch pattern.

For each unique handler in bank 15, read its first ~16 instructions and
look for known operand-fetching helper calls. Output a TOML-ready entry
per opcode with the detected operand format.

Recognition patterns:
  - JSR $EFD5 (vm_read_word_into_ptr0)        => 2-byte word operand
  - JSR $EFA6                                  => 1-byte operand
  - JSR $EFC0                                  => 1-byte operand
  - JSR $EFEC                                  => 1-byte operand
  - JSR $EFBF                                  => 1-byte signed operand
  - JSR $EF97                                  => 1-byte signed operand
  - JSR $EFD3                                  => 1-byte operand (pull-then-advance)
  - First instr is "txa / and #$0f"            => opcode-as-operand cluster
  - Pure jmp vm_dispatch (no JSRs)             => no operand (NOP-like)
  - Anything else                              => leave as "unknown"

The classifier walks at most 16 instructions of the handler since most
operand fetches happen at the very start. If multiple JSRs appear,
multiple operand bytes might be consumed (rare).
"""

import sys
from collections import defaultdict

rom = open(sys.argv[1], "rb").read()[16:]
lo = rom[0x3F026:0x3F126]
hi = rom[0x3F126:0x3F226]
opcodes = [(hi[i] << 8) | lo[i] for i in range(256)]


def cpu_to_prg(addr):
    """Bank 15 CPU address -> PRG offset."""
    assert 0xC000 <= addr <= 0xFFFF, f"not bank 15: ${addr:04X}"
    return 15 * 0x4000 + (addr & 0x3FFF)


# Helper signatures: byte sequences that indicate operand fetch type
OPERAND_FETCH_HELPERS = {
    # JSR target -> (operand-format-name, byte-count)
    0xEFD5: ("word", 2),    # vm_read_word_into_ptr0
    0xEFA6: ("byte", 1),
    0xEFC0: ("byte", 1),
    0xEFEC: ("byte", 1),
    0xEFBF: ("byte", 1),
    0xEF97: ("sbyte", 1),   # signed byte
    0xEFD3: ("byte", 1),
}


def classify_handler(handler_addr):
    """Read up to 16 instructions of handler; return operand format tag."""
    prg = cpu_to_prg(handler_addr)

    # Quick check: is this just JMP vm_dispatch ($E867)?
    if rom[prg:prg+3] == bytes([0x4C, 0x67, 0xE8]):
        return "nop"

    # Walk up to 16 instructions, looking for known operand-fetch JSRs
    # We just scan bytes; this is a fast heuristic, not a real disassembler.
    operands = []
    operand_in_opcode = False
    pos = prg
    seen = set()
    max_scan = 40  # bytes
    while pos < prg + max_scan and len(operands) < 3:
        if pos in seen:
            break  # loop
        seen.add(pos)
        if pos >= len(rom):
            break
        op = rom[pos]
        # Cheap 6502 instruction-length lookup for the bytes we care about
        if op == 0x20:  # JSR abs (3 bytes)
            if pos + 2 < len(rom):
                target = rom[pos+1] | (rom[pos+2] << 8)
                if target in OPERAND_FETCH_HELPERS:
                    fmt, _ = OPERAND_FETCH_HELPERS[target]
                    operands.append(fmt)
                # JSR vm_dispatch isn't an operand fetch but we keep walking
                # JSR vm_call_native ($EB57) is the call mechanism; not operand
                if target == 0xE867:  # jmp/jsr to vm_dispatch ends classification
                    break
            pos += 3
        elif op == 0x4C:  # JMP abs - ALWAYS end of handler (don't walk past)
            # If the JMP is to a "tail" routine (like $EB9E for host_call),
            # tails have their own operand fetches that we'd need to follow.
            # We record the tail address so caller can merge if known.
            if pos + 2 < len(rom):
                tail_target = rom[pos+1] | (rom[pos+2] << 8)
                # Known tails with their own operand fetches:
                if tail_target == 0xEB9E:  # host_call_E9 tail: jsr ef97 = sbyte
                    operands.append("byte")  # adjustment byte (signed in mechanism, byte for disasm)
            break
        elif op == 0x60:  # RTS (1 byte)
            break
        elif op == 0x40:  # RTI (1 byte)
            break
        elif op == 0x6C:  # JMP indirect (3 bytes)
            break
        elif op == 0x8A:  # TXA (1 byte)
            # Common pattern start for opcode-as-operand handlers
            # txa / and #$0f / ... pattern
            if pos + 2 < len(rom) and rom[pos+1] == 0x29 and rom[pos+2] == 0x0F:
                operand_in_opcode = True
            pos += 1
        elif op == 0x29:  # AND immediate (2 bytes)
            pos += 2
        elif op in (0x18, 0x38, 0x88, 0xA8, 0xAA, 0xBA, 0xC8, 0xCA, 0xE8, 0xEA):
            pos += 1  # implied (CLC, SEC, DEY, TAY, TAX, TSX, INY, DEX, INX, NOP)
        elif op in (0xA9, 0xA0, 0xA2, 0x69, 0xE9, 0xC9, 0xC0, 0xE0):
            pos += 2  # immediate operand
        elif op in (0x10, 0x30, 0x50, 0x70, 0x90, 0xB0, 0xD0, 0xF0):
            pos += 2  # relative branch
        elif op in (0x85, 0x95, 0xA5, 0xB5, 0x65, 0x75, 0x86, 0x96, 0xA6, 0xB6,
                    0x84, 0x94, 0xA4, 0xB4, 0x24, 0xC5, 0xC6, 0xE6, 0xE5,
                    0xC4, 0xE4, 0x26, 0x46, 0x66, 0x06, 0x05, 0x25, 0x45):
            pos += 2  # zero-page op
        elif op in (0x8D, 0x9D, 0xAD, 0xBD, 0x6D, 0x7D, 0x8E, 0xAE, 0xBE,
                    0x8C, 0xAC, 0xBC, 0x2C, 0xCD, 0xCE, 0xEE, 0xED,
                    0xCC, 0xEC, 0x2E, 0x4E, 0x6E, 0x0E, 0x0D, 0x2D, 0x4D):
            pos += 3  # absolute op
        else:
            pos += 1  # unknown, advance 1

    if operand_in_opcode and not operands:
        return "opcode_operand"
    if not operands:
        return "no_operand"
    if operands == ["word"]:
        return "word"
    if operands == ["byte"]:
        return "byte"
    if operands == ["sbyte"]:
        return "sbyte"
    if operands == ["word", "byte"]:
        return "word_byte"
    return "_".join(operands)


# Classify each unique handler
clusters = defaultdict(list)
for op, h in enumerate(opcodes):
    clusters[h].append(op)

# Group by detected operand format
by_format = defaultdict(list)
for h, ops in clusters.items():
    fmt = classify_handler(h)
    for op in ops:
        by_format[fmt].append((op, h))

# Print summary
total = sum(len(v) for v in by_format.values())
print(f"Total opcodes classified: {total}\n")
for fmt, entries in sorted(by_format.items(), key=lambda x: -len(x[1])):
    print(f"=== {fmt}: {len(entries)} opcodes ===")
    op_strs = []
    sorted_ops = sorted(entries)
    if len(sorted_ops) > 0:
        start = sorted_ops[0][0]
        prev = start
        for op, _ in sorted_ops[1:]:
            if op == prev + 1:
                prev = op
            else:
                op_strs.append(f"${start:02X}" if start == prev else f"${start:02X}-${prev:02X}")
                start = prev = op
        op_strs.append(f"${start:02X}" if start == prev else f"${start:02X}-${prev:02X}")
    print(f"  opcodes: {' '.join(op_strs)}")
    print()
