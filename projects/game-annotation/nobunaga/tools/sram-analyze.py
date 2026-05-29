"""Analyze the .sav SRAM dump to find structure."""
import sys
from collections import Counter

sav_data = open(sys.argv[1], "rb").read()
assert len(sav_data) == 8192, f"expected 8192 bytes (8 KB SRAM), got {len(sav_data)}"

# SRAM maps to CPU $6000-$7FFF, so byte 0 of the file = CPU $6000.
BASE = 0x6000

print(f"SRAM dump: {len(sav_data)} bytes ({BASE:04X}-{BASE+len(sav_data)-1:04X})")
print()

# --- Byte-value distribution ---
counter = Counter(sav_data)
zero_count = counter[0x00]
ff_count = counter[0xFF]
print(f"Bytes that are $00: {zero_count} ({100*zero_count/8192:.1f}%)")
print(f"Bytes that are $FF: {ff_count} ({100*ff_count/8192:.1f}%)")
print(f"Distinct byte values: {len(counter)}")
print()

# --- Find runs of zeros and FFs (sparse vs. dense regions) ---
def find_runs(data, value, min_length=8):
    runs = []
    in_run = False
    start = 0
    for i, b in enumerate(data):
        if b == value:
            if not in_run:
                in_run = True
                start = i
        else:
            if in_run:
                if i - start >= min_length:
                    runs.append((start, i - start))
                in_run = False
    if in_run and len(data) - start >= min_length:
        runs.append((start, len(data) - start))
    return runs

print("Runs of $00 (>= 16 bytes):")
for offset, length in find_runs(sav_data, 0x00, 16):
    print(f"  ${BASE+offset:04X}-${BASE+offset+length-1:04X}  ({length} bytes)")
print()

print("Runs of $FF (>= 16 bytes):")
for offset, length in find_runs(sav_data, 0xFF, 16):
    print(f"  ${BASE+offset:04X}-${BASE+offset+length-1:04X}  ({length} bytes)")
print()

# --- Look for repeated structures: hash 16-byte windows, find common ones ---
# If province records are e.g. 32 bytes, we'd see clusters of similar bytes at fixed stride
# Heuristic: count unique 4-byte sequences at each offset alignment
print("Page summaries (256-byte chunks): nonzero count + first 16 bytes")
for page in range(32):
    start = page * 256
    chunk = sav_data[start:start+256]
    nonzero = sum(1 for b in chunk if b != 0)
    if nonzero > 0:
        head = " ".join(f"{b:02X}" for b in chunk[:16])
        print(f"  ${BASE+start:04X}: {nonzero:3d} nonzero  | {head}")
