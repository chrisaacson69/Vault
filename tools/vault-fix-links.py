#!/usr/bin/env python3
"""
vault-fix-links.py — repair broken markdown links by unique-basename match.

Most broken links are path-depth bugs or moved files where the target STILL EXISTS somewhere
in the vault under the same filename. For each broken in-vault link, if exactly ONE vault .md
file has that basename, rewrite the link to the correct relative path (preserving #anchors).
Targets with no match (moved-to-repo content) or multiple matches (ambiguous, e.g. README.md)
are reported, never guessed.

Link targets are percent-decoded before they are resolved on disk, so a link that legitimately
spells a space as `%20` is not reported as missing (paths under raw/ routinely have spaces).
Emitted replacements re-encode spaces as `%20` to match vault convention.

Two distinct file sets: NO_WRITE dirs are never scanned as sources (raw/ is immutable), but their
.md files ARE indexed as basename candidates, so a link pointing INTO raw/ can still be matched.

Run:  py -3 tools/vault-fix-links.py            (dry-run)
      py -3 tools/vault-fix-links.py --write     (apply)
"""
import os
import re
import sys
from pathlib import Path
from urllib.parse import unquote

VAULT = Path(__file__).resolve().parent.parent
# Never scanned and never rewritten. raw/ is immutable (enforced by .claude/hooks/protect-raw.js).
EXCLUDE = {".git", "node_modules", ".obsidian", ".claude", "raw"}
# Excluded from scanning, but still valid link TARGETS worth indexing by basename.
INDEX_ONLY = {"raw"}
LINK = re.compile(r"\]\(([^)]+)\)")


def md_files(include=()):
    """Vault .md files. `include` re-admits EXCLUDE dirs as index-only candidates."""
    out = []
    for p in VAULT.rglob("*.md"):
        rel = p.relative_to(VAULT)
        blocked = set(x for x in rel.parts if x in EXCLUDE)
        if (blocked - set(include)) or p.name.startswith("_"):
            continue
        out.append(p.resolve())
    return out


def encode(path_str):
    """Re-encode a posix path for emission, matching the vault's %20 convention."""
    return path_str.replace(" ", "%20")


def main():
    write = "--write" in sys.argv
    files = md_files()
    by_name = {}
    for f in md_files(include=INDEX_ONLY):
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
            # Percent-decode before touching the filesystem: "%20" is a space on disk.
            decoded = unquote(bpart)
            try:
                rp = (f.parent / decoded).resolve()
            except OSError:
                continue
            is_md = rp.suffix.lower() == ".md"
            is_dir = decoded.endswith("/") or rp.is_dir()
            if not (is_md or is_dir):
                continue
            if rp.exists():
                continue  # not broken
            name = Path(decoded).name
            cands = by_name.get(name, [])
            if len(cands) == 1:
                new = encode(Path(os.path.relpath(cands[0], f.parent)).as_posix()) + anchor
                if new != raw:
                    repl[raw] = new
            else:
                key = (str(f.relative_to(VAULT)).replace("\\", "/"), bpart)  # report as written
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
