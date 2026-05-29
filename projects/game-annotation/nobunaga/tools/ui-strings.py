"""
ui-strings.py — Dump the master UI string table from Nobunaga's Ambition.

Bank 15 holds the game's UI label strings as plain null-terminated ASCII:

  $F840  21 packed strings  — the lord-command menu (Move, War, ... Pass)
  $F8AE  18 x 16-bit LE ptr — pointer table -> the stat-label strings
  $F8D2+ the stat strings   — 6 character-stat labels, then 12 fief-stat labels

The fief-stat labels appear in *record order*, so this table independently
confirms the $7001 province-record layout decoded in chapters 9-10:
gold debt town rice output dams loyalty wealth men morale skill arms.

Usage:  python ui-strings.py <rom> [out.txt]
"""
import sys

rom = open(sys.argv[1], "rb").read()[16:]
out_path = sys.argv[2] if len(sys.argv) > 2 else "ui-strings.txt"

def c15(cpu):                       # bank-15 CPU addr -> PRG offset
    return 15 * 0x4000 + (cpu & 0x3FFF)

def read_str(cpu):
    p = c15(cpu); a = p
    while a < len(rom) and rom[a] != 0:
        a += 1
    return rom[p:a].decode("ascii", "replace")

MENU_BASE = 0xF840          # packed null-terminated strings
MENU_COUNT = 21
PTRTBL_BASE = 0xF8AE        # 16-bit LE pointers to the stat-label strings
CHAR_STAT_COUNT = 6
FIEF_STAT_COUNT = 12

lines = []
def emit(s=""): lines.append(s)

emit("Nobunaga's Ambition (USA) - master UI string table (bank 15)")
emit("Plain null-terminated ASCII. Found by searching the ROM for the known")
emit("menu/stat words, not hand-keyed — see chapter 9/10.")
emit("=" * 64)
emit()

emit(f"-- Lord-command menu @ ${MENU_BASE:04X} ({MENU_COUNT} packed strings) --")
emit("   in-game item N == this index N+1 == command-table.txt index N")
addr = MENU_BASE
for i in range(MENU_COUNT):
    s = read_str(addr)
    emit(f"  [{i:>2}] item {i+1:>2}  ${addr:04X}  {s}")
    addr += len(s) + 1

emit()
emit(f"-- Stat-label pointer table @ ${PTRTBL_BASE:04X} "
     f"({CHAR_STAT_COUNT + FIEF_STAT_COUNT} x 16-bit LE) --")
for i in range(CHAR_STAT_COUNT + FIEF_STAT_COUNT):
    p = c15(PTRTBL_BASE + i * 2)
    w = rom[p] | (rom[p+1] << 8)
    if i < CHAR_STAT_COUNT:
        kind = f"char-stat {i}"            # daimyo record: age + 5 attrs
    else:
        kind = f"fief-stat {i - CHAR_STAT_COUNT}"   # province record field index
    emit(f"  [{i:>2}] {kind:<13} -> ${w:04X}  {read_str(w)!r}")

emit()
emit("The fief-stat labels are in $7001 province-record order:")
emit("  byte offset 0 2 4 6 8 10 12 14 16 18 20 22 = "
     "gold debt town rice output dams loyalty wealth men morale skill arms")
emit("(the header / base-koku field at offset 24 has no label in this table).")

with open(out_path, "w", encoding="utf-8") as f:
    f.write("\n".join(lines) + "\n")

print(f"Wrote {out_path} ({len(lines)} lines)")
for ln in lines:
    print("  " + ln)
