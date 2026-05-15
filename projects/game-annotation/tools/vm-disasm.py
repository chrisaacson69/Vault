r"""
vm-disasm.py — Disassemble Nobunaga's Ambition VM bytecode.

The game's logic lives as bytecode in banks 0-14, interpreted by a stack/register
VM at bank 15 ($E823 onwards, chapter 5 details). This tool walks the bytecode,
decodes opcodes against a configurable operand-format spec, and emits annotated
VM-assembly listings.

Two traversal modes:
  - flow (default): recursive-descent. Follows jumps and branches, queues their
    targets, stops at vm_return. Does NOT walk through control flow into the
    operand bytes that follow it — so it stays byte-aligned through a whole
    subroutine. This is the mode you want for reading a real handler.
  - linear (--linear): the original straight walk. Useful for dumping a raw
    region when you don't trust the entry point or want to see data.

The opcode spec (vm-opcodes.toml) gives each opcode its operand format and an
optional `flow` field:
    flow = "jump_rel"    unconditional, target = next_pc + sbyte operand
    flow = "jump_abs"    unconditional, target = word operand
    flow = "branch_rel"  conditional,   target = next_pc + sbyte operand
    flow = "branch_abs"  conditional,   target = word operand
    flow = "call"        host_call — target recorded, execution continues after
    flow = "return"      ends the path (vm_return)
    flow = "switch"      $D5 jump table — variable length, path stops here

Usage:
    python vm-disasm.py <rom> <opcode-spec.toml> [--start ADDR] [--bank N]
                        [--length N] [--max-insns N] [--labels FILE] [--linear]
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
    """Read mesen-labels.toml; return cpu_addr -> name for PRG (code) labels."""
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
    """Return 'bytecode', 'native', 'ram', or '?' for a host_call target."""
    if 0xC000 <= target_cpu_addr <= 0xFFFF:
        prg_offset = 15 * PRG_BANK_SIZE + (target_cpu_addr & (PRG_BANK_SIZE - 1))
    elif 0x8000 <= target_cpu_addr <= 0xBFFF:
        prg_offset = current_bank * PRG_BANK_SIZE + (target_cpu_addr & (PRG_BANK_SIZE - 1))
    else:
        return "ram"
    if prg_offset + 3 > len(rom):
        return "?"
    if rom[prg_offset:prg_offset + 3] == BYTECODE_SUB_SIGNATURE:
        return "bytecode"
    return "native"


def cpu_to_prg_offset(cpu_addr: int, bank: int) -> int:
    return bank * PRG_BANK_SIZE + (cpu_addr & (PRG_BANK_SIZE - 1))


def bank_range(bank: int) -> tuple[int, int]:
    """CPU address window a given bank occupies."""
    if bank == 15:
        return 0xC000, 0xFFFF
    return 0x8000, 0xBFFF


def try_read_string(rom, cpu_addr, bank, maxlen=48):
    """If cpu_addr points at a plausible null-terminated ASCII string, return it.

    The game's in-game text is stored as plain ASCII: printable bytes, $0A line
    breaks, $00 terminator, printf-style %s/%d format codes. Targets at
    $C000-$FFFF resolve in bank 15 (fixed); $8000-$BFFF in the given bank.
    Returns None if the bytes don't look like a string.
    """
    if 0xC000 <= cpu_addr <= 0xFFFF:
        prg = 15 * PRG_BANK_SIZE + (cpu_addr & (PRG_BANK_SIZE - 1))
    elif 0x8000 <= cpu_addr <= 0xBFFF:
        prg = bank * PRG_BANK_SIZE + (cpu_addr & (PRG_BANK_SIZE - 1))
    else:
        return None
    out = []
    for i in range(maxlen):
        if prg + i >= len(rom):
            break
        b = rom[prg + i]
        if b == 0x00:
            break
        if b == 0x0A:
            out.append("\\n")
        elif 0x20 <= b <= 0x7E:
            out.append(chr(b))
        else:
            return None  # non-text byte -> not a string
    s = "".join(out)
    # require some real letters so we don't tag stray printable data
    if len(s) >= 3 and sum(c.isalpha() for c in s) >= 2:
        return s
    return None


def decode_instruction(rom, prg, pc, op, spec, bank, handlers, labels):
    """Decode one opcode + operands at PRG offset `prg`.

    Returns a dict:
        consume        total instruction length in bytes
        line           formatted listing line (without leading PC handling)
        flow           the spec's flow tag, or None
        target         resolved branch/jump target CPU addr, or None
        call_target    host_call target CPU addr, or None
        is_unknown     True if the opcode had no spec entry
    """
    handler = handlers[op]

    if spec is None:
        line = (f"{op:02X}                          "
                f"(unknown op ${op:02X})         ; handler={addr_str(handler, labels)}")
        return dict(consume=1, line=line, flow=None, target=None,
                    call_target=None, is_unknown=True)

    operand_specs = spec.get("operands", [])
    operand_bytes = []
    operand_values = []
    consume = 1
    for opspec in operand_specs:
        t = opspec["type"]
        if t == "word":
            if prg + consume + 1 >= len(rom):
                break
            low = rom[prg + consume]
            high = rom[prg + consume + 1]
            operand_bytes.extend([low, high])
            operand_values.append(("word", (high << 8) | low))
            consume += 2
        elif t in ("byte", "sbyte"):
            if prg + consume >= len(rom):
                break
            b = rom[prg + consume]
            operand_bytes.append(b)
            operand_values.append((t, b))
            consume += 1

    all_bytes = [op] + operand_bytes
    bytes_str = " ".join(f"{b:02X}" for b in all_bytes)
    op_name = spec.get("name", f"op_{op:02X}")
    is_host_call = op_name.startswith("host_call")

    # Opcodes whose word literal is frequently a pointer to in-game ASCII text.
    string_carrier = op_name in (
        "push_imm_word", "loadA_imm_word", "loadB_imm_word",
        "loadA_mem_word", "loadB_mem_word",
    )

    operand_strs = []
    string_hint = None
    for idx, (t, v) in enumerate(operand_values):
        if t == "word":
            s = addr_str(v, labels)
            if is_host_call and idx == 0:
                tag = classify_host_call_target(v, rom, bank)
                if tag in ("bytecode", "native"):
                    s += f" {{{tag}}}"
            if string_carrier and string_hint is None:
                string_hint = try_read_string(rom, v, bank)
            operand_strs.append(s)
        elif t == "byte":
            operand_strs.append(f"${v:02X}")
        elif t == "sbyte":
            sv = v - 256 if v >= 128 else v
            operand_strs.append(f"{sv:+d}")
    operand_text = ", ".join(operand_strs)

    annotation = spec.get("description", "")
    if spec.get("operand_in_opcode") == "low_4_bits":
        annotation = f"{annotation}  (inline operand = {op & 0x0F})".strip()
    if string_hint is not None:
        # the resolved string is the most useful annotation — lead with it
        annotation = f'"{string_hint}"' + (f"  | {annotation}" if annotation else "")

    line = f"{bytes_str:28s}{op_name:24s} {operand_text}"
    if annotation:
        line = f"{line:<78s} ; {annotation}"

    # --- control-flow resolution ---
    flow = spec.get("flow")
    target = None
    call_target = None
    next_pc = pc + consume
    if flow in ("jump_rel", "branch_rel") and operand_values:
        t, v = operand_values[0]
        sv = v - 256 if v >= 128 else v
        target = next_pc + sv
    elif flow in ("jump_abs", "branch_abs") and operand_values:
        t, v = operand_values[0]
        target = v
    elif flow == "call" and operand_values and operand_values[0][0] == "word":
        call_target = operand_values[0][1]

    return dict(consume=consume, line=line, flow=flow, target=target,
                call_target=call_target, is_unknown=False)


def disasm_flow(rom, start, bank, op_lookup, handlers, labels, max_insns):
    """Recursive-descent walk: follow jumps/branches, stop at returns.

    Returns (lines, stats). Stays byte-aligned through a whole subroutine
    because it never decodes the bytes that a control-flow opcode jumps over.
    """
    lo, hi = bank_range(bank)
    decoded = {}            # cpu_addr -> dict from decode_instruction
    worklist = [start]
    queued = {start}        # everything ever placed on the worklist
    call_targets = []       # (from_pc, target) for the summary
    branch_targets = set()  # addrs that are jump/branch destinations (for labels)

    while worklist:
        pc = worklist.pop()
        while True:
            if pc in decoded:
                break
            if not (lo <= pc <= hi):
                break
            prg = cpu_to_prg_offset(pc, bank)
            if prg >= len(rom):
                break
            op = rom[prg]
            spec = op_lookup.get(op)
            info = decode_instruction(rom, prg, pc, op, spec, bank, handlers, labels)
            decoded[pc] = info
            if len(decoded) >= max_insns:
                worklist.clear()
                break

            flow = info["flow"]
            if info["call_target"] is not None:
                call_targets.append((pc, info["call_target"]))

            if flow == "return" or flow == "switch":
                break
            if flow in ("jump_rel", "jump_abs"):
                tgt = info["target"]
                if tgt is not None and lo <= tgt <= hi:
                    branch_targets.add(tgt)
                    if tgt not in queued:
                        queued.add(tgt)
                        worklist.append(tgt)
                break  # unconditional — no fall-through
            if flow in ("branch_rel", "branch_abs"):
                tgt = info["target"]
                if tgt is not None and lo <= tgt <= hi:
                    branch_targets.add(tgt)
                    if tgt not in queued:
                        queued.add(tgt)
                        worklist.append(tgt)
                # conditional — fall through to next_pc as well

            pc = pc + info["consume"]

    # --- render, sorted by address, with gap markers ---
    lines = []
    addrs = sorted(decoded)
    known = sum(1 for a in addrs if not decoded[a]["is_unknown"])
    unknown = len(addrs) - known
    prev_end = None
    for a in addrs:
        info = decoded[a]
        if prev_end is not None and a != prev_end:
            if a > prev_end:
                lines.append(f"  ; ---- gap ${prev_end:04X}-${a-1:04X} "
                             f"({a - prev_end} bytes not on any traced path) ----")
            else:
                lines.append(f"  ; ---- overlap: ${a:04X} re-entered mid-stream ----")
        marker = ">" if a in branch_targets else " "
        lines.append(f" {marker}${a:04X}  {info['line']}")
        prev_end = a + info["consume"]

    lines.append("")
    lines.append(f"  ; {known} known + {unknown} unknown opcodes across "
                 f"{len(addrs)} instructions; {len(branch_targets)} branch targets")
    if call_targets:
        uniq = sorted(set(t for _, t in call_targets))
        lines.append(f"  ; host_call targets: "
                     + ", ".join(addr_str(t, labels) for t in uniq))
    return lines


def disasm_linear(rom, start_cpu_addr, bank, length, handlers, op_lookup, labels):
    """Original straight-line walk — decode `length` bytes from `start`."""
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
        spec = op_lookup.get(op)
        info = decode_instruction(rom, base_prg + pos, pc, op, spec,
                                  bank, handlers, labels)
        lines.append(f"  ${pc:04X}  {info['line']}")
        pos += info["consume"]
        if info["is_unknown"]:
            unknown_count += 1
        else:
            known_count += 1
    lines.append("")
    lines.append(f"  ; {known_count} known, {unknown_count} unknown opcodes in {pos} bytes")
    return lines


def main() -> int:
    parser = argparse.ArgumentParser(description="Disassemble Nobunaga VM bytecode.")
    parser.add_argument("rom", type=Path, help="ROM file (.nes)")
    parser.add_argument("opcode_spec", type=Path, help="Opcode operand-format TOML")
    parser.add_argument("--start", type=lambda x: int(x, 0), default=0xA77B,
                        help="Start CPU address (default $A77B)")
    parser.add_argument("--bank", type=int, default=0, help="PRG bank index (default 0)")
    parser.add_argument("--length", type=int, default=200,
                        help="Bytes to disassemble in --linear mode (default 200)")
    parser.add_argument("--max-insns", type=int, default=400,
                        help="Instruction cap in flow mode (default 400)")
    parser.add_argument("--labels", type=Path, default=None,
                        help="mesen-labels.toml for friendly address rendering")
    parser.add_argument("--linear", action="store_true",
                        help="Use the old straight-line walk instead of flow following")
    args = parser.parse_args()

    rom = load_rom(args.rom)
    handlers = extract_opcode_handlers(rom)
    op_lookup = load_opcode_spec(args.opcode_spec)
    labels = load_labels(args.labels) if args.labels else {}

    mode = "linear" if args.linear else "flow (control-flow following)"
    print(f"VM bytecode disassembly")
    print(f"  ROM:          {args.rom}  ({len(rom)} bytes after header)")
    print(f"  start:        ${args.start:04X} (bank {args.bank}, "
          f"PRG ${cpu_to_prg_offset(args.start, args.bank):05X})")
    print(f"  mode:         {mode}")
    print(f"  opcode spec:  {args.opcode_spec} ({len(op_lookup)} of 256 opcodes defined)")
    print(f"  labels:       {len(labels)} CPU addresses named")
    print()

    if args.linear:
        lines = disasm_linear(rom, args.start, args.bank, args.length,
                              handlers, op_lookup, labels)
    else:
        lines = disasm_flow(rom, args.start, args.bank, op_lookup,
                            handlers, labels, args.max_insns)
    for line in lines:
        print(line)
    return 0


if __name__ == "__main__":
    sys.exit(main())
