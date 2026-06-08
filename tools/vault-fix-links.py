#!/usr/bin/env python3
"""
vault-fix-links.py — repair broken markdown links by unique-basename match.

Most broken links are path-depth bugs or moved files where the target STILL EXISTS somewhere
in the vault under the same filename. For each broken in-vault link, if exactly ONE vault .md
file has that basename, rewrite the link to the correct relative path (preserving #anchors).
Targets with no match (moved-to-repo content) or multiple matches (ambiguous, e.g. README.md)
are reported, never guessed.

Run:  py -3 tools/vault-fix-links.py            (dry-run)
      py -3 tools/vault-fix-links.py --write     (apply)
"""
import os
import re
import sys
from pathlib import Path

VAULT = Path(__file__).resolve().parent.parent
EXCLUDE = {".git", "node_modules", ".obsidian", ".claude", "raw"}
LINK = re.compile(r"\]\(([^)]+)\)")


def md_files():
    out = []
    for p in VAULT.rglob("*.md"):
        rel = p.relative_to(VAULT)
        if any(x in EXCLUDE for x in rel.parts) or p.name.startswith("_"):
            continue
        out.append(p.resolve())
    return out


def main():
    write = "--write" in sys.argv
    files = md_files()
    by_name = {}
    for f in files:
        by_name.setdefault(f.name, []).append(f)

    fixed = 0
    unfixable = {}
    for f in files:
        orig = f.read_text(encoding="utf-8", errors="replace")
        repl = {}
        for m in LINK.finditer(orig):
            raw = m.group(1)
            if "#" in raw:
                bpart, apart = raw.split("#", 1)
                anchor = "#" + apart
            else:
                bpart, anchor = raw, ""
            bpart = bpart.split("?")[0].strip()
            if not bpart or "://" in bpart or bpart.startswith("mailto:"):
                continue
            try:
                rp = (f.parent / bpart).resolve()
            except OSError:
                continue
            is_md = rp.suffix.lower() == ".md"
            is_dir = bpart.endswith("/") or rp.is_dir()
            if not (is_md or is_dir):
                continue
            if rp.exists():
                continue  # not broken
            name = Path(bpart).name
            cands = by_name.get(name, [])
            if len(cands) == 1:
                new = Path(os.path.relpath(cands[0], f.parent)).as_posix() + anchor
                if new != raw:
                    repl[raw] = new
            else:
                key = (str(f.relative_to(VAULT)).replace("\\", "/"), bpart)
                unfixable[key] = "missing" if not cands else f"ambiguous({len(cands)})"

        if repl:
            txt = orig
            for raw, new in repl.items():
                txt = txt.replace("](" + raw + ")", "](" + new + ")")
            fixed += len(repl)
            print(f"{'FIX' if write else 'WOULD FIX'} {f.relative_to(VAULT).as_posix()}: {len(repl)} links")
            if write:
                f.write_text(txt, encoding="utf-8")

    print(f"\nFixable by unique basename: {fixed} links.  Unfixable (need a decision): {len(unfixable)}")
    for (src, tgt), why in sorted(unfixable.items()):
        print(f"   [{why}] {src} -> {tgt}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
