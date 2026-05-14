"""Score and tier the 17-fief starting positions from ROM defaults."""
rom = open("Nobunaga's Ambition (USA).nes", "rb").read()[16:]
def c2p(cpu): return (cpu - 0x8000) + 3 * 0x4000
def rd16le(cpu):
    o = c2p(cpu)
    return rom[o] | (rom[o+1] << 8)
def read_name(cpu, slot):
    o = c2p(cpu); raw = rom[o:o+slot]
    e = raw.find(0)
    return raw[:e if e >= 0 else slot].decode("ascii", "replace")

# 17-fief anchors — dense tables, index 0 = Hatakeyama/Noto
PROV_BASE, PROV_NAMES = 0xB002, 0xB988
DAIMYO_BASE, DAIMYO_NAMES = 0xB532, 0xB7AB

# Province fields: header,gold,debt,town,rice,output,dams,loyalty,wealth,men,morale,skill,arms
PF = ["header","gold","debt","town","rice","output","dams","loyalty","wealth","men","morale","skill","arms"]
# Daimyo fields: age,health,drive,luck,charisma,iq,status
DF = ["age","health","drive","luck","charisma","iq","status"]

positions = []
for i in range(17):  # 17 clans, dense (idx 0 = Hatakeyama, idx 16 = Oda)
    prov = {PF[j]: rd16le(PROV_BASE + i*26 + j*2) for j in range(13)}
    o = c2p(DAIMYO_BASE + i*7)
    dai = {DF[j]: rom[o+j] for j in range(7)}
    name = read_name(DAIMYO_NAMES + i*9, 9)
    pname = read_name(PROV_NAMES + i*10, 10)

    army = prov["men"] + prov["morale"] + prov["skill"] + prov["arms"]
    econ = prov["town"] + prov["rice"] + prov["output"] + prov["dams"] + prov["wealth"] + prov["gold"]
    leader = dai["health"] + dai["drive"] + dai["luck"] + dai["charisma"] + dai["iq"]
    total = army + econ + leader
    positions.append({
        "idx": i, "clan": name, "prov": pname,
        "army": army, "econ": econ, "leader": leader, "total": total,
        "age": dai["age"], "loyalty": prov["loyalty"], "header": prov["header"],
    })

# Rank
print(f"{'rank':>4} {'clan':<10} {'province':<10} {'army':>5} {'econ':>5} {'leader':>6} {'total':>6} {'age':>4}")
print("-" * 62)
for rank, p in enumerate(sorted(positions, key=lambda x: -x["total"]), 1):
    print(f"{rank:>4} {p['clan']:<10} {p['prov']:<10} {p['army']:>5} {p['econ']:>5} "
          f"{p['leader']:>6} {p['total']:>6} {p['age']:>4}")

print()
# Per-axis leaders
for axis in ("army", "econ", "leader"):
    ranked = sorted(positions, key=lambda x: -x[axis])
    print(f"Best {axis:>6}: " + ", ".join(f"{p['clan']}({p[axis]})" for p in ranked[:5]))
print()

# Province idx 17 is past the end of the 17-fief table (next scenario's data).
prov17 = {PF[j]: rd16le(PROV_BASE + 17*26 + j*2) for j in range(13)}
print("Province idx 17 (past end of 17-fief table) ROM bytes:")
for k, v in prov17.items():
    print(f"  {k:>8}: {v}")
