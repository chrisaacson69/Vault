---
status: active
created: 2026-04-15
published: true
title: The Role Landscape
summary: Mapping industry titles to what we're actually doing. The terminology is settling but hasn't caught up to the frontier.
layout: layouts/page.njk
---
# The Role Landscape — What the Industry Calls This
> Mapping industry titles to what we're actually doing. The terminology is settling but hasn't caught up to the frontier.

**Links:** [Career](./README.md), [Level 6 — Direct Execution](../research/level-6-direct-execution.md), [The Cyborg Model](../research/cyborg-model.md), [LLMs as Praxeological Actors](../research/economics/llm-praxeology.md)

## The Title Hierarchy

Based on job posting analysis (889 postings, Jan 2026 — AI Shipping Labs) and industry discourse:

### Tier 1: The Dominant Title — "AI Engineer"

Coined by swyx (Shawn Wang, 2023). The fastest-growing job title in tech per LinkedIn's 2026 report.

**The critical distinction:** AI Engineer builds **with** AI models, not the models themselves. As swyx put it, quoting Karpathy: *"One can be quite successful in this role without ever training anything."*

From the 889-posting analysis:
- **70%** are "AI-first roles" — RAG pipelines, agent workflows, production deployment
- **Only 2%** are traditional ML/DL (model training)
- **95.6%** are production-focused, not research
- Top skills: RAG (35.9%), Prompt Engineering (29.1%), LLM Integration (25.4%), Python (82.5%)

**Proposed definition:** *"An AI engineer is an engineer who owns the design, evaluation, and production operation of systems built on foundation models."*

This is the safe, widely-understood, resume-friendly title. It maps to what we do.

### Tier 2: Emerging Specialized Titles

| Title | What It Means | Fit |
|---|---|---|
| **Agentic AI Engineer** | Multi-agent orchestration, autonomous workflows, tool-use patterns. 10K+ postings on Indeed. EY, Deloitte actively hiring. | Strong — maps to vault's agent team work |
| **Forward Deployed Engineer** | Client-facing AI implementation. 800% growth Jan-Sep 2025. Anthropic, OpenAI, Cohere expanding teams. | Good if consulting/client work |
| **AI Software Engineer** | Hybrid — traditional SWE + AI deployment. API integrations, system design, prompt engineering. | Accurate but generic |
| **Generative AI Developer** | RAG systems, prompt optimization, model architecture understanding. $150K-$250K range. | Slightly narrow |
| **Full-Stack AI Engineer** | End-to-end AI application development. Lockheed Martin and others posting this. | Good for signaling breadth |

### Tier 3: Dying or Misaligned Titles

| Title | Status | Why Not |
|---|---|---|
| **Prompt Engineer** | 40% decline 2024-2025. Being absorbed as a skill, not a role. | Too narrow, shrinking market |
| **ML Engineer** | Means model training (PyTorch, TensorFlow, math). Works below the API boundary. | Wrong side of the line |
| **Vibe Coder** | Real postings exist (223+, including Google, Visa, Amazon). Defined as "translate intent into prompts, assess and refine outputs." | Skews junior. Not the gravitas for 15+ years of experience |
| **AI-Augmented Developer** | Gartner uses it, but rarely appears in actual postings. | Descriptive, not hireable |

## The API Boundary

The cleanest distinction (from Humanloop):

- **ML Engineers** work **below** the API boundary — creating and training models
- **AI Engineers** work **above** it — using models to solve product challenges
- Recommended team ratio: ~4 AI Engineers per 1 ML Engineer

This maps perfectly. We never train models. We design systems that use them.

## The Level Gap

Here's the problem: most "AI Engineer" postings describe **L2-L3 work** — integrate an LLM into an existing product, build a RAG pipeline, add a chatbot. The vault's work is at **L4-L6**:

| Posting Reality | Vault Reality |
|---|---|
| "Integrate LLM into existing workflow" | Agent IS the workflow |
| "Build RAG pipeline" | Knowledge system with cross-linked wiki, automated ingestion, self-maintaining indexes |
| "Prompt engineering" | Multi-agent orchestration with specialized roles |
| "Add AI features to product" | AI-native architecture where the agent executes processes directly |
| "Deploy chatbot" | Agent teams that write code, review PRs, manage infrastructure |

The title "AI Engineer" is correct but understates the scope. The industry hasn't standardized titles for L5-L6 work because most of the industry isn't there yet — the Pragmatic Engineer survey found **90% of developers who think they're AI-native are at L2.**

## Where Senior Experience Matters

The Pragmatic Engineer's 2026 AI Tooling survey (906 respondents, median 11-15 years experience):

- **Staff+ engineers** are the heaviest AI agent adopters at **63.5%** — higher than any other seniority level
- Directors and senior leaders are *"especially into Claude Code — twice as popular with these folks as at less senior levels"*
- The skills that matter at senior levels: *"AI fluency, judgment over speed, system thinking, communication, and automation mindset"*

This inverts the naive expectation. It's not juniors adopting AI fastest — it's seniors who know what to build and can evaluate whether the AI built it correctly. The [Cyborg Model](../research/cyborg-model.md) predicted this: the human provides judgment, taste, and grounding. That requires experience.

## Positioning Strategy

**Resume title:** Senior AI Engineer (or Staff AI Engineer)
- "Senior" signals experience depth. "AI Engineer" signals the right domain.
- Avoid "Senior Developer who uses AI" — that frames AI as an add-on, not the core method.

**Differentiators to emphasize:**
1. **Agentic architecture** — designing multi-agent systems, not just calling APIs
2. **Knowledge system design** — the vault pattern (structured knowledge bases that agents maintain and query)
3. **L5-L6 workflow design** — agents executing processes, not just generating code
4. **AI economics** — understanding why agent teams succeed or fail (grounding, comparative advantage, the cyborg model)
5. **Evaluation and judgment** — the senior skill that makes AI useful instead of dangerous

**Portfolio evidence (from this vault):**
- Projects built with AI agent teams (Slay, CyborgDJ, YouTube Migration)
- The vault itself as a knowledge management system
- Level 6 analysis and predictions
- Economic frameworks for AI agent behavior

## Key Sources

- swyx, "The Rise of the AI Engineer" (Latent.Space, 2023)
- AI Shipping Labs, "What is an AI Engineer? — 1000+ Job Descriptions" (Jan 2026)
- Pragmatic Engineer, "AI Tooling for Software Engineers in 2026" (906 respondents)
- LinkedIn "Jobs on the Rise" 2026 report
- Humanloop, "What is an AI Engineer?" (API boundary framework)

## Tags

[ai](../tags/ai.md), [career](../tags/career.md)
