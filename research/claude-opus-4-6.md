# Claude Opus 4.6 — Research
> Tracking what's known about Claude Opus 4.6 capabilities, benchmarks, and real-world results.

**Status:** active
**Created:** 2026-02-12
**Links:** [Vault Index](../INDEX.md)

## Sources

### Video 1: "How Anthropic's AI Bankrupted Itself"
- **URL:** https://www.youtube.com/watch?v=zMDXzG1kA14
- **Transcript:** [transcript1_clean.txt](./transcript1_clean.txt)
- **Focus:** Anthropic's "Claudius" vending machine experiments — AI agent running a small business
- **Key takeaway:** AI agents (Sonnet 4.0/4.5 era) are still vulnerable to prompt injection and social engineering, but the controlled experiment showed modest profit is possible when inputs are tightly managed

### Video 2: "Claude Opus 4.6: The Biggest AI Jump I've Covered"
- **URL:** https://www.youtube.com/watch?v=JKk77rzOL34
- **Transcript:** [transcript2_clean.txt](./transcript2_clean.txt)
- **Focus:** Opus 4.6 capabilities, benchmarks, real-world deployments
- **Key takeaway:** Generational leap — autonomous coding went from 30 min to 2 weeks in 12 months

## Key Claims & Data Points

### Context Window & Retrieval
- 5x context expansion: 200K tokens (Opus 4.5) -> 1M tokens (Opus 4.6)
- Can hold ~50,000 lines of code in a single session (up from ~10,000)
- **MRCV2 needle-in-haystack scores:**
  - Sonnet 4.5: 18.5% at 1M tokens
  - Gemini 3 Pro: 26.3%
  - **Opus 4.6: 76% at 1M tokens, 93% at 256K tokens**
- The retrieval improvement is more important than raw context size

### Autonomous Coding
- 16 Opus 4.6 agents built a fully functional C compiler in Rust over 2 weeks
  - 100,000+ lines of code
  - Builds Linux kernel on 3 architectures
  - Passes 99% of torture test suite
  - Compiles PostgreSQL
  - Cost: ~$20,000
- Trajectory: 30 min -> 7 hours (Rakuten, summer) -> 2 weeks (Feb 2026)

### Agent Teams ("Team Swarms")
- Multiple Claude Code instances running simultaneously, each in own context window
- Lead agent decomposes work, assigns to specialists, tracks dependencies
- Peer-to-peer messaging between agents (not just hub-and-spoke)
- 13 distinct operations for spawning, managing, coordinating agents
- Shipped as a built-in feature of Opus 4.6

### Security Research
- Given basic tools (Python, debuggers, fuzzers) and pointed at open-source code
- Found 500+ previously unknown zero-day vulnerabilities
- Code had been reviewed by human researchers and scanned by automated tools
- Independently decided to analyze git history when other methods failed
- Invented its own detection methodology

### Rakuten Deployment
- Opus 4.6 on their issue tracker in production
- Closed 13 issues autonomously in a single day
- Assigned 12 issues to correct team members across 50-person org and 6 repos
- Understood org chart, team ownership, when to escalate
- Building ambient agent: 24 parallel Claude Code sessions on their monorepo
- Non-technical employees contributing to development via Claude Code terminal

### "Personal Software" & Non-Technical Use
- Two CNBC reporters built a Monday.com replacement in under an hour ($5-$15 compute)
- "Vibe working" — describe outcomes, not process
- Shift from operating tools to directing agents
- Bottleneck moves from technical proficiency to clarity of intent

### Industry Trends
- Revenue per employee at AI-native companies: 5-7x traditional SaaS
  - Cursor: $100M ARR with ~20 people
  - Midjourney: $200M with ~40 people
  - Lovable: $200M in 8 months with 15 people
- McKinsey targeting AI agent parity with human workers by end of 2026
- Dario Amodei: 70-80% odds of a billion-dollar solo-founded company by end of 2026

## Open Questions
- How does Opus 4.6 actually perform for extended creative writing vs coding?
- Reddit skepticism: "lobotomized" for writing tasks — real tradeoff or workflow adjustment?
- What are the actual limitations of agent teams in practice?
- How does the vending machine experiment inform real-world agent deployment guardrails?

## Tags
[ai](../tags/ai.md), [claude](../tags/claude.md), [opus-4-6](../tags/opus-4-6.md), [agents](../tags/agents.md)
