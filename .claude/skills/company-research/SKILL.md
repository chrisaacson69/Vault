---
name: company-research
description: Deep-dive a target company for interview prep — tech stack, AI initiatives, culture, open problems, recent news. Use when the user says "research <company>", "what does <company> do with AI", "company-research", or is preparing for an interview.
user-invocable: true
allowed-tools: Read, Write, Edit, Grep, Glob, Bash, Agent, WebFetch, WebSearch
---

## Company Research Agent

Base directory: `C:\Users\Chris.Isaacson\Vault`

**Shared procedures:** Follow [web-research.md](../../shared/web-research.md) for all search and synthesis operations. Follow [vault-page.md](../../shared/vault-page.md) for page creation conventions.

### 1. Parse Input

Extract:
- **Company name**
- **Target role** (if specified)
- **Specific questions** the user wants answered

Check `career/active-postings.md` for existing posting details.

### 2. Research Areas

Launch parallel Agent searches where possible. For each area, follow web-research.md methodology:

| Area | What to Find | Search Pattern |
|---|---|---|
| **Overview** | What they do, size, revenue, recent trajectory | `"<company>" overview 2026` |
| **AI & Tech** | AI initiatives, tech stack, LLM providers, agentic work | `"<company>" AI engineering blog`, `"<company>" github` |
| **Culture** | Engineering blog, conference talks, remote policy, values | `"<company>" engineering culture` |
| **AI Leadership** | VP/Director names, team size, growth | `"<company>" VP AI linkedin` |
| **Challenges** | Open problems, strategic shifts, hiring gaps | `"<company>" challenges 2026` |
| **Financials** | Earnings, funding, growth trajectory | `"<company>" earnings 2026` |

### 3. Map Vault Experience

Read relevant vault pages to identify talking points:
- `career/strategy.md` — performative loop argument
- `career/role-landscape.md` — role mapping
- `INDEX.md` → relevant project pages
- `research/level-6-direct-execution.md`, `research/cyborg-model.md`, `research/economics/praxis-agent-teams.md`

Identify 3-5 vault projects/research that map to company needs.

### 4. Write Briefing

Save to `career/research-<company-slug>.md` following vault-page.md conventions.

Include:
- **Company overview** — 2-3 paragraphs
- **AI & Technology** — initiatives, stack, providers
- **Engineering culture** — team structure, values, open source
- **AI leadership** — who runs AI, background
- **Challenges & opportunities** — talking points
- **Vault experience mapping** — table: Their Need | Your Evidence | Vault Page
- **Potential interview questions** — based on role + company
- **Key talking points** — 3 specific connections
- **Red flags / concerns** — layoffs, bad reviews, pivot risk
- **Sources** — list of URLs

Tag with `[career](../tags/career.md)`.

### 5. Report

Tell the user: key findings (2-3 bullets), strongest vault connections, red flags, suggested next steps.
