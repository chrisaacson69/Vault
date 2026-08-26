---
status: active — thesis grounded; stimuli + protocol captured to raw/, replication at n>1 pending
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
- **Captured:** [`raw/datasets/comment-oracle-coldread-2026-08-26/`](../raw/datasets/comment-oracle-coldread-2026-08-26/README.anon.md) holds both stimuli byte-exact, the verbatim protocol, and the relayed results with per-claim verification.
- **The reader transcripts are lost** — both agent output files were 0 bytes when checked. The *stimuli and protocol* survive, so the experiment is **reproducible but the original run is not archivable**. The figures below are condensed from the orchestrating session's log, not verbatim reader text.
- **n = 1 per arm.** One reader per condition, two agents total — recorded, not unknown. So the tally below is a single paired observation, not a distribution. The [prior blind-reader experiment](./repairing-llm-code.md) found two independent readers agreeing on the *same wrong answer* with zero variance, which is exactly why one reader per arm cannot separate "the comment helped" from "this reader dug harder."
- **Phase 1 was captured asymmetrically.** Reader B reported its file-restricted answers explicitly; Reader A reported only its Phase 2 corrections, so Arm A's column was reconstructed by inference. A replication must harvest Phase 1 as a returned artifact *before* granting repo access.
- **The arms differ by more than comment volume.** The trim also reworded the XML `<param>` tags, so the reduced arm *gains* a directly-stated fact while losing 38 comment lines. At n=1 that is a live alternative explanation for the parent-resolution questions.
- All identifiers here are **anonymized**; the real ones stay in `raw/`. `published: false` until that separation is confirmed.

## The question, and why it isn't about style

When agents write code, comments proliferate. They earn their keep in the moment — they carry context the tool can't hold, and in multi-agent work they are how one agent tells the next what it did. Then the code ships, and the same comments read as noise.

The reflex answer ("delete what the code already says") is a style opinion. The interesting version is an **eviction rule with a test behind it**, which is the same problem the vault has already solved twice: once for memory tiers, once for readability of decompiled C.

## The correction that produced the thesis

The first framing proposed here was: *correctness grounds downward to a lower artifact; a comment grounds to nothing, so comments have no oracle, and superfluity is measured by whether transfer fidelity drops when you strip them.* The production session broke both halves — and the two objections turned out to be one objection.

**Objection 1 — the fidelity test has no cost term.** Both cold readers eventually answered the hard questions correctly; the trimmed reader just needed a second phase and four more files. Given unlimited access every fact in a comment is recoverable in principle, so a pure fidelity measure says *no comment ever carries anything*. The comment's value was never fidelity — it's **locality**, a cross-file fact placed at the point of use.

**Objection 2 — "no oracle" is too strong, and sometimes the oracle is out of reach.** `ParentIdLookup() returns its input unchanged` *does* ground downward — to another file. It is checkable, therefore it can rot detectably. But the stored procedure the method calls **is not in the repo at all**, and the global key lives in an attribute on the *type* (`[KeyField(...)]`), not the method — so "drop an altitude" assumed a reachable lower artifact that, in the one genuinely unrecoverable case, did not exist.

Both objections restore the same missing variable: **cost to reach**. Oracle availability is not exists/doesn't. It is a distance.

## The partition

| Distance to oracle | Specimen from the session | Rot behavior | Verdict |
|---|---|---|---|
| **In-frame** — same file, same read | a wrapper whose body is one line away | detectable, cheaply | **Delete.** The reader arrives anyway; the comment is a cache of a thing already in view |
| **In-repo, out-of-frame** — another file, or a different scope of the same file | `ParentIdLookup` → its defining file; the type-level key attribute | detectable, but only if someone looks | **Keep, short.** A *scope* mismatch, not absence. Line-range reading makes this worse, not better |
| **Out-of-repo** — no artifact inside the boundary | the stored proc; a vendor API's ordering constraint | **silent** — the external thing changes and nothing in your repo moves | **Keep — and prefer importing the oracle.** Pin or snapshot the contract so the distance shrinks. Narrating an unreachable truth is the fallback, not the fix |
| **Outside the software** — the operational envelope | "this key is duplicable in principle, but only if someone forces it" | falsifiable **only by an incident** — the world changes and no artifact moves | **Keep.** No artifact holds a frequency. Convert it to a guard where you can; where you can't, the comment is the guard |
| **No oracle, ever** — intent | "returning true here is correct because approved domains partition parents" | unfalsifiable; a reversed decision leaves no trace | **Keep. This is the only copy** |

The result worth naming is the **inversion**: the class with *no* oracle is exactly the class that survives eviction. Everything verifiable is, by that same verifiability, a candidate for deletion.

