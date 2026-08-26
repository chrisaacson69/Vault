"""Deterministic structural checks for /vault-heartbeat (1a, 1c, 1.5c pass 1).

Usage:  py -3 .claude/skills/vault-heartbeat/scripts/check.py [links|tags|raw|all]

Read-only. Repairs live in repair-tags.py. Every exclusion below is a MEASURED
false positive (2026-08-26) -- do not "simplify" them away.
"""
import re, os, sys, urllib.parse

VAULT = os.environ.get('VAULT_DIR', r"C:\Users\Chris.Isaacson\Vault")
os.chdir(VAULT)
EXCL = {'node_modules', '.git', '.obsidian', '_site'}
SEP = os.sep

# Templates whose `## Tags` section holds placeholder tags rather than real ones.
# (Prose that merely MENTIONS a tag link elsewhere in the body is handled by the
#  section rule in tag_usage() -- a tag counts only inside `## Tags`. That rule is
#  why CLAUDE.md needs no entry here, and why notes/obsidian-plugin-setup.md keeps
#  its real `ai` tag while its Dataview `philosophy` example is correctly ignored.)
DOC_EXAMPLES = {'projects/_template.md'}
# Sibling-format suffix chain: one captured source, many files.
DERIV = re.compile(r'(\.en-orig|\.en|-orig|_clean|-clean|_raw|-raw|\.info|\.live_chat)+$', re.I)


def walk_pages(skip_tags=True, skip_dotclaude=True):
    for root, dirs, files in os.walk('.'):
        dirs[:] = [d for d in dirs if d not in EXCL]
        norm = root.replace(SEP, '/')
        if norm.startswith('./raw'):
            continue
        if skip_tags and norm.startswith('./tags'):
            continue
        if skip_dotclaude and norm.startswith('./.claude'):
            continue
        for f in files:
            if not f.endswith('.md'):
                continue
            rel = os.path.join(root, f).replace(SEP, '/')
            rel = rel[2:] if rel.startswith('./') else rel
            try:
                yield rel, root, open(os.path.join(root, f), encoding='utf-8').read()
            except Exception:
                continue


def check_links():
    print("=== 1a BROKEN LINKS ===")
    txt = open('INDEX.md', encoding='utf-8').read()
    pat = re.compile(r'\[([^\]]*)\]\((\.[^)]*)\)')
    bad = [(txt[:m.start()].count('\n') + 1, m.group(1), urllib.parse.unquote(m.group(2).split('#')[0]))
           for m in pat.finditer(txt)
           if m.group(2).split('#')[0] and not os.path.exists(urllib.parse.unquote(m.group(2).split('#')[0]))]
    print("INDEX.md: %d relative links, %d broken" % (len(pat.findall(txt)), len(bad)))
    for l, t, p in bad:
        print("  L%d: [%s] -> %s" % (l, t, p))

    pat2 = re.compile(r'\[([^\]]*)\]\((\.{1,2}/[^)]*)\)')
    n = 0
    for rel, root, t in walk_pages(skip_tags=False, skip_dotclaude=False):
        for m in pat2.finditer(t):
            tgt = m.group(2).split('#')[0]
            if not tgt:
                continue
            p = urllib.parse.unquote(tgt)
            if not os.path.exists(os.path.normpath(os.path.join(root, p))):
                # Two classes of non-navigable link that are NOT defects:
                #  (a) literal placeholders in templates/docs
                #  (b) instruction strings inside .claude/ that a skill writes INTO a
                #      page ("Tag with [career](../tags/career.md)") -- the depth is
                #      correct from the target page, not from the skill file.
                placeholder = (
                    any(k in p for k in ('path/to', 'relative/path', 'tag-name', './tag.md',
                                         'my-project', 'NN-previous', 'transcript-file',
                                         'YYYY-MM-DD'))
                    or (rel.startswith('.claude/') and '/tags/' in p)
                    or rel == 'projects/_template.md')
                print("  %s L%d: [%s] -> %s%s"
                      % (rel, t[:m.start()].count('\n') + 1, m.group(1), p,
                         "   (template placeholder)" if placeholder else "   *** REAL ***"))
                n += 1
    print("vault-wide: %d broken (placeholders annotated)" % n)


