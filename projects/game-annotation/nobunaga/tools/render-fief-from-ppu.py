#!/usr/bin/env python3
"""Render a fief's current visible screen from its PPU memory dump.

Replaces the 16 near-identical render-<fief>-from-ppu.py scripts (which differed
only in the hardcoded input/output paths). Consolidated 2026-05-29.

Usage:
    python render-fief-from-ppu.py <fief>            # e.g. echigo, mino, mikawa
    python render-fief-from-ppu.py <fief> --no-analysis
    python render-fief-from-ppu.py --list            # list available PPU dumps

Input : traces/<fief>-ppu-memory.dmp   (16 KB PPU memory dump from Mesen)
Output: atlas/<fief>-ppu-render.png  +  atlas/<fief>-ppu-render-2x.png

PPU memory layout (16 KB = 4x $1000):
  $0000-$0FFF : pattern table 0 (BG, unused in NA1 combat)
  $1000-$1FFF : pattern table 1 (active CHR for the current scene)
  $2000-$23BF : nametable 0 (32x30 tile indices)
  $23C0-$23FF : attribute table 0
  $3F00-$3F1F : palettes
"""
import os
import sys
import glob
from collections import Counter
from PIL import Image

HERE = os.path.dirname(os.path.abspath(__file__))
PROJ = os.path.dirname(HERE)
TRACES = os.path.join(PROJ, 'traces')
ATLAS = os.path.join(PROJ, 'atlas')

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

CHR_BASE = 0x1000   # BG pattern table base for combat (chapter 16)
NT_BASE  = 0x2000
ATTR_BASE = 0x23C0
PAL_BASE = 0x3F00


def list_dumps():
    dumps = sorted(glob.glob(os.path.join(TRACES, '*-ppu-memory.dmp')))
    print("Available PPU dumps:")
    for d in dumps:
        name = os.path.basename(d).replace('-ppu-memory.dmp', '')
        print(f"  {name}")


def decode_tile(ppu, idx):
    offset = CHR_BASE + idx * 16
    pixels = []
    for row in range(8):
        p0 = ppu[offset + row]
        p1 = ppu[offset + row + 8]
        pixels.append([((p0 >> bit) & 1) | (((p1 >> bit) & 1) << 1) for bit in range(7, -1, -1)])
    return pixels


def attr_palette_index(attr_table, tile_col, tile_row):
    attr_row = min(tile_row // 4, 7)
    attr_col = tile_col // 4
    attr_byte = attr_table[attr_row * 8 + attr_col]
    shift = ((tile_row % 4) // 2) * 4 + ((tile_col % 4) // 2) * 2
    return (attr_byte >> shift) & 0x03


def render(fief, analysis=True):
    ppu_path = os.path.join(TRACES, f'{fief}-ppu-memory.dmp')
    if not os.path.exists(ppu_path):
        print(f"ERROR: no PPU dump for '{fief}' at {ppu_path}\n")
        list_dumps()
        sys.exit(1)

    with open(ppu_path, 'rb') as f:
        ppu = f.read()

    tiles = [decode_tile(ppu, i) for i in range(256)]
    palette_16 = list(ppu[PAL_BASE:PAL_BASE + 16])
    attr_table = list(ppu[ATTR_BASE:ATTR_BASE + 64])
    print(f"[{fief}] palette: {' '.join(f'{b:02X}' for b in palette_16)}")

    WIDTH, HEIGHT = 32 * 8, 30 * 8
    img = Image.new('RGB', (WIDTH, HEIGHT))
    for row in range(30):
        for col in range(32):
            nt_idx = ppu[NT_BASE + row * 32 + col]
            sub_id = attr_palette_index(attr_table, col, row)
            sub = palette_16[sub_id * 4:sub_id * 4 + 4]
            tile_pixels = tiles[nt_idx]
            for py in range(8):
                for px in range(8):
                    v = tile_pixels[py][px]
                    nes_idx = palette_16[0] if v == 0 else sub[v]
                    img.putpixel((col * 8 + px, row * 8 + py), NES_MASTER[nes_idx & 0x3F])

    os.makedirs(ATLAS, exist_ok=True)
    out_path = os.path.join(ATLAS, f'{fief}-ppu-render.png')
    img.save(out_path)
    img.resize((WIDTH * 2, HEIGHT * 2), Image.NEAREST).save(out_path.replace('.png', '-2x.png'))
    print(f"[{fief}] wrote {out_path} (+ -2x)")

    if analysis:
        nt_bytes = list(ppu[NT_BASE:NT_BASE + 960])
        print(f"[{fief}] top tile indices: " +
              ', '.join(f'${i:02X}x{c}' for i, c in Counter(nt_bytes).most_common(15)))


def main():
    args = [a for a in sys.argv[1:]]
    if not args or args[0] in ('-h', '--help'):
        print(__doc__)
        return
    if args[0] == '--list':
        list_dumps()
        return
    fief = args[0]
    analysis = '--no-analysis' not in args
    render(fief, analysis=analysis)


if __name__ == '__main__':
    main()
