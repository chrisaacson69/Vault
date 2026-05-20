#!/usr/bin/env python3
"""Render the NA1 main title screen from extracted data:
  - Nametable from PPU dump (nametable_title.txt)
  - Attribute table from PPU dump (hardcoded inline below)
  - CHR data from trace reconstruction (title-chr.bin)
  - Palette: PLACEHOLDER (using copyright's until we get actual)
"""
import os, re

here = os.path.dirname(os.path.abspath(__file__))

# ---- NES master palette ----
NES_MASTER = [
    (84,84,84),(0,30,116),(8,16,144),(48,0,136),(68,0,100),(92,0,48),(84,4,0),(60,24,0),
    (32,42,0),(8,58,0),(0,64,0),(0,60,0),(0,50,60),(0,0,0),(0,0,0),(0,0,0),
    (152,150,152),(8,76,196),(48,50,236),(92,30,228),(136,20,176),(160,20,100),(152,34,32),(120,60,0),
    (84,90,0),(40,114,0),(8,124,0),(0,118,40),(0,102,120),(0,0,0),(0,0,0),(0,0,0),
    (236,238,236),(76,154,236),(120,124,236),(176,98,236),(228,84,236),(236,88,180),(236,106,100),(212,136,32),
    (160,170,0),(116,196,0),(76,208,32),(56,204,108),(56,180,204),(60,60,60),(0,0,0),(0,0,0),
    (236,238,236),(168,204,236),(188,188,236),(212,178,236),(236,174,236),(236,174,212),(236,180,176),(228,196,144),
    (204,210,120),(180,222,120),(168,226,144),(152,226,180),(160,214,228),(160,162,160),(0,0,0),(0,0,0),
]

# ---- Actual title-screen palette from PPU $3F00-$3F0F ----
PALETTES_16 = [
    0x3E, 0x16, 0x27, 0x30,    # Sub 0: bg, dark-red, bright-orange, white
    0x3E, 0x38, 0x30, 0x30,    # Sub 1: bg, light-yellow, white, white
    0x3E, 0x18, 0x29, 0x30,    # Sub 2: bg, dark-olive, light-olive, white
    0x3E, 0x18, 0x01, 0x30,    # Sub 3: bg, dark-olive, deep-blue, white
]

# ---- Title-screen attribute table (PPU $23C0-$23FF) ----
ATTR_TABLE = [
    0x50,0x50,0x50,0x50, 0x10,0x00,0x00,0x00,
    0x55,0x55,0x55,0x55, 0x11,0x00,0x00,0x00,
    0x00,0x00,0x00,0x00, 0x00,0x00,0x00,0x00,
    0x00,0x00,0x00,0x00, 0x00,0x00,0x00,0x00,
    0x00,0x00,0x00,0x00, 0x00,0x00,0x00,0x00,
    0x00,0x00,0x00,0x00, 0x00,0x00,0x00,0x00,
    0x00,0x00,0x00,0x00, 0x00,0x50,0x50,0x10,
    0x00,0x00,0x00,0x00, 0x00,0x00,0x00,0x00,
]

def attr_palette_index(tile_col, tile_row):
    attr_row = tile_row // 4
    attr_col = tile_col // 4
    if attr_row >= 8: attr_row = 7
    attr_byte = ATTR_TABLE[attr_row * 8 + attr_col]
    quadrant_x = (tile_col % 4) // 2
    quadrant_y = (tile_row % 4) // 2
    shift = quadrant_y * 4 + quadrant_x * 2
    return (attr_byte >> shift) & 0x03

# ---- Load CHR data — prefer the full PPU dump if available ----
chr_dump_path = os.path.join(here, 'title-chr-dump.txt')
chr_bin_path  = os.path.join(here, 'title-chr.bin')
if os.path.exists(chr_dump_path):
    chr_data = bytearray(4096)
    i = 0
    with open(chr_dump_path) as f:
        for tok in f.read().split():
            if re.fullmatch(r'[0-9A-Fa-f]{2}', tok) and i < 4096:
                chr_data[i] = int(tok, 16)
                i += 1
    print(f"Loaded {i} CHR bytes from PPU dump (title-chr-dump.txt)")
else:
    with open(chr_bin_path, 'rb') as f:
        chr_data = f.read()
    print(f"Loaded {len(chr_data)} CHR bytes from trace reconstruction")

def decode_tile(idx):
    """Decode tile at given index (0-255) from the CHR data."""
    offset = idx * 16
    pixels = []
    for row in range(8):
        p0 = chr_data[offset + row]
        p1 = chr_data[offset + row + 8]
        line = []
        for bit in range(7, -1, -1):
            v = ((p0 >> bit) & 1) | (((p1 >> bit) & 1) << 1)
            line.append(v)
        pixels.append(line)
    return pixels

tiles = [decode_tile(i) for i in range(256)]

# ---- Load nametable from text file ----
with open(os.path.join(here, 'nametable_title.txt')) as f:
    text = f.read()
nt_bytes = []
for tok in text.split():
    if re.fullmatch(r'[0-9A-Fa-f]{2}', tok):
        nt_bytes.append(int(tok, 16))
print(f"Nametable: {len(nt_bytes)} bytes")

# ---- Composite ----
WIDTH, HEIGHT = 32*8, 30*8
pixels = [[0]*WIDTH for _ in range(HEIGHT)]
for row in range(30):
    for col in range(32):
        tile_idx = nt_bytes[row*32 + col]
        if tile_idx >= len(tiles): continue
        tile_pixels = tiles[tile_idx]
        sub_id = attr_palette_index(col, row)
        sub = PALETTES_16[sub_id*4 : sub_id*4 + 4]
        for py in range(8):
            for px in range(8):
                v = tile_pixels[py][px]
                nes_idx = PALETTES_16[0] if v == 0 else sub[v]
                pixels[row*8 + py][col*8 + px] = nes_idx

# ---- Save PNG ----
from PIL import Image
img = Image.new('RGB', (WIDTH, HEIGHT))
for y in range(HEIGHT):
    for x in range(WIDTH):
        img.putpixel((x, y), NES_MASTER[pixels[y][x] & 0x3F])
img.save(os.path.join(here, 'title2.png'))
img.resize((WIDTH*2, HEIGHT*2), Image.NEAREST).save(os.path.join(here, 'title2-2x.png'))
print(f"Wrote title2.png and title2-2x.png")
