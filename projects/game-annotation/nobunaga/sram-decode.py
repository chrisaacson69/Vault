#!/usr/bin/env python3
"""Parse SRAM dump and find the staging buffer + metatile patterns."""
import os, re

here = os.path.dirname(os.path.abspath(__file__))
with open(os.path.join(here, 'sram_dump.txt')) as f:
    text = f.read()

# Extract all hex bytes
bytes_arr = []
for tok in text.split():
    if re.fullmatch(r'[0-9A-Fa-f]{2}', tok):
        bytes_arr.append(int(tok, 16))

print(f"Total bytes parsed: {len(bytes_arr)}")

def at(addr):
    """Convert CPU $6000+N to dump offset N."""
    return addr - 0x6000

# Verify a known landmark first: province name "Noto" should appear somewhere.
# Find all "Noto" string occurrences
target = b'Noto'
data_bytes = bytes(bytes_arr)
print()
print("'Noto' occurrences:")
i = 0
while True:
    idx = data_bytes.find(target, i)
    if idx < 0: break
    print(f"  offset ${idx:04X}  CPU ${0x6000+idx:04X}")
    i = idx + 1

# Find the metatile pattern "82 83 86 87 84 85" (cell metatile A signature)
print()
print("Metatile-A pattern (82 83 86 87 84 85) occurrences:")
target = bytes([0x82, 0x83, 0x86, 0x87, 0x84, 0x85])
i = 0
while True:
    idx = data_bytes.find(target, i)
    if idx < 0: break
    print(f"  offset ${idx:04X}  CPU ${0x6000+idx:04X}")
    i = idx + 1

# Find first cell — should be at start of staging buffer
# Updated prediction: buffer at $7BFE, 88-byte column stride, 5 cells × 16 B + 8 extra per column
print()
print("=== STAGING BUFFER AT $7BFE — 11 cols × 88 bytes ===")
print()
# Identify each known metatile pattern
PATTERNS = {
    bytes([0x82,0x83,0x86,0x87,0x84,0x85,0x88,0x89,0x8A,0x8B,0x8E,0x8F,0x8C,0x8D,0x90,0x91]): 'A',
    bytes([0xA2,0xA3,0xA6,0xA7,0xA4,0xA5,0xA8,0xA9,0xAA,0xAB,0xAE,0xAF,0xAC,0xAD,0xB0,0xB1]): 'B',
    bytes([0x92,0x93,0x96,0x97,0x94,0x95,0x98,0x99,0x9A,0x9B,0x9E,0x9F,0x9C,0x9D,0xA0,0xA1]): 'C',
    bytes([0x63,0x64,0x67,0x68,0x65,0x66,0x69,0x6A,0x6B,0x6C,0x6F,0x70,0x6D,0x6E,0x71,0x72]): 'F',
    bytes([0x73,0x74,0x77,0x78,0x75,0x76,0x79,0x7A,0x7B,0x7C,0x7C,0x7F,0x7D,0x7E,0x80,0x81]): 'D',
    bytes([0x01]*16): '.',  # blank
}

BUFFER_START = 0x7BFE
COL_STRIDE = 88
CELL_SIZE = 16
NUM_COLS = 11
NUM_ROWS = 5

def identify(window):
    for pat, name in PATTERNS.items():
        if window == pat: return name
    return '?'

# Build a 5-row x 11-col grid of metatile letters
# ISOMETRIC STAGGER: odd columns are shifted +8 bytes (= 2 NES rows down = half-cell)
grid = [['?' for _ in range(NUM_COLS)] for _ in range(NUM_ROWS)]
for col in range(NUM_COLS):
    stagger = 8 if (col % 2 == 1) else 0
    for row in range(NUM_ROWS):
        addr = BUFFER_START + col * COL_STRIDE + stagger + row * CELL_SIZE
        off = at(addr)
        if off + CELL_SIZE > len(bytes_arr): continue
        cell = bytes(bytes_arr[off:off+CELL_SIZE])
        grid[row][col] = identify(cell)

print("Visible map (11 cols × 5 rows of metatile cells) - WITH STAGGER:")
print("       " + " ".join(f"c{c}" for c in range(NUM_COLS)))
for row in range(NUM_ROWS):
    print(f"  r{row}:   " + "  ".join(grid[row]))

# Show staggered visual layout (odd cols visually shifted down)
print()
print("Visual (isometric stagger — odd cols shown shifted down half a row):")
print("       " + " ".join(f"c{c}" for c in range(NUM_COLS)))
for row in range(NUM_ROWS * 2):
    half_row = row // 2
    cells = []
    for col in range(NUM_COLS):
        is_odd_col = col % 2 == 1
        # Even cols show on even half-rows; odd cols show on odd half-rows
        if (is_odd_col and row % 2 == 1) or (not is_odd_col and row % 2 == 0):
            if half_row < NUM_ROWS:
                cells.append(grid[half_row][col])
            else:
                cells.append(' ')
        else:
            cells.append(' ')
    print(f"  hr{row}:  " + "  ".join(cells))

# Dump each column's structure raw
print()
print("Raw column dumps (each is 88 bytes, structured as 5 cells × 16B + 8B trailer):")
for col in range(NUM_COLS):
    addr = BUFFER_START + col * COL_STRIDE
    off = at(addr)
    if off + COL_STRIDE > len(bytes_arr): break
    print(f"\n  Col {col} (CPU ${addr:04X}):")
    for row in range(NUM_ROWS):
        cell_bytes = bytes_arr[off + row*16 : off + row*16 + 16]
        cell_str = ' '.join(f'{b:02X}' for b in cell_bytes)
        letter = identify(bytes(cell_bytes))
        print(f"    r{row} [{letter}]: {cell_str}")
    trailer = bytes_arr[off + 80 : off + 88]
    trailer_str = ' '.join(f'{b:02X}' for b in trailer)
    print(f"    trailer: {trailer_str}")

# Also find first "01" run of length >= 16 (looks like blank cells)
print()
print("Looking for blank-cell runs (16x 01):")
target = bytes([0x01] * 16)
i = 0
count = 0
while count < 5:
    idx = data_bytes.find(target, i)
    if idx < 0: break
    print(f"  offset ${idx:04X}  CPU ${0x6000+idx:04X}")
    i = idx + 1
    count += 1
