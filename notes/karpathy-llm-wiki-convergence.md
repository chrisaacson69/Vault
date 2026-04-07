---
status: reference
created: 2026-04-07
---
# Karpathy LLM Wiki — Independent Convergence
> This vault and Karpathy's "LLM Wiki" pattern arrived at the same architecture independently. When two systems converge from different starting points, the shared structure is likely load-bearing.

**Links:** [Obsidian Plugin Setup](./obsidian-plugin-setup.md), [Working With Claude](./working-with-claude.md), [Cyborg Model](../research/cyborg-model.md)

## Source

- **Gist:** [karpathy/LLM Wiki](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) (2026-04-02)
- **Video walkthrough:** [Nate Herk — "Andrej Karpathy Just 10x'd Everyone's Claude Code"](https://www.youtube.com/watch?v=sboNwYmH3AY) (2026-04-05)

## The Shared Architecture

Both systems independently arrived at:

| Pattern | Karpathy | This Vault |
|---------|----------|------------|
| Knowledge representation | Folder of markdown files | Same |
| Master map | `index.md` | `INDEX.md` |
| Agent schema | `CLAUDE.md` / `AGENTS.md` | `CLAUDE.md` |
| Cross-references | LLM-maintained links between pages | `**Links:**` sections + `## Tags` with back-links |
| Tag/category system | Tags on pages | Tag index files in `tags/` with reverse-links |
| Visual frontend | Obsidian | Obsidian |
| Version control | Git repo | Git repo |
| Ingest operation | Drop raw source, LLM processes into wiki | `raw/` folder + `/vault-ingest` skill |
| Query operation | Ask questions, get answers with citations | Normal vault interaction |
| Lint/health check | Periodic LLM health-check | `/vault-heartbeat` skill |
| Log | `log.md` (chronological) | `logs/` folder |

## Where This Vault Goes Further

- **Automated maintenance skills** — `/vault-sync` updates INDEX, tags, cross-links in one pass. Karpathy's workflow is manual.
- **Domain-specific ingest** — `/debate-review` is a structured pipeline for a specific source type. `/vault-ingest` dispatches by content type (article, YouTube, raw file). Karpathy's ingest is generic.
- **Cross-project transfer** — `/vault-to-project` pushes vault research into project CLAUDE.md files. Karpathy doesn't address how wiki knowledge flows into working codebases.
- **Persistent memory layer** — Claude Code's `memory/` system survives across conversations. Karpathy's "hot cache" is a single file inside one project.
- **Tag indexes as first-class objects** — Tag files are pages with reverse-links, visible in graph view and queryable via Dataview's `FROM [[tags/tagname]]`.

## Ideas Adopted From Karpathy

- **`raw/` folder** — separation of immutable source material from processed wiki pages. Content was growing inside the vault structure; centralizing it in `raw/` keeps the wiki clean and gives a clear ingest pipeline.
- **Marp slide decks** — markdown-to-slides for generating presentations from research content. CLI installed (`marp`), Obsidian plugin available.
- **Web Clipper** — browser extension for one-keystroke article capture to `raw/`. Manual path when automated fetch is bot-blocked.
- **Dataview plugin** — queryable vault via YAML frontmatter. Triggered migration of all 128 vault pages from bold-text metadata to YAML frontmatter.
- **"File good answers back into the wiki"** — explicitly naming the practice of turning query results and syntheses into vault pages, not just chat output.

## Why Convergence Matters

Independent convergence from different starting points (Karpathy: research paper wikis; this vault: philosophy/economics/gaming research + debate analysis) suggests the shared patterns are structurally necessary, not stylistic choices:

1. **Markdown files > vector databases** — at current context window sizes, a well-indexed folder is a better knowledge representation than embeddings or RAG.
2. **The LLM is the maintenance team** — wikis die because humans won't do bookkeeping. LLMs don't get bored.
3. **Index files > embedding search** — at moderate scale (~100-500 pages), a maintained index is more reliable than semantic search.
4. **The filesystem is the database** — no infrastructure needed. Git gives you versioning, branching, and collaboration for free.

Karpathy frames this through Vannevar Bush's Memex (1945) — a personal knowledge store with associative trails between documents. Bush's vision was closer to this than to what the web became: private, actively curated, with the connections between documents as valuable as the documents themselves. The missing piece was who does the maintenance. The LLM handles that.

## Tags

[ai](../tags/ai.md), [epistemology](../tags/epistemology.md)
