"""
adjacency-50.py — Dump the 50-fief province adjacency table.

Located 2026-05-29 at bank 4 $8004 via symmetry-constrained ROM scan
(find-adjacency-50.py). Same encoding as the 17-fief table at $8300:
8-byte slots, 0-based province indices, $FF-terminated, $00 padded.

Usage:  py adjacency-50.py <rom> [out.txt]
"""
import sys

rom = open(sys.argv[1], "rb").read()
if rom[:4] == b"NES\x1a":
    rom = rom[16:]
out_path = sys.argv[2] if len(sys.argv) > 2 else "adjacency-50.txt"

TABLE_BANK = 4
TABLE_CPU = 0x8004
SLOT = 8
COUNT = 50

NAMES = [
    "Ezo", "Mutsu", "Morioka", "Iwasaki", "Ugo", "Rikuzen", "Uzen", "Iwaki",
    "Iwashiro", "Echigo", "Hitachi", "Shimotsu", "Awa(E)", "Musashi", "Shinano",
    "Noto", "Ecchu", "Hida", "Kiso", "Suruga", "Kaga", "Echizen", "Mino",
    "Mikawa", "Owari", "Iseshima", "Omi", "Iga", "Tango", "Tanba", "Yamashir",
    "Yamato", "Settsu", "Kii", "Inaba", "Harima", "Izumo", "Sanbi", "Aki",
    "Sanuki", "Awa(S)", "Iyo", "Tosa", "Nakamura", "Buzen", "Chikuhi", "Bungo",
    "Higo", "Hiyuga", "Satuma",
]

def prg(cpu, bank): return bank * 0x4000 + (cpu & 0x3FFF)

def neighbours(idx):
    base = prg(TABLE_CPU + idx * SLOT, TABLE_BANK)
    out = []
    for b in rom[base:base + SLOT]:
        if b == 0xFF or b >= COUNT:
            break
        out.append(b)
    return out

lines = []
def emit(s=""): lines.append(s)

emit("Nobunaga's Ambition (USA) - province adjacency table (50-fief)")
emit(f"Bank {TABLE_BANK} ${TABLE_CPU:04X}, {SLOT}-byte slots, 0-based province")
emit("indices, $FF-terminated. Located via symmetry-constrained ROM scan.")
emit("=" * 72)
emit()
emit("-- neighbour lists (province numbers shown 1-based, as in-game) --")
for i in range(COUNT):
    nb = sorted(neighbours(i))
    raw = " ".join(f"{b:02X}" for b in rom[prg(TABLE_CPU + i*SLOT, TABLE_BANK):
                                            prg(TABLE_CPU + i*SLOT, TABLE_BANK) + SLOT])
    nb_str = ", ".join(f"{n+1}({NAMES[n]})" for n in nb)
    emit(f"  {i+1:>2} {NAMES[i]:<10}: {nb_str}")
    emit(f"      raw: [{raw}]")

emit()
emit("-- adjacency matrix (row = from, col = to; X = border) --")
hdr = "          " + " ".join(f"{c+1:>2}" for c in range(COUNT))
emit(hdr)
adj = [set(neighbours(i)) for i in range(COUNT)]
for i in range(COUNT):
    row = " ".join(" X" if j in adj[i] else " ." for j in range(COUNT))
    emit(f"  {i+1:>2} {NAMES[i]:<7} {row}")

emit()
# symmetry + degree stats
asym = [(i+1, j+1) for i in range(COUNT) for j in adj[i] if i not in adj[j]]
emit(f"symmetry check: {'all mutual' if not asym else 'ASYMMETRIC: ' + str(asym)}")
total_edges = sum(len(s) for s in adj) // 2
deg = [len(s) for s in adj]
emit(f"edges: {total_edges}  avg degree: {sum(deg)/len(deg):.2f}  "
     f"min/max degree: {min(deg)}/{max(deg)}")
emit()

# Historical sanity checks
emit("-- sanity checks against known historical adjacencies --")
checks = [
    (23, 24, "Mikawa-Owari"),
    (23, 22, "Mikawa-Mino"),
    (23, 19, "Mikawa-Suruga"),
    (24, 22, "Owari-Mino"),
    (24, 25, "Owari-Iseshima"),
    (24, 26, "Owari-Omi"),
    (22, 21, "Mino-Echizen"),
    (22, 17, "Mino-Hida"),
    (32, 30, "Settsu-Yamashir"),
    (32, 35, "Settsu-Harima"),
    (0, 1, "Ezo-Mutsu"),
    (49, 47, "Satuma-Higo"),
    (49, 48, "Satuma-Hiyuga"),
    (13, 14, "Musashi-Shinano"),
    (13, 10, "Musashi-Hitachi"),
    (9, 14, "Echigo-Shinano"),
]
for a, b, label in checks:
    yes = b in adj[a]
    emit(f"  {label:<22}: {'OK' if yes else 'MISS'}  ({a+1}-{b+1})")

with open(out_path, "w", encoding="utf-8") as f:
    f.write("\n".join(lines) + "\n")
print(f"Wrote {out_path} ({len(lines)} lines)")
for ln in lines:
    print("  " + ln)
