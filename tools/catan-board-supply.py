#!/usr/bin/env python3
"""
catan-board-supply.py — read a base-Catan board as an economy: pip supply per
resource, and what each build costs given that supply.

Premise (Chris, 2026-11-09): setups are random, but each resource's total pips
can be counted. That distribution plus each build's recipe decides which goals
are cheap and which are expensive on THIS board, so reading the board as a
whole informs strategy and initial placement.

Model
-----
  supply[r] = sum of pips (2/12 -> 1, 3/11 -> 2, ... 6/8 -> 5) on r's tiles.
  share[r]  = supply[r] / total pips (58 on every standard board).
  price(b)  = sum over b's recipe of units / (5 * share[r]).
              A perfectly even board (every share = 1/5) prices each card at
              1.0, so price(b) = card count. Above that = the board makes b
              dearer; below = cheaper.

Board supply, NOT capture: what you collect depends on your vertices and on
placement order. Linear in scarcity; no ports, trading, robber, or the
expiring value of open settlement spots (see research/gaming/sim-channels/
catan.md). Random boards ignore the no-adjacent-6/8 rule, which moves numbers
between tiles and so shifts per-resource totals slightly.

Usage
-----
  py -3 tools/catan-board-supply.py --sample 200000          # distribution over random boards
  py -3 tools/catan-board-supply.py --board "wood=6,9,10,3 brick=8,4,11 sheep=5,12,9,6 wheat=8,5,10,3 ore=4,11,2"
  py -3 tools/catan-board-supply.py --selftest
"""
import argparse
import random
import statistics as st
import sys

PIPS = {2: 1, 3: 2, 4: 3, 5: 4, 6: 5, 8: 5, 9: 4, 10: 3, 11: 2, 12: 1}
TOKENS = [2, 3, 3, 4, 4, 5, 5, 6, 6, 8, 8, 9, 9, 10, 10, 11, 11, 12]
TILES = {"wood": 4, "brick": 3, "sheep": 4, "wheat": 4, "ore": 3}
RES = list(TILES)
RECIPES = {
    "road": {"wood": 1, "brick": 1},
    "settlement": {"wood": 1, "brick": 1, "sheep": 1, "wheat": 1},
    "city": {"wheat": 2, "ore": 3},
    "dev": {"ore": 1, "wheat": 1, "sheep": 1},
}


def prices(supply):
    total = sum(supply.values())
    return {b: sum(n / (5 * supply[r] / total) for r, n in rec.items())
            for b, rec in RECIPES.items()}


def random_supply(rng):
    t = TOKENS[:]
    rng.shuffle(t)
    s, i = {}, 0
    for r, k in TILES.items():
        s[r] = sum(PIPS[x] for x in t[i:i + k])
        i += k
    return s


def pct(v, q):
    return v[min(len(v) - 1, int(q * len(v)))]


def sample(n, seed):
    rng = random.Random(seed)
    sups = [random_supply(rng) for _ in range(n)]
    prs = [prices(s) for s in sups]
    print(f"{n} random boards (seed {seed}); total pips {sum(PIPS[k] for k in TOKENS)}")
    print("\nSupply (pips)      mean   p5  p95  min  max")
    for r in RES:
        v = sorted(s[r] for s in sups)
        print(f"  {r:8}        {st.mean(v):5.2f}  {pct(v,.05):3}  {pct(v,.95):3}  {v[0]:3}  {v[-1]:3}")
    print("\nPrice (1.0/card = even board)  cards  median    p5    p95")
    for b in RECIPES:
        v = sorted(p[b] for p in prs)
        print(f"  {b:11}                    {sum(RECIPES[b].values())}   {pct(v,.5):5.2f}  {pct(v,.05):5.2f}  {pct(v,.95):5.2f}")
    v = sorted(p["city"] / p["settlement"] for p in prs)
    print(f"\ncity/settlement price ratio  p5 {pct(v,.05):.2f}  median {pct(v,.5):.2f}  p95 {pct(v,.95):.2f}")


def parse_board(spec):
    s = {}
    for part in spec.split():
        r, nums = part.split("=")
        s[r] = sum(PIPS[int(x)] for x in nums.split(","))
    missing = set(RES) - set(s)
    if missing:
        sys.exit(f"missing resources: {sorted(missing)}")
    return s


def show_board(s):
    print("Supply: " + "  ".join(f"{r} {s[r]}" for r in RES) + f"  (total {sum(s.values())})")
    for b, p in prices(s).items():
        print(f"  {b:11} {p:5.2f}  (even board {sum(RECIPES[b].values())})")


def selftest():
    assert sum(PIPS[k] for k in TOKENS) == 58
    assert sum(TILES.values()) == len(TOKENS) == 18
    even = {r: 58 / 5 for r in RES}
    for b, p in prices(even).items():
        assert abs(p - sum(RECIPES[b].values())) < 1e-9, b
    # expected supply: 58/18 pips per tile
    rng = random.Random(7)
    sups = [random_supply(rng) for _ in range(40000)]
    for r, k in TILES.items():
        m = st.mean(s[r] for s in sups)
        assert abs(m - 58 * k / 18) < 0.1, (r, m)
    print("selftest ok")


if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("--sample", type=int)
    ap.add_argument("--seed", type=int, default=1)
    ap.add_argument("--board")
    ap.add_argument("--selftest", action="store_true")
    a = ap.parse_args()
    if a.selftest:
        selftest()
    elif a.board:
        show_board(parse_board(a.board))
    else:
        sample(a.sample or 200000, a.seed)
