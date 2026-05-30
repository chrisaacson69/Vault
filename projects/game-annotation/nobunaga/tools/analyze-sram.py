"""Analyze an 8 KB Nobunaga SRAM dump (.dmp / .sav) — structure and detail views.

Consolidates sram-analyze.py + sram-detail.py, which both take an 8 KB SRAM image
(CPU $6000-$7FFF) on the command line.

Modes:
  structure  byte-value distribution, runs of $00/$FF, 256-byte page summaries —
             the "what's where" landscape of an unfamiliar dump. [was sram-analyze.py]
  detail     ASCII strings, province-table stride-fitting, $7000 / $7700 region
             dumps — exploratory record-layout fitting. [was sram-detail.py]

For the verified live province table (17×26, with PRE/POST --diff) use the canonical
sram-decode-province.py instead; `detail` here is the exploratory precursor to it.
"""

import argparse
from collections import Counter
from pathlib import Path

BASE = 0x6000


def find_runs(data, value, min_length=8):
    runs, in_run, start = [], False, 0
    for i, b in enumerate(data):
        if b == value:
            if not in_run:
                in_run, start = True, i
        elif in_run:
            if i - start >= min_length:
                runs.append((start, i - start))
            in_run = False
    if in_run and len(data) - start >= min_length:
        runs.append((start, len(data) - start))
    return runs


def mode_structure(sav):
    assert len(sav) == 8192, f"expected 8192 bytes (8 KB SRAM), got {len(sav)}"
    print(f"SRAM dump: {len(sav)} bytes ({BASE:04X}-{BASE+len(sav)-1:04X})")
    print()

    counter = Counter(sav)
    print(f"Bytes that are $00: {counter[0x00]} ({100*counter[0x00]/8192:.1f}%)")
    print(f"Bytes that are $FF: {counter[0xFF]} ({100*counter[0xFF]/8192:.1f}%)")
    print(f"Distinct byte values: {len(counter)}")
    print()

    print("Runs of $00 (>= 16 bytes):")
    for offset, length in find_runs(sav, 0x00, 16):
        print(f"  ${BASE+offset:04X}-${BASE+offset+length-1:04X}  ({length} bytes)")
    print()

    print("Runs of $FF (>= 16 bytes):")
    for offset, length in find_runs(sav, 0xFF, 16):
        print(f"  ${BASE+offset:04X}-${BASE+offset+length-1:04X}  ({length} bytes)")
    print()

    print("Page summaries (256-byte chunks): nonzero count + first 16 bytes")
    for page in range(32):
        start = page * 256
        chunk = sav[start:start+256]
        nonzero = sum(1 for b in chunk if b != 0)
        if nonzero > 0:
            head = " ".join(f"{b:02X}" for b in chunk[:16])
            print(f"  ${BASE+start:04X}: {nonzero:3d} nonzero  | {head}")


def mode_detail(sav):
    print("=== ASCII strings (4+ chars) in $7800-$7BFF region ===")

    def is_printable(b):
        return 0x20 <= b <= 0x7E

    start = None
    for i, b in enumerate(sav):
        if is_printable(b):
            if start is None:
                start = i
        else:
            if start is not None and i - start >= 4:
                print(f"  ${BASE+start:04X}: '{sav[start:i].decode('ascii', errors='replace')}'")
            start = None
    if start is not None and len(sav) - start >= 4:
        print(f"  ${BASE+start:04X}: '{sav[start:].decode('ascii', errors='replace')}'")
    print()

    print("=== $7000-$71FF as 16-bit values (50 entries × 4 bytes? or 50 × 8?) ===")
    for stride in (4, 6, 8, 10, 12, 16, 20):
        n_records = 50
        end = 0x7000 - BASE + n_records * stride
        if end <= len(sav):
            print(f"\n  Stride {stride}: 50 records ${0x7000:04X}-${BASE + 0x7000 - BASE + n_records*stride - 1:04X}")
            for i in range(5):
                offset = (0x7000 - BASE) + i * stride
                rec = sav[offset:offset + stride]
                print(f"    rec {i:2d} @${BASE+offset:04X}:  {' '.join(f'{b:02X}' for b in rec)}")

    print("\n=== $7000-$70FF as 8-byte records (full page) ===")
    for i in range(32):
        offset = (0x7000 - BASE) + i * 8
        rec = sav[offset:offset + 8]
        print(f"  rec {i:2d} @${BASE+offset:04X}:  {' '.join(f'{b:02X}' for b in rec)}")

    print("\n=== $7700-$77FF (16-byte rows) — possible packed daimyo records ===")
    for i in range(16):
        offset = (0x7700 - BASE) + i * 16
        rec = sav[offset:offset + 16]
        print(f"  ${BASE+offset:04X}:  {' '.join(f'{b:02X}' for b in rec)}")


MODES = {"structure": mode_structure, "detail": mode_detail}


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("mode", choices=MODES)
    ap.add_argument("dump", help="8 KB SRAM dump (.dmp / .sav)")
    args = ap.parse_args()
    sav = Path(args.dump).read_bytes()
    MODES[args.mode](sav)


if __name__ == "__main__":
    main()
