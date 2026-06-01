#!/usr/bin/env py -3
"""render-portrait.py — render the daimyo composite-portrait face-part tiles.

Decoded 2026-06-01: unpack_base5_digits_upload_blocks ($8086, bank 2) reads a
per-daimyo packed "face code" word at SRAM $6EB1[idx], splits it into base-5
digits (each 0-4 = one of 5 variants of a facial feature), and uploads each
feature's tile block from BANK 8 to CHR-RAM via ppu_upload_block ($CF7C, bank arg=8):

   feature  src_base  stride(bytes)  tiles  PPU dest
   0        $A604     192 (=$C0)     12     $17F0
   1        $A9C4      96            6      $18B0
   2        $ABA4      96            6      $1910
   3        $AD84     192            12     $1970

Block N for digit d = base + d*stride; 5 variants each. The 4 blocks land
consecutively in CHR pattern table 1, assembled into a ~36-tile (6x6 = 48x48px) face.

This tool extracts those bank-8 regions and renders them as 2bpp tile sheets so the
graphics can be eyeballed / assembled. Source bank + bases are the ground-truth
$8086 operands; verify visually.

Usage:
  py -3 tools/render-portrait.py sheet   [out.png]   # all features x 5 variants, tile grid
  py -3 tools/render-portrait.py faces   [out.png]   # assemble the 4 blocks as composite faces (variant combos)
"""
import sys, glob
from PIL import Image

ROM = open(glob.glob("*.nes")[0] if glob.glob("*.nes") else
           glob.glob("**/*.nes", recursive=True)[0], "rb").read()
if ROM[:4] == b"NES\x1a":
    ROM = ROM[16:]

BANK = 8
def prg(cpu, bank=BANK): return bank * 0x4000 + (cpu & 0x3FFF)

# (name, cpu_base, stride_bytes, tiles_per_block)  — from the $8086 operands
FEATURES = [
    ("f0_A604", 0xA604, 192, 12),
    ("f1_A9C4", 0xA9C4,  96,  6),
    ("f2_ABA4", 0xABA4,  96,  6),
    ("f3_AD84", 0xAD84, 192, 12),
]
VARIANTS = 5
# 2-bit -> greyscale (0 = light bg ... 3 = dark)
PAL = [(248, 248, 248), (168, 168, 168), (96, 96, 96), (0, 0, 0)]

def decode_tile(blob):
    px = []
    for y in range(8):
        p0, p1 = blob[y], blob[y + 8]
        row = [((p0 >> (7 - x)) & 1) | (((p1 >> (7 - x)) & 1) << 1) for x in range(8)]
        px.append(row)
    return px

def tile_img(blob, scale=4):
    px = decode_tile(blob)
    im = Image.new("RGB", (8, 8))
    im.putdata([PAL[px[y][x]] for y in range(8) for x in range(8)])
    return im.resize((8 * scale, 8 * scale), Image.NEAREST)

def sheet(out):
    """Each feature = a band; rows = 5 variants, cols = tiles_per_block."""
    scale, gap = 4, 4
    maxtiles = max(f[3] for f in FEATURES)
    cell = 8 * scale
    band_h = VARIANTS * (cell + 2)
    W = maxtiles * (cell + 2) + 40
    H = len(FEATURES) * (band_h + gap + 14)
    canvas = Image.new("RGB", (W, H), (40, 40, 60))
    y = 0
    for (name, base, stride, ntiles) in FEATURES:
        for v in range(VARIANTS):
            blk = prg(base + v * stride)
            for t in range(ntiles):
                o = blk + t * 16
                canvas.paste(tile_img(ROM[o:o + 16], scale),
                             (40 + t * (cell + 2), y + v * (cell + 2)))
        y += band_h + gap + 14
    canvas.save(out)
    print(f"wrote {out}  ({W}x{H})  — {len(FEATURES)} features x {VARIANTS} variants")

def faces(out):
    """Assemble the 4 blocks in CHR order as one tile run, tiled W wide, for a few variant combos.
    The 4 blocks total 12+6+6+12 = 36 tiles -> try 6 wide x 6 tall."""
    scale, Wt = 6, 6
    combos = [(0,0,0,0),(1,1,1,1),(2,2,2,2),(3,3,3,3),(4,4,4,4),
              (0,1,2,3),(4,3,2,1),(2,0,4,1)]
    cell = 8 * scale
    face_tiles = sum(f[3] for f in FEATURES)  # 36
    Ht = (face_tiles + Wt - 1) // Wt
    fw, fh = Wt * cell, Ht * cell
    canvas = Image.new("RGB", (len(combos) * (fw + 8), fh + 8), (40, 40, 60))
    for ci, combo in enumerate(combos):
        run = []
        for (name, base, stride, ntiles), d in zip(FEATURES, combo):
            blk = prg(base + d * stride)
            for t in range(ntiles):
                run.append(ROM[blk + t * 16:blk + t * 16 + 16])
        for i, blob in enumerate(run):
            r, c = divmod(i, Wt)
            canvas.paste(tile_img(blob, scale), (ci * (fw + 8) + c * cell, r * cell))
    canvas.save(out)
    print(f"wrote {out}  — {len(combos)} composite faces ({Wt}x{Ht} tiles each)")

if __name__ == "__main__":
    cmd = sys.argv[1] if len(sys.argv) > 1 else "sheet"
    out = sys.argv[2] if len(sys.argv) > 2 else f"atlas/portrait-{cmd}.png"
    {"sheet": sheet, "faces": faces}[cmd](out)
