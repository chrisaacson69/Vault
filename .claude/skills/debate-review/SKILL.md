---
name: debate-review
description: Analyze an online debate and create a vault page with argument structures, key moves, structural analysis, and vault connections. Use this when the user shares a debate link or transcript for review.
user-invocable: true
allowed-tools: Read, Edit, Write, Glob, Grep, Bash, Agent, WebFetch
---

## Debate Review Procedure

Create a comprehensive debate analysis for the vault at `C:\Users\Chris.Isaacson\Vault`.

**Shared procedures:**
- [content-extract.md](../../shared/content-extract.md) — YouTube transcript extraction, SRT cleaning, raw file conventions
- [vault-page.md](../../shared/vault-page.md) — page format, cross-linking, file placement

### 1. Acquire Transcript

Follow content-extract.md for source type detection and extraction. If given a YouTube URL:
- Use `yt-dlp` to download the transcript: `yt-dlp --write-auto-sub --sub-lang en --sub-format srt --skip-download -o "/tmp/transcript-name" "URL"`
- Read the SRT file and strip timestamp formatting.
- Save raw transcript to `Vault/raw/debates/` for reference.
- Ask the user for the debate start/end timestamps if not provided.
- Extract the debate portion (excluding pre-show, after-panels, audience Q&A unless specifically requested).

If given a non-YouTube URL, use `WebFetch` to get the content. If that fails (bot-blocked), tell the user to clip it manually with Web Clipper to `raw/` and point you at the file.

### 2. Read and Analyze

Read the full debate transcript. Identify:
- **Participants** — names, positions, backgrounds.
- **Format** — opening statements, cross-examination, closing, etc.
- **Core thesis** of each side.
- **Key arguments** — the 3-5 most substantive exchanges.
- **Structural moves** — where arguments succeed or fail structurally, not just rhetorically.
- **Vault connections** — which existing vault frameworks apply (scope confusion, performative grounding, game theory, economics, etc.).

### 3. Write the Vault Page

Create the page at `Vault/research/debates/<descriptive-filename>.md` using this format:

```markdown
# Debate Title
> One-line thesis summary.

**Date:** YYYY-MM-DD
**Source:** [Platform — Channel/Show](URL) — [Transcript](../../raw/debates/transcript-file.txt)
**Participants:** Name (position) vs Name (position)
**Moderator:** Name (if applicable)
**Duration:** approximate
**Result:** outcome if known
**Vault relevance:** [linked pages]

---

## Context
Brief background on the topic and why it matters.

## Argument Structures
### Affirmative / Side A
Numbered argument structure.

### Negative / Side B
Numbered argument structure.

## Analysis
### Key Argument 1: Title
What happened, why it matters structurally.

### Key Argument 2: Title
(repeat as needed)

## Structural Problems
What broke in each side's reasoning.

## Toolkit (if applicable)
Concrete tools for engaging with these arguments in the future.

## Vault Connections
Bulleted list linking to existing vault pages with one-line explanation of each connection.

## Open Questions
What remains unresolved or worth exploring further.

## Tags
[tag links]
```

### 4. Focus: Arguments Over Rhetoric

The user cares about **argument structure and logical validity**, not who "won" stylistically. Focus on:
- Where premises are unsupported.
- Where fallacies occur — but explain WHY they matter, don't just label them (see [The Fallacy Fallacy](../../research/philosophy/the-fallacy-fallacy.md)).
- Where scope confusion is operating.
- Where arguments connect to or challenge existing vault frameworks.

### 5. Update Vault Infrastructure

After creating the page, run the vault-sync procedure:
- Update `Vault/research/debates/README.md`
- Update `Vault/INDEX.md`
- Update tag files and tag index counts
- Add cross-links to referenced vault pages
