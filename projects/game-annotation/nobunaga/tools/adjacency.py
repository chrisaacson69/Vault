"""
adjacency.py — Dump the province adjacency table from Nobunaga's Ambition.

Move, War, and Send all need to know which provinces border which. That graph
is stored in bank 4 at $8300: one 8-byte slot per province, holding 0-based
neighbour indices terminated by $FF (unused slot bytes are $00).

The 17-fief table was verified against a hand-derived adjacency matrix —
17/17 provinces match exactly. This tool dumps it as a reference (an appendix
to the strategic-engine chapters) and prints it both as neighbour lists and
as a matrix.

Usage:  python adjacency.py <rom> [out.txt]
"""
import sys

rom = open(sys.argv[1], "rb").read()[16:]
out_path = sys.argv[2] if len(sys.argv) > 2 else "adjacency.txt"

TABLE_BANK = 4
TABLE_CPU = 0x8300          # 17-fief province adjacency, 8-byte slots
SLOT = 8
COUNT = 17                 # 17-fief scenario

def prg(cpu, bank):
    return bank * 0x4000 + (cpu & 0x3FFF)

def neighbours(idx):
    """0-based neighbour indices for province idx (0-based)."""
    base = prg(TABLE_CPU + idx * SLOT, TABLE_BANK)
    out = []
    for b in rom[base:base + SLOT]:
        if b == 0xFF or b >= COUNT:
            break
        out.append(b)
    return out

lines = []
def emit(s=""): lines.append(s)

emit("Nobunaga's Ambition (USA) - province adjacency table (17-fief)")
emit(f"Bank {TABLE_BANK} ${TABLE_CPU:04X}, {SLOT}-byte slots, 0-based province")
emit("indices, $FF-terminated. Verified 17/17 against a hand-derived matrix.")
emit("=" * 60)
emit()
emit("-- neighbour lists (province numbers shown 1-based, as in-game) --")
for i in range(COUNT):
    nb = sorted(n + 1 for n in neighbours(i))
    raw = " ".join(f"{b:02X}" for b in rom[prg(TABLE_CPU + i*SLOT, TABLE_BANK):
                                            prg(TABLE_CPU + i*SLOT, TABLE_BANK) + SLOT])
    emit(f"  {i+1:>2}: {', '.join(str(n) for n in nb):<24}  [{raw}]")

emit()
emit("-- adjacency matrix (row = from, col = to; X = border) --")
hdr = "     " + " ".join(f"{c+1:>2}" for c in range(COUNT))
emit(hdr)
adj = [set(neighbours(i)) for i in range(COUNT)]
for i in range(COUNT):
    row = " ".join(" X" if j in adj[i] else "  ." [0:2] for j in range(COUNT))
    emit(f"  {i+1:>2} {row}")

emit()
# symmetry check — adjacency should be mutual
asym = [(i+1, j+1) for i in range(COUNT) for j in adj[i] if i not in adj[j]]
emit(f"symmetry check: {'all mutual' if not asym else 'ASYMMETRIC: ' + str(asym)}")
emit("note: the 50-fief scenario has its own adjacency table (not yet located).")

with open(out_path, "w", encoding="utf-8") as f:
    f.write("\n".join(lines) + "\n")
print(f"Wrote {out_path} ({len(lines)} lines)")
for ln in lines:
    print("  " + ln)