def tag_usage():
    """tag -> set(pages that really declare it.

    A tag counts ONLY inside the page's `## Tags` section. Body prose legitimately
    links tag files while explaining the convention (CLAUDE.md's example, the
    Dataview `FROM [[tags/philosophy]]` note) -- counting those invents tags.
    """
    usage = {}
    for rel, root, t in walk_pages():
        if rel in DOC_EXAMPLES:
            continue
        m = re.search(r'^## Tags\s*$', t, re.M)
        if not m:
            continue
        for mm in re.finditer(r'\]\((?:\.\.?/)+tags/([A-Za-z0-9._-]+)\.md\)', t[m.end():]):
            usage.setdefault(mm.group(1), set()).add(rel)
    return usage


def tag_listed(tag):
    """pages back-linked from tags/<tag>.md, excluding tag->tag related links"""
    listed = set()
    txt = open(os.path.join('tags', tag + '.md'), encoding='utf-8').read()
    for m in re.finditer(r'\]\((\.\.?/[^)]+\.md)\)', txt):
        p = os.path.normpath(os.path.join('tags', urllib.parse.unquote(m.group(1)))).replace(SEP, '/')
        if p.startswith('tags/'):
            continue
        listed.add(p)
    return listed


def check_tags():
    print("=== 1c TAG INTEGRITY ===")
    tags = sorted(f[:-3] for f in os.listdir('tags') if f.endswith('.md') and f != '_index.md')
    idx = open('tags/_index.md', encoding='utf-8').read()
    declared = {m.group(1): int(m.group(2)) for m in
                re.finditer(r'\[([^\]]+)\]\(\./[^)]+\.md\)\s*[-\u2014]+\s*(\d+)\s+files?', idx)}
    usage = tag_usage()

    unreg = [t for t in tags if t not in declared]
    print("tag files: %d | registered in _index.md: %d" % (len(tags), len(declared)))
    if unreg:
        print("  UNREGISTERED (unfindable): %s" % ', '.join(unreg))
    gone = [t for t in declared if t not in tags]
    if gone:
        print("  DECLARED BUT NO FILE: %s" % ', '.join(gone))

    ghosts = missing = 0
    for tag in tags:
        listed, real = tag_listed(tag), usage.get(tag, set())
        d = declared.get(tag)
        if d is not None and d != len(listed):
            print("  COUNT  %-24s _index=%s backlinks=%d" % (tag, d, len(listed)))
        for g in sorted(listed - real):
            print("  GHOST  %-24s %s%s" % (tag, g, "" if os.path.exists(g) else "  [FILE GONE]"))
            ghosts += 1
        for m in sorted(real - listed):
            print("  MISS   %-24s %s" % (tag, m))
            missing += 1
    print("ghosts=%d missing=%d  (ghost w/ existing file -> repair the PAGE, not the tag file)"
          % (ghosts, missing))


def check_raw():
    print("=== 1.5c RAW COVERAGE (pass 1 of 3 -- filename only) ===")
    print("!! Pass 1 alone is ~70%% false-positive. Survivors MUST then be checked by")
    print("!! URL (pass 2) and by topic keyword (pass 3) before being reported. See SKILL.md.")
    blob = urllib.parse.unquote('\n'.join(t for _, _, t in walk_pages(skip_tags=False, skip_dotclaude=False)))

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

    unc = []
    for (d, stem), paths in sorted(groups.items()):
        if any(os.path.basename(p) in blob or os.path.splitext(os.path.basename(p))[0] in blob
               for p in paths) or stem in blob:
            continue
        unc.append((d, stem, paths))
    print("source groups: %d | pass-1 survivors needing passes 2-3: %d" % (len(groups), len(unc)))
    for d, stem, paths in unc:
        print("  %9d B  %-24s %s (%d files)"
              % (sum(os.path.getsize(p) for p in paths), d, stem, len(paths)))


if __name__ == '__main__':
    which = sys.argv[1] if len(sys.argv) > 1 else 'all'
    for name, fn in (('links', check_links), ('tags', check_tags), ('raw', check_raw)):
        if which in (name, 'all'):
            fn()
            print("")
