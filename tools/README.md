# tools/

Deterministic generators & audit gates for the vault — the **derive** half of
[method/author-web-derive-hierarchy.md](../method/author-web-derive-hierarchy.md):
keep the vault write-optimized (a web of forward links), and let tools derive the
read-optimized checks instead of auditing by hand.

## vault-graph.py — the derive-the-ledger audit gate

Scans the markdown link graph and reports:

- **[HARD] broken links** — a link whose target file/dir doesn't exist.
- **[HARD] ledger non-reciprocity** — a page's `...ledger...` section names an in-vault
  specimen that doesn't link back (the two-way-ledger check, by machine). Keys on the
  convention that thesis pages list specimens under a heading containing "ledger"
  (e.g. `## Evidence ledger`, `## Downward ledger`). Links to/from `method/` pages are
  treated as methodology references, not specimen edges.
- **[warn] orphans** — research/method/notes pages with no inbound link.

```
py -3 tools/vault-graph.py
```

Exit 0 = no HARD violations (usable as a pre-commit gate); 1 = violations.

**First run (2026-06-08):** ledger reciprocity **CLEAN (0)** — validates the
specimen↔thesis reorg deterministically. Surfaced **178 broken links**, mostly tag/INDEX
deep-links to `game-annotation/*` and `pygone/*` subpages that were extracted to standalone
repos (the repo-extraction seam-breaker at scale) — the baseline to clean before wiring
this as a *blocking* gate.

## vault-tagindex.py — regenerate the tag reverse-indexes (the "derive indexes" half)

Source of truth = each page's `## Tags` section (which links to `../tags/<tag>.md`); this
derives the reverse index. CONSERVATIVE — it does **not** clobber curated descriptions:
**prunes** entries whose target no longer exists (repo-extraction casualties), **adds** pages
that tag X but aren't listed (with the page's own `>` one-liner), and **keeps** existing valid
entries verbatim. Preserves each tag file's header.

```
py -3 tools/vault-tagindex.py            # dry-run summary (-N broken, +N new per file)
py -3 tools/vault-tagindex.py --write    # apply
```

First apply (2026-06-08): 41 tag files reconciled — broken links **178 → 117**, ~200 missing
memberships added (`+48 philosophy`, `+29 morality`, …, the hand-maintained index's rot). The
remaining 117 broken links are non-tag (INDEX deep-links, a few wrong-path bugs) — a separate pass.

## vault-backlinks.py — materialize backlinks (the "emit backlinks" half) — BUILT, not applied

Derives the reverse walk and writes it into a marked, auto-generated `## Backlinks` block at the
bottom of each `research/`/`notes/`/`method/` page. Idempotent. Held back by default: a dry-run
shows it would touch **193 pages**, it duplicates Obsidian's native backlinks pane, and it pushes
against the vault's "keep pages lean" rule — so it's an on-demand tool, not an always-run gate.

```
py -3 tools/vault-backlinks.py            # dry-run summary
py -3 tools/vault-backlinks.py --write    # apply (193 pages)
```
