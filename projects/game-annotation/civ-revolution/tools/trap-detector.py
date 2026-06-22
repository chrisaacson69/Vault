#!/usr/bin/env python3
"""
trap-detector.py -- which tech-unit unlocks are TRAPS vs normal progression.

Chris's caveat: in a tech-progression game domination is the DEFAULT (Modern Infantry beats
Warrior -- that's the tree working). So raw "is it dominated" flags everything and says nothing.
A real TRAP is a unit whose tech is a DEAD-END LEAF (nothing else requires it -> a pure detour)
yet a same-role unit DOMINATES it -- and bonus signal if the dominator's tech is ON your path
(required by other techs you'd take anyway). That's the Navigation->Steam Power case.

Grounded in civrev_data (unit A/D/M + the tech DAG). No soft parameters.
CAVEAT: domination here is on A/D/M only -- it ignores special abilities (Submarine stealth,
Bomber range, Fighter air-superiority, Catapult/Artillery siege-through-walls). Those are a v2
"capability" axis; a stat-dominated unit with a unique role may still be worth it.

Run:  py -3 trap-detector.py
"""
from civrev_data import UNITS, cum_cost, is_leaf, required_by

COMBAT = [u for u in UNITS if u[6] != "none"]
RB = required_by()


def stats(u):
    return (u[2], u[3], u[4])  # A, D, M


def dominates(v, u):
    return all(a >= b for a, b in zip(stats(v), stats(u))) and stats(v) != stats(u)


def dominators(u):
    """same-domain units that A/D/M-dominate u, cheapest-tech first."""
    ds = [v for v in COMBAT if v[6] == u[6] and v[0] != u[0] and dominates(v, u)]
    return sorted(ds, key=lambda v: cum_cost(v[1]))


def onpath(tech):
    n = len(RB.get(tech, set()))
    return f"on-path: feeds {n} tech{'s' if n != 1 else ''}" if n else "LEAF (dead-end)"


def main():
    traps, progression, topline = [], [], []
    for u in COMBAT:
        ds = dominators(u)
        if not ds:
            topline.append(u)
        elif u[1] != "none" and is_leaf(u[1]):
            traps.append((u, ds[0]))
        else:
            progression.append((u, ds[0]))

    print("CivRev tech-unit TRAP detector -- grounded (unit A/D/M + tech DAG), no soft params.\n")

    print("=== TRAPS (dead-end tech + outclassed unit -> skip the tech) ===")
    if not traps:
        print("  (none)")
    for u, v in traps:
        ua, va = stats(u), stats(v)
        print(f"  {u[0]} ({u[6]}) via {u[1]} [{onpath(u[1])}, cumcost {cum_cost(u[1])}]")
        print(f"     dominated by {v[0]} {va[0]}/{va[1]}/{va[2]} vs {ua[0]}/{ua[1]}/{ua[2]} "
              f"via {v[1]} [{onpath(v[1])}, cumcost {cum_cost(v[1])}]")
        print(f"     => {u[1]} leads nowhere; {v[1]} is reachable on your path. Skip {u[1]}.\n")

    print("=== TOP-OF-LINE (nothing in-role A/D/M-beats these -- the units worth teching to) ===")
    by_dom = {}
    for u in topline:
        by_dom.setdefault(u[6], []).append(f"{u[0]} ({u[1]})")
    for dom in sorted(by_dom):
        print(f"  {dom:9} {' , '.join(by_dom[dom])}")

    print("\n=== PROGRESSION (dominated, but tech is on-path -- normal upgrade, not a trap) ===")
    for u, v in sorted(progression, key=lambda p: cum_cost(p[0][1])):
        w = cum_cost(v[1]) - cum_cost(u[1])
        print(f"  {u[0]:16} ({u[1]}, {onpath(u[1])}) -> {v[0]} via {v[1]};  window {w} beakers")
    print("\n  (window = extra cumulative beakers from this unit's tech to its cheapest dominator;")
    print("   small window on an on-path tech = a short-lived but still-useful step, not a detour.)")


if __name__ == "__main__":
    main()
