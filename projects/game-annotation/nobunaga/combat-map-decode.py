#!/usr/bin/env python3
"""Reconstruct the tactical-map nametable from the combat trace.

Each tactical-map cell is a 4x4 block of NES tiles starting at PPU (col 10, row 4).
Each $C480 call paints one 4-tile row of one cell from SRAM $7BFD+.
"""
import os, re

here = os.path.dirname(os.path.abspath(__file__))
TRACE = r"C:\Users\Chris.Isaacson\AppData\Local\Microsoft\WinGet\Packages\SourMesen.Mesen2_Microsoft.Winget.Source_8wekyb3d8bbwe\Debugger\Nobunaga's Ambition (USA).txt"

PC_RE   = re.compile(r"^([0-9A-F]{4}) ")
A_RE    = re.compile(r"\bA:([0-9A-F]{2})")
FR_RE   = re.compile(r"\bFr:(\d+)")
EQ_RE   = re.compile(r"= \$([0-9A-F]{2})")

# We'll collect every nametable write with its PPU dest address.
# Approach: walk in order, track the most recent ($C480, $C486) pair as the
# current PPU dest, advancing one byte per $C4B5 write.

ppu_hi = 0
ppu_lo = 0
ppu_addr = 0
writes = []   # list of (frame, ppu_addr, byte)

frame = 0
with open(TRACE, encoding='latin-1') as f:
    for line in f:
        pc_m = PC_RE.match(line)
        if not pc_m: continue
        pc = pc_m.group(1)
        fr_m = FR_RE.search(line)
        if fr_m: frame = int(fr_m.group(1))

        if pc == 'C480':
            m = EQ_RE.search(line)
            if m: ppu_hi = int(m.group(1), 16)
        elif pc == 'C486':
            m = EQ_RE.search(line)
            if m:
                ppu_lo = int(m.group(1), 16)
                ppu_addr = (ppu_hi << 8) | ppu_lo
        elif pc == 'C4B5':
            a_m = A_RE.search(line)
            if a_m:
                byte = int(a_m.group(1), 16)
                writes.append((frame, ppu_addr, byte))
                ppu_addr += 1  # increment for next write in this row

# Build a "final state" image of the nametable
# Use a 64-col × 30-row layout to span both nametables ($2000 and $2400)
# PPU $2000 = (0,0), PPU $2400 = (0, 30) effectively, but we'll just map
# linearly: any address $2000-$2FFF maps to a single logical 64x30 grid.

nt = {}  # (row, col) -> last byte written
for fr, ppu, b in writes:
    if ppu < 0x2000 or ppu >= 0x3000: continue
    offset = ppu - 0x2000
    # First nametable ($2000-$23FF) = cols 0-31
    # Second nametable ($2400-$27FF) = cols 32-63 (assumes vertical mirroring -> horizontal layout)
    if offset < 0x400:
        row = offset // 32
        col = offset % 32
    elif offset < 0x800:
        offset -= 0x400
        row = offset // 32
        col = offset % 32 + 32
    else:
        continue  # ignore attribute tables
    if row >= 30: continue
    nt[(row, col)] = b

# Print the assembled nametable, rows 0-25
print("=== Assembled nametable (final state, both nametables side-by-side) ===")
print("     " + " ".join(f"{c:02d}" for c in range(64)))
print("     " + "-" * 192)
for row in range(28):
    cells = []
    for col in range(64):
        v = nt.get((row, col))
        cells.append(f"{v:02X}" if v is not None else "  ")
    line = " ".join(cells)
    # Mark rows that contain map cell data
    label = "*" if (row >= 4 and row < 24) else " "
    print(f"R{row:02d} {label}  {line}")

# Pull the map area: rows 4-23, cols 10-53 (44 wide × 20 tall)
# Decompose into 11×5 cells, each 4×4 tiles
print()
print("=== Tactical map: 11 × 5 cells (each 4×4 NES tiles) ===")
for cell_y in range(5):
    for tile_row in range(4):
        row = 4 + cell_y * 4 + tile_row
        cells_in_row = []
        for cell_x in range(11):
            tiles = []
            for tile_col in range(4):
                col = 10 + cell_x * 4 + tile_col
                v = nt.get((row, col))
                tiles.append(f"{v:02X}" if v is not None else "..")
            cells_in_row.append(''.join(tiles))
        print(f"  cell-y={cell_y} tile-row={tile_row}: " + " | ".join(cells_in_row))
    print()

# Identify unique cells (metatile signatures)
print("=== Unique cells in the map (cell-y, cell-x) → metatile signature ===")
signatures = {}
for cell_y in range(5):
    for cell_x in range(11):
        sig = []
        for tr in range(4):
            for tc in range(4):
                row = 4 + cell_y * 4 + tr
                col = 10 + cell_x * 4 + tc
                v = nt.get((row, col))
                sig.append(v if v is not None else -1)
        sig = tuple(sig)
        signatures.setdefault(sig, []).append((cell_x, cell_y))

print(f"Distinct cell patterns: {len(signatures)}")
for i, (sig, positions) in enumerate(sorted(signatures.items(), key=lambda kv: -len(kv[1]))):
    sig_str = ' '.join(f"{v:02X}" if v >= 0 else ".." for v in sig)
    pos_str = ', '.join(f"({x},{y})" for x,y in positions)
    print(f"  #{i:02d}  ({len(positions)}x)  {sig_str}   @ {pos_str}")
