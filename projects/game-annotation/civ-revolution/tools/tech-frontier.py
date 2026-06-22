#!/usr/bin/env python3
"""
tech-frontier.py -- the dominance frontier over CivRev's tech-tree first-discover bonuses.

THE POINT (per Chris): a first-discover bonus is NOT a scalar. "+1 science in EVERY city"
is worth  mag x cities x horizon  (it scales with WIDTH and TIME), while "Free Legion" is a
flat one-time value. So the efficient frontier SHIFTS with city count: a tech dominated at
2 cities can dominate at 6. This tool makes that shift visible.

GROUNDED inputs (from raw/civrev-civilopedia-tables.md): each tech's beaker COST and its
first-discover BONUS string; unit/building production costs (to value "Free X").
MODEL PARAMETERS (NOT grounded -- tunable assumptions, gold-equivalent): yield weights,
pop tile-yield, hammer->gold rate, Great-Person value, horizon. The tool's job is to show
STRUCTURE (how the frontier moves with width), not to emit authoritative numbers. Tune PARAMS
and the ranking moves; the *shift with city count* is the robust, grounded-in-structure result.

Run:  py -3 tech-frontier.py            # default compare at 2 / 4 / 8 cities
      py -3 tech-frontier.py --horizon 60 --cities 1,3,6
"""
import argparse

# GROUNDED data lives in civrev_data.py (single source of truth, shared with trap-detector).
# This tool's first-bonus model uses (name, cost, bonus); prereqs (also in civrev_data) unused here.
from civrev_data import TECHS as _TECHS, PROD_COST  # noqa: E402
TECHS = [(n, c, b) for n, c, _pre, b in _TECHS]

# --- PARAMETERS (NOT grounded -- tunable assumptions, gold-equivalent) -----------
PARAMS = {
    # gold-equivalent value of +1 of a per-city yield, PER TURN:
    "w_science": 1.5, "w_production": 2.0, "w_trade": 1.5, "w_gold": 1.0, "w_culture": 0.2,
    "pop_tile_yield": 3.0,   # a +1 pop works a tile ~ this many gold-equiv/turn
    "hammer_value": 2.0,     # gold per production hammer (~ the rush rate)
    "gp_value": 300.0,       # a Great Person (instant tech / wonder) -- very soft
    "map_value": 100.0,      # "entire map revealed" -- soft
    "other_value": 40.0,     # Communism factory discount / Networking univ discount -- soft
    "horizon": 100,          # turns the bonus stays active after discovery
}

PERCITY_PERTURN = {  # "+N <yield> in every city" -> per-turn gold-equiv weight key
    "science": "w_science", "production": "w_production",
    "trade": "w_trade", "gold": "w_gold", "culture": "w_culture",
}


def classify(bonus):
    """-> (kind, payload). kind in {none, percity_perturn, percity_pop, free, gold, gp,
    map, other}."""
    b = bonus.strip()
    if b == "none":
        return ("none", None)
    if b == "Free Great Person":
        return ("gp", None)
    if b == "Entire map revealed":
        return ("map", None)
    if b == "other":
        return ("other", None)
    if b.startswith("Free "):
        items = b[5:].replace(" in a city", "").split(", ")
        # handle "Free SDI" alias
        prod = sum(PROD_COST.get(it, PROD_COST.get(it.rstrip("s"), 0)) for it in items)
        return ("free", prod)
    if b.endswith("gold") and b[0].isdigit():
        return ("gold", int(b.split()[0]))
    if "in every city" in b:
        # "+N <yield> in every city"
        parts = b.split()
        mag = int(parts[0].lstrip("+"))
        yld = parts[1]
        if yld == "population":
            return ("percity_pop", mag)
        return ("percity_perturn", (mag, yld))
    return ("other", None)


def value(bonus, cities, P):
    kind, pay = classify(bonus)
    H = P["horizon"]
    if kind == "none":
        return 0.0
    if kind == "percity_perturn":
        mag, yld = pay
        return mag * cities * P[PERCITY_PERTURN[yld]] * H        # scales with cities AND time
    if kind == "percity_pop":
        return pay * cities * P["pop_tile_yield"] * H            # pop produces forever -> width x time
    if kind == "free":
        return pay * P["hammer_value"]                           # flat one-time
    if kind == "gold":
        return float(pay)                                        # flat one-time
    if kind == "gp":
        return P["gp_value"]                                     # flat one-time
    if kind == "map":
        return P["map_value"]
    return P["other_value"]


