---
name: vault-ingest
description: Ingest a source (URL, YouTube video, or raw/ file) into the vault — fetch content, save to raw/, process into structured vault pages with cross-links. Use when the user says "ingest this", shares a URL to add to the vault, or asks to process a file in raw/.
user-invocable: true
allowed-tools: Read, Edit, Write, Glob, Grep, Bash, Agent, WebFetch
---

## Vault Ingest — Top-Level Dispatcher

Base directory: `C:\Users\Chris.Isaacson\Vault`

**Shared procedures:**
- [content-extract.md](../../shared/content-extract.md) — source type detection, YouTube/article extraction, SRT cleaning, raw file frontmatter
- [vault-page.md](../../shared/vault-page.md) — page format, cross-linking, file placement, size guidelines
- [web-research.md](../../shared/web-research.md) — search methodology, failure handling (for URL-based ingests)

### 1. Determine Source Type

Use the source type detection table in content-extract.md to identify the handler.

### 2. Fetch Content

Follow the extraction procedures in content-extract.md for the detected source type:
- **YouTube** — yt-dlp for metadata + transcript, SRT cleaning
- **Article URL** — WebFetch → markdown, fallback to Web Clipper
- **Raw file** — read directly from `raw/`
- **Pasted text** — save to `raw/` with frontmatter first

Save all raw content to `raw/` with standardized frontmatter per content-extract.md conventions.

### 3. Discuss Before Processing

Before creating vault pages, present to the user:
- **Source summary** — 3-5 key takeaways
- **Proposed pages** — what new pages to create or which existing pages to update
- **Emphasis question** — "What angle matters most to you? Anything to emphasize or skip?"

Wait for user input. If the user says "just do it" or "full auto," proceed with default emphasis.

### 4. Process Into Vault Pages

A single source may touch 5-15 pages. Follow vault-page.md for all page creation:

1. **Check before creating** — search INDEX.md and Grep for existing pages on the topic
2. **Prefer updating over duplicating** — enrich existing pages rather than creating overlapping new ones
3. **Write pages** with proper format per vault-page.md (frontmatter, summary, links, tags)
4. **Cross-link aggressively** — bidirectional links per vault-page.md conventions
5. **File good synthesis back into the wiki** — if the ingest produces a comparison, resolution, or new framework connection, that synthesis IS a vault page

### 5. Run Vault Sync

After all pages are created/updated, run vault-sync procedures:
- Update INDEX.md (add new pages, update date)
- Update parent README files
- Update tag files and tag index counts
- Add bidirectional cross-links

### 6. Log the Ingest

Report to the user:
- What source was ingested
- What pages were created/updated
- What connections were made

### Design Principles

- **Raw files are immutable** — never modify source material in `raw/`
- **Graceful degradation** — per content-extract.md, if fetch fails, guide to manual path
- **The human directs, the LLM executes** — always discuss before bulk page creation
- **Connections over coverage** — per vault-page.md, well-linked > thorough but isolated
- **Compound, don't duplicate** — per vault-page.md, update and enrich what exists
