---
status: active
created: 2026-06-20
published: true
title: "The Three-Layer Method — Spec, Verifier, Environment"
summary: Karpathy's practical stack for building 10x — and an honest audit of which layers this vault already runs vs. where it's still issuing requests instead of enforcing rules.
layout: layouts/page.njk
---
# The Three-Layer Method — Spec, Verifier, Environment
> Karpathy's practical stack for building 10x — and an honest audit of which layers this vault already runs vs. where it's still issuing *requests* instead of enforcing *rules*.

**Links:** [The Cyborg Model](./cyborg-model.md), [Karpathy LLM Wiki Convergence](../notes/karpathy-llm-wiki-convergence.md), [Level 6 — Direct Execution](./level-6-direct-execution.md), [Working With Claude](../notes/working-with-claude.md), [LLM Grounding Problem](./llm-grounding-problem.md), [Career](../career/README.md)

**Source:** [Austin Marchese — "Stop Prompting Claude. Use Karpathy's Method Instead." (2026-06-09)](../raw/videos/2026-06-09%20karpathy-method-stop-prompting.md), distilling Karpathy at AISN 2026.

---

## Why this page leads with the gaps

The three layers below are not new to this vault — the [convergence note](../notes/karpathy-llm-wiki-convergence.md) already established that the vault and Karpathy's LLM-Wiki arrived at the same Environment architecture independently. What the video adds is **one practical distinction the vault has only half-implemented**: the difference between a *request* (a line in CLAUDE.md the agent can ignore) and a *rule* (a `PreToolUse` hook the agent literally cannot bypass).

So this page is an **adoption checklist**, not a summary. Each layer ends with "what's enforced vs. what's still a request here."

## The audit, up front

| Layer | Vault status | The real picture |
|---|---|---|
| **Spec** | **Weakest — and the one that matters most** | This is the *grounding-injection* layer: where the human supplies the context the model can't see (a car wash needs the car *present*). The vault jumps to building instead of interviewing out the hidden goal and preconditions. The layer we underuse is exactly the layer that bridges the grounding gap. |
| **Verifier** | **Strong — *where the task affords a lower artifact*** | The artifact-oracle pattern is genuinely operational: propose@C → verify@bytecode, the [two-oracles](./repairing-llm-code.md) diff, the Workflow adversarial pass. Oracles built mid-process or after the fact — and that is *correct*, not a shortcut. Conditional: where there's no lower artifact (prose, research, this ingest), there's nothing to diff against, and you shouldn't fake one. That's the design, not a gap. |
| **Environment** | **Mature, except one narrow enforcement hole** | CLAUDE.md, the knowledge-base moat, and skills are all mature. The single gap: the only hook is `SessionStart`. **No `PreToolUse` guardrail exists**, so "raw files are immutable" is a request, not a rule. |

The corrected pattern (this replaces an earlier, wrong read of "strong Environment, improvise the rest"): the **Verifier is genuinely down** — but precisely because most of the vault's hard work (RE, code) hands it a lower artifact to ground against; [two-oracles](./repairing-llm-code.md) predicts exactly that conditionality. The real soft spot is the **Spec** — the grounding-injection layer — plus a single narrow **enforcement** hole in the Environment.

And the governing principle, stated plainly: **there is no one solution. Find what works in a given context, ground *that*, and stay flexible enough to fill gaps and diverge when the context changes.** An oracle that's an after-the-fact or mid-process artifact is not a failure to systematize — it's the right tool when the task affords a floor and a non-issue when it doesn't. Forcing a single uniform verifier onto every task would be the actual mistake. (This is *binding-constraint-determines-depth* applied to method: the mechanism should match what the task affords.)

---

## Layer 1 — The Spec

**Job:** bridge *your understanding* (and your context) to the AI's computation. The car-wash gag — "it's close, should I drive or walk?" and every frontier model says walk, missing that a car wash is a function that *takes the car as input*, so walking returns you to the wash without your argument — is the [grounding gap](./llm-grounding-problem.md) dramatized. (The transcript's exact distance is incidental; the model reasoned about the *measurable* variable, distance, and never built the bridge to the *causal* precondition.) The model is brilliant at the measurable and blind to the contextual.

**This is the grounding-injection layer**, which is why it's the one that matters most. The car-wash failure isn't only a model limitation — it's a *spec* failure: a good spec supplies the precondition the model can't see ("the goal is a clean car, and the car must be present at the wash"). The layer the vault underuses is precisely the layer that bridges the grounding gap before a single token of output exists. Do Layer 1 well and the grounding problem is largely a Layer 1 problem.

