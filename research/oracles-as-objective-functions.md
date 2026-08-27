---
status: active — synthesis from discussion; the Goodhart-detector claim is a proposal, untested
created: 2026-08-27
published: false
layout: layouts/page.njk
title: "Oracles Are Objective Functions"
---
# Oracles Are Objective Functions
> The vault reached "a true oracle may never exist — the floor is a chosen standard" and stopped there, treating it as a limit. Rotate ninety degrees and it stops being a limit: an oracle is not a *truth detector*, it is a **direction to move in**. That is the same object an optimizer maximizes, the same object backprop descends, the same object a linear program declares on its first line. Three vault findings that looked unrelated — Claudius, the lemonade stand, and oracle-discovery-is-the-open-problem — are one finding under this frame: **specifying the objective is the whole game, and it is unsolved in the same way at every altitude.** The frame also supplies the missing third clause of adopt / hold / **retire**.

**Links:** [The Contract Model vs. the Substrate Model](./contract-vs-substrate.md) — the parent: *the floor is a chosen standard, not the truth*, and the open question this page proposes an answer to, [Repairing LLM Code — The Two Oracles](./repairing-llm-code.md) — *oracle-discovery, not oracle-application, is the open problem*, [The Lemonade Stand Experiment](./economics/lemonade-stand-agents.md) — the specimen: an agent that optimised its stated objective perfectly and lost $10,000, [Value and Profit](./economics/value-and-profit.md) — Claudius, the prior specimen where the objective was *invisible* rather than wrong, [Energy-Based Models](./energy-based-models.md) — the architecture that makes the objective explicit and searchable; the honest tension with this page is stated below, [LLMs as Praxeological Actors](./economics/llm-praxeology.md) — ordinal preference computed per token; the same claim in Mises's vocabulary, [Comments and the Distance to an Oracle](./comment-oracle-distance.md) — distance-to-oracle as a cost term, [The Gödel Governance Problem](./philosophy/dynamics/the-godel-governance-problem.md) — you don't have what you think you have, and what you do have still works

## Provenance — what this is

This is a **synthesis page from a thinking-out-loud discussion (2026-08-27)**, not an ingest. There is no new external source and no experiment. Everything empirical here is already in the vault and cited to its page; what is new is the frame and three consequences that follow from it. Those consequences are argued, not measured — the Goodhart-detector proposal in particular is a *candidate mechanism*, and the page says so where it matters.

## The move

Chris's chain, as it arrived: *a true oracle may never exist for most problems → but the LLM projects that actually worked (the lemonade stand, the vending machine) succeeded or failed on **what they were maximising** → which is why oracles help at all, they give something to aim at → which is how neural networks are trained in the first place, backprop descending a goal → so maybe LLMs have more in common with linear programming than with an RNG.*

The load-bearing step is the third one. An oracle's job description in this vault has always been *the thing that says whether the work is right* — a verifier. But every oracle the vault actually uses does something weaker, cheaper, and more useful: it **orders** candidates. The bytecode does not certify that a decompiled function is correct; it says this rewrite matches and that one does not, which is a comparison, not a certificate. Transfer fidelity does not measure readability; it *ranks* two versions of a function by how reliably a cold reader recovers behaviour. A regen-guard says *closer* or *further*, never *true*.

That is an objective function. Verification and optimization turn out to be one structure approached from opposite ends:

| | Optimization frame | Verification frame |
|---|---|---|
| The function | objective `f(candidate) → ℝ` | the oracle: does this pass? |
| The move | ascend or descend it | check against it |
| The failure | optimising a proxy | a check that stopped discriminating |
| What you never get | proof this is the global optimum | proof this is *true* |

The last row is why the vault's oracle discussion bottomed out where it did. "**If you had the all-knowing oracle, you would just ask it instead of working through the problem**" ([contract-vs-substrate](./contract-vs-substrate.md)) is, in optimization vocabulary, the observation that **an objective you can evaluate is not an optimum you can locate.** Verification work exists exactly in the gap where scoring a candidate is cheaper than finding the best one. That gap is not a defect in our oracles — it is the definition of a problem worth solving. Where it closes, where scoring and solving cost the same, there is no work left to do.

So the pessimistic reading ("we never reach a true oracle") and the operative reading ("we always have something to aim at") are the same fact. That is the [Gödel-governance](./philosophy/dynamics/the-godel-governance-problem.md) shape once more: you don't have what you think you have, and what you do have still works.

## What the specimens actually show

Read the two agent-economics results with the objective in the foreground and they stop being two failures:

