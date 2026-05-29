#!/usr/bin/env python3
"""Hunt for the actual cell-index table in all ROM banks.

The table should be 935 bytes (17 fiefs × 55) of "map-like" data:
- Many byte values repeat (terrain has spatial coherence)
- Distinct-value count per 55-byte window: ~10-40 (not ~50+ like code)
- Wide range across the full 935 bytes (different fiefs have different terrains)
"""
import os

rom_path = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                       "Nobunaga's Ambition (USA).nes")
with open(rom_path, 'rb') as f:
    data = f.read()[16:]

PRG = 0x4000
NUM_BANKS = 16

def map_likeness_score(window):
    """Higher = more like map data, lower = more like code.
    Heuristic: penalize windows with high frequency of VM-opcode patterns."""
    # Code markers (VM opcodes that occur a lot in code)
    code_markers = {0xCF, 0xE9, 0xD3, 0xB3, 0xAC, 0xD7, 0xD8, 0x20, 0x23, 0xE8}
    code_count = sum(1 for b in window if b in code_markers)
    # Data should have repeats (terrain runs)
    from collections import Counter
    counts = Counter(window)
    distinct = len(counts)
    max_run = max(counts.values())
    # Score: lower distinct count + fewer code markers + some run-length = data-like
    return -code_count * 2 + max_run + (40 - min(distinct, 40))

# Test every bank, every 16-byte aligned position from $8000-$BFFF (or $C000-$FFFF for bank 15)
print("Top map-likeness candidates (each = 935-byte window):")
print(f"{'Bank':>4} {'CPU addr':>9}  {'Score':>5}  {'Distinct':>8}  {'MaxRun':>6}  First-16-bytes")
candidates = []

for bank in range(NUM_BANKS):
    bank_base = bank * PRG
    cpu_base = 0xC000 if bank == NUM_BANKS - 1 else 0x8000
    # Try aligned starts
    for offset in range(0, PRG - 935, 1):
        window = data[bank_base + offset : bank_base + offset + 935]
        if len(window) < 935: continue
        from collections import Counter
        counts = Counter(window)
        distinct = len(counts)
        # Want: 10-50 distinct values (not too few = padding, not too many = code)
        if distinct < 10 or distinct > 50: continue
        max_run = max(counts.values())
        # Want: max run NOT dominant (real terrain has variation)
        if max_run > 500: continue
        # Top value shouldn't be > 20% of bytes (terrain shouldn't dominate)
        if max_run > 200: continue
        # Want at least 15 distinct values
        if distinct < 15: continue
        score = map_likeness_score(window)
        candidates.append((score, bank, cpu_base + offset, distinct, max_run, window[:16]))

candidates.sort(reverse=True)
for c in candidates[:15]:
    score, bank, cpu, distinct, max_run, head = c
    head_str = ' '.join(f'{b:02X}' for b in head)
    print(f"{bank:>4}  ${cpu:04X}    {score:>5}  {distinct:>8}  {max_run:>6}  {head_str}")
