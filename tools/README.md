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

### Next increment
The *generate* half: emit the reciprocal backlinks and regenerate INDEX/tag indexes from
the forward-link graph + frontmatter, so the read-optimized hierarchy is derived, not
hand-maintained.
