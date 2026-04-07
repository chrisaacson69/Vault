---
status: sketch — intended as a bridge between the Vault's observations and George Montañez's conservation of information research
created: 2026-03-31
---
# Conservation of Complexity — A Cross-Domain Pattern
> Computational work is conserved across transformations. You can move the cost, but you can't destroy it. This pattern appears in information theory, physics, economics, mathematics, and philosophy.

**Links:** [Hayek vs Mises](./hayek-vs-mises-calculation.md), [Gödel Against Himself](./godel-against-himself.md), [Planck Measurement](./planck-measurement-working-note.md), [Counting Requires Agents](./bridge-logic-to-morality.md)
**Related research:** Montañez, "The Famine of Forte" (2017); Montañez et al., conservation of information in learning systems (2019); Shannon-Hartley theorem (1948); Gödel incompleteness (1931); Mises calculation problem (1920); Wolfram computational irreducibility

---

## The Pattern

Across multiple domains, the same structure appears: a system hits a limit, an ingenious workaround is found, but the workaround moves the cost rather than eliminating it. The total work is conserved.

| Domain | Apparent limit | Workaround | Where the cost moved |
|---|---|---|---|
| **Shannon** | Channel capacity: C = B·log₂(1+S/N) | MIMO: multiple channels through same medium | Physical infrastructure (more antennas, spectrum) |
| **Planck measurement** | Sequential scan of a proton: ~1 billion years | Parallel measurement | Need 10^40 simultaneous sensors |
| **P = NP** | Exponential search time | Precompute all answers, O(1) lookup | Exponential storage + exponential precompute time |
| **Mises calculation** | No prices without markets | Simulate the market with AI | Simulation IS a market; opportunity cost of compute |
| **Model collapse** | AI trained on AI degrades | Keep original human data | Need to distinguish human from AI text (increasingly impossible) |
| **Gödel** | Incomplete OR inconsistent | Add axioms to capture missing truths | New system has its own Gödel sentence |
| **Cantor** | Can't enumerate the reals | Construct a "complete" set theory | Continuum hypothesis is undecidable |
| **Chaos theory** | Prediction diverges from reality | More precise initial measurements | Precision cost grows faster than prediction horizon |
| **Deontology/Consequentialism** | Can't compute consequences of actions | Follow rules (cached consequences) | Rules are approximations that break in edge cases |

Every row is the same story: the limit is real, the workaround is clever, and the cost is conserved.

---

## Connection to Montañez's Conservation of Information

Montañez formalizes this pattern for information/search: I(original problem) ≤ I(problem | helper) + I(helper). Any information "saved" by having a good model is offset by the information cost of obtaining that model. Extended (2019) to any artificial learning system, and further to any probabilistic search system.

This is the information-theoretic version of the pattern. But the pattern is broader than information theory:

- **In physics:** Planck measurement shows that observational work is conserved — you can trade time for parallelism but the total measurement cost doesn't shrink.
- **In economics:** Mises shows that computational work can't replace institutional process — simulating a market costs as much as running one, because the market IS the computation.
- **In mathematics:** Gödel shows that expressive power and completeness trade off — more power means more undecidable statements. Cantor shows enumeration can't capture the continuum. Both are about the cost of representation exceeding the capacity of any single system.
- **In engineering:** Shannon's limit is per-channel. MIMO doesn't break it — it multiplies channels at the cost of physical infrastructure.
- **In chaos theory:** Prediction precision and prediction horizon trade off exponentially. Better measurements buy diminishing returns in forecast length.

The question: **is there a single conserved quantity underlying all of these?** Montañez's conservation of information captures the search/learning cases. But the physics cases (Planck, chaos) involve different currencies (time, sensors, precision). The economics case involves institutional process. The math cases involve expressive power.

---

## Where Montañez's Talk Could Be Stronger

### The Gödel Connection

The talk uses Gödel to argue: syntax ≠ semantics → LLMs are trapped in syntax → AI can't reason.

This overreaches. Gödel shows that any formal system capable of arithmetic has unprovable truths. But:
1. Humans face the same limitation — we can't prove the Gödel sentence without stepping outside the system either.
2. LLMs fail at reasoning for engineering reasons (tokenization, pattern matching, statistical shortcuts), not because of incompleteness.
3. Natural deduction is sound and complete for first-order logic — lumping it with LLMs as equivalent "syntactic systems" obscures a massive difference.

A cleaner formulation: Gödel shows that **no single formal system is complete** — but this doesn't mean formal systems are useless, just that they have edges. The conservation of information theorem is actually the stronger tool here because it's directly about the cost of search/learning, not about the limits of provability.

### Model Collapse → Grounding

The talk presents model collapse as evidence that AI text is inferior to human text. This is true but the explanation could go deeper: humans produce text grounded in contact with reality (embodied experience, sensory feedback, causal interaction with the world). AI produces text grounded in text about reality. Training on AI text is like making photocopies of photocopies — each generation loses detail because there's no fresh contact with the source.

The conserved quantity here might be **grounding** — contact with reality that injects fresh information into the system. Human text has it. AI text doesn't. Model collapse is what happens when you cut off the source of fresh information.

---

## The Open Question

Is "conservation of complexity" a single principle, or is it a family resemblance across different domains that happen to rhyme?

**If it's a single principle:** There should be a formalization that captures all the cases — information theory, physics, economics, mathematics — under one framework. Montañez's conservation of information is the best candidate but currently only covers search/learning.

**If it's a family resemblance:** The pattern is still useful as a heuristic — when someone claims to have gotten something for nothing (broken Shannon, solved P=NP, replaced markets with AI, escaped Gödel), check where the cost moved. It's always somewhere.

**The Vault's working position:** It's probably a single principle that we don't yet have the formalism to express. The pattern is too consistent across too many domains to be coincidence. But asserting this without the formalism would be the same overreach we critique in others. So: watch the pattern, collect the cases, wait for the math.

---

## For Montañez Specifically

Your conservation of information work is formalizing one face of a pattern that appears across physics, economics, mathematics, and philosophy. The cases collected here may be useful as:

1. **Additional domains** where the conservation pattern manifests (Planck measurement, Mises calculation, chaos theory) beyond the search/learning cases you've formalized.
2. **A caution about the Gödel connection** — the incompleteness theorem doesn't do the work your talk needs it to. The conservation of information theorem is actually your stronger tool. Gödel is about provability limits; your work is about information cost. They rhyme but they're not the same.
3. **A framing suggestion** — "computational work is conserved across transformations" is more accessible and more defensible than the Gödel→syntax→semantics chain, and it connects directly to Shannon (which your audience already accepts).

The model collapse evidence combined with the grounding problem is your strongest empirical case. The conservation theorem is your strongest theoretical case. Gödel is a distraction that invites technical objections and obscures the more direct argument.

## Tags
conservation-of-information, computational-irreducibility, AI, godel, shannon, mises, montanez
