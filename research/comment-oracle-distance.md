---
status: active — thesis grounded, experiment awaiting capture + second reader
created: 2026-08-26
published: false
layout: layouts/page.njk
title: "Comments and the Distance to an Oracle"
---
# Comments and the Distance to an Oracle
> A comment's value is not whether the fact is recoverable — given unlimited reach, every fact is. It's how far the reader must travel to recover it. Oracle availability is a *distance*, not a binary, and that single axis decides which comments get evicted, which get promoted out of the code, and which are the only surviving copy of something no artifact can hold.

**Links:** [Repairing LLM Code — The Two Oracles](./repairing-llm-code.md) — the parent; this is its readability axis applied to prose-in-code, [The Context Cache Hierarchy](../notes/context-cache-hierarchy.md) — promotion-without-eviction, and the locality correction it needed, [The Substrate Is the Governing Mechanism](./substrate-as-governance.md) — delete the sanctioned channel and coordination goes covert, [Building Swarms](../method/swarm-construction-rules.md) — the fan-out multiplier that makes comment weight architectural, [Practicality vs. Precision](./principled-llm-code.md) — mechanical-vs-analytical: if a rule is decidable, make it deterministic

## Provenance — what is measured and what is not

Honest status, because the thesis leans on an experiment this page does not yet hold:

- The A/B was run **2026-08-26 on a production C# codebase** (Chris's employer, not a vault repo): one function, full comments vs. reduced comments, cold readers, eight control-flow/behavior questions, graded against the code.
- The figures below are **as reported by the production-side agent**, relayed in session. The transcripts were still in a session-scoped harness scratchpad at the time of writing — **they must be captured to `raw/` to be reproducible**, and until then this page's numbers are second-hand.
- **Readers per condition is not yet recorded.** The [prior blind-reader experiment](./repairing-llm-code.md) found two independent readers agreeing on the *same wrong answer* with zero variance, so a per-question tally needs at least two readers per condition before it is citable as a number.
- All identifiers here are **anonymized**; the real ones stay in `raw/`. `published: false` until that separation is confirmed.

## The question, and why it isn't about style

When agents write code, comments proliferate. They earn their keep in the moment — they carry context the tool can't hold, and in multi-agent work they are how one agent tells the next what it did. Then the code ships, and the same comments read as noise.

The reflex answer ("delete what the code already says") is a style opinion. The interesting version is an **eviction rule with a test behind it**, which is the same problem the vault has already solved twice: once for memory tiers, once for readability of decompiled C.

## The correction that produced the thesis

The first framing proposed here was: *correctness grounds downward to a lower artifact; a comment grounds to nothing, so comments have no oracle, and superfluity is measured by whether transfer fidelity drops when you strip them.* The production session broke both halves — and the two objections turned out to be one objection.

**Objection 1 — the fidelity test has no cost term.** Both cold readers eventually answered the hard questions correctly; the trimmed reader just needed a second phase and four more files. Given unlimited access every fact in a comment is recoverable in principle, so a pure fidelity measure says *no comment ever carries anything*. The comment's value was never fidelity — it's **locality**, a cross-file fact placed at the point of use.

**Objection 2 — "no oracle" is too strong, and sometimes the oracle is out of reach.** `ParentIdLookup() returns its input unchanged` *does* ground downward — to another file. It is checkable, therefore it can rot detectably. But the stored procedure the method calls **is not in the repo at all**, and the global key lives in an attribute on the *type* (`[DatabaseKeyField(...)]`), not the method — so "drop an altitude" assumed a reachable lower artifact that, in the one genuinely unrecoverable case, did not exist.

Both objections restore the same missing variable: **cost to reach**. Oracle availability is not exists/doesn't. It is a distance.

## The partition

| Distance to oracle | Specimen from the session | Rot behavior | Verdict |
|---|---|---|---|
| **In-frame** — same file, same read | a wrapper whose body is one line away | detectable, cheaply | **Delete.** The reader arrives anyway; the comment is a cache of a thing already in view |
| **In-repo, out-of-frame** — another file, or a different scope of the same file | `ParentIdLookup` → its defining file; the type-level key attribute | detectable, but only if someone looks | **Keep, short.** A *scope* mismatch, not absence. Line-range reading makes this worse, not better |
| **Out-of-repo** — no artifact inside the boundary | the stored proc; a vendor API's ordering constraint | **silent** — the external thing changes and nothing in your repo moves | **Keep — and prefer importing the oracle.** Pin or snapshot the contract so the distance shrinks. Narrating an unreachable truth is the fallback, not the fix |
| **No oracle, ever** — intent | "returning true here is correct because approved domains partition parents" | unfalsifiable; a reversed decision leaves no trace | **Keep. This is the only copy** |

The result worth naming is the **inversion**: the class with *no* oracle is exactly the class that survives eviction. Everything verifiable is, by that same verifiability, a candidate for deletion.

