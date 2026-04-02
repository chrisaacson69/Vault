# Vault Gap Audit — 2026-02-28
> Comprehensive audit of holes, stubs, underdeveloped arguments, missing cross-links, and implied-but-unwritten topics across the vault.

**Status:** reference
**Created:** 2026-02-28
**Links:** [INDEX](../INDEX.md), [Active Tasks](../tasks/active.md)

## Summary

After reading every file in the vault, this audit identifies **4 categories of gaps** across **6 domains**. The gaps are ranked by severity: how much they weaken the vault's interconnected reasoning.

---

## 1. CRITICAL — Self-Labeled Stubs and Foundational Gaps

These are files the vault itself acknowledges as incomplete, AND that other files depend on.

### ~~1.1 Epistemology is a stub~~ — SUBSTANTIALLY DEVELOPED
- **Resolution:** No longer a bare stub. Three developed pages now ground the position: [The Birthmark](../research/philosophy/epistemology/the-birthmark.md) (epistemic imperfection is a feature; five principles for approaching truth), [Relational Objectivity](../research/philosophy/epistemology/relational-objectivity.md) (four-category ontology of facts; "relational" ≠ "subjective"), [The Weighting Problem](../research/philosophy/epistemology/weighting-problem.md) (objective measurements ≠ objective composites). The README still has threads to explore (structural realism formalization, Objectivist engagement, convergence limits), but the foundation is laid.

### ~~1.2 Cognitive vs. Motor Skills is a stub~~ — DEVELOPED INTO HUB PAGE
- **Resolution:** Content was already developed across measurement-causality (evolutionary progression, Libet reframe, system interaction), cyborg-model (practical implications), llm-grounding-problem (what happens without grounding), and h-neurons (confidence injection pipeline). The stub has been rewritten as a hub page that synthesizes and cross-references all of this, with new links to h-neurons and conservation-of-complexity.

### ~~1.3 The Is-Ought Bridge is incomplete~~ — CLOSED
- **Resolution:** Resolved via performative grounding in [morality README](../research/philosophy/morality/README.md) (line ~44): "The bridge is closed." The "is" already contains the "ought" — agents who exist are already acting, acting presupposes valuation. Hume was right that logic alone can't bridge it, but the questioner is already standing on the other side. Supported by [Performative Grounding — Lineage](../research/philosophy/morality/performative-grounding-lineage.md) tracing the move from Aristotle through Apel, Gewirth, Hoppe, and Korsgaard.

---

## 2. HIGH — Arguments Raised But Not Resolved

These are threads opened in existing files that were left hanging. They weaken the arguments they appear in.

### 2.1 Scope legitimacy criteria — the scope model's biggest vulnerability
- **File:** [research/philosophy/morality/README.md](../research/philosophy/morality/README.md) (line ~89)
- **Quote:** "Without a criterion for which scope applies when, scope-shifting becomes a tool for justification."
- **Problem:** The scope model (narrow/medium/broad) is powerful but has no rules for when zoom-in vs. zoom-out is legitimate. Every historical atrocity used scope-shifting. This is acknowledged but unfixed.

### ~~2.2 Defining "flourishing"~~ — DISSOLVED
- **Resolution:** The framework doesn't need a definition of "flourishing." The word smuggles in subjective weighting. Agents determine what they want; empirics determines the best course of action. "Flourishing" = achieving desires. Already resolved in [morality README](../research/philosophy/morality/README.md) (line ~164).

### 2.3 The filter problem — convergence validates both good and bad patterns
- **File:** [research/philosophy/morality/README.md](../research/philosophy/morality/README.md) (line ~101)
- **Problem:** Cross-cultural convergence is used as evidence for moral objectivity, but civilizations also converged on slavery, patriarchy, and out-group violence. Error-correction over centuries is proposed as the filter, but the timescale problem ("what does a person living inside an uncorrected error do?") is unresolved.

