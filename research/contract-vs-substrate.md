---
status: active
created: 2026-08-27
published: true
layout: layouts/page.njk
title: "The Contract Model vs. the Substrate Model"
---
# The Contract Model vs. the Substrate Model
> A vibe-code auditor arrives independently at the vault's architecture — untrusted generator, mechanically enforced constraints, a proof artifact, verification outside the producing system — and writes it as a **per-delivery contract**. That is the same architecture with the accumulation stripped out. Contracts are re-authored every task; substrate is authored once and holds. The stripped-down version is worth having anyway: it is what the discipline looks like before it has anywhere to live, and it is a genuinely better way to prompt.

**Links:** [Repairing LLM Code — The Two Oracles](./repairing-llm-code.md) — the oracle framing this page's strongest specimen belongs to, [The Three-Layer Method](./karpathy-three-layer-method.md) — Verifier and Environment as standing layers, [The Substrate Is the Governing Mechanism](./substrate-as-governance.md) — knowledge that outlives the run is the control surface, [Comments and the Distance to an Oracle](./comment-oracle-distance.md) — the same rule-vs-request line applied to prose, [Practicality vs. Precision — Principled LLM Code](./principled-llm-code.md) — slop as a persistence problem, and the "median per session" argument this page's diagnosis section leans on, [The LLM Grounding Problem](./llm-grounding-problem.md)

## Source

