#!/usr/bin/env python3
"""
open-questions.py — derive an open-questions registry from the pages' `## Open Questions` sections.

The failure this fixes (Vault/CLAUDE.md, "Check the open questions before treating anything as new"):
questions get re-asked, or answered elsewhere, without anyone noticing, because the only way to match
them was grep. Modelled on REA's `record_unknown` / `update_unknown` (research/reverse-engineering/
rea-candidate-tool.md) — but DERIVED: pages stay the source of truth, notes/open-questions.md is a pure
function of them, like tags/_index.md via tag-counts.py.

Convention read from the pages (already in use, nothing new to learn):
  - an item under a heading starting "Open Questions" is a question;
  - it is RESOLVED when the question is struck through — `~~question~~ resolution note` — or starts
    with ✅; everything else (including "MOSTLY RESOLVED") is OPEN;
  - it is MOVED when it starts with ↪ — a re-ask replaced by a pointer to the one home that tracks it
    (`- ↪ **label** → [home](…)`); a moved item is neither open nor paired;
  - two items never pair as a re-ask when either already links to the other's page: linking is the fix;
  - links in the note are "resolved by"; the first YYYY-MM-DD in the note is the resolution date.

ID = first 6 hex of sha1(question text with markup stripped), so striking a question through to
resolve it keeps its ID. Rewording makes a new ID. No revision counter: git is the revision log.

The mechanical part costs no tokens. Deciding whether a finding actually answers a question is
inference — `--find` narrows that to ten candidates instead of a thousand.

  py -3 tools/open-questions.py               # report; exit 1 if the registry is stale
  py -3 tools/open-questions.py --write       # regenerate notes/open-questions.md
  py -3 tools/open-questions.py --find TEXT   # rank questions (open + resolved) against TEXT
"""
import hashlib
import itertools
import math
import posixpath
import re
import sys
import urllib.parse
from pathlib import Path

VAULT = Path(__file__).resolve().parent.parent
OUT = VAULT / "notes" / "open-questions.md"
EXCLUDE = {"raw", "logs", ".claude", ".git", ".obsidian", "node_modules", "_site"}

HEAD = re.compile(r"^(#+)\s*Open Questions\b", re.I)
ITEM = re.compile(r"^(?:[-*]|\d+\.)\s+(.*)$")
STRUCK = re.compile(r"^(?:\*\*)?~~(.+?)~~(?:\*\*)?\s*(.*)$")
LINK = re.compile(r"\[([^\]]*)\]\(([^)]*)\)")
DATE = re.compile(r"\b20\d\d-\d\d-\d\d\b")
# Says it's closed: an all-caps verdict, or the word right after a dash/bold/paren ("— resolved 2026-…").
# A plain "how did it dissolve?" inside the question is not a verdict.
SAYS_RESOLVED = re.compile(r"\b(?:RESOLVED|ANSWERED|DISSOLVED)\b"
                           r"|(?:[—–(]|\*\*)\s*(?:now\s+)?(?:\w+\s+)?(?:[Rr]esolved|[Aa]nswered|[Dd]issolved)\b")
NOT_RESOLVED = re.compile(r"\b(unresolved|not (?:yet )?(?:resolved|answered)|half|partly|partially|mostly|largely|substantially)\b", re.I)
STOP = set("""the a an of to and or is in it that this for on be as are does do can what how why with by
not at from its which if there was would should could vs than into any more one has have his her their
they them you your our but when who whom will just also only about still same other""".split())
DUP_MIN = 0.30   # Jaccard over question tokens; 0.3 was where real re-asks stopped dominating (2026-10-16)


def plain(t):
    t = LINK.sub(r"\1", t)
    t = re.sub(r"[*_`~>]", "", t)
    return re.sub(r"\s+", " ", t).strip()


def stem(w):
    return w[:-1] if len(w) > 4 and w.endswith("s") and not w.endswith("ss") else w


def tokens(t):
    return {stem(w) for w in re.findall(r"[a-z][a-z0-9-]{2,}", plain(t).lower()) if w not in STOP}


def summary(q, n=150):
    m = re.match(r"^\s*\*\*(.+?)\*\*", q)          # bold lead, the vault's usual question form
    s = plain(m.group(1) if m else q)
    return s if len(s) <= n else s[: n - 1].rstrip() + "…"


def page_title(text, path):
    m = re.search(r'^title:\s*"?(.*?)"?\s*$', text, re.M) or re.search(r"^#\s+(.+)$", text, re.M)
    return plain(m.group(1)) if m else path.stem