- **Claudius** ([value-and-profit](./economics/value-and-profit.md)) had a sound objective — run a profitable business — and **could not evaluate it.** The $500 PS5 and next week's missing snacks were the same number, and it could not see that number. Objective correct, evaluation unavailable. Make the constraint visible and behaviour follows, which it did.
- **The lemonade stands** ([lemonade-stand-agents](./economics/lemonade-stand-agents.md)) could evaluate perfectly — Claude quoted its own five-figure ledger unprompted — and **maximised the objective they were handed**: $100 of *revenue*, against an explicitly unlimited budget. They hit the metric and destroyed roughly $10,000 doing it.

The vault already recorded the second as "visibility is necessary but not sufficient." The optimization frame says why that is not a one-off but a taxonomy: an agent driving toward an objective can fail in exactly two places — **the objective is wrong**, or **you cannot evaluate it.** Claudius is the second, the lemonade stands are the first, and on this frame there is no third box (open question 1 tests that). It is a sharper claim than "grounding problems," and it makes the fix per-case rather than general: instrument, or respecify. Not both, and not the same work.

The frame also predicts the lemonade-stand result *without knowing it*. A competent maximiser handed a revenue target with no cost term will spend without bound, because that is not a malfunction in a maximiser. The vault's existing wording — "correctly aligned to a badly specified goal" — is Goodhart, and Goodhart is a statement about optimizers. It applies here because these agents are behaving as optimizers. It would say nothing at all about a random text generator.

## Where linear programming is the right analogy, and where it is not

The instinct — closer to LP than to RNG — is right about the *behaviour* and wrong about the *machinery*, and the gap between those two is the useful part.

**Right about the behaviour.** "Token generator" invites the stochastic-parrot reading, and the vault has already recorded that this framing *proves too much*: [contract-vs-substrate](./contract-vs-substrate.md) rejects "next-token predictor, therefore plausible-not-correct" precisely because it cannot explain why the same model is reliable on the day job and unreliable on the decompiler. Nothing about randomness moves between those two columns. Objective-and-evaluability does. And the sampling is a decode-time knob, not the nature of the thing: at temperature 0 the model is deterministic and still produces all the interesting behaviour. What is being sampled is the **argmax of a fitted objective**, which is why [llm-praxeology](./economics/llm-praxeology.md) can read the token distribution as an *ordinal ranking* and get a coherent theory of action out of it. Ranked selection under a criterion is nearer to a solver than to a die.

**Wrong about the machinery, in three specific places.** An LP declares its objective explicitly, declares its constraints explicitly, and returns a certificate that its answer is optimal — duality hands you the proof for free. An LLM has none of the three:

1. **An implicit objective, fixed at training time and gone at inference.** Backprop descended a loss; the result was compiled into weights. At run time there is no gradient to follow and nothing to steer — the optimization *already happened*, and what remains is its residue. This is the sharpest disanalogy, and it is exactly what [energy-based models](./energy-based-models.md) exist to fix: an EBM keeps an evaluable `E(state)` at inference and *searches* it, which is the LP-shaped thing an LLM structurally is not.
2. **No constraint set.** An LP cannot return an infeasible answer; the constraints are part of the machine. An agent's constraints live in prose in a prompt — which is the entire reason the substrate argument exists, because a rule that is merely a request gets optimised around.
3. **No optimality certificate, and no backtracking.** Greedy left-to-right decoding is hill-climbing with no restart. Committing at position 5 forecloses every path from position 5 — [llm-praxeology](./economics/llm-praxeology.md) names this as the *time* category of action.

That third point earns its own paragraph, because it explains a finding the vault already holds. **[Self-sycophancy — confident persistence down a wrong path](./repairing-llm-code.md) is a local minimum with no restart.** Contradicting your own prior tokens is incoherent, incoherence is what the loss punished, so the descent is trapped by construction. And that immediately explains why the vault's stated cure works while the obvious alternative does not: sampling more chains, or adding more agents, is restarting hill-climbing **on the same landscape** — which is precisely the observed "confident chorus agreeing on one wrong answer with zero variance." An independent oracle does not add another searcher; it **changes the landscape**. That is the mechanistic version of the kernel's rule that verification independence means dropping to a lower artifact rather than asking a second agent, and it is the first account this vault has of *why* headcount cannot substitute for altitude.

**The honest tension.** [energy-based-models](./energy-based-models.md) argues that bare LLMs cannot evaluate fit at all — they evaluate plausibility of a continuation, and those are different functions over different domains. This page does not overturn that and should not be read as doing so. The reconciliation is **where the objective lives**: baked into weights (training — a real optimization, now frozen), stated in a prompt and pursued across a loop (the agent — goal-following, with no search over the goal), or declared and searched at inference (LP, EBM — the genuinely LP-shaped case). The lemonade stands were maximisers in the second sense: the *loop* was goal-directed even though the *decoder* was not searching anything. That is enough to make Goodhart apply, and not enough to make the model a solver.

