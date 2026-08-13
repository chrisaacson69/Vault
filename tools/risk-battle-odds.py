#!/usr/bin/env python3
"""
risk-battle-odds.py — exact odds for a Risk battle fought to the death.

Models a single attacker-vs-defender battle as an ABSORBING MARKOV CHAIN and
solves it exactly (no simulation, no sampling error).

Convention
----------
  A = attacking ARMIES AT RISK. In Risk you must leave 1 army behind in the
      attacking territory, so a stack of N attacks with A = N-1.
  D = defending armies in the target territory.

Each round both sides roll the maximum dice allowed (the "best case" dice
assumption): attacker rolls min(3, A), defender rolls min(2, D). Highest die is
compared to highest, second to second; DEFENDER WINS TIES. Each comparison
costs the loser one army. Rounds repeat until A = 0 (attack fails) or D = 0
(territory taken, A survivors move in, +1 left behind).

Usage
-----
  py -3 tools/risk-battle-odds.py 298 300
  py -3 tools/risk-battle-odds.py 298 300 --observed 54
  py -3 tools/risk-battle-odds.py 10 10 --stack     # A given as a STACK size (N-1 attacks)
  py -3 tools/risk-battle-odds.py --selftest

Output: P(win), the expected/median/modal number of surviving attackers, the
full percentile spread, and (with --observed) where a real result landed.
"""

import argparse
import math
import sys
from itertools import product

# --------------------------------------------------------------------------
# Per-round dice table: (attacker_dice, defender_dice) -> {attacker_losses: p}
# Enumerated exhaustively over all 6**(ad+dd) equally-likely rolls.
# --------------------------------------------------------------------------


def round_table():
    tbl = {}
    for ad in (1, 2, 3):
        for dd in (1, 2):
            n = min(ad, dd)  # armies destroyed this round (one per compared pair)
            counts = {}
            total = 0
            for arolls in product(range(1, 7), repeat=ad):
                a_sorted = sorted(arolls, reverse=True)
                for drolls in product(range(1, 7), repeat=dd):
                    d_sorted = sorted(drolls, reverse=True)
                    # defender wins ties -> attacker loses the pair unless strictly higher
                    aloss = sum(1 for i in range(n) if a_sorted[i] <= d_sorted[i])
                    counts[aloss] = counts.get(aloss, 0) + 1
                    total += 1
            tbl[(ad, dd)] = {k: v / total for k, v in counts.items()}
    return tbl


ROUND = round_table()


# --------------------------------------------------------------------------
# The chain. States (a, d); every round strictly reduces a+d, so a single
# sweep over decreasing total is an exact forward propagation of probability.
# --------------------------------------------------------------------------


def solve(A, D):
    """Return (win_dist, loss_dist).

    win_dist[a]  = P(attacker takes the territory with exactly a survivors)
    loss_dist[d] = P(attack fails with exactly d defenders left standing)
    """
    if A < 0 or D < 0:
        raise ValueError("armies must be non-negative")

    prob = [[0.0] * (D + 1) for _ in range(A + 1)]
    prob[A][D] = 1.0
    win = [0.0] * (A + 1)
    loss = [0.0] * (D + 1)

    for total in range(A + D, -1, -1):
        lo = max(0, total - D)
        hi = min(A, total)
        for a in range(lo, hi + 1):
            d = total - a
            p = prob[a][d]
            if p == 0.0:
                continue
            if d == 0:            # territory taken
                win[a] += p
                continue
            if a == 0:            # attack spent
                loss[d] += p
                continue
            ad, dd = min(3, a), min(2, d)
            n = min(ad, dd)
            for aloss, q in ROUND[(ad, dd)].items():
                prob[a - aloss][d - (n - aloss)] += p * q
    return win, loss


# --------------------------------------------------------------------------
# The REDUCED chain — the same answer from the game's structure instead of
# from brute force. Three facts do the work:
#
#   1. While a>=3 and d>=2 the round is always 3v2, which kills EXACTLY 2
#      armies. So a+d falls by exactly 2 and its PARITY never changes —
#      half the (a,d) grid is unreachable.
#   2. In that regime the transition law does not depend on (a,d) at all, so
#      attacker losses are a sum of IID {0,1,2} draws: a 1-D random walk.
#   3. The regime is left only through a<=2 or d<=1, and that boundary region
#      is closed under transitions, so its tail solves in O(A+D).
#
# This is not asymptotically faster than solve() — both are O(A*D)/2, and the
# forward sweep already skips the unreachable half implicitly. Its value is
# that it is a structurally INDEPENDENT oracle, and that fact 2 hands us exact
# closed forms for the mean and the spread (see moments()).
# --------------------------------------------------------------------------


