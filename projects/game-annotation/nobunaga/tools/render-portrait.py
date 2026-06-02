#!/usr/bin/env py -3
"""render-portrait.py — render Nobunaga's Ambition daimyo portraits from ROM.

Two portrait systems (decoded 2026-06-01; see ROADMAP / project_nobunaga_daimyo_portraits):

PRESET (historical/original daimyo) — `anthology` command.
  draw_daimyo_portrait ($E76F) takes this path when the daimyo record's status byte
  (record[+6], SRAM $752F+idx*7+6) == 0. The face is a DEDICATED hand-drawn CHR block:
    * Descriptor table: bank 8 $BBD0, 4 bytes/entry {bank, tile_count, src_ptr_LE},
      indexed by fief_to_mapid(fief). Portrait CHR packed contiguously in banks 7-8.
    * Layout: a PER-PORTRAIT 6x6 (=48x48px) tile-index map at bank 8 $B144 + mapid*36
      (the bytecode at $E7E4 computes fief_to_mapid*36 + $B144 as the blit's map ptr).
      The count tiles upload to CHR $15B0 = PT1 tile 0x5B, so a map cell value v ->
      uploaded tile (v - 0x5B). 0x5B is each portrait's background/border filler tile.
    * Palette: 4 NES indices at $F7CC (bank 15) = 0x3E,0x38,0x28,0x30 (black/cream/gold/
      white), written to BG palette 0.
  Mapid mapping: 50-fief scenario daimyo idx == mapid (identity); 17-fief daimyo idx ->
  province_to_mapid_table ($F70E) [15,9,13,20,21,17,19,23,22,31,26,27,25,30,32,14,24].
  Names: bank 3, 9 bytes/entry — 50-fief @ $97AB, 17-fief @ $B7AB.
  (All five facts validated: portraits render as recognizable faces; the 17- and 50-fief
  Oda both resolve to descriptor[24].)

COMPOSITE (RNG-generated replacement daimyo) — `sheet`/`faces` commands.
  unpack_base5_digits_upload_blocks ($8086, bank 2) reads a per-daimyo packed base-5
  "face code" at SRAM $6EB1[idx], splits it into 4 digits (0-4 = feature variant), and
  uploads each feature's tile block from BANK 8:
       feature  src_base  stride  tiles
       0        $A604     192     12
       1        $A9C4      96      6
       2        $ABA4      96      6
       3        $AD84     192     12

Usage:
  py -3 tools/render-portrait.py anthology [17|50]   # labeled grid of a scenario's daimyo (both if omitted)
  py -3 tools/render-portrait.py sheet   [out.png]   # composite: all features x 5 variants, tile grid
  py -3 tools/render-portrait.py faces   [out.png]   # composite: assemble 4 blocks as variant combos
"""
import sys, glob, os
from PIL import Image, ImageDraw

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

# ======================================================================
# PRESET portraits (historical daimyo) + per-scenario anthology
# ======================================================================

# Standard NES (2C02) master palette — 64 colors, index -> RGB. Only the 4
# portrait indices matter here, but the full table keeps the tool reusable for
# any ROM graphic. (Common FCEUX/Nestopia-style values.)
NES_PALETTE = [
    (124,124,124),(0,0,252),(0,0,188),(68,40,188),(148,0,132),(168,0,32),(168,16,0),(136,20,0),
    (80,48,0),(0,120,0),(0,104,0),(0,88,0),(0,64,88),(0,0,0),(0,0,0),(0,0,0),
    (188,188,188),(0,120,248),(0,88,248),(104,68,252),(216,0,204),(228,0,88),(248,56,0),(228,92,16),
    (172,124,0),(0,184,0),(0,168,0),(0,168,68),(0,136,136),(0,0,0),(0,0,0),(0,0,0),
    (248,248,248),(60,188,252),(104,136,252),(152,120,248),(248,120,248),(248,88,152),(248,120,88),(252,160,68),
    (248,184,0),(184,248,24),(88,216,84),(88,248,152),(0,232,216),(120,120,120),(0,0,0),(0,0,0),
    (252,252,252),(164,228,252),(184,184,248),(216,184,248),(248,184,248),(248,164,192),(240,208,176),(252,224,168),
    (248,216,120),(216,248,120),(152,248,176),(176,248,204),(156,252,240),(248,212,252),(0,0,0),(0,0,0),
]