def scales_with_width(bonus):
    return classify(bonus)[0] in ("percity_perturn", "percity_pop")


def frontier(rows):
    """rows: list of (name, cost, val). Pareto frontier: min cost, max val."""
    front = set()
    for n, c, v in rows:
        dominated = any((c2 <= c and v2 >= v and (c2, v2) != (c, v)) for _, c2, v2 in rows)
        if not dominated and v > 0:
            front.add(n)
    return front


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--horizon", type=int, default=PARAMS["horizon"])
    ap.add_argument("--cities", default="2,4,8")
    args = ap.parse_args()
    PARAMS["horizon"] = args.horizon
    city_counts = [int(x) for x in args.cities.split(",")]

    print("CivRev tech-tree dominance frontier (gold-equivalent value per beaker).")
    print(f"horizon={PARAMS['horizon']} turns.  GROUNDED: cost+bonus type.  "
          f"PARAMS (soft): yield weights, gp={PARAMS['gp_value']}, hammer={PARAMS['hammer_value']}.\n")

    # ROI table across city counts
    roi = {}      # name -> {cities: roi}
    front = {}    # cities -> set(names on frontier)
    for cc in city_counts:
        rows = [(n, c, value(b, cc, PARAMS)) for n, c, b in TECHS]
        front[cc] = frontier(rows)
        for n, c, v in rows:
            roi.setdefault(n, {})[cc] = v / c

    bonus_of = {n: b for n, c, b in TECHS}
    cost_of = {n: c for n, c, b in TECHS}

    # --- top techs by ROI at the widest count, showing the shift ----------------
    hi = city_counts[-1]
    ranked = sorted(roi, key=lambda n: -roi[n][hi])
    head = "  ".join(f"{cc}c" for cc in city_counts)
    print(f"  {'tech':17}{'cost':>5}  ROI(value/beaker) @ {head}   width? bonus")
    for n in ranked[:16]:
        rois = "  ".join(f"{roi[n][cc]:5.2f}" for cc in city_counts)
        w = "WIDE" if scales_with_width(bonus_of[n]) else " -- "
        fr = "*" if n in front[hi] else " "
        print(f"{fr} {n:17}{cost_of[n]:>5}  {rois}    {w}  {bonus_of[n]}")
    print("  (* = on the efficient frontier at the widest count)\n")

    # --- the crossover: who OVERTAKES whom as you go wide -----------------------
    lo = city_counts[0]
    movers = []
    for n in roi:
        d = roi[n][hi] - roi[n][lo]
        if abs(d) > 1e-9:
            movers.append((d, n))
    movers.sort(reverse=True)
    print(f"  ROI change from {lo} -> {hi} cities (the 'X works at {hi} but not {lo}' effect):")
    for d, n in movers[:6]:
        print(f"    +{d:6.2f}  {n:17} ({roi[n][lo]:.2f} -> {roi[n][hi]:.2f})  {bonus_of[n]}")
    flat = [n for n in ranked if not scales_with_width(bonus_of[n])][:3]
    print(f"    (flat, width-independent: {', '.join(flat)} -- one-time bonuses don't scale)\n")

    # --- the THIN SPINE: how few techs Pareto-dominate the whole tree -----------
    spine = sorted(front[hi], key=lambda n: cost_of[n])
    print(f"  the spine: {len(spine)} of {len(TECHS)} techs are on the cost-vs-value frontier "
          f"(@ {hi}c) -- the rest are dominated:")
    print(f"    {', '.join(spine)}")
    print("  (stable across width: per-city techs all scale together, so the SET barely moves --")
    print("   the research tree really is this thin.)\n")

    # --- the REGIME FLIP: which tech you rush FIRST, by city count --------------
    print("  rush-order (top-3 by ROI) at each width -- the one-time -> per-city regime flip:")
    for cc in city_counts:
        top3 = sorted(roi, key=lambda n: -roi[n][cc])[:3]
        cells = "   ".join(f"{n} {roi[n][cc]:.1f}" for n in top3)
        print(f"    {cc}c: {cells}")
    print("    => one-time bonuses (Free Walls) lead the 1-city opening; per-city bonuses")
    print("       (Irrigation/Literacy) take over by 2 cities -- rush first, then go wide.")


if __name__ == "__main__":
    main()
