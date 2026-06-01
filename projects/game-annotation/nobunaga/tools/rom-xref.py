"""
rom-xref.py - who references which ROM DATA pointer, and what is it. The ROM-side
twin of data-xref.py. Where data-xref tracks the $A4-$AB absolute family (RAM/data-
segment VARIABLES), ROM tables & strings are reached as IMMEDIATE-WORD POINTERS:

  $8A loadA_imm_word   regA = <word>     (table base -> indexed, or a value)
  $8C loadB_imm_word   regB = <word>
  $8E push_imm_word    push <word>       (string ptr -> a print/message syscall)

An immediate whose value lands in ROM ($8000-$FFFF) is a POINTER INTO ROM. This is
the reference mechanism the B1 data-walk needs (the abs family never sees them).

PER-BANK: the same CPU address holds different bytes in each switchable bank
($8000-$BFFF), so a pointer is decoded in the bank of its REFERENCING sub. $C000+
is the fixed bank 15. Pointers into the $8000-$BFFF *code* region that resolve to a
known function label are CODE pointers (callbacks / dispatch entries), not data.

CLASSIFICATION (decode bytes at the target until NUL):
  code : target is an already-labeled function (skip - it's a code pointer)
  str  : >=2 leading printable ASCII, NUL-terminated within 64, high printable ratio
  tbl  : everything else (binary table / blob -> needs interpretation)

Commands:
  frontier [--unlabeled] [--class str|tbl|code] [--bank N] [--min N]
                              ranked ROM pointers: addr/bank/refs/class/subs/preview
  refs <addr> [--bank N]      detail for one pointer (which subs, which sites)
  strings [--toml] [--bank N] all str-class pointers; --toml emits paste-ready labels
  stats                       class/region breakdown
"""
import argparse
import re
import sys
from collections import defaultdict
from pathlib import Path

PROJ = Path(__file__).resolve().parent.parent
DISASM = PROJ / "disasm"
ROM = PROJ / "Nobunaga's Ambition (USA).nes"
CODE_BANKS = (0, 1, 2, 15)
IMM_WORD_OPS = {0x8A: "loadA", 0x8C: "loadB", 0x8E: "push"}

sys.path.insert(0, str(PROJ / "tools"))
from importlib import import_module
_nv = import_module("nobunaga_vm")

INS_RE = re.compile(
    r'^\s*>?\$([0-9A-Fa-f]{4})\s+'
    r'([0-9A-Fa-f]{2}(?:\s+[0-9A-Fa-f]{2})*)\s+'
    r'(\S+)(.*)$'
)
SUB_RE = re.compile(r'^;\s*sub\s+\$([0-9A-Fa-f]{4})')

_rom_bytes = None
def rom():
    global _rom_bytes
    if _rom_bytes is None:
        _rom_bytes = ROM.read_bytes()
    return _rom_bytes

def rom_off(addr, bank):
    """CPU addr + mapped bank -> file offset (0x10 iNES header; 0x4000/bank)."""
    if addr >= 0xC000:
        return 0x10 + 15 * 0x4000 + (addr - 0xC000)   # fixed bank 15
    return 0x10 + bank * 0x4000 + (addr - 0x8000)      # switchable window

def decode_str(addr, bank, maxn=64):
    """Bytes at (addr,bank) until NUL -> (text, raw_len, printable_ratio)."""
    o = rom_off(addr, bank)
    raw = []
    for i in range(maxn):
        if o + i >= len(rom()):
            break
        b = rom()[o + i]
        if b == 0:
            break
        raw.append(b)
    if not raw:
        return "", 0, 0.0
    printable = sum(1 for b in raw if 32 <= b < 127 or b in (0x0a, 0x0d))
    text = "".join(chr(b) if 32 <= b < 127 else ("\\n" if b == 0x0a else
            "\\r" if b == 0x0d else "[%02x]" % b) for b in raw)
    return text, len(raw), printable / len(raw)

def _name(prg_labels, addr, bank):
    """Bank-unambiguous toml label for a ROM (addr, bank), via the PRG-offset
    identity (load_labels_by_prg). The flat loader collides switchable-window
    banks at the same CPU addr; this does not. Returns None for non-ROM or unlabeled."""
    if bank is None or addr < 0x8000:
        return None
    prg = (15 if addr >= 0xC000 else bank) * 0x4000 + (addr & 0x3FFF)
    v = prg_labels.get(prg)
    return v[0] if v else None

