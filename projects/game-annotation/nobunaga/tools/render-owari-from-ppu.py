#!/usr/bin/env python3
"""Render Mino's current visible section from the PPU memory dump.

PPU memory layout (16 KB = 4× $1000):
  $0000-$0FFF : pattern table 0 (BG, not used in NA1 — combat uses $1000)
  $1000-$1FFF : pattern table 1 (the active CHR for the current scene)
  $2000-$23BF : nametable 0 (current screen tile indices, 32×30)
  $23C0-$23FF : attribute table for nametable 0
  $2400-$27BF : nametable 1 (mirror or 2nd screen, depending on mirroring)
  $27C0-$27FF : attribute table for nametable 1
  $3F00-$3F1F : palettes (BG x4 + sprite x4 sub-palettes)
"""
import os
from PIL import Image

here = os.path.dirname(os.path.abspath(__file__))
ppu_path = os.path.join(here, 'traces', 'owari-ppu-memory.dmp')
with open(ppu_path, 'rb') as f:
    ppu = f.read()

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

CHR_BASE = 0x1000   # BG pattern table base for combat (per chapter 16)
NT_BASE  = 0x2000
ATTR_BASE = 0x23C0
PAL_BASE = 0x3F00

# Decode tile from CHR at idx (16 bytes per tile)
def decode_tile(idx):
    offset = CHR_BASE + idx * 16
    pixels = []
    for row in range(8):
        p0 = ppu[offset + row]
        p1 = ppu[offset + row + 8]
        line = []
        for bit in range(7, -1, -1):
            v = ((p0 >> bit) & 1) | (((p1 >> bit) & 1) << 1)
            line.append(v)
        pixels.append(line)
    return pixels

tiles = [decode_tile(i) for i in range(256)]

# Get palette (16 bytes, 4 sub-palettes)
palette_16 = list(ppu[PAL_BASE : PAL_BASE + 16])
print(f"Palette: {' '.join(f'{b:02X}' for b in palette_16)}")

# Get attribute table
attr_table = list(ppu[ATTR_BASE : ATTR_BASE + 64])

def attr_palette_index(tile_col, tile_row):
    attr_row = tile_row // 4
    attr_col = tile_col // 4
    if attr_row >= 8: attr_row = 7
    attr_byte = attr_table[attr_row * 8 + attr_col]
    qx = (tile_col % 4) // 2
    qy = (tile_row % 4) // 2
    shift = qy * 4 + qx * 2
    return (attr_byte >> shift) & 0x03

# Render the nametable
WIDTH = 32 * 8
HEIGHT = 30 * 8
img = Image.new('RGB', (WIDTH, HEIGHT))
for row in range(30):
    for col in range(32):
        nt_idx = ppu[NT_BASE + row * 32 + col]
        tile_pixels = tiles[nt_idx]
        sub_id = attr_palette_index(col, row)
        sub = palette_16[sub_id*4 : sub_id*4 + 4]
        for py in range(8):
            for px in range(8):
                v = tile_pixels[py][px]
                nes_idx = palette_16[0] if v == 0 else sub[v]
                img.putpixel((col*8 + px, row*8 + py), NES_MASTER[nes_idx & 0x3F])

out_path = os.path.join(here, 'atlas', 'owari-ppu-render.png')
img.save(out_path)
img.resize((WIDTH*2, HEIGHT*2), Image.NEAREST).save(out_path.replace('.png', '-2x.png'))
print(f"Wrote {out_path}")

# Also extract the nametable tile-index counts for analysis
from collections import Counter
nt_bytes = list(ppu[NT_BASE : NT_BASE + 960])
counts = Counter(nt_bytes)
top = counts.most_common(15)
print(f"\nTop 15 tile indices used in nametable:")
for tile_idx, count in top:
    print(f"  ${tile_idx:02X}: {count}x")

# Print full nametable (30 rows x 32 cols)
print(f"\nFull nametable hex dump:")
for row in range(30):
    bytes_str = ' '.join(f'{ppu[NT_BASE + row * 32 + c]:02X}' for c in range(32))
    print(f"  r{row:02d}: {bytes_str}")
