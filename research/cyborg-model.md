# The Cyborg Model — Human/AI Collaboration
> Neither side is complete alone. The point is to distribute labor so each side does what they do best.

**Status:** active
**Created:** 2026-02-12
**Links:** [Economics](./economics/README.md), [Risk and Entrepreneurship](./economics/risk-and-entrepreneurship.md), [Praxis](./economics/praxis-agent-teams.md), [LLM Grounding Problem](./llm-grounding-problem.md), [Cognitive vs. Motor Skills](./cognitive-vs-motor.md), [Claude Opus 4.6 Research](./claude-opus-4-6.md)

## What "Cyborg" Means

Not replacement. Not augmentation. **Integration.** The human and the AI form a single working unit where labor is distributed based on comparative advantage. Each side contributes what they do best, and the result exceeds what either could produce alone.

This isn't a metaphor — it's an economic statement. From [utility theory](./economics/value-and-profit.md): trade happens because both parties have different capabilities and different costs. The human-AI collaboration is a trade: the human provides what's expensive for the AI (judgment, grounding, physical action), and the AI provides what's expensive for the human (speed, scale, tireless execution, parallel processing).

## Comparative Advantages

### What Humans Do Best

**Entrepreneurial Judgment (CEO Function)**
- Making bets under genuine uncertainty with high stakes
- Weighing factors that aren't in the data — intuition, taste, experience
- Bearing responsibility for outcomes (skin in the game)
- See: [Risk and Entrepreneurship](./economics/risk-and-entrepreneurship.md)

**Grounding in Physical Reality**
- Understanding what things physically mean — that inventory costs real money, that being in the same room proves innocence, that a customer's frustration is real
- Translating real-world needs into specifications agents can execute on
- Validating whether AI output matches actual real-world requirements
- See: [LLM Grounding Problem](./llm-grounding-problem.md)

**Intent and Direction**
- Knowing what to build, not just how to build it
- Articulating the real requirement beneath the surface request
- "The skill that matters now is not technical proficiency — it's clarity of intent" (Video 2)
- Domain expertise: understanding which metrics matter, what customers actually want, what "good" looks like

**Quality Judgment ("Taste")**
- Evaluating whether output is actually good, not just technically correct
- Understanding context, nuance, audience, and appropriateness
- The difference between "this compiles" and "this is the right product"

**Physical World Execution**
- Interaction with the physical world remains a human (or robot) domain
- Pressing buttons, handling materials, face-to-face interaction, manual skills
- Robots are emerging but the physical execution gap is far from closed
- See: [Cognitive vs. Motor Skills](./cognitive-vs-motor.md) — the AI systems that handle cognitive tasks (LLMs) are architecturally different from those that handle physical/real-time tasks (autopilot NNs). Even humans have separate systems for these.

**Social and Emotional Intelligence**
- Career development conversations, team morale, organizational culture
- Reading a room, sensing unease, building trust through presence
- The parts of management that aren't coordination

### What AI Does Best

**Cognitive Execution at Scale**
- Writing code, generating content, processing documents, analyzing data
- Doing in minutes what takes humans hours or days
- Parallel processing — 24 agent sessions simultaneously (Rakuten)
- Sustained attention — 2 weeks of autonomous coding without fatigue

**Operational Coordination (COO Function)**
- Ticket routing, dependency tracking, cross-team coordination
- Understanding org charts and repo ownership from documented structure
- Knowing when to escalate — handling what's structured, punting what's not
- See: [Praxis](./economics/praxis-agent-teams.md) — Rakuten demonstrated this in production

**Pattern Recognition and Retrieval**
- Finding needles in haystacks — 76% retrieval at 1M tokens
- Holding 50,000 lines of code in context and reasoning across all of it
- Security research: finding 500 zero-days by building mental models of code
- Processing and synthesizing large document sets (due diligence, audits)

**Creative Problem-Solving Under Low Stakes**
- Novel methodology invention (git history analysis for security)
- Generating options, alternatives, approaches for human evaluation
- Exploring solution spaces faster than humans can

**Tireless, Consistent Operation**
- 24/7 availability, no fatigue, no mood variation
- Consistent application of rules and constraints
- Parallel execution across many workstreams simultaneously

