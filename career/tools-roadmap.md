---
status: active
created: 2026-04-15
---
# Career Tools Roadmap
> Each tool demonstrates the thesis it's designed to sell. The process of building them IS the portfolio.

**Links:** [Career](./README.md), [Strategy](./strategy.md), [Role Landscape](./role-landscape.md)

## Phase 1: Foundations (build now)

| # | Tool | What It Does | Status |
|---|---|---|---|
| 1 | **Live Presentation Generator** | Reads vault → generates Marp slides → HTML + video. [Full spec](./presentation-generator-spec.md) | `/career-slides` skill live |
| 2 | **Vault-to-Resume Skill** | Reads vault projects + job description → tailored resume. Reference: [claude-code-job-tailor](https://github.com/javiera-vasquez/claude-code-job-tailor) | Not started |
| 3 | **Salary Intelligence Agent** | Aggregates multiple sources → cross-referenced comp analysis by role/location. | `/salary-intel` skill live |

## Phase 2: Search & Application (build when Phase 1 works)

| # | Tool | What It Does | Status |
|---|---|---|---|
| 4 | **Job Scanner Agent** | Targeted search with A-F grading per posting. Human-in-the-loop approval. Reference: [Career-Ops system](https://dev.to/santifer/i-built-a-multi-agent-job-search-system-with-claude-code-631-evaluations-12-modes-2cd0) | Not started |
| 5 | **Company Research Agent** | Deep-dives target company: tech stack, AI initiatives, news, open problems → structured briefing. | `/company-research` skill live |
| 6 | **Tailored Application Generator** | Full package per approved posting: tailored resume (#2) + cover letter + portfolio links. Depends on #2 and #4. | Not started |

## Phase 3: Interview & Presentation (build during active search)

| # | Tool | What It Does | Spec |
|---|---|---|---|
| 7 | **Interview Prep Agent** | STAR-format answers from real vault project history. Company-specific technical questions. Depends on #5. | — |
| 8 | **AI Intro Video Generator** | 2-3 min video: L5-6 thesis + vault evidence. Script → slides → TTS/narration → compositing via [animation-studio](https://github.com/chrisaacson69/animation-studio). Most ambitious — build last. | — |
| 9 | **Live Portfolio Site** | Eleventy site generated from vault. `published: true` in frontmatter controls visibility. GitHub Pages deployment. | Built — Eleventy + templates working |

## The Structural Advantage

No existing career tool connects to a personal knowledge base. Every commercial tool starts from a blank form. This pipeline reads the vault — 145+ cross-linked pages of real projects, research, and frameworks. The content already exists. These tools select, shape, and deliver it.

See [strategy.md](./strategy.md) for why this is a Gödel loop: the tools that find the job prove you can do the job.

## Tags

[ai](../tags/ai.md), [career](../tags/career.md)
