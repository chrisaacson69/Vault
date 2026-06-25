---
name: vault-sync
description: Update vault infrastructure after adding or modifying a page — INDEX.md, tag files, tag index counts, cross-links, and README entries. Use this whenever a new vault page is created or an existing page's tags or links change.
user-invocable: true
allowed-tools: Read, Edit, Write, Glob, Grep
---

## Vault Sync Procedure

The vault lives at `C:\Users\Chris.Isaacson\Vault`. After any page is created or modified, run the following steps to keep infrastructure consistent.

### 1. Identify Changes

Determine what was added or changed:
- New page? Note its path, title, one-line description, and tags.
- Modified page? Note which tags or links changed.

### 2. Update INDEX.md

- Add or update the entry in `Vault/INDEX.md` under the correct section (Projects, Research, Notes).
- Maintain alphabetical/logical ordering within sections.
- Format: `- [Title](./relative/path.md) — one-line description`
- Update the `**Last updated:**` date to today.

### 3. Update Parent README

- If the page lives under a research subdirectory (e.g., `research/philosophy/`, `research/economics/`, `research/debates/`), add it to that directory's `README.md`.

### 4. Update Tag Files

For each tag on the page:
- Add a back-link entry to `Vault/tags/<tag-name>.md`.
- Format: `- [Page Title](../relative/path/to/page.md)`
- If the tag file doesn't exist, create it with a one-line description and the back-link.

### 5. Update Tag Index Counts (CALCULATE, don't maintain)

- The `— N files` count is a derived report variable: never hand-increment it (that is what let it drift). After updating the tag files in step 4, run `py -3 tools/tag-counts.py --write` — it recomputes every count from the actual back-link entries in `tags/<tag>.md` and rewrites `_index.md`. Run with no flag for a dry-run report.
- If a *new* tag was created, add its `- [tag](./tag.md) — 0 files` line to the index in alphabetical order first, then run the tool to fill in the real count.

### 6. Add Cross-Links

- Add the new page to the `**Links:**` header of any page it references.
- Ensure bidirectional linking: if page A links to page B, page B should link back to page A.

### 7. Verify

- Confirm all relative paths resolve correctly.
- Tag counts are verified by the tool in step 5 (re-run it with no flag; exit 0 = clean) — no manual checking.

### Notes

- Tags section at the bottom of each page uses format: `[tag-name](../../tags/tag-name.md)` (adjust relative depth).
- INDEX.md paths are relative to vault root: `./research/...`
- Tag back-links are relative to `tags/` directory: `../research/...`