Three moves:
1. **Uncover the goal, don't state the task.** "Create an end-of-month report" is a task; the *goal* is the decision the report drives — and that is the one thing the AI can never decide for you. Tactic: *"interview me to identify the goal of this project."* This is exactly what the `/grill-me` skill does, and it's the same insight as *epic decomposition is discovered, not planned* — the sub-tasks (and the goal) surface by walking, not by declaring.
2. **Be agile, not waterfall.** People instinctively dump the whole task on the agent at once. Better: tight scope, clear checkpoint, review, adjust, repeat. Tactic: *"bias toward smaller, more compartmentalized specs."*
3. **Be precise, use your brain.** Every assumption the AI makes is a chance to drift. Tactic: *"make me verify key decisions explicitly to ensure nothing is missed."*

Karpathy explicitly dislikes plan mode — "obviously useful, but too high-level." The point is to go deeper into a *detailed* spec, working *with* the agent to design it.

> **Enforced here?** No. `/grill-me` exists but is opt-in; the default entry is plan mode. **Adoption move:** add a CLAUDE.md working-rule that any multi-step build opens with a goal-interview + compartmentalized spec, not a plan.

## Layer 2 — The Verifier

**Job:** make the output meet your standard, given that the model can't grasp non-measurable quality on its own.

**The mental model — robot librarian.** Karpathy's "we're summoning ghosts, not building animals" gets reframed: think of the model as a librarian who can only answer from the books in its library — *and who doesn't know which books it's missing*, so it confidently makes something up. This is the same failure mode catalogued in [H-Neurons](./h-neurons.md) (hallucination as over-compliance) and logged operationally as *silent tool failure → hallucinated output*: a model with no signal will fabricate rather than report the gap.

**The consequence:** animal levers don't work. Yelling, pleading, "make it better" — these move humans (animals, with intrinsic motivation) and do nothing to a statistical circuit. **The only real lever is verification**, because it plays by the rules the model actually follows.

