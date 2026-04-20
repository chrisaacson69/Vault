# Vault — Personal Knowledge & Project System

This is Chris's personal vault for tracking projects, research, notes, tasks, goals, and logs.

## System Design

This vault uses a folder structure with **cross-linking** to function as a knowledge network rather than a strict hierarchy. Every file can link to any other file using relative markdown links.

### Conventions

- **Links between files**: Use relative markdown links, e.g. `[Project Name](./projects/my-project.md)`
- **Tags**: Each file may include a `## Tags` section at the bottom listing relevant tags as links to tag index files, e.g. `[python](./tags/python.md)`. Tag files in `/tags/` collect reverse-links to everything with that tag.
- **Front matter**: Files use YAML frontmatter for queryable metadata, followed by the heading, summary, and links:
  ```
  ---
  status: active | paused | completed | archived
  created: YYYY-MM-DD
  ---
  # Title
  > One-line summary

  **Links:** [related item](./path/to/file.md), [another](./path/to/other.md)
  ```
  Status and Created live in YAML (queryable by Dataview). Links stay as markdown in the body (clickable, graph-visible). Tags stay in the `## Tags` section at the bottom as links to tag index files (graph-visible, queryable via `FROM [[tags/tagname]]`).

### Folder Purposes

| Folder       | What goes here                                      |
|-------------|-----------------------------------------------------|
| `projects/` | Active and past projects (code, personal, creative) |
| `research/` | Topics being explored, learning notes, references   |
| `career/`   | AI lessons learned, career development, what works and what doesn't |
| `notes/`    | Quick captures, ideas, standalone thoughts          |
| `tasks/`    | Goals, to-do tracking, milestones                   |
| `logs/`     | Session logs, journals, progress entries            |
| `tags/`     | Auto-maintained tag index files for cross-referencing|
| `raw/`      | Unprocessed source material for ingestion (Web Clipper drops, PDFs, transcripts) |

### Raw Ingestion Workflow

The `raw/` folder holds unprocessed source material — Web Clipper articles, PDFs, transcripts, copied text. When asked to ingest a source:

1. **Read the raw source** and discuss key takeaways with Chris.
2. **Decide where it belongs** — new research page, addition to existing page, or note.
3. **Create or update wiki pages** — extract entities, concepts, and arguments into proper vault pages with cross-links.
4. **Update the index** — add new pages to INDEX.md.
5. **Update tag indexes** — ensure tag files have back-links for any new pages.
6. **Log the ingest** — note what was processed and what pages were created/updated.

A single raw source may touch 5-15 wiki pages. The raw file itself is never modified — it's the source of truth.

### How Claude Should Work With This Vault

1. **Always check INDEX.md first** when looking for existing content — it's the master map.
2. **Cross-link aggressively** — when creating or updating a file, link it to related files and update their link sections too.
3. **Maintain tag indexes** — when tagging a file, ensure the corresponding tag file in `/tags/` has a back-link.
4. **Keep INDEX.md current** — add new files to the index when they're created.
5. **Prefer updating over duplicating** — search for existing notes on a topic before creating new ones.
6. **Use consistent formatting** — follow the front matter and conventions above.
7. **Log sessions when significant** — if a conversation covers substantial ground, offer to create a log entry.
8. **Keep pages lean** — overview/README pages should be ~60-80 lines of summaries and pointers. Full arguments, reading lists, and detailed analysis go in sub-pages. Point, don't dump.

### Presentations (Marp)

Slide decks use [Marp](https://marp.app/) — markdown-to-slides. Files with `marp: true` in YAML frontmatter are slide decks.

- **Slide separator:** `---` between slides, or use `headingDivider: 2` to auto-split on `##` headings.
- **Themes:** `default`, `gaia`, `uncover` (set via `theme:` in frontmatter).
- **Export:** `marp presentation.md --pdf` or `--pptx` or `--html` (requires Chrome/Edge).
- **Background images:** `![bg right:40%](image.jpg)` for split layouts.
- **Speaker notes:** HTML comments `<!-- note text -->`.
- **Convention:** Use standard markdown links (not wiki-links) in slides. Keep Marp files in the same folder as the research they present, or in `projects/` for project-specific decks.

Example frontmatter:
```yaml
---
marp: true
theme: gaia
paginate: true
headingDivider: 2
---
```
