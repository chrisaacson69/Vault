#!/usr/bin/env python3
"""Render a tactical map from an SRAM staging-buffer dump.

The SRAM buffer at $7BFD holds 11 columns × 88 bytes = 968 bytes total.
Even columns: 5 cells × 16B + 8B trailer
Odd columns:  8B header + 5 cells × 16B (isometric stagger)

Each 16-byte cell pattern is identified against the metatile dictionary at
bank-2 $B100. Output is a stylized 11×5 map with the actual structural
content the engine renders.
"""
import os, sys, re
from PIL import Image, ImageDraw, ImageFont

here = os.path.dirname(os.path.abspath(__file__))

# Metatile dictionary at bank-2 $B100, 6 entries of 16 bytes each
METATILE_DICT = {
    'F': bytes([0x63,0x64,0x67,0x68,0x65,0x66,0x69,0x6A,0x6B,0x6C,0x6F,0x70,0x6D,0x6E,0x71,0x72]),
    'B': bytes([0xA2,0xA3,0xA6,0xA7,0xA4,0xA5,0xA8,0xA9,0xAA,0xAB,0xAE,0xAF,0xAC,0xAD,0xB0,0xB1]),
    'D': bytes([0x73,0x74,0x77,0x78,0x75,0x76,0x79,0x7A,0x7B,0x7C,0x7C,0x7F,0x7D,0x7E,0x80,0x81]),
    'C': bytes([0x92,0x93,0x96,0x97,0x94,0x95,0x98,0x99,0x9A,0x9B,0x9E,0x9F,0x9C,0x9D,0xA0,0xA1]),
    'A': bytes([0x82,0x83,0x86,0x87,0x84,0x85,0x88,0x89,0x8A,0x8B,0x8E,0x8F,0x8C,0x8D,0x90,0x91]),
    'E': bytes([0x57,0x58,0x5B,0x5C,0x59,0x5A,0x5D,0x59,0x5E,0x5D,0x59,0x5A,0x5F,0x60,0x61,0x62]),
}
BLANK_PATTERN = bytes([0x01] * 16)
ZERO_PATTERN  = bytes([0x00] * 16)

TERRAIN_COLORS = {
    'A': (180, 220, 130), 'B': (40, 110, 50),  'C': (130, 130, 130),
    'D': (210, 150, 90),  'F': (180, 60, 60),  'E': (90, 140, 200),
    '.': (60, 60, 70),    '?': (200, 0, 200),
}
TERRAIN_DARK = {k: tuple(int(v*0.7) for v in c) for k, c in TERRAIN_COLORS.items()}
LABEL_COLOR  = {
    'A': (60,100,30),  'B': (200,230,180), 'C': (255,255,255),
    'D': (60,30,0),    'F': (255,220,200), 'E': (220,240,255),
    '.': (200,200,200), '?': (255,255,255),
}

def identify(window):
    """Identify a 16-byte metatile pattern → letter."""
    for letter, pat in METATILE_DICT.items():
        if window == pat: return letter
    if window == BLANK_PATTERN: return '.'
    if window == ZERO_PATTERN:  return '.'
    return '?'

def load_dump(path, dump_base=None):
    """Load bytes from either a .dmp/.bin binary file or a hex-text file.

    Returns (bytes_list, dump_base) where dump_base is the CPU address of byte 0.

    For binary .dmp files from Mesen, dump_base must be passed explicitly (binary
    has no metadata about where in memory it came from).
    For hex-text files, dump_base can be inferred from a "$XXXX:$YYYY" header line
    or passed explicitly.
    """
    if path.lower().endswith(('.dmp', '.bin')):
        with open(path, 'rb') as f:
            data = list(f.read())
        return data, dump_base
    # Hex-text — extract all 2-digit hex bytes
    with open(path) as f:
        text = f.read()
    # Try to find a header like "$7B40:$7F4F  XX XX..." or "$7B40 XX XX..."
    if dump_base is None:
        m = re.search(r'\$([0-9A-Fa-f]{4})\s*:', text)
        if m:
            dump_base = int(m.group(1), 16)
    bytes_list = [int(b, 16) for b in re.findall(r'(?<![0-9A-Fa-f])[0-9A-Fa-f]{2}(?![0-9A-Fa-f])', text)]
    # If we found a header, strip the first 2 bytes (they were the header address parsed as hex)
    # Actually no — the regex (?<![0-9A-Fa-f]) prevents matching inside $XXXX, so we're safe.
    return bytes_list, dump_base