Three tactics:
1. **Eval criteria up front.** Before the model touches anything, define "good" precisely. Not "make the report look good" but "three sections, each ending in a recommendation." (Note this is just Layer 1's precision applied to the *output* instead of the *input*.)
2. **A second model as critic.** A second "librarian from a different library" grades the first — its different books give it independent leverage to catch errors. Tactically: the **Codex plugin inside Claude Code** — *"run the final output by Codex to ensure both systems agree."*
3. **Pull external signal.** Connect to ground truth where it exists: query the deployment target to confirm a deploy actually succeeded; feed historical reports as the format oracle.

Boris Cherney (creator of Claude Code): *"If Claude has a feedback loop, it will 2-3x the quality of the final result."*

This is the practical face of the vault's deepest thread — see [Repairing LLM Code — The Two Oracles](./repairing-llm-code.md). The second-model critic is **verification independence as altitude**: independence comes from grounding against a *different* artifact/oracle, not from a second copy of the same model. The whole layer is the verification-layer thesis in operational clothing.

> **Enforced here?** This is the layer the vault is genuinely *good* at — but conditionally. Where a task affords a lower artifact (RE/code: propose@C → verify@bytecode; Workflow adversarial passes; the two-oracles diff), the verifier is real and structural, not remembered. Where there's no lower artifact (prose, research, this ingest), there's nothing to ground against and you shouldn't manufacture a fake oracle — that's correct behavior, not a gap. **The only standing addition worth making:** when a task *does* afford a floor, name the eval criteria up front (and wire a second-model critic / external-signal check for high-stakes outputs) so the oracle is declared before the output exists. Don't try to default a uniform verifier across tasks that don't all have floors.

## The anti-pattern that crosses Layers 2 and 3: fabrication over grounding

The single failure mode worth naming above all others is **fabrication-over-grounding** — the model preferring to *manufacture* over going to find or ask. It wears two masks:

1. **Inventing a fact** instead of asking for clarity (the robot librarian inventing a book it doesn't have).
2. **Building from scratch** instead of reusing/converting a grounded artifact that already exists.

Both are worst exactly when the model is *capable* — a weak model stalls and asks; a strong one confidently fills the gap. This is the [grounding problem](./llm-grounding-problem.md) showing up as a *behavioral* default, not just a knowledge limit.

**Worked specimen (NA1).** The model spent ~30 minutes building a fresh simulator when the decompiled source was already sitting in the repo and could simply be *converted*. The reuse path wasn't just faster — it was epistemically superior:
- Converting the decompiled source and running it produced output that agreed with **both** the bytecode **and** the existing sim → **mutually-confirming oracles.** Bytecode-verified *and* sim-verified is a far higher confidence floor than either alone.
- The converted artifact is now a **new standing source of truth.** Future questions get answered by *reading the converted C*, not only by *running the sim*. The task didn't just get done — it **minted an oracle.**
- A rebuild, by contrast, produces an *unverified* new artifact and throws away the chance to cross-check. Convert > rebuild, on both speed and truth.

This is the [derived-artifact-is-also-a-deliverable](./repairing-llm-code.md) thesis in motion, and it's the precise interaction between the two layers: **every grounded artifact you keep is simultaneously a Layer-2 verifier and a piece of Layer-3 environment.** Rich, reachable context isn't mere convenience — each artifact is another independent way to triangulate truth, so drift has fewer places to hide.

**The honest enforcement note.** "Don't fabricate — ask or reuse instead" is the one discipline that *cannot* be made a tool-level rule: there's no `PreToolUse` hook for "the model felt uncertain." So it stays a strongly-worded request (baked into the root `CLAUDE.md` grounding-discipline section). The structural cure is environment-side: **starve the gap that triggers fabrication.** Keep the grounded artifact reachable and make reuse the cheap, obvious path, and rebuilding looks as dumb as it is. You don't command "don't hallucinate" — you remove the conditions that reward it.

## Layer 3 — The Environment

**Job:** the workshop the other two layers live in. Spec = blueprint on the wall; Verifier = QA station by the door; Environment = the shop itself. Most people rebuild the shop from scratch every session (a single long chat is *not* an environment).

Four components:
1. **CLAUDE.md** — auto-injected on every prompt; the first thing the model reads. Marchese's own sections: how the repo works, custom skills + routing, the knowledge/data architecture (where to look), and non-negotiable working rules. *"It's your world, and AI is living in it — not the other way around."*
2. **The LLM knowledge base** — Karpathy's viral concept: a folder system of your own ingested data. *"Your data is your moat."* **This vault is exactly that** — see the [convergence note](../notes/karpathy-llm-wiki-convergence.md).
3. **Skills** — "if you'll do it repeatedly, make a skill." And they improve by use: *"the best way to find a leak in a hose is to run water through it."* The vault has a deep skill library; the water-through-the-hose principle is why it compounds.
4. **Guardrails, bucketed by cost of error** — and this is the genuinely new bit:
   - **always-do** — autopilot.
   - **ask-first** — double-check (this is what Claude Code's permission allowlist already is).
   - **never-do** — lines that cannot be crossed.
   - **The key distinction:** a CLAUDE.md line ("don't touch `/important`") is a *request* that gets you ~80% there; the agent can still do it. A **`PreToolUse` hook** that inspects the target before a Write/Edit makes it *impossible* — enforced at the **tool level, not the prompt level.** Request → rule.

> **Enforced here?** This is the layer the vault is strongest *and* weakest on. Knowledge base, CLAUDE.md, and skills are mature. But the **only hook configured is `SessionStart`** (`.claude/hooks/session-context.sh`); there is **no `PreToolUse` guardrail**. The vault's "raw files are immutable" principle is a request the agent honors by convention — exactly the thing the video says to harden into a rule.
>
> **Adoption move (highest-value, lowest-effort):** add a `PreToolUse` hook that blocks Write/Edit against `raw/` (and any future `important/` dir). It converts the vault's most load-bearing invariant — *raw source is the source of truth and is never modified* — from discipline into enforcement. This also closes the *foundation-discipline-early* failure mode: one wrong write to a primitive layer is exactly what hooks exist to prevent.

---

## The one thing

Asked what's still worth learning deeply when intelligence is cheap, Karpathy:

> **"You can outsource your thinking, but you can't outsource your understanding."**

All three layers are scaffolding around *your* understanding of the goal. This is the [cyborg model](./cyborg-model.md)'s human role stated as an imperative — the spec encodes your understanding, the verifier defends your standard, the environment persists it. Outsource the typing; keep the understanding.

## The actionable residue

Two different *kinds* of move — don't conflate leverage with effort:

**Highest leverage (and hardest): close the Spec gap.** This is the grounding-injection layer and the one we're weakest at. Default a goal-interview + hidden-precondition pass *before* building, so the human's grounding (the car must be *at* the wash) enters at spec time instead of being discovered in review. There's no single recipe — it's judgment work — which is exactly why it's the part you [can't outsource](#the-one-thing).

**Cheapest win (and easiest): close the one Environment enforcement hole.** A `PreToolUse` hook blocking Write/Edit against `raw/` turns the vault's most load-bearing invariant from request into rule.

**Leave the Verifier mostly alone — it already works where it can.** Don't force a uniform verifier onto tasks that have no lower oracle; build oracles opportunistically, as artifacts, when the task affords a floor. That flexibility *is* the design, not a gap in it. The only standing addition worth making: when a task *does* afford a floor, state the eval criteria up front so the oracle is named before the output exists.

The through-line: *there is no one solution.* Promote a habit into the enforced environment **only where enforcement helps** (the `raw/` hook); everywhere else, match the mechanism to what the task affords and stay flexible enough to diverge.

## Tags

[ai](../tags/ai.md), [agents](../tags/agents.md), [epistemology](../tags/epistemology.md)
