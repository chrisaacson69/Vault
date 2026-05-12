r"""
asm-relabel.py — Rewrite disasm6 output with named labels.

Reads a TOML labels config (same format as mesen-labels.toml) and produces
labeled copies of the disassembly files. The originals are left untouched
as ground truth; output files get a "_labeled.asm" suffix in the same dir.

Substitutions performed:
  1. b{N}_c{XXXX} pattern (disasm6 bank-local label) -> our PRG label name
  2. $XXXX absolute address -> our RAM label name
  3. $XX zero-page address -> our RAM label name

Immediate-mode literals (#$XX) and raw hex bytes (without a $ prefix) are not
touched. Substitutions are applied to comments as well, so disasm6's "; lda $0071"
annotations become readable too.

Usage:
    python asm-relabel.py <labels.toml> --disasm-dir <dir>
    python asm-relabel.py <labels.toml> --disasm-dir <dir> --output-dir <dir>
"""

import argparse
import re
import sys
import tomllib
from pathlib import Path


def parse_hex_key(key: str) -> int:
    key = key.strip()
    return int(key, 16) if key.lower().startswith("0x") else int(key, 0)


def build_label_maps(config: dict) -> tuple[dict[int, str], dict[tuple[int, int], str]]:
    """Return (ram_labels, prg_labels).

    ram_labels: {addr -> name} for CPU memory $0000-$FFFF
    prg_labels: {(bank_idx, cpu_addr) -> name}
    """
    ram = {}
    for hex_key, info in config.get("ram", {}).items():
        ram[parse_hex_key(hex_key)] = info["name"]

    prg = {}
    for bank_key, entries in config.get("prg", {}).items():
        if not bank_key.startswith("bank"):
            continue
        try:
            bank_idx = int(bank_key.removeprefix("bank"))
        except ValueError:
            continue
        for hex_key, info in entries.items():
            prg[(bank_idx, parse_hex_key(hex_key))] = info["name"]

    return ram, prg


# Regexes — defined once, reused across files.
RX_BANK_LABEL = re.compile(r"\bb(\d+)_([0-9a-fA-F]{4})\b")
RX_ABS = re.compile(r"(?<!#)\$([0-9a-fA-F]{4})\b")
RX_ZP = re.compile(r"(?<!#)\$([0-9a-fA-F]{2})\b")


def relabel_line(line: str,
                 ram_labels: dict[int, str],
                 prg_labels: dict[tuple[int, int], str],
                 counters: dict[str, int]) -> str:
    """Apply all three substitutions to a single line. counters is mutated in place."""

    def sub_bank(m: re.Match) -> str:
        b = int(m.group(1))
        a = int(m.group(2), 16)
        name = prg_labels.get((b, a))
        if name is None:
            return m.group(0)
        counters["bank"] += 1
        return name

    def sub_abs(m: re.Match) -> str:
        a = int(m.group(1), 16)
        name = ram_labels.get(a)
        if name is None:
            return m.group(0)
        counters["abs"] += 1
        return name

    def sub_zp(m: re.Match) -> str:
        a = int(m.group(1), 16)
        name = ram_labels.get(a)
        if name is None:
            return m.group(0)
        counters["zp"] += 1
        return name

    line = RX_BANK_LABEL.sub(sub_bank, line)
    line = RX_ABS.sub(sub_abs, line)
    line = RX_ZP.sub(sub_zp, line)
    return line


def relabel_file(input_path: Path,
                 output_path: Path,
                 ram_labels: dict[int, str],
                 prg_labels: dict[tuple[int, int], str]) -> dict[str, int]:
    counters = {"bank": 0, "abs": 0, "zp": 0, "lines": 0}
    with input_path.open(encoding="utf-8") as f_in, \
         output_path.open("w", encoding="utf-8", newline="") as f_out:
        for line in f_in:
            f_out.write(relabel_line(line, ram_labels, prg_labels, counters))
            counters["lines"] += 1
    return counters


def main() -> int:
    parser = argparse.ArgumentParser(description="Apply labels to disasm6 output files.")
    parser.add_argument("config", type=Path, help="Path to the TOML labels config.")
    parser.add_argument("--disasm-dir", type=Path, required=True,
                        help="Directory containing bank_*.asm files.")
    parser.add_argument("--output-dir", type=Path, default=None,
                        help="Output directory (default: same as --disasm-dir, with _labeled suffix).")
    args = parser.parse_args()

    if not args.config.exists():
        print(f"error: config not found: {args.config}", file=sys.stderr)
        return 2
    if not args.disasm_dir.is_dir():
        print(f"error: disasm dir not found: {args.disasm_dir}", file=sys.stderr)
        return 2

    with args.config.open("rb") as f:
        config = tomllib.load(f)

    ram_labels, prg_labels = build_label_maps(config)
    output_dir = args.output_dir or args.disasm_dir
    output_dir.mkdir(exist_ok=True, parents=True)

    print(f"  config:     {args.config}")
    print(f"  RAM labels: {len(ram_labels)}")
    print(f"  PRG labels: {len(prg_labels)}")
    print(f"  output:     {output_dir}")
    print()

    bank_files = sorted(args.disasm_dir.glob("bank_*.asm"))
    if not bank_files:
        print(f"  warning: no bank_*.asm files found in {args.disasm_dir}", file=sys.stderr)
        return 1

    grand = {"bank": 0, "abs": 0, "zp": 0, "lines": 0}
    for bank_file in bank_files:
        if bank_file.name.endswith("_labeled.asm"):
            continue  # don't re-process output of a previous run
        out = output_dir / bank_file.name.replace(".asm", "_labeled.asm")
        c = relabel_file(bank_file, out, ram_labels, prg_labels)
        total = c["bank"] + c["abs"] + c["zp"]
        print(f"  {bank_file.name:20s}  bank={c['bank']:4d}  abs={c['abs']:4d}  zp={c['zp']:4d}  total={total:5d}")
        for k in grand:
            grand[k] += c[k]

    print()
    print(f"  grand total: bank={grand['bank']}  abs={grand['abs']}  zp={grand['zp']}  "
          f"total={grand['bank']+grand['abs']+grand['zp']}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
