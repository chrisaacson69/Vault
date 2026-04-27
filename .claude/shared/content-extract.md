# Content Extraction — Dispatcher

Top-level dispatcher for extracting structured content from any source. Detects the source type and routes to the appropriate handler.

**Handlers:**
- [video-extract.md](./video-extract.md) — YouTube, Rumble, and 1000+ video sites (via yt-dlp)
- [web-fetch.md](./web-fetch.md) — articles, web pages, documentation (via WebFetch, future Playwright)

## Source Type Detection

| Input | Type | Handler | Specific Tool |
|---|---|---|---|
| YouTube URL (`youtube.com`, `youtu.be`) | video | video-extract.md | yt-dlp |
| Rumble / other video URL | video | video-extract.md | yt-dlp |
| Article / web page URL | article | web-fetch.md | WebFetch |
| PDF file | document | Read tool (native) | — |
| SRT/VTT file | transcript | video-extract.md (SRT cleaning) | — |
| Raw text / pasted content | manual | Save to `raw/` first | — |
| HTML file | article | web-fetch.md (cleaning rules) | — |

## Dispatch Logic

1. **Check for video URL patterns** — `youtube.com`, `youtu.be`, `rumble.com`, `vimeo.com`, `dailymotion.com`, `bitchute.com`
   → Route to video-extract.md

2. **Check for document file** — `.pdf` extension
   → Use Read tool directly (handles PDFs natively)

3. **Check for transcript file** — `.srt`, `.vtt` extension
   → Use video-extract.md SRT cleaning procedures

4. **Check for web URL** — any `http://` or `https://`
   → Route to web-fetch.md

5. **Check for raw file reference** — path in `raw/` directory
   → Read directly, extract existing frontmatter

6. **Pasted text / no URL** — raw content provided inline
   → Save to `raw/` with standardized frontmatter, then process

## Raw File Conventions

All extracted content saved to `raw/` gets standardized frontmatter (format defined in each handler). File naming:

- Videos: `raw/videos/YYYY-MM-DD title-slug.md` (or `raw/debates/` for debate content)
- Articles: `raw/articles/YYYY-MM-DD title-slug.md`
- Other: `raw/YYYY-MM-DD title-slug.md`

## Processing Principles

1. **Raw files are immutable** — never modify source material in `raw/`
2. **Graceful degradation** — if automated extraction fails, guide user to manual path per handler's failure table
3. **Discuss before bulk processing** — present key takeaways and proposed pages to the user before creating wiki pages
4. **Never fabricate** — if extraction fails, say so. Don't fill gaps with assumptions.
