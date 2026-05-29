"""Check whether 50-fief province NAME table and STATS table are index-aligned,
and whether the daimyo->province link is shared-index."""
rom = open("Nobunaga's Ambition (USA).nes", "rb").read()[16:]
def c2p(cpu): return (cpu - 0x8000) + 3 * 0x4000
def rd16le(cpu):
    o = c2p(cpu); return rom[o] | (rom[o+1] << 8)
def read_name(cpu, slot):
    o = c2p(cpu); raw = rom[o:o+slot]
    e = raw.find(0)
    return raw[:e if e >= 0 else slot].decode("ascii", "replace")

# Anchors — all tables are dense from index 0 (no "special" record).
# 50-fief
P_STATS, P_NAMES = 0x9002, 0x9988
D_STATS, D_NAMES = 0x9532, 0x97AB
# 17-fief
P17_STATS, P17_NAMES = 0xB002, 0xB988

# Province stats signature = the 12 stat fields (skip header)
def prov_stats(base, i):
    return tuple(rd16le(base + i*26 + j*2) for j in range(1, 13))

# Build 17-fief name->stats map for reference
print("=== 17-fief reference: name[i] vs its stats ===")
ref17 = {}
for i in range(17):
    nm = read_name(P17_NAMES + i*10, 10)
    st = prov_stats(P17_STATS, i)
    if nm.strip():
        ref17[st] = nm
        if nm in ("Owari", "Mikawa", "Mino"):
            print(f"  17-fief idx {i:>2}: {nm:<10} stats={st}")

print()
print("=== 50-fief: does name[i] match stats[i]? ===")
print(f"{'idx':>3} {'name[i]':<12} {'stats match 17-fief?':<22}")
mismatches = 0
for i in range(50):
    nm = read_name(P_NAMES + i*10, 10)
    st = prov_stats(P_STATS, i)
    ref = ref17.get(st, "")
    flag = ""
    if nm.strip() and ref and nm != ref:
        flag = f"  <-- name says '{nm}' but stats are 17-fief's '{ref}'"
        mismatches += 1
    elif nm.strip() and ref == nm:
        flag = "  (consistent)"
    if flag:
        print(f"{i:>3} {nm:<12} {ref:<12}{flag}")
print(f"\n  {mismatches} name/stats mismatches found")

print()
print("=== Where is Owari in 50-fief? ===")
# Find "Owari" in the name table
for i in range(50):
    if read_name(P_NAMES + i*10, 10) == "Owari":
        print(f"  'Owari' NAME at index {i}")
# Find Owari's stats (the 17-fief Owari stat tuple) in the 50-fief stats table
owari_stats = None
for st, nm in ref17.items():
    if nm == "Owari":
        owari_stats = st
for i in range(50):
    if prov_stats(P_STATS, i) == owari_stats:
        print(f"  Owari STATS at index {i}")

print()
print("=== Where is Oda in 50-fief, and what province index would shared-index give? ===")
for i in range(50):
    if read_name(D_NAMES + i*9, 9) == "Oda":
        print(f"  'Oda' daimyo NAME at index {i}")
        pn = read_name(P_NAMES + i*10, 10)
        ps = prov_stats(P_STATS, i)
        psref = ref17.get(ps, "?")
        print(f"  -> province name[{i}] = '{pn}', province stats[{i}] = 17-fief's '{psref}'")