def render(sram_path, out_name, label, dump_base=0x7B40):
    bytes_list, base = load_dump(sram_path, dump_base)
    if base is None:
        base = dump_base
    DUMP_BASE = base

    def byte_at(addr):
        idx = addr - DUMP_BASE
        if 0 <= idx < len(bytes_list):
            return bytes_list[idx]
        return 0

    def cell_at(addr):
        return bytes(byte_at(addr + i) for i in range(16))

    # Identify each cell
    grid = [['?' for _ in range(11)] for _ in range(5)]
    BUFFER_BASE = 0x7BFD
    for col in range(11):
        col_base = BUFFER_BASE + col * 88
        stagger  = 8 if (col & 1) else 0
        for row in range(5):
            cell_addr = col_base + stagger + row * 16
            window = cell_at(cell_addr)
            grid[row][col] = identify(window)

    print(f"=== {label} (from SRAM staging buffer) ===")
    for r in range(5):
        print(f"  row {r}: {' '.join(grid[r])}")

    # Render with isometric stagger
    CELL_PX = 32
    WIDTH = 11 * CELL_PX
    HEIGHT = (5 * 4 + 2) * 8

    img = Image.new('RGB', (WIDTH, HEIGHT + 24), (10, 10, 15))
    draw = ImageDraw.Draw(img)
    try:
        font = ImageFont.truetype("arial.ttf", 12)
        font_small = ImageFont.truetype("arial.ttf", 9)
        font_title = ImageFont.truetype("arialbd.ttf", 16)
    except Exception:
        font = font_small = font_title = ImageFont.load_default()

    draw.text((4, 4), label, fill=(255, 255, 255), font=font_title)

    for col in range(11):
        for row in range(5):
            t = grid[row][col]
            stagger_px = 16 if (col % 2 == 1) else 0
            x = col * CELL_PX
            y = row * CELL_PX + stagger_px + 24
            body = TERRAIN_COLORS.get(t, (255, 0, 255))
            inner = TERRAIN_DARK.get(t, (180, 0, 180))
            draw.rectangle([x, y, x+CELL_PX-1, y+CELL_PX-1], fill=body)
            draw.rectangle([x+4, y+4, x+CELL_PX-5, y+CELL_PX-5], outline=inner, width=1)
            draw.text((x + 12, y + 9), t, fill=LABEL_COLOR.get(t, (255,255,255)), font=font)
            draw.text((x + 1, y + 1), f"{col},{row}", fill=LABEL_COLOR.get(t, (255,255,255)), font=font_small)

    for boundary in [5 * CELL_PX, 8 * CELL_PX]:
        draw.line([boundary, 24, boundary, HEIGHT + 24], fill=(80, 80, 100), width=1)

    out_path = os.path.join(here, 'atlas', out_name)
    img.save(out_path)
    img.resize((WIDTH*2, (HEIGHT+24)*2), Image.NEAREST).save(out_path.replace('.png', '-2x.png'))
    print(f"Wrote {out_path}")
    return grid

# Render all captured fiefs
captures = [
    ('atlas/iga-sram.txt',                 'iga-sram-render.png',  'Iga (all clear + castle/town center)',          0x7B40),
    ('traces/mino-save-ram.dmp',           'mino-sram-render.png', 'Mino (mountain spine + forest perimeter)',       0x6000),
    ('traces/kaga-save-ram.dmp',           'kaga-sram-render.png', 'Kaga (water NW + clear + forest SE, NO mountains)', 0x6000),
    ('traces/shinano-save-ram.dmp',        'shinano-sram-render.png', 'Shinano (fief 16)',                              0x6000),
    ('traces/musashi-save-ram.dmp',        'musashi-sram-render.png', 'Musashi (fief 3)',                                0x6000),
    ('traces/iseshima-save-ram.dmp',       'iseshima-sram-render.png', 'Iseshima (fief 13)',                             0x6000),
    ('traces/yamato-save-ram.dmp',         'yamato-sram-render.png',   'Yamato (fief 10) — donut?',                       0x6000),
    ('traces/suruga-save-ram.dmp',         'suruga-sram-render.png',   'Suruga (fief 7) — has void cells',                0x6000),
    ('traces/echigo-save-ram.dmp',         'echigo-sram-render.png',   'Echigo (fief 2) — canonical donut?',              0x6000),
    ('traces/omi-save-ram.dmp',            'omi-sram-render.png',      'Omi (fief 11) — Asakura captured, defensive',     0x6000),
    ('traces/yamashiro-save-ram.dmp',      'yamashiro-sram-render.png','Yamashiro (fief 14) — Kyoto',                     0x6000),
    ('traces/fief5-save-ram.dmp',          'echizen-sram-render.png',  'Echizen (fief 5) — Asakura home (CPU)',           0x6000),
    ('traces/hida-save-ram.dmp',           'hida-sram-render.png',     'Hida (fief 6) — mountainous?',                    0x6000),
    ('traces/mikawa-save-ram.dmp',         'mikawa-sram-render.png',   'Mikawa (fief 8) — Tokugawa home, Oda invading',   0x6000),
    ('traces/owari-save-ram.dmp',          'owari-sram-render.png',    'Owari (fief 17) — Oda home, being invaded',        0x6000),
    ('traces/noto-save-ram.dmp',           'noto-sram-render.png',     'Noto (fief 1) — Hatakeya home, FINAL FIEF',        0x6000),
    ('traces/final-battle-sram.dmp',       'settsu-sram-render.png',   'Settsu (fief 15) — Osaka Bay, FINAL CONQUEST',    0x6000),
]
for path, out, label, base in captures:
    full = os.path.join(here, path) if not os.path.isabs(path) else path
    if os.path.exists(full):
        render(full, out, label, dump_base=base)
        print()
