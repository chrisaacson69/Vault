#!/usr/bin/env python3
"""Render the illustrated NES STRATEGIC MAP (the Map command's pannable overview)
straight from ROM bytes — no PPU/emulation needed.

This is the *art* map (terrain tiles drawn by the cartridge), NOT the schematic
adjacency graphs that render-strategic-atlas.py / render-strategic-50.py draw,
and NOT the tactical battle grid that render-rom-to-map.py builds.

How it works (decoded 2026-06-02, see ROADMAP "PULL THE REAL STRATEGIC MAP"):
  - The Map command (driver_map $AF38) calls ui_helper_cd20 to set palette + upload
    the map CHR, then map_helper_e5f2(section) blits one 28x16 tilemap SECTION to
    the nametable. There are 9 sections (a pannable map); arrows switch sections.
  - Tilemap : bank 4 $8D5C, 0x1C0 (=448=28x16) bytes/section x 9 sections.
  - Attrs   : bank 4 $9D1C, 0x20 (=32) bytes/section (BG sub-palette per 16x16 quad).
  - CHR     : bank 4, the map tileset uploaded to PT1 $15B0 (= tile $5B = 91), so a
              tilemap cell value V indexes CHR-RAM[$1000 + V*16], and the uploaded
              block starts at bank4 $845C for tile 91 -> CHR addr = $845C + (V-91)*16.
  - Palette : bank 15 $F67A (4 colors/sub-palette, stored as words w/ 0 high byte).
              Map BG palette 0 ~ [$3E,$12,$29,$30] = backdrop / sea / land / coast.

Tiles 8-17 are the game font's digits (0-9) overlaid as fief-number labels — drawn
on a different CHR region; here they render from the same contiguous block (close
enough for the terrain read) unless --font is added later.

Usage:
  py render-strategic-map.py                 # contact sheet of all 9 sections (3x3)
  py render-strategic-map.py --section N      # one section, big
  py render-strategic-map.py --scale 3 --out atlas/strategic-map.png
"""
import sys, importlib.util
from pathlib import Path
HERE = Path(__file__).parent
sys.path.insert(0, str(HERE))
from nobunaga_vm import NobunagaVM
from PIL import Image, ImageDraw

# render-text.py (hyphenated) holds the game-font glyph decoder. Font tiles 0..80
# live in PT1 alongside the map terrain (tiles 91..234), so a tilemap cell value
# <= 80 is a FONT glyph (fief-number digits, region labels) and >= 81 is terrain.
_spec = importlib.util.spec_from_file_location("render_text", HERE / "render-text.py")
_rt = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(_rt)
FONT_MAX_TILE = 80

# Full NES master palette (same table as run-animation.py).
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

BANK_MAP = 4
TILEMAP = 0x8D5C       # 0x1C0 bytes/section
ATTR    = 0x9D1C       # 0x20 bytes/section
CHR_BASE = 0x845C      # bank4 byte addr that uploads to PT1 tile 91 ($15B0)
CHR_TILE0 = 91         # tile index that CHR_BASE corresponds to
SEC_W, SEC_H = 28, 16  # tiles
N_SEC = 9
PAL_TABLE = 0xF67A     # bank 15 (fixed)


def load_palettes(vm):
    """4 BG sub-palettes. We know sub-palette 0 & 1 from $F67A; fill the rest by
    repeating so attribute bytes that select pal 2/3 still draw something sane."""
    raw = [vm.read_banked(15, PAL_TABLE + i) for i in range(16)]
    # stored as words (color, 0x00); colors at even offsets
    cols = [raw[i * 2] & 0x3F for i in range(8)]
    sub = [cols[0:4], cols[4:8]]
    sub.append(cols[0:4])
    sub.append(cols[4:8])
    return [[NES_PALETTE[c] for c in s] for s in sub]


