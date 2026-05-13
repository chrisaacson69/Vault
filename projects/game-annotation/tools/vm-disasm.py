r"""
vm-disasm.py — Disassemble Nobunaga's Ambition VM bytecode.

The game's logic lives as bytecode in banks 0-14, interpreted by a stack-based
VM at bank 15 ($E823 onwards, chapter 5 details). This tool walks the bytecode,
decodes opcodes against a configurable operand-format spec, and emits annotated
VM-assembly listings.

Strategy: iterative coverage. The opcode-spec TOML starts with the handful of
opcodes we've decoded; unknown opcodes are emitted as raw bytes annotated with
their handler addresses (so we know which routines to walk next). After each
session decoding a few new handlers, we re-run and get richer output.

Usage:
    python vm-disasm.py <rom> <opcode-spec.toml> [--start ADDR] [--bank N]
                                                   [--length N] [--labels FILE]

Default: disassemble 200 bytes starting at $A77B in bank 0 (the VM bytecode
entry point after the JSR $E823 at $A778).
"""

import argparse
import sys
import tomllib
from pathlib import Path


# Hard-coded for Nobunaga (could be config in opcode-spec if we generalize).
TABLE_LO_PRG_OFFSET = 0x3F026     # CPU $F026 in bank 15
TABLE_HI_PRG_OFFSET = 0x3F126     # CPU $F126 in bank 15
PRG_BANK_SIZE = 0x4000


def load_rom(path: Path) -> bytes:
    """Load ROM bytes, skipping the 16-byte iNES header."""
    data = path.read_bytes()
    if data[:4] != b"NES\x1a":
        raise ValueError(f"{path} doesn't have an iNES header")
    return data[16:]


def extract_opcode_handlers(rom: bytes) -> list[int]:
    """Return 256 16-bit handler addresses from the VM dispatch table."""
    lo = rom[TABLE_LO_PRG_OFFSET : TABLE_LO_PRG_OFFSET + 256]
    hi = rom[TABLE_HI_PRG_OFFSET : TABLE_HI_PRG_OFFSET + 256]
    return [(hi[i] << 8) | lo[i] for i in range(256)]


def load_opcode_spec(path: Path) -> dict:
    """Read opcode operand-format spec; return op_value -> entry lookup."""
    with path.open("rb") as f:
        config = tomllib.load(f)
    lookup = {}
    for entry in config.get("opcode", []):
        if "op" in entry:
            lookup[entry["op"]] = entry
        elif "op_range" in entry:
            lo, hi = entry["op_range"]
            for op in range(lo, hi + 1):
                if op not in lookup:    # explicit single-op entries win over range
                    lookup[op] = entry
    return lookup


def load_labels(path: Path) -> dict[int, str]:
    """Read mesen-labels.toml; return cpu_addr -> name for PRG (code) labels.

    Returns a flat map of CPU address -> name across all banks. Note that a
    name like 'syscall_dispatch' is in bank 15 at CPU $F226 — we use the
    CPU address directly since that's what bytecode references via host_call.
    """
    out = {}
    with path.open("rb") as f:
        cfg = tomllib.load(f)
    for bank_section, entries in cfg.get("prg", {}).items():
        for hex_key, info in entries.items():
            addr = int(hex_key, 16)
            out[addr] = info["name"]
    return out


def addr_str(addr: int, labels: dict[int, str]) -> str:
    """Format an address as $XXXX, with label annotation if known."""
    if addr in labels:
        return f"${addr:04X} ({labels[addr]})"
    return f"${addr:04X}"


# JSR $E823 = bytes 20 23 E8 — the signature of a bytecode-subroutine entry stub.
BYTECODE_SUB_SIGNATURE = bytes([0x20, 0x23, 0xE8])


def classify_host_call_target(target_cpu_addr: int, rom: bytes, current_bank: int) -> str:
    """Return a tag describing what's at the host_call target.

    Returns 'bytecode' if the first 3 bytes are JSR $E823 (a bytecode subroutine
    entry stub), 'native' otherwise.

    Bank handling: targets at $C000-$FFFF are always in bank 15 (fixed). Targets
    at $8000-$BFFF are in whichever bank is currently mapped — we use current_bank
    as the best guess. For accurate cross-bank resolution we'd need to track bank
    state through bytecode execution, which we don't (yet).
    """
    if 0xC000 <= target_cpu_addr <= 0xFFFF:
        # Bank 15 (fixed kernel area)
        prg_offset = 15 * PRG_BANK_SIZE + (target_cpu_addr & (PRG_BANK_SIZE - 1))
    elif 0x8000 <= target_cpu_addr <= 0xBFFF:
        prg_offset = current_bank * PRG_BANK_SIZE + (target_cpu_addr & (PRG_BANK_SIZE - 1))
    else:
        return "ram"  # target in RAM is unusual but possible
    if prg_offset + 3 > len(rom):
        return "?"
    if rom[prg_offset:prg_offset + 3] == BYTECODE_SUB_SIGNATURE:
        return "bytecode"
    return "native"


def cpu_to_prg_offset(cpu_addr: int, bank: int) -> int:
    return bank * PRG_BANK_SIZE + (cpu_addr & (PRG_BANK_SIZE - 1))