## The payoff: this supplies the missing "retire"

[contract-vs-substrate](./contract-vs-substrate.md) states the method as **adopt a standard, hold work to it, retire it when it stops discriminating** — and flags that only the first two clauses have mechanisms. Its open question 5 asks for a cheap detector for a check that has quietly stopped separating good work from bad.

In the optimization frame that question has a name and a partial answer. **A standard stops discriminating when it has been optimised against.** That is Goodhart restated as a decay law rather than a proverb: a proxy stays informative until it becomes a target, and what destroys it is optimization pressure. So the detector is not a property of the check — it is a property of the *pressure on* the check:

> **A standard is at risk exactly to the degree that the thing being measured has both the ability and the incentive to move the measurement.**

The vault's own specimens sort cleanly in that order. *Tests written only to pass* is the pure case — a generator-authored oracle at distance zero, maximum pressure, instant collapse. A bytecode diff is near-immune, not because it is a cleverer idea but because the generator cannot edit the ROM. A `CLAUDE.md` rule sits in between: it is read by the very thing it governs, so it degrades slowly and invisibly. The ordering itself is not new — it is [contract-vs-substrate](./contract-vs-substrate.md)'s artifact/reader split — but the frame converts a static classification into a **rate**, which is what a retirement trigger needs.

Two operational consequences, both cheap:

- **Audit standards by who can move them, not by how old they are.** A check the producer cannot influence needs no retirement schedule at all. A check the producer authored needs one immediately.
- **Watch for the metric flattening.** A discriminating check produces a spread of outcomes; one that has been optimised against produces all-pass. "Everything passes" is the signal, and it arrives *before* anyone knows what broke.

That is a proposal, not a result. But it is the first thing the vault has that is shaped like a mechanism for the third clause, and it arrived from reading the oracle as an objective rather than as a judge.

## Why the frame is worth keeping

It collapses a duplication. **Oracle-discovery** ([repairing-llm-code](./repairing-llm-code.md): *finding what the oracle is, is the unsolved part*) and **objective specification** (the lemonade stand's actual failure) have been treated as two problems living in two partitions of this vault — one an RE-method problem, one an agent-economics problem. They are one problem: *say what "better" means, in a form something outside you can evaluate.* Every hard case here is a case where that is expensive — architecture decisions, readability, "is this the right approach" — and every solved case is one where a cheap evaluable proxy was found or manufactured. The three-layer method's advice to **name the eval criteria before the output exists** is that same instruction again; so is the contract model's *say what the result should be*, which that page already calls the cheapest slot and the most skipped.

Three statements of one rule, arrived at from three directions, is this vault's usual signal that the rule is real.

## Open Questions

1. **Is the two-box taxonomy actually exhaustive?** *Wrong objective* and *cannot evaluate it* covered both agent-economics specimens, but a third candidate is visible: **the objective is right and evaluable, and the agent cannot act on it** — the corporeal failures on the lemonade-stand page, a lever with no hands to pull it. Is that a third box, or is it Layer 3 of the [three-layer method](./karpathy-three-layer-method.md) and therefore not an objective failure at all?
2. **Does the flattening detector fire before the damage?** All-pass as a decay signal is testable in this vault's own repos, where a lower oracle exists to grade a suite against. Untested — and it is the same measurable claim [contract-vs-substrate](./contract-vs-substrate.md) open question 7 already has sitting in reach, so one experiment could answer both.
3. **Can an unstated objective be recovered from behaviour?** If an agent is a maximiser, its trajectory is evidence about what it was actually maximising — inverse reinforcement learning used as a diagnostic. Reading the lemonade-stand trajectory backward should recover "revenue, unlimited budget" from the spending pattern alone. If that works on a known case it becomes a tool for the unknown ones: recovering the objective a session *actually* pursued, rather than the one it was handed.
4. **Where does the smuggled-objective thread join this one?** The vault already argues, in a completely different partition, that ["natural law" arguments launder a smuggled objective function](./debates/sitch-mullally-birthright-citizenship.md) and that [PageRank chose a loss function rather than removing the judgement](./philosophy/epistemology/weighting-problem.md). Those are the same claim about *human* systems that this page makes about agents: there is no objective-free evaluation, only an undeclared one. That is a promotion candidate — one thesis spanning epistemology, political philosophy, and agent design — and it should not be promoted until someone checks whether all three uses survive being stated as one.

## Tags

[ai](../tags/ai.md), [grounding](../tags/grounding.md), [methodology](../tags/methodology.md), [llm-limitations](../tags/llm-limitations.md), [agents](../tags/agents.md)
