"""
vm-opcode-labels.py - propose `vm_op_XX_<mnemonic>` labels for the VM-opcode
dispatch handlers, mechanically (Layer-1 propagation, like the ext-op resolver).

The 256-entry VM opcode table ($F026 lo / $F126 hi, bank 15) maps each opcode byte
to its native handler. The handler SEMANTICS are already validated in
vm_decompile.OPCODE_TO_MNEMONIC, but the handler ADDRESSES are mostly unnamed in
mesen-labels.toml -> they read as bare `b15_XXXX:` in the native disasm and the
call-index. This tool reads the ROM table, groups opcodes by handler address, and
proposes a toml label per UNNAMED distinct handler, derived from the opcode(s) that
reach it. Deterministic (fixed ROM). Output is reviewed, then merged by hand.

Usage:  py -3 tools/vm-opcode-labels.py            # report + proposed toml lines
        py -3 tools/vm-opcode-labels.py --toml      # only the toml lines (for merge)
"""
import re
import sys
from importlib import import_module
from pathlib import Path
from collections import defaultdict

PROJ = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(PROJ / "tools"))
_ml = import_module("mesen-labels")
_vd = import_module("vm_decompile")

ROM = PROJ / "Nobunaga's Ambition (USA).nes"
INES = 16
MNEM = _vd.OPCODE_TO_MNEMONIC


def sanitize(s):
    out = "".join(c if (c.isalnum() or c == "_") else "_" for c in s)
    return ("_" + out) if out and out[0].isdigit() else out


def main():
    toml_only = "--toml" in sys.argv
    rom = ROM.read_bytes()
    base = INES + 15 * _ml.BANK_SIZE            # bank 15 fixed
    lo = base + (0xF026 - 0xC000)
    hi = base + (0xF126 - 0xC000)

    # opcode -> handler addr
    op_addr = {op: rom[lo + op] | (rom[hi + op] << 8) for op in range(256)}
    addr_ops = defaultdict(list)
    for op, a in op_addr.items():
        addr_ops[a].append(op)

    # existing toml names
    named = {lab.addr: lab.name for lab in _ml.parse_toml()}

    rows, cats = build_rows(addr_ops, named)

    if "--write" in sys.argv:
        write_block(rows)
        return
    if toml_only:
        for addr, nm, ops, note, _ in rows:
            print(toml_line(addr, nm, ops, note))
        return

    print(f"256 opcodes -> {len(addr_ops)} distinct handler addrs")
    print("Categories:")
    for k, v in sorted(cats.items(), key=lambda x: -x[1]):
        print(f"  {k:22s} {v}")
    print(f"\nProposed new labels: {len(rows)}\n")
    for addr, nm, ops, note, _ in rows:
        opl = ",".join(f"${o:02X}" for o in ops)
        flag = "  <-- REVIEW" if "REVIEW" in note else ""
        print(f"  ${addr:04X}  {nm:34s} [{note}]  ops={opl}{flag}")


def clean_mnem(op, mn):
    """Drop the placeholder 'op_XX_' prefix so 'op_84_bwb' -> 'bwb', 'op_CB' -> ''."""
    if mn and mn.startswith("op_"):
        mn = re.sub(r"^op_[0-9A-Fa-f]{2}_?", "", mn)
    return mn or None


def build_rows(addr_ops, named):
    rows = []          # (addr, name, opcodes, note, comment)
    cats = defaultdict(int)
    for addr in sorted(addr_ops):
        ops = addr_ops[addr]
        if addr in named:
            cats["already_named"] += 1
            continue
        opl = ",".join(f"${o:02X}" for o in ops)
        mnems = {MNEM.get(o) for o in ops}
        mnems.discard(None)
        if len(ops) == 1:
            op = ops[0]
            mn = clean_mnem(op, MNEM.get(op))
            if mn:
                rows.append((addr, f"vm_op_{op:02X}_{sanitize(mn)}", ops, "single",
                             f"VM opcode ${op:02X} handler ({MNEM.get(op)})."))
                cats["single_named_mnem"] += 1
            else:
                rows.append((addr, f"vm_op_{op:02X}", ops, "single, NO mnemonic",
                             f"VM opcode ${op:02X} handler. UNDECODED -- no decompiler "
                             f"mnemonic yet; analytical target (read body to decode)."))
                cats["single_no_mnem"] += 1
        else:
            rep = min(ops)
            if mnems and all(m.startswith("trigger_syscall") for m in mnems):
                rows.append((addr, "vm_op_trigger_syscall_shared", ops, "syscall-trigger sink",
                             f"Shared VM-opcode handler that triggers a host syscall, reached by "
                             f"{len(ops)} opcodes ({opl}). The opcode byte selects the syscall."))
                cats["syscall_trigger_shared"] += 1
            elif len(mnems) == 1:
                mn = clean_mnem(rep, next(iter(mnems))) or f"{rep:02X}"
                rows.append((addr, f"vm_op_{sanitize(mn)}_shared", ops,
                             f"shared by {len(ops)} ops, same mnem",
                             f"Shared VM-opcode handler for {len(ops)} opcodes ({opl})."))
                cats["shared_same_mnem"] += 1
            elif not mnems:
                rows.append((addr, "vm_op_undefined_sink", ops,
                             f"shared by {len(ops)} ops, undefined sink",
                             f"Shared sink for {len(ops)} undefined opcodes ({opl})."))
                cats["undefined_sink"] += 1
            else:
                rows.append((addr, f"vm_op_{rep:02X}_shared", ops,
                             f"shared by {len(ops)} ops, MIXED mnems {sorted(mnems)} -- REVIEW",
                             f"Shared VM-opcode handler for {len(ops)} opcodes ({opl}) -- REVIEW."))
                cats["shared_mixed"] += 1
    return rows, cats


def toml_line(addr, nm, ops, note, comment=None):
    if comment is None:
        opl = ",".join(f"${o:02X}" for o in ops)
        comment = f"VM opcode handler for {opl} ({note})."
    return f'"0x{addr:04X}" = {{ name = "{nm}", comment = "{comment}" }}'


BLOCK_START = "# >>> AUTO: VM-opcode handler labels (tools/vm-opcode-labels.py --write)"
BLOCK_END = "# <<< AUTO: VM-opcode handler labels"
ANCHOR = "# --- Bank 0 ---"


def write_block(rows):
    """Idempotently splice the generated labels into mesen-labels.toml [prg.bank15],
    just before the '# --- Bank 0 ---' marker. Re-running replaces the prior block."""
    toml = PROJ / "mesen-labels.toml"
    text = toml.read_text(encoding="utf-8")
    # strip any prior auto block
    text = re.sub(re.escape(BLOCK_START) + r".*?" + re.escape(BLOCK_END) + r"\n*",
                  "", text, flags=re.DOTALL)
    if ANCHOR not in text:
        sys.exit(f"ERROR: anchor {ANCHOR!r} not found in toml; aborting (no blind append).")
    lines = [BLOCK_START,
             f"# 256 VM opcodes -> handlers via $F026/$F126; mechanically named from the",
             f"# validated vm_decompile.OPCODE_TO_MNEMONIC. Regenerate: vm-opcode-labels.py --write."]
    for addr, nm, ops, note, comment in rows:
        lines.append(toml_line(addr, nm, ops, note, comment))
    lines.append(BLOCK_END)
    block = "\n".join(lines) + "\n\n"
    text = text.replace(ANCHOR, block + ANCHOR, 1)
    toml.write_text(text, encoding="utf-8")
    print(f"Wrote {len(rows)} VM-opcode handler labels into {toml.name} (idempotent block).")


if __name__ == "__main__":
    main()
