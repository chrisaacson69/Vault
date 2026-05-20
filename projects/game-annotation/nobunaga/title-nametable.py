#!/usr/bin/env python3
"""Render the title-screen nametable from the trace extract."""

import os
here = os.path.dirname(os.path.abspath(__file__))
with open(os.path.join(here, 'nametable_bytes.txt')) as f:
    bytes_hex = [b.strip() for b in f if b.strip()]

print(f"Total bytes: {len(bytes_hex)}")
print()
print("Nametable (32x30), non-blank rows only:")
print("    " + " ".join(f"{c:02x}" for c in range(32)))
print("    " + "-" * 96)
for row in range(30):
    line = bytes_hex[row*32:(row+1)*32]
    if not all(b == '02' for b in line):
        print(f"R{row:02d}: {' '.join(line)}")

print()
print("Per-row stats:")
for row in range(30):
    line = bytes_hex[row*32:(row+1)*32]
    distinct = set(line)
    nonblank = [b for b in line if b != '02']
    print(f"R{row:02d}  distinct={len(distinct):2d}  nonblank={len(nonblank):2d}")
