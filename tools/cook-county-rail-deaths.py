#!/usr/bin/env python3
"""How does the Cook County Medical Examiner classify deaths by train?

Research query backing Reading Outcome Statistics #3 (official categories bend
with their consequences) and the Lazy Law suicide-measurement thread. It
answers "were any of these ever ruled an accident?" with the office's own
records, so the page's numbers can be re-derived instead of trusted.

Source: Cook County Medical Examiner Case Archive (Socrata dataset cjeq-bs86),
https://datacatalog.cookcountyil.gov/resource/cjeq-bs86.json

Two definitions of a rail death, and why both are reported:
  * TAG  -- transportation_related_type == 'Train'. This is the office's own flag,
            but it was applied unevenly in 2015-16: train suicides were tagged
            while many train accidents were not. That makes the tagged series
            show a spurious drop in the suicide share after 2016.
  * TEXT -- the whole word TRAIN(S) in the primary-cause fields, OR the tag.
            This is independent of tagging practice. A substring match is wrong
            because "RESTRAINT" and "STRAIN" contain "TRAIN".

Pitfall worth keeping: SoQL follows SQL three-valued logic, so
"NOT (secondarycause LIKE ...)" silently drops rows where the field is NULL.
Only about 5% of rail deaths have a secondary cause recorded, so intoxication
cannot be tested from the public fields.

Usage:  py -3 tools/cook-county-rail-deaths.py [--city "DES PLAINES"]
"""
import argparse
import json
import re
import urllib.parse
import urllib.request

BASE = "https://datacatalog.cookcountyil.gov/resource/cjeq-bs86.json"
CAUSE_FIELDS = ("primarycause", "primarycause_linea", "primarycause_lineb")
WORD = re.compile(r"\bTRAINS?\b")


def query(**params):
    url = BASE + "?" + urllib.parse.urlencode(params)
    with urllib.request.urlopen(url, timeout=60) as r:
        return json.load(r)


def rail_rows():
    where = " OR ".join("upper(%s) like '%%TRAIN%%'" % f for f in CAUSE_FIELDS)
    where = "(%s) OR transportation_related_type = 'Train'" % where
    cols = "incident_date, manner, age, gender, incident_city, incident_street, " \
           "transportation_related_type, transportation_status, secondarycause, " + ", ".join(CAUSE_FIELDS)
    rows = query(**{"$select": cols, "$where": where, "$limit": 10000})
    out = []
    for r in rows:
        text = " ".join(r.get(f, "") for f in CAUSE_FIELDS).upper()
        if WORD.search(text) or r.get("transportation_related_type") == "Train":
            out.append(r)
    return out


def share(rows, years):
    s = sum(1 for r in rows if r.get("manner") == "SUICIDE" and r["_y"] in years)
    a = sum(1 for r in rows if r.get("manner") == "ACCIDENT" and r["_y"] in years)
    return s, a, (100.0 * s / (s + a)) if s + a else float("nan")


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--city", default="DES PLAINES", help="city for the case list (default: DES PLAINES)")
    args = ap.parse_args()

    rows = [r for r in rail_rows() if "2014" <= (r.get("incident_date") or "")[:4] <= "2099"]
    for r in rows:
        r["_y"] = r["incident_date"][:4]
        r["_tag"] = r.get("transportation_related_type") == "Train"
    years = sorted({r["_y"] for r in rows})

    print("Rail deaths, Cook County ME, %s-%s (TEXT definition): %d cases" % (years[0], years[-1], len(rows)))
    print("year  suicide accident undetermined homicide | suicide share of S+A  (TAG-only share)")
    for y in years:
        yr = [r for r in rows if r["_y"] == y]
        c = {m: sum(1 for r in yr if r.get("manner") == m) for m in ("SUICIDE", "ACCIDENT", "UNDETERMINED", "HOMICIDE")}
        tag = [r for r in yr if r["_tag"]]
        ts = sum(1 for r in tag if r.get("manner") == "SUICIDE")
        ta = sum(1 for r in tag if r.get("manner") == "ACCIDENT")
        s, a = c["SUICIDE"], c["ACCIDENT"]
        print("%s  %7d %8d %12d %8d | %5.0f%%   (%3.0f%%)" % (
            y, s, a, c["UNDETERMINED"], c["HOMICIDE"],
            100.0 * s / max(1, s + a), 100.0 * ts / max(1, ts + ta)))
    s, a, p = share(rows, set(years))
    print("TOTAL: suicide %d, accident %d -> suicide share %.0f%%" % (s, a, p))

    etoh = [r for r in rows if re.search(r"ETHANOL|ALCOHOL", (r.get("secondarycause") or "").upper())]
    with_sec = [r for r in rows if r.get("secondarycause")]
    print("\nSecondary cause recorded: %d of %d. Ethanol/alcohol listed: %d, by manner: %s" % (
        len(with_sec), len(rows), len(etoh),
        {m: sum(1 for r in etoh if r.get("manner") == m) for m in sorted({r.get("manner") for r in etoh})}))

    city = [r for r in rows if (r.get("incident_city") or "").upper() == args.city.upper()]
    print("\n%s case list (%d):" % (args.city.upper(), len(city)))
    for r in sorted(city, key=lambda r: r["incident_date"]):
        print("  %s  %-12s age %-3s %-6s %-40s %s" % (
            r["incident_date"][:10], r.get("manner"), r.get("age", "?"), r.get("gender", "?"),
            (r.get("incident_street") or "")[:40], r.get("transportation_status") or ""))


if __name__ == "__main__":
    main()
