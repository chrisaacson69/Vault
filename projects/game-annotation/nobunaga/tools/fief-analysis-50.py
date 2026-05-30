#!/usr/bin/env python3
"""fief-analysis-50.py — Per-fief strategic aggregates + neighbor analysis (50-fief).

Aggregates (geometric means):
  Economy = (town * output * dams * loyalty * wealth) ** (1/5)
  Army    = (men * morale * arms) ** (1/3)
  Daimyo  = (health * drive * luck * charisma * iq) ** (1/5)

Neighbor analysis (Econ & Army), using adjacency at bank 4 $8004:
  1. RankDelta   = mean(neighbor rank) - own rank          (rank 1 = strongest)
  2. ValueGap    = own value - mean(neighbor value)        (keeps magnitude)
  3. Threat/Prey : Threat = sum of how much each STRONGER neighbor exceeds you
                   Prey   = sum of how much you exceed each WEAKER neighbor
  4. Ignition    = weighted blend of own power, expansion room (prey),
                   safety (low army threat), defensibility (few fronts)
  5. Backfield   : Reach2 = provinces within 2 hops; NewFronts = avg new
                   borders opened per conquered neighbor (low = clean rollup)

Outputs analysis-50fief.tsv (Excel-ready) + a readable console summary.
"""
import os

here = os.path.dirname(os.path.abspath(__file__))
root = os.path.join(here, '..')
COUNT = 50

# ---- province stats from 50Fief.txt ----
# idx name header gold debt town rice output dams loyalty wealth men morale skill arms
prov = {}
with open(os.path.join(root, '50Fief.txt')) as f:
    next(f)
    for line in f:
        t = line.split()
        if len(t) < 15: continue
        i = int(t[0])
        nm = {12: "Awa(E)", 40: "Awa(S)"}.get(i, t[1])   # disambiguate the two Awa
        prov[i] = dict(name=nm, town=int(t[5]), output=int(t[7]), dams=int(t[8]),
                       loyalty=int(t[9]), wealth=int(t[10]), men=int(t[11]),
                       morale=int(t[12]), arms=int(t[14]))

# ---- daimyo stats from 50Diamyo.txt (shared index) ----
daim = {}
with open(os.path.join(root, '50Diamyo.txt')) as f:
    next(f)
    for line in f:
        t = line.split()
        if len(t) < 9: continue
        i = int(t[0])
        daim[i] = dict(clan=t[1], health=int(t[3]), drive=int(t[4]), luck=int(t[5]),
                       charisma=int(t[6]), iq=int(t[7]))

# ---- adjacency from ROM bank 4 $8004 ----
rom = open(os.path.join(here, "Nobunaga's Ambition (USA).nes"), 'rb').read()[16:]
def prg(cpu, bank): return bank*0x4000 + (cpu & 0x3FFF)
ADJ = []
for i in range(COUNT):
    base = prg(0x8004 + i*8, 4)
    nb = []
    for b in rom[base:base+8]:
        if b == 0xFF or b >= COUNT: break
        nb.append(b)
    ADJ.append(nb)
adjset = [set(a) for a in ADJ]

# ---- aggregates ----
def gmean(v):
    p = 1.0
    for x in v: p *= x
    return p ** (1.0/len(v))
econ = {i: gmean([prov[i]['town'],prov[i]['output'],prov[i]['dams'],prov[i]['loyalty'],prov[i]['wealth']]) for i in range(COUNT)}
army = {i: gmean([prov[i]['men'],prov[i]['morale'],prov[i]['arms']]) for i in range(COUNT)}
dmy  = {i: gmean([daim[i]['health'],daim[i]['drive'],daim[i]['luck'],daim[i]['charisma'],daim[i]['iq']]) for i in range(COUNT)}

def ranks(vals):
    order = sorted(range(COUNT), key=lambda i: -vals[i]); r={}; prev=None; pr=0
    for pos,i in enumerate(order):
        if vals[i]!=prev: pr=pos+1; prev=vals[i]
        r[i]=pr
    return r
er, ar, dr = ranks(econ), ranks(army), ranks(dmy)

# ---- per-fief neighbor metrics ----
def rank_delta(rk,i):
    return (sum(rk[j] for j in ADJ[i])/len(ADJ[i]) - rk[i]) if ADJ[i] else 0.0
def val_gap(val,i):
    return (val[i] - sum(val[j] for j in ADJ[i])/len(ADJ[i])) if ADJ[i] else 0.0
def threat(val,i):
    return sum(max(0.0, val[j]-val[i]) for j in ADJ[i])
def prey(val,i):
    return sum(max(0.0, val[i]-val[j]) for j in ADJ[i])

econ_vgap = {i: val_gap(econ,i) for i in range(COUNT)}
army_vgap = {i: val_gap(army,i) for i in range(COUNT)}
econ_threat = {i: threat(econ,i) for i in range(COUNT)}
econ_prey   = {i: prey(econ,i)   for i in range(COUNT)}
army_threat = {i: threat(army,i) for i in range(COUNT)}
army_prey   = {i: prey(army,i)   for i in range(COUNT)}