def _boundary_solve(A, D):
    """Exact (P(win), E[survivors]) for every state with a<=2 or d<=1.

    Every transition strictly lowers a+d, so one pass in increasing total order
    resolves the whole region without recursion.
    """
    states = set()
    for a in range(0, min(2, A) + 1):
        for d in range(0, D + 1):
            states.add((a, d))
    for d in range(0, min(1, D) + 1):
        for a in range(0, A + 1):
            states.add((a, d))

    pw, es = {}, {}
    for (a, d) in sorted(states, key=lambda s: s[0] + s[1]):
        if d == 0:
            pw[(a, d)], es[(a, d)] = 1.0, float(a)
            continue
        if a == 0:
            pw[(a, d)], es[(a, d)] = 0.0, 0.0
            continue
        ad, dd = min(3, a), min(2, d)
        n = min(ad, dd)
        w = e = 0.0
        for al, q in ROUND[(ad, dd)].items():
            s2 = (a - al, d - (n - al))
            w += q * pw[s2]
            e += q * es[s2]
        pw[(a, d)], es[(a, d)] = w, e
    return pw, es


def reduced(A, D):
    """(P(win), E[survivors], bulk_cells, n_boundary_states) via the reduction.

    Returns MOMENTS ONLY — for the full survivor distribution use solve().
    """
    pwb, esb = _boundary_solve(A, D)
    if A <= 2 or D <= 1:
        return pwb[(A, D)], esb[(A, D)], 0, len(pwb)

    P32 = ROUND[(3, 2)]
    front = {A: 1.0}          # P(still in the 3v2 regime with `a` attackers left)
    exits = {}
    k, cells = 0, 0
    while front:
        k += 1
        total = A + D - 2 * k          # d is implied: d = total - a
        nxt = {}
        for a, p in front.items():
            cells += 1
            for al, q in P32.items():
                a2 = a - al
                d2 = total - a2
                if a2 <= 2 or d2 <= 1:
                    exits[(a2, d2)] = exits.get((a2, d2), 0.0) + p * q
                else:
                    nxt[a2] = nxt.get(a2, 0.0) + p * q
        front = nxt

    pw = sum(p * pwb[s] for s, p in exits.items())
    es = sum(p * esb[s] for s, p in exits.items())
    return pw, es, cells, len(exits)


def moments(A, D):
    """Closed forms from the IID bulk increments (fact 2 above).

    Z = a - c*d with c = mu/(2-mu) is a MARTINGALE, so optional stopping gives
    E[survivors] = A - c*D directly, and the per-round variance of Z gives the
    spread. Both are bulk approximations: they ignore the endgame boundary.

    The constants are exact rationals, not fits: attacker losses per round are
    7161/7776 and defender losses 8391/7776 (summing to 2), so the price of a
    defender is c = 7161/8391 = 2387/2797 = 0.8534143725...
    """
    p = ROUND[(3, 2)]
    mu = p[1] + 2 * p[2]                    # E[attacker losses per round]
    var = (p[1] + 4 * p[2]) - mu * mu
    d_rate = 2 - mu                         # E[defender losses]; the two sum to exactly 2
    c = mu / d_rate                         # attacker armies paid per defender killed
    z_var = (1 + c) ** 2 * var              # per-round variance of the martingale
    return {
        "mu": mu, "var": var, "d_rate": d_rate, "c": c,
        "mean": A - c * D,
        "sd": math.sqrt(z_var * D / d_rate),
        "sd_coef": math.sqrt(z_var / d_rate),   # sd ~ coef * sqrt(D)
    }


# --------------------------------------------------------------------------
# Reporting
# --------------------------------------------------------------------------


def percentile(win, p_win, q):
    """q-th percentile of surviving attackers over ALL outcomes (a loss = 0)."""
    p_loss = 1.0 - p_win
    cum = p_loss
    if cum >= q:
        return 0
    for a in range(1, len(win)):
        cum += win[a]
        if cum >= q:
            return a
    return len(win) - 1


