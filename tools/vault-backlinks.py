#!/usr/bin/env python3
"""
vault-backlinks.py — materialize derived "Backlinks" sections (the reverse-edge index).

The "emit backlinks" half of method/author-web-derive-hierarchy.md: the web is walkable
forward via authored links; this derives the BACKWARD walk and writes it into a clearly
marked, auto-generated block at the bottom of each content page — so the reverse edges are
visible in git/GitHub/plain-markdown, not only in Obsidian's pane. Idempotent: re-running
replaces the block; a page with no inbound links gets no block (and an existing one is removed).

Tag files are excluded as backlink *sources* (a tag listing isn't a meaningful reference).

Scope: research/, notes/, method/ pages.

Run:  py -3 tools/vault-backlinks.py            (dry-run summary)
      py -3 tools/vault-backlinks.py --write     (apply)
"""
import os
import re
import sys
from pathlib import Path

VAULT = Path(__file__).resolve().parent.parent
EXCLUDE = {".git", "node_modules", ".obsidian", ".claude", "raw"}
SCOPE = ("research", "notes", "method")
LINK = re.compile(r"\[[^\]]*\]\(([^)]+)\)")
BEGIN = "<!-- vault-backlinks:begin -->"
END = "<!-- vault-backlinks:end -->"
BLOCK_RE = re.compile(re.escape(BEGIN) + r".*?" + re.escape(END), re.DOTALL)


def md_files():
    out = []
    for p in VAULT.rglob("*.md"):
        rel = p.relative_to(VAULT)
        if any(x in EXCLUDE for x in rel.parts) or p.name.startswith("_"):
            continue
        out.append(p.resolve())
    return out


def md_dest(src, target):
    t = target.split("#")[0].split("?")[0].strip()
    if not t or "://" in t:
        return None
    try:
        raw = (src.parent / t).resolve()
    except OSError:
        return None
    if raw.is_dir():
        cand = raw / "README.md"
        return cand if cand.exists() else None
    return raw if raw.suffix.lower() == ".md" else None


def title(text, fallback):
    m = re.search(r"^#\s+(.*)$", text, re.MULTILINE)
    return m.group(1).strip() if m else fallback


def main():
    write = "--write" in sys.argv
    files = md_files()
    fileset = set(files)
    texts = {f: f.read_text(encoding="utf-8", errors="replace") for f in files}

    inbound = {f: [] for f in files}
    for src in files:
        if src.relative_to(VAULT).parts[0] == "tags":
            continue  # tag listings aren't real references
        for m in LINK.finditer(texts[src]):
            d = md_dest(src, m.group(1))
            if d and d in fileset and d != src:
                inbound[d].append(src)

    changed = 0
    for f in files:
        if f.relative_to(VAULT).parts[0] not in SCOPE or f.name in {"README.md", "INDEX.md"}:
            continue
        refs = sorted(set(inbound[f]), key=lambda s: title(texts[s], s.stem).lower())
        old = texts[f]
        base = BLOCK_RE.sub("", old).rstrip()
        if refs:
            lines = [f"- [{title(texts[s], s.stem)}]({Path(os.path.relpath(s, f.parent)).as_posix()})"
                     for s in refs]
            block = f"{BEGIN}\n## Backlinks\n" + "\n".join(lines) + f"\n{END}"
            new = base + "\n\n" + block + "\n"
        else:
            new = base + "\n"
        if new != old:
            changed += 1
            print(f"{'WROTE' if write else 'DIFF'} {f.relative_to(VAULT).as_posix()}: {len(refs)} backlinks")
            if write:
                f.write_text(new, encoding="utf-8")

    print(f"\n{changed} pages {'updated' if write else 'would change'} "
          f"({'--write' if write else 'dry-run; pass --write to apply'})")


if __name__ == "__main__":
    main()
