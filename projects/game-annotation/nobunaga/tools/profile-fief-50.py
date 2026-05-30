#!/usr/bin/env python3
"""profile-fief-50.py - Full strategic play-profile for one or more fiefs (50-fief).

Pulls own stats + aggregates + ranks, then every neighbor's strength and the
per-neighbor threat/prey gap, the forced/best expansion target, and backfield
reach. Usage:  py profile-fief-50.py Ezo "Awa(E)" Noto ...
"""
import os, sys

here = os.path.dirname(os.path.abspath(__file__)); root = os.path.join(here, '..'); COUNT = 50

prov = {}
with open(os.path.join(root, '50Fief.txt')) as f:
    next(f)
    for line in f:
        t = line.split()
        if len(t) < 15: continue
        i = int(t[0]); nm = {12:"Awa(E)",40:"Awa(S)"}.get(i, t[1])
        prov[i] = dict(name=nm, town=int(t[5]), rice=int(t[6]), output=int(t[7]), dams=int(t[8]),
                       loyalty=int(t[9]), wealth=int(t[10]), men=int(t[11]), morale=int(t[12]),
                       skill=int(t[13]), arms=int(t[14]))
daim = {}
with open(os.path.join(root, '50Diamyo.txt')) as f:
    next(f)
    for line in f:
        t = line.split()
        if len(t) < 9: continue
        i = int(t[0])
        daim[i] = dict(clan=t[1], age=int(t[2]), health=int(t[3]), drive=int(t[4]),
                       luck=int(t[5]), charisma=int(t[6]), iq=int(t[7]))

rom = open(os.path.join(here, "Nobunaga's Ambition (USA).nes"), 'rb').read()[16:]
def prg(c,b): return b*0x4000+(c&0x3FFF)
ADJ=[]
for i in range(COUNT):
    base=prg(0x8004+i*8,4); nb=[]
    for x in rom[base:base+8]:
        if x==0xFF or x>=COUNT: break
        nb.append(x)
    ADJ.append(nb)
adjset=[set(a) for a in ADJ]

def gmean(v):
    p=1.0
    for x in v: p*=x
    return p**(1.0/len(v))
econ={i:gmean([prov[i]['town'],prov[i]['output'],prov[i]['dams'],prov[i]['loyalty'],prov[i]['wealth']]) for i in range(COUNT)}
army={i:gmean([prov[i]['men'],prov[i]['morale'],prov[i]['arms']]) for i in range(COUNT)}
dmy ={i:gmean([daim[i]['health'],daim[i]['drive'],daim[i]['luck'],daim[i]['charisma'],daim[i]['iq']]) for i in range(COUNT)}
def ranks(v):
    o=sorted(range(COUNT),key=lambda i:-v[i]); r={};p=None;pr=0
    for pos,i in enumerate(o):
        if v[i]!=p: pr=pos+1;p=v[i]
        r[i]=pr
    return r
er,ar,dr=ranks(econ),ranks(army),ranks(dmy)
byname={prov[i]['name'].lower():i for i in range(COUNT)}

def reach2(i):
    s=set()
    for j in ADJ[i]:
        s.add(j); s.update(ADJ[j])
    s.discard(i); return s

KAGA_CAP_NOTE = "  ** SPECIAL: tax hard-capped at 30% (Honganji Ikko-ikki), not 100% **"

def profile(i):
    p,d=prov[i],daim[i]
    print("="*70)
    print(f"{prov[i]['name'].upper()}  -  {d['clan']} clan   (province #{i+1})")
    print("="*70)
    print(f"  Daimyo {d['clan']:<9} age {d['age']:>3}  Daimyo-agg {dmy[i]:5.1f} (rank {dr[i]}/50)"
          f"   [H{d['health']} Dr{d['drive']} Lk{d['luck']} Ch{d['charisma']} IQ{d['iq']}]")
    print(f"  ECONOMY  {econ[i]:5.1f}  (rank {er[i]:>2}/50)   "
          f"town {p['town']} output {p['output']} dams {p['dams']} loy {p['loyalty']} wlt {p['wealth']}  rice {p['rice']}")
    print(f"  ARMY     {army[i]:5.1f}  (rank {ar[i]:>2}/50)   "
          f"men {p['men']} morale {p['morale']} arms {p['arms']}")
    if prov[i]['name']=="Kaga": print(KAGA_CAP_NOTE)
    print(f"  degree {len(ADJ[i])}   2-hop reach {len(reach2(i))} provinces")
    print()
    print(f"  {'NEIGHBOR':<11}{'clan':<10}{'Econ':>6}{'Army':>6}{'mil edge':>9}  read")
    threat=prey=0.0
    for j in ADJ[i]:
        edge=army[i]-army[j]              # +ve = you outgun them
        if edge>=0: prey+=edge; tag=f"PREY  (+{edge:.0f} army) - takeable"
        else: threat+=-edge; tag=f"THREAT ({edge:.0f} army) - they outgun you"
        print(f"  {prov[j]['name']:<11}{daim[j]['clan']:<10}{econ[j]:>6.0f}{army[j]:>6.0f}{edge:>+9.0f}  {tag}")
    print()
    print(f"  total Army-THREAT in: {threat:5.1f}    total Army-PREY out: {prey:5.1f}")
    # forced/best target = neighbor you most outgun (or least outgunned by)
    tgt=max(ADJ[i], key=lambda j: army[i]-army[j])
    edge=army[i]-army[tgt]
    if edge>0:
        print(f"  -> first strike: {prov[tgt]['name']} ({daim[tgt]['clan']}), you lead army by {edge:.0f}; "
              f"gains Econ {econ[tgt]:.0f}")
    else:
        print(f"  -> NO favorable attack ({prov[tgt]['name']} still leads by {-edge:.0f}); "
              f"must DEVELOP first, then break out")
    print()

targets = sys.argv[1:] or ["Ezo","Awa(E)"]
for name in targets:
    i = byname.get(name.lower())
    if i is None: print(f"(unknown fief: {name})"); continue
    profile(i)
