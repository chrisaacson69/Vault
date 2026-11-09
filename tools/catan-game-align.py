#!/usr/bin/env python3
"""
catan-game-align.py — does a player's winning path match what the board made cheap?

Reads hand-transcribed expert Catan games (one JSON file each) and compares
each board's prices (from catan-board-supply.py, reused, not re-implemented)
with how each player actually scored.

Design (research/gaming/sim-channels/catan.md, "Verifying it needs expert
human games"):
  1. board  -> prices -> board tilt: is the city/dev side cheap or dear here?
  2. player -> realized path tilt from the final VP breakdown
  3. control: do players whose path MATCHES the board's tilt win more often
     than players whose path doesn't? Board tilt is shared by everyone at the
     table, so the comparison is between players facing the same board. That
     is the control the 50-game Kaggle run lacked (it saw only the tiles
     players picked, never the board they picked from).

Tilts
-----
  board tilt  = log(median_ratio / ratio), ratio = price(city)/price(settlement)
                on this board; median_ratio = 1.36 over random boards.
                > 0: cities cheaper than usual (city board); < 0: settlement board.
  path tilt   = (city-side VP - expansion-side VP) / total VP, where
                city side      = 2*cities + 2*largest_army + vp_cards
                expansion side = settlements + 2*longest_road
                > 0: won/scored through cities and dev cards; < 0: through land.
  aligned     = board tilt and path tilt have the same sign (|board tilt| <
                0.05 is "neutral" and excluded from the aligned/unaligned split).

Record format: see raw/datasets/catan-expert/TEMPLATE.json. Numbers are
transcribed from a source; never fill a field you could not read — use null
and the analyzer will skip what it can't compute.

Usage
-----
  py -3 tools/catan-game-align.py raw/datasets/catan-expert/
  py -3 tools/catan-game-align.py --selftest
"""
import importlib.util
import json
import math
import pathlib
import sys

_here = pathlib.Path(__file__).resolve().parent
_spec = importlib.util.spec_from_file_location("supply", _here / "catan-board-supply.py")
supply = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(supply)

MEDIAN_RATIO = 1.36   # catan-board-supply.py --sample 200000 (seed 1), 2026-11-09
NEUTRAL = 0.05


def board_supply(board):
    s = {r: 0 for r in supply.RES}
    for hexx in board:
        if hexx["resource"] == "desert":
            continue
        s[hexx["resource"]] += supply.PIPS[hexx["token"]]
    return s


def validate_board(board):
    counts = {}
    for h in board:
        counts[h["resource"]] = counts.get(h["resource"], 0) + 1
    want = dict(supply.TILES, desert=1)
    if counts != want:
        return f"tile counts {counts} != standard {want}"
    toks = sorted(h["token"] for h in board if h["resource"] != "desert")
    if toks != sorted(supply.TOKENS):
        return f"tokens {toks} != standard set"
    return None


def board_tilt(board):
    p = supply.prices(board_supply(board))
    return math.log(MEDIAN_RATIO / (p["city"] / p["settlement"])), p


def vp(f):
    return (f["settlements"] + 2 * f["cities"] + 2 * bool(f["longest_road"])
            + 2 * bool(f["largest_army"]) + f["vp_cards"])


def path_tilt(f):
    city = 2 * f["cities"] + 2 * bool(f["largest_army"]) + f["vp_cards"]
    land = f["settlements"] + 2 * bool(f["longest_road"])
    tot = city + land
    return (city - land) / tot if tot else 0.0


def analyse(games, out=print):
    rows = []
    for name, g in games:
        err = validate_board(g["board"])
        if err:
            out(f"[skip] {name}: {err}")
            continue
        bt, p = board_tilt(g["board"])
        kind = "city" if bt > NEUTRAL else "settlement" if bt < -NEUTRAL else "neutral"
        out(f"\n{name}  ({g.get('source', {}).get('url', 'no source')})")
        out(f"  supply {board_supply(g['board'])}")
        out(f"  city/settlement price {p['city']/p['settlement']:.2f} -> board tilt {bt:+.2f} ({kind} board)")
        for pl in g["players"]:
            f = pl["final"]
            if any(f.get(k) is None for k in ("settlements", "cities", "longest_road", "largest_army", "vp_cards")):
                out(f"  {pl['name']:14} incomplete final breakdown, skipped")
                continue
            pt = path_tilt(f)
            al = None if kind == "neutral" else (pt > 0) == (bt > 0)
            rows.append({"won": bool(pl.get("winner")), "aligned": al})
            out(f"  {pl['name']:14} VP {vp(f):2}  path tilt {pt:+.2f}  "
                f"{'aligned' if al else 'unaligned' if al is False else 'n/a'}"
                f"{'  WINNER' if pl.get('winner') else ''}")
    out("\n=== aggregate ===")
    for label, val in (("aligned", True), ("unaligned", False)):
        grp = [r for r in rows if r["aligned"] is val]
        w = sum(r["won"] for r in grp)
        rate = f"{w/len(grp):.1%}" if grp else "n/a"
        out(f"  {label:9} players {len(grp):3}  wins {w:3}  win rate {rate}")
    n_games = len({n for n, _ in games})
    out(f"  games {n_games}; neutral-board players excluded: {sum(r['aligned'] is None for r in rows)}")
    if n_games < 30:
        out("  (small N: a per-game readout, not evidence yet)")
    return rows


def load(path):
    p = pathlib.Path(path)
    files = sorted(p.glob("*.json")) if p.is_dir() else [p]
    return [(f.stem, json.loads(f.read_text(encoding="utf-8")))
            for f in files if f.name != "TEMPLATE.json"]


def selftest():
    # SYNTHETIC board, built only to exercise the code — not a real game.
    ore_rich = ([{"resource": "ore", "token": t} for t in (6, 8, 5)]
                + [{"resource": "brick", "token": t} for t in (2, 12, 3)]
                + [{"resource": "wheat", "token": t} for t in (6, 8, 9, 4)]
                + [{"resource": "wood", "token": t} for t in (3, 11, 10, 4)]
                + [{"resource": "sheep", "token": t} for t in (5, 9, 10, 11)]
                + [{"resource": "desert", "token": None}])
    assert validate_board(ore_rich) is None
    assert sum(board_supply(ore_rich).values()) == 58
    bt, _ = board_tilt(ore_rich)
    assert bt > NEUTRAL, bt                      # ore-rich, brick-poor -> city board
    city_f = {"settlements": 2, "cities": 3, "longest_road": False, "largest_army": True, "vp_cards": 0}
    land_f = {"settlements": 5, "cities": 1, "longest_road": True, "largest_army": False, "vp_cards": 0}
    assert vp(city_f) == 10 and vp(land_f) == 9
    assert path_tilt(city_f) > 0 > path_tilt(land_f)
    g = {"board": ore_rich, "players": [
        {"name": "A", "winner": True, "final": city_f},
        {"name": "B", "final": land_f}]}
    rows = analyse([("synthetic", g)], out=lambda *_: None)
    assert rows == [{"won": True, "aligned": True}, {"won": False, "aligned": False}]
    bad = ore_rich[:-1] + [{"resource": "ore", "token": None}]
    assert validate_board(bad)
    print("selftest ok")


if __name__ == "__main__":
    if len(sys.argv) > 1 and sys.argv[1] == "--selftest":
        selftest()
    elif len(sys.argv) > 1:
        analyse(load(sys.argv[1]))
    else:
        sys.exit(__doc__)
