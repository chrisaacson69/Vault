"""The two heartbeat checks that tools/ does NOT already cover.

Everything else the heartbeat needs is ALREADY BUILT in tools/ -- see tools/README.md
and route there first:

    py -3 tools/vault-graph.py            broken links + ledger reciprocity + orphans (the audit gate)
    py -3 tools/vault-fix-links.py        repair broken links by unique-basename match
    py -3 tools/vault-tagindex.py         derive tags/<tag>.md from each page's `## Tags`
    py -3 tools/tag-counts.py             recompute the `- N files` counts in tags/_index.md
    py -3 tools/vault-backlinks.py        materialize derived Backlinks sections

Only these two are genuinely missing, so only these live here:

  raw       1.5c pass 1 -- group raw/ by source, flag groups no page names by filename.
            Pass 1 ONLY. ~70%% false-positive alone; survivors must then be checked by
            URL and by topic before being reported. See SKILL.md 1.5c.
  ghosts    the one tag direction vault-tagindex.py leaves alone: it prunes entries whose
            target is GONE, but a tag file listing a page that still exists and simply
            stopped declaring the tag is left in place. Usually the PAGE lost its `## Tags`
            entry, not the tag file being wrong (2026-08-26: 39 pages, all belonged).

Usage:  py -3 .claude/skills/vault-heartbeat/scripts/heartbeat-checks.py [raw|ghosts|all]
Read-only. Repair ghosts by editing the page's `## Tags` section, then re-run
tools/vault-tagindex.py --write and tools/tag-counts.py --write.
"""
import re, os, sys, urllib.parse

VAULT = os.environ.get('VAULT_DIR', r"C:\Users\Chris.Isaacson\Vault")
os.chdir(VAULT)
EXCL = {'node_modules', '.git', '.obsidian', '_site'}
SEP = os.sep
DERIV = re.compile(r'(\.en-orig|\.en|-orig|_clean|-clean|_raw|-raw|\.info|\.live_chat)+$', re.I)
# Templates whose `## Tags` section holds placeholders rather than real tags.
TEMPLATES = {'projects/_template.md'}


def pages(skip_tags=True):
    for root, dirs, files in os.walk('.'):
        dirs[:] = [d for d in dirs if d not in EXCL]
        norm = root.replace(SEP, '/')
        if norm.startswith('./raw'):
            continue
        if skip_tags and (norm.startswith('./tags') or norm.startswith('./.claude')):
            continue
        for f in files:
            if not f.endswith('.md'):
                continue
            rel = os.path.join(root, f).replace(SEP, '/')
            rel = rel[2:] if rel.startswith('./') else rel
            try:
                yield rel, open(os.path.join(root, f), encoding='utf-8').read()
            except Exception:
                continue


def check_raw():
    print("=== 1.5c RAW COVERAGE -- PASS 1 OF 3 (filename only) ===")
    print("!! Pass 1 alone is ~70% false-positive. Every survivor MUST then be checked by")
    print("!! URL (pass 2) and topic keyword (pass 3). Reporting pass 1 as-is fabricates a finding.")
    blob = urllib.parse.unquote('\n'.join(t for _, t in pages(skip_tags=False)))

    def stem_of(p):
        s = os.path.splitext(os.path.basename(p))[0]
        while True:
            n = DERIV.sub('', s)
            if n.lower().endswith(('.en', '.srv1', '.vtt', '.srt')):
                n = os.path.splitext(n)[0]
            if n == s:
                return s
            s = n

    groups = {}
    for root, dirs, files in os.walk('raw'):
        dirs[:] = [d for d in dirs if d not in EXCL]
        for f in files:
            if f.startswith('.') or f.endswith('.gitkeep'):
                continue
            p = os.path.join(root, f).replace(SEP, '/')
            groups.setdefault((os.path.dirname(p), stem_of(p)), []).append(p)

    unc = [(d, s, ps) for (d, s), ps in sorted(groups.items())
           if not (any(os.path.basename(p) in blob
                       or os.path.splitext(os.path.basename(p))[0] in blob for p in ps)
                   or s in blob)]
    print("source groups: %d | pass-1 survivors needing passes 2-3: %d" % (len(groups), len(unc)))
    for d, s, ps in unc:
        print("  %9d B  %-24s %s (%d files)"
              % (sum(os.path.getsize(p) for p in ps), d, s, len(ps)))


def check_ghosts():
    print("=== TAG GHOSTS (the direction vault-tagindex.py leaves alone) ===")
    usage = {}
    for rel, t in pages():
        if rel in TEMPLATES:
            continue
        m = re.search(r'^## Tags\s*$', t, re.M)
        if not m:
            continue          # a tag counts ONLY inside `## Tags`; body prose is a mention
        for mm in re.finditer(r'\]\((?:\.\.?/)+tags/([A-Za-z0-9._-]+)\.md\)', t[m.end():]):
            usage.setdefault(mm.group(1), set()).add(rel)

    total = 0
    for tag in sorted(f[:-3] for f in os.listdir('tags')
                      if f.endswith('.md') and f != '_index.md'):
        txt = open(os.path.join('tags', tag + '.md'), encoding='utf-8').read()
        listed = set()
        for m in re.finditer(r'\]\((\.\.?/[^)]+\.md)\)', txt):
            p = os.path.normpath(os.path.join('tags', urllib.parse.unquote(m.group(1))))
            p = p.replace(SEP, '/')
            if p.startswith('tags/'):
                continue      # tag->tag "related tag" link, legitimate
            listed.add(p)
        for g in sorted(listed - usage.get(tag, set())):
            if os.path.exists(g):
                print("  %-24s %s" % (tag, g))
                total += 1
    print("ghosts: %d  (file exists -> the PAGE lost its `## Tags` entry; repair the page)" % total)


if __name__ == '__main__':
    which = sys.argv[1] if len(sys.argv) > 1 else 'all'
    for name, fn in (('raw', check_raw), ('ghosts', check_ghosts)):
        if which in (name, 'all'):
            fn()
            print("")
