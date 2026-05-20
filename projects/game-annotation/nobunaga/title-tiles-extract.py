#!/usr/bin/env python3
"""Extract title-screen tile graphics from ROM bank 0 starting at $AC4A.

NES 2bpp format per tile (16 bytes):
  bytes 0-7  = bit-plane 0 (one byte per row of 8 pixels, MSB = leftmost)
  bytes 8-15 = bit-plane 1
For each row, combine plane0 and plane1 bit-by-bit to get a pixel value 0-3.
"""
import os

here = os.path.dirname(os.path.abspath(__file__))
rom_path = os.path.join(here, "Nobunaga's Ambition (USA).nes")
with open(rom_path, 'rb') as f:
    data = f.read()[16:]   # skip iNES header

PRG_BANK = 0x4000
# Title-screen CHR source = bank 0 $AC4A (from chapter 16 trace work)
SRC_BANK = 0
SRC_CPU  = 0xAC4A
SRC_PRG  = SRC_BANK * PRG_BANK + (SRC_CPU - 0x8000)

NUM_TILES = 80   # tile $00-$4F, covering everything the title uses

def decode_tile(blob):
    """Decode 16 bytes → 8x8 grid of pixel values 0-3."""
    pixels = []
    for row in range(8):
        p0 = blob[row]
        p1 = blob[row + 8]
        line = []
        for bit in range(7, -1, -1):
            v = ((p0 >> bit) & 1) | (((p1 >> bit) & 1) << 1)
            line.append(v)
        pixels.append(line)
    return pixels

# Extract tiles
tiles = []
for i in range(NUM_TILES):
    offset = SRC_PRG + i * 16
    blob = data[offset:offset + 16]
    tiles.append(decode_tile(blob))

# ASCII render — 4 levels of "ink"
CHARS = [' ', '.', '+', '#']

print(f"Source: PRG ${SRC_PRG:05X} (bank {SRC_BANK}, CPU ${SRC_CPU:04X})")
print(f"Decoding {NUM_TILES} tiles as 8x8 grids using 2bpp NES format")
print()

# Render in a grid: 16 tiles per row
TILES_PER_ROW = 16
for row_start in range(0, NUM_TILES, TILES_PER_ROW):
    # Print the tile-index header
    print('  '.join(f'  ${row_start+c:02X}    ' for c in range(min(TILES_PER_ROW, NUM_TILES - row_start))))
    # Print each pixel row of this band of tiles
    for pixel_row in range(8):
        line_parts = []
        for col in range(TILES_PER_ROW):
            tile_idx = row_start + col
            if tile_idx >= NUM_TILES: break
            pixels = tiles[tile_idx][pixel_row]
            line_parts.append(''.join(CHARS[v] for v in pixels))
        print('  '.join(line_parts))
    print()