def classify(addr, bank, labels, code_addrs=None):
    if _name(labels, addr, bank):
        return "labeled"
    # code-pointer: the immediate lands ON a decoded instruction boundary in this
    # bank => it's a callback / continuation address pushed as an arg, not data.
    if code_addrs is not None and addr in code_addrs.get(bank, ()):
        return "code"
    text, n, ratio = decode_str(addr, bank)
    raw = rom()[rom_off(addr, bank):rom_off(addr, bank) + n]
    # string: NUL-terminated, >=2 bytes, high printable ratio, starts printable, and
    # not a single repeated fill byte (e.g. 0x55 'UUUU' PPU fill).
    if (n >= 2 and ratio >= 0.85 and not text.startswith("[")
            and len(set(raw)) > 1):
        return "str"
    return "tbl"

def build_index():
    """Return (idx, code_addrs):
       idx        : addr -> bank -> list of {sub, ins, mnem} imm-word references
       code_addrs : bank -> set of decoded instruction addresses (for code-ptr class)."""
    idx = defaultdict(lambda: defaultdict(list))
    code_addrs = defaultdict(set)
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
            code_addrs[bank].add(int(m.group(1), 16))
            opc = int(m.group(2).split()[0], 16)
            if opc not in IMM_WORD_OPS:
                continue
            am = re.search(r'\$([0-9A-Fa-f]{4})', m.group(4))
            if not am:
                continue
            target = int(am.group(1), 16)
            if target < 0x8000:
                continue
            idx[target][bank].append({
                "sub": cur_sub, "ins": int(m.group(1), 16), "mnem": IMM_WORD_OPS[opc],
            })
    return idx, code_addrs

def _sub_name(prg_labels, sub, bank):
    if sub is None:
        return "(top-level)"
    n = _name(prg_labels, sub, bank)
    return f"{n} (${sub:04X})" if n else f"sub_${sub:04X}"

def _slug(text, maxlen=30):
    """Readable label stem from decoded text. Strips control/cursor prefixes (the
    `>[16]80` tile codes that prefix many strings) by anchoring on the first letter,
    so all entry-point variants of one message converge to the same stem."""
    s = re.sub(r'\[[0-9a-f]{2}\]', '', text)         # drop raw hex escapes
    s = s.replace('\\n', ' ').replace('\\r', ' ')
    m = re.search(r'[A-Za-z].*', s)                   # anchor on first letter
    core = m.group(0) if m else s
    slug = re.sub(r'[^A-Za-z0-9]+', '_', core).strip('_').lower()[:maxlen].rstrip('_')
    if len(re.sub(r'[^a-z]', '', slug)) >= 2:         # enough letters to be meaningful
        return slug
    # letterless (pure format/punct string, e.g. "%2d", " "): name by its specifiers
    fmt = "_".join(re.findall(r'%[0-9]*[dscx]', text)) or "blank"
    return ("fmt_" + re.sub(r'[^A-Za-z0-9]+', '_', fmt)).strip('_').lower()

def iter_pointers(idx, labels, bank_filter=None):
    for addr in sorted(idx):
        for bank in sorted(idx[addr]):
            if bank_filter is not None and bank != bank_filter:
                continue
            refs = idx[addr][bank]
            yield addr, bank, refs

def cmd_frontier(idx, labels, code_addrs, unlabeled, klass, bank_filter, min_n):
    rows = []
    for addr, bank, refs in iter_pointers(idx, labels, bank_filter):
        if len(refs) < min_n:
            continue
        name = _name(labels, addr, bank)
        if unlabeled and name:
            continue
        c = classify(addr, bank, labels, code_addrs)
        if klass and c != klass:
            continue
        text, n, ratio = decode_str(addr, bank)
        subs = sorted({r["sub"] for r in refs}, key=lambda s: (s is None, s))
        rows.append((len(refs), addr, bank, c, name, subs, text[:42]))
    rows.sort(key=lambda t: (-t[0], t[1], t[2]))
    print(f"// {len(rows)} ROM pointers  (min {min_n} refs"
          f"{', unlabeled' if unlabeled else ''}{', class='+klass if klass else ''}"
          f"{', bank %d'%bank_filter if bank_filter is not None else ''})")
    print(f"// {'addr':>6} bk {'n':>2} {'class':>7}  subs / preview")
    for n_refs, addr, bank, c, name, subs, prev in rows:
        sub0 = _sub_name(labels, subs[0], bank) + ("  +%d" % (len(subs)-1) if len(subs) > 1 else "")
        tag = name or (f'"{prev}"' if c == "str" else prev)
        print(f"   ${addr:04X} {bank:>2} {n_refs:>2} {c:>7}  {sub0}  | {tag}")

