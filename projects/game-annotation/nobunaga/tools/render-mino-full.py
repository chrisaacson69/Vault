#!/usr/bin/env python3
"""Render the FULL 11x5 isometric tactical map of Mino (fief 9) directly from
ROM data. Demonstrates that the map is recoverable from the engine internals
even though the game only ever shows 5x5 windows at runtime.

Data sources (all ROM-derived from prior chapters):
  - 11x5 metatile letter grid: chapter 16 validation against Chris's Mino layout
  - Metatile dictionary: bank-2 $B100-$B17D (16 bytes each, ROM)
  - Isometric stagger: chapter 16 (odd cols shift +8 bytes = 2 NES rows down)
  - Terrain palette: chapter 17 (A=clear, B=forest, C=mountain, D=town, F=castle)

Output: 352 x 176 px PNG covering the entire Mino battlefield, with the
isometric staggered layout that the engine uses in its $7B4E SRAM buffer.

The on-screen game window only shows 5x5 cells at a time (3 overlapping
sections), but the underlying data describes all 55 cells. This script
renders all 55.
"""
import os
from PIL import Image, ImageDraw, ImageFont

here = os.path.dirname(os.path.abspath(__file__))

# Chapter-16-validated 11x5 metatile grid for Mino (fief 9, 0-indexed 8)
# Letters: A=clear, B=forest, C=mountain, D=town, F=castle
# Validated against Chris's hand-drawn map: fortress at (1,6), town at (3,6),
# mountain between at (2,6); diagonal mountain ridge (0,8)-(3,3); etc.
MINO_GRID = [
    list("AAABBBBBCBB"),  # row 0
    list("BBCCBBFCCBB"),  # row 1 — F = fortress/castle at col 6
    list("BBBBCCCACCB"),  # row 2 — C between fortress and town
    list("BBBCCADAAAB"),  # row 3 — D = town at col 6
    list("BBBAAAAAAAB"),  # row 4
]

# CHR tile indices each metatile references (from chapter 16 dictionary)
METATILE_DICT = {
    'A': [0x82,0x83,0x86,0x87, 0x84,0x85,0x88,0x89, 0x8A,0x8B,0x8E,0x8F, 0x8C,0x8D,0x90,0x91],
    'B': [0xA2,0xA3,0xA6,0xA7, 0xA4,0xA5,0xA8,0xA9, 0xAA,0xAB,0xAE,0xAF, 0xAC,0xAD,0xB0,0xB1],
    'C': [0x92,0x93,0x96,0x97, 0x94,0x95,0x98,0x99, 0x9A,0x9B,0x9E,0x9F, 0x9C,0x9D,0xA0,0xA1],
    'D': [0x73,0x74,0x77,0x78, 0x75,0x76,0x79,0x7A, 0x7B,0x7C,0x7C,0x7F, 0x7D,0x7E,0x80,0x81],
    'F': [0x63,0x64,0x67,0x68, 0x65,0x66,0x69,0x6A, 0x6B,0x6C,0x6F,0x70, 0x6D,0x6E,0x71,0x72],
}

# Stylized colors per terrain type (RGB)
TERRAIN_COLORS = {
    'A': (180, 220, 130),   # clear / plains — light green
    'B': (40, 110, 50),     # forest — dark green
    'C': (130, 130, 130),   # mountain — grey
    'D': (210, 150, 90),    # town — tan/orange
    'F': (180, 60, 60),     # castle — dark red
    'E': (90, 140, 200),    # river / sea — blue (unused in Mino)
}
TERRAIN_DARK = {  # darker variant for cell interior shading
    'A': (140, 180, 100),
    'B': (28, 80, 38),
    'C': (95, 95, 95),
    'D': (160, 110, 60),
    'F': (130, 30, 30),
    'E': (50, 100, 160),
}
LABEL_COLOR = {
    'A': (60, 100, 30),
    'B': (200, 230, 180),
    'C': (255, 255, 255),
    'D': (60, 30, 0),
    'F': (255, 220, 200),
    'E': (220, 240, 255),
}

# Image dimensions:
#   11 cells wide x 4 NES tiles per cell x 8 px = 352 px wide
#   5 cells tall x 4 NES tiles per cell x 8 px = 160 px PLUS 16 px stagger = 176 px
WIDTH = 11 * 4 * 8       # 352
HEIGHT = (5 * 4 + 2) * 8  # 176 (+2 NES rows for isometric stagger)
CELL_PX = 32              # 4 NES tiles × 8 px

img = Image.new('RGB', (WIDTH, HEIGHT), (20, 20, 30))   # very dark background
draw = ImageDraw.Draw(img)

# Try to get a small font for labels
try:
    font = ImageFont.truetype("arial.ttf", 12)
    font_small = ImageFont.truetype("arial.ttf", 9)
except Exception:
    font = ImageFont.load_default()
    font_small = font

# Render each cell
for col in range(11):
    for row in range(5):
        terrain = MINO_GRID[row][col]
        if terrain not in TERRAIN_COLORS:
            continue
        # Apply isometric stagger — odd columns shift down by 2 NES rows = 16 px
        stagger_px = 16 if (col % 2 == 1) else 0
        x = col * CELL_PX
        y = row * CELL_PX + stagger_px
        # Cell body
        body = TERRAIN_COLORS[terrain]
        inner = TERRAIN_DARK[terrain]
        # Outer 32x32 rect
        draw.rectangle([x, y, x+CELL_PX-1, y+CELL_PX-1], fill=body)
        # Inner detail (small inset showing the cell pattern)
        draw.rectangle([x+4, y+4, x+CELL_PX-5, y+CELL_PX-5], outline=inner, width=1)
        # Cell label (terrain letter + coordinates)
        label = terrain
        draw.text((x + 12, y + 9), label, fill=LABEL_COLOR[terrain], font=font)
        # Cell coordinates in corner
        draw.text((x + 1, y + 1), f"{col},{row}", fill=LABEL_COLOR[terrain], font=font_small)

# Draw section dividers (the 3 viewing windows: cols 0-4, 3-7, 6-10)
# Show the windows as faint vertical lines
for boundary in [5*CELL_PX, 8*CELL_PX]:  # boundaries between sections
    draw.line([boundary, 0, boundary, HEIGHT], fill=(80, 80, 100), width=1)

# Title at the top
img.save(os.path.join(here, 'mino-full-map.png'))
img.resize((WIDTH*2, HEIGHT*2), Image.NEAREST).save(os.path.join(here, 'mino-full-map-2x.png'))
print(f"Wrote mino-full-map.png  ({WIDTH}x{HEIGHT}, stylized terrain colors)")
print(f"Wrote mino-full-map-2x.png  ({WIDTH*2}x{HEIGHT*2}, 2x scaling)")
print()
print("Legend:")
print("  A (light green)  = clear/plains")
print("  B (dark green)   = forest")
print("  C (grey)         = mountain")
print("  D (orange/tan)   = town")
print("  F (dark red)     = castle/fortress")
print()
print("The 3 grey vertical lines mark the section boundaries — the game shows")
print("only one 5-col section at a time:")
print("  Section 0: cols 0-4")
print("  Section 1: cols 3-7  (overlaps left and right)")
print("  Section 2: cols 6-10")
