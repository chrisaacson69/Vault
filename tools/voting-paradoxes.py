#!/usr/bin/env python3
"""voting-paradoxes.py -- worked, machine-checked examples of social-choice pathologies.

Every example on research/debates/voting-paradox-worked-examples.md is COMPUTED here,
not asserted. `--selftest` re-derives each claimed pathology from the ballot profiles
and fails loudly if any claim stops holding.

Two independent families of claim are covered, and they are NOT the same argument:

  (1) IMPOSSIBILITY -- no method satisfies every desideratum at once.
      Arrow                 -> IIA failure (the ONLY one that is literally Arrow)
      Gibbard-Satterthwaite -> strategic manipulation pays
      Moulin                -> no-show / participation failure
      (monotonicity and Condorcet failure are CRITERIA, not theorems -- label them so)

  (2) UNDERDETERMINATION -- "STV" is not one rule. Identical ballots, different
      legally-ordinary implementation choices (quota, surplus transfer), different
      winners. This is the attack on the handwave about what lets a candidate advance.

Usage:
  py -3 tools/voting-paradoxes.py --selftest    # verify every documented claim
  py -3 tools/voting-paradoxes.py --report      # print the tables used on the page
  py -3 tools/voting-paradoxes.py --search      # re-run the profile search
"""

from __future__ import annotations

import argparse
import itertools
import random
from fractions import Fraction

# A profile is a list of (weight, ranking); ranking is a tuple, most-preferred first.


def candidates(profile):
    seen = set()
    for _, ranking in profile:
        seen.update(ranking)
    return sorted(seen)


def restrict(profile, keep):
    """Delete candidates not in `keep` from every ballot (the Arrow/IIA surgery)."""
    out = []
    for w, ranking in profile:
        r = tuple(c for c in ranking if c in keep)
        if r:
            out.append((w, r))
    return out


def first_prefs(profile, alive):
    tally = {c: 0 for c in alive}
    for w, ranking in profile:
        for c in ranking:
            if c in alive:
                tally[c] += w
                break
    return tally


def plurality(profile):
    alive = set(candidates(profile))
    t = first_prefs(profile, alive)
    return max(sorted(t), key=lambda c: t[c])


def borda(profile):
    cands = candidates(profile)
    n = len(cands)
    score = {c: 0 for c in cands}
    for w, ranking in profile:
        for i, c in enumerate(ranking):
            score[c] += w * (n - 1 - i)
    return max(sorted(score), key=lambda c: score[c])


def pairwise(profile):
    cands = candidates(profile)
    m = {(a, b): 0 for a in cands for b in cands if a != b}
    for w, ranking in profile:
        pos = {c: i for i, c in enumerate(ranking)}
        for a, b in itertools.permutations(cands, 2):
            if pos.get(a, len(ranking) + 1) < pos.get(b, len(ranking) + 1):
                m[(a, b)] += w
    return m


def condorcet(profile):
    """The candidate who beats every other head-to-head, or None."""
    cands = candidates(profile)
    m = pairwise(profile)
    for a in cands:
        if all(m[(a, b)] > m[(b, a)] for b in cands if b != a):
            return a
    return None


def condorcet_loser(profile):
    cands = candidates(profile)
    m = pairwise(profile)
    for a in cands:
        if all(m[(a, b)] < m[(b, a)] for b in cands if b != a):
            return a
    return None


def irv(profile, trace=False):
    """Instant-runoff / single-winner RCV: eliminate fewest first prefs, transfer."""
    alive = set(candidates(profile))
    rounds = []
    while True:
        t = first_prefs(profile, alive)
        total = sum(t.values())
        rounds.append(dict(t))
        if not total:
            break
        for c in sorted(alive):
            if t[c] * 2 > total:
                return (c, rounds) if trace else c
        if len(alive) <= 1:
            break
        low = min(t.values())
        doomed = sorted([c for c in alive if t[c] == low])[-1]
        alive.discard(doomed)
    winner = sorted(alive)[0] if alive else None
    return (winner, rounds) if trace else winner


def runoff(profile):
    """Traditional two-round runoff: top two on first prefs, then head-to-head."""
    alive = set(candidates(profile))
    t = first_prefs(profile, alive)
    top2 = sorted(sorted(alive), key=lambda c: -t[c])[:2]
    m = pairwise(restrict(profile, set(top2)))
    a, b = top2
    return a if m[(a, b)] >= m[(b, a)] else b


