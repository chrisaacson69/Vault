#!/usr/bin/env python3
"""render-strategic-50.py — Geographic node-link render of the 50-fief
adjacency graph (bank 4 $8004) for eyeball verification against the map.

Each province is placed at its approximate real-Japan position; edges are
drawn straight from the ROM adjacency table. A correct table yields short,
local, mostly non-crossing edges (a planar map). Long crossing edges flag
suspect entries.

Usage:  py render-strategic-50.py [rom] [out.png]
"""
import os, sys
from PIL import Image, ImageDraw, ImageFont

here = os.path.dirname(os.path.abspath(__file__))
rom_path = sys.argv[1] if len(sys.argv) > 1 else os.path.join(here, "Nobunaga's Ambition (USA).nes")
out_path = sys.argv[2] if len(sys.argv) > 2 else os.path.join(here, '..', 'atlas', 'strategic-50-adjacency.png')

rom = open(rom_path, 'rb').read()
if rom[:4] == b'NES\x1a':
    rom = rom[16:]

TABLE_BANK, TABLE_CPU, SLOT, COUNT = 4, 0x8004, 8, 50
def prg(cpu, bank): return bank * 0x4000 + (cpu & 0x3FFF)
def neighbours(idx):
    base = prg(TABLE_CPU + idx * SLOT, TABLE_BANK)
    out = []
    for b in rom[base:base + SLOT]:
        if b == 0xFF or b >= COUNT:
            break
        out.append(b)
    return out

# 0-based index order == 50Fief.txt == in-ROM name table.
NAMES = [
    "Ezo","Mutsu","Morioka","Iwasaki","Ugo","Rikuzen","Uzen","Iwaki","Iwashiro",
    "Echigo","Hitachi","Shimotsu","Awa(E)","Musashi","Shinano","Noto","Ecchu",
    "Hida","Kiso","Suruga","Kaga","Echizen","Mino","Mikawa","Owari","Iseshima",
    "Omi","Iga","Tango","Tanba","Yamashir","Yamato","Settsu","Kii","Inaba",
    "Harima","Izumo","Sanbi","Aki","Sanuki","Awa(S)","Iyo","Tosa","Nakamura",
    "Buzen","Chikuhi","Bungo","Higo","Hiyuga","Satuma",
]

# Approximate real-Japan map positions (x = east, y = north->south).
# Japan tilts NE, so Tohoku sits at high x / low y, Kyushu at low x / high y.
POS = {
    0:(12.0,0.0),  1:(12.0,2.0),  2:(12.0,3.2), 3:(11.2,3.8), 4:(10.5,3.0),
    5:(12.2,4.4),  6:(10.6,4.2),  7:(12.2,5.4), 8:(11.1,5.4),
    9:(10.0,5.2), 10:(12.2,6.4), 11:(11.1,6.2), 12:(12.4,7.8), 13:(11.4,7.2),
    14:(10.1,6.7), 15:(8.5,5.0), 16:(8.9,5.7), 17:(9.1,6.5), 18:(9.6,7.3),
    19:(10.6,8.1), 20:(8.2,6.1), 21:(7.7,6.7), 22:(8.9,7.3), 23:(9.7,8.1),
    24:(8.8,8.0), 25:(8.4,8.7), 26:(7.8,7.4), 27:(7.9,8.2), 28:(6.7,7.0),
    29:(6.6,7.7), 30:(7.2,7.9), 31:(7.4,8.7), 32:(6.5,8.3), 33:(7.4,9.5),
    34:(5.4,7.2), 35:(6.0,8.3), 36:(3.9,7.4), 37:(4.8,8.2), 38:(3.1,8.2),
    39:(5.4,9.5), 40:(6.2,9.7), 41:(3.7,9.9), 42:(4.8,10.5), 43:(3.6,10.7),
    44:(2.2,8.8), 45:(0.9,9.1), 46:(2.0,9.9), 47:(1.1,10.3), 48:(2.2,10.9),
    49:(1.1,11.5),
}

