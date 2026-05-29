"""Extract daimyo records from $7500-$77FF region; find all records starting with marker."""
import sys

data = open(sys.argv[1], "rb").read()
BASE = 0x6000

# Tokugawa was found at offset $1560 (= CPU $7560) starting with $12
# Let's see the surrounding region and find all $12-marker records
region_start = 0x1500  # $7500
region_end = 0x1800    # $7800

print(f"=== Region $7500-$77FF (256-byte rows) ===")
for row in range(region_start, region_end, 16):
    bytes_str = " ".join(f"{b:02X}" for b in data[row:row+16])
    ascii_str = "".join(chr(b) if 0x20 <= b <= 0x7E else "." for b in data[row:row+16])
    print(f"  ${BASE+row:04X}: {bytes_str}  | {ascii_str}")

# Look for the daimyo record at $7560 and try stride 10 (since we see "12 .. .. .. .. .. 00 .. .. ..")
print("\n=== Trying 10-byte stride from $7560 (records of (marker, 5 stats, 4 more bytes)) ===")
for i in range(20):
    offset = 0x1560 + i * 10
    if offset + 10 > len(data): break
    rec = data[offset:offset+10]
    bytes_str = " ".join(f"{b:02X}" for b in rec)
    print(f"  rec {i:2d} @${BASE+offset:04X}:  {bytes_str}")

print("\n=== Trying 16-byte stride from $7560 ===")
for i in range(20):
    offset = 0x1560 + i * 16
    if offset + 16 > len(data): break
    rec = data[offset:offset+16]
    bytes_str = " ".join(f"{b:02X}" for b in rec)
    print(f"  rec {i:2d} @${BASE+offset:04X}:  {bytes_str}")