def coombs(profile):
    """Eliminate whoever is ranked LAST by the most voters."""
    alive = set(candidates(profile))
    while len(alive) > 1:
        t = first_prefs(profile, alive)
        total = sum(t.values())
        for c in sorted(alive):
            if t[c] * 2 > total:
                return c
        last = {c: 0 for c in alive}
        for w, ranking in profile:
            tail = [c for c in ranking if c in alive]
            if tail:
                last[tail[-1]] += w
        alive.discard(max(sorted(alive), key=lambda c: last[c]))
    return sorted(alive)[0]


SINGLE_WINNER = {
    "Plurality": plurality,
    "Runoff": runoff,
    "IRV/RCV": irv,
    "Borda": borda,
    "Coombs": coombs,
    "Condorcet": condorcet,
}


def stv(profile, seats, quota="droop", transfer="gregory"):
    """Multi-winner STV, with the implementation choices the cartoon glosses over.

    quota:    droop = floor(V/(S+1))+1        hare = V/S
    transfer: gregory = fractional, ALL the winner's ballots move at reduced weight
              whole   = whole-ballot sample (deterministic stand-in for the random
                        draw several real jurisdictions actually use)
    """
    piles = [[Fraction(w), list(r)] for w, r in profile]
    total = sum(p[0] for p in piles)
    if quota == "droop":
        q = Fraction(int(total / (seats + 1)) + 1)
    elif quota == "hare":
        q = Fraction(total, seats)
    else:
        raise ValueError(quota)

    elected, alive = [], set(candidates(profile))

    def tally():
        t = {c: Fraction(0) for c in alive}
        for wt, r in piles:
            for c in r:
                if c in alive:
                    t[c] += wt
                    break
        return t

    while len(elected) < seats and alive:
        t = tally()
        over = [c for c in sorted(alive) if t[c] >= q]
        if over:
            c = max(over, key=lambda x: t[x])
            elected.append(c)
            alive.discard(c)
            if len(elected) == seats:
                break
            surplus = t[c] - q
            held = [p for p in piles
                    if next((x for x in p[1] if x in alive or x == c), None) == c]
            if surplus > 0 and held:
                if transfer == "gregory":
                    factor = surplus / t[c]
                    for p in held:
                        p[0] *= factor
                elif transfer == "whole":
                    remaining = surplus
                    for p in reversed(held):
                        if remaining <= 0:
                            p[0] = Fraction(0)
                        elif p[0] <= remaining:
                            remaining -= p[0]
                        else:
                            p[0] = remaining
                            remaining = Fraction(0)
                else:
                    raise ValueError(transfer)
            else:
                for p in held:
                    p[0] = Fraction(0)
            for p in piles:
                p[1] = [x for x in p[1] if x != c]
            continue

        if len(alive) + len(elected) <= seats:
            elected.extend(sorted(alive))
            break
        low = min(t.values())
        doomed = sorted([c for c in alive if t[c] == low])[-1]
        alive.discard(doomed)
        for p in piles:
            p[1] = [x for x in p[1] if x != doomed]

    return tuple(sorted(elected))


# ===========================================================================
# THE DOCUMENTED EXAMPLES -- all found by search, then pinned and re-verified.
# ===========================================================================

# [1] 111 voters. Six methods, FIVE different winners.
FIVE_WAY = [
    (16, ("C", "B", "E", "A", "D")),
    (12, ("C", "E", "D", "A", "B")),
    (12, ("E", "A", "D", "C", "B")),
    (22, ("A", "E", "B", "C", "D")),
    (30, ("D", "B", "E", "C", "A")),
    (19, ("B", "A", "C", "E", "D")),
]

# [2] ARROW/IIA + a Condorcet failure in one profile. 96 voters.
# IRV elects C. Delete A (a loser) and IRV elects B -- though no voter changed
# their B-vs-C ranking. B also beats everyone head-to-head.
IIA = [
    (40, ("A", "B", "C")),
    (37, ("C", "B", "A")),
    (19, ("B", "C", "A")),
]