def report(A, D, observed=None):
    win, loss = solve(A, D)
    p_win = sum(win)
    ev_win = sum(a * win[a] for a in range(len(win)))          # unconditional
    ev_cond = ev_win / p_win if p_win > 0 else 0.0             # given a win
    mode = max(range(len(win)), key=lambda a: win[a]) if p_win > 0 else 0
    ev_def_left = sum(d * loss[d] for d in range(len(loss)))
    ev_def_left_cond = ev_def_left / (1 - p_win) if p_win < 1 else 0.0

    print(f"RISK — {A} attacking armies vs {D} defenders (max dice, defender wins ties)")
    print(f"  attacking stack on the board: {A + 1}  (1 must stay home)")
    print()
    print(f"  P(attacker takes the territory) = {p_win:.6f}   ({p_win*100:.3f}%)")
    print(f"  P(attack fails)                 = {1-p_win:.6f}   ({(1-p_win)*100:.3f}%)")
    print()
    print("  Surviving attackers (given a WIN):")
    print(f"    expected  = {ev_cond:.2f}     (moves in {ev_cond:.2f}, +1 stays home)")
    print(f"    most likely single value (mode) = {mode}")
    print(f"    P50 / median = {percentile(win, p_win, 0.50)}")
    print()
    # Fluid/attrition closed form. In the 3v2 regime the attacker loses 0.92091 armies
    # per round and the defender 1.07909 (they sum to 2 -- two armies die every round),
    # so the attacker pays 0.85342 armies per defender killed. This approximates the
    # UNCONDITIONAL mean (a failed attack contributing 0), not the given-a-win mean.
    mo = moments(A, D)
    e2 = sum(a * a * win[a] for a in range(len(win)))
    sd_unc = math.sqrt(max(0.0, e2 - ev_win ** 2))
    e1c = ev_cond
    sd_con = math.sqrt(max(0.0, e2 / p_win - e1c ** 2)) if p_win > 0 else 0.0

    print(f"  Expected over ALL attacks (a failure counts as 0) = {ev_win:.2f}")
    print()
    print("  Spread (this is the part people misjudge):")
    print(f"    sd of survivors = {sd_con:.2f} given a win  /  {sd_unc:.2f} over all attacks")
    if A > 0:
        print(f"    that is only {sd_con/A:.1%} of the {A}-army attacking force")
    if A >= 20 and D >= 20 and mo["mean"] > 0:
        print(f"    closed form:  A - {mo['c']:.4f}*D = {mo['mean']:.2f}"
              f"   (exact {ev_win:.2f}, drift {ev_win - mo['mean']:+.2f})")
        print(f"                  sd ~ {mo['sd_coef']:.4f}*sqrt(D) = {mo['sd']:.2f}"
              f"   (exact {sd_unc:.2f}; the a=0 boundary trims the low tail)")
    else:
        print("    closed forms do not apply at this scale (the 3v2 regime is too short)")
    print()
    print("  Percentile spread of survivors (over ALL outcomes; a failed attack = 0):")
    for q in (0.01, 0.05, 0.10, 0.25, 0.50, 0.75, 0.90, 0.95, 0.99):
        print(f"    {q*100:5.0f}th : {percentile(win, p_win, q):>4}")
    print()
    if p_win < 1:
        print(f"  If the attack fails, expected defenders left = {ev_def_left_cond:.2f}")
        print()

    if observed is not None:
        p_below = (1.0 - p_win) + sum(win[a] for a in range(1, min(observed, A) + 1))
        p_worse = (1.0 - p_win) + sum(win[a] for a in range(1, min(observed, A)))
        p_exact = win[observed] if 0 <= observed <= A else 0.0
        print(f"  OBSERVED result: {observed} survivors")
        print(f"    P(exactly {observed})      = {p_exact*100:.4f}%")
        print(f"    P(worse than {observed})   = {p_worse*100:.3f}%")
        print(f"    P(better than {observed})  = {(1-p_below)*100:.3f}%")
        print(f"    -> percentile band: {p_worse*100:.1f}–{p_below*100:.1f}")
        print(f"    vs expected {ev_cond:.1f} given a win: "
              f"{observed - ev_cond:+.1f} armies")
    return win, loss


# --------------------------------------------------------------------------
# Self-test against published Risk dice odds (grounding check, not a rebuild)
# --------------------------------------------------------------------------


