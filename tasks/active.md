# Active Tasks & Goals
> Current things to do, tracked and linked.

**Updated:** 2026-03-12

## Completed

### GitHub Migration ✓
Moved all `source/repos/` projects to GitHub under `chrisaacson69`. Vault is its own repo; code projects are separate repos. Vault project pages use `**Repo:**` fields pointing to GitHub URLs.

**Repos pushed:**
- [Vault](https://github.com/chrisaacson69/Vault) — personal knowledge system
- [camelot_from_youtube](https://github.com/chrisaacson69/camelot_from_youtube) — DJ track analysis toolkit
- [batch-resize](https://github.com/chrisaacson69/batch-resize) — image batch resizer
- [order-playlist](https://github.com/chrisaacson69/order-playlist) — DJ playlist optimizer
- [monopoly](https://github.com/chrisaacson69/monopoly) — Monopoly AI (reorganized: ai/, player/, research/, integration/, source-material/)
- [slay](https://github.com/chrisaacson69/slay) — hex strategy game (Python)
- [slay-c](https://github.com/chrisaacson69/slay-c) — hex strategy game (C port)
- [triangular-arbitrage](https://github.com/chrisaacson69/triangular-arbitrage) — currency/crypto arbitrage
- [pytorch-learning](https://github.com/chrisaacson69/pytorch-learning) — PyTorch tutorial series
- [pytorch-audio-learning](https://github.com/chrisaacson69/pytorch-audio-learning) — TorchAudio tutorial series

## In Progress

### ~~Is-Ought Bridge / Grounding Morality~~ — Closed
Resolved via performative grounding: the "is" already contains the "ought" because agents who exist are already acting, and acting presupposes valuation. Hume was right that logic alone can't bridge it, but the questioner is already on the other side. See [Morality README](../research/philosophy/morality/README.md) line ~44: "The bridge is closed."

### Debate Prep: Press Freedom (Topic #6)
Accepted invite. Affirmative: "Free access of the press is critical to a healthy, functioning democracy." Date TBD. Prep sheet and opening script complete. Research page written.
- [Debate Prep](../notes/debate-prep-press-freedom.md)
- [Press Freedom and Governance](../research/philosophy/dynamics/press-freedom-and-governance.md)

### YouTube Animation Studio — Infrastructure
Custom Docker image for RunPod deployed. Three repos:
- [animation-studio-pod](https://github.com/chrisaacson69/animation-studio-pod) — Docker image + CI (`ghcr.io/chrisaacson69/animation-studio-pod:1.1.0`)
- [animation-studio](https://github.com/chrisaacson69/animation-studio) — episode scripts, studio tools, assets
- ComfyUI + Manim + Fish Speech TTS + Claude Code baked in. Media server on port 8080.
- **Next:** Test on GPU pod when available; first-time auth setup (`claude login` → `gh auth login` → `save-auth`)

### Bridge Pages: Logic → Morality (Sketched, Waiting on Logic Series)
Two vault pages that connect the YouTube logic grounding to the morality framework. Write after logic series is complete.
1. **"Gödel Against Himself"** — Gödel was a Platonist; the Vault's alternative reading of incompleteness
2. **"Counting Requires Agents"** — numbers as agent-imposed abstraction (shepherd, clouds, height, Planck)
3. **"Agency as Moral Ground"** — TAG killer; morality presupposes agency, not God
- Full sketches: [Bridge Planning Note](../notes/bridge-logic-to-morality.md)
- Content pipeline: YouTube logic series → Page 1 → Page 2 → YouTube morality series

## Up Next

### ~~Epistemology — develop from stub~~ — Substantially developed
No longer a bare stub. Three developed pages now ground the position: [The Birthmark](../research/philosophy/epistemology/the-birthmark.md) (epistemic imperfection as feature, not bug; five principles for approaching truth), [Relational Objectivity](../research/philosophy/epistemology/relational-objectivity.md) (four-category ontology of facts), [The Weighting Problem](../research/philosophy/epistemology/weighting-problem.md) (objective measurements ≠ objective composites). The README still lists threads to explore (structural realism as foundation, Objectivist engagement, convergence limits), but the epistemological position is grounded.

### ~~Define "flourishing"~~ — Dissolved
Already resolved in the morality README: "flourishing" smuggles in subjective weighting. The framework doesn't need it. Agents determine what they want; empirics determines the best course of action. "Flourishing" = achieving desires, nothing more. The data speaks for itself.

### Property Rights — dedicated page
Labor-mixing (Locke → Rothbard → Objectivism) fails at the family unit, bakes "justified" into the definition. Conflict avoidance is the leading alternative ground. Needs formal treatment covering: labor-mixing critique, family counterexample, conflict avoidance grounding, the "justified" circularity, connection to self-ownership debate, trade-vs-conquest economics.
- [Self-Ownership and Property Rights](../research/philosophy/morality/legal-theory/self-ownership-and-property-rights.md)
- [Wilson vs Objectivism debate](../research/debates/wilson-objectivism-stance-dependence.md)

### ~~Coercion boundary analysis~~ — Resolved
Resolved by the action/inaction asymmetry (morality README): action is singular, inaction is the infinite complement. Acting to constrain = aggression. Not providing = default state. Structurally different categories. Grounds the negative/positive rights distinction.

### ~~Cognitive vs. Motor Skills~~ — Developed
Rewritten as hub page synthesizing content from measurement-causality (evolutionary progression, Libet, system interaction), cyborg model (practical implications), LLM grounding problem (what happens without grounding), and h-neurons (confidence injection). No longer a stub.

### Scope legitimacy criteria
Rules for when zoom-in vs. zoom-out is legitimate in the morality framework's scope model. Without this, scope-shifting is a tool for justification.

### Measurement Over Sentiment — unifying principle
The vault commits to evaluating systems by outcomes, not intentions, across multiple domains: morality (agency over intention), law (consequence over mens rea), economics (revealed preference over stated preference), merit (system outcomes over moral worth of inputs). This principle is implicit across four+ pages but has no dedicated articulation. Pull together as a cross-cutting vault page.
- [Morality](../research/philosophy/morality/README.md)
- [Mens Rea](../research/philosophy/morality/legal-theory/mens-rea.md)
- [Value and Profit](../research/economics/value-and-profit.md)
- [Market Efficiency and Human Limits](../research/economics/market-efficiency-and-human-limits.md)

## Someday / Maybe

- Constitutional analysis (dedicated page unifying all Constitutional threads)
- ~~Free speech / 1A analysis~~ — initial treatment in [Press Freedom and Governance](../research/philosophy/dynamics/press-freedom-and-governance.md); broader 1A analysis still needed
- 2nd Amendment analysis
- Fraud as aggression (without mens rea) + serial fraud problem
- Marriage / shared ownership under natural law
- Restitution for death
- Business models + agent team economics
- Money, competition, and capital theory

### ~~Monopoly Theory Integration~~ — Resolved
Repo research docs audited. Finding: vault's frontier-trade-theory and subgraph-trade-engine-spec already supersede the repo's working notes. Three missing concepts (denial value, knockout probability, empirical results) pulled into frontier-trade-theory. README mapping table expanded with status column showing what lives where. Repo's `positional-value-analysis.md` and `valuation-notes.md` are earlier working notes now captured in vault.
