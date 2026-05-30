#!/usr/bin/env python3
"""verify-17-subset-of-50.py — Cross-check the 17-fief adjacency against the
50-fief adjacency by province NAME.

The 17-fief scenario tiles central Japan with 17 provinces; the 50-fief tiles
the SAME ground with more provinces, inserting fiefs (Kiso, Ecchu, Tango,
Tanba, Kii) inside the 17-fief footprint. So 17-fief adjacency is NOT a strict
edge subset of the 50 — inserted provinces reroute some borders.

Correct relationship: every 17-fief edge A-B is either
  (a) present directly in the 50-fief table, OR
  (b) A and B are separated in the 50 by exactly the inserted provinces
      (a path through non-17 fiefs only) -- a graph contraction.

Any 17-fief edge that is NEITHER direct NOR a clean contraction is a red flag.
"""
import os
from collections import deque

here = os.path.dirname(os.path.abspath(__file__))
rom = open(os.path.join(here, "Nobunaga's Ambition (USA).nes"), 'rb').read()[16:]

def prg(cpu, bank): return bank * 0x4000 + (cpu & 0x3FFF)
def read_table(cpu, bank, count):
    adj = []
    for i in range(count):
        base = prg(cpu + i*8, bank)
        nb = []
        for b in rom[base:base+8]:
            if b == 0xFF or b >= count: break
            nb.append(b)
        adj.append(nb)
    return adj

ADJ50 = read_table(0x8004, 4, 50)
ADJ17 = read_table(0x8300, 4, 17)

N50 = ["Ezo","Mutsu","Morioka","Iwasaki","Ugo","Rikuzen","Uzen","Iwaki","Iwashiro",
    "Echigo","Hitachi","Shimotsu","Awa(E)","Musashi","Shinano","Noto","Ecchu","Hida",
    "Kiso","Suruga","Kaga","Echizen","Mino","Mikawa","Owari","Iseshima","Omi","Iga",
    "Tango","Tanba","Yamashir","Yamato","Settsu","Kii","Inaba","Harima","Izumo","Sanbi",
    "Aki","Sanuki","Awa(S)","Iyo","Tosa","Nakamura","Buzen","Chikuhi","Bungo","Higo",
    "Hiyuga","Satuma"]
N17 = ["Noto","Echigo","Musashi","Kaga","Echizen","Hida","Suruga","Mikawa","Mino",
    "Yamato","Omi","Iga","Iseshima","Yamashir","Settsu","Shinano","Owari"]

idx50 = {n:i for i,n in enumerate(N50)}
shared = set(N17)                       # the 17 names that exist in both
inserted = set(N50) - shared            # provinces only in the 50-fief map
adj50_set = [set(a) for a in ADJ50]

def contraction_path(a, b):
    """Shortest path in 50 from a to b whose INTERMEDIATE nodes are all
    inserted (non-17) provinces. Returns list of 50-indices or None."""
    sa, sb = idx50[a], idx50[b]
    q = deque([(sa, [sa])])
    seen = {sa}
    while q:
        cur, path = q.popleft()
        for nxt in adj50_set[cur]:
            if nxt == sb:
                return path + [sb]
            if nxt in seen: continue
            if N50[nxt] in inserted:        # may only pass through inserted fiefs
                seen.add(nxt)
                q.append((nxt, path + [nxt]))
    return None

# Enumerate 17-fief edges by name
edges17 = set()
for i, nb in enumerate(ADJ17):
    for j in nb:
        edges17.add(tuple(sorted((N17[i], N17[j]))))

direct, contracted, broken = [], [], []
for a, b in sorted(edges17):
    if idx50[b] in adj50_set[idx50[a]]:
        direct.append((a, b))
    else:
        p = contraction_path(a, b)
        if p:
            contracted.append((a, b, [N50[k] for k in p]))
        else:
            broken.append((a, b))

print(f"17-fief edges: {len(edges17)}")
print(f"  direct in 50-fief        : {len(direct)}")
print(f"  contracted (via inserted): {len(contracted)}")
print(f"  BROKEN (unexplained)     : {len(broken)}")
print()
print("-- direct subset edges (present verbatim in the 50) --")
for a, b in direct:
    print(f"   {a:<9} - {b}")
print()
print("-- contracted edges (50 inserted a province between them) --")
for a, b, path in contracted:
    mid = " -> ".join(path)
    print(f"   {a:<9} - {b:<9}  via  {mid}")
if broken:
    print()
    print("-- !! BROKEN: 17-fief edge with no 50-fief explanation !! --")
    for a, b in broken:
        print(f"   {a:<9} - {b}")
else:
    print()
    print("RESULT: every 17-fief edge is explained by the 50-fief table.")
