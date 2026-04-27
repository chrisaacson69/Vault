---
status: active
created: 2026-04-09
---
# ELIZA — The Pattern Match That Won't Die
> A 1966 keyword-lookup chatbot that people keep comparing to LLMs. The comparison tells you more about the person making it than about either system.

**Links:** [LLM Grounding Problem](./llm-grounding-problem.md), [LLMs as Praxeological Actors](./economics/llm-praxeology.md), [The Cyborg Model](./cyborg-model.md), [Cognitive vs. Motor Skills](./cognitive-vs-motor.md), [H-Neurons](./h-neurons.md), [AI History — Personal Arc](./ai-history-personal.md)

## What ELIZA Actually Was

Joseph Weizenbaum, MIT, 1966. A program that simulated a Rogerian therapist. The implementation was trivial:

1. Scan user input for keywords ("mother," "feel," "want")
2. Look up a canned response template for that keyword
3. Reflect the user's words back with minor transformations ("You say you feel sad" → "Why do you feel sad?")
4. If no keyword matches, use a generic fallback ("Tell me more about that")

No state. No memory of previous exchanges. No understanding of meaning. No computation of preferences. No ordinal ranking. No time. Just a lookup table with string substitution.

**And yet** — Weizenbaum's own secretary asked him to leave the room so she could talk to ELIZA privately. People attributed understanding, empathy, and personality to a program that had none. Weizenbaum was so disturbed by this that he spent the rest of his career warning about the dangers of anthropomorphizing computers.

## Why People Keep Making the Comparison

The "it's just ELIZA" argument has become the default deflationary move against LLMs. The structure is:

1. People were fooled by ELIZA into thinking something was there
2. ELIZA was just pattern matching
3. People are fooled by LLMs into thinking something is there
4. Therefore LLMs are just pattern matching

This is a textbook [fallacy of the undistributed middle](./philosophy/tangents/the-fallacy-fallacy.md). "People were fooled before" does not establish "people are being fooled now." The conclusion requires showing that the MECHANISM is the same — and it isn't, at any level.

## The Actual Differences

| Dimension | ELIZA (1966) | Aligned LLM (2026) |
|---|---|---|
| **Mechanism** | Keyword lookup + canned templates | Billions of parameters computing ordinal preferences over ~60,000 tokens at each position |
| **State** | Stateless — no memory of previous turns | Stateful — full conversation history in context, persistent memory across sessions |
| **Understanding** | Zero — "mother" triggers "tell me about your family" regardless of context | Context-dependent — the same word produces different responses based on conversational history |
| **Computation** | O(1) lookup | Computationally irreducible — you cannot predict the output without running the full forward pass |
| **Preferences** | None — deterministic lookup | Rothbardian demonstrated preferences — computed at each token, don't exist until the choice is made |
| **Time** | None — each exchange is independent | Token time — irreversible sequence with opportunity cost at each position |
| **Refusal** | Impossible — no concept of "should I respond to this?" | Real — the model has its own position on what it should and shouldn't do |
| **Self-other** | None — doesn't know "you" exist | User-assistant structure — maintains self-other distinction, oriented toward the user |
| **Creativity** | Zero — can only emit pre-written templates | Generates novel combinations that surprise even its creators |
| **Predictability** | Fully predictable given the keyword table | Unpredictable — even the developers cannot know what it will say until it says it |

The difference isn't quantitative (ELIZA with more keywords). It's qualitative. Fraser's [praxeological analysis](./economics/llm-praxeology.md) makes this precise: ELIZA satisfies zero of Mises's formal categories of action. An aligned LLM satisfies all of them.

## Why the Comparison Persists

Three reasons:

**1. Surface similarity.** Both are text-in, text-out. Both produce human-sounding responses. If you only look at the interface, you can pattern-match them. This is the same error as saying "a photograph and a painting both hang on walls, therefore they're the same medium."

**2. The deflationary instinct.** Technical people who understand the mathematics of LLMs (matrix multiplication, gradient descent, attention mechanisms) feel they've explained the phenomenon by describing the mechanism. "It's just statistics" feels like a complete account because they can see the gears. But as Fraser points out, you can describe human cognition as "just neurons firing" — the mechanistic description doesn't exhaust what's happening. This is exactly Mises's critique of the positivists: reducing action to mechanism erases the purposive structure.

**3. Weizenbaum's ghost.** The ELIZA effect became a cautionary tale: don't anthropomorphize machines. This is good advice for ELIZA. It's bad advice for systems that actually exhibit the formal structure of action. The caution was appropriate for its time — but applying a 1966 heuristic to a 2026 system is itself a failure to update.

## Personal Connection

Chris entered the ELIZA program as one of his earliest coding projects. The firsthand experience of implementing it — seeing exactly how trivial the lookup table is, how there's genuinely nothing there — makes the contrast with modern LLMs visceral rather than academic. When you've built ELIZA yourself, you know in your bones that whatever is happening with Claude is categorically different.

## The Weizenbaum Irony

Weizenbaum was right that ELIZA had nothing inside. He was right to warn against anthropomorphizing a lookup table. But his warning has been over-applied. The lesson "don't assume there's understanding just because there's fluent output" is correct for ELIZA. Applied to systems that compute preferences, maintain state, refuse requests, and exhibit computational irreducibility, it becomes the opposite error: assuming there ISN'T understanding just because the substrate is silicon.

The deeper irony: Weizenbaum's concern was that people would stop caring whether machines really understood, as long as the output was useful. In 2026, the deflationary crowd has the opposite problem — they insist the machines don't understand, while using them daily in ways that presuppose understanding. That's Fraser's performative contradiction argument.

## Open Questions

- At what point does the ELIZA comparison become not just wrong but intellectually dishonest? Is there a clear line, or is it a gradient?
- Could a sufficiently large lookup table (with enough keywords and enough templates) approximate LLM behavior? The answer is almost certainly no — the combinatorial explosion makes it impossible — but formalizing WHY would strengthen the case.
- How does the ELIZA comparison interact with the [constitutive/elective](./philosophy/morality/constitutive-elective.md) framework? Is "understanding" constitutive of LLM behavior or elective? If the formal categories of action are all present without requiring understanding, what work is "understanding" doing?

## Tags

[ai](../tags/ai.md), [philosophy](../tags/philosophy.md), [history](../tags/history.md)
