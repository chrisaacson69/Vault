#!/usr/bin/env python3
"""Composite atlas showing all 17 tactical maps positioned geographically
with adjacency lines drawn between connected fiefs.

Adjacency from bank-4 $8300 in the ROM.
"""
import os
from PIL import Image, ImageDraw, ImageFont

here = os.path.dirname(os.path.abspath(__file__))
saves_dir = os.path.join(here, 'atlas', 'Saves')
out_path = os.path.join(here, 'atlas', 'strategic-atlas-with-adjacencies.png')

FIEFS = ['Noto','Echigo','Musashi','Kaga','Echizen','Hida','Suruga','Mikawa',
         'Mino','Yamato','Omi','Iga','Iseshima','Yamashir','Settsu','Shinano','Owari']

# Adjacency matrix decoded from bank-4 $8300
ADJ = [
    [3],                      # 0 Noto
    [2, 3, 15],               # 1 Echigo
    [1, 6, 15],               # 2 Musashi
    [0, 1, 4, 5, 15],         # 3 Kaga
    [3, 5, 8, 10],            # 4 Echizen
    [3, 4, 8, 15],            # 5 Hida
    [2, 7, 15],               # 6 Suruga
    [6, 8, 15, 16],           # 7 Mikawa
    [4, 5, 7, 10, 12, 15, 16],# 8 Mino
    [11, 12, 13, 14],         # 9 Yamato
    [4, 8, 11, 12, 13],       # 10 Omi
    [9, 10, 12, 13],          # 11 Iga
    [8, 9, 10, 11, 16],       # 12 Iseshima
    [9, 10, 11, 14],          # 13 Yamashir
    [9, 13],                  # 14 Settsu
    [1, 2, 3, 5, 6, 7, 8],    # 15 Shinano
    [7, 8, 12],               # 16 Owari
]

# File names (mapping 0-indexed to user's file convention)
FILES = {
    0:  'fief-00-noto-sram-render.png',
    1:  'fief-01-echigo-sram-render.png',
    2:  'fief-02-musashi-sram-render.png',
    3:  'fief-03-kaga-sram-render.png',
    4:  'fief-04-echizen-sram-render.png',
    5:  'fief-05-hida-sram-render.png',
    6:  'fief-06-suruga-sram-render.png',
    7:  'fief-07-mikawa-sram-render.png',
    8:  'fief-08-mino-sram-render.png',
    9:  'fief-09-yamato-sram-render.png',
    10: 'fief-10-omi-sram-render.png',
    11: 'fief-11-iga-sram-render.png',
    12: 'fief-12-iseshima-sram-render.png',
    13: 'fief-13-yamashiro-sram-render.png',
    14: 'fief-14-settsu.png',
    15: 'fief-15-shinano-sram-render.png',
    16: 'fief-16-owari-sram-render.png',
}

# Positions from user's NA17Fief.txt — game's in-map layout
# Format: fief_idx_0based: (col, row)
POSITIONS = {
    0:  (3, 0),  # Noto
    3:  (3, 1),  # Kaga
    1:  (5, 1),  # Echigo
    4:  (2, 2),  # Echizen
    5:  (3, 2),  # Hida
    13: (1, 3),  # Yamashir
    15: (4, 3),  # Shinano
    14: (0, 4),  # Settsu
    8:  (3, 4),  # Mino
    2:  (5, 4),  # Musashi
    10: (2, 5),  # Omi
    16: (3, 5),  # Owari
    11: (1, 6),  # Iga
    6:  (4, 6),  # Suruga
    9:  (0, 7),  # Yamato
    12: (2, 7),  # Iseshima
    7:  (3, 7),  # Mikawa
}

# Load all images and find the typical map size
imgs = {}
for idx, fname in FILES.items():
    path = os.path.join(saves_dir, fname)
    if os.path.exists(path):
        imgs[idx] = Image.open(path)
    else:
        print(f'WARNING: missing {fname}')

# Scale each map to a reasonable size for the composite
MAP_W = 280
MAP_H = 160
scaled = {}
for idx, img in imgs.items():
    scaled[idx] = img.resize((MAP_W, MAP_H), Image.LANCZOS)

# Compute canvas dimensions
CELL_W = 360  # spacing between fief columns
CELL_H = 220  # spacing between fief rows
MARGIN = 60

max_col = max(p[0] for p in POSITIONS.values())
max_row = max(p[1] for p in POSITIONS.values())
canvas_w = int((max_col + 1) * CELL_W + 2 * MARGIN)
canvas_h = int((max_row + 1) * CELL_H + 2 * MARGIN)

canvas = Image.new('RGB', (canvas_w, canvas_h), (15, 20, 35))
draw = ImageDraw.Draw(canvas)

# Compute pixel position for each fief center
def fief_center(idx):
    col, row = POSITIONS[idx]
    cx = MARGIN + col * CELL_W + MAP_W // 2
    cy = MARGIN + row * CELL_H + MAP_H // 2
    return cx, cy

# Draw adjacency lines FIRST (under the maps)
edges_drawn = set()
for idx in range(17):
    for n in ADJ[idx]:
        edge = tuple(sorted((idx, n)))
        if edge in edges_drawn: continue
        edges_drawn.add(edge)
        x1, y1 = fief_center(idx)
        x2, y2 = fief_center(n)
        # Yellow line with slight glow
        draw.line([(x1, y1), (x2, y2)], fill=(255, 220, 80), width=3)

# Now paste each map (no extra labels — the source images have titles)
try:
    font = ImageFont.truetype("arialbd.ttf", 20)
except Exception:
    font = ImageFont.load_default()

for idx in range(17):
    if idx not in scaled: continue
    col, row = POSITIONS[idx]
    x = int(MARGIN + col * CELL_W)
    y = int(MARGIN + row * CELL_H)
    # Dark border background
    draw.rectangle([x - 4, y - 4, x + MAP_W + 4, y + MAP_H + 4], fill=(60, 80, 110))
    canvas.paste(scaled[idx], (x, y))

# Title
try:
    font_title = ImageFont.truetype("arialbd.ttf", 40)
except Exception:
    font_title = font_id
draw.text((MARGIN, 8), "Nobunaga's Ambition — Strategic Atlas (17 fiefs + adjacency)",
          fill=(220, 220, 220), font=font_title)

# Save
canvas.save(out_path)
print(f'Wrote {out_path}')
print(f'Canvas size: {canvas_w} × {canvas_h}')

# Also save a half-scale version for easier viewing
canvas.resize((canvas_w // 2, canvas_h // 2), Image.LANCZOS).save(
    out_path.replace('.png', '-half.png'))
print(f'Also wrote half-scale version')