def selftest():
    ok = True

    def chk(name, got, want, tol=1e-12):
        nonlocal ok
        good = abs(got - want) < tol
        ok &= good
        print(f"  [{'ok ' if good else 'FAIL'}] {name}: {got!r} vs {want!r}")

    # Canonical single-round numbers (Wikipedia / standard Risk odds tables).
    chk("3v2 defender loses 2", ROUND[(3, 2)][0], 2890 / 7776)
    chk("3v2 one each",         ROUND[(3, 2)][1], 2611 / 7776)
    chk("3v2 attacker loses 2", ROUND[(3, 2)][2], 2275 / 7776)
    chk("3v1 defender loses 1", ROUND[(3, 1)][0],  855 / 1296)
    chk("2v2 defender loses 2", ROUND[(2, 2)][0],  295 / 1296)
    chk("2v1 defender loses 1", ROUND[(2, 1)][0],  125 / 216)
    chk("1v2 defender loses 1", ROUND[(1, 2)][0],   55 / 216)
    chk("1v1 defender loses 1", ROUND[(1, 1)][0],   15 / 36)

    # Whole-battle sanity: 1 vs 1 is exactly the single-round number.
    w, l = solve(1, 1)
    chk("battle 1v1 P(win)", sum(w), 15 / 36)

    # Probability conservation on a big battle.
    w, l = solve(50, 50)
    chk("50v50 total prob", sum(w) + sum(l), 1.0, tol=1e-9)

    # The two engines are structurally independent (2-D brute-force sweep vs
    # parity-reduced bulk walk + boundary decomposition). Agreement is the
    # strongest check in this file, so it runs on every invocation.
    print()
    for A, D in [(3, 2), (5, 5), (10, 7), (20, 20), (40, 35), (100, 100), (298, 300)]:
        w, l = solve(A, D)
        fp, fe = sum(w), sum(i * w[i] for i in range(len(w)))
        rp, re, _, _ = reduced(A, D)
        chk(f"engines agree {A}v{D} P(win)", fp, rp, tol=1e-11)
        chk(f"engines agree {A}v{D} E[S]  ", fe, re, tol=1e-9)

    # The martingale identity behind the closed form: E[dZ] must be exactly 0.
    mo = moments(1, 1)
    chk("martingale drift", -mo["mu"] + mo["c"] * (2 - mo["mu"]), 0.0, tol=1e-15)
    chk("loss rates sum to 2", mo["mu"] + mo["d_rate"], 2.0)

    print("\nSELFTEST", "PASSED" if ok else "FAILED")
    return 0 if ok else 1


def main():
    ap = argparse.ArgumentParser(description="Exact Risk battle odds (absorbing Markov chain).")
    ap.add_argument("attackers", nargs="?", type=int, help="attacking armies AT RISK (stack - 1)")
    ap.add_argument("defenders", nargs="?", type=int)
    ap.add_argument("--stack", action="store_true",
                    help="treat 'attackers' as the on-board stack size; 1 stays home")
    ap.add_argument("--observed", type=int, help="an actual survivor count to score")
    ap.add_argument("--selftest", action="store_true")
    ap.add_argument("--reduced", action="store_true",
                    help="also solve with the parity-reduced engine and show what it trims")
    args = ap.parse_args()

    if args.selftest:
        return selftest()
    if args.attackers is None or args.defenders is None:
        ap.error("need ATTACKERS and DEFENDERS (or --selftest)")

    A = args.attackers - 1 if args.stack else args.attackers
    win, loss = report(A, args.defenders, args.observed)

    if args.reduced:
        D = args.defenders
        rp, re, cells, nex = reduced(A, D)
        fp = sum(win)
        fe = sum(i * win[i] for i in range(len(win)))
        grid = (A + 1) * (D + 1)
        print("  REDUCED ENGINE (parity-trimmed bulk walk + boundary decomposition)")
        print(f"    P(win)  {rp:.12f}   vs sweep {fp:.12f}   delta {abs(rp-fp):.2e}")
        print(f"    E[S]    {re:.10f}   vs sweep {fe:.10f}   delta {abs(re-fe):.2e}")
        print(f"    bulk cells walked  {cells:,} of the {grid:,}-cell grid ({cells/grid:.1%})")
        print(f"    boundary states    {nex:,}  (a<=2 or d<=1; closed under transitions)")
        print(f"    a+d parity is fixed at {(A+D) % 2} in the 3v2 regime — "
              f"the other half of the grid is unreachable")
    return 0


if __name__ == "__main__":
    sys.exit(main())