# Region colors for quick visual grouping
REGION = {
    'tohoku':(range(0,9),(120,90,150)),
    'kanto':([10,11,12,13],(70,110,160)),
    'chubu':([9,14,15,16,17,18,19,20,21,22,23,24],(70,150,120)),
    'kinki':([25,26,27,28,29,30,31,32,33],(180,140,60)),
    'chugoku':([34,35,36,37,38],(170,90,90)),
    'shikoku':([39,40,41,42,43],(150,110,160)),
    'kyushu':([44,45,46,47,48,49],(160,70,70)),
}
node_color = {}
for _, (idxs, col) in REGION.items():
    for i in idxs:
        node_color[i] = col

SCALE_X, SCALE_Y, MARGIN = 150, 110, 90
xs = [p[0] for p in POS.values()]; ys = [p[1] for p in POS.values()]
W = int((max(xs)-min(xs))*SCALE_X + 2*MARGIN)
H = int((max(ys)-min(ys))*SCALE_Y + 2*MARGIN)
def px(i):
    x,y = POS[i]
    return (int((x-min(xs))*SCALE_X+MARGIN), int((y-min(ys))*SCALE_Y+MARGIN))

img = Image.new('RGB',(W,H),(16,22,38))
d = ImageDraw.Draw(img)
def fnt(sz):
    try: return ImageFont.truetype('arialbd.ttf', sz)
    except Exception: return ImageFont.load_default()
f_lab, f_title = fnt(15), fnt(34)

# Edges first. Flag long ones (possible errors) in red.
adj = [neighbours(i) for i in range(COUNT)]
import math
LONG = 3.2  # graph-units; sea crossings are ~2, land borders <1.5
edges = set()
flagged = []
for i in range(COUNT):
    for j in adj[i]:
        e = tuple(sorted((i,j)))
        if e in edges: continue
        edges.add(e)
        x1,y1 = px(i); x2,y2 = px(j)
        dist = math.hypot(POS[i][0]-POS[j][0], POS[i][1]-POS[j][1])
        if dist > LONG:
            d.line([(x1,y1),(x2,y2)], fill=(230,70,70), width=4)
            flagged.append((i,j,dist))
        else:
            d.line([(x1,y1),(x2,y2)], fill=(235,205,90), width=3)

# Nodes
R = 22
for i in range(COUNT):
    cx,cy = px(i)
    col = node_color.get(i,(120,120,120))
    d.ellipse([cx-R,cy-R,cx+R,cy+R], fill=col, outline=(240,240,240), width=2)
    num = str(i+1)
    bb = d.textbbox((0,0),num,font=f_lab)
    d.text((cx-(bb[2]-bb[0])/2, cy-(bb[3]-bb[1])/2-1), num, fill=(255,255,255), font=f_lab)
    name = NAMES[i]
    nb = d.textbbox((0,0),name,font=f_lab)
    d.text((cx-(nb[2]-nb[0])/2, cy+R+2), name, fill=(210,215,225), font=f_lab)

d.text((MARGIN, 20), "Nobunaga's Ambition — 50-fief adjacency (bank 4 $8004) over geographic layout",
       fill=(235,235,235), font=f_title)
deg = [len(a) for a in adj]
d.text((MARGIN, 60), f"{sum(deg)//2} edges   avg degree {sum(deg)/len(deg):.2f}   "
       f"red = long edge (>{LONG}u, check)   numbers are 1-based province IDs",
       fill=(180,185,195), font=f_lab)

img.save(out_path)
half = img.resize((W//2,H//2), Image.LANCZOS); half.save(out_path.replace('.png','-half.png'))
print(f'Wrote {out_path}  ({W}x{H})')
print(f'edges={len(edges)}  flagged long edges={len(flagged)}')
for i,j,dt in sorted(flagged,key=lambda t:-t[2]):
    print(f'  LONG  {i+1:>2} {NAMES[i]:<10} -- {j+1:>2} {NAMES[j]:<10}  dist={dt:.2f}')
