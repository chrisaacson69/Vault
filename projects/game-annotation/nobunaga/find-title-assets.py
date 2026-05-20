#!/usr/bin/env python3
"""Search the ROM for the NA1 title screen's 4 assets:
  palette, attribute table, nametable, CHR pattern table.
Reports ROM location for each — answers whether the scene is fully
recoverable from ROM alone (vs. needing live PPU dumps).
"""
import os

here = os.path.dirname(os.path.abspath(__file__))
rom_path = os.path.join(here, "Nobunaga's Ambition (USA).nes")
with open(rom_path, 'rb') as f:
    data = f.read()[16:]
PRG = 0x4000

def search(pattern, label):
    print(f"\n=== {label} ({len(pattern)} bytes) ===")
    hits = []
    for i in range(len(data) - len(pattern) + 1):
        if data[i:i+len(pattern)] == pattern:
            bank = i // PRG
            offset = i % PRG
            cpu = 0x8000 + offset if bank < 15 else 0xC000 + offset
            hits.append((i, bank, cpu))
    if not hits:
        print('  NOT FOUND in ROM')
    else:
        for prg_off, bank, cpu in hits[:10]:
            print(f'  PRG ${prg_off:05X}  bank {bank:2d}  CPU ${cpu:04X}')
        if len(hits) > 10:
            print(f'  ... +{len(hits)-10} more matches')
    return hits

# 1. Palette (16 bytes)
palette = bytes([0x3E,0x16,0x27,0x30, 0x3E,0x38,0x30,0x30,
                 0x3E,0x18,0x29,0x30, 0x3E,0x18,0x01,0x30])
search(palette, "Title palette")

# 2. Attribute table (64 bytes)
attr = bytes([0x50,0x50,0x50,0x50,0x10,0x00,0x00,0x00,
              0x55,0x55,0x55,0x55,0x11,0x00,0x00,0x00,
              0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
              0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
              0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
              0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
              0x00,0x00,0x00,0x00,0x00,0x50,0x50,0x10,
              0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00])
search(attr, "Title attribute table")

# 3. Nametable — use a distinctive 32-byte slice from the middle (row 12: $74-$83 map content)
nt_slice = bytes([0x4D,0x4D,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7D,0x7E,0x80,0x81,0x82,0x83,
                  0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x4D,0x8B,0x4D,0x8D,0x8E,0x4D,0x4D,0x4D,0x4D])
search(nt_slice, "Title nametable (32-byte distinctive slice)")

# 4. CHR — use unique tile pattern from the title's distinctive "horse/samurai" art
# Picking a non-zero, non-FF distinctive tile from the dump (the 'small font' E-shaped tile from earlier)
chr_slice = bytes([0xCD,0xCD,0xF9,0xCD,0xCD,0x02,0xFC,0x00, 0xCD,0xCD,0xF9,0xCD,0xCD,0x02,0xFC,0x00])
search(chr_slice, "Title CHR (1 distinctive tile, 16 bytes)")

# Also check: is the title's nametable just before its attribute table?
# (KOEI splash was: $A84A attr → $A88A nametable → $AC4A CHR — all contiguous)
print()
print("=== Searching for title-scene bundling pattern ===")
nt_full_start = bytes([0x01]*16)  # first 16 bytes of NT are all $01
print("(First 16 bytes of title nametable are all $01 — too generic to localize)")
print("Trying a more distinctive nametable prefix (rows 6-7, the all-$4D region):")
distinctive = bytes([0x01]*16 + [0x4D]*16)  # transition from row 5 ($01) to row 6 ($4D)
search(distinctive, "$01-row → $4D-row transition (likely title NT signature)")
