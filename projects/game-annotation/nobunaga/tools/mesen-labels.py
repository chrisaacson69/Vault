"""
mesen-labels.py - project mesen-labels.toml (the single source of truth for every
named address) onto its consumers. One label edit -> propagates everywhere.

The toml is authoritative; this tool NEVER writes back to it. Targets:

  --mlb [PATH]   Emit a Mesen 2 .mlb label file. Default PATH is beside the ROM
                 with the ROM's basename, so Mesen 2 auto-loads it on launch.
                 (Type:Address:Label:Comment; types NesPrgRom / NesInternalRam /
                  NesSaveRam / NesMemory. Mesen rejects a .mlb with empty prefixes.)

  --asm          Emit disasm/bank_NN_named.asm for each raw disasm/bank_NN.asm,
                 rewriting code labels (b{NN}_{addr} definitions + jsr/jmp/branch
                 operands) and RAM/SaveRAM operands ($0000-$07FF / $6000-$7FFF) to
                 their toml names. Leaves the curated *_labeled.asm untouched.

  --check        Parse + classify only; print coverage stats, no files written.

The decompiler (vm_decompile.py) already reads the toml directly, so decompiled/*.c
is covered for free -- this tool closes the gap for Mesen and the native disasm.

Dependency-free (the format is uniform; no tomllib on py3.9). Run from anywhere.
"""
import argparse
import re
import sys
from pathlib import Path

PROJ = Path(__file__).resolve().parent.parent
TOML = PROJ / "mesen-labels.toml"
ROM = PROJ / "Nobunaga's Ambition (USA).nes"
DISASM = PROJ / "disasm"

BANK_SIZE = 0x4000

# ---------------------------------------------------------------------------
# toml parse (tailored; entries are single-line and uniform)
# ---------------------------------------------------------------------------
SECTION_RE = re.compile(r'^\[([^\]]+)\]')
# "0xADDR" = { name = "NAME", comment = "COMMENT" }   (comment optional)
ENTRY_RE = re.compile(
    r'^"0x([0-9A-Fa-f]+)"\s*=\s*\{\s*'
    r'name\s*=\s*"((?:[^"\\]|\\.)*)"'
    r'(?:\s*,\s*comment\s*=\s*"((?:[^"\\]|\\.)*)")?'
    r'\s*\}'
)


def _unescape(s):
    """TOML basic-string escapes -> plain text, flattened to one line for .mlb."""
    if s is None:
        return ""
    out, i = [], 0
    while i < len(s):
        c = s[i]
        if c == "\\" and i + 1 < len(s):
            nxt = s[i + 1]
            out.append({"n": " ", "t": " ", '"': '"', "\\": "\\"}.get(nxt, nxt))
            i += 2
        else:
            out.append(c)
            i += 1
    return "".join(out).replace("\r", " ").replace("\n", " ")


class Label:
    __slots__ = ("addr", "name", "comment", "section", "section_bank")

    def __init__(self, addr, name, comment, section):
        self.addr = addr
        self.name = name
        self.comment = comment
        self.section = section
        # section_bank is None for [ram]; the int written in the [prg.bankN] header.
        m = re.match(r"prg\.bank(\d+)", section)
        self.section_bank = int(m.group(1)) if m else None

    @property
    def bank(self):
        """Physical PRG bank. $C000-$FFFF is the MMC1 FIXED bank (15) regardless of
        which section the entry was written under -- the address is authoritative,
        the section is just organization (and ~60 kernel labels are mis-filed under
        [prg.bank0]). $8000-$BFFF is switchable, so trust the section there."""
        if self.section_bank is None:
            return None
        if self.addr >= 0xC000:
            return 15
        return self.section_bank

    @property
    def missectioned(self):
        return self.bank is not None and self.bank != self.section_bank


def parse_toml(path=TOML):
    labels = []
    section = None
    for raw in path.read_text(encoding="utf-8").splitlines():
        line = raw.strip()
        m = SECTION_RE.match(line)
        if m:
            section = m.group(1)
            continue
        if not line.startswith('"0x'):
            continue
        e = ENTRY_RE.match(line)
        if not e:
            print(f"WARN: unparsed entry: {raw!r}", file=sys.stderr)
            continue
        labels.append(Label(int(e.group(1), 16), e.group(2),
                            _unescape(e.group(3)), section))
    mis = [l for l in labels if l.missectioned]
    if mis:
        print(f"NOTE: {len(mis)} fixed-bank labels ($C000-$FFFF) are filed under the "
              f"wrong [prg.bankN] section (normalized to bank 15). e.g. "
              f"{mis[0].name} (${mis[0].addr:04X}) under [prg.bank{mis[0].section_bank}]. "
              f"Tool output is correct; consider moving them to [prg.bank15] in the toml.",
              file=sys.stderr)
    return labels


# ---------------------------------------------------------------------------
# address -> Mesen 2 memory-type + type-relative address
# ---------------------------------------------------------------------------
def mlb_target(lab):
    """Return (mesen_type, type_relative_address) or None to skip."""
    if lab.bank is not None:
        # PRG-ROM. Same low-14-bit mapping for the $8000-$BFFF switchable window
        # and the $C000-$FFFF fixed bank: offset = bank*0x4000 + (cpu & 0x3FFF).
        return "NesPrgRom", lab.bank * BANK_SIZE + (lab.addr & 0x3FFF)
    a = lab.addr
    if a < 0x0800:
        return "NesInternalRam", a               # $0000-$07FF internal RAM
    if 0x6000 <= a <= 0x7FFF:
        return "NesSaveRam", a - 0x6000          # battery PRG-RAM, chip-relative
    return "NesMemory", a                        # registers / mirrors: CPU bus