def disasm(rom: bytes,
           start_cpu_addr: int,
           bank: int,
           length: int,
           handlers: list[int],
           op_lookup: dict[int, dict],
           labels: dict[int, str]) -> list[str]:
    """Walk bytecode; return list of formatted lines.

    Each line shows: PC, raw bytes, opcode name, decoded operands, annotations.
    Unknown opcodes are emitted as 1-byte raw with a "(unknown)" tag and the
    handler address for follow-up.
    """
    base_prg = cpu_to_prg_offset(start_cpu_addr, bank)
    lines = []
    pos = 0
    unknown_count = 0
    known_count = 0

    while pos < length:
        if base_prg + pos >= len(rom):
            lines.append(f"  ; ROM ended at PRG ${base_prg + pos:05X}")
            break

        pc = start_cpu_addr + pos
        op = rom[base_prg + pos]
        handler = handlers[op]
        spec = op_lookup.get(op)

        if spec is None:
            # Unknown — emit raw byte with handler annotation
            lines.append(
                f"  ${pc:04X}  {op:02X}                          "
                f"(unknown op ${op:02X})         ; handler={addr_str(handler, labels)}"
            )
            pos += 1
            unknown_count += 1
            continue

        # Known opcode — consume operands
        operand_specs = spec.get("operands", [])
        operand_bytes = []
        operand_values = []
        consume = 1   # opcode byte itself
        for opspec in operand_specs:
            t = opspec["type"]
            if t == "word":
                if base_prg + pos + consume + 1 >= len(rom):
                    break
                low = rom[base_prg + pos + consume]
                high = rom[base_prg + pos + consume + 1]
                operand_bytes.extend([low, high])
                operand_values.append(("word", (high << 8) | low))
                consume += 2
            elif t == "byte" or t == "sbyte":
                if base_prg + pos + consume >= len(rom):
                    break
                b = rom[base_prg + pos + consume]
                operand_bytes.append(b)
                operand_values.append((t, b))
                consume += 1

        # Format the bytes column
        all_bytes = [op] + operand_bytes
        bytes_str = " ".join(f"{b:02X}" for b in all_bytes)

        # Format the operand-rendering
        op_name = spec.get("name", f"op_{op:02X}")
        operand_strs = []
        is_host_call = op_name.startswith("host_call")
        for idx, (t, v) in enumerate(operand_values):
            if t == "word":
                operand_str = addr_str(v, labels)
                # For host_call's first word operand, classify the target.
                if is_host_call and idx == 0:
                    tag = classify_host_call_target(v, rom, bank)
                    if tag == "bytecode":
                        operand_str += " {bytecode}"
                    elif tag == "native":
                        operand_str += " {native}"
                operand_strs.append(operand_str)
            elif t == "byte":
                operand_strs.append(f"${v:02X}")
            elif t == "sbyte":
                # signed byte: show as +/-N
                sv = v - 256 if v >= 128 else v
                operand_strs.append(f"{sv:+d}")
        operand_text = ", ".join(operand_strs)

        # Opcode-as-operand annotation for shared-handler clusters
        annotation = spec.get("description", "")
        if spec.get("operand_in_opcode"):
            field = spec["operand_in_opcode"]
            if field == "low_4_bits":
                inline = op & 0x0F
                annotation = f"{annotation}  (inline operand = {inline})".strip()

        line = f"  ${pc:04X}  {bytes_str:28s}{op_name:24s} {operand_text}"
        if annotation:
            line = f"{line:<80s} ; {annotation}"
        lines.append(line)
        pos += consume
        known_count += 1

    lines.append("")
    lines.append(f"  ; {known_count} known, {unknown_count} unknown opcodes in {pos} bytes")
    return lines


def main() -> int:
    parser = argparse.ArgumentParser(description="Disassemble Nobunaga VM bytecode.")
    parser.add_argument("rom", type=Path, help="ROM file (.nes)")
    parser.add_argument("opcode_spec", type=Path, help="Opcode operand-format TOML")
    parser.add_argument("--start", type=lambda x: int(x, 0), default=0xA77B,
                        help="Start CPU address (default $A77B = bytecode entry after JSR)")
    parser.add_argument("--bank", type=int, default=0, help="PRG bank index (default 0)")
    parser.add_argument("--length", type=int, default=200, help="Bytes to disassemble")
    parser.add_argument("--labels", type=Path, default=None,
                        help="mesen-labels.toml to render label names in operands")
    args = parser.parse_args()

    rom = load_rom(args.rom)
    handlers = extract_opcode_handlers(rom)
    op_lookup = load_opcode_spec(args.opcode_spec)
    labels = load_labels(args.labels) if args.labels else {}

    print(f"VM bytecode disassembly")
    print(f"  ROM:          {args.rom}  ({len(rom)} bytes after header)")
    print(f"  start:        ${args.start:04X} (bank {args.bank}, "
          f"PRG ${cpu_to_prg_offset(args.start, args.bank):05X})")
    print(f"  length:       {args.length} bytes")
    print(f"  opcode spec:  {args.opcode_spec} ({len(op_lookup)} of 256 opcodes defined)")
    print(f"  labels:       {len(labels)} CPU addresses named")
    print()

    lines = disasm(rom, args.start, args.bank, args.length,
                   handlers, op_lookup, labels)
    for line in lines:
        print(line)
    return 0


if __name__ == "__main__":
    sys.exit(main())
