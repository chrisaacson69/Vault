#!/usr/bin/env python3
"""
tag-counts.py — derive tags/_index.md counts instead of hand-maintaining them.

The "— N files" figure beside each tag in tags/_index.md is a REPORT variable: it
should be CALCULATED from ground truth, never incremented by hand (hand-incrementing
is what let it drift to "11" while the file listed 16). This makes _index.md a pure
function of the tag files: for each tag it counts the backlink entries actually listed
in tags/<tag>.md and rewrites the count to match.

Layering: pages --(vault-sync backlink step)--> tags/<tag>.md --(this tool)--> _index counts.
Each layer is derived from the one below; nothing is maintained twice.

  py -3 tools/tag-counts.py          # report drift, write nothing (exit 1 if drift)
  py -3 tools/tag-counts.py --write  # rewrite _index.md counts in place (exit 0)

Keep it boring on purpose: it only touches the integer, and only when it's wrong.
"""
import re
import sys
from pathlib import Path

VAULT = Path(__file__).resolve().parent.parent
TAGS = VAULT / "tags"

# A backlink entry in a tag file: a list item linking to a relative .md page,
# e.g. "- [New Machine Migration](../notes/new-machine-migration.md) — ...".
# Prose bullets ("- Appears across domains") and headings don't match.
ENTRY = re.compile(r"^\s*[-*]\s+\[[^\]]+\]\((?:\.\.?/)[^)]+\.md\)", re.MULTILINE)
# An _index line: "- [meta-musing](./meta-musing.md) — 11 files"
IDX = re.compile(r"^(?P<pre>\s*[-*]\s+\[(?P<tag>[^\]]+)\]\(\./(?P=tag)\.md\)\s+—\s+)(?P<n>\d+)\s+files?(?P<post>.*)$")


def count_entries(tag):
    f = TAGS / f"{tag}.md"
    if not f.exists():
        return None
    return len(ENTRY.findall(f.read_text(encoding="utf-8", errors="replace")))


def main():
    write = "--write" in sys.argv[1:]
    idx_path = TAGS / "_index.md"
    lines = idx_path.read_text(encoding="utf-8", errors="replace").splitlines(keepends=True)

    drift, missing, out = [], [], []
    for line in lines:
        m = IDX.match(line.rstrip("\n"))
        if not m:
            out.append(line)
            continue
        tag, old = m["tag"], int(m["n"])
        actual = count_entries(tag)
        if actual is None:
            missing.append(tag)
            out.append(line)
            continue
        if actual != old:
            drift.append((tag, old, actual))
        nl = "\n" if line.endswith("\n") else ""
        word = "file" if actual == 1 else "files"
        out.append(f"{m['pre']}{actual} {word}{m['post']}{nl}")

    for tag, old, new in drift:
        print(f"  {tag}: {old} -> {new}")
    if missing:
        print(f"  [warn] _index lists tags with no tags/<tag>.md: {', '.join(missing)}")
    print(f"\n{len(drift)} count(s) drifted" + (" — writing" if (write and drift) else ""))

    if write and drift:
        idx_path.write_text("".join(out), encoding="utf-8")
        return 0
    return 1 if drift else 0


if __name__ == "__main__":
    sys.exit(main())
