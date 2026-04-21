---
status: complete — video analysis + vault position
created: 2026-03-11
---
# Newcomb's Paradox — Pre-commitment, Decision Theory, and Agent Type
> Two boxes, one choice, and the question that splits smart people 50/50. The answer reveals how you think about rationality, free will, and what kind of agent you are.

**Source:** [This Paradox Splits Smart People 50/50](https://www.youtube.com/watch?v=Ol18JoeXlVI) — Veritasium (Derek Muller)
**Transcript:** [newcomb-paradox-transcript.txt](../../../raw/videos/newcomb-paradox-transcript.txt)
**Links:** [Measurement, Causality, and Free Will](../metaphysics/measurement-causality.md), [The Gödel Governance Problem](./the-godel-governance-problem.md), [Gaming — Game Theory](../../gaming/README.md), [The Nash Bargaining Problem](../../gaming/nash-bargaining-problem.md), [The Multiplayer Coalition Problem](../../gaming/multiplayer-coalition-problem.md), [Morality](../morality/README.md), [Performative Grounding](../morality/performative-grounding-lineage.md), [The SAVE Act and the Suffrage Question](../../debates/save-act-suffrage-hoppian.md), [Legal Theory](../morality/legal-theory/README.md), [D&D Spell Damage Model](../../gaming/dnd-spell-damage-model.md)

## The Setup

You enter a room with two boxes:
- **Box A** (transparent): $1,000 — always there
- **Box B** (mystery): $0 or $1,000,000

A supercomputer with a near-perfect track record (thousands of correct predictions) made a prediction *before you entered*:
- If it predicted you'd take **only Box B** → it put **$1,000,000** in Box B
- If it predicted you'd take **both boxes** → it put **$0** in Box B

The boxes are already set. The prediction is already made. What do you do?

## The Two Camps

### One-Boxing (Evidential Decision Theory)

Your choice is *evidence* about what the computer predicted. If C = probability the computer is correct:

```
EU(one-box) = $1,000,000 × C
EU(two-box) = $1,000 × C + $1,001,000 × (1 - C)
```

Setting equal and solving: the breakeven is C = 50.05%. If the computer is better than a coin flip — and it has thousands of correct predictions — one-boxing wins.

The one-box explainer in the video lays out this math before naming EDT. Good pedagogy: let the math commit the audience before they can dismiss it as "some philosophy thing."

### Two-Boxing (Causal Decision Theory)

Your choice *can't change the past*. Whatever is in Box B is already there. For any fixed probability P that the computer predicted one-boxing:

```
EU(one-box) = $1,000,000 × P
EU(two-box) = $1,000 + $1,000,000 × P
```

Two-boxing always gets you $1,000 more. This is **strategic dominance** — the dominant strategy regardless of the computer's prediction.

### The Split

A 2016 survey: 53.5% one-boxers, 46.5% two-boxers. As Nozick wrote: "To almost everyone, it is perfectly clear and obvious what should be done. The difficulty is that these people seem to divide almost evenly on the problem."

## What the Video Covers

### Free Will
If a perfect predictor exists, is choice real? The philosopher in the video answers: "Whether we do or don't have free will, you have to live as though it exists." Derek suggests his one-boxing comes from a sense that free will may not exist.

### Rationality and "Why Ain'cha Rich?"
The two-boxer's defense: "I acted rationally." The one-boxer's response: "If you're so smart, why ain'cha rich?" The one-boxers consistently walk out with $1,000,000. The two-boxers consistently walk out with $1,000.

Some two-boxers respond that the game is "rigged." Derek calls this a cop-out: Newcomb's reveals that to get the best outcome, you must sometimes act "irrationally" by CDT's own lights.

### The Prisoner's Dilemma Connection
In a one-shot PD, defecting dominates. But in an iterated PD, cooperation wins. Derek draws the parallel: a rational *person* might defect, but a rational *society* is full of cooperators. What's rational for the individual destroys the collective.

### Pre-commitment as Resolution
The narrator (a two-boxer) lists three conditions that would flip him:
1. If his choice could **change the past**
2. If there were **multiple trials**
3. If he could **pre-commit**

The video's key insight: **the pre-negotiation already happened.** The computer's track record across thousands of trials *is* the iterated game. The prediction mechanism *is* the observation of your agent-type. Condition 3 (and arguably condition 2) is already met — the two-boxer just doesn't recognize it.

The resolution: the question isn't "what do you choose in the moment?" but "what kind of agent would you wire yourself to be, if you could choose your own wiring before knowing about the problem?" Answer: a one-boxer. And since you've already wired yourself through a lifetime of decisions and commitments, you're already committed.

### MAD and the Chicken Game
Real-world pre-commitment with lethal stakes:
- **Mutually Assured Destruction:** Pre-commit to retaliate so the attack never comes. But if the attack *does* come, retaliating is irrational (everyone dies). The commitment works precisely because you can't back out.
- **Chicken:** Throw the steering wheel out the window. Now the other driver *must* swerve. (Dr. Strangelove's doomsday device is the nuclear version.)
- The failure mode: pre-commitment only works if everyone knows about it. The whole point of Dr. Strangelove is that the Russians forgot to announce the device.

## Vault Position: One-Box

The vault is firmly in the one-box camp. Not because of EDT specifically, but because the vault's entire framework is built on pre-commitment:

### Performative Grounding IS One-Boxing

[Performative grounding](../morality/performative-grounding-lineage.md) says: the act of questioning presupposes the framework that makes questioning possible. You can't argue against rationality without using rationality. You can't argue against one-boxing without *being* the kind of agent the computer predicts will two-box.

The structure is the same: your agent-type is revealed by your actions, including the action of deliberating. The computer doesn't need to read your mind — it just needs to predict what kind of deliberator you are. And the kind of deliberator who reasons "my choice can't change the past, so I should two-box" is exactly the kind of deliberator who walks out with $1,000.

### Constitutional Friction IS Pre-commitment

The vault's answer to the [suffrage question](../../debates/save-act-suffrage-hoppian.md) — restrict scope, not the vote — is a Newcomb-style pre-commitment. You bind the system *now* (constitutional constraints) so that future majorities can't defect (regulatory capture, GDP ratchet). The constitution is the steering wheel thrown out the window.

And the failure mode is the same as MAD: if the constraint actually gets tested (constitutional crisis), honoring it might look irrational in the moment. But the pre-commitment is what prevents the crisis from arising in the first place. The 5% → 40% GDP ratchet is what happens when a society two-boxes — each individual vote to expand scope is "rational" by CDT, but the cumulative result is everyone poorer.

### The Iterated PD Insight Applied to Single Games

The deepest connection: the video shows that pre-commitment turns a one-shot game into an effectively iterated game. If you're the *type of person* who cooperates, and the other player can observe your type (as the supercomputer does), then cooperation pays even in a single round.

This is exactly how the vault's moral framework works. Morality isn't about individual utility calculations — it's about agent-type. The person who *is* honest, cooperative, and commitment-honoring outperforms the person who defects on every individual calculation. Not because of magical thinking, but because agent-type is observable and other agents (and supercomputers) respond to it.

### Free Will: Pragmatically Inert

The vault's position on free will from [measurement-causality](../metaphysics/measurement-causality.md): the metaphysical question is pragmatically inert. You experience deliberation, you experience choice, consequences track your actions. That's sufficient to ground morality, game theory, and governance without resolving a 2,500-year-old debate.

The video's philosopher says the same thing: "you have to live as though it exists." But the vault's version is stronger — it doesn't take a metaphysical position *at all*. The compatibilist says "free will is compatible with determinism." The vault says: whatever the underlying reality, the cognitive layer generates structured, goal-directed, computationally irreducible outputs. Call it what you want. It grounds responsibility.

The supercomputer in Newcomb's paradox doesn't exist in reality, so "what would a perfect predictor imply about determinism?" is an absurd hypothetical generating absurd results. The *interesting* question is what the paradox reveals about the answerer — which is a question about agent-type, not metaphysics.

### The Euthyphro Parallel

The MAD section has a subtle structural echo of the [Euthyphro dilemma](../morality/README.md):

"Do you want a leader who will *always* push the button (credible but insane) or one who will *think about it* (rational but non-credible)?"

Compare: "Is an action good because God commands it, or does God command it because it's good?"

- Horn 1 (obedience / always push): the commitment works as deterrence but fails as morality. You've replaced judgment with compliance.
- Horn 2 (deliberation / think about it): morality is preserved but the pre-commitment collapses. You're back to CDT — "I'll decide in the moment."

The resolution in both cases is the same: the pre-commitment must be *internalized*, not externally enforced. You don't one-box because a rule says to. You one-box because you *are* the kind of agent who honors commitments. The doomsday device fails because it's external. Character doesn't.

## Open Questions

1. **Does the pre-commitment framework survive adversarial selection?** The supercomputer is benevolent — it rewards one-boxers. Real-world predictors (markets, opponents, institutions) may exploit predictability. When does being a readable agent-type become a vulnerability?

2. **The Kavka toxin puzzle.** You're offered $1M to *intend* to drink a mildly unpleasant (but harmless) toxin tomorrow. You don't have to drink it — you just have to genuinely intend to tonight. Can you form a genuine intention you plan to abandon? This tests whether pre-commitment is a real psychological phenomenon or just a decision-theoretic trick.

3. **Newcomb's and the Gödel governance problem.** A constitution is a pre-commitment device. But [Gödel showed](./the-godel-governance-problem.md) that a constitution can contain the seeds of its own legal overthrow. Is this the governance equivalent of the two-boxer's "your choice can't change the past"? The amendment is already in the constitution; your commitment not to use it doesn't change that.

4. **Correlation vs. causation in decision-making.** EDT says correlations matter for decisions. CDT says only causes matter. The vault's [stance-dependence](../../debates/wilson-objectivism-stance-dependence.md) work says relational facts are real. Does that commit the vault to EDT? Or is the one-boxing position compatible with a modified CDT that recognizes agent-type as causal?

## Tags
[philosophy](../../../tags/philosophy.md), [game-theory](../../../tags/game-theory.md), [free-will](../../../tags/free-will.md), [logic](../../../tags/logic.md)
