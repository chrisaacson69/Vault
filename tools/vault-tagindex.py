#!/usr/bin/env python3
"""
vault-tagindex.py — derive/maintain the tags/*.md reverse-link indexes.

The "regenerate indexes" half of method/author-web-derive-hierarchy.md. Source of truth
is each page's `## Tags` section (which links to ../tags/<tag>.md); this derives the
reverse index. CONSERVATIVE by design — it does NOT clobber curated descriptions:
  - PRUNE: drop entries whose target file no longer exists (e.g. repo-extraction casualties).
  - ADD:   append pages that tag X but aren't listed yet (link + the page's own one-liner).
  - KEEP:  existing valid entries verbatim (descriptions preserved).
Preserves each tag file's header (everything above the first list item).

Run:  py -3 tools/vault-tagindex.py            (dry-run summary)
      py -3 tools/vault-tagindex.py --write     (apply)
"""
import os
import re
import sys
from pathlib import Path

VAULT = Path(__file__).resolve().parent.parent
TAGS = (VAULT / "tags").resolve()
EXCLUDE = {".git", "node_modules", ".obsidian", ".claude", "raw"}
LINK = re.compile(r"\[[^\]]*\]\(([^)]+)\)")


def content_files():
    for p in VAULT.rglob("*.md"):
        rel = p.relative_to(VAULT)
        if any(x in EXCLUDE for x in rel.parts):
            continue
        if rel.parts[0] == "tags" or p.name.startswith("_"):
            continue
        yield p.resolve()


def first(pat, text):
    m = re.search(pat, text, re.MULTILINE)
    return m.group(1).strip() if m else None


def summary(text):
    s = first(r"^>\s+(.*)$", text) or ""
    cut = s.find(". ")
    if 0 <= cut < 200:
        s = s[: cut + 1]
    if len(s) > 180:
        s = s[:177].rstrip() + "…"
    return s


def tags_section(text):
    m = re.search(r"^#{2,6}\s+Tags\s*$", text, re.MULTILINE)
    if not m:
        return ""
    nxt = re.search(r"^#{1,6}\s", text[m.end():], re.MULTILINE)
    return text[m.end(): m.end() + (nxt.start() if nxt else len(text) - m.end())]


def resolve(src, target, want_tag=False):
    t = target.split("#")[0].split("?")[0].strip()
    if not t or "://" in t:
        return None
    try:
        raw = (src.parent / t).resolve()
    except OSError:
        return None
    if raw.suffix.lower() == ".md":
        if want_tag:
            return raw.stem if raw.parent == TAGS else None
        return raw
    return None


def main():
    write = "--write" in sys.argv

    members = {}  # tag stem -> list of (title, path, summary)
    for f in content_files():
        txt = f.read_text(encoding="utf-8", errors="replace")
        sec = tags_section(txt)
        if not sec:
            continue
        ttl = first(r"^#\s+(.*)$", txt) or f.stem
        summ = summary(txt)
        for m in LINK.finditer(sec):
            stem = resolve(f, m.group(1), want_tag=True)
            if stem:
                members.setdefault(stem, []).append((ttl, f, summ))

    changed = 0
    for tagfile in sorted(TAGS.glob("*.md")):
        if tagfile.name.startswith("_"):
            continue
        old = tagfile.read_text(encoding="utf-8", errors="replace")
        idx = old.find("\n- [")
        header = (old if idx == -1 else old[:idx]).rstrip() + "\n"
        old_lines = [ln for ln in old.splitlines() if ln.startswith("- [")]

        kept, kept_paths, pruned = [], set(), 0
        for ln in old_lines:
            lm = LINK.search(ln)
            dest = resolve(tagfile, lm.group(1)) if lm else None
            if dest is not None and not dest.exists():
                pruned += 1
                continue
            kept.append(ln)
            if dest is not None:
                kept_paths.add(dest)

        added = 0
        for ttl, f, summ in sorted(members.get(tagfile.stem, []), key=lambda e: e[0].lower()):
            if f in kept_paths:
                continue
            rel = Path(os.path.relpath(f, TAGS)).as_posix()
            kept.append(f"- [{ttl}]({rel})" + (f" — {summ}" if summ else ""))
            kept_paths.add(f)
            added += 1

        body = header + "\n" + "\n".join(kept) + "\n"
        if body != old:
            changed += 1
            print(f"{'WROTE' if write else 'DIFF'} tags/{tagfile.name}: -{pruned} broken, +{added} new")
            if write:
                tagfile.write_text(body, encoding="utf-8")

    print(f"\n{changed} tag files {'updated' if write else 'would change'} "
          f"({'--write' if write else 'dry-run; pass --write to apply'})")


if __name__ == "__main__":
    main()
