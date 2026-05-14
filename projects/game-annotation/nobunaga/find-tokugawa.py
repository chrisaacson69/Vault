"""Find Tokugawa's stats (85,77,98,86,84 = 55 4D 62 56 54) in a save file."""
import sys

target_full = bytes([0x55, 0x4D, 0x62, 0x56, 0x54])
target_perm = [
    bytes([0x55, 0x4D, 0x62, 0x56, 0x54]),  # Health, Drive, Luck, Cha, IQ (input order)
    bytes([0x54, 0x56, 0x62, 0x4D, 0x55]),  # reversed
    bytes([0x55, 0x56, 0x4D, 0x62, 0x54]),  # alphabetical (Cha, Drive, Health, IQ, Luck)
    bytes([0x4D, 0x55, 0x54, 0x56, 0x62]),  # Drive, Health, IQ, Cha, Luck
    bytes([0x55, 0x4D, 0x54, 0x62, 0x56]),
]

# Also look for any 5 of those bytes in close proximity (any order)
target_set = {0x55, 0x4D, 0x62, 0x56, 0x54}

for fname in sys.argv[1:]:
    data = open(fname, "rb").read()
    print(f"\n=== {fname} ({len(data)} bytes) ===")

    print("Exact orderings:")
    for pat in target_perm:
        positions = []
        pos = 0
        while True:
            idx = data.find(pat, pos)
            if idx < 0: break
            positions.append(idx)
            pos = idx + 1
        if positions:
            ord_str = " ".join(f"${b:02X}" for b in pat)
            print(f"  {ord_str} → {len(positions)} matches: {[hex(p) for p in positions[:10]]}")

    print("Any 5-byte window containing exactly these 5 bytes:")
    matches = []
    for i in range(len(data) - 4):
        window = data[i:i+5]
        if set(window) == target_set:
            matches.append((i, window))
    if matches:
        for offset, w in matches[:20]:
            ord_str = " ".join(f"${b:02X}" for b in w)
            print(f"  offset ${offset:05X}: {ord_str}")
    else:
        print("  none")
