"""
Dump Nobunaga's 256-entry VM opcode dispatch table.

Reads handler-address words from $F026 (low bytes) and $F126 (high bytes) in bank 15.
For each unique handler, dumps the first 24 native bytes.

This is Phase 1 of the verified opcode table project. After running, manually
classify each handler against Sea-16's semantic catalog and write the result
to vm-opcodes-v2.toml.
"""

import sys
from pathlib import Path

ROM = Path(__file__).parent.parent / "Nobunaga's Ambition (USA).nes"

def cpu_to_file(cpu, bank=15):
    """Map CPU address in bank `bank` to file offset (header = $10)."""
    if bank == 15:
        return 0x10 + 15 * 0x4000 + (cpu - 0xC000)
    else:
        return 0x10 + bank * 0x4000 + (cpu - 0x8000)


def main():
    rom = ROM.read_bytes()

    # Dispatch tables at $F026 (low) and $F126 (high)
    lo_base = cpu_to_file(0xF026)
    hi_base = cpu_to_file(0xF126)

    # Build opcode -> handler map
    handlers = {}  # opcode -> addr
    addr_to_ops = {}  # addr -> [opcodes]
    for op in range(256):
        lo = rom[lo_base + op]
        hi = rom[hi_base + op]
        addr = lo | (hi << 8)
        handlers[op] = addr
        addr_to_ops.setdefault(addr, []).append(op)

    # Print opcode -> handler table
    print("=" * 78)
    print("NOBUNAGA VM DISPATCH TABLE (opcode -> handler in bank 15)")
    print("=" * 78)
    for op in range(256):
        addr = handlers[op]
        peers = [f"${o:02X}" for o in addr_to_ops[addr] if o != op]
        peer_note = f"  (shared with {','.join(peers)})" if peers else ""
        print(f"  ${op:02X}  ->  ${addr:04X}{peer_note}")

    # Now dump each unique handler's first 24 bytes
    print()
    print("=" * 78)
    print(f"UNIQUE HANDLERS: {len(addr_to_ops)} (out of 256 opcodes)")
    print("=" * 78)
    for addr in sorted(addr_to_ops.keys()):
        ops = addr_to_ops[addr]
        op_list = ','.join(f"${o:02X}" for o in ops)
        print(f"\n${addr:04X}   (opcodes: {op_list})")
        ofs = cpu_to_file(addr)
        # Print 24 bytes hex + try a crude disasm hint
        bytes_str = ' '.join(f'{rom[ofs+i]:02X}' for i in range(min(24, 0x10000 - addr)))
        print(f"  bytes: {bytes_str}")


if __name__ == "__main__":
    main()
