"""Analyze the Nobunaga VM's 256-entry opcode dispatch table (bank 15).

Consolidates the former opcode trio (opcode-survey / dump-dispatch / opcode-classify),
all of which read the same dispatch table at $F026 (low bytes) / $F126 (high bytes).

Modes:
  survey    opcode -> handler map, clustered by handler and sorted by frequency
            (tackle high-use handlers first). [was opcode-survey.py]
  dispatch  full opcode -> handler table + first N native bytes of each unique
            handler (default 24). [was dump-dispatch.py]
  classify  classify each handler by its operand-fetch pattern (word/byte/sbyte/
            no_operand/opcode_operand/...). [was opcode-classify.py]

ROM defaults to "Nobunaga's Ambition (USA).nes" in the project root; override with
a positional path. Output of `dispatch`/`survey` feeds vm-opcodes-v2.toml by hand.
"""

import argparse
from collections import defaultdict
from pathlib import Path

DEFAULT_ROM = Path(__file__).parent.parent / "Nobunaga's Ambition (USA).nes"

# Dispatch table file offsets (iNES header included): bank 15, $F026 / $F126.
LO_OFS = 0x3F026 + 0x10
HI_OFS = 0x3F126 + 0x10


def cpu_to_file(addr, bank=15):
    """Map a CPU address to a file offset (iNES header = $10)."""
    if bank == 15:
        return 0x10 + 15 * 0x4000 + (addr - 0xC000)
    return 0x10 + bank * 0x4000 + (addr - 0x8000)


def load(rom_path):
    """Return (rom_bytes, opcode->handler list, handler->opcodes dict)."""
    rom = Path(rom_path).read_bytes()
    handlers = [rom[LO_OFS + op] | (rom[HI_OFS + op] << 8) for op in range(256)]
    clusters = defaultdict(list)
    for op, h in enumerate(handlers):
        clusters[h].append(op)
    return rom, handlers, clusters


def _compress(ops):
    """Compress a sorted opcode list into hex ranges, e.g. '$00-$03 $10'."""
    out, start, prev = [], ops[0], ops[0]
    for o in ops[1:]:
        if o == prev + 1:
            prev = o
        else:
            out.append(f"${start:02X}" if start == prev else f"${start:02X}-${prev:02X}")
            start = prev = o
    out.append(f"${start:02X}" if start == prev else f"${start:02X}-${prev:02X}")
    return out


# --- mode: survey -----------------------------------------------------------

def mode_survey(rom, handlers, clusters):
    print(f"Total unique handlers: {len(clusters)}\n")
    print(f"{'handler':<8} {'count':>5}  opcodes (hex)")
    for h, ops in sorted(clusters.items(), key=lambda x: -len(x[1])):
        print(f"${h:04X}    {len(ops):>5}  {' '.join(_compress(ops))}")


# --- mode: dispatch ---------------------------------------------------------

def mode_dispatch(rom, handlers, clusters, nbytes=24):
    print("=" * 78)
    print("NOBUNAGA VM DISPATCH TABLE (opcode -> handler in bank 15)")
    print("=" * 78)
    for op in range(256):
        addr = handlers[op]
        peers = [f"${o:02X}" for o in clusters[addr] if o != op]
        peer_note = f"  (shared with {','.join(peers)})" if peers else ""
        print(f"  ${op:02X}  ->  ${addr:04X}{peer_note}")

    print()
    print("=" * 78)
    print(f"UNIQUE HANDLERS: {len(clusters)} (out of 256 opcodes)")
    print("=" * 78)
    for addr in sorted(clusters):
        ops = ','.join(f"${o:02X}" for o in clusters[addr])
        print(f"\n${addr:04X}   (opcodes: {ops})")
        ofs = cpu_to_file(addr)
        n = min(nbytes, 0x10000 - addr)
        print(f"  bytes: {' '.join(f'{rom[ofs+i]:02X}' for i in range(n))}")


# --- mode: classify ---------------------------------------------------------

# JSR target -> (operand-format-name, byte-count)
OPERAND_FETCH_HELPERS = {
    0xEFD5: ("word", 2),    # vm_read_word_into_ptr0
    0xEFA6: ("byte", 1),
    0xEFC0: ("byte", 1),
    0xEFEC: ("byte", 1),
    0xEFBF: ("byte", 1),
    0xEF97: ("sbyte", 1),   # signed byte
    0xEFD3: ("byte", 1),
}