DESC_TABLE_CPU = 0xBBD0     # bank 8: 4-byte descriptors {bank, count, src_lo, src_hi}
DESC_BANK = 8
MAP_TABLE_CPU = 0xB144     # bank 8: PER-PORTRAIT 6x6 tile-index maps, 36 bytes/mapid
MAP_TABLE_BANK = 8
TILE_BASE = 0x5B           # CHR $15B0 in PT1 == tile 0x5B; map cell v -> uploaded tile v-0x5B
PAL_CPU, PAL_BANK = 0xF7CC, 15   # 4 palette words (low byte = NES index)
GRID = 6                   # 6x6 tiles = 48x48 px

# Names: bank 3, 9 bytes/entry, NUL/space padded.
NAME_BANK = 3
NAME_CPU = {17: 0xB7AB, 50: 0x97AB}
# 17-fief province->mapid (province_to_mapid_table $F70E); 50-fief is identity.
MAPID_17 = [15, 9, 13, 20, 21, 17, 19, 23, 22, 31, 26, 27, 25, 30, 32, 14, 24]


def _portrait_palette():
    """The 4 RGB colors for portraits, from ROM $F7CC (low byte of each word = NES index)."""
    o = prg(PAL_CPU, PAL_BANK)
    idx = [ROM[o + i * 2] for i in range(4)]   # LE words; low byte is the index
    return [NES_PALETTE[i & 0x3F] for i in idx]


def _decode_tile_pal(blob, pal):
    px = []
    for y in range(8):
        p0, p1 = blob[y], blob[y + 8]
        px += [pal[((p0 >> (7 - x)) & 1) | (((p1 >> (7 - x)) & 1) << 1)] for x in range(8)]
    return px


def _descriptor(mapid):
    """(chr_bank, tile_count, chr_file_offset) for a portrait, from bank 8 $BBD0[mapid]."""
    o = prg(DESC_TABLE_CPU, DESC_BANK) + mapid * 4
    b, cnt, lo, hi = ROM[o:o + 4]
    return b, cnt, prg(lo | (hi << 8), b)


def _name(scenario, idx):
    o = prg(NAME_CPU[scenario], NAME_BANK) + idx * 9
    raw = ROM[o:o + 9]
    return "".join(chr(c) for c in raw if 32 <= c < 127).strip() or f"#{idx}"


def render_preset_portrait(mapid, scale=1):
    """Render daimyo portrait for `mapid` as a GRID*8 x GRID*8 px image (NES-exact),
    optionally integer-upscaled (NEAREST, pixel-preserving)."""
    pal = _portrait_palette()
    mt = prg(MAP_TABLE_CPU, MAP_TABLE_BANK) + mapid * (GRID * GRID)
    tile_map = ROM[mt: mt + GRID * GRID]   # this portrait's own 6x6 tile-index map
    _b, cnt, off = _descriptor(mapid)
    im = Image.new("RGB", (GRID * 8, GRID * 8), pal[0])
    for i, v in enumerate(tile_map):
        ti = v - TILE_BASE
        if 0 <= ti < cnt:
            tile = Image.new("RGB", (8, 8))
            tile.putdata(_decode_tile_pal(ROM[off + ti * 16: off + ti * 16 + 16], pal))
            r, c = divmod(i, GRID)
            im.paste(tile, (c * 8, r * 8))
    if scale != 1:
        im = im.resize((GRID * 8 * scale, GRID * 8 * scale), Image.NEAREST)
    return im