# [3] Non-monotonicity. 67 voters. C wins; then 12 A-first voters PROMOTE C, and C loses.
MONO = [
    (18, ("B", "C", "A")),
    (12, ("C", "B", "A")),
    (8, ("C", "A", "B")),
    (29, ("A", "B", "C")),
]
MONO_RAISED = [
    (18, ("B", "C", "A")),
    (12, ("C", "B", "A")),
    (20, ("C", "A", "B")),
    (17, ("A", "B", "C")),
]

# [4] No-show paradox (Moulin). 118 voters elect C; 9 more turn up and elect A,
# which those 9 rank BELOW C. Verified tie-break-free in both counts.
NOSHOW_BASE = [
    (21, ("D", "A", "B", "C")),
    (33, ("C", "D", "A", "B")),
    (16, ("B", "D", "A", "C")),
    (21, ("C", "B", "D", "A")),
    (27, ("A", "B", "C", "D")),
]
NOSHOW_EXTRA = [(9, ("B", "D", "C", "A"))]

# [5] Gibbard-Satterthwaite. 100 voters; 6 of them bury their own favourite and win.
GS_SINCERE = [
    (35, ("Right", "Centre", "Left")),
    (33, ("Left", "Centre", "Right")),
    (32, ("Centre", "Left", "Right")),
]
GS_STRATEGIC = [
    (29, ("Right", "Centre", "Left")),
    (6, ("Centre", "Right", "Left")),
    (33, ("Left", "Centre", "Right")),
    (32, ("Centre", "Left", "Right")),
]

# [6] THE HEADLINE. 172 voters, 3 seats, four ordinary rule-sets, three councils.
STV_RULES = [
    (22, ("C", "B", "A", "D", "E")),
    (35, ("A", "B", "D", "E", "C")),
    (18, ("C", "B", "E", "A", "D")),
    (29, ("C", "E", "B", "D", "A")),
    (31, ("C", "E", "A", "B", "D")),
    (37, ("C", "B", "A", "E", "D")),
]

# [6a] Quota alone decides it (surplus rule held fixed).
QUOTA_ONLY = [
    (24, ("E", "C", "D", "A", "B")),
    (29, ("D", "B", "C", "A", "E")),
    (7, ("B", "C", "D", "E", "A")),
    (31, ("A", "B", "C", "E", "D")),
    (25, ("D", "A", "C", "B", "E")),
    (15, ("D", "C", "B", "E", "A")),
]

# [7] Majority-criterion failure. A holds an outright 60% first-preference majority
# and Borda elects B anyway. (Found by the selftest itself, as a failed sanity check.)
MAJORITY = [
    (60, ("A", "B", "C")),
    (40, ("B", "C", "A")),
]

# [6b] Surplus-transfer rule alone decides it (quota held fixed).
TRANSFER_ONLY = [
    (20, ("C", "B", "A", "E", "D")),
    (27, ("E", "D", "C", "A", "B")),
    (31, ("D", "E", "C", "B", "A")),
    (46, ("B", "E", "D", "A", "C")),
    (23, ("D", "A", "C", "E", "B")),
]


def _tie_free(profile):
    """True if no IRV round needs a tie-break, so the result is not an artefact."""
    alive = set(candidates(profile))
    while len(alive) > 1:
        t = first_prefs(profile, alive)
        total = sum(t.values())
        if any(v * 2 > total for v in t.values()):
            return True
        low = min(t.values())
        if sum(1 for v in t.values() if v == low) > 1:
            return False
        alive.discard(min(sorted(alive), key=lambda c: t[c]))
    return True


def _only_raised(before, after, cand):
    """Verify `after` differs from `before` ONLY by moving `cand` UP on some ballots."""
    def norm(prof):
        d = {}
        for w, r in prof:
            d[r] = d.get(r, 0) + w
        return d
    b, a = norm(before), norm(after)
    lost = {r: b[r] - a.get(r, 0) for r in b if b[r] > a.get(r, 0)}
    gained = {r: a[r] - b.get(r, 0) for r in a if a[r] > b.get(r, 0)}
    if not lost or not gained or sum(lost.values()) != sum(gained.values()):
        return False
    for lr in lost:
        for gr in gained:
            if tuple(x for x in gr if x != cand) != tuple(x for x in lr if x != cand):
                return False
            if gr.index(cand) >= lr.index(cand):
                return False
    return True