def cmd_refs(addr, idx, labels, code_addrs, bank_filter):
    if addr not in idx:
        print(f"// ${addr:04X}: no imm-word ROM references")
        return
    for bank in sorted(idx[addr]):
        if bank_filter is not None and bank != bank_filter:
            continue
        refs = idx[addr][bank]
        c = classify(addr, bank, labels, code_addrs)
        text, n, ratio = decode_str(addr, bank)
        print(f"// ${addr:04X}  bank{bank}  {len(refs)} refs  class={c}  "
              f"printable={ratio:.0%}  name={_name(labels,addr,bank) or '-'}")
        if c == "str":
            print(f"//   text: \"{text}\"")
        else:
            o = rom_off(addr, bank)
            print(f"//   bytes: " + " ".join("%02x" % b for b in rom()[o:o+16]))
        by_sub = defaultdict(list)
        for r in refs:
            by_sub[r["sub"]].append(r)
        for sub in sorted(by_sub, key=lambda s: (s is None, s)):
            sites = ", ".join(f"{r['mnem']}@${r['ins']:04X}" for r in by_sub[sub])
            print(f"     {_sub_name(labels, sub, bank)}: {sites}")

def cmd_strings(idx, labels, code_addrs, as_toml, bank_filter):
    by_bank = defaultdict(list)
    for addr, bank, refs in iter_pointers(idx, labels, bank_filter):
        if _name(labels, addr, bank):
            continue
        if classify(addr, bank, labels, code_addrs) != "str":
            continue
        text, n, ratio = decode_str(addr, bank)
        by_bank[bank].append((addr, text, refs))
    total = sum(len(v) for v in by_bank.values())
    if not as_toml:
        for bank in sorted(by_bank):
            print(f"# --- bank {bank} ({len(by_bank[bank])} strings) ---")
            for addr, text, refs in sorted(by_bank[bank]):
                print(f'  ${addr:04X}  ({len(refs)}x)  "{text}"')
        print(f"# total {total} string pointers")
        return
    # toml emission, per-bank section. Names are globally unique (load_labels is flat,
    # so a name reused across banks would shadow); on collision append the address.
    seen = set()
    for bank in sorted(by_bank):
        sec = "prg.bank15" if bank == 15 else f"prg.bank{bank}"
        print(f"\n[{sec}]   # ROM strings (rom-xref auto-decode)")
        for addr, text, refs in sorted(by_bank[bank]):
            nm = "msg_" + _slug(text)
            if nm in seen:
                nm = f"{nm}_{addr:04x}"
            seen.add(nm)
            ctext = text.replace('"', "'")
            print(f'"0x{addr:04X}" = {{ name = "{nm}", comment = "[ROM-STR] \\"{ctext}\\"" }}')

def is_ptr_table(addr, bank, n=8):
    """True only if the first n words read as a CLEAN table of code pointers — the
    first word is in the switchable/fixed code window AND >=0.85 of words are
    $8000-$EFFF (excludes $Fxxx vectors/$FFFA and obvious non-pointers). Conservative
    on purpose: a borderline table keeps the neutral `_data_` name rather than falsely
    asserting `jumptab`."""
    o = rom_off(addr, bank)
    ws = [rom()[o + 2 * i] | (rom()[o + 2 * i + 1] << 8)
          for i in range(n) if o + 2 * i + 1 < len(rom())]
    if not ws or not (0x8000 <= ws[0] <= 0xEFFF):
        return False
    return sum(0x8000 <= w <= 0xEFFF for w in ws) >= len(ws) * 0.85

# Analytical combat tables — deferred to a focused session (need geometry interpretation).
_DEFER_SUBS = ("quadrant", "render_combat_map")

def _table_name(addr, primary_subname, ptr):
    if ptr:
        return f"jumptab_{addr:04x}"          # content-verified dispatch table
    base = re.sub(r'_[0-9a-f]{4}$', '', primary_subname or "")[:24].strip('_')
    return f"{base}_data_{addr:04x}" if base else f"rodata_{addr:04x}"