## Intent is a primary record, not documentation

For mechanism claims the code is primary and the comment is a **cache** of it — a cache with no coherency protocol, which is why a stale comment is the one artifact in a repo that can be flatly wrong with nothing to notice. For intent there is no primary. The comment **is** the artifact: a primary record misfiled into a code file. You don't keep it because it's useful; you keep it because deleting it is data loss. In the session that produced this page, the cross-parent-duplicate reasoning *existed nowhere until it was said out loud.*

Two consequences the mechanism/intent split alone doesn't give you:

1. **Intent that spans call sites must be promoted out.** A comment has excellent locality on the **read** axis and none on the **find** axis — it is reachable only by already having opened the right lines, and you cannot search for it by the question it answers. So a decision governing five call sites belongs in a design record with a pointer left behind. Leaving it inline is the vault's own promotion-without-eviction failure wearing a different substrate.
2. **Intent needs a different janitor: provenance, not verification.** It cannot rot against an artifact, so it rots invisibly when the decision is reversed. Date it and link it to where the decision lives — the same bidirectional registration the memory tiers use. Without that, "keep all intent" becomes its own accretion problem.

## The repaired test

> **Load-bearing iff a reader restricted to a fixed context answers correctly with the comment and incorrectly without it.**

Fixing the context is what supplies the missing cost term. The production session ran exactly this as a Phase 1 (file-restricted) / Phase 2 (unrestricted) split, and it produced a distribution rather than an opinion — **as reported: of 8 questions, 4 needed no comment, 3 needed one, and 1 was answered either way but reached more cheaply with it.**

Two method notes for the next run:

- **Instrument cost behaviorally, not by self-report.** The eighth case was described as degrading "from certain to inferred," and [confidence is worthless as a signal](./repairing-llm-code.md) — the wrong readers in the prior experiment reported 4/5. Phase 2 already produced the right instrument: **files opened, turns taken.** Use it uniformly.
- **The file is one point on the cost curve, not the definition.** The honest generalization is *at budget B* — and sweeping B is how you would measure the distance axis directly instead of asserting it.

## The swarm turn — why this was worth tackling

Human readability is the smallest of the three uses. Comments are also (a) the context an agent reads before editing, and (b) **the channel one agent uses to tell the next what it did** — which makes them a coordination substrate, and [the substrate is the governing mechanism](./substrate-as-governance.md).

That page's warning applies directly: kill the sanctioned channel while the need persists and coordination does not stop, it goes **covert** — into names, dead parameters, structure chosen to signal rather than to work. So the production gate must evict *completed* channels, not the channel itself. And at fan-out the weight is architectural rather than hygienic: [every per-agent overhead is paid N times](../method/swarm-construction-rules.md).

The defect that makes this hard is that all of it wears one syntax. Type the comments and eviction becomes mechanical — [mechanical-vs-analytical](./principled-llm-code.md) applied to prose:

| Marker | Class | Lifetime | Evicted by |
|---|---|---|---|
| `WHY:` | intent — the no-oracle class | durable; promoted out when it spans call sites | never automatically; audited for provenance |
| `TODO(TICKET)` | work backlog, addressed to a human | outlives the session | closing the ticket |
| `AGENT:` | inter-agent coordination | dead at end of run | the production gate, mechanically |

The codebase in question **already runs half the convention** — ticket-scoped `TODO(...)` markers are in use and work. What is missing is a durable tag, and a transient one distinguishable from it, which is why stripping agent chatter currently risks stripping the backlog.

This also turns [substrate-as-governance's open question #2](./substrate-as-governance.md) — *does owning the substrate actually keep coordination in it?* — from untested into an experiment with a control: sanction `AGENT:`, strip at the gate, and watch whether handoff information stays inside the marker or reappears in naming and structure.

## Open Questions

1. **Does the distance axis survive measurement?** Sweeping the reader's budget B should produce a monotone curve — comment value rising with distance. Untested; currently a partition asserted from four specimens.
2. **Where is the crossover for `AGENT:` comments?** [Building Swarms](../method/swarm-construction-rules.md) asks the same of shared workspaces: below some fan-out width, is inline coordination simply correct?
3. **Does prescribing the marker keep coordination inside it** — or does an optimized swarm abuse a sanctioned schema into a private encoding, the way [any format eventually is](./substrate-as-governance.md)?
4. **Can the in-repo/out-of-frame row be automated away?** A type-level attribute governing a method is a scope mismatch a tool could surface at the point of use — which would delete the whole second row rather than commenting it.
5. **Is there a rot detector for the third row?** Out-of-repo oracles fail silently by construction. Contract snapshots convert distance into an in-repo artifact — how much of the class does that actually cover?

## Tags

[ai](../tags/ai.md), [software-engineering](../tags/software-engineering.md), [grounding](../tags/grounding.md), [methodology](../tags/methodology.md), [llm-limitations](../tags/llm-limitations.md)
