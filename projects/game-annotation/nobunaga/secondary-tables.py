"""Dump the 33-record table at $B1D6 (between 17-fief province + daimyo defaults)."""
rom = open("Nobunaga's Ambition (USA).nes", "rb").read()[16:]
def c2p(cpu): return (cpu - 0x8000) + 3 * 0x4000
def rd16le(cpu):
    o = c2p(cpu)
    return rom[o] | (rom[o+1] << 8)
def read_name(cpu, slot):
    o = c2p(cpu); raw = rom[o:o+slot]
    e = raw.find(0)
    return raw[:e if e >= 0 else slot].decode("ascii", "replace")

PROV_NAMES = 0xB992
prov_names = [read_name(PROV_NAMES + i*10, 10) for i in range(17)]
DAIMYO_NAMES = 0xB7B4
daimyo_names = [read_name(DAIMYO_NAMES + i*9, 9) for i in range(16)]

# The table runs $B1D6 .. $B52F (the 0F 27 daimyo marker is at $B530).
# 33 records x 26 bytes. Field 0 is a tier marker (3000/7000/4500/2500).
BASE = 0xB1D6
N = 33

print(f"33-record table @ ${BASE:04X}-${BASE+N*26-1:04X}  (26 bytes/record, 13x 16-bit LE)")
print()
# Guess: records 0-16 are per-province, records 17-32 per-daimyo (17+16=33).
labels = [f"prov:{prov_names[i]}" if i < 17 else f"daimyo:{daimyo_names[i-17]}"
          for i in range(N)]
print(f"{'rec':>3} {'guess-label':<18} {'mark':>5} | " + " ".join(f"f{j:<2}" for j in range(1, 13)))
print("-" * 90)
for i in range(N):
    rec = [rd16le(BASE + i*26 + j*2) for j in range(13)]
    print(f"{i:>3} {labels[i]:<18} {rec[0]:>5} | " + " ".join(f"{v:>3}" for v in rec[1:]))

# Marker distribution
from collections import Counter
markers = Counter(rd16le(BASE + i*26) for i in range(N))
print()
print("Marker (field 0) distribution:", dict(markers))
