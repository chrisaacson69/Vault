# The Vault — an OS for ideas, projects, and the discipline that ties them together

**Mental model: the vault is an OS; the tasks/projects are the apps.** This file is the OS manual —
how the vault is organized, how to navigate it, and how to use it. The vault is *not* "a knowledge
base"; the knowledge base (`research/`) is one **partition** of it, alongside the project process-table
(`projects/`), the I/O subsystem (`raw/`), and the rest. Rules live at the altitude they apply:

- **Kernel** (universal law, loads in *every* repo) → user-global `~/.claude/CLAUDE.md`: grounding + how-Chris-works. The one thing always resident.
- **Shell / OS manual** (navigate + use the vault) → *this file*. Loads when working in the vault.
- **Per-partition rules** → each section's own header / `CLAUDE.md` (e.g. `projects/CLAUDE.md` = the project SDK). Loads when working in that partition.
- **Router** → `memory/MEMORY.md` (pointers) → area indexes (recalled on relevance) → vault pages / repos (deep stores).
- **Syscalls** → the skills (`vault-sync`, `vault-ingest`, `vault-heartbeat`, `label-walk`, …).
- **Device manager** → logical-name pointers (in `projects/`) resolved to physical mounts via per-machine `.claude/local-paths.md`.

## Grounding Discipline — Read First (non-negotiable)

Chris's #1 standing rule: **never fabricate, and never rebuild what already exists. When grounding is missing, go find it or ask — do not fill the gap with an assumption.** Fabrication has two masks; both are forbidden:

1. **Inventing a fact** instead of asking for clarity. If you're uncertain, the goal is ambiguous, or you're missing context — *ask*, or surface the gap explicitly. Do not paper over it with a confident guess. (A failed or empty tool result is not data — verify with a second tool before acting on it.)
2. **Building from scratch** instead of reusing/converting a grounded artifact that already exists. Before writing anything new (a sim, a parser, a table, a generator), check whether decompiled source, an existing tool, or a prior artifact already answers the question or can be *converted* into the answer. Reuse/convert beats rebuild — a rebuild is an *unverified* new artifact; a conversion is *cross-checked* against its source.

**Why this matters (the payoff, not just the prohibition):** every grounded artifact you reuse or mint is simultaneously a verifier (Layer 2) and a piece of the environment (Layer 3). Converting NA1's decompiled source instead of rebuilding a sim gave output that was *both* bytecode-verified and sim-verified — mutually-confirming oracles — and left behind a new standing source of truth that answers future questions by reading, not just by running. Each artifact is another way to triangulate truth, so drift has fewer places to hide.

