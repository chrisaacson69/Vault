"""
find-adjacency-50.py — Locate the 50-fief adjacency table.

Strategy: scan the ROM for any region that "looks like" 50 adjacency slots:
- 50 consecutive N-byte slots (try N = 8, 10, 12, 16)
- Each slot: bytes < 50 (neighbor indices), $FF terminator, $00 padding
- Each slot has at least 1 neighbor (no isolated provinces)
- Adjacency is symmetric (A→B iff B→A)

Score candidates by symmetry rate + average neighbor count plausibility.
"""
import sys

rom = open(sys.argv[1], "rb").read()
if len(rom) >= 16 and rom[:4] == b"NES\x1a":
    rom = rom[16:]

COUNT = 50
SLOT_SIZES = [6, 8, 10, 12, 16]


def parse_slot(buf, slot_size):
    """Parse a slot: return list of neighbor indices, or None if invalid."""
    out = []
    saw_term = False
    for b in buf[:slot_size]:
        if b == 0xFF:
            saw_term = True
            break
        if b >= COUNT:
            return None
        if b in out:
            return None  # duplicate neighbor
        out.append(b)
    # Remaining bytes after $FF must be $00 (padding) — relaxed: ignore
    return out


def evaluate(offset, slot_size):
    """Try to parse 50 slots at offset; return (score, slots) or (0, None)."""
    table_size = COUNT * slot_size
    if offset + table_size > len(rom):
        return 0, None
    slots = []
    for i in range(COUNT):
        s = parse_slot(rom[offset + i * slot_size:], slot_size)
        if s is None:
            return 0, None
        if len(s) == 0:
            return 0, None  # isolated province — unlikely
        if i in s:
            return 0, None  # self-loop
        slots.append(s)

    # Symmetry score
    adj = [set(s) for s in slots]
    pairs = 0
    mutual = 0
    for i in range(COUNT):
        for j in adj[i]:
            pairs += 1
            if i in adj[j]:
                mutual += 1
    if pairs == 0:
        return 0, None
    sym = mutual / pairs

    # Plausibility: average degree should be ~3-6 for a real geography
    avg_deg = pairs / COUNT
    if not (1.5 < avg_deg < 8):
        return 0, None

    score = sym * 1000 + (1 if 2.5 < avg_deg < 6 else 0) * 10
    return score, slots


def cpu_addr(prg_off):
    """Convert PRG offset to (bank, CPU addr)."""
    bank = prg_off // 0x4000
    cpu = 0x8000 + (prg_off & 0x3FFF)
    return bank, cpu


candidates = []
for slot_size in SLOT_SIZES:
    table_size = COUNT * slot_size
    for off in range(0, len(rom) - table_size, 1):
        score, slots = evaluate(off, slot_size)
        if score >= 950:  # almost-perfectly-symmetric
            candidates.append((score, off, slot_size, slots))

candidates.sort(key=lambda x: -x[0])
print(f"Found {len(candidates)} candidate tables")
for score, off, ss, slots in candidates[:10]:
    bank, cpu = cpu_addr(off)
    adj = [set(s) for s in slots]
    deg = sum(len(s) for s in slots) / COUNT
    mutual = sum(1 for i in range(COUNT) for j in adj[i] if i in adj[j])
    pairs = sum(len(s) for s in slots)
    print(f"  off=${off:06X} bank={bank} cpu=${cpu:04X} slot={ss}  "
          f"sym={mutual}/{pairs}  avg_deg={deg:.2f}  score={score:.1f}")
