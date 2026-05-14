"""Hunt for Tokugawa with multiple encodings."""
import sys
from itertools import permutations

stats = [85, 77, 98, 86, 84]  # H, D, L, Ch, IQ
stats_set = set(stats)

# Candidate encodings
patterns = []
# 1. 8-bit any order
for perm in permutations(stats):
    patterns.append(("8-bit perm", bytes(perm)))
# 2. 16-bit big-endian
for perm in permutations(stats):
    p = b""
    for v in perm:
        p += bytes([0x00, v])
    patterns.append(("16-bit BE perm", p))
# 3. 16-bit little-endian
for perm in permutations(stats):
    p = b""
    for v in perm:
        p += bytes([v, 0x00])
    patterns.append(("16-bit LE perm", p))

for fname in sys.argv[1:]:
    data = open(fname, "rb").read()
    print(f"\n=== {fname} ({len(data)} bytes) ===")
    found_any = False
    for label, pat in patterns:
        idx = data.find(pat)
        if idx >= 0:
            found_any = True
            ord_str = " ".join(f"${b:02X}" for b in pat)
            print(f"  {label}: {ord_str} at offset ${idx:05X}")
            # context
            ctx_start = max(0, idx - 8)
            ctx_end = min(len(data), idx + len(pat) + 8)
            ctx = " ".join(f"{b:02X}" for b in data[ctx_start:ctx_end])
            mark = "  " * (idx - ctx_start) + "[" + "  " * len(pat) + "]"
            print(f"     context: {ctx}")
            break  # one per file is enough
    if not found_any:
        # As a fallback: look for windows containing all 5 byte values within 10 bytes
        print("  Trying scattered (within 10-byte window):")
        for i in range(len(data) - 10):
            window = data[i:i+10]
            if all(s in window for s in stats):
                ord_str = " ".join(f"{b:02X}" for b in window)
                print(f"    offset ${i:05X}: {ord_str}")
                found_any = True
                if i > 1000: break  # one example
        if not found_any:
            print("    no scattered match")
        # Also try with a +/-2 fuzziness
        print("  Trying with +/-2 fuzz:")
        for i in range(len(data) - 4):
            window = data[i:i+5]
            close = all(any(abs(w - s) <= 2 for s in stats) for w in window) and \
                    all(any(abs(w - s) <= 2 for w in window) for s in stats)
            if close and sum(window) == sum(stats):
                continue  # exact would have matched
            if close:
                ord_str = " ".join(f"{b:02X}" for b in window)
                print(f"    offset ${i:05X}: {ord_str}")
                break