def cmd_tables(idx, labels, code_addrs, as_toml, bank_filter):
    """Name the non-string ROM tables from PROVENANCE (the named sub that reads them)
    + content-verified type (jump table vs binary blob). Honest by construction: the
    name asserts only what's grounded (who reads it / it's a pointer table); the bucket
    heuristic + byte preview live in the comment. Combat-geometry tables are deferred."""
    by_bank = defaultdict(list)
    deferred = 0
    for addr, bank, refs in iter_pointers(idx, labels, bank_filter):
        if _name(labels, addr, bank):
            continue
        if classify(addr, bank, labels, code_addrs) != "tbl":
            continue
        subnames = [(_name(labels, r["sub"], bank) or "") for r in refs if r["sub"] is not None]
        ptr = is_ptr_table(addr, bank)
        if not ptr and subnames and all(any(d in sn for d in _DEFER_SUBS) for sn in subnames):
            deferred += 1
            continue
        by_bank[bank].append((addr, refs, subnames, ptr))
    total = sum(len(v) for v in by_bank.values())
    if not as_toml:
        for bank in sorted(by_bank):
            print(f"# --- bank {bank} ({len(by_bank[bank])} tables) ---")
            for addr, refs, subnames, ptr in sorted(by_bank[bank]):
                kind = "jumptab" if ptr else "data"
                print(f"  ${addr:04X}  {kind:8} ({len(refs)}x)  <- {subnames[0] if subnames else '(top)'}")
        print(f"# total {total} tables to name; {deferred} combat-geometry tables deferred")
        return
    seen = set()
    for bank in sorted(by_bank):
        sec = "prg.bank15" if bank == 15 else f"prg.bank{bank}"
        print(f"\n[{sec}]   # ROM tables (rom-xref provenance-named, B1 data-walk)")
        for addr, refs, subnames, ptr in sorted(by_bank[bank]):
            nm = _table_name(addr, subnames[0] if subnames else "", ptr)
            if nm in seen:
                nm = f"{nm}_{addr:04x}"
            seen.add(nm)
            o = rom_off(addr, bank)
            preview = " ".join("%02x" % b for b in rom()[o:o + 12])
            who = ", ".join(sorted({s for s in subnames if s})) or "(top-level)"
            kind = "pointer/dispatch table" if ptr else "binary table (unanalyzed)"
            print(f'"0x{addr:04X}" = {{ name = "{nm}", '
                  f'comment = "[ROM-DATA] {kind}; read by {who} via imm-word ptr; bytes: {preview}" }}')

def cmd_stats(idx, labels, code_addrs):
    cls = defaultdict(int); reg = defaultdict(lambda: defaultdict(int))
    for addr, bank, refs in iter_pointers(idx, labels):
        c = classify(addr, bank, labels, code_addrs)
        cls[c] += 1
        reg[f"${addr>>8:02X}xx"][c] += 1
    print("// class totals:", dict(cls))
    print("// by region (region: {class:count}):")
    for r in sorted(reg):
        print(f"   {r}: {dict(reg[r])}")

def _norm(tok):
    return int(tok.lstrip("$").lower().replace("0x", ""), 16)

def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    s = ap.add_subparsers(dest="cmd", required=True)
    p = s.add_parser("frontier")
    p.add_argument("--unlabeled", action="store_true")
    p.add_argument("--class", dest="klass", choices=["str", "tbl", "code", "labeled"])
    p.add_argument("--bank", type=int)
    p.add_argument("--min", type=int, default=1)
    p = s.add_parser("refs"); p.add_argument("addr"); p.add_argument("--bank", type=int)
    p = s.add_parser("strings"); p.add_argument("--toml", action="store_true"); p.add_argument("--bank", type=int)
    p = s.add_parser("tables"); p.add_argument("--toml", action="store_true"); p.add_argument("--bank", type=int)
    s.add_parser("stats")
    args = ap.parse_args()

    idx, code_addrs = build_index()
    labels = _nv.load_labels_by_prg()   # PRG-offset keyed: bank-unambiguous (see _name)
    if args.cmd == "frontier":
        cmd_frontier(idx, labels, code_addrs, args.unlabeled, args.klass, args.bank, args.min)
    elif args.cmd == "refs":
        cmd_refs(_norm(args.addr), idx, labels, code_addrs, args.bank)
    elif args.cmd == "strings":
        cmd_strings(idx, labels, code_addrs, args.toml, args.bank)
    elif args.cmd == "tables":
        cmd_tables(idx, labels, code_addrs, args.toml, args.bank)
    elif args.cmd == "stats":
        cmd_stats(idx, labels, code_addrs)

if __name__ == "__main__":
    main()
