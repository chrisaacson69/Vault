#!/usr/bin/env python3
"""Render Iga (fief 12, 0-indexed 11) tactical map from bank-4 cell-array data.

Uses the byte-to-terrain mapping derived 2026-05-21:
  $04 = clear, $10 = forest, $40 = mountain, $80 = town, $20 = castle,
  $02 = sea/river, $08 = bridge/special
"""
import os
from PIL import Image, ImageDraw, ImageFont

here = os.path.dirname(os.path.abspath(__file__))
rom_path = os.path.join(here, "Nobunaga's Ambition (USA).nes")
with open(rom_path, 'rb') as f:
    data = f.read()[16:]

PRG_BANK = 0x4000
FIEF = 11  # Iga (= fief 12 1-indexed)
CELL_TABLE_BASE = 0xA57E
prg_offset = 4 * PRG_BANK + (CELL_TABLE_BASE + FIEF * 55 - 0x8000)
cell_bytes = data[prg_offset : prg_offset + 55]

# Byte → terrain letter mapping (hypothesis)
BYTE_TO_TERRAIN = {
    0x04: 'A',  # clear
    0x10: 'B',  # forest
    0x40: 'C',  # mountain
    0x80: 'D',  # town / large feature
    0x20: 'F',  # castle / fortress
    0x02: 'E',  # sea / river
    0x08: 'G',  # bridge / special
}

# Colors per terrain
TERRAIN_COLORS = {
    'A': (180, 220, 130),
    'B': (40, 110, 50),
    'C': (130, 130, 130),
    'D': (210, 150, 90),
    'F': (180, 60, 60),
    'E': (90, 140, 200),
    'G': (160, 120, 200),  # purple for bridge/special
}
TERRAIN_DARK = {k: tuple(int(v*0.7) for v in c) for k, c in TERRAIN_COLORS.items()}
LABEL_COLOR = {
    'A': (60, 100, 30),
    'B': (200, 230, 180),
    'C': (255, 255, 255),
    'D': (60, 30, 0),
    'F': (255, 220, 200),
    'E': (220, 240, 255),
    'G': (255, 230, 255),
}

# Build the grid from cell bytes
grid = []
for row in range(5):
    grid.append([BYTE_TO_TERRAIN.get(cell_bytes[row * 11 + c], '?') for c in range(11)])

print("Iga tactical map (decoded from bank-4 $A7DB):")
for row in range(5):
    print(f"  row {row}: {' '.join(grid[row])}")
print()

# Render with isometric stagger
WIDTH = 11 * 4 * 8
HEIGHT = (5 * 4 + 2) * 8
CELL_PX = 32

img = Image.new('RGB', (WIDTH, HEIGHT), (20, 20, 30))
draw = ImageDraw.Draw(img)
try:
    font = ImageFont.truetype("arial.ttf", 12)
    font_small = ImageFont.truetype("arial.ttf", 9)
except Exception:
    font = ImageFont.load_default()
    font_small = font

for col in range(11):
    for row in range(5):
        terrain = grid[row][col]
        if terrain == '?':
            continue
        stagger_px = 16 if (col % 2 == 1) else 0
        x = col * CELL_PX
        y = row * CELL_PX + stagger_px
        body = TERRAIN_COLORS[terrain]
        inner = TERRAIN_DARK[terrain]
        draw.rectangle([x, y, x+CELL_PX-1, y+CELL_PX-1], fill=body)
        draw.rectangle([x+4, y+4, x+CELL_PX-5, y+CELL_PX-5], outline=inner, width=1)
        draw.text((x + 12, y + 9), terrain, fill=LABEL_COLOR[terrain], font=font)
        draw.text((x + 1, y + 1), f"{col},{row}", fill=LABEL_COLOR[terrain], font=font_small)

# Section dividers
for boundary in [5 * CELL_PX, 8 * CELL_PX]:
    draw.line([boundary, 0, boundary, HEIGHT], fill=(80, 80, 100), width=1)

img.save(os.path.join(here, 'iga-full-map.png'))
img.resize((WIDTH*2, HEIGHT*2), Image.NEAREST).save(os.path.join(here, 'iga-full-map-2x.png'))
print(f"Wrote iga-full-map.png ({WIDTH}x{HEIGHT}) and 2x version")
print()
print("Legend: A=clear B=forest C=mountain D=town F=castle E=sea G=bridge")