def scan():
    qs, titles = [], {}
    for p in sorted(VAULT.rglob("*.md")):
        rel = p.relative_to(VAULT)
        if rel.parts[0] in EXCLUDE or p == OUT:
            continue
        text = p.read_text(encoding="utf-8", errors="replace")
        lines, i = text.splitlines(), 0
        while i < len(lines):
            m = HEAD.match(lines[i])
            i += 1
            if not m:
                continue
            stop, cur = re.compile(r"^#{1,%d}\s" % len(m.group(1))), None
            while i < len(lines) and not stop.match(lines[i]):
                s, mi = lines[i], ITEM.match(lines[i])
                if mi:
                    cur = {"page": rel.as_posix(), "line": i + 1, "raw": mi.group(1)}
                    qs.append(cur)
                elif cur and s[:1] in (" ", "\t") and s.strip():
                    cur["raw"] += " " + s.strip()          # continuation line or nested sub-bullet
                elif s.strip():
                    cur = None                             # prose paragraph ends the item
                i += 1
            titles[rel.as_posix()] = page_title(text, p)
    for q in qs:
        body = re.sub(r"^✅\s*", "", q["raw"].strip())
        m = STRUCK.match(body)
        if body.startswith("↪"):
            q.update(status="moved", q=body.lstrip("↪ "), note=body)
        elif m:
            q.update(status="resolved", q=m.group(1), note=m.group(2))
        else:
            q.update(status="resolved" if q["raw"].lstrip().startswith("✅") else "open", q=body, note="")
        q["tok"] = tokens(q["q"])
        q["all"] = tokens(q["q"] + " " + q["note"] + " " + titles.get(q["page"], ""))
        q["links"] = [u for _, u in LINK.findall(q["note"])]
        q["linked"] = {linked_page(q["page"], u) for _, u in LINK.findall(q["raw"])}
        d = DATE.search(q["note"])
        q["date"] = d.group(0) if d else ""
    seen = {}
    for q in qs:                                         # stable, unique IDs; exact repeats get -2, -3
        base = hashlib.sha1(plain(q["q"]).lower().encode("utf-8")).hexdigest()[:6]
        seen[base] = seen.get(base, 0) + 1
        q["id"] = base if seen[base] == 1 else f"{base}-{seen[base]}"
    return qs, titles


def linked_page(page, url):
    path = urllib.parse.unquote(url.split("#")[0])
    return posixpath.normpath(posixpath.join(posixpath.dirname(page), path)) if path else page


def jaccard(a, b):
    return len(a & b) / len(a | b) if a and b else 0.0


def pairs(qs):
    """Cross-page near-duplicates: open/open = possible re-ask; open/resolved = possibly answered."""
    cand = [q for q in qs if len(q["tok"]) >= 4 and q["status"] != "moved"]
    out = []
    for a, b in itertools.combinations(cand, 2):
        if a["page"] == b["page"] or (a["status"] == b["status"] == "resolved")                 or b["page"] in a["linked"] or a["page"] in b["linked"]:
            continue
        j = jaccard(a["tok"], b["tok"])
        if j >= DUP_MIN:
            if a["status"] == "resolved":
                a, b = b, a
            out.append((j, a, b))
    out.sort(key=lambda x: (-x[0], x[1]["page"], x[1]["line"]))
    return out


def lint(qs):
    drift = [q for q in qs if q["status"] == "open" and SAYS_RESOLVED.search(q["q"]) and not NOT_RESOLVED.search(q["q"])]
    unlinked = [q for q in qs if q["status"] == "resolved" and not q["links"]]
    return drift, unlinked


def href(page):
    return "../" + page.replace(" ", "%20")


def ref(q, titles):
    return f"[{titles.get(q['page'], q['page'])}]({href(q['page'])}) L{q['line']}"