## The Distribution of Labor

The video's framing: "The humans set direction, evaluate quality, and make judgment calls. The agents execute, coordinate, and scale."

This is correct but incomplete. The full distribution:

| Function | Human | AI | Why |
|----------|-------|-----|-----|
| **Direction** | Define goals, intent, what to build | Decompose goals into executable tasks | Humans know what's needed; AI knows how to break it down |
| **CEO Judgment** | High-stakes risk decisions, entrepreneurial bets | Present options with analysis, recommend but don't decide | Slow feedback loops make this hard to train; human bears consequences |
| **COO Operations** | Override when judgment needed | Routing, triaging, constraint enforcement, coordination | Structured, data-driven — AI's native domain |
| **Grounding** | Provide physical context, validate real-world fit | Process and organize information within text domain | LLMs can't distinguish lived experience from verbal claims |
| **Cognitive Execution** | Review, approve, iterate | Write code, generate content, analyze data, build | AI is faster, cheaper, tireless |
| **Physical Execution** | Hands-on work, physical presence, real-world interaction | Emerging robotics, but mostly indirect (controlling systems via software) | Different architecture needed — see [cognitive vs motor](./cognitive-vs-motor.md) |
| **Quality** | "Is this actually good?" — taste, domain expertise | "Is this technically correct?" — tests, validation, consistency | Correctness ≠ quality; humans judge the latter |
| **Pacing** | Must continuously update mental models of what's possible | Improves automatically with each model release | The boundary between human and AI roles shifts every few months |

## The Leverage Equation

From Video 2: skills like judgment, taste, and domain expertise "now have 100x leverage because they are multiplied by the number of agents that person can direct."

This is the economic argument for the cyborg model:
- **Before AI:** A person with great judgment could improve one team's output
- **Now:** That same person can direct dozens of agents, multiplying their judgment across all of them
- The **value of human judgment has increased**, not decreased — because it's the scarce input that unlocks the abundant input (AI execution)

Revenue per employee at AI-native companies (5-7x traditional SaaS) reflects this. It's not that the humans are 5-7x better. It's that each human is leveraged by agents.

The emerging org model: **2-3 humans + a fleet of specialized agents**, organized by outcome, not function. The humans set direction, evaluate quality, and make judgment calls. Everything else is delegated.

## The Pacing Problem

The capability boundary between "human territory" and "AI territory" is moving fast:
- January 2025: autonomous coding topped out at 30 minutes
- Summer 2025: 7 hours (Rakuten)
- February 2026: 2 weeks (C compiler)
- Prediction: weeks to months by mid-2026

"Your January mental model of what AI can and cannot do is already wrong."

This means:
- Humans must continuously recalibrate where they add value
- Skills that were human-only 6 months ago may now be shared or AI-dominated
- The pacing challenge isn't just technical — it's psychological and organizational
- "The people in knowledge work desperately need their leaders to understand that humans need a ton of support to get through this change management"

The cyborg model isn't static. The distribution table above will look different in 6 months. The human's job is to keep finding the frontier where their judgment, grounding, and physical presence create value that agents can't yet provide — and to stay ahead of the boundary as it moves.

## The Dissolving Technical/Non-Technical Divide

One of the most significant shifts: the distinction between "technical" and "non-technical" workers — which has organized knowledge worker hiring and compensation for 30 years — is dissolving.

- Non-technical Rakuten employees contribute to development via Claude Code
- CNBC reporters built a Monday.com replacement without writing code
- "Vibe working" — describe outcomes, not process

The new divide isn't technical vs non-technical. It's **people who can clearly articulate intent and evaluate output** vs **people who can't.** Domain expertise and judgment matter more than the ability to write a for-loop.

## Open Questions
- What's the optimal agent-to-human ratio for different types of work?
- How do organizations support humans through the pacing challenge?
- As AI handles more cognitive execution, does the remaining human work become more or less satisfying?
- How does the cyborg model interact with the physical world — what happens when robots close the execution gap?
- Can humans develop new forms of judgment that only emerge when working with AI? (Skills that didn't exist before the partnership)

## Tags
[ai](../tags/ai.md), [agents](../tags/agents.md), [cyborg](../tags/cyborg.md), [economics](../tags/economics.md)