def search_five_way(seed=20260820, tries=400000):
    """Re-run the search that produced FIVE_WAY."""
    rng = random.Random(seed)
    perms = list(itertools.permutations(list("ABCDE")))
    for _ in range(tries):
        prof = [(rng.randint(8, 35), rng.choice(perms)) for _ in range(6)]
        winners = {}
        for name, fn in SINGLE_WINNER.items():
            w = fn(prof)
            if w is None:
                break
            winners[name] = w
        else:
            if len(set(winners.values())) >= 5:
                return prof, winners
    return None


def selftest():
    failures = []

    def check(label, cond, detail=""):
        if cond:
            print("  PASS  " + label)
        else:
            failures.append(label)
            print("  FAIL  " + label + "  " + str(detail))

    print()
    print("[1] One electorate, six methods, FIVE different winners")
    winners = {n: f(FIVE_WAY) for n, f in SINGLE_WINNER.items()}
    for n, w in winners.items():
        print("        %-10s -> %s" % (n, w))
    check("six methods produce five distinct winners",
          len(set(winners.values())) >= 5, winners)
    check("a Condorcet winner EXISTS (so 'no majority will' is not the excuse)",
          condorcet(FIVE_WAY) is not None)

    print()
    print("[2] ARROW / IIA: deleting a LOSER changes the winner")
    full = irv(IIA)
    trimmed = irv(restrict(IIA, {"B", "C"}))
    print("        A, B, C on the ballot -> %s" % full)
    print("        delete A (a loser)    -> %s" % trimmed)
    check("A really is a loser", full != "A", full)
    check("IIA violated: winner flips when an irrelevant alternative is deleted",
          full != trimmed, "%s vs %s" % (full, trimmed))
    check("same profile is ALSO a Condorcet failure: B beats all, C wins",
          condorcet(IIA) == "B" and full == "C",
          "condorcet=%s irv=%s" % (condorcet(IIA), full))

    print()
    print("[3] Non-monotonicity: RAISING the winner makes the winner LOSE")
    w0, w1 = irv(MONO), irv(MONO_RAISED)
    print("        original                      -> %s" % w0)
    print("        12 voters promote %s to first  -> %s" % (w0, w1))
    check("electorate size unchanged",
          sum(w for w, _ in MONO) == sum(w for w, _ in MONO_RAISED))
    check("C wins originally", w0 == "C", w0)
    check("the ONLY change is C moving UP on 12 ballots",
          _only_raised(MONO, MONO_RAISED, "C"))
    check("promoting C costs C the win", w1 != w0, "%s -> %s" % (w0, w1))

    print()
    print("[4] No-show paradox (Moulin): turning out makes these voters WORSE off")
    without = irv(NOSHOW_BASE)
    with_them = irv(NOSHOW_BASE + NOSHOW_EXTRA)
    pref = NOSHOW_EXTRA[0][1]
    print("        they abstain -> %s" % without)
    print("        they vote    -> %s" % with_them)
    print("        their sincere ranking: %s" % " > ".join(pref))
    check("outcome changes when they show up", without != with_them)
    check("they PREFER the outcome they get by ABSTAINING",
          pref.index(without) < pref.index(with_them),
          "%s vs %s under %s" % (without, with_them, pref))
    check("no tie-break used in either count (not an artefact)",
          _tie_free(NOSHOW_BASE) and _tie_free(NOSHOW_BASE + NOSHOW_EXTRA))

    print()
    print("[5] GIBBARD-SATTERTHWAITE: insincere ranking pays")
    sincere, strategic = irv(GS_SINCERE), irv(GS_STRATEGIC)
    print("        everyone sincere                    -> %s" % sincere)
    print("        6 Right voters bury their favourite -> %s" % strategic)
    check("the manipulation changes the winner", sincere != strategic)
    check("manipulators prefer the new winner (Right ranks Centre above Left)",
          sincere == "Left" and strategic == "Centre",
          "%s -> %s" % (sincere, strategic))
    check("electorate size unchanged",
          sum(w for w, _ in GS_SINCERE) == sum(w for w, _ in GS_STRATEGIC))

    print()
    print("[6] THE HEADLINE: identical ballots, four ordinary rule-sets, 3 seats")
    combos = {}
    for q in ("droop", "hare"):
        for tr in ("gregory", "whole"):
            combos[(q, tr)] = stv(STV_RULES, 3, q, tr)
            print("        quota=%-6s surplus=%-8s -> %s" % (q, tr, combos[(q, tr)]))
    check("ordinary rule choices elect DIFFERENT councils from identical ballots",
          len(set(combos.values())) >= 3, combos)

    print()
    print("[6a] QUOTA alone decides it (surplus rule fixed at Gregory)")
    a, b = stv(QUOTA_ONLY, 3, "droop", "gregory"), stv(QUOTA_ONLY, 3, "hare", "gregory")
    print("        Droop quota -> %s" % (a,))
    print("        Hare  quota -> %s" % (b,))
    check("changing ONLY the quota changes the council", a != b, "%s vs %s" % (a, b))

    print()
    print("[6b] SURPLUS-TRANSFER rule alone decides it (quota fixed at Droop)")
    c = stv(TRANSFER_ONLY, 3, "droop", "gregory")
    d = stv(TRANSFER_ONLY, 3, "droop", "whole")
    print("        Gregory (fractional) -> %s" % (c,))
    print("        Whole-ballot sample  -> %s" % (d,))
    check("changing ONLY the surplus rule changes the council", c != d,
          "%s vs %s" % (c, d))

    print()
    print("[7] Majority-criterion failure: Borda overrides an outright majority")
    print("        60 voters: A > B > C")
    print("        40 voters: B > C > A")
    for n, f in SINGLE_WINNER.items():
        print("        %-10s -> %s" % (n, f(MAJORITY)))
    check("A holds an outright first-preference majority (60 of 100)",
          first_prefs(MAJORITY, set(candidates(MAJORITY)))["A"] * 2
          > sum(w for w, _ in MAJORITY))
    check("Borda elects B anyway (majority criterion violated)",
          borda(MAJORITY) == "B", borda(MAJORITY))
    check("every OTHER method respects the majority",
          all(f(MAJORITY) == "A" for n, f in SINGLE_WINNER.items() if n != "Borda"))

    print()
    print("[8] Sanity: unanimity is respected by everything")
    unan = [(10, ("A", "B", "C"))]
    check("all methods elect a unanimous favourite",
          all(f(unan) == "A" for f in SINGLE_WINNER.values()))

    print()
    if failures:
        print("SELFTEST FAILED: %d claim(s) no longer hold -> %s"
              % (len(failures), failures))
        return 1
    print("SELFTEST PASSED: every documented claim re-derived from the ballots.")
    return 0


