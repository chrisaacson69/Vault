#!/usr/bin/env python3
"""Render all 17 fief tactical maps from bank-4 cell-index data.

Output: atlas/fief-NN-name.png (1x) + atlas/fief-NN-name-2x.png (zoomed)
        atlas/atlas-overview.png (all 17 in one grid)
        atlas/atlas-summary.txt (text summary of each fief)
"""
import os
from PIL import Image, ImageDraw, ImageFont

here = os.path.dirname(os.path.abspath(__file__))
atlas_dir = os.path.join(here, 'atlas')
os.makedirs(atlas_dir, exist_ok=True)

rom_path = os.path.join(here, "Nobunaga's Ambition (USA).nes")
with open(rom_path, 'rb') as f:
    data = f.read()[16:]

PRG_BANK = 0x4000
CELL_TABLE_BASE = 0xA57E
BANK = 4

# Fief names (0-indexed); from chapter 7 finding + SRAM dump confirmation
FIEF_NAMES = [
    "Noto",      # 0
    "Echigo",    # 1
    "Musashi",   # 2
    "Kaga",      # 3
    "Echizen",   # 4
    "Hida",      # 5
    "Suruga",    # 6
    "Mikawa",    # 7
    "Mino",      # 8
    "Yamato",    # 9
    "Omi",       # 10
    "Iga",       # 11
    "Iseshima",  # 12
    "Yamashir",  # 13
    "Settsu",    # 14
    "Shinano",   # 15
    "Owari",     # 16
]

# Terrain encoding (decoded 2026-05-21)
BYTE_TO_TERRAIN = {
    0x04: 'A',  0x10: 'B',  0x40: 'C',
    0x80: 'D',  0x20: 'F',  0x02: 'E',  0x08: 'G',
}
TERRAIN_NAMES = {
    'A': 'clear', 'B': 'forest', 'C': 'mountain',
    'D': 'town',  'F': 'castle', 'E': 'sea',  'G': 'bridge',
}
TERRAIN_COLORS = {
    'A': (180, 220, 130),
    'B': (40, 110, 50),
    'C': (130, 130, 130),
    'D': (210, 150, 90),
    'F': (180, 60, 60),
    'E': (90, 140, 200),
    'G': (160, 120, 200),
}
TERRAIN_DARK = {k: tuple(int(v*0.7) for v in c) for k, c in TERRAIN_COLORS.items()}
LABEL_COLOR = {
    'A': (60, 100, 30),  'B': (200, 230, 180), 'C': (255, 255, 255),
    'D': (60, 30, 0),    'F': (255, 220, 200), 'E': (220, 240, 255),
    'G': (255, 230, 255),
}

CELL_PX = 32
WIDTH = 11 * CELL_PX
HEIGHT = (5 * 4 + 2) * 8

try:
    font = ImageFont.truetype("arial.ttf", 12)
    font_small = ImageFont.truetype("arial.ttf", 9)
    font_title = ImageFont.truetype("arialbd.ttf", 16)
except Exception:
    font = ImageFont.load_default()
    font_small = font
    font_title = font

def render_fief(fief_idx, name):
    """Render one fief's tactical map and return (image, grid, byte_counts)."""
    prg = BANK * PRG_BANK + (CELL_TABLE_BASE + fief_idx * 55 - 0x8000)
    cells = data[prg : prg + 55]

    grid = [[BYTE_TO_TERRAIN.get(cells[r*11 + c], '?') for c in range(11)]
            for r in range(5)]

    img = Image.new('RGB', (WIDTH, HEIGHT), (20, 20, 30))
    draw = ImageDraw.Draw(img)
    for col in range(11):
        for row in range(5):
            terrain = grid[row][col]
            if terrain == '?': continue
            stagger = 16 if (col % 2 == 1) else 0
            x = col * CELL_PX
            y = row * CELL_PX + stagger
            body = TERRAIN_COLORS[terrain]
            inner = TERRAIN_DARK[terrain]
            draw.rectangle([x, y, x+CELL_PX-1, y+CELL_PX-1], fill=body)
            draw.rectangle([x+4, y+4, x+CELL_PX-5, y+CELL_PX-5], outline=inner, width=1)
            draw.text((x + 12, y + 9), terrain, fill=LABEL_COLOR[terrain], font=font)
            draw.text((x + 1, y + 1), f"{col},{row}", fill=LABEL_COLOR[terrain], font=font_small)
    # Section dividers
    for boundary in [5 * CELL_PX, 8 * CELL_PX]:
        draw.line([boundary, 0, boundary, HEIGHT], fill=(80, 80, 100), width=1)

    # Byte counts
    from collections import Counter
    counts = Counter(cells)
    return img, grid, counts

# Render all 17
print("Rendering 17 fief tactical maps...")
all_imgs = []
summary_lines = ["Nobunaga's Ambition — Tactical Map Atlas",
                 "Generated 2026-05-21 from bank-4 $A57E cell-index table",
                 "=" * 70, ""]

for i, name in enumerate(FIEF_NAMES):
    img, grid, counts = render_fief(i, name)
    # Add title to a wrapped version
    titled = Image.new('RGB', (WIDTH, HEIGHT + 24), (10, 10, 15))
    titled.paste(img, (0, 24))
    titled_draw = ImageDraw.Draw(titled)
    titled_draw.text((4, 4), f"Fief {i:02d}: {name}", fill=(255, 255, 255), font=font_title)
    titled.save(os.path.join(atlas_dir, f"fief-{i:02d}-{name.lower()}.png"))
    titled.resize((WIDTH*2, (HEIGHT+24)*2), Image.NEAREST).save(
        os.path.join(atlas_dir, f"fief-{i:02d}-{name.lower()}-2x.png"))
    all_imgs.append((titled, name, i))

    # Summary line
    count_str = ' '.join(f"{TERRAIN_NAMES.get(BYTE_TO_TERRAIN.get(b, '?'), 'unk')}:{c}"
                        for b, c in sorted(counts.items()))
    grid_str = '\n'.join('    ' + ' '.join(grid[r]) for r in range(5))
    summary_lines.append(f"Fief {i:02d} {name}:")
    summary_lines.append(f"  bytes:  " + count_str)
    summary_lines.append(grid_str)
    summary_lines.append("")
    print(f"  fief {i:02d} {name}: {dict(counts)}")

# Atlas overview — 4 cols x 5 rows grid
COLS, ROWS = 4, 5  # holds 20 cells, 17 used + 3 blank
cell_w = WIDTH
cell_h = HEIGHT + 24
overview = Image.new('RGB', (cell_w * COLS, cell_h * ROWS), (5, 5, 10))
for idx, (img, name, i) in enumerate(all_imgs):
    r = idx // COLS
    c = idx % COLS
    overview.paste(img, (c * cell_w, r * cell_h))
overview.save(os.path.join(atlas_dir, "atlas-overview.png"))
# Half-scale overview for easier viewing
overview.resize((cell_w * COLS // 2, cell_h * ROWS // 2), Image.LANCZOS).save(
    os.path.join(atlas_dir, "atlas-overview-half.png"))

# Write summary
with open(os.path.join(atlas_dir, "atlas-summary.txt"), 'w') as f:
    f.write('\n'.join(summary_lines))

print()
print(f"All 17 fiefs rendered to {atlas_dir}/")
print(f"Plus atlas-overview.png (large grid) and atlas-overview-half.png")
print(f"Plus atlas-summary.txt (per-fief grid + byte counts)")
