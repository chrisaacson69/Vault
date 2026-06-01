"""
data-xref.py - who reads / writes a RAM/SRAM/data address. The variable-side twin
of native-call-index.py: name a code sub by behavior, then ask "who touches $addr?"
to recover a DATA variable's role. Enables the data-walk (the labeling pass for the
$6xxx/$7xxx game-state vars, mirroring the code-side label-walk).

SOURCE: the VM bytecode disasm (disasm/bank_NN_vm.asm), where the game logic lives.
The code banks' *native* asm is raw `hex` bytes (disasm6 can't decode bytecode as
code), and the kernel touches mostly ZP/PPU -- so absolute data refs are a VM-asm
phenomenon. Each ref is mapped to its containing `; sub $XXXX` (named via the toml).

Opcode classification (as THIS ROM's handlers / the decompiler model them; note the
spec's "STORE_abs" comment on $A8 is misleading -- $A8 is a LOAD here):
  READ : A4 word->A, A5 byte->A, A6 word->B, A8 word->A, AA push word, AB push byte
  ADDR : A7 address-of -> A (operand is a pointer, not a value read)
  WRITE: A9 byte store -> abs
  CAVEAT: word stores to a FIXED address go through frame-relative ($85 STORE_near)
  or indirect ($B1) opcodes that don't carry a static address -- so the WRITE set
  here is a LOWER BOUND. A var read via abs ops but never written via $A9 (e.g.
  $6FF6, the combat damage words) is written frame-relative. Don't read "0 writers"
  as "never written."

Commands (addr accepts 6FF6 / 0x6FF6 / $6FF6):
  refs <addr>              every ref, grouped by containing sub, with kind + site
  hot [--min N]            addresses ranked by ref count (naming priority)
      [--unlabeled]        ... restricted to addresses with NO toml name yet
      [--lo HEX --hi HEX]  ... restricted to an address window (default 0x6000-0x7FFF)
"""
import argparse
import re
import sys
from collections import defaultdict
from pathlib import Path

PROJ = Path(__file__).resolve().parent.parent
DISASM = PROJ / "disasm"
CODE_BANKS = (0, 1, 2, 15)

sys.path.insert(0, str(PROJ / "tools"))
from importlib import import_module
_nv = import_module("nobunaga_vm")

# opcode byte -> access kind for the absolute-memory family ($A4-$AB), per the v2
# OPCODE_INFO spec (nobunaga_vm). $A8/$A9 are STORES (proven: $A48E LOADL_abs $6D9F /
# INC / $A492 STORE_abs $6D9F = the year++ in-place increment — the store-back is $A8).
# The matching decompiler bug ($A8 -> loadA_mem_word) is logged in ROADMAP.
ABS_KIND = {
    0xA4: "read", 0xA5: "read", 0xA6: "read", 0xAA: "read",
    0xAB: "read", 0xA7: "addr", 0xA8: "write", 0xA9: "write",
}

# A vm.asm instruction line: optional '>' marker, $ADDR, byte(s), mnemonic, operand.
INS_RE = re.compile(
    r'^\s*>?\$([0-9A-Fa-f]{4})\s+'              # 1: instruction address
    r'([0-9A-Fa-f]{2}(?:\s+[0-9A-Fa-f]{2})*)\s+'  # 2: raw bytes
    r'(\S+)'                                    # 3: mnemonic
    r'(.*)$'                                    # 4: operand + comment
)
SUB_RE = re.compile(r'^;\s*sub\s+\$([0-9A-Fa-f]{4})')


def build_index():
    """Return refs: addr -> list of dicts {bank, sub, ins, opc, kind, mnem}."""
    refs = defaultdict(list)
    for bank in CODE_BANKS:
        path = DISASM / f"bank_{bank:02d}_vm.asm"
        if not path.exists():
            continue
        cur_sub = None
        for line in path.read_text(encoding="utf-8", errors="ignore").splitlines():
            sm = SUB_RE.match(line)
            if sm:
                cur_sub = int(sm.group(1), 16)
                continue
            m = INS_RE.match(line)
            if not m:
                continue
            opc = int(m.group(2).split()[0], 16)
            kind = ABS_KIND.get(opc)
            if not kind:
                continue
            am = re.search(r'\$([0-9A-Fa-f]{4})', m.group(4))
            if not am:
                continue
            addr = int(am.group(1), 16)
            refs[addr].append({
                "bank": bank, "sub": cur_sub, "ins": int(m.group(1), 16),
                "opc": opc, "kind": kind, "mnem": m.group(3),
            })
    return refs


