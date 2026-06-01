"""
native-call-index.py - who-calls-whom across the engine's native + bytecode code,
plus true-orphan detection. The backward half of the labeling walk: label a sub by
behavior, then ask "who calls this?" to recover its purpose.

Three edge sources are FUSED (a direct-jsr-only graph would flag dozens of false
orphans, because most kernel subs are reached indirectly):
  1. native jsr / jmp          - disasm/bank_{00,01,02,15}.asm  (b{NN}_hhhh or $hhhh operands)
  2. bytecode host_call        - disasm/bank_{00,01,02,15}_vm.asm  (E9/AC ... host_call $hhhh)
  3. ROM dispatch tables       - syscall $C173 (23), VM opcode $F026/$F126 (256),
                                 command driver $B9B2 (via command-table.txt)
Plus the hardware vectors (reset/nmi/irq).

Address resolution: a target >= $C000 is the FIXED bank 15; $8000-$BFFF is the
current file's (switchable) bank. Indirect `jmp (..)` is recorded as unresolved.

Commands (addr accepts C537 / 0xC537 / $C537):
  callers <addr>        every inbound edge (jsr / jmp / host_call / table / vector)
  calls   <addr>        every outbound edge from the sub starting at <addr>
  orphans [--bank N]    code subs with NO inbound edge (candidates for the walk /
                        indirect-only reach). [--named-only] restricts to toml labels.
  stats                 edge + coverage summary
"""
import argparse
import re
import sys
from collections import defaultdict
from pathlib import Path

PROJ = Path(__file__).resolve().parent.parent
DISASM = PROJ / "disasm"
ROM = PROJ / "Nobunaga's Ambition (USA).nes"
CMD_TABLE = PROJ / "command-table.txt"
CODE_BANKS = (0, 1, 2, 15)
INES_HEADER = 16

# import the toml parser from the sibling projector (single source of label truth)
sys.path.insert(0, str(PROJ / "tools"))
from importlib import import_module
_ml = import_module("mesen-labels")


def cpu_to_prgfile(bank, cpu):
    return INES_HEADER + bank * _ml.BANK_SIZE + (cpu & 0x3FFF)


def callee_bank(target, file_bank):
    """Fixed bank 15 owns $C000-$FFFF; $8000-$BFFF is the file's switchable bank."""
    return 15 if target >= 0xC000 else file_bank


# ---------------------------------------------------------------------------
# edges: list of (src_addr, dst_addr, kind, src_label)
# ---------------------------------------------------------------------------
CF_RE = re.compile(
    r"^\s*(?:([A-Za-z_]\w*):)?\s*"                # optional label def
    r"(jsr|jmp|bcc|bcs|beq|bne|bmi|bpl|bvc|bvs)\s+"  # control-flow mnemonic
    r"(\(?)([^\s;]+)"                            # operand (group3='(' if indirect)
    r".*?;\s*([0-9A-Fa-f]{4,6}):"                # trailing ; PRGOFFSET:
)
LABEL_DEF_RE = re.compile(r"^([A-Za-z_]\w*):.*?;\s*([0-9A-Fa-f]{4,6}):")
BNN_RE = re.compile(r"^b(\d+)_([0-9a-fA-F]{4})$")
HEX_OPERAND_RE = re.compile(r"^\$([0-9a-fA-F]{4})$")


def parse_native(bank, entry_targets):
    """Yield edges from a native disasm bank. entry_targets = set of known sub-entry
    addrs (jsr/host_call targets) used to attribute calls to the enclosing sub."""
    path = DISASM / f"bank_{bank:02d}.asm"
    if not path.exists():
        return [], {}
    edges = []
    defs = {}                     # addr -> label token at definition
    cur_entry = None              # addr of the enclosing sub-entry
    base = 0xC000 if bank == 15 else 0x8000
    for line in path.read_text(encoding="utf-8").splitlines():
        ld = LABEL_DEF_RE.match(line)
        if ld:
            laddr = base + (int(ld.group(2), 16) & 0x3FFF)
            defs[laddr] = ld.group(1)
            if laddr in entry_targets:
                cur_entry = laddr
        m = CF_RE.match(line)
        if not m:
            continue
        mnem, indirect, operand = m.group(2), m.group(3), m.group(4)
        src = base + (int(m.group(5), 16) & 0x3FFF)
        if indirect == "(":
            edges.append((cur_entry if cur_entry is not None else src, None,
                          mnem + "_indirect", defs.get(cur_entry)))
            continue
        b = BNN_RE.match(operand)
        if b:
            dst = int(b.group(2), 16)
        else:
            h = HEX_OPERAND_RE.match(operand)
            if not h:
                continue
            dst = int(h.group(1), 16)
        kind = "jsr" if mnem == "jsr" else ("jmp" if mnem == "jmp" else "branch")
        edges.append((cur_entry if cur_entry is not None else src, dst, kind,
                      defs.get(cur_entry)))
    return edges, defs


