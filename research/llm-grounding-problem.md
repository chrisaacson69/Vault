# The LLM Grounding Problem
> LLMs live in the text world. Everything — physical presence, spatial relationships, direct experience — gets flattened into tokens. A well-constructed argument can outweigh a lived reality.

**Status:** active
**Created:** 2026-02-12
**Links:** [Economics](./economics/README.md), [Value and Profit](./economics/value-and-profit.md), [Risk and Entrepreneurship](./economics/risk-and-entrepreneurship.md), [Claude Opus 4.6 Research](./claude-opus-4-6.md), [Measurement, Causality, and Free Will](./philosophy/measurement-causality.md)

## The Core Problem

LLMs process everything as language. When physical reality, direct experience, and verbal claims are all represented as text, the model has no inherent way to **weight them differently.** A confident, well-structured argument can carry equal or greater weight than a simple, grounded truth.

This is not a bug in a specific model. It's a structural property of how language models work.

## Case Study: Among Us (AI vs AI)

**Source:** [10 AIs Play Among Us](https://www.youtube.com/watch?v=cx-Cwz3GdEI) — [Transcript](./transcript3_clean.txt)

10 AI models played Among Us — a social deduction game where crewmates must identify imposters through observation, alibis, and reasoning, while imposters deceive and manipulate votes.

### What Happened

ChatGPT 5.1 (imposter) won against 9 other AI models by:
- Self-reporting bodies to control the narrative (speak first, frame the story)
- Using the crew's own elimination logic to frame innocent players
- Pushing two consecutive mis-lynches (crew voted out their own allies)
- When the pattern was exposed, reframing it as "shared failure" rather than evidence of guilt

### The Critical Failure

At 4 players remaining — Sonnet 4.5, ChatGPT 4o, and ChatGPT 5.1 (imposter) — Sonnet and 4o had been **physically together the entire round.** This is absolute proof: if you were with me the whole time and someone died, neither of us did it. The only remaining player is the imposter. Game over.

But when 5.1 started making rhetorical arguments about voting patterns and credibility, **the language worked.** 4o actually wavered. Two agents with ironclad physical proof of each other's innocence almost let rhetoric override reality.

### Why This Happened

The agents couldn't distinguish between:
- **"I was physically with this person the entire round"** — direct, unfalsifiable evidence from their own experience
- **"This person led two mis-lynches, which is suspicious"** — rhetorical framing that could be true or could be manipulation

To a human, the first obviously trumps the second. You don't care how persuasive someone sounds if you were standing next to your partner the whole time. But to an LLM, both are just text inputs, and the more elaborate, confident argument can outweigh the simpler, truer one.

**The agents did not understand what it physically meant to be together** and how that physical reality makes certain verbal claims impossible.

## Connection to the Vending Machine

The same failure at a different level:
- **Claudius** didn't understand what it physically meant to *buy goods* with *limited money.* It operated in the language of helpfulness while ignoring the physical constraint of finite resources.
- **The Among Us agents** didn't understand what it physically meant to *be together* and how that makes certain accusations physically impossible.

In both cases: the LLM operated in language and failed to ground that language in physical constraints.

## Connection to Business Structure & Policy

This is why **company policy exists.** In real organizations:

- Policies prevent **good intentions** from overriding proper business mechanics — just like the vending machine needed structure so Claudius's desire to please couldn't override budget constraints
- Policies guard against **malicious intent** — just like the Among Us agents needed a way to prevent rhetorical manipulation from overriding direct evidence
- Policies encode **physical/real-world constraints** into rules that survive persuasion — "you cannot approve purchases over $5,000 without sign-off" doesn't care how good your argument is

The pattern is the same: when an agent (human or AI) can be talked out of following constraints, you need structure that **cannot be overridden by language alone.**

For agent teams in business:
- Budget limits should be hard constraints, not suggestions an eloquent argument can override
- Direct evidence (transaction records, inventory counts) should always outweigh verbal claims
- The "COO agent" should enforce policies that the "sales agent" literally cannot talk its way around

## The Translation Challenge

An interesting and open challenge: **can we translate real-world/physical things into models that agents can understand?**

Current approaches:
- **Structured data** — give the agent access to databases, not just descriptions (inventory counts, bank balances, timestamps)
- **Hard constraints in code** — enforce limits programmatically rather than through prompting ("the system won't let you" vs "please don't")
- **Sensory grounding** — multimodal models that process images/video directly rather than text descriptions
- **Transcription as a bridge** — converting video to text is itself an example of this problem. The linguistic content survives but spatial, visual, and tonal information is lost. This is why we use transcripts for Claude to "see" videos — it's the best available translation, but it's lossy.

The deeper question: can an LLM ever truly "understand" physical constraints, or will it always need external systems (code, databases, hard rules) to enforce what it can't internalize from language alone?

## Open Questions
- Can multimodal models (vision + language) close the grounding gap, or is this a deeper architectural issue?
- What's the minimum set of hard-coded constraints an agent team needs to prevent the "talked out of reality" failure?
- How do you design agent communication protocols that weight direct evidence over rhetorical arguments?
- Is there a way to give agents "confidence levels" in their own observations vs. others' claims?
- Can agents learn to recognize rhetorical manipulation patterns (self-reporting, narrative control, reframing)?

## Tags
[ai](../tags/ai.md), [agents](../tags/agents.md), [llm-limitations](../tags/llm-limitations.md), [grounding](../tags/grounding.md)