def anthology(scenario, out, scale=4, cols=None):
    """Labeled grid of every daimyo's preset portrait for a scenario (17 or 50)."""
    count = scenario
    cols = cols or (6 if scenario == 17 else 10)
    rows = (count + cols - 1) // cols
    pw = GRID * 8 * scale            # portrait pixel size
    lbl_h = 12
    pad, mtop = 6, 26
    cellw, cellh = pw + pad, pw + lbl_h + pad
    W, H = cols * cellw + pad, mtop + rows * cellh + pad
    canvas = Image.new("RGB", (W, H), (24, 24, 32))
    d = ImageDraw.Draw(canvas)
    d.text((pad, 7), f"Nobunaga's Ambition — {scenario}-fief daimyo  ({count} portraits, "
                     f"48x48 native x{scale})", fill=(230, 230, 210))
    for i in range(count):
        mapid = i if scenario == 50 else MAPID_17[i]
        port = render_preset_portrait(mapid, scale)
        r, c = divmod(i, cols)
        x, y = pad + c * cellw, mtop + r * cellh
        canvas.paste(port, (x, y))
        d.text((x + 1, y + pw + 1), _name(scenario, i), fill=(255, 220, 140))
    os.makedirs(os.path.dirname(out) or ".", exist_ok=True)
    canvas.save(out)
    print(f"wrote {out}  ({W}x{H})  — {count} {scenario}-fief daimyo portraits")


# ======================================================================
# COMPOSITE portraits (the "dead daimyo" / generated-replacement logic)
# ======================================================================
# unpack_composite_face_record ($E6B9, the path draw_daimyo_portrait uses) splits the
# base-5 face code into 4 digits and assembles a face from interchangeable parts:
#   digit:  d0=code%5 (head)  d1=(code/5)%5 (eyes)  d2=(code/25)%5 (nose)  d3=code/125 (mouth)
#   CHR (bank 8): per-feature tile block, base + digit*stride, uploaded to a fixed tile base
#   map (bank 9): per-feature 6x6 tile-index slice, base + digit*len -> the 36-byte layout
# (CHR bank 8 / map bank 9 are the upload/sram-wrap BANK ARGs read from the bytecode.)
# (name, chr_base, chr_stride, map_base, tile_base, n_tiles)
COMPOSITE_FEATURES = [
    ("head",  0xA604, 192, 0xAE34, 0x5B, 12),
    ("eyes",  0xA9C4,  96, 0xAE70, 0x67,  6),
    ("nose",  0xABA4,  96, 0xAE8E, 0x6D,  6),
    ("mouth", 0xAD84, 192, 0xAEAC, 0x73, 12),
]
CHR_BANK, MAP_BANK = 8, 9

# Daimyo NAME generator ($DCB2): name = a 2-char syllable from table1 ($F930, capitalized
# first syllables) + a 2-char syllable from table2 ($F95D, lowercase), each rng_mod(11);
# the game re-rolls on a duplicate (strcmp vs the live name table).
NAME_T1_CPU, NAME_T2_CPU, NAME_GEN_BANK = 0xF930, 0xF95D, 15


def _name_syllables():
    t1 = prg(NAME_T1_CPU, NAME_GEN_BANK)
    t2 = prg(NAME_T2_CPU, NAME_GEN_BANK)
    s1 = [ROM[t1 + 2 * i: t1 + 2 * i + 2].decode("latin1") for i in range(11)]
    s2 = [ROM[t2 + 2 * i: t2 + 2 * i + 2].decode("latin1") for i in range(11)]
    return s1, s2


def generate_name(rng, used, s1, s2):
    """Roll a daimyo name the way generate_daimyo_name does — syllable1+syllable2, each
    rng(11) — re-rolling on a duplicate (the game's strcmp dedup)."""
    while True:
        nm = s1[rng.randint(0, 10)] + s2[rng.randint(0, 10)]
        if nm not in used:
            used.add(nm)
            return nm


