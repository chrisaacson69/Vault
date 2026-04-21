---
name: career-slides
description: Generate a presentation from vault content — reads research pages, produces Marp slides, exports to HTML and optionally video. Use when the user says "make a presentation about", "generate slides for", "career slides", or wants to demo the L0-6 framework.
user-invocable: true
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, Agent
---

## Career Slides Generator

Base directory: `C:\Users\Chris.Isaacson\Vault`

**Shared procedures:** Follow [vault-page.md](../../shared/vault-page.md) for reading vault content and understanding page structure.

Generate a polished Marp slide deck from vault content, export to HTML for browser presentation, and optionally composite into a video.

### 1. Determine Topic & Source Pages

If the user specifies a topic, search the vault for relevant pages:
- Read `INDEX.md` to find pages matching the topic
- Read the relevant pages to extract key points, tables, data, and quotes
- If no topic specified, default to the L0-6 AI Engineering framework using:
  - `research/level-6-direct-execution.md`
  - `research/cyborg-model.md`
  - `research/economics/llm-praxeology.md`
  - `research/economics/praxis-agent-teams.md`

### 2. Generate Marp Markdown

Write the slide deck to `career/slides-output.md` using this template structure:

```yaml
---
marp: true
theme: gaia
class: lead
paginate: true
backgroundColor: #1a1a2e
color: #eee
headingDivider: 2
style: |
  section {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  }
  section.lead h1 {
    color: #e94560;
    font-size: 2.5em;
  }
  section.lead h2 {
    color: #0f3460;
    background: #e94560;
    padding: 0.2em 0.5em;
    border-radius: 8px;
    font-size: 1.4em;
  }
  section h2 {
    color: #e94560;
  }
  table {
    font-size: 0.7em;
  }
  strong {
    color: #e94560;
  }
  a {
    color: #16c79a;
  }
  code {
    background: #0f3460;
    color: #16c79a;
    padding: 0.1em 0.3em;
    border-radius: 4px;
  }
  section.lead p {
    font-size: 0.9em;
    color: #aaa;
  }
---
```

**Slide guidelines:**
- First slide: title + subtitle (uses `class: lead` from frontmatter)
- Each `##` heading starts a new slide (via `headingDivider: 2`)
- Keep text concise — bullets, not paragraphs
- Use tables for comparisons (they render well with the custom theme)
- Use `>` blockquotes for emphasis/callouts
- Add speaker notes in HTML comments: `<!-- note text -->`
- Last slide: the meta-argument / call to action
- Target 8-12 slides for a 5-10 minute presentation

### 3. Export to HTML

Run:
```bash
npx @marp-team/marp-cli --no-stdin career/slides-output.md -o career/slides-output.html --html
```

Then open in browser:
```bash
start "" "C:/Users/Chris.Isaacson/Vault/career/slides-output.html"
```

**IMPORTANT:** Always present via browser HTML or `marp -p` preview window. Never present inside Obsidian — the Obsidian Marp plugin renders inline in a note pane and looks unprofessional.

### 4. Optional: Live Preview Mode

If the user wants to watch slides generate in real-time:
```bash
npx @marp-team/marp-cli --no-stdin -w -p career/slides-output.md
```
This opens a preview window that auto-refreshes as the file is written.

### 5. Optional: Export to Video

If the user wants a video version:

1. Export slides as PNGs:
```bash
npx @marp-team/marp-cli --no-stdin --images png --image-scale 2 career/slides-output.md -o career/slides/slide.png
```

2. Ask the user for per-slide timing (seconds per slide), or default to 8 seconds each.

3. Build the ffmpeg command dynamically:
   - Each slide input: `-loop 1 -t <seconds> -i slides/slide.NNN.png`
   - Add fade transitions: `fade=t=in:st=0:d=1,fade=t=out:st=<T-1>:d=1`
   - First slide: fade out only. Last slide: fade in only.
   - Concatenate and encode: `-c:v libx264 -pix_fmt yuv420p -r 24`
   - Output to `career/slides-video.mp4`

4. Open the result:
```bash
start "" "C:/Users/Chris.Isaacson/Vault/career/slides-video.mp4"
```

### 6. Report

Tell the user:
- How many slides were generated
- Which vault pages were sourced
- What outputs are available (HTML, video)
- Suggest timing adjustments if video was generated
