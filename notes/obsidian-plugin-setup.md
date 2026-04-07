---
status: active
created: 2026-04-07
---
# Obsidian Plugin Setup
> Setup instructions for Dataview, Marp Slides, and Web Clipper — the three plugins that complete the Karpathy-style LLM wiki pattern.

**Links:** [INDEX](../INDEX.md), [Working With Claude](./working-with-claude.md)

## 1. Dataview

**What it does:** Queries your vault like a database. Filters by status, date, folder, tags, links.

**Install:** Settings > Community Plugins > Browse > search "Dataview" > Install > Enable.

**Recommended settings** (Settings > Dataview):
- Enable JavaScript queries: ON (for dashboard blocks)
- Enable inline queries: ON (for `= this.status` in pages)

**Example queries for this vault:**

All active research, sorted by date:
````
```dataview
TABLE status, created
FROM "research"
WHERE status = "active"
SORT created DESC
```
````

Everything linking to a specific tag file (put this inside a tag index page):
````
```dataview
LIST
FROM [[tags/philosophy]]
SORT file.name ASC
```
````

Recently modified pages across the vault:
````
```dataview
TABLE file.folder AS "Location", status
SORT file.mtime DESC
LIMIT 20
```
````

Pages grouped by status:
````
```dataview
TABLE rows.file.link AS "Pages"
WHERE status
GROUP BY status
```
````

Page counts per folder (DataviewJS):
````
```dataviewjs
for (let folder of ["projects", "research", "notes", "tasks", "logs"]) {
  let count = dv.pages('"' + folder + '"').length;
  dv.paragraph(`**${folder}:** ${count} pages`);
}
```
````

**Key detail:** Our `## Tags` section uses markdown links like `[philosophy](../../tags/philosophy.md)`. Dataview's `FROM [[tags/philosophy]]` finds all pages containing a link to that tag file — so our existing tag system works with Dataview out of the box. No need for `#hashtag` syntax.

---

## 2. Marp Slides

**What it does:** Renders markdown files with `marp: true` frontmatter as slide decks. Preview in Obsidian, export to PDF/PPTX/HTML.

**Install:** Settings > Community Plugins > Browse > search "Marp Slides" (by Samuele Cozzi) > Install > Enable.

**Configuration** (Settings > Marp Slides):
- Chrome Path: leave default (auto-detects Edge on Windows 11)
- Enable HTML: ON

**CLI also installed:** `marp` is available in terminal for batch export:
```bash
marp slides.md --pdf
marp slides.md --pptx
marp slides.md --html
```

**Quick start:** Any research page can become a rough slide deck by adding this frontmatter and using `---` between slides:
```yaml
---
marp: true
theme: gaia
paginate: true
headingDivider: 2
---
```
With `headingDivider: 2`, every `##` heading starts a new slide automatically.

---

## 3. Web Clipper

**What it does:** Clips web articles to markdown, drops them in your vault's `raw/` folder for ingestion.

**Install:** Browser extension — search "Obsidian Web Clipper" in Chrome/Edge/Firefox extension store. Official extension by the Obsidian team.

**Configure the template** (click extension icon > settings gear):

1. Edit the default template or create a new one called "Vault Ingest"
2. Set these fields:
   - **Vault:** your vault name
   - **Folder (path):** `raw`
   - **Note name:** `{{date|date:"YYYY-MM-DD"}} {{title|safe_name}}`
3. Set properties (frontmatter):
   - `source`: `{{url}}` (text)
   - `author`: `{{author}}` (text)
   - `title`: `{{title}}` (text)
   - `clipped`: `{{date|date:"YYYY-MM-DD"}}` (text)
   - `published`: `{{published}}` (text)
4. Note content format: `{{content}}`

**Optional: URL-based triggers** — auto-select templates by site:
- YouTube URLs → a YouTube template that captures video metadata
- arXiv URLs → a paper template with abstract extraction
- Community templates at [github.com/obsidian-community/web-clipper-templates](https://github.com/obsidian-community/web-clipper-templates)

**Workflow:** Clip article > it lands in `raw/` > tell Claude "ingest the new raw file" > Claude processes it into vault pages.

**Keyboard shortcut:** `Alt+Shift+O` (Windows) for quick clip without opening the UI.

---

## Optional: Local Images

By default, Web Clipper links to remote image URLs (which can break). To save images locally:

1. Obsidian Settings > Files and Links > Attachment folder path > set to `raw/assets/`
2. Settings > Hotkeys > search "Download" > bind "Download attachments" to `Ctrl+Shift+D`
3. After clipping, open the note and hit `Ctrl+Shift+D` to pull images locally.

## Tags

[ai](../tags/ai.md)