def classify_handler(rom, handler_addr):
    """Read up to ~16 instructions of a handler; return its operand-format tag.

    Fast byte-walking heuristic (not a full disassembler): operand fetches almost
    always happen at the very start of a handler.
    """
    prg = cpu_to_file(handler_addr)

    # Pure JMP vm_dispatch ($E867) => NOP-like, no operand.
    if rom[prg:prg + 3] == bytes([0x4C, 0x67, 0xE8]):
        return "nop"

    operands = []
    operand_in_opcode = False
    pos, seen, max_scan = prg, set(), 40
    while pos < prg + max_scan and len(operands) < 3:
        if pos in seen or pos >= len(rom):
            break
        seen.add(pos)
        op = rom[pos]
        if op == 0x20:  # JSR abs
            if pos + 2 < len(rom):
                target = rom[pos + 1] | (rom[pos + 2] << 8)
                if target in OPERAND_FETCH_HELPERS:
                    operands.append(OPERAND_FETCH_HELPERS[target][0])
                if target == 0xE867:  # jsr vm_dispatch ends classification
                    break
            pos += 3
        elif op == 0x4C:  # JMP abs - always end of handler
            if pos + 2 < len(rom):
                tail = rom[pos + 1] | (rom[pos + 2] << 8)
                if tail == 0xEB9E:  # host_call_E9 tail: jsr ef97 = sbyte adjustment byte
                    operands.append("byte")
            break
        elif op in (0x60, 0x40, 0x6C):  # RTS / RTI / JMP indirect
            break
        elif op == 0x8A:  # TXA - opcode-as-operand cluster start (txa / and #$0f)
            if pos + 2 < len(rom) and rom[pos + 1] == 0x29 and rom[pos + 2] == 0x0F:
                operand_in_opcode = True
            pos += 1
        elif op == 0x29:  # AND immediate
            pos += 2
        elif op in (0x18, 0x38, 0x88, 0xA8, 0xAA, 0xBA, 0xC8, 0xCA, 0xE8, 0xEA):
            pos += 1  # implied
        elif op in (0xA9, 0xA0, 0xA2, 0x69, 0xE9, 0xC9, 0xC0, 0xE0):
            pos += 2  # immediate
        elif op in (0x10, 0x30, 0x50, 0x70, 0x90, 0xB0, 0xD0, 0xF0):
            pos += 2  # relative branch
        elif op in (0x85, 0x95, 0xA5, 0xB5, 0x65, 0x75, 0x86, 0x96, 0xA6, 0xB6,
                    0x84, 0x94, 0xA4, 0xB4, 0x24, 0xC5, 0xC6, 0xE6, 0xE5,
                    0xC4, 0xE4, 0x26, 0x46, 0x66, 0x06, 0x05, 0x25, 0x45):
            pos += 2  # zero-page
        elif op in (0x8D, 0x9D, 0xAD, 0xBD, 0x6D, 0x7D, 0x8E, 0xAE, 0xBE,
                    0x8C, 0xAC, 0xBC, 0x2C, 0xCD, 0xCE, 0xEE, 0xED,
                    0xCC, 0xEC, 0x2E, 0x4E, 0x6E, 0x0E, 0x0D, 0x2D, 0x4D):
            pos += 3  # absolute
        else:
            pos += 1  # unknown, advance 1

    if operand_in_opcode and not operands:
        return "opcode_operand"
    if not operands:
        return "no_operand"
    return "_".join(operands)


def mode_classify(rom, handlers, clusters):
    by_format = defaultdict(list)
    for h, ops in clusters.items():
        fmt = classify_handler(rom, h)
        for op in ops:
            by_format[fmt].append((op, h))

    total = sum(len(v) for v in by_format.values())
    print(f"Total opcodes classified: {total}\n")
    for fmt, entries in sorted(by_format.items(), key=lambda x: -len(x[1])):
        print(f"=== {fmt}: {len(entries)} opcodes ===")
        ops = [op for op, _ in sorted(entries)]
        print(f"  opcodes: {' '.join(_compress(ops))}\n")


MODES = {"survey": mode_survey, "dispatch": mode_dispatch, "classify": mode_classify}


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("mode", choices=MODES, help="analysis mode")
    ap.add_argument("rom", nargs="?", default=str(DEFAULT_ROM), help="ROM path")
    ap.add_argument("--bytes", type=int, default=24,
                    help="dispatch mode: bytes per handler (default 24)")
    args = ap.parse_args()

    rom, handlers, clusters = load(args.rom)
    if args.mode == "dispatch":
        mode_dispatch(rom, handlers, clusters, args.bytes)
    else:
        MODES[args.mode](rom, handlers, clusters)


if __name__ == "__main__":
    main()