# ---- backfield / 2-hop ----
def reach2(i):
    s=set()
    for j in ADJ[i]:
        s.add(j); s.update(ADJ[j])
    s.discard(i)
    return s
def new_fronts(i):
    if not ADJ[i]: return 0.0
    base = adjset[i] | {i}
    return sum(len(adjset[j]-base) for j in ADJ[i])/len(ADJ[i])
reach2_n = {i: len(reach2(i)) for i in range(COUNT)}
newfronts = {i: new_fronts(i) for i in range(COUNT)}

# ---- ignition (normalized weighted blend) ----
def minmax(d):
    lo=min(d.values()); hi=max(d.values()); rng=(hi-lo) or 1.0
    return {k:(v-lo)/rng for k,v in d.items()}
power = {i: gmean([econ[i],army[i]]) for i in range(COUNT)}     # own might
nP, nRoom = minmax(power), minmax(econ_prey)
nSafe = {i: 1-v for i,v in minmax(army_threat).items()}        # less threat = safer
nDef  = {i: 1-v for i,v in minmax({k:float(len(ADJ[k])) for k in range(COUNT)}).items()}
W = dict(power=0.35, room=0.25, safe=0.25, defn=0.15)           # tunable weights
ignition = {i: 100*(W['power']*nP[i]+W['room']*nRoom[i]+W['safe']*nSafe[i]+W['defn']*nDef[i]) for i in range(COUNT)}
ir = ranks(ignition)

# ---- TSV ----
out = os.path.join(root, 'analysis-50fief.tsv')
cols = ["id","name","clan","deg","neighbors",
        "Econ","EconRank","Army","ArmyRank","Daimyo","DaimyoRank",
        "EconRankDelta","ArmyRankDelta","EconValGap","ArmyValGap",
        "ArmyThreat","ArmyPrey","EconThreat","EconPrey",
        "Reach2","NewFronts","Ignition","IgnRank"]
with open(out,'w') as f:
    f.write("\t".join(cols)+"\n")
    for i in range(COUNT):
        row=[i+1,prov[i]['name'],daim[i]['clan'],len(ADJ[i]),
             ";".join(prov[j]['name'] for j in ADJ[i]),
             f"{econ[i]:.2f}",er[i],f"{army[i]:.2f}",ar[i],f"{dmy[i]:.2f}",dr[i],
             f"{rank_delta(er,i):+.2f}",f"{rank_delta(ar,i):+.2f}",
             f"{econ_vgap[i]:+.2f}",f"{army_vgap[i]:+.2f}",
             f"{army_threat[i]:.1f}",f"{army_prey[i]:.1f}",
             f"{econ_threat[i]:.1f}",f"{econ_prey[i]:.1f}",
             reach2_n[i],f"{newfronts[i]:.2f}",f"{ignition[i]:.1f}",ir[i]]
        f.write("\t".join(str(x) for x in row)+"\n")
print(f"Wrote {out}\n")

def top(title, key, n=12, fmt="{:.1f}", rev=True, extra=None):
    print(f"=== {title} ===")
    order=sorted(range(COUNT), key=lambda i:key[i], reverse=rev)[:n]
    for i in order:
        ex = extra(i) if extra else ""
        print(f"  {prov[i]['name']:<10} {daim[i]['clan']:<10} {fmt.format(key[i]):>8}   {ex}")
    print()

# 2 — value gaps
top("ECON value-gap: strongest vs neighborhood (you >> them)", econ_vgap,
    extra=lambda i:f"Econ {econ[i]:.0f} vs nbr {econ[i]-econ_vgap[i]:.0f}")
top("ECON value-gap: weakest vs neighborhood (them >> you)", econ_vgap, rev=False,
    extra=lambda i:f"Econ {econ[i]:.0f} vs nbr {econ[i]-econ_vgap[i]:.0f}")

# 3 — threat / prey
top("ARMY THREAT: most military pressure incoming", army_threat,
    extra=lambda i:f"deg {len(ADJ[i])}, Army {army[i]:.0f}")
top("ECON PREY: most economic expansion room", econ_prey,
    extra=lambda i:f"deg {len(ADJ[i])}, Econ {econ[i]:.0f}")

# 4 — ignition
print("=== IGNITION: best places to start a winning run (0-100) ===")
print(f"  {'fief':<10} {'clan':<10} {'Ign':>5}  {'pow':>4} {'room':>4} {'safe':>4} {'def':>4}")
for i in sorted(range(COUNT), key=lambda i:-ignition[i])[:12]:
    print(f"  {prov[i]['name']:<10} {daim[i]['clan']:<10} {ignition[i]:>5.1f}  "
          f"{nP[i]*100:>4.0f} {nRoom[i]*100:>4.0f} {nSafe[i]*100:>4.0f} {nDef[i]*100:>4.0f}")
print()

# 5 — backfield
top("CLEANEST ROLLUP: fewest new fronts opened per conquest (low=consolidating)",
    newfronts, n=10, fmt="{:.2f}", rev=False,
    extra=lambda i:f"deg {len(ADJ[i])}, reach2 {reach2_n[i]}")
