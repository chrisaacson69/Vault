---
status: active
created: 2026-08-26
published: true
layout: layouts/page.njk
title: "Building Swarms — Token Rules as Architecture"
---
# Building Swarms — Token Rules as Architecture
> Nate B. Jones's 15 token rules are written as single-agent hygiene. At fan-out, every per-agent overhead is paid N times — which promotes a habit into an architectural constraint. This is the translation, plus the anti-pattern it explains.

**Links:** [The Substrate Is the Governing Mechanism](../research/substrate-as-governance.md), [Method — a library of good procedure](./README.md), [The Anchor Method](./anchor-method.md), [The Context Cache Hierarchy](../notes/context-cache-hierarchy.md), [Claude Code Skill Engineering](../notes/claude-code-skill-engineering.md), [Working With Claude](../notes/working-with-claude.md), [Praxis Agent Teams](../research/economics/praxis-agent-teams.md)

**Source:** [Nate B. Jones — 15 rules to stop running out of tokens](../raw/videos/2026-08-26%20nate-b-jones-15-token-rules.md) ([YouTube](https://www.youtube.com/watch?v=Y8vAQ1FgNbM)), ingested 2026-08-26. Companion page: [The Substrate Is the Governing Mechanism](../research/substrate-as-governance.md).

## The multiplier — why hygiene becomes architecture

Jones's framing is a desk you have to keep clean, and the whole video is addressed to one person in one chat. The load-bearing fact he gives is the one that changes character under fan-out:

> A typical setup with several tool servers connected — GitHub, Slack, Sentry, Grafana — burns roughly **55,000 tokens in tool definitions before the model does anything at all.**

For one agent that's an annoyance. For a twelve-agent fan-out it is **660,000 tokens spent before any work begins**, and none of it is task-specific. Every per-agent constant — tool definitions, standing instructions, the system preamble, whatever context the orchestrator copies down — is multiplied by the width of the fan-out.

That is the whole translation rule: **in a swarm, a per-agent overhead is a per-agent overhead times N, and anything you can move from per-agent to shared-once is a structural win, not a tidiness win.** Habits you can afford to skip solo become the difference between a fan-out that runs and one that dies on limits.

## The rules, translated

Numbering caveat: the video states rules **1–7, 9, 10 and 14** aloud. Rule **8 is never spoken** — he goes straight from 7 to 9; it presumably exists in the written Substack version, which was not fetched. The bracketed ones below are positioned by ordering in the transcript, not by a stated number.

| Rule (single-agent form) | Swarm form |
|---|---|
| 1. Edit your mistake, don't argue with it | Orchestrator re-issues a corrected task to a fresh agent rather than negotiating with a confused one. A wrong agent is cheaper to replace than to convince. |
| 2. Batch related questions; name the output shape | One agent per *coherent* unit of work — not per question. And name the return shape, which at fan-out means a schema, not a request. |
| 3. Start a clean task when the job changes | **The definition of an agent boundary.** Fresh context scoped to one task is what a subagent *is*; it's Jones's most-resisted rule made structural. |
| 4. Carry the answer, not the argument | **The single most important one.** Pass each stage's *artifact* to the next, never its transcript. |
| 5. Ask for only the answer you need | Output is billed twice — once written, then forever as input. In a pipeline it's billed again at every downstream stage that carries it. Bound every agent's return. |
| 6. Search the file yourself; don't make the model search | The orchestrator scouts and hands each agent the located path or passage. Otherwise N agents each re-run the same search. |
| 7. Send the lightest useful form | Pass paths and extracted text, not whole files, and never the original PDF. |
| *(8 — not stated in the video)* | — |
| 9. Keep answers somewhere retrievable | **The shared workspace.** This is the swarm rule; see the [substrate page](../research/substrate-as-governance.md). |
| 10. Load only the tools the job can use | Scope tools per agent. This is the 55k × N line — the highest-leverage single change in a wide fan-out. |
| *[11] Compaction / context editing* | For long-running agents that can't restart mid-task. Note his honest caveat: you are continuing against an *approximation* of the original context. |
| *[12] Use the dumbest model that still works* | Per-agent model and effort tiering — cheap mechanical stages small, adversarial/judge stages large. |
| *[13] Prompt caching* | A stable shared prefix across agents is a cache hit N times instead of a cold start N times. Actively *rewards* uniform preambles. |
| 14. Enforce hard limits | Cap request and response size per agent so one runaway can't eat the budget for the whole fan-out. |
| *[15] Answer from the store without a model call* | The cache-hit case: if the shared workspace already holds an accepted answer, serve it and skip the agent entirely. 100% of the call saved. |

## The anti-pattern this explains

The observed failure — *agents were instructed to do tasks, had no shared workspace, and each received the entire context copied to it instead of a focused task* — is rules 3, 4, 6 and 10 failing simultaneously, and it has a single root cause.

**Without a durable shared artifact, there is nothing to point at, so every agent must be handed the whole history.** Copying context isn't the mistake; it's the *symptom* of having no substrate. The costs compound in two directions at once:

- **Cost:** the full transcript is multiplied by the fan-out width, on top of the per-agent tool and preamble constants.
- **Opacity:** nothing durable is produced *between* agents, so the orchestrator is the only integration point, nothing accumulates, and there's no readable record of what passed between them.

Which is the point where this note and the [substrate page](../research/substrate-as-governance.md) meet: a swarm without a shared workspace is simultaneously maximally expensive *and* maximally opaque. Both are fixed by the same move. This is [`context-cache-hierarchy.md`](../notes/context-cache-hierarchy.md)'s prediction confirmed against a real failure — *"memory coherence precedes parallelism… parallel agents over an unregistered, re-deriving substrate just multiply the drift."*

## What the harness already does for you

Worth knowing before building anything custom — several of these are already structural in Claude Code's `Workflow` tool, which is a reason to reuse rather than rebuild:

- `pipeline()` passes each stage's **return value** to the next, not the conversation. That is rule 4, enforced by the API shape.
- The `schema` option forces a subagent through a structured-output tool and validates it. That is rule 2's "name the output shape" *and* the prescribe-the-protocol governance move from the substrate page — the same act satisfies both.
- `opts.model` and `opts.effort` are rule 12 per agent.
- Agents return their final text as data, so the return *is* the artifact.

The gap the harness does **not** close is rule 9: there is no shared writable workspace between agents by default. Stages hand results forward, but nothing durable accumulates *beside* the pipeline for later agents to read. That's the piece to build, and it should be built as a named, schema'd directory — not as an incidental scratch area, per the substrate page's argument about unowned channels.

## The measurement worth running

This is the half of the two-video ingest that is verifiable locally, with no external fetching and no policy surface. Same task, two fan-out shapes:

1. **Control:** full context copied to every agent (the observed anti-pattern).
2. **Treatment:** orchestrator writes a shared artifact; each agent gets a pointer, a scoped task, and only the tools it needs.

Measure tokens and wall-clock. That turns "we hit this wall once" into a number the vault can cite, and it's a measurement against a lower artifact rather than a second opinion — the [verification-independence standard](../research/karpathy-three-layer-method.md). Until it's run, everything on this page is a well-argued prediction, not a result.

## Open Questions

1. **What's the actual multiplier?** The 55k tool-definition figure is Jones citing Anthropic; the fan-out multiplication is arithmetic on top of it. Unmeasured here.
2. **Where's the crossover?** At small N the shared-workspace overhead may exceed the copying cost. Is there a fan-out width below which the anti-pattern is simply correct?
3. **Rule 8.** Never stated in the video. Recoverable from the written writeup if it's ever fetched.
4. **Does compaction (11) hold across a long pipeline?** Jones is explicit that continuation runs against an approximation of the original context. Compounded over stages, how much drift accumulates — and does an artifact-passing pipeline avoid it entirely by never needing compaction?
5. **Is a per-agent tool budget enforceable**, or only advisable? Rule 14 caps sizes; nothing obviously caps tool-definition weight at spawn.

## Tags

[ai](../tags/ai.md), [agents](../tags/agents.md), [agent-teams](../tags/agent-teams.md), [workflow](../tags/workflow.md), [methodology](../tags/methodology.md)