### ~~2.4 The coercion boundary~~ — RESOLVED
- **Resolution:** The [action/inaction asymmetry](../research/philosophy/morality/README.md#the-actioninaction-asymmetry) resolves this: action is singular (one thing you're doing); inaction is the infinite complement (everything you're not doing). Acting to constrain someone = aggression, evaluable. Not providing something = default state, not the same class. This grounds the negative/positive rights distinction structurally.

### 2.5 "Best system so far" — the strongest pragmatic defense, underdeveloped
- **File:** [research/debates/moral-foundations-wilson-whatever.md](../research/debates/moral-foundations-wilson-whatever.md)
- **Problem:** In the moral foundations debate, the argument "secular morality doesn't need ultimate justification — it's the best system so far" was identified as the strongest move but left underdeveloped. This is actually a Popperian/evolutionary argument that connects to error-correction and the civilizational cycles work.

### 2.6 The Gödel trap — acknowledged but unresolved
- **File:** [research/philosophy/morality/scope-confusion.md](../research/philosophy/morality/scope-confusion.md) (line ~56)
- **Problem:** "A system powerful enough to govern itself is powerful enough to destroy itself." The amendment process is offered as friction, but the open question — does the Gödel trap have a solution, or only management? — is central to whether constitutional design can ever "break the cycle."

### 2.7 Repeat offenders and serial fraud
- **File:** [research/philosophy/legal-theory/mens-rea.md](../research/philosophy/legal-theory/mens-rea.md) (line ~249)
- **Problem:** If each breach is treated in isolation (no intent analysis), how does the system identify and respond to serial fraud? The framework's victim-focus doesn't naturally aggregate across victims.

### 2.8 Degrees of information in the free will principle
- **File:** [research/philosophy/legal-theory/mens-rea.md](../research/philosophy/legal-theory/mens-rea.md) (line ~254)
- **Problem:** The free will principle hinges on "informed" vs "uninformed" agents, but information is a spectrum. Partially informed participants need a cleaner treatment.

---

## 3. MEDIUM — Missing Topics Implied by Existing Work

These are topics the vault's own files explicitly call for but that haven't been written yet.

### 3.1 Constitutional Analysis (dedicated page)
- **Called for in:** [research/philosophy/legal-theory/README.md](../research/philosophy/legal-theory/README.md) (line ~46)
- **Quote:** "It may warrant its own dedicated page examining the document as a whole."
- **Why needed:** The Constitution surfaces across civilizational cycles, government formation, scope confusion, 1A, 2A, and multiple debates. A dedicated page would unify these threads.

### 3.2 Marriage under Natural Law
- **Called for in:** [research/philosophy/legal-theory/README.md](../research/philosophy/legal-theory/README.md) — "Upcoming Topics"

### 3.3 Shared Ownership under Libertarian Law
- **Called for in:** [research/philosophy/legal-theory/README.md](../research/philosophy/legal-theory/README.md) — "Upcoming Topics"
- **Also an open question in:** mens-rea.md (line ~251)

### 3.4 Fraud as Aggression (without mens rea)
- **Called for in:** [research/philosophy/legal-theory/README.md](../research/philosophy/legal-theory/README.md) — "Upcoming Topics"
- **Closely connected to:** the serial fraud gap (2.7 above)

### 3.5 Restitution for Death
- **Called for in:** [research/philosophy/legal-theory/README.md](../research/philosophy/legal-theory/README.md) — "Upcoming Topics"
- **Also an open question in:** mens-rea.md (line ~250)

### 3.6 Free Speech / 1A Analysis
- **Called for in:** [research/philosophy/legal-theory/README.md](../research/philosophy/legal-theory/README.md) — "Upcoming Topics"
- **Already partially developed in:** mens-rea's incitement analysis, scope-confusion's connection to speech restrictions

### 3.7 2nd Amendment Analysis
- **Called for in:** [research/philosophy/legal-theory/README.md](../research/philosophy/legal-theory/README.md) — "Upcoming Topics" (has substantial outline)

### 3.8 Business Models, Architecture & Guardrails, Agent Team Economics
- **Called for in:** [research/economics/README.md](../research/economics/README.md) — "Planned" section
- **Why needed:** The economics framework builds from value → risk → agent teams, but stops before "how do you actually structure an AI business?" These are the practical payoffs.

### 3.9 Money, Competition, and Capital Theory
- **Missing from:** economics research broadly
- **Why needed:** The economics section covers value, profit, risk, and insurance but never treats money (as a medium of exchange distinct from barter), competition (as a process, not an outcome), or capital structure. These are foundational for the business model work.

### 3.10 The Insurance Transition Path
- **Referenced in:** [research/economics/insurance.md](../research/economics/insurance.md) — Open Questions
- **Why needed:** The insurance page makes a strong theoretical case for catastrophic-only insurance, but never addresses the practical question: how do you get from here to there? This is the policy-relevant gap.

---

## 4. STRUCTURAL — Cross-Links, Tags, and Maintenance Gaps

### 4.1 Missing Cross-Links

| From | Should Link To | Why |
|------|---------------|-----|
| [logic-and-math/README.md](../research/philosophy/logic-and-math/README.md) | [weighting-problem.md](../research/philosophy/epistemology/weighting-problem.md) | Weighting problem directly challenges convergence argument used in logic/math |
| [opposing-forces.md](../research/philosophy/opposing-forces.md) | [insurance.md](../research/economics/insurance.md) | Insurance interventionism spiral is a concrete case of opposing forces |
| [cyborg-model.md](../research/cyborg-model.md) | [measurement-causality.md](../research/philosophy/measurement-causality.md) | Measurement-causality provides the physical grounding for why cognitive/motor split exists |
| [llm-grounding-problem.md](../research/llm-grounding-problem.md) | [cognitive-vs-motor.md](../research/cognitive-vs-motor.md) | The grounding problem IS the cognitive layer operating without a motor grounding layer |
| [civilizational-cycles.md](../research/philosophy/civilizational-cycles.md) | [scope-confusion.md](../research/philosophy/morality/scope-confusion.md) | Scope confusion identifies the mechanism (enforcement escalation) behind the voluntary→coercion drift |
| [computation-and-information.md](../research/computation-and-information.md) | [opposing-forces.md](../research/philosophy/opposing-forces.md) | Computational irreducibility is one of the candidate explanations for opposing forces |

### 4.2 Empty Tasks File
- **File:** [tasks/active.md](../tasks/active.md)
- **Problem:** In-progress and up-next sections are empty despite 20+ open questions and planned topics across the vault. The task file should reflect the vault's actual research agenda.

### 4.3 Empty Logs Directory
- **File:** logs/
- **Problem:** CLAUDE.md instructs logging significant sessions. Many significant sessions have occurred (morality framework, scope confusion, mens rea literature review, bilateral trade implementation, gaming research). None logged.

### 4.4 INDEX.md Not Fully Current
- **Problem:** Several files exist that aren't in INDEX.md:
  - `research/gaming/multiplayer-coalition-problem.md`
  - `research/gaming/bilateral-trade-valuation.md`
  - Individual debate files (only the debates/README is indexed)

---

## Prioritized Action Plan

### Tier 1 — Foundation (weakens everything if left unfixed)
1. ~~Develop epistemology from stub~~ — substantially developed (Birthmark, Relational Objectivity, Weighting Problem)
2. ~~Complete or explicitly limit the is-ought bridge~~ — closed via performative grounding
3. ~~Define "flourishing"~~ — dissolved; agents define their own goals, empirics evaluates paths

### Tier 2 — Load-Bearing Gaps (referenced by multiple files)
4. ~~Develop cognitive-vs-motor from stub~~ — rewritten as hub page synthesizing content from 4 files
5. ~~Resolve the coercion boundary~~ — resolved via action/inaction asymmetry
6. Write scope legitimacy criteria
7. Write constitutional analysis page

### Tier 3 — Natural Extensions (called for by existing work)
8. Free speech / 1A analysis (partially written in incitement analysis)
9. Fraud as aggression + serial fraud problem
10. Marriage / shared ownership under natural law
11. Business models + agent team economics

### Tier 4 — Maintenance
12. Fix missing cross-links (table above)
13. Update tasks/active.md with research agenda
14. Create session logs for past significant work
15. Update INDEX.md with missing files

---

## Tags
[philosophy](../tags/philosophy.md), [economics](../tags/economics.md), [morality](../tags/morality.md)
