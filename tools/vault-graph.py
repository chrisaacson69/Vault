#!/usr/bin/env python3
"""
vault-graph.py — the derive-the-ledger audit gate.

Implements the deterministic half of method/author-web-derive-hierarchy.md:
keep the vault write-optimized (a web of forward links) and let a tool DERIVE the
read-optimized checks instead of auditing by hand. Scans the markdown link graph and
reports, with ZERO false-positive intent:

  [HARD]  Broken links          — a link whose target file/dir does not exist.
  [HARD]  Ledger non-reciprocity — a page's "...ledger..." section names an in-vault
                                   specimen that does NOT link back (the two-way-ledger
                                   rot this whole reorg was about, now checked by machine).
  [warn]  Orphans               — research/method/notes pages with no inbound link.

Exit code 0 = no HARD violations (usable as a pre-commit gate); 1 = violations.

Run:  py -3 tools/vault-graph.py
Convention it keys on: thesis pages put their specimens under a heading containing the
word "ledger" (e.g. "## Evidence ledger", "## Downward ledger"). That marker is what
makes the specimen<->thesis edge machine-derivable rather than guessed.
"""
import re
import sys
from pathlib import Path
from urllib.parse import unquote

VAULT = Path(__file__).resolve().parent.parent
EXCLUDE = {".git", "node_modules", ".obsidian", ".claude", "raw"}
# Meta/template files carry illustrative placeholder links by design, not real edges.
EXCLUDE_FILES = {"CLAUDE.md", "INSTRUCTIONS.md"}
ROOTS = {"INDEX.md", "README.md", "MEMORY.md", "index.md"}

LINK = re.compile(r"\[[^\]]*\]\(([^)]+)\)")
LEDGER_HDR = re.compile(r"^#{2,4}\s+.*ledger.*$", re.IGNORECASE | re.MULTILINE)
ANY_HDR = re.compile(r"^#{1,4}\s", re.MULTILINE)


def md_files():
    out = []
    for p in VAULT.rglob("*.md"):
        if any(part in EXCLUDE for part in p.relative_to(VAULT).parts):
            continue
        if p.name in EXCLUDE_FILES or p.name.startswith("_"):
            continue
        out.append(p.resolve())
    return out


def clean_target(t):
    t = t.split("#")[0].split("?")[0].strip()
    if not t or "://" in t or t.startswith("mailto:"):
        return None
    # URL-decode (%20 -> space): a percent-encoded space is a VALID link that resolves
    # in Obsidian and the browser; only a naive filesystem lookup would miss it. Decode
    # so the audit reflects real navigability instead of false-positiving on encoded paths.
    return unquote(t)


def md_dest(src, target):
    """Resolve a link to an in-vault .md path, or None (dir-link -> README if it exists)."""
    t = clean_target(target)
    if t is None:
        return None
    try:
        raw = (src.parent / t).resolve()
    except OSError:
        return None
    if raw.is_dir():
        cand = (raw / "README.md")
        return cand if cand.exists() else None
    if raw.suffix.lower() == ".md":
        return raw
    return None


def link_targets(text):
    for m in LINK.finditer(text):
        yield m.group(1)


def main():
    files = md_files()
    fileset = set(files)
    texts = {f: f.read_text(encoding="utf-8", errors="replace") for f in files}

    graph = {f: set() for f in files}
    broken = set()
    for f in files:
        for raw in link_targets(texts[f]):
            t = clean_target(raw)
            if t is None:
                continue
            try:
                rawp = (f.parent / t).resolve()
            except OSError:
                continue
            is_md = rawp.suffix.lower() == ".md"
            is_dir_link = t.endswith("/") or rawp.is_dir()
            if not (is_md or is_dir_link):
                continue
            if not rawp.exists():
                broken.add((f, t))
                continue
            d = md_dest(f, raw)
            if d and d in fileset:
                graph[f].add(d)

    inbound = {f: 0 for f in files}
    for f, ds in graph.items():
        for d in ds:
            inbound[d] += 1

    ledger_viol = set()
    for f in files:
        t = texts[f]
        for m in LEDGER_HDR.finditer(t):
            start = m.end()
            nxt = ANY_HDR.search(t, start)
            section = t[start: nxt.start() if nxt else len(t)]
            # A link to a method/ page inside a ledger section is a methodology
            # reference, not a specimen edge; and the method pages' own ledgers cite
            # audit cases that intentionally don't reciprocate. Skip both directions.
            if f.relative_to(VAULT).parts[0] == "method":
                continue
            for raw in link_targets(section):
                d = md_dest(f, raw)
                if d is None or d not in fileset or d == f:
                    continue
                if d.relative_to(VAULT).parts[0] == "method":
                    continue
                if f not in graph.get(d, set()):
                    ledger_viol.add((f, d))

    orphans = [
        f for f in files
        if f.name not in ROOTS
        and f.relative_to(VAULT).parts[0] in ("research", "method", "notes")
        and inbound[f] == 0
    ]

    def rel(p):
        return str(p.relative_to(VAULT)).replace("\\", "/")

    n_links = sum(len(v) for v in graph.values())
    print(f"vault-graph: {len(files)} md files, {n_links} in-vault md links\n")

    print(f"[HARD] Broken links: {len(broken)}")
    for f, t in sorted((rel(a), b) for a, b in broken):
        print(f"   {f} -> {t}")

    print(f"\n[HARD] Ledger non-reciprocity: {len(ledger_viol)}")
    for a, b in sorted((rel(x), rel(y)) for x, y in ledger_viol):
        print(f"   {a}  ledgers  {b}  — no backlink")

    print(f"\n[warn] Orphans (research/method/notes, no inbound): {len(orphans)}")
    for f in sorted(rel(x) for x in orphans):
        print(f"   {f}")

    hard = len(broken) + len(ledger_viol)
    print(f"\n{'CLEAN' if hard == 0 else 'HARD VIOLATIONS: ' + str(hard)}")
    return 1 if hard else 0


if __name__ == "__main__":
    sys.exit(main())
