#!/usr/bin/env python3
"""Reconstruct the title screen by combining the nametable (tile indices) with
the CHR-RAM tile graphics (from ROM bank 0 $AC4A). Outputs grayscale PPM.

Pipeline:
  1. Read 4 KB of CHR data from ROM bank-0 $AC4A
  2. Decode each tile from NES 2bpp format → 8×8 grid of values 0-3
  3. Read the previously-extracted nametable (32×30 tile indices)
  4. Composite into a 256×240 pixel grayscale PPM
"""
import os

here = os.path.dirname(os.path.abspath(__file__))
rom_path = os.path.join(here, "Nobunaga's Ambition (USA).nes")
with open(rom_path, 'rb') as f:
    data = f.read()[16:]

PRG_BANK = 0x4000

# All four title-scene ROM pointers (bank 0)
TITLE_ATTR_CPU = 0xA84A  #  64 bytes → PPU $23C0
TITLE_NT_CPU   = 0xA88A  # 960 bytes → PPU $2000
TITLE_CHR_CPU  = 0xAC4A  # 4 KB     → PPU $1000
TITLE_PAL_CPU  = 0xB862  #  16 bytes → PPU $3F00 (via $0700 shadow)

def prg(cpu_addr, bank=0):
    return bank * PRG_BANK + (cpu_addr - 0x8000)

SRC_PRG = prg(TITLE_CHR_CPU)

# ---- Step 1: decode 256 tiles from CHR data ----
def decode_tile(blob):
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

tiles = []
for i in range(256):
    offset = SRC_PRG + i * 16
    blob = data[offset:offset + 16]
    if len(blob) < 16: break
    tiles.append(decode_tile(blob))

# ---- Step 2: read the nametable we extracted earlier ----
nt_path = os.path.join(here, 'nametable_bytes.txt')
with open(nt_path) as f:
    nt_bytes = [int(b.strip(), 16) for b in f if b.strip()]

if len(nt_bytes) != 960:
    print(f"Warning: nametable has {len(nt_bytes)} bytes, expected 960")

# ---- Step 3: composite into 256×240 pixel image ----
WIDTH = 32 * 8   # 256
HEIGHT = 30 * 8  # 240

# ---- NES master palette ----
# 64 RGB triples from the canonical 2C02 PPU (NESdev wiki reference)
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

# ---- The 4 BG sub-palettes (16 NES indices = 4 sub-palettes × 4 colors each) ----
# These are the bytes from PPU $3F00-$3F0F.
# Placeholder values until the user dumps actual PPU memory.
# Color 0 of every sub-palette is the universal background (PPU mirrors $3F00).
# Load the 16-byte palette directly from ROM (bank-0 $B862)
PALETTES_16 = list(data[prg(TITLE_PAL_CPU) : prg(TITLE_PAL_CPU) + 16])

# Load the 64-byte attribute table directly from ROM (bank-0 $A84A)
ATTR_TABLE = list(data[prg(TITLE_ATTR_CPU) : prg(TITLE_ATTR_CPU) + 64])

def attr_palette_index(tile_col, tile_row):
    """Return which sub-palette (0-3) governs the tile at (tile_col, tile_row)."""
    # Attribute table is 8x8, each byte covers 4-tile × 4-tile area
    attr_row = tile_row // 4
    attr_col = tile_col // 4
    if attr_row >= 8: attr_row = 7  # bottom 2 tile rows reuse the last attr row
    attr_byte = ATTR_TABLE[attr_row * 8 + attr_col]
    # Which quadrant within the 4x4 area?  Each quadrant = 2x2 tiles
    quadrant_x = (tile_col % 4) // 2   # 0 = left, 1 = right
    quadrant_y = (tile_row % 4) // 2   # 0 = top,  1 = bottom
    # Pack quadrant into shift amount: TL=0, TR=2, BL=4, BR=6
    shift = quadrant_y * 4 + quadrant_x * 2
    return (attr_byte >> shift) & 0x03

# (PALETTE_GRAY/SUB_PALETTE no longer used — palette is per-region via attribute table)

# Build the pixel grid — store NES master-palette indices directly (after applying
# attribute table) so each pixel knows its final color
pixels = [[0] * WIDTH for _ in range(HEIGHT)]
for row in range(30):
    for col in range(32):
        tile_idx = nt_bytes[row * 32 + col]
        if tile_idx >= len(tiles):
            continue
        tile_pixels = tiles[tile_idx]
        sub_palette_id = attr_palette_index(col, row)
        # The 4 NES indices for this sub-palette
        sub = PALETTES_16[sub_palette_id * 4 : sub_palette_id * 4 + 4]
        for py in range(8):
            for px in range(8):
                v = tile_pixels[py][px]
                # NES quirk: color index 0 is always the universal background
                # (PPU mirrors $3F00, $3F04, $3F08, $3F0C to the same value)
                nes_idx = PALETTES_16[0] if v == 0 else sub[v]
                pixels[row * 8 + py][col * 8 + px] = nes_idx

# ---- Step 4: write PNG (preferred) and ASCII version ----
png_path = os.path.join(here, 'title-screen.png')
png_2x_path = os.path.join(here, 'title-screen-2x.png')

try:
    from PIL import Image
    img = Image.new('RGB', (WIDTH, HEIGHT))
    for y in range(HEIGHT):
        for x in range(WIDTH):
            nes_idx = pixels[y][x]
            img.putpixel((x, y), NES_MASTER[nes_idx & 0x3F])
    img.save(png_path)
    # Also write 2x scaled (nearest-neighbor) for easier viewing
    img.resize((WIDTH * 2, HEIGHT * 2), Image.NEAREST).save(png_2x_path)
    print(f"Wrote {png_path}  ({WIDTH}x{HEIGHT} RGB PNG)")
    print(f"Wrote {png_2x_path}  ({WIDTH*2}x{HEIGHT*2} 2x nearest-neighbor)")
except ImportError:
    # Pillow not available — fall back to PPM
    ppm_path = os.path.join(here, 'title-screen.ppm')
    with open(ppm_path, 'w') as f:
        f.write('P3\n')
        f.write(f'{WIDTH} {HEIGHT}\n')
        f.write('255\n')
        for row in pixels:
            line_parts = []
            for nes_idx in row:
                r, g, b = NES_MASTER[nes_idx & 0x3F]
                line_parts.append(f'{r} {g} {b}')
            f.write(' '.join(line_parts) + '\n')
    print(f"Wrote {ppm_path}  ({WIDTH}x{HEIGHT} grayscale PPM — install pillow for PNG)")

# Also write ASCII-art version — group NES indices by brightness for the 4-char palette
ascii_path = os.path.join(here, 'title-screen-ascii.txt')
CHARS = [' ', '.', '+', '#']
def brightness(nes_idx):
    r,g,b = NES_MASTER[nes_idx & 0x3F]
    return (r + g + b) // 3
with open(ascii_path, 'w') as f:
    for ny in range(HEIGHT):
        row_chars = ''
        for nx in range(WIDTH):
            b = brightness(pixels[ny][nx])
            bucket = 0 if b < 64 else 1 if b < 128 else 2 if b < 192 else 3
            row_chars += CHARS[bucket]
        if row_chars.strip():
            f.write(row_chars + '\n')
        else:
            f.write('\n')
print(f"Wrote {ascii_path}  (ASCII art version)")
print()
print(f"Decoded {len(tiles)} tiles from ROM ${SRC_PRG:05X}")
print(f"Nametable: {len(nt_bytes)} bytes ({len(nt_bytes)//32}x32 grid)")