**And one row is not like the others: row 2 is audience-asymmetric.** Distance is measured from *the reader*, so it depends on what the reader is holding. A human with an IDE has had row 2 solved for twenty-five years — hover, go-to-definition, inlay hints, and find-references collapse "another file, or another scope" to nearly zero cost. Agents read line ranges through a file API with no hover at all, so the identical fact sits at a completely different distance for them. The specimen is in the session that produced this page: the orchestrator read the very file containing `[KeyField(...)]` many times, by line range, and never saw it — 450 lines above the method it governed.

That reframes a large share of agent comment proliferation. **Row-2 comments are a prosthetic for tooling the reader doesn't have**, which means the honest fix is usually not to write the comment but to close the gap — give the agent the language server. It is the same *import the oracle* move as row 3, and the same reuse-over-rebuild rule the vault applies everywhere: a symbol index that already exists and is always correct beats prose that duplicates it and silently rots. The prediction that follows is testable and sharp: **row 2 shrinks as agent tooling acquires what IDEs already have; rows 3–5 do not shrink at all**, because no amount of tooling reaches a stored proc outside the repo, a frequency in the world, or a reason that was never written down. See open question 4 for the part that is still genuinely open.

## Intent is a primary record, not documentation

For mechanism claims the code is primary and the comment is a **cache** of it — a cache with no coherency protocol, which is why a stale comment is the one artifact in a repo that can be flatly wrong with nothing to notice. For intent there is no primary. The comment **is** the artifact: a primary record misfiled into a code file. You don't keep it because it's useful; you keep it because deleting it is data loss. In the session that produced this page, the cross-parent-duplicate reasoning *existed nowhere until it was said out loud.*

Two consequences the mechanism/intent split alone doesn't give you:

1. **Intent that spans call sites must be promoted out.** A comment has excellent locality on the **read** axis and none on the **find** axis — it is reachable only by already having opened the right lines, and you cannot search for it by the question it answers. So a decision governing five call sites belongs in a design record with a pointer left behind. Leaving it inline is the vault's own promotion-without-eviction failure wearing a different substrate.
2. **Intent needs a different janitor: provenance, not verification.** It cannot rot against an artifact, so it rots invisibly when the decision is reversed. Date it and link it to where the decision lives — the same bidirectional registration the memory tiers use. Without that, "keep all intent" becomes its own accretion problem.

## The envelope class — where a comment suppresses a false positive

The strongest specimen in the session was not intent, and it is the row that was missing. **Both readers independently concluded that a key value could exist across two different customers, and reported it as a contract mismatch — and the agent with edit rights escalated it as a defect, proposing three remediations.** They were right about the artifacts and wrong about the system: the duplicate is possible in principle but would have to be *forced*, so the code's uniqueness assumption is **not technically correct and operationally true.** Nothing in the repo says so. The schema permits the duplicate, the code assumes it away, and the reconciliation is a fact about how the business is actually operated.

The division of labour there is itself the evidence. The two read-only readers *described* the mismatch and stopped. The orchestrating agent — the one that could edit — moved to fix it. That is the predicted behaviour observed directly, and it is a stronger specimen than reader consensus, because a reader that cannot act cannot demonstrate the failure this class produces.

This differs from intent in a way worth keeping separate. Intent states what we *want* and is unfalsifiable. An envelope claim states what *is*, contingently, outside the software — falsifiable, but only by an incident, never by a test. And it has a distinctive signature: **it makes correct code look like a bug.**

That signature is why this class matters more for agent readers than for human ones. A human who reads "assume unique" shrugs and moves on. An agent with edit rights *fixes* it — adds a dedupe, tightens a guard, files a defect. All three agents here — two readers and the orchestrator — reached the same conclusion with no variance between them, and the only one able to act moved to change working code. That is the vault's [known failure mode](./repairing-llm-code.md): consensus is not a correctness check, and an ensemble cannot separate right from wrong when the error is in the shared input. The comment is the only thing in the system that breaks that tie.

So the cost of omitting an envelope comment is not a slower read — it is a **wrong action taken confidently.** That is a different loss function from every other row, and it is the first case in this page where the comment is doing a job no cheaper artifact can do at all.

**It also carries its own exit.** Chris's own framing — *it would have to be forced* — describes an unenforced precondition, and unenforced preconditions can usually be enforced: add the constraint, or a guard that throws on the forced case. That converts the fact from prose into an executable artifact and the comment can then be deleted, which is row 3's *import the oracle* move applied one row down. Where the escape hatch is deliberate — the business wants the forced case to remain possible — the reason for *not* enforcing it is intent, and it graduates to `WHY:`. Either way the comment has a defined fate instead of sitting there forever.