def render_composite_portrait(digits, scale=1):
    """Render the composite face for base-5 (d0,d1,d2,d3) — exactly the generated-daimyo
    assembly. Returns a GRID*8 x GRID*8 px image (NES-exact)."""
    pal = _portrait_palette()
    # virtual CHR tile index -> source ROM offset (bank 8), per the upload bases
    vtile = {}
    tile_map = bytearray()
    for (name, chr_base, stride, map_base, tbase, n), d in zip(COMPOSITE_FEATURES, digits):
        chr_off = prg(chr_base + d * stride, CHR_BANK)
        for k in range(n):
            vtile[tbase + k] = chr_off + k * 16
        mo = prg(map_base + d * n, MAP_BANK)
        tile_map += ROM[mo: mo + n]          # this feature's tile-index slice
    im = Image.new("RGB", (GRID * 8, GRID * 8), pal[0])
    for i, v in enumerate(tile_map):
        src = vtile.get(v)
        if src is not None:
            tile = Image.new("RGB", (8, 8))
            tile.putdata(_decode_tile_pal(ROM[src: src + 16], pal))
            r, c = divmod(i, GRID)
            im.paste(tile, (c * 8, r * 8))
    if scale != 1:
        im = im.resize((GRID * 8 * scale, GRID * 8 * scale), Image.NEAREST)
    return im


def random_faces(out, n=36, cols=9, seed=1573, scale=3):
    """Roll `n` random daimyo faces the way a succession event does (4 independent rng(5)
    digits = a base-5 face code) and lay them in a grid, labeled with the code."""
    import random
    rng = random.Random(seed)
    s1, s2 = _name_syllables()
    used = set()
    rows = (n + cols - 1) // cols
    pw = GRID * 8 * scale
    lbl_h, pad, mtop = 11, 6, 24
    cellw, cellh = pw + pad, pw + lbl_h + pad
    W, H = cols * cellw + pad, mtop + rows * cellh + pad
    canvas = Image.new("RGB", (W, H), (24, 24, 32))
    d = ImageDraw.Draw(canvas)
    d.text((pad, 7), f"Nobunaga's Ambition — {n} randomly-generated daimyo "
                     f"(base-5 composite face + syllable name generator, the succession "
                     f"'dead-daimyo' roll; seed {seed})", fill=(230, 230, 210))
    for i in range(n):
        digits = [rng.randint(0, 4) for _ in range(4)]   # d0..d3, each rng(5)
        name = generate_name(rng, used, s1, s2)          # the $DCB2 name roll
        port = render_composite_portrait(digits, scale)
        r, c = divmod(i, cols)
        x, y = pad + c * cellw, mtop + r * cellh
        canvas.paste(port, (x, y))
        d.text((x + 1, y + pw + 1), name, fill=(255, 220, 140))
    os.makedirs(os.path.dirname(out) or ".", exist_ok=True)
    canvas.save(out)
    print(f"wrote {out}  ({W}x{H})  — {n} random composite faces (seed {seed})")


if __name__ == "__main__":
    cmd = sys.argv[1] if len(sys.argv) > 1 else "anthology"
    if cmd == "anthology":
        arg = sys.argv[2] if len(sys.argv) > 2 else None
        scenarios = [int(arg)] if arg in ("17", "50") else [17, 50]
        for sc in scenarios:
            anthology(sc, f"atlas/daimyo-anthology-{sc}.png")
    elif cmd == "random":
        seed = int(sys.argv[2]) if len(sys.argv) > 2 else 1573
        random_faces("atlas/daimyo-random-36.png", n=36, cols=9, seed=seed)
    else:
        out = sys.argv[2] if len(sys.argv) > 2 else f"atlas/portrait-{cmd}.png"
        {"sheet": sheet, "faces": faces}[cmd](out)
