"""Analyze the user's full SRAM paste."""
paste = """
00 35 00 00 00 1E 00 35 00 23 00 1F 00 22 00 30
00 35 00 27 00 6C 00 38 00 08 07 4F 00 00 00 35
00 5D 00 55 00 53 00 55 00 4C 00 4F 00 62 00 D6
00 4C 00 B8 06 3D 00 00 00 94 00 52 00 49 00 50
00 8E 00 4B 00 3D 00 A1 00 BF 00 47 00 68 06 71
00 00 00 2C 00 B4 00 42 00 39 00 59 00 57 00 71
00 83 00 3F 00 43 00 68 06 4F 00 00 00 80 00 58
00 5C 00 4C 00 80 00 3B 00 2C 00 83 00 3F 00 43
00 CC 06 3B 00 00 00 2E 00 4F 00 2F 00 43 00 60
00 5C 00 3B 00 56 00 44 00 38 00 CC 06 4E 00 00
00 4D 00 65 00 40 00 4E 00 46 00 45 00 4E 00 4C
00 4D 00 47 00 94 07 02 00 00 00 42 00 2B 00 88
00 40 00 4E 00 5E 00 47 00 4B 00 4A 00 49 00 F4
06 3B 00 00 00 20 00 25 00 22 00 0E 00 4E 00 1A
00 3B 00 6B 00 F1 01 45 00 08 07 76 00 00 00 2D
00 78 00 2E 00 38 00 49 00 46 00 60 00 B1 00 53
00 57 00 B8 06 3F 00 00 00 3A 00 55 00 3E 00 43
00 46 00 45 00 3F 00 5A 00 2D 01 44 00 F4 06 3E
00 00 00 52 00 41 00 1A 00 2F 00 37 00 36 00 3E
00 53 00 29 01 4F 00 A4 06 2D 00 00 00 38 00 8D
00 35 00 51 00 46 00 41 00 2D 00 B1 00 53 00 57
00 A8 07 39 00 00 00 5E 00 41 00 42 00 35 00 3E
00 45 00 39 00 3A 00 AF 00 36 00 80 07 4A 00 00
00 49 00 5D 00 44 00 44 00 5E 00 5A 00 4A 00 5B
00 64 01 40 00 A4 06 67 00 00 00 53 00 6E 00 33
00 55 00 78 00 71 00 67 00 A4 00 49 00 48 00 44
07 3D 00 00 00 8A 00 53 00 60 00 55 00 A3 00 59
00 3D 00 AA 00 B1 00 56 00 90 06 0F 00 00 00 19
00 08 00 2A 00 0C 00 14 00 1E 00 0A 00 1E 00 05
00 0A 00 B8 0B 23 00 00 00 1E 00 05 00 2D 00 0F
00 1E 00 28 00 08 00 1E 00 0A 00 0F 00 B8 0B 1E
00 00 00 23 00 1E 00 41 00 11 00 1E 00 28 00 0A
00 23 00 05 00 0F 00 B8 0B 05 00 00 00 1E 00 08
00 28 00 0F 00 19 00 23 00 08 00 1E 00 0A 00 0A
00 B8 0B 14 00 00 00 14 00 14 00 3C 00 0A 00 28
00 2D 00 14 00 23 00 14 00 0F 00 B8 0B 09 00 00
00 14 00 19 00 46 00 0A 00 23 00 1E 00 0A 00 14
00 0F 00 0A 00 B8 0B 08 00 00 00 1E 00 0A 00 30
00 0F 00 1E 00 19 00 08 00 19 00 0F 00 0A 00 B8
0B 0F 00 00 00 23 00 0A 00 2D 00 11 00 1E 00 14
00 0A 00 1E 00 0A 00 0A 00 B8 0B 1A 00 00 00 19
00 0F 00 32 00 0C 00 19 00 23 00 0F 00 1E 00 14
00 0A 00 58 1B 0A 00 00 00 23 00 0A 00 2A 00 11
00 1E 00 19 00 0A 00 1E 00 0F 00 0A 00 58 1B 07
"""
# Just first ~700 bytes to find Mikawa's record clearly
data = bytes(int(x, 16) for x in paste.split())
BASE = 0x6000

# Mikawa stats: gold=2, debt=0, town=66, rice=43, output=136, dams=64, loyalty=78, wealth=94, men=71, morale=75, skill=74, arms=73
# As 16-bit BE byte sequence:
mikawa_full = bytes([
    0x00, 0x02, 0x00, 0x00, 0x00, 0x42, 0x00, 0x2B,
    0x00, 0x88, 0x00, 0x40, 0x00, 0x4E, 0x00, 0x5E,
    0x00, 0x47, 0x00, 0x4B, 0x00, 0x4A, 0x00, 0x49
])
# Without gold (skip first 2 bytes):
mikawa_no_gold = mikawa_full[2:]
# Without debt:
mikawa_no_debt = mikawa_full[:2] + mikawa_full[4:]
# 11-stat sequence starting at debt:
eleven_stats = mikawa_full[2:]  # debt onwards

idx = data.find(mikawa_full)
print(f"Full Mikawa (12 stats incl gold=2): {'FOUND @ $' + format(BASE+idx, '04X') if idx >= 0 else 'not found'}")
idx = data.find(eleven_stats)
print(f"Mikawa minus gold (11 stats from debt=0): {'FOUND @ $' + format(BASE+idx, '04X') if idx >= 0 else 'not found'}")

# Confirmed: $60B8 looks right based on visual inspection. Show that region.
print("\nRegion $60AC-$60D3 (potential Mikawa record + neighbors):")
for i in range(0xAC, 0xD4, 2):
    if i < len(data):
        val = (data[i] << 8) | data[i+1]
        print(f"  ${BASE+i:04X}: ${val:04X} = {val:5d}")

# Search for repeating headers — values that follow distinctive `$XX YY 03/06/07` patterns
print("\n'Big values' that look like base koku headers (16-bit > 256):")
for i in range(0, len(data) - 1, 2):
    val = (data[i] << 8) | data[i+1]
    if val >= 256 and val <= 4000:
        print(f"  ${BASE+i:04X}: ${val:04X} = {val}")
