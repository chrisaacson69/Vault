---
name: vault-ingest
description: Ingest a source (URL, YouTube video, or raw/ file) into the vault — fetch content, save to raw/, process into structured vault pages with cross-links. Use when the user says "ingest this", shares a URL to add to the vault, or asks to process a file in raw/.
user-invocable: true
allowed-tools: Read, Edit, Write, Glob, Grep, Bash, Agent, WebFetch
---

## Vault Ingest — Top-Level Dispatcher

The vault lives at `C:\Users\Chris.Isaacson\Vault`. This skill takes a source and turns it into structured vault knowledge.

### 1. Determine Source Type

Identify what was given:

| Input | Type | Handler |
|-------|------|---------|
| YouTube URL (`youtube.com`, `youtu.be`) | video | YouTube handler |
| Other URL | article | Article handler |
| Filename in `raw/` | raw file | Raw file handler |
| Pasted text (no URL) | manual | Save to `raw/` first, then process |

### 2. Fetch Content

#### YouTube Handler
1. Get metadata: `yt-dlp --skip-download --print title --print channel --print duration_string --print upload_date "URL"`
2. Download transcript: `yt-dlp --write-auto-sub --sub-lang en --sub-format srt --skip-download -o "/tmp/transcript-name" "URL"`
3. Read the SRT file and strip timestamp formatting into plain text.
4. Save to `raw/` as `YYYY-MM-DD <title>.md` with frontmatter:
   ```yaml
   ---
   source: <URL>
   author: <channel name>
   title: <video title>
   clipped: <today>
   published: <upload date>
   type: youtube
   ---
   ```
5. Save raw transcript to `raw/videos/` (or `raw/debates/` for debate content).

#### Article Handler
1. Use `WebFetch` to fetch the URL and extract full content as markdown.
2. Save to `raw/` as `YYYY-MM-DD <title>.md` with frontmatter:
   ```yaml
   ---
   source: <URL>
   author: <extracted if available>
   title: <page title>
   clipped: <today>
   type: article
   ---
   ```
3. **If WebFetch fails** (bot-blocked, paywall, dynamic content):
   - Tell the user: "This site blocked automated fetch. Use Web Clipper (`Alt+Shift+O`) to clip it manually to `raw/`, then tell me to process it."
   - Stop and wait. Do not fabricate content.

#### Raw File Handler
1. Read the file from `raw/`.
2. Extract any existing frontmatter (Web Clipper adds source, title, author).
3. Proceed to processing.

### 3. Discuss Before Processing

Before creating vault pages, present to the user:
- **Source summary** — 3-5 key takeaways.
- **Proposed pages** — what new pages to create or which existing pages to update.
- **Emphasis question** — "What angle matters most to you? Anything to emphasize or skip?"

Wait for user input before proceeding. If the user says "just do it" or "full auto," proceed with default emphasis.

### 4. Process Into Vault Pages

A single source may touch 5-15 pages. For each:

1. **Decide page type:**
   - New research page — if the source introduces a new topic or argument
   - Update to existing page — if the source adds evidence or a new angle to existing vault content
   - New note — if it's a quick insight or sketch that doesn't merit a full research page

2. **Write/update pages** with proper format:
   ```yaml
   ---
   status: active
   created: YYYY-MM-DD
   ---
   # Title
   > One-line summary

   **Links:** [related pages]

   ## Content...

   ## Tags
   [tag links]
   ```

3. **Cross-link aggressively** — connect to every relevant existing vault page. The value of the wiki is in the connections, not the individual pages.

4. **File good synthesis back into the wiki** — if the ingest produces a comparison, a resolution to a contradiction, or a new framework connection, that synthesis IS a vault page, not just chat output.

### 5. Run Vault Sync

After all pages are created/updated, run the vault-sync procedure:
- Update INDEX.md (add new pages, update date)
- Update parent README files
- Update tag files and tag index counts
- Add bidirectional cross-links

### 6. Log the Ingest

Append to the conversation or offer to create a log entry noting:
- What source was ingested
- What pages were created/updated
- What connections were made

### Design Principles

- **Raw files are immutable** — never modify source material in `raw/`. It's the source of truth.
- **Graceful degradation** — if automated fetch fails, guide the user to the manual path (Web Clipper). Never fabricate content from a failed fetch.
- **The human directs, the LLM executes** — always discuss takeaways and emphasis before bulk page creation. The user's judgment about what matters is more valuable than exhaustive extraction.
- **Connections over coverage** — a well-linked page that ties into 5 existing vault threads is worth more than a thorough but isolated summary.
- **Compound, don't duplicate** — check existing pages before creating new ones. Update and enrich what exists. The vault's value comes from compounding knowledge, not accumulating files.