**Audience changes the job.** This is the clean statement of why the human and agent cases diverge, and it is Chris's observation: to a human, comments are mostly about intent — the *why*, since a competent reader recovers the *what*. Agents already recover the *what* reliably; what they lack is the envelope. So an agent-facing comment set is doing three jobs, only one of which a human comment set usually does:

1. **Intent** — why this is the right behavior (human and agent alike).
2. **Envelope** — why this correct-looking defect is not one (agent-critical, human-optional).
3. **Coordination** — what the last agent did and what the next should not touch (agent-only).

## The repaired test

> **Load-bearing iff a reader restricted to a fixed context answers correctly with the comment and incorrectly without it.**

Fixing the context is what supplies the missing cost term. The production session ran exactly this as a Phase 1 (file-restricted) / Phase 2 (unrestricted) split, and it produced a **per-question verdict** rather than an opinion — **of 8 questions, 4 needed no comment, 3 needed one, and 1 was held with certainty in the verbose arm but only inferred in the reduced one.** At n=1 per arm this is a single paired observation, not yet a distribution; the value is that the test is *decidable per question*, which an aggregate readability judgement never is.

The three comment-dependent questions all concerned facts residing in other files — which is the distance thesis surviving its own experiment rather than being assumed by it. **With one honest caveat that lands on exactly these questions:** the trim also reworded the XML `<param>` tags, so the reduced arm gained a directly-stated fact while losing 38 comment lines. Those are the parent-resolution questions. At n=1 the confound is a live alternative explanation for the strongest result on the page, and the replication must hold the `<param>` text fixed across arms so the only variable is comment volume.

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
| `ASSUMES:` | the operational envelope — an unenforced precondition | durable until enforced | writing the guard that enforces it (then delete), or a deliberate decision not to (then it becomes `WHY:`) |
| `TODO(TICKET)` | work backlog, addressed to a human | outlives the session | closing the ticket |
| `AGENT:` | inter-agent coordination | dead at end of run | the production gate, mechanically |

`ASSUMES:` is the only one of the four that is also a **do-not-fix signal** — it exists precisely because an agent reasoning correctly from the artifacts will otherwise "repair" working code. The other three tell a reader something; that one stops an action.

The codebase in question **already runs half the convention** — ticket-scoped `TODO(...)` markers are in use and work. What is missing is a durable tag, and a transient one distinguishable from it, which is why stripping agent chatter currently risks stripping the backlog.

This also turns [substrate-as-governance's open question #2](./substrate-as-governance.md) — *does owning the substrate actually keep coordination in it?* — from untested into an experiment with a control: sanction `AGENT:`, strip at the gate, and watch whether handoff information stays inside the marker or reappears in naming and structure.

## Open Questions

1. **Does the distance axis survive measurement?** Sweeping the reader's budget B should produce a monotone curve — comment value rising with distance. Untested; currently a partition asserted from four specimens.
2. **Where is the crossover for `AGENT:` comments?** [Building Swarms](../method/swarm-construction-rules.md) asks the same of shared workspaces: below some fan-out width, is inline coordination simply correct?
3. **Does prescribing the marker keep coordination inside it** — or does an optimized swarm abuse a sanctioned schema into a private encoding, the way [any format eventually is](./substrate-as-governance.md)?
4. **Row 2 is already automated away — for humans.** This is not a question about a tool that might exist; it is an asymmetry in who has one. An IDE surfaces a type-level attribute or a callee's contract on hover, which is why human readers rarely need row-2 comments and why the codebase's existing comment set — written by and for humans with IntelliSense — is thin in exactly that row. Agents read line ranges through a file API with no hover: in the session that produced this page, the orchestrator read the very file holding `[KeyField(...)]` many times by line range and never saw it, 450 lines above the method. So the prediction is that **row 2 shrinks as agent tooling acquires what IDEs already have, while rows 3–5 do not** — the second row is a tooling deficit wearing a documentation costume. The open part is whether hover-equivalents can reach the out-of-frame *reasons* (a callee's failure behaviour) as well as its signature, since the signature is what tooling actually surfaces and the behaviour is what the reader needed.
5. **Is there a rot detector for the third row?** Out-of-repo oracles fail silently by construction. Contract snapshots convert distance into an in-repo artifact — how much of the class does that actually cover?

## Tags

[ai](../tags/ai.md), [software-engineering](../tags/software-engineering.md), [grounding](../tags/grounding.md), [methodology](../tags/methodology.md), [llm-limitations](../tags/llm-limitations.md)
