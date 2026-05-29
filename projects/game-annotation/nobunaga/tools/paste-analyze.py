"""Analyze the user's pasted SRAM region."""
paste = """
00 00 00 23 00 1F 00 1D 00 2B 00 55 00 53 00 54
00 4B 00 3C 00 50 00 88 00 46 00 42 00 39 00 4F
00 4D 00 4B 00 4C 00 80 00 3B 00 2F 00 42 00 4E
00 4A 00 32 00 4E 00 46 00 45 00 88 00 40 00 3D
00 4D 00 10 00 0E 00 4E 00 1A 00 29 00 38 00 3C
00 39 00 3E 00 42 00 46 00 45 00 1A 00 2F 00 34
00 33 00 35 00 51 00 46 00 41 00 42 00 35 00 2B
00 33 00 44 00 44 00 46 00 42 00 33 00 55 00 4F
00 49 00 55 00 55 00 98 00 4D 00 00 00 00 00 00
"""
data = bytes(int(x, 16) for x in paste.split())
print(f"Bytes: {len(data)} (= ${len(data):X})")
BASE = 0x6000

# Current Mikawa stats (gold=2, debt=0, town=66, rice=43, output=136, dams=64, loyalty=78, wealth=94, men=71, morale=75, skill=74, arms=73)
# As 16-bit BE:
target = bytes([
    0x00, 0x02, 0x00, 0x00, 0x00, 0x42, 0x00, 0x2B,
    0x00, 0x88, 0x00, 0x40, 0x00, 0x4E, 0x00, 0x5E,
    0x00, 0x47, 0x00, 0x4B, 0x00, 0x4A, 0x00, 0x49
])
idx = data.find(target)
print(f"Exact Mikawa stats (in displayed order, BE): {'FOUND @ $' + format(BASE+idx, '04X') if idx >= 0 else 'not in this region'}")

# Print 16-bit BE values with annotations for distinctive Mikawa values
mikawa_vals = {
    0x02: "gold=2", 0x42: "town=66", 0x2B: "rice=43", 0x88: "output=136",
    0x40: "dams=64", 0x4E: "loyalty=78", 0x5E: "wealth=94", 0x47: "men=71",
    0x4B: "morale=75", 0x4A: "skill=74", 0x49: "arms=73"
}
print("\nAll 16-bit BE values (with Mikawa-stat annotations):")
for i in range(0, len(data), 2):
    val = (data[i] << 8) | data[i+1]
    cpu = BASE + i
    label = f" <- {mikawa_vals[val]}" if val in mikawa_vals else ""
    print(f"  ${cpu:04X}: ${val:04X} = {val:5d}{label}")
