"""Deeper analysis: extract strings + try to fit a province table."""
import sys

sav = open(sys.argv[1], "rb").read()
BASE = 0x6000

# --- Extract all ASCII strings (4+ printable chars) ---
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
            s = sav[start:i].decode('ascii', errors='replace')
            print(f"  ${BASE+start:04X}: '{s}'")
        start = None
if start is not None and len(sav) - start >= 4:
    s = sav[start:].decode('ascii', errors='replace')
    print(f"  ${BASE+start:04X}: '{s}'")
print()

# --- Analyze $7000-$74FF as 2-byte records ---
print("=== $7000-$71FF as 16-bit values (50 entries × 4 bytes? or 50 × 8?) ===")
# Try fitting 50 records of various stride sizes
for stride in (4, 6, 8, 10, 12, 16, 20):
    n_records = 50
    end = 0x7000 - BASE + n_records * stride
    if end <= len(sav):
        print(f"\n  Stride {stride}: 50 records ${0x7000:04X}-${BASE + 0x7000 - BASE + n_records*stride - 1:04X}")
        for i in range(5):  # show first 5 records
            offset = (0x7000 - BASE) + i * stride
            rec = sav[offset:offset + stride]
            hex_str = " ".join(f"{b:02X}" for b in rec)
            print(f"    rec {i:2d} @${BASE+offset:04X}:  {hex_str}")

# --- Show $7000-$70FF in full (the candidate "province table page 1") ---
print("\n=== $7000-$70FF as 8-byte records (full page) ===")
for i in range(32):  # 256 bytes / 8 = 32 records per page
    offset = (0x7000 - BASE) + i * 8
    rec = sav[offset:offset + 8]
    hex_str = " ".join(f"{b:02X}" for b in rec)
    print(f"  rec {i:2d} @${BASE+offset:04X}:  {hex_str}")

# --- $77xx region structure ---
print("\n=== $7700-$77FF (16-byte rows) — possible packed daimyo records ===")
for i in range(16):
    offset = (0x7700 - BASE) + i * 16
    rec = sav[offset:offset + 16]
    hex_str = " ".join(f"{b:02X}" for b in rec)
    print(f"  ${BASE+offset:04X}:  {hex_str}")