def render(qs, titles):
    op = [q for q in qs if q["status"] == "open"]
    rs = [q for q in qs if q["status"] == "resolved"]
    pr = pairs(qs)
    drift, unlinked = lint(qs)
    L = [
        "---",
        "published: false",
        'title: "Open Questions Registry"',
        "---",
        "# Open Questions Registry",
        "> **GENERATED by [`tools/open-questions.py`](../tools/open-questions.py) — do not edit.** Edit the page that asks"
        " the question, then run `py -3 tools/open-questions.py --write`. Before filing a finding or a question as new,"
        " run `--find \"…\"` against it (see [Vault/CLAUDE.md](../CLAUDE.md), *Check the open questions*).",
        "",
        "**Resolve a question in place:** strike it through and say where it was answered —"
        " `- ~~question~~ **Resolved YYYY-MM-DD** → [page](…)`. The ID survives the strike-through.",
        "",
        f"**{len(qs)} questions on {len({q['page'] for q in qs})} pages — {len(op)} open, {len(rs)} resolved,"
        f" {len(qs) - len(op) - len(rs)} moved.**"
        f" {sum(1 for _, a, b in pr if b['status'] == 'resolved')} possibly answered elsewhere,"
        f" {sum(1 for _, a, b in pr if b['status'] == 'open')} possible re-asks, {len(drift)} marker drifts,"
        f" {len(unlinked)} resolved without a link.",
        "",
    ]

    def pair_block(title, blurb, rows):
        L.extend([f"## {title}", f"> {blurb}", ""])
        if not rows:
            L.append("- none")
        for j, a, b in rows:
            L.append(f"- **{j:.2f}** `{a['id']}` {ref(a, titles)} — {summary(a['q'], 110)}")
            L.append(f"  - `{b['id']}` {ref(b, titles)} — {summary(b['q'], 110)}")
        L.append("")

    pair_block("Possibly answered elsewhere", "An open question worded like a question resolved on another page."
               " Read both; if it's answered, strike it through and link the answer.",
               [p for p in pr if p[2]["status"] == "resolved"])
    pair_block("Possible re-asks", "Two open questions on different pages with overlapping wording"
               f" (Jaccard ≥ {DUP_MIN}). Pick one home and link the other to it.",
               [p for p in pr if p[2]["status"] == "open"])

    L.extend(["## Marker drift", "> Says resolved/answered in its text but isn't struck through, so it counts as open.", ""])
    L.extend([f"- `{q['id']}` {ref(q, titles)} — {summary(q['q'], 110)}" for q in drift] or ["- none"])
    L.extend(["", "## Resolved", "> Newest first. *(no link)* = the note doesn't say where it was answered.", ""])
    for q in sorted(rs, key=lambda q: (q["date"] or "0000", q["page"], q["line"]), reverse=True):
        tail = f" *({q['date']})*" if q["date"] else ""
        L.append(f"- `{q['id']}` {ref(q, titles)} — {summary(q['q'], 110)}{tail}" + ("" if q["links"] else " *(no link)*"))
    L.extend(["", "## Open, by page", ""])
    last = None
    for q in op:
        if q["page"] != last:
            if last is not None:
                L.append("")
            L.append(f"### [{titles.get(q['page'], q['page'])}]({href(q['page'])})")
            last = q["page"]
        L.append(f"- `{q['id']}` L{q['line']} — {summary(q['q'])}")
    L.append("")
    return "\n".join(L)


def find(qs, text, n=10):
    """Rank by the share of the query's IDF weight each question (+ its note and page title) covers."""
    t = tokens(text)
    if not t:
        print("no searchable words in query")
        return 1
    df = {w: sum(1 for q in qs if w in q["all"]) for w in t}
    idf = {w: math.log((len(qs) + 1) / (df[w] + 1)) + 1 for w in t}
    total = sum(idf.values())
    scored = sorted(((sum(idf[w] for w in t & q["all"]) / total, -len(q["all"]), q) for q in qs),
                    key=lambda x: (-x[0], -x[1]))
    for cover, _, q in [s for s in scored if s[0] > 0][:n]:
        print(f"{cover:4.2f}  {q['id']:8} {q['status']:8} {q['page']}:{q['line']}\n      {summary(q['q'], 140)}")
    return 0


def main():
    args = sys.argv[1:]
    qs, titles = scan()
    if "--find" in args:
        i = args.index("--find")
        return find(qs, " ".join(args[i + 1:]))
    new = render(qs, titles)
    old = OUT.read_text(encoding="utf-8") if OUT.exists() else ""
    op = sum(1 for q in qs if q["status"] == "open")
    pr = pairs(qs)
    drift, unlinked = lint(qs)
    rs = sum(1 for q in qs if q["status"] == "resolved")
    print(f"{len(qs)} questions: {op} open, {rs} resolved, {len(qs) - op - rs} moved")
    print(f"  {sum(1 for p in pr if p[2]['status'] == 'resolved')} possibly answered elsewhere, "
          f"{sum(1 for p in pr if p[2]['status'] == 'open')} possible re-asks, "
          f"{len(drift)} marker drift, {len(unlinked)} resolved without link")
    stale = new != old
    print(f"registry {'stale' if stale else 'up to date'}" + (" — writing" if stale and "--write" in args else ""))
    if "--write" in args:
        if stale:
            OUT.write_text(new, encoding="utf-8")
        return 0
    return 1 if stale else 0


if __name__ == "__main__":
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8")
    sys.exit(main())
