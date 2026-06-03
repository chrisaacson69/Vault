"""
sram-decode-province.py — Decode the live province table from a Mesen SRAM dump.

The SRAM (battery-backed PRG-RAM, $6000-$7FFF, 8 KB) maps directly to the dump
file: offset 0 = $6000, offset $1FFF = $7FFF. The live working province table
lives at $7001 (chapter 9 §4 reconciliation), 17 records x 26 bytes for the
17-fief scenario.

Record layout (16-bit LE per field):
    +0   gold              +12  loyalty
    +2   debt              +14  wealth
    +4   town              +16  men
    +6   rice              +18  morale
    +8   output            +20  skill
    +10  dams              +22  arms
                           +24  header (base koku, the development ceiling)

Also dumps the small config block at $6D5F (4 bytes; byte 0 = current_season
counter, 0-3) and the daimyo turn order at $6F1B (scenario_fief_count bytes)
for sanity checking.

Usage: python sram-decode-province.py <dump.dmp> [--diff <other.dmp>]
"""

import argparse
import sys
from pathlib import Path

SRAM_BASE = 0x6000
PROVINCE_TABLE = 0x7001
RECORD_SIZE = 26
NUM_RECORDS = 17

CONFIG_BLOCK = 0x6D5F
CONST_TWO    = 0x6D63
TURN_ORDER   = 0x6F1B  # was $6F0B (zero refs); real array base per main-turn-loop walk 2026-06-02
SELECTED_IDX = 0x6F5F

FIELDS = [
    ("gold",     0),
    ("debt",     2),
    ("town",     4),
    ("rice",     6),
    ("output",   8),
    ("dams",    10),
    ("loyalty", 12),
    ("wealth",  14),
    ("men",     16),
    ("morale",  18),
    ("skill",   20),
    ("arms",    22),
    ("header",  24),
]

DAIMYO_NAMES_17 = [
    "Hatakeyama", "Uesugi", "Hojo", "Honganji", "Asakura", "Anekoji",
    "Imagawa", "Tokugawa", "Iera", "Tsutsui", "Asai", "Rokkaku",
    "Kitabatake", "Ashikaga", "Miyoshi", "Takeda", "Oda",
]


def cpu_to_file(addr):
    return addr - SRAM_BASE


def read_word(data, file_off):
    """16-bit little-endian read."""
    return data[file_off] | (data[file_off + 1] << 8)


def decode_record(data, idx):
    rec_off = cpu_to_file(PROVINCE_TABLE) + idx * RECORD_SIZE
    return {name: read_word(data, rec_off + off) for name, off in FIELDS}


def print_record(idx, rec, label=""):
    name = DAIMYO_NAMES_17[idx] if idx < len(DAIMYO_NAMES_17) else f"idx{idx}"
    print(f"  fief {idx+1:2d}  ({name:11s}){label}: "
          + " ".join(f"{k}={v}" for k, v in rec.items()))


def dump_table(data):
    print(f"--- province_table_live @ $7001 ---")
    for idx in range(NUM_RECORDS):
        print_record(idx, decode_record(data, idx))


def dump_globals(data):
    cfg = data[cpu_to_file(CONFIG_BLOCK):cpu_to_file(CONFIG_BLOCK) + 6]
    print(f"\n--- globals ---")
    print(f"  config_block @ $6D5F   = {' '.join(f'{b:02X}' for b in cfg)}  "
          f"(expect '01 01 02 32 ?? ??')")
    print(f"  const_two   @ $6D63   = word {read_word(data, cpu_to_file(CONST_TWO))}  "
          f"(expect 2)")
    turn = data[cpu_to_file(TURN_ORDER):cpu_to_file(TURN_ORDER) + NUM_RECORDS]
    print(f"  daimyo_turn_order @ $6F1B = {list(turn)}")
    sel = read_word(data, cpu_to_file(SELECTED_IDX))
    print(f"  selected_province_idx @ $6F5F = {sel}  "
          f"(if in-game: {DAIMYO_NAMES_17[sel] if sel < len(DAIMYO_NAMES_17) else '?'})")


def diff_records(pre, post, idx):
    r_pre = decode_record(pre, idx)
    r_post = decode_record(post, idx)
    changes = {k: (r_pre[k], r_post[k]) for k in r_pre if r_pre[k] != r_post[k]}
    return changes


def diff_table(pre, post):
    print("\n--- diff (only changed fields) ---")
    any_changes = False
    for idx in range(NUM_RECORDS):
        changes = diff_records(pre, post, idx)
        if changes:
            any_changes = True
            name = DAIMYO_NAMES_17[idx] if idx < len(DAIMYO_NAMES_17) else f"idx{idx}"
            print(f"  fief {idx+1:2d}  ({name:11s}):")
            for k, (a, b) in changes.items():
                d = b - a
                sgn = f"{d:+d}"
                print(f"      {k:8s}: {a:5d} -> {b:5d}  ({sgn})")
    if not any_changes:
        print("  (no province-table changes)")

    # also diff a handful of single-word globals
    for label, addr in (("const_two", CONST_TWO),
                        ("selected_province_idx", SELECTED_IDX)):
        a = read_word(pre, cpu_to_file(addr))
        b = read_word(post, cpu_to_file(addr))
        if a != b:
            print(f"  {label} @ ${addr:04X}: {a} -> {b}")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("dump", type=Path)
    ap.add_argument("--diff", type=Path, default=None,
                    help="Second dump to diff against the first")
    ap.add_argument("--fief", type=int, default=None,
                    help="Spotlight one fief (1-indexed in-game numbering)")
    args = ap.parse_args()

    pre = args.dump.read_bytes()
    if len(pre) != 0x2000:
        print(f"warning: dump is {len(pre)} bytes, expected 8192 ($6000-$7FFF)",
              file=sys.stderr)

    print(f"=== {args.dump.name}  ({len(pre)} bytes) ===")
    if args.fief is not None:
        idx = args.fief - 1
        print_record(idx, decode_record(pre, idx))
    else:
        dump_table(pre)
    dump_globals(pre)

    if args.diff:
        post = args.diff.read_bytes()
        print(f"\n\n=== {args.diff.name}  ({len(post)} bytes) ===")
        if args.fief is not None:
            idx = args.fief - 1
            print_record(idx, decode_record(post, idx))
        else:
            dump_table(post)
        dump_globals(post)
        diff_table(pre, post)


if __name__ == "__main__":
    main()
