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

### 1.1 Epistemology is a stub — everything rests on it
- **File:** [research/philosophy/epistemology/README.md](../research/philosophy/epistemology/README.md)
- **Self-labeled:** "stub — collecting threads for future exploration"
- **Why critical:** The morality framework, logic/math framework, AND economics all assume **structural realism** (reality has structure, our formalisms model it, convergence is evidence of objectivity). This is an epistemological claim that has never been examined on its own terms. The weighting problem (the one developed page here) actually *challenges* the convergence argument — and the tension is acknowledged but unresolved.
- **What's needed:** Develop the structural realism position into a full argument. Engage with Kuhn (paradigm shifts), Polanyi (tacit knowledge), and the Objectivist chain. Resolve whether convergence on weightings (not just measurements) counts as evidence.

### 1.2 Cognitive vs. Motor Skills is a stub — referenced by 3 major pages
- **File:** [research/cognitive-vs-motor.md](../research/cognitive-vs-motor.md)
- **Self-labeled:** "stub — data dump for future exploration"
- **Why critical:** Referenced by the cyborg model, measurement-causality, and LLM grounding problem. The cognitive/motor split is a load-bearing distinction for the AI architecture argument ("LLMs are cognitive; robotics is motor"). Currently a placeholder with a list of topics to explore.
- **What's needed:** Develop the architecture comparison (transformer vs NN), the latency argument, the training difference, and the embodied cognition question. Connect formally to the measurement-causality framework's explanation of why the two layers exist.

### 1.3 The Is-Ought Bridge is incomplete — the morality framework's foundation
- **File:** [research/philosophy/morality/README.md](../research/philosophy/morality/README.md) (line ~46)
- **Self-labeled:** "The bridge is partially built."
- **Why critical:** The entire morality framework hangs on whether "you must act" gets you to "some choices are objectively better." If it doesn't, the framework describes pragmatic heuristics, not moral truths — which is still useful but a fundamentally different claim.
- **What's needed:** Either complete the bridge (show that agency + inescapable constraints compels specific moral conclusions) or explicitly accept the conditional-ought position (morality is objective *given* goals, but goals themselves aren't grounded). The weighting problem's "conditional-ought escape" is a candidate resolution.

---

## 2. HIGH — Arguments Raised But Not Resolved

These are threads opened in existing files that were left hanging. They weaken the arguments they appear in.

### 2.1 Scope legitimacy criteria — the scope model's biggest vulnerability
- **File:** [research/philosophy/morality/README.md](../research/philosophy/morality/README.md) (line ~89)
- **Quote:** "Without a criterion for which scope applies when, scope-shifting becomes a tool for justification."
- **Problem:** The scope model (narrow/medium/broad) is powerful but has no rules for when zoom-in vs. zoom-out is legitimate. Every historical atrocity used scope-shifting. This is acknowledged but unfixed.

### 2.2 Defining "flourishing" — the morality framework's dependent variable
- **File:** [research/philosophy/morality/README.md](../research/philosophy/morality/README.md) (line ~99)
- **Problem:** "Good choices tend toward flourishing" — but flourishing is never defined. Is it Aristotelian eudaimonia? Subjective well-being? Survival? The framework's predictive power depends on this, and it connects directly to the weighting problem (different definitions = different weightings).

### 2.3 The filter problem — convergence validates both good and bad patterns
- **File:** [research/philosophy/morality/README.md](../research/philosophy/morality/README.md) (line ~101)
- **Problem:** Cross-cultural convergence is used as evidence for moral objectivity, but civilizations also converged on slavery, patriarchy, and out-group violence. Error-correction over centuries is proposed as the filter, but the timescale problem ("what does a person living inside an uncorrected error do?") is unresolved.

### 2.4 Positive vs. negative rights — referenced but never developed
- **Files:** [research/philosophy/measurement-causality.md](../research/philosophy/measurement-causality.md) (line ~92), [research/philosophy/legal-theory/government-formation.md](../research/philosophy/legal-theory/government-formation.md) (line ~265)
- **Problem:** The coercion analysis distinguishes "limiting choices" from "not providing choices" and flags this as mapping onto positive vs. negative rights. The government formation page lists it as an open question. Neither develops it. This is a critical boundary for the legal theory — it determines how minimal the minimal state should be.

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
1. Develop epistemology from stub to full argument
2. Complete or explicitly limit the is-ought bridge
3. Define "flourishing" (even provisionally)

### Tier 2 — Load-Bearing Gaps (referenced by multiple files)
4. Develop cognitive-vs-motor from stub
5. Resolve positive vs. negative rights
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
