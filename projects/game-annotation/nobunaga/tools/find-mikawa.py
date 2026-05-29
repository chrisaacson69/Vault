"""Find Mikawa's province record by searching for the stat signature."""
import sys

data = open(sys.argv[1], "rb").read()

# User's turn-2+ stats (gold, debt, town, rice, output, dams, loyalty, wealth, men, morale, skill, arms)
# = 0, 0, 66, 75, 136, 64, 61, 77, 71, 75, 74, 73
target = bytes([
    0x00, 0x00, 0x00, 0x00, 0x00, 0x42, 0x00, 0x4B,
    0x00, 0x88, 0x00, 0x40, 0x00, 0x3D, 0x00, 0x4D,
    0x00, 0x47, 0x00, 0x4B, 0x00, 0x4A, 0x00, 0x49
])
idx = data.find(target)
print(f"Exact 24-byte sequence: {'FOUND at $' + format(0x6000+idx, '04X') if idx >= 0 else 'not found'}")

for label, order in [
    ("orig (g,d,t,r,o,da,l,w,m,mo,sk,a)", [0,0,66,75,136,64,61,77,71,75,74,73]),
    ("rice-first (r,o,da,t,g,d,w,l,m,mo,sk,a)", [75,136,64,66,0,0,77,61,71,75,74,73]),
    ("econ-mil (t,r,o,da,w,l,g,d,m,mo,sk,a)", [66,75,136,64,77,61,0,0,71,75,74,73]),
    ("w,t,r,o,da,l,g,d,m,mo,sk,a", [77,66,75,136,64,61,0,0,71,75,74,73]),
    ("t,r,o,da,w,l,m,mo,sk,a,g,d", [66,75,136,64,77,61,71,75,74,73,0,0]),
    ("t,r,o,da,m,mo,sk,a,w,l,g,d", [66,75,136,64,71,75,74,73,77,61,0,0]),
]:
    pat = b''.join(bytes([0, v]) for v in order)
    pos = data.find(pat)
    if pos >= 0:
        print(f"  {label}: @ $" + format(0x6000+pos, '04X'))

print("\nByte detail $70B0-$70DF:")
for row_start in range(0x70B0, 0x70E0, 16):
    offset = row_start - 0x6000
    row = data[offset:offset+16]
    print(f"  ${row_start:04X}: " + ' '.join(f'{b:02X}' for b in row))

print("\n16-bit BE fields from $70AC to $70DB:")
for i in range(16):
    offset = (0x70AC - 0x6000) + i*2
    val = (data[offset] << 8) | data[offset+1]
    label = ""
    user_stats = {
        0: "gold/debt", 66: "town", 75: "rice/morale", 136: "output",
        64: "dams", 61: "loyalty", 77: "wealth", 71: "men", 74: "skill", 73: "arms"
    }
    if val in user_stats:
        label = f"  &lt;- {user_stats[val]}?"
    print(f"  ${0x70AC + i*2:04X} = ${val:04X} = {val:5d}{label}")
