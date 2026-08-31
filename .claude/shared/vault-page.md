# Vault Page Creation — Shared Conventions

Reusable conventions for any skill that creates or updates vault pages. Referenced by multiple skills to ensure consistent formatting and cross-linking.

## Page Format

Every vault page follows this structure:

```yaml
---
status: active | paused | completed | archived
created: YYYY-MM-DD
---
# Title
> One-line summary

**Source:** [Title](../raw/videos/YYYY-MM-DD slug.txt) — <https://original.url>
**Links:** [related item](./path/to/file.md), [another](./path/to/other.md)

## Content sections...

## Tags

[tag-name](../tags/tag-name.md)
```

### The `**Source:**` line (required for any page derived from `raw/`)

**Every page built from captured material names its `raw/` path, as a relative link, verbatim.** Cite the
original URL too, but the local path is the part that must be there: the URL says where it came from, the
path says *which artifact in this repo it was actually derived from*. Omit it and the page is unverifiable
on any other machine, and the vault loses its only mechanical way to tell captured-and-processed from
captured-and-forgotten.

This is not bookkeeping — it is the Grounding Discipline's audit trail. Measured 2026-08-26: without it,
raw coverage can only be guessed at by matching filenames, which ran ~70% false-positive (75 of 194 source
groups flagged as unprocessed; four clusters spot-checked, all four were fully processed and simply cited
by URL or under an unrelated page name). One `**Source:**` line per page turns that three-pass heuristic
into an exact lookup. See `.claude/skills/vault-heartbeat/SKILL.md` §1.5c.

- Multiple sources → one `**Source:**` line each, or a `## Sources` section with the same content.
- Source is a URL with no local capture → cite the URL and say so; don't invent a path.
- Pages with no captured source at all (pure synthesis) correctly have no `**Source:**` line.

### Frontmatter Rules
- `status` and `created` are required
- Add `published: true`, `title:`, `summary:`, and `layout: layouts/page.njk` if the page should appear on the public portfolio site
- Status and created live in YAML (queryable by Dataview)
- Links stay as markdown in the body (clickable, graph-visible)
- Tags stay in the `## Tags` section at the bottom as links to tag index files

## Cross-Linking

1. **Link aggressively** — when creating a page, link it to every relevant existing page
2. **Bidirectional** — if page A links to page B, page B's `**Links:**` section should link back to page A
3. **Use relative paths** — `./sibling.md`, `../parent/sibling.md`, `../../tags/tag.md`
4. **Connections over coverage** — a well-linked page that ties into 5 existing vault threads is worth more than a thorough but isolated summary

## File Placement

| Content Type | Location | Notes |
|---|---|---|
| Research topic | `research/<category>/` | Under appropriate subdirectory |
| Career content | `career/` | Career strategy, tools, postings |
| Quick insight/sketch | `notes/` | Standalone thoughts, not full research |
| Project docs | `projects/<name>/` | Active and past projects |
| Debate analysis | `research/debates/` | Online debate reviews |
| Raw source material | `raw/` | Never modified after creation |

## Page Size Guidelines

- **Index/overview pages (READMEs):** ~60-80 lines. Summaries and pointers, not full arguments.
- **Content pages:** No hard limit, but split into sub-pages when a single page exceeds ~150 lines on a distinct sub-topic.
- **Point, don't dump** — keep hub pages lean. Full analysis goes in leaf pages.

## Before Creating a New Page

1. **Check INDEX.md** — does a page on this topic already exist?
2. **Search with Grep** — look for the key terms across existing pages
3. **Prefer updating over duplicating** — enrich existing pages rather than creating overlapping new ones
4. **Compound, don't accumulate** — the vault's value comes from compounding knowledge, not adding files

## After Creating/Updating a Page

Run vault-sync procedures (or tell the user to run `/vault-sync`):
- Add to INDEX.md under the correct section
- Update parent README if in a research subdirectory
- Add back-links to tag files in `tags/`
- Update tag counts in `tags/_index.md`
- Add bidirectional cross-links to referenced pages
