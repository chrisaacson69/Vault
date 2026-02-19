# Praxis: Agent Teams vs. the Theory
> Testing our economic framework against real-world agent team results from Opus 4.6 deployments.

**Status:** active
**Created:** 2026-02-12
**Links:** [Economics](./README.md), [Value and Profit](./value-and-profit.md), [Risk and Entrepreneurship](./risk-and-entrepreneurship.md), [LLM Grounding Problem](../llm-grounding-problem.md), [Claude Opus 4.6 Research](../claude-opus-4-6.md)

## Purpose

We built a theoretical framework covering:
- **Utility and trade** — profit is mutual, emerging from differences in subjective value
- **Risk and entrepreneurship** — profit is the reward for correct bets under uncertainty
- **Organizational hierarchy** — Line Manager → COO → CEO, each handling progressively harder decision classes
- **The grounding problem** — LLMs can be talked out of physical reality because everything is flattened to tokens

This page tests that framework against the real-world success stories reported in the [Opus 4.6 video](https://www.youtube.com/watch?v=JKk77rzOL34).

## Analysis

### 1. The C Compiler — 16 Agent Team

**What happened:** 16 Opus 4.6 agents built a fully functional C compiler in Rust over 2 weeks. 100,000+ lines of code, builds Linux kernel on 3 architectures, passes 99% of torture test suite. Cost: ~$20,000.

**Structure:** Lead agent coordinated, specialists handled subsystems (parser, code generator, optimizer), peer-to-peer messaging between agents.

**Utility/Trade:** Compute cost ($20K) exchanged for a product (working compiler). A human team would cost hundreds of thousands and take months. Massive utility gap — both sides profit.

**Risk:** Low. A compiler has a specification — it either compiles correctly or it doesn't. Success criteria are clear and measurable. No entrepreneurial bet on demand or market. This is **COO-class work** — well-defined, verifiable, structured.

**Grounding:** Largely a non-issue. Code is text. Compilation is verifiable. The agents work in their native medium and outputs are testable in the same domain.

**Verdict:** COO-class problem. Agent teams excel here. No CEO judgment needed, no grounding gap.

---

### 2. Rakuten — Managing 50 Developers

**What happened:** Opus 4.6 on their issue tracker in production. Closed 13 issues autonomously in one day. Assigned 12 issues to correct team members across 50-person org and 6 repos. Knew when to escalate to a human.

**Structure:** Single agent operating as COO — routing, triaging, assigning. Building toward 24 parallel agent sessions on their monorepo.

**Utility/Trade:** Replaces coordination labor. A human engineering manager doing ticket triage spends 15-20 hours/week on pattern-matching work. At $250K/year fully loaded, that's significant salary for automatable tasks.

**Risk:** Moderate. Closing issues = judgment calls on correctness. Assigning issues = predicting who has context. But critically — **it knew when to escalate.** It didn't try to play CEO. It handled COO-level decisions and punted the rest.

**Grounding:** Small gap. Code and issue trackers are text-native. Org chart understanding works when organizational structure is documented. Risk would emerge if the agent tried to infer undocumented social dynamics.

**Verdict:** Clean COO-class success. The critical design choice: **human-in-the-loop based on stakes.** The agent presents options for hard calls rather than making them unilaterally. Exactly our model.

---

### 3. Security Research — 500 Zero-Days

**What happened:** Given basic tools (Python, debuggers, fuzzers) and pointed at open-source code with no specific instructions. Found 500+ previously unknown zero-day vulnerabilities in code reviewed by human researchers and scanned by automated tools. Independently decided to analyze git history when standard methods failed. Invented its own detection methodology.

**Structure:** Solo agent with tools. No team, no hierarchy.

**Utility/Trade:** Finding vulnerabilities human researchers missed. Compute cost vs. security for millions of users. Enormous utility gap.

**Risk:** Here's where it gets interesting. The agent made a **novel methodological bet** — "standard fuzzing isn't working, I'll try analyzing git history instead." That's not constraint execution. That's closer to entrepreneurial judgment — a creative gamble that paid off. But the domain has low downside: if the novel approach fails, you just don't find anything. You don't lose resources.

**Grounding:** Partially relevant. Code is text, but vulnerabilities exist at the boundary between what code says and what it physically does (buffer overflows, race conditions). The agent reasoning about "where assumptions break down" is reasoning about the gap between text and physical behavior. Going to git history — reasoning about the code's evolution over time — goes deeper than static text analysis.

**Verdict:** Pushes beyond COO into **limited CEO territory.** Entrepreneurial in method, but low-risk in outcome. A notable demonstration of **creativity** — the new model showing capacity for novel problem-solving approaches when standard methods fail.

---

### 4. CNBC Reporters — Monday.com Clone

**What happened:** Two non-technical reporters built a project management dashboard (calendar views, email integration, task boards) in under an hour. $5-$15 compute cost.

**Structure:** Human-agent pair. Human describes outcome, agent executes.

**Utility/Trade:** Personal software worth thousands in subscription fees for $15 in compute. Massive utility gap. But this is personal software — no repeatable value creation, no customers, no business risk.

**Risk:** Near zero. Bad output = wasted $15. No market bet, no demand risk, no competition. Below COO-level — individual task execution.

**Grounding:** The human closes the loop. They know what they need from physical experience using Monday.com. They describe it in text. The agent builds it. The human validates whether the output matches real-world needs. Grounding provided externally.

**Verdict:** Below the business framework entirely. A single trade, not a business. But illustrates a key principle: **when the human provides grounding and judgment, the agent just needs to execute.** Bottleneck is clarity of intent, not agent capability.

---

## Summary

| Example | Decision Class | Risk Level | Grounding Gap | CEO Needed? | Outcome |
|---------|---------------|------------|---------------|-------------|---------|
| C Compiler | COO — structured, verifiable | Low | None (code is text) | No — specification exists | Success |
| Rakuten | COO — routing, triaging | Moderate | Small (documented org structure) | No — escalates when needed | Success |
| Security | CEO-adjacent — novel methodology | Low downside | Partial (code vs execution) | Limited — bounded risk bets | Success |
| CNBC Reporters | Below COO — task execution | Near zero | None (human grounds it) | No — human is the CEO | Success |

## The Pattern

**Every success story either:**
- **(a)** Operates in a well-structured, verifiable domain where the grounding problem doesn't apply (compiler, code, issue tracking), OR
- **(b)** Has a human closing the grounding loop (reporters describing what they need, Rakuten escalation)

**None of them required** genuine CEO-level entrepreneurial judgment under high-stakes uncertainty.

The closest — security research — was entrepreneurial in *method* (creative problem-solving) but low-risk in *outcome* (bounded downside). This is notable: **LLMs may develop creativity before they develop entrepreneurial judgment**, because creativity under low stakes doesn't require the slow feedback loops that make the CEO role hard to train.

## What Hasn't Been Tested

The open frontier — running an actual business with:
- Real entrepreneurial risk (capital at stake)
- Real customers (adversarial context, demand uncertainty)
- Physical-world grounding requirements (inventory, logistics, time-sensitive delivery)
- Competing utility functions under genuine uncertainty

The vending machine was the closest attempt, and it failed exactly where our theory predicts: at the intersection of sycophancy, grounding, and entrepreneurial judgment.

## Open Questions
- Can the creativity demonstrated in security research transfer to entrepreneurial contexts?
- What's the next real-world test that pushes into CEO-class decisions?
- How do we design a "vending machine 2.0" experiment that applies the structural lessons?

## Tags
[economics](../../tags/economics.md), [agents](../../tags/agents.md), [praxis](../../tags/praxis.md)
