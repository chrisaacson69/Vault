"""
command-table.py — Dump the lord-command driver table from Nobunaga's Ambition.

The menu's command handlers are NOT a single switch. Each menu command is a
separate bytecode subroutine, and their entry points live in a pointer table
in bank 1 at $B9B2. Menu item N (1-based, as shown in-game) is table index N-1.

Confirmed: a Mesen $EB7A call trace while picking in-game menu item 7 ("Grow")
landed on table index 6 = $9D3D. So: in-game item == table index + 1.

This tool walks the table, validates each entry is a real bytecode subroutine
(starts with the JSR $E823 stub), groups entries by their opening-byte
signature into command "families", and emits a reference + roadmap for the
per-command decode work (chapter 9).

Usage:  python command-table.py <rom> [out.txt]
"""
import sys

rom = open(sys.argv[1], "rb").read()[16:]
out_path = sys.argv[2] if len(sys.argv) > 2 else "command-table.txt"

TABLE_CPU = 0xB9B2          # bank 1
TABLE_BANK = 1
STUB = bytes([0x20, 0x23, 0xE8])   # JSR $E823 — bytecode-subroutine entry stub

def b1(cpu):                # bank-1 CPU addr -> PRG offset
    return TABLE_BANK * 0x4000 + (cpu & 0x3FFF)

def is_stub(cpu):
    p = b1(cpu)
    return rom[p:p+3] == STUB

# --- walk the table until an entry stops looking like a command driver ---
entries = []
i = 0
while True:
    p = b1(TABLE_CPU + i * 2)
    w = rom[p] | (rom[p+1] << 8)
    if not (0x8000 <= w <= 0xBFFF) or not is_stub(w):
        break
    bp = b1(w)
    frame_off = rom[bp+3] | (rom[bp+4] << 8)
    sig = bytes(rom[bp+5:bp+5+8])      # first 8 bytecode bytes = family fingerprint
    entries.append((i, w, frame_off, sig))
    i += 1
    if i > 64:                          # safety cap
        break

# --- group by opening signature into families ---
families = {}
for idx, addr, foff, sig in entries:
    families.setdefault(sig, []).append(idx)

lines = []
def emit(s=""): lines.append(s)

emit("Nobunaga's Ambition (USA) - lord-command driver table")
emit(f"Table @ bank 1 ${TABLE_CPU:04X}, {len(entries)} entries.")
emit("In-game menu item N == table index N-1  (verified: item 7 'Grow' == index 6 $9D3D).")
emit("Each entry is a bytecode subroutine; 'frame_off' is the stub's frame-pointer delta.")
emit("=" * 72)
emit()
emit(f"{'idx':>3} {'item#':>5} {'driver':>7} {'frame':>6}  first 8 bytecode bytes")
emit("-" * 72)
for idx, addr, foff, sig in entries:
    sig_hex = " ".join(f"{b:02X}" for b in sig)
    emit(f"{idx:>3} {idx+1:>5} ${addr:04X}  ${foff:04X}  {sig_hex}")

emit()
emit("Command families (entries sharing an opening-byte signature):")
emit("-" * 72)
for sig, idxs in sorted(families.items(), key=lambda kv: -len(kv[1])):
    sig_hex = " ".join(f"{b:02X}" for b in sig)
    members = ", ".join(f"{x}(${dict((e[0],e[1]) for e in entries)[x]:04X})" for x in idxs)
    tag = "  <- Grow is here" if 6 in idxs else ""
    emit(f"  [{sig_hex}]  x{len(idxs)}{tag}")
    emit(f"      indices: {members}")

with open(out_path, "w", encoding="utf-8") as f:
    f.write("\n".join(lines) + "\n")
print(f"Wrote {out_path} ({len(entries)} command drivers, "
      f"{len(families)} families)")
for ln in lines:
    print("  " + ln)