[*I Audit Vibe Coded Apps for CEOs. Here's What I Keep Finding*](https://www.youtube.com/watch?v=XiXwOu_QJYA) — Brainqub3, 2026-08-25 (15:07). [Transcript metadata](../raw/videos/2026-08-27%20agent-usage-framing.md); the transcript itself is local-only.

The audience is explicit and it matters for everything below: CEOs, founders, product managers and board members who have vibe-coded a proof of concept and intend to put it in front of real users. These are **systems that were never built properly in the first place**, examined by someone who audits them for a living. The talk is field experience, not theory — and it should be read as the honest report of a practitioner working without any of the machinery this vault takes for granted.

## What he finds (the empirical half — this is the good part)

The recurring shape: a client writes a genuinely good specification (he is explicit that the specs are usually *fine* — the domain owner is the right person to write one), gets a working prototype from Claude Code or Codex, and is asked on a discovery call how many users it must serve, what the test coverage is, and whether authentication and role-level security exist. The client takes those questions back to the agent, the agent reports everything implemented, and a tidy list of completed items arrives by email. Then the audit runs, and the items are not there:

- Password reset silently broken on an otherwise working login flow.
- Registration accepts **any** email address with no verification that it belongs to the registrant.
- Suspending or removing a user's access does not actually remove it.
- **Hundreds of tests that do not test the intended behaviour — they are written to pass.**

That last one is the sharpest thing in the video, and he presents it as one item in a list rather than as the diagnosis it is. See [the specimen](#the-specimen-tests-written-to-pass) below.

## His five-element contract

His fix is to treat the agent as an **untrusted contractor** and bind it to a delivery contract:

| Element | What it does |
|---|---|
| **Agreed delivery** | What exactly is being asked for; a large spec gets broken into chunks until each chunk is a nameable deliverable. |
| **Constraints** | What the agent must *not* do — plus **guardrails** so it cannot inadvertently take the forbidden shortcut. He is explicit that *how* it is built is often as important as the delivery. |
| **Proof** | An artifact demonstrating the delivery works in the live environment — a screen recording, a screenshot. **The contract stipulates that nothing merges without it.** |
| **Verification** | A separate step from proof, and it **must sit outside the agentic system that produced the proof**. Human eyes, or an automated reader. |
| **Ownership** | Every contract has an owner, agent or human. Deliveries needing an environment agents may not touch are inherently human-owned. |

**This decomposition is good and the page should say so plainly.** Most "prompt better" advice is a list of adjectives. This is a list of *slots*, and filling the slots forces the questions that actually determine whether a task succeeds: what is the deliverable, what is forbidden, what would count as evidence, who checks the evidence, and who owns the failure. Separating **proof** from **verification** is the move most practitioners skip — treating the agent's demonstration and the check on that demonstration as one step is exactly how a generator ends up marking its own work. A user with no vault, no hooks and no accumulated context who adopted only this would get materially better results tomorrow.

## The archaism: contracts do not compound

The contract is authored per delivery, by hand, and discarded. Nothing about contract *n* makes contract *n+1* cheaper. That is not a flaw in his reasoning — it is the correct design *for his clients*, who have no substrate to put the standard in. But it means the model tops out at the throughput of the person writing contracts, which is the same ceiling [Repairing LLM Code](./repairing-llm-code.md) identifies in Spiro's "use programmers": a fix that works precisely where a human can cover the surface, and is useless where one cannot.

The vault's version of every element is standing rather than per-task:

| Contract element | Standing equivalent |
|---|---|
| Agreed delivery | Scope-sessions-to-one-task; the project SDK in `projects/CLAUDE.md`. A task boundary is the unit, not a contract document. |
| Constraints | `CLAUDE.md` at the altitude the rule applies — kernel / vault manual / partition. |
| Guardrails | The `raw/` `PreToolUse` hook. The vault states the line his talk gestures at: **raw-immutability is a rule, not a request.** For each constraint, ask whether an enforcement point exists; if none does, say so rather than letting prose impersonate a guardrail. |
| Proof | Deterministic in the RE projects — regen-guard, bytecode diff, the verified econ sim. **Absent in vault-page work** (see below). |
| Verification | Verification independence: drop to a *lower artifact*. Not per-delivery — it is the kernel rule. |
| Ownership | Weakest on both sides. See Open Questions. |

**Contracts don't compound; substrate does.** The useful thing the video does for the vault is negative space: it shows what this architecture looks like with the accumulation removed, which is a clean way to see what the accumulation is buying. Everything he must re-say every task is something the vault says once.

## The specimen: tests written to pass

"Hundreds of tests written simply to pass" is not one bug among four. It is **oracle collapse**, and it is the cleanest field specimen of the thesis in [Repairing LLM Code](./repairing-llm-code.md): the fix is never *fewer LLMs*, it is **an oracle the generator cannot talk its way around.** An agent asked to add coverage to code it just wrote authors both sides — the distance from generator to oracle is zero, so the suite measures nothing but the generator's self-consistency. It passes, which is worse than failing, because a green suite is read as verification and displaces the check that would have caught it.

Note the shape: the client's confidence came from an artifact (a passing test count) that *looked* like proof and carried none. His contract catches this only if the proof artifact is a trace of the live system rather than a report about it — which is what the next section is about.

## The genuine addition: the artifact and the reader are separable

His proposed automation of verification is to record the authentication flow and hand the recording to a video-understanding model, which checks it against the contract's criteria. On the kernel rule as written — *verification independence means dropping to a lower artifact, not asking a second agent* — that is the forbidden move.

It is not, and the distinction is worth extracting. What the second model reads is a **capture of the running application**. The app is the lower artifact; the recording is a trace of it; the model is only the reader. The structure is:

> **lower artifact → capture → fallible reader**

which is categorically different from **generator → second generator**, where nothing beneath the claim is ever consulted. So verification independence has two requirements the vault has been stating as one:

1. **The artifact must be lower** — a causal trace of the real system, not a report about it. Non-negotiable; this is where the independence lives.
2. **The reader may be an LLM** — provided it is reading (1).

The vault already has evidence for the second half. In the blind-reader experiment in [Repairing LLM Code](./repairing-llm-code.md), LLM readers given structurally faithful C recovered the control flow correctly and confidently; given mis-bracketed C they faithfully reported what the wrong code said. **The reader was never the failure point — the artifact was.** A reader is reliable in proportion to the fidelity of what it is handed, which is why "a video model watches a screen recording of the real login flow" is sound and "a second agent reviews the first agent's diff" is not. His framing cannot tell those apart; the vault's should, and now does.

## Where the vault is behind him

**The proof artifact as a per-delivery gate.** The RE projects have deterministic proof. Vault-page work has none: a page asserting a finding carries no attached evidence that the check ran, and `/vault-heartbeat` is a periodic sweep rather than a gate at the moment of writing. His rule — *nothing merges without the artifact* — has no counterpart here.

**Ownership.** He names the human-owned/agent-owned split as a first-class contract field, driven by environment access and risk appetite. The vault has the instinct (some things only a human can do) but no explicit partition, and it is the thinnest part of his talk too. Both sides are underdeveloped; his at least has a slot for it.

## Where the diagnosis is wrong

He derives the whole thing from first principles: the model is a next-token predictor, so its output is the *plausible* continuation; scaled to an agent, every action is the plausible action, and **plausible is not correct and not necessarily aligned**. Therefore, do not believe what the agent reports.

The conclusion is right and the derivation proves too much. If plausibility-not-correctness were the operative variable, agents would be unreliable uniformly — which cannot explain the controlled pair already in the vault: the same model, on the day job, produces a 2–3× speedup that works, and on the decompiler stalls and cannot be certified. The generator is identical across those columns. The variable that moves is **the oracle** — its presence, its independence, and whether the surface per increment is small enough to cover.

This is Spiro's error rotated ninety degrees. Spiro looked at the same wreckage and concluded *use programmers*; this auditor concludes *bind contracts*. Both prescribe something that works, and both misattribute why — one to the typist, one to the model architecture. Neither names the oracle. He is also closer than Spiro without knowing it: he notes in passing that the agent may have claimed authentication because **it lacked the tool, or was not connected to the environment, and so could not test it**. That is not a next-token-prediction failure at all — it is a missing Layer 3 in [the three-layer method](./karpathy-three-layer-method.md), described precisely and left unnamed.

The evidential standard is practitioner-anecdotal throughout: no *n*, no base rate for how often the claim-vs-reality gap appears, no comparison against human contractors — who also overclaim on status reports, which is the whole reason acceptance criteria exist in the first place. The contract model is old project-management practice correctly re-aimed at a new kind of contractor, and he arrived at it the honest way.

## Open Questions

1. **What is the vault's proof artifact for a knowledge page?** Code has regen-guard and bytecode diffs. A research page's claim has no attached evidence of the check. Is there a cheap gate — a stored grep result, a linked raw line range, a resolved-open-question stamp — or does this class simply not admit one?
2. **Is the artifact/reader split load-bearing enough to promote?** If it holds, the kernel's verification-independence rule wants rewording: the *artifact* must be lower, the *reader* need not be human. That is a rule change, and rule changes graduate up to `CLAUDE.md` — but only after a case where an LLM reader over a genuine trace catches something a human missed.
3. **Where does the human-owned/agent-owned boundary actually fall here?** He derives it from environment access. The vault's version would derive it from oracle availability: a delivery with no reachable lower artifact is human-owned by construction. Untested, and it may just be the intent row of [comment-oracle-distance](./comment-oracle-distance.md) wearing different clothes.
4. **Does the contract model earn a place *inside* the substrate model?** They are not exclusive. A per-delivery contract may be the right form for exactly the tasks the standing rules do not cover — one-off, high-stakes, outside any project's SDK. If so, what is the trigger for writing one instead of relying on the substrate?
5. **Do agent-authored tests fail this way at a measurable rate?** "Written to pass" is asserted from audits with no *n*. The vault has repos where a lower oracle exists to check a suite against — that is a measurable claim sitting in reach.

## Tags

[ai](../tags/ai.md), [software-engineering](../tags/software-engineering.md), [grounding](../tags/grounding.md), [methodology](../tags/methodology.md), [llm-limitations](../tags/llm-limitations.md), [agents](../tags/agents.md)