Most of this rule cannot be enforced by a hook (there's no enforcement point for "felt uncertain"), so it lives here as a hard request — and the structural cure is to keep grounded context reachable so reuse is always the cheap, obvious path. See [The Three-Layer Method](./research/karpathy-three-layer-method.md). **The one mechanically-enforceable sub-rule IS now enforced:** a `PreToolUse` hook (`.claude/hooks/protect-raw.js`) blocks any Edit/overwrite of an existing file under `raw/` (creating new captures is still allowed). raw-immutability is a *rule*, not a request.

**Reuse requires findability — protect the meta-tool.** The cure above only works if you can *find* the existing artifact, so the routing layer (the index/hierarchy) is the precondition for everything else. The discipline: keep the index in context (INDEX.md for pages, MEMORY.md for facts, project READMEs/CONTEXT for tools), and dig for specifics on demand — don't load everything. Adding capability is not "append a file": it is *integrate* — register it in the index (rules 1, 4, 5 below) and evict or supersede what it replaces, so nothing gets silently shadowed. Append-without-eviction rots the tool bank exactly the way it rots memory: the old becomes unfindable, then forgotten, then rebuilt. **Before creating or testing new tools, verify the meta-tool model still routes cleanly to what already exists.**

**External repos — resolve by logical name, never hardcode paths.** The vault is portable (committed, syncs across machines); absolute local paths are not. So committed pages refer to external repos by **logical name + GitHub URL** (portable identity) and by the **relative sibling convention** `../<name>` (works when repos are cloned side-by-side). The **absolute local path on this machine** is resolved via [`.claude/local-paths.md`](./.claude/local-paths.md) — a per-machine, gitignored resolver table. When you need an external repo's files, look its logical name up there; if it's missing, *ask* — don't guess a path. Never commit an absolute `C:\…` path into a vault page (several are `published: true` and go to the public site).

## Operating Context & universal grounding → user-global

The universal behavioral law — **how Chris works** (structure-over-demos, quality-not-volume, reuse>rebuild, verification-independence, classify-architecture-first, symmetric-grounding, explicit-mode) and the **grounding core** — lives one tier up, in the user-global `~/.claude/CLAUDE.md`, so it loads in *every* repo (the sibling code projects, not just the vault). Provenance for each rule is in the memory area indexes (`area_user_career`, `area_re_method`, `area_vault_system`, `area_politics`). **Everything below this point is vault-*specific*** — the structure, usage, and maintenance rules that only apply when working inside the vault.

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

### Partitions (folders) — what each is, and where its rules live

| Partition   | Role in the OS | What goes here | Its rules |
|-------------|----------------|----------------|-----------|
| `research/` | **idea partition** — `/home` | Topics explored: spawn a hypothesis, later crystallize it. *This is the "knowledge base" — one partition, not the whole vault.* | conventions below |
| `projects/` | **process table** | Pointers to the running apps (external repos), modeled as a **package library with dependencies**. | **`projects/CLAUDE.md` — the project SDK** (how to do a project) |
| `raw/`      | **I/O subsystem** | Unprocessed source material (Web Clipper drops, PDFs, transcripts) consumed by ingestion. *Immutable — enforced by a `PreToolUse` hook.* | "Raw Ingestion Workflow" below |
| `career/`   | partition | Career development, what works/doesn't with AI at the *career* level (≠ the project-execution SDK, which lives in `projects/`). | conventions below |
| `notes/`    | partition | Quick captures, standalone thoughts | conventions below |
| `tasks/`    | partition | Goals, to-do tracking, milestones | conventions below |
| `logs/`     | partition | Session logs, journals, progress entries | conventions below |
| `tags/`     | index | Auto-maintained tag index files (cross-referencing) | maintained by `vault-sync` |

### Raw Ingestion Workflow

The `raw/` folder holds unprocessed source material — Web Clipper articles, PDFs, transcripts, copied text. When asked to ingest a source:

1. **Read the raw source** and discuss key takeaways with Chris.
2. **Decide where it belongs** — new research page, addition to existing page, or note.
3. **Create or update wiki pages** — extract entities, concepts, and arguments into proper vault pages with cross-links.
4. **Update the index** — add new pages to INDEX.md.
5. **Update tag indexes** — ensure tag files have back-links for any new pages.
6. **Log the ingest** — note what was processed and what pages were created/updated.

A single raw source may touch 5-15 wiki pages. The raw file itself is never modified — it's the source of truth. **This is enforced**, not just convention: a `PreToolUse` hook blocks edits/overwrites to existing files under `raw/` (new files are allowed — that's capture). See the Grounding Discipline section above.

### How Claude Should Work With This Vault

1. **Always check INDEX.md first** when looking for existing content — it's the master map.
2. **Cross-link aggressively** — when creating or updating a file, link it to related files and update their link sections too.
3. **Maintain tag indexes** — when tagging a file, ensure the corresponding tag file in `/tags/` has a back-link.
4. **Keep INDEX.md current** — add new files to the index when they're created.
5. **Prefer updating over duplicating** — search for existing notes, *and existing tools/skills/artifacts*, before creating new ones. This is the vault-page-and-tooling instance of the Grounding Discipline above (reuse/convert beats rebuild). An addition that doesn't update the index (rule 4) is net-negative: it adds search cost without adding *findable* capability.
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