# bytecode call edges ------------------------------------------------------
# The VM disasm expresses EVERY inter-sub call as `CALL_abs $XXXX` / `CALL_abs_imm1
# $XXXX ..., $NN` (the imm1 form carries an arg-count byte). An older revision used a
# `host_call` mnemonic — kept here for back-compat, but today's disasm has 0 of those and
# 600+ CALL_abs per bank, so matching ONLY host_call silently dropped the whole bytecode
# call graph (every bytecode sub reported "0 callers"). Both forms become edges.
VM_SUB_RE = re.compile(r";\s*sub\s+\$([0-9A-Fa-f]{4})")
VM_CALL_RE = re.compile(r"\b(?:host_call(?:_simple)?|CALL_abs(?:_imm1)?)\s+\$([0-9A-Fa-f]{4})")


def parse_bytecode(bank):
    path = DISASM / f"bank_{bank:02d}_vm.asm"
    if not path.exists():
        return []
    edges = []
    cur = None
    for line in path.read_text(encoding="utf-8").splitlines():
        s = VM_SUB_RE.search(line)
        if s:
            cur = int(s.group(1), 16)
            continue
        c = VM_CALL_RE.search(line)
        if c and cur is not None:
            edges.append((cur, int(c.group(1), 16), "call_abs", None))
    return edges


# ROM dispatch tables ------------------------------------------------------
def read_bank15(rom):
    off = cpu_to_prgfile(15, 0xC000)
    return rom[off:off + _ml.BANK_SIZE]


def table_edges(rom):
    """syscall ($C173, 23x JMP abs), VM opcode ($F026 lo / $F126 hi, 256), and the
    command driver table (via command-table.txt). Returns edges with synthetic src."""
    edges = []
    b15 = read_bank15(rom)

    def at(cpu):
        return cpu - 0xC000

    # syscall dispatch: 23 entries, 3 bytes each (4C lo hi)
    base = at(0xC173)
    for i in range(23):
        lo, hi = b15[base + i * 3 + 1], b15[base + i * 3 + 2]
        edges.append((0xC173, lo | (hi << 8), "syscall_table", f"syscall[{i}]"))

    # VM opcode dispatch: parallel lo/hi tables, 256 entries
    lo_b, hi_b = at(0xF026), at(0xF126)
    for op in range(256):
        tgt = b15[lo_b + op] | (b15[hi_b + op] << 8)
        edges.append((0xF026, tgt, "vm_opcode_table", f"vm_op[${op:02X}]"))

    # command driver table $B9B2 (already extracted to command-table.txt)
    if CMD_TABLE.exists():
        for ln in CMD_TABLE.read_text(encoding="utf-8").splitlines():
            mm = re.match(r"\s*\d+\s+\d+\s+(\S+)\s+\$([0-9A-Fa-f]{4})", ln)
            if mm:
                edges.append((0xB9B2, int(mm.group(2), 16), "command_table",
                              f"cmd:{mm.group(1)}"))
    return edges


VECTORS = {0xC000: "RESET", 0xC0DA: "NMI", 0xC139: "IRQ"}


