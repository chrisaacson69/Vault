"""Repair the tag layer after check.py reports ghosts/missing/unregistered (1c).

Usage:  py -3 .claude/skills/vault-heartbeat/scripts/repair-tags.py [--apply]

Dry run by default. THREE repairs, in this order:
  1. ghost  -> the tag file lists a page that no longer declares the tag.
              If the page still exists the TAG FILE IS RIGHT and the page lost its
              `## Tags` entry: add the tag to the page. (2026-08-26: 39 pages / 55
              pairs, every one belonged. Evicting would have destroyed a correct index.)
  2. missing-> the page declares the tag, the tag file doesn't list it: add the back-link.
  3. _index -> rebuild tags/_index.md so every tag file is registered with a true count.

REVIEW THE DRY RUN. Step 1 edits content pages; a wrong tag is worse than a missing one.
"""
import re, os, sys, urllib.parse

VAULT = os.environ.get('VAULT_DIR', r"C:\Users\Chris.Isaacson\Vault")
os.chdir(VAULT)
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from check import walk_pages, tag_usage, tag_listed, DOC_EXAMPLES  # noqa: E402

APPLY = '--apply' in sys.argv
SEP = os.sep
TAGHDR = re.compile(r'^## Tags\s*$', re.M)


def main():
    tags = sorted(f[:-3] for f in os.listdir('tags') if f.endswith('.md') and f != '_index.md')
    usage = tag_usage()
    titles = {}
    for rel, _root, t in walk_pages():
        h = re.search(r'^#\s+(.+)$', t, re.M)
        titles[rel] = h.group(1).strip() if h else os.path.basename(rel)[:-3]

    # ---- 1. ghosts -> add the tag to the page ----
    ghosts = {}
    for tag in tags:
        for g in sorted(tag_listed(tag) - usage.get(tag, set())):
            if os.path.exists(g) and g not in DOC_EXAMPLES:
                ghosts.setdefault(g, []).append(tag)
    print("-- 1. pages missing a tag the tag file claims: %d pages / %d pairs --"
          % (len(ghosts), sum(len(v) for v in ghosts.values())))
    for page in sorted(ghosts):
        tl = ghosts[page]
        depth = page.count('/')
        prefix = '../' * depth if depth else './'
        txt = open(page, encoding='utf-8').read()
        m = TAGHDR.search(txt)
        if m:
            lines = txt[m.end():].split('\n')
            i = 0
            while i < len(lines) and not lines[i].strip():
                i += 1
            if i >= len(lines):
                print("  SKIP (empty Tags section) %s" % page)
                continue
            sep = ' \u00b7 ' if '\u00b7' in lines[i] else ', '
            lines[i] = lines[i].rstrip() + sep + sep.join(
                '[%s](%stags/%s.md)' % (t, prefix, t) for t in tl)
            new, act = txt[:m.end()] + '\n'.join(lines), 'APPEND'
        else:
            new = txt.rstrip('\n') + '\n\n## Tags\n\n' + ' \u00b7 '.join(
                '[%s](%stags/%s.md)' % (t, prefix, t) for t in tl) + '\n'
            act = 'CREATE'
        print("  %-7s %-56s + %s" % (act, page, ', '.join(tl)))
        if APPLY:
            open(page, 'w', encoding='utf-8', newline='').write(new)

    if APPLY:
        usage = tag_usage()  # pages changed; recompute before steps 2-3

    # ---- 2. missing back-links -> add to the tag file ----
    print("\n-- 2. tag files missing a back-link --")
    counts, added = {}, 0
    for tag in tags:
        listed, real = tag_listed(tag), usage.get(tag, set())
        miss = sorted(real - listed)
        if miss:
            txt = open(os.path.join('tags', tag + '.md'), encoding='utf-8').read()
            lines = txt.rstrip('\n').split('\n')
            for p in miss:
                lines.append('- [%s](../%s)' % (titles.get(p, p), p))
                print("  %-22s + %s" % (tag, p))
                added += 1
            if APPLY:
                open(os.path.join('tags', tag + '.md'), 'w',
                     encoding='utf-8', newline='').write('\n'.join(lines) + '\n')
        counts[tag] = len(listed | real)
    print("  back-links added: %d" % added)

    # ---- 3. rebuild _index.md ----
    idx = open('tags/_index.md', encoding='utf-8').read()
    head = re.search(r'^(---.*?---\s*\n#[^\n]*\n(?:>[^\n]*\n)?)', idx, re.S)
    head = head.group(1) if head else '# Tag Index\n'
    body = '\n'.join('- [%s](./%s.md) \u2014 %d file%s'
                     % (t, t, counts[t], '' if counts[t] == 1 else 's') for t in tags)
    was = set(re.findall(r'\[([^\]]+)\]\(\./[^)]+\.md\)', idx))
    print("\n-- 3. _index.md: %d -> %d entries | newly registered: %s --"
          % (len(was), len(tags), ', '.join(sorted(set(tags) - was)) or 'none'))
    if APPLY:
        open('tags/_index.md', 'w', encoding='utf-8', newline='').write(
            head.rstrip('\n') + '\n\n' + body + '\n')
    print("\nAPPLIED" if APPLY else "\n(dry run -- pass --apply)")


if __name__ == '__main__':
    main()
