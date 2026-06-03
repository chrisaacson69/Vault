#!/usr/bin/env py -3
"""walk_guard.py — the shared regen-guard for the *-walk-apply.py root-writers.

Both label-walk-apply.py and var-walk-apply.py end their batch by REGEN-ing the
decompiled C and asserting the diff is benign: only the expected file(s) changed,
and every change is a PURE RENAME (identifier swap, zero logic/structure churn).
This module is the single source of that check so the two siblings can't DRIFT
apart again — label-walk's old guard diffed vs **git HEAD** (false-positives on a
dirty tree) with a bank-NN-only allow-set (would trip on the legitimate all_banks.c
change); var-walk's snapshot-vs-pre-regen guard fixed both. Now they share it.
See [[feedback_drift_is_rederivation]] (cure = one artifact) / SKILL.md.

Contract: snapshot decompiled/*.c BEFORE regen, regen, then
`find_guard_violations(before, after, allowed)`:
  - `others`    = changed files OUTSIDE the allow-set (cross-bank bleed — a label/var
                  name leaked into another bank's file). MUST be empty.
  - `nonrename` = allowed files whose change is NOT a pure rename (logic/structure
                  changed). MUST be empty.
The rename test collapses every identifier to `ID` on each non-comment line and
compares the line SEQUENCE (order-preserving) — a pure rename normalizes to the
identical sequence; any added/removed/reordered logic line survives.
"""
import re
from pathlib import Path


def snapshot_decompiled(decompiled_dir):
    """{filename: text} for every decompiled/*.c. Take this BEFORE regen so the guard
    compares against the actual pre-batch state, not git HEAD (robust to a dirty tree:
    unrelated uncommitted regens don't register as this batch's changes)."""
    return {p.name: p.read_text(encoding="utf-8")
            for p in Path(decompiled_dir).glob("*.c")}


def norm_lines(text):
    """Non-comment lines with every identifier collapsed to 'ID' — so a pure rename
    normalizes to the IDENTICAL line sequence (order preserved; logic changes survive)."""
    out = []
    for ln in text.splitlines():
        s = ln.strip()
        if s.startswith("//"):
            continue
        out.append(re.sub(r"[A-Za-z_]\w*", "ID", s))
    return out


def find_guard_violations(before, after, allowed):
    """Compare two snapshots. Returns (others, nonrename):
      others    = sorted changed files NOT in `allowed` (cross-bank bleed).
      nonrename = sorted changed files in `allowed` whose change isn't a pure rename.
    Both empty == clean guard."""
    allowed = set(allowed)
    changed = {n for n in set(before) | set(after) if before.get(n) != after.get(n)}
    others = sorted(changed - allowed)
    nonrename = [n for n in sorted(changed & allowed)
                 if norm_lines(before.get(n, "")) != norm_lines(after.get(n, ""))]
    return others, nonrename