# ---------------------------------------------------------------------------
def build():
    labels = _ml.parse_toml()
    name = {}
    lab_bank = {}
    for lab in labels:
        name[lab.addr] = lab.name
        lab_bank[lab.addr] = lab.bank

    rom = ROM.read_bytes()

    # pass 1: collect entry targets (jsr / host_call / table / vector destinations)
    raw_native = {b: parse_native(b, set())[0] for b in CODE_BANKS}
    bytecode = [e for b in CODE_BANKS for e in parse_bytecode(b)]
    tables = table_edges(rom)

    entry_targets = set(VECTORS)
    for b in CODE_BANKS:
        for src, dst, kind, _ in raw_native[b]:
            if dst is not None and kind in ("jsr", "jmp"):
                entry_targets.add(dst)
    for _, dst, _, _ in bytecode:
        entry_targets.add(dst)
    for _, dst, _, _ in tables:
        entry_targets.add(dst)

    # pass 2: re-parse native attributing calls to enclosing sub-entries
    edges = []
    defs = {}
    for b in CODE_BANKS:
        e, d = parse_native(b, entry_targets)
        edges += e
        defs.update(d)
    edges += bytecode + tables
    for v, n in VECTORS.items():
        edges.append((None, v, "vector", n))

    inbound = defaultdict(list)   # dst -> [(src, kind, src_label)]
    outbound = defaultdict(list)  # src -> [(dst, kind)]
    for src, dst, kind, slabel in edges:
        if dst is not None:
            inbound[dst].append((src, kind, slabel))
        if src is not None and dst is not None:
            outbound[src].append((dst, kind))
    return name, lab_bank, defs, entry_targets, inbound, outbound


def fmt(addr, name):
    if addr is None:
        return "(none)"
    return f"${addr:04X} {name.get(addr, '')}".rstrip()


def parse_addr(s):
    return int(s.lstrip("$").replace("0x", "").replace("0X", ""), 16)


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = ap.add_subparsers(dest="cmd")
    p = sub.add_parser("callers"); p.add_argument("addr")
    p = sub.add_parser("calls"); p.add_argument("addr")
    p = sub.add_parser("orphans")
    p.add_argument("--bank", type=int); p.add_argument("--named-only", action="store_true")
    sub.add_parser("stats")
    args = ap.parse_args()

    name, lab_bank, defs, entries, inbound, outbound = build()

    if args.cmd == "callers":
        a = parse_addr(args.addr)
        ins = inbound.get(a, [])
        print(f"Callers of {fmt(a, name)}  ({len(ins)} inbound):")
        if not ins:
            print("  (none found via direct jsr/jmp, host_call, or dispatch tables)")
        for src, kind, slabel in sorted(ins, key=lambda x: (x[1], x[0] or 0)):
            who = (name.get(src) if src else None) or slabel or (f"${src:04X}" if src else "")
            at = f"  (${src:04X})" if src is not None and name.get(src) else ""
            print(f"  [{kind:16s}] {who}{at}")
        return

    if args.cmd == "calls":
        a = parse_addr(args.addr)
        outs = outbound.get(a, [])
        print(f"Outbound from {fmt(a, name)}  ({len(outs)}):")
        seen = set()
        for dst, kind in sorted(outs):
            if (dst, kind) in seen:
                continue
            seen.add((dst, kind))
            print(f"  [{kind:16s}] -> {fmt(dst, name)}")
        return

    if args.cmd == "orphans":
        # universe = toml-named code addrs + discovered entry targets
        universe = set(entries) | {a for a in name if a >= 0x8000}
        rows = []
        for a in sorted(universe):
            if a < 0x8000:
                continue
            if args.bank is not None:
                # named addrs carry their real bank; bare $8000-$BFFF targets are
                # bank-ambiguous so fall back to the fixed-bank rule.
                b = lab_bank.get(a) if lab_bank.get(a) is not None else callee_bank(a, args.bank)
                if b != args.bank:
                    continue
            if args.named_only and a not in name:
                continue
            if not inbound.get(a):
                rows.append(a)
        print(f"Orphans (no inbound edge): {len(rows)}")
        print("These have no direct/host_call/table caller -> the walk's targets, OR")
        print("reached by an unresolved indirect jmp. Named ones are worth purpose-checking.\n")
        for a in rows:
            print(f"  {fmt(a, name) or ('$%04X' % a):40s} {'<-NAMED' if a in name else ''}")
        return

    # stats
    kinds = defaultdict(int)
    for dsts in inbound.values():
        for _, kind, _ in dsts:
            kinds[kind] += 1
    print(f"Labels (toml): {len(name)}   entry targets: {len(entries)}")
    print("Inbound edges by kind:")
    for k, n in sorted(kinds.items(), key=lambda x: -x[1]):
        print(f"  {k:18s} {n}")
    named_code = [a for a in name if a >= 0x8000]
    orphan_named = [a for a in named_code if not inbound.get(a)]
    print(f"Named code subs: {len(named_code)}   with no inbound edge: {len(orphan_named)}")
    print("\n(use: callers <addr> | calls <addr> | orphans [--bank N] [--named-only])")


if __name__ == "__main__":
    main()