def report():
    bar = "=" * 74
    print(bar)
    print("TABLE 1 -- one electorate, six methods, five winners (%d voters)"
          % sum(w for w, _ in FIVE_WAY))
    print(bar)
    for w, r in FIVE_WAY:
        print("  %3d voters:  %s" % (w, " > ".join(r)))
    print()
    for n, f in SINGLE_WINNER.items():
        print("  %-12s elects %s" % (n, f(FIVE_WAY)))

    print()
    print(bar)
    print("TABLE 2 -- STV under four ordinary implementation choices "
          "(3 seats, %d voters)" % sum(w for w, _ in STV_RULES))
    print(bar)
    for w, r in STV_RULES:
        print("  %3d voters:  %s" % (w, " > ".join(r)))
    print()
    for q in ("droop", "hare"):
        for tr in ("gregory", "whole"):
            print("  quota=%-6s surplus=%-8s -> council %s"
                  % (q, tr, stv(STV_RULES, 3, q, tr)))

    print()
    print(bar)
    print("TABLE 3 -- IRV round by round on the Arrow/IIA profile")
    print(bar)
    w, rounds = irv(IIA, trace=True)
    for i, r in enumerate(rounds, 1):
        print("  round %d: %s"
              % (i, ", ".join("%s=%s" % kv for kv in sorted(r.items()))))
    print("  IRV winner: %s   Condorcet winner: %s   Condorcet loser: %s"
          % (w, condorcet(IIA), condorcet_loser(IIA)))
    print("  delete A (a loser) and IRV elects: %s"
          % irv(restrict(IIA, {"B", "C"})))


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--selftest", action="store_true")
    ap.add_argument("--report", action="store_true")
    ap.add_argument("--search", action="store_true")
    args = ap.parse_args()
    if args.search:
        print("search result:", search_five_way())
        return 0
    if args.report:
        report()
        return 0
    return selftest()


if __name__ == "__main__":
    raise SystemExit(main())