def decode_tile(vm, tile_idx, rom):
    """Return 8x8 list of palette-index (0-3) for a tilemap cell value.
    Cells <= 80 are game-font glyphs (PT1 tiles uploaded from bank0 $B2BA);
    cells >= 81 are map terrain (bank4 block, tile 91 -> $845C)."""
    if tile_idx <= FONT_MAX_TILE:
        # font glyph: 1bpp ink mask -> draw ink as palette color 3, else color 0
        bmp = _rt._tile_bitmap(rom, tile_idx)
        return [[3 if bmp[y][x] else 0 for x in range(8)] for y in range(8)]
    addr = CHR_BASE + (tile_idx - CHR_TILE0) * 16
    rows = []
    for y in range(8):
        p0 = vm.read_banked(BANK_MAP, addr + y)
        p1 = vm.read_banked(BANK_MAP, addr + y + 8)
        row = [((p0 >> (7 - x)) & 1) | (((p1 >> (7 - x)) & 1) << 1) for x in range(8)]
        rows.append(row)
    return rows


def attr_palette(attr_bytes, tx, ty):
    """Which BG sub-palette (0-3) applies at tile (tx,ty). NES attribute layout:
    1 byte per 32x32px (4x4 tile) area; 2 bits per 16x16 (2x2 tile) quadrant."""
    # attribute table is 8 bytes/row of 4x4-tile cells; section is 28 wide -> 7 cells
    cell_x, cell_y = tx // 4, ty // 4
    idx = cell_y * 8 + cell_x
    if idx >= len(attr_bytes):
        return 0
    b = attr_bytes[idx]
    quad = ((ty % 4) // 2) * 2 + ((tx % 4) // 2)  # 0 TL,1 TR,2 BL,3 BR
    return (b >> (quad * 2)) & 3


def render_section(vm, sec, pals, scale=2, rom=None):
    rom = rom if rom is not None else _rt._rom()
    tm = [vm.read_banked(BANK_MAP, TILEMAP + sec * 0x1C0 + i) for i in range(0x1C0)]
    at = [vm.read_banked(BANK_MAP, ATTR + sec * 0x20 + i) for i in range(0x20)]
    img = Image.new("RGB", (SEC_W * 8, SEC_H * 8), (0, 0, 0))
    px = img.load()
    for ty in range(SEC_H):
        for tx in range(SEC_W):
            v = tm[ty * SEC_W + tx]
            pal = pals[attr_palette(at, tx, ty)]
            tile = decode_tile(vm, v, rom)
            for yy in range(8):
                for xx in range(8):
                    px[tx * 8 + xx, ty * 8 + yy] = pal[tile[yy][xx]]
    if scale != 1:
        img = img.resize((img.width * scale, img.height * scale), Image.NEAREST)
    return img


def _tilemap(vm, sec):
    return [vm.read_banked(BANK_MAP, TILEMAP + sec * 0x1C0 + i) for i in range(0x1C0)]


def best_offset(A, B):
    """Best (dx, dy, score): placing section B at (dx,dy) relative to A, matching
    on terrain tiles (>=81) only (labels/sea move/repeat and add noise)."""
    def cell(S, x, y): return S[y * SEC_W + x]
    best = (0.0, 0, 0, 0)
    for dy in range(-12, 13):
        for dx in range(-(SEC_W - 1), SEC_W):
            n = t = 0
            for y in range(SEC_H):
                for x in range(SEC_W):
                    x1, y1 = x - dx, y - dy
                    if 0 <= x1 < SEC_W and 0 <= y1 < SEC_H:
                        a, b = cell(A, x, y), cell(B, x1, y1)
                        if a >= 81 and b >= 81:
                            t += 1
                            n += (a == b)
            if t >= 60 and n / t > best[0]:
                best = (n / t, t, dx, dy)
    return best


def auto_layout(vm, sections, seed=0, thresh=0.5):
    """Greedy spanning tree: place `seed` at (0,0), attach each remaining section at
    the absolute offset that best aligns it to an already-placed section. Returns
    {section: (ax, ay)} in tile coords (may be negative; caller normalizes)."""
    maps = {s: _tilemap(vm, s) for s in sections}
    placed = {seed: (0, 0)}
    remaining = [s for s in sections if s != seed]
    while remaining:
        best = None  # (score, sec, ax, ay)
        for s in remaining:
            for p, (px_, py_) in placed.items():
                sc, t, dx, dy = best_offset(maps[p], maps[s])
                if sc >= thresh and (best is None or sc > best[0]):
                    best = (sc, s, px_ + dx, py_ + dy)
        if best is None:
            print(f"  (no section aligns above {thresh}; leaving {remaining} unplaced)")
            break
        sc, s, ax, ay = best
        placed[s] = (ax, ay)
        remaining.remove(s)
        print(f"  placed sec {s} at ({ax},{ay})  score={sc:.2f}")
    return placed


def render_stitch(vm, pals, sections, scale=2, seed=0):
    rom = _rt._rom()
    placed = auto_layout(vm, sections, seed=seed)
    minx = min(x for x, y in placed.values())
    miny = min(y for x, y in placed.values())
    maxx = max(x + SEC_W for x, y in placed.values())
    maxy = max(y + SEC_H for x, y in placed.values())
    W = (maxx - minx) * 8
    H = (maxy - miny) * 8
    canvas = Image.new("RGB", (W, H), (0, 0, 0))
    # paste sections; later (higher section #) on top so labels stay legible
    for s in sorted(placed, reverse=True):
        ax, ay = placed[s]
        img = render_section(vm, s, pals, 1, rom)
        canvas.paste(img, ((ax - minx) * 8, (ay - miny) * 8))
    if scale != 1:
        canvas = canvas.resize((canvas.width * scale, canvas.height * scale), Image.NEAREST)
    return canvas


def contact_sheet(vm, pals, sections, cols, scale=2):
    rom = _rt._rom()
    cells = [render_section(vm, s, pals, scale, rom) for s in sections]
    cw, ch = cells[0].size
    pad = 8
    rows = (len(cells) + cols - 1) // cols
    sheet = Image.new("RGB", (cols * cw + (cols + 1) * pad, rows * ch + (rows + 1) * pad), (40, 40, 40))
    d = ImageDraw.Draw(sheet)
    for i, c in enumerate(cells):
        r, col = divmod(i, cols)
        x, y = pad + col * (cw + pad), pad + r * (ch + pad)
        sheet.paste(c, (x, y))
        d.text((x + 2, y + 2), f"sec {sections[i]}", fill=(255, 255, 0))
    return sheet


def main():
    args = sys.argv[1:]
    scale = int(args[args.index("--scale") + 1]) if "--scale" in args else 2
    out = args[args.index("--out") + 1] if "--out" in args else None
    vm = NobunagaVM()
    pals = load_palettes(vm)
    print("BG sub-palettes (NES idx):",
          [[hex(vm.read_banked(15, PAL_TABLE + i * 2) & 0x3F) for i in range(j*4, j*4+4)] for j in range(2)])
    # 17-fief scenario shows sections 0-1 (verified: $FED8 province->section is all
    # 0/1, and the daimyo-select cycle wraps at 4 -> sections {0,1}); 50-fief uses
    # all 9 (cycle wraps at 9). The Map command flips between these as discrete
    # pages (map_helper_af10 prints "Arrows: other sections / A: menu") -- they are
    # NOT a single scrolling map (edge-match + scroll-overlap both ~0.1).
    scenario = int(args[args.index("--scenario") + 1]) if "--scenario" in args else 50
    sections = [0, 1] if scenario == 17 else list(range(N_SEC))
    if "--section" in args:
        sec = int(args[args.index("--section") + 1])
        img = render_section(vm, sec, pals, scale)
        out = out or f"atlas/strategic-section-{sec}.png"
    elif "--stitch" in args:
        print(f"Auto-stitching scenario-{scenario} sections {sections}...")
        img = render_stitch(vm, pals, sections, scale=scale)
        out = out or f"atlas/strategic-map-{scenario}-stitched.png"
    else:
        img = contact_sheet(vm, pals, sections, cols=(2 if scenario == 17 else 3), scale=scale)
        out = out or f"atlas/strategic-map-{scenario}.png"
    Path(out).parent.mkdir(parents=True, exist_ok=True)
    img.save(out)
    print(f"wrote {out}  ({img.width}x{img.height})")


if __name__ == "__main__":
    main()