def _norm(tok):
    tok = tok.lstrip("$")
    return int(tok, 16) if tok.lower().startswith("0x") else int(tok, 16)


def _sub_name(labels, sub):
    if sub is None:
        return "(top-level)"
    v = labels.get(sub)
    name = (v[0] if isinstance(v, tuple) else v) if v else None
    return f"{name} (${sub:04X})" if name else f"sub_${sub:04X}"


def cmd_refs(addr, refs, labels):
    rs = refs.get(addr, [])
    cur = labels.get(addr)
    cur_name = (cur[0] if isinstance(cur, tuple) else cur) if cur else None
    print(f"// ${addr:04X}  {cur_name or '(unlabeled)'}   "
          f"{len(rs)} refs  "
          f"({sum(r['kind']=='read' for r in rs)}R "
          f"{sum(r['kind']=='write' for r in rs)}W "
          f"{sum(r['kind']=='addr' for r in rs)}&)")
    by_sub = defaultdict(list)
    for r in rs:
        by_sub[r["sub"]].append(r)
    for sub in sorted(by_sub, key=lambda s: (s is None, s)):
        sites = by_sub[sub]
        tags = ", ".join(f"{r['kind']}@${r['ins']:04X}" for r in sorted(sites, key=lambda r: r["ins"]))
        print(f"  bank{sites[0]['bank']:02d}  {_sub_name(labels, sub)}: {tags}")
    if not rs:
        print("  (no absolute-memory refs; may be ZP/frame-relative/indirect only)")


def cmd_hot(refs, labels, min_n, unlabeled, lo, hi):
    rows = []
    for addr, rs in refs.items():
        if not (lo <= addr <= hi):
            continue
        if len(rs) < min_n:
            continue
        lab = labels.get(addr)
        name = (lab[0] if isinstance(lab, tuple) else lab) if lab else None
        if unlabeled and name:
            continue
        nr = sum(r["kind"] == "read" for r in rs)
        nw = sum(r["kind"] == "write" for r in rs)
        na = sum(r["kind"] == "addr" for r in rs)
        nsubs = len({r["sub"] for r in rs})
        rows.append((len(rs), addr, nr, nw, na, nsubs, name))
    rows.sort(key=lambda t: (-t[0], t[1]))
    print(f"// {len(rows)} addresses  (window ${lo:04X}-${hi:04X}, min {min_n} refs"
          f"{', unlabeled only' if unlabeled else ''})")
    print(f"// {'addr':>6}  {'refs':>4} {'R':>3} {'W':>3} {'&':>3} {'subs':>4}  label")
    for n, addr, nr, nw, na, nsubs, name in rows:
        print(f"   ${addr:04X}  {n:>4} {nr:>3} {nw:>3} {na:>3} {nsubs:>4}  {name or '-'}")


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = ap.add_subparsers(dest="cmd", required=True)
    p = sub.add_parser("refs"); p.add_argument("addr")
    p = sub.add_parser("hot")
    p.add_argument("--min", type=int, default=3)
    p.add_argument("--unlabeled", action="store_true")
    p.add_argument("--lo", default="0x6000")
    p.add_argument("--hi", default="0x7FFF")
    args = ap.parse_args()

    refs = build_index()
    labels = _nv.load_labels()
    if args.cmd == "refs":
        cmd_refs(_norm(args.addr), refs, labels)
    elif args.cmd == "hot":
        cmd_hot(refs, labels, args.min, args.unlabeled, _norm(args.lo), _norm(args.hi))


if __name__ == "__main__":
    main()