def emit_mlb(labels, out_path):
    lines, by_type = [], {}
    for lab in labels:
        t = mlb_target(lab)
        if t is None:
            continue
        mtype, addr = t
        by_type[mtype] = by_type.get(mtype, 0) + 1
        # Type:Address:Label:Comment  (Mesen splits on the first 3 colons,
        # so colons inside the comment are safe).
        lines.append(f"{mtype}:{addr:X}:{lab.name}:{lab.comment}")
    out_path.write_text("\n".join(lines) + "\n", encoding="utf-8")
    return by_type


# ---------------------------------------------------------------------------
# --asm: rewrite raw disasm with toml names
# ---------------------------------------------------------------------------
def build_name_maps(labels):
    code = {}   # (bank, addr) -> name   (for b{NN}_{addr} tokens)
    ram = {}    # addr -> name           (bank-independent $0000-$7FFF operands)
    for lab in labels:
        if lab.bank is not None:
            code[(lab.bank, lab.addr)] = lab.name
        elif lab.addr <= 0x7FFF:
            ram[lab.addr] = lab.name
    return code, ram

CODE_TOKEN_RE = re.compile(r"\bb(\d+)_([0-9a-fA-F]{4})\b")
# (?<!#) so an IMMEDIATE constant `#$73` is never mistaken for a reference to
# address $0073 -- only true memory operands ($73 / $0073 / $0073,x) get labeled.
RAM_OPERAND_RE = re.compile(r"(?<!#)\$([0-9a-fA-F]{2,4})\b")


def apply_to_asm(text, code, ram):
    n_code = [0]
    n_ram = [0]

    def code_sub(m):
        bank, addr = int(m.group(1)), int(m.group(2), 16)
        name = code.get((bank, addr))
        if name:
            n_code[0] += 1
            return name
        return m.group(0)

    text = CODE_TOKEN_RE.sub(code_sub, text)

    def ram_sub(m):
        addr = int(m.group(1), 16)
        name = ram.get(addr)
        if name:
            n_ram[0] += 1
            return name
        return m.group(0)

    out_lines = []
    for line in text.splitlines():
        # Protect ONLY the final `; PRGOFFSET: rawbytes` comment (it encodes
        # addresses as bare hex that must NOT be rewritten). Everything before it
        # is fair game -- crucially the decoded-instruction comment on
        # `hex 8d 73 00 ; sta $0073` lines (absolute zero-page access forced as raw
        # bytes), so those labeled variables get substituted too.
        idx = line.rfind(";")
        if idx == -1:
            out_lines.append(RAM_OPERAND_RE.sub(ram_sub, line))
        else:
            out_lines.append(RAM_OPERAND_RE.sub(ram_sub, line[:idx]) + line[idx:])
    return "\n".join(out_lines), n_code[0], n_ram[0]


# Only banks 0/1/2/15 contain code (3-14 are data per the ROADMAP). Bank 15's
# raw disasm uses symbolic b15_ operands so code-label propagation is full; banks
# 0/1/2 use raw $XXXX operands (their code reads better as decompiled/*.c), so
# they mainly gain RAM-operand labels here.
CODE_BANKS = (0, 1, 2, 15)


def emit_named_asm(labels):
    code, ram = build_name_maps(labels)
    results = []
    for bank in CODE_BANKS:
        raw = DISASM / f"bank_{bank:02d}.asm"
        if not raw.exists():
            continue
        text = raw.read_text(encoding="utf-8")
        named, nc, nr = apply_to_asm(text, code, ram)
        out = raw.with_name(raw.stem + "_named.asm")
        out.write_text(named, encoding="utf-8")
        results.append((out.name, nc, nr))
    return results


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--mlb", nargs="?", const="__default__", metavar="PATH",
                    help="write Mesen .mlb (default: beside ROM, ROM basename)")
    ap.add_argument("--asm", action="store_true",
                    help="write disasm/bank_NN_named.asm with toml names applied")
    ap.add_argument("--check", action="store_true",
                    help="parse + classify only; print stats, write nothing")
    args = ap.parse_args()

    labels = parse_toml()
    print(f"Parsed {len(labels)} labels from {TOML.name}")

    if args.check or not (args.mlb or args.asm):
        by_type = {}
        for lab in labels:
            t = mlb_target(lab)
            if t:
                by_type[t[0]] = by_type.get(t[0], 0) + 1
        for t, n in sorted(by_type.items()):
            print(f"  {t:16s} {n}")
        if not (args.mlb or args.asm):
            print("\n(no target given; use --mlb and/or --asm. --check = stats only)")
            return

    if args.mlb:
        if args.mlb == "__default__":
            out = ROM.with_suffix(".mlb")
        else:
            out = Path(args.mlb)
        by_type = emit_mlb(labels, out)
        total = sum(by_type.values())
        print(f"Wrote {total} labels -> {out}")
        for t, n in sorted(by_type.items()):
            print(f"  {t:16s} {n}")

    if args.asm:
        for name, nc, nr in emit_named_asm(labels):
            print(f"Wrote {name}: {nc} code labels, {nr} RAM operands applied")


if __name__ == "__main__":
    main()
