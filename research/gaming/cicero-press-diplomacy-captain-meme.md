---
status: active
created: 2026-04-23
published: true
layout: layouts/page.njk
title: "CaptainMeme vs. 6 Cicero — The Human/AI Split in Press Diplomacy"
---
# CaptainMeme vs. 6 Cicero — The Human/AI Split in Press Diplomacy
> An expert human diplomacy player plays full-press blitz Diplomacy against six Cicero AIs and narrates the game. The surface observation is that Cicero's press is indistinguishable from human press; the deeper observation is that the bots' *strategic behavior* still reveals the planner underneath. CaptainMeme repeatedly names specific human/AI behavioral differences — most notably, the absence of grudge motivation — and uses them as exploitation targets. What he documents is the planner-LM composite architecture showing through even when the language layer is fully operational.

**Sources:**
- DiploStrats, "Expert Diplomacy Player vs CICERO AI" (narrator Marcus Zylstra / CaptainMeme) — [YouTube](https://www.youtube.com/watch?v=u5192bvUS7k) — [Transcript](../../raw/videos/captain-meme-vs-cicero-press.txt)
- Cicero paper: [Bakhtin et al., Science 2022](https://www.science.org/doi/10.1126/science.ade9097)

**Links:** [Planner-LM Composites](../planner-lm-composites.md), [Gunboat Diplomacy and Diplodocus](./gunboat-diplomacy-diplodocus.md), [Diplomacy: 7 AI Models](./diplomacy-ai-analysis.md), [The Multiplayer Coalition Problem](./multiplayer-coalition-problem.md), [The Nash Bargaining Problem](./nash-bargaining-problem.md), [LLM Agents Across Strategic Games](./llm-agents-across-games.md), [LLMs as Praxeological Actors](../economics/llm-praxeology.md)

---

## The game

Blitz press Diplomacy. CaptainMeme (top tournament player, worked with Meta on Cicero for six months prior) as Russia, versus six Cicero AIs controlling the other powers. Full natural-language negotiation is permitted; the AIs generate and respond to press in real time. The game ends with CaptainMeme sharing a joint board top at the scoring threshold.

CaptainMeme's own framing at the end: *"If you'd asked me a couple of months ago, before I started working on Cicero, whether an AI would ever be competitive in press diplomacy, I would have said probably not... the fact that it works in an actual language setting is absolutely mind-blowing to me."* The video is an expert player documenting that he was wrong about what was possible.

## The human/AI split — CaptainMeme's observations

Throughout the game CaptainMeme flags specific moments where he treats the AIs differently from how he'd treat human opponents, and is explicit about why. The observations cluster cleanly.

### Where Cicero matches humans (raising the interpretive bar)

- **Elaborate press in early game.** In top-level human play, depth and specificity of early-game press is how players establish trust. Cicero matches this — its opening press is detailed, strategically on-topic, and proposes concrete plans rather than vague coordination. "In a game where one person is doing that and the other isn't, I'd be tempted to go full aggressive against the one who isn't... however in this game of course all of these are the same Cicero AI so they're all being that elaborate, and this is the case in a lot of expert games — you don't really know who you want to go with right off the bat because everyone's press is really good."
- **Response to betrayal.** When CaptainMeme stabs Austria, Austria retaliates. CaptainMeme explicitly notes: *"the same response a human would make in that situation."*
- **Strategic commitment to positions.** The bots don't randomly switch strategies; they pursue coherent multi-turn plans.

Implication: *the LM component of Cicero clears the threshold at which language alone can't be used to identify the AI.* This is the press equivalent of what Diplodocus achieves in Gunboat through move-level imitation (key 5 from the [Gunboat page](./gunboat-diplomacy-diplodocus.md#diplostratss-five-keys-of-gunboat-ai)).

### Where Cicero differs from humans (strategically material)

The differences are in *strategic behavior*, not in press quality. They reveal the planner's architecture showing through.

- **No grudge carry-forward.** The sharpest observation, surfaced twice in the video. CaptainMeme lies to Germany about Denmark to buy a turn of positional flexibility: *"it costs a bit of Social Capital — basically says Germany is going to trust me less in future — but that's less of an issue with a bot than it is with a human because the bot is going to act in their best interest in the future most likely, whereas a human might go 'screw you, you know, we're done.'"*
- **Willing to reconcile after hostility.** A human who's been actively "suiciding" their units against you tends to stay committed out of sunk cost and revenge motivation. Cicero accepts a fresh cooperative deal when the math supports it: *"a human player in this position... would usually stick to [the hostility]. Whereas the bot is"* open to pivot.
- **Forward-looking optimization dominates.** The bot reasons from current state toward best future outcome without a penalty term for "this player wronged me previously." Past-injury doesn't carry into the current value calculation.

### Exploits CaptainMeme tried (and whether they worked)

- **Pleading ignorance.** CaptainMeme tries to soften Austria's retaliation with "I didn't know Italy was going to support me into Romania" — a common human social move that invites forgiveness. **Failed.** Bot doesn't accept it. *"The bot does not buy it at all — they're just like 'no, screw you, I'm gonna attack you,' which is the same response a human would make."* A forward-looking planner models *positions*, not *intentions*; current state determines retaliation, not the counterfactual about what the opponent "meant."
- **Lying about future agreements.** CaptainMeme tells Germany "you can have Denmark back in the fall" while planning to hold it. **Worked the first time; failed the second time.** The bot updated its trust model within the game — *"maybe it's because I did it before and they were like 'okay, that player is not trustworthy, let's just make sure I get it this time.'"*
- **Forward-interest appeals.** Framing proposals as "here's why working with me benefits you going forward" rather than "you owe me for past cooperation." **Generally worked.** The planner responds to forward-value arguments where a human might reject them out of principle.

## What the split reveals about the planner-LM composite

The "no grudge" pattern is **diagnostic of the planner-LM architecture** showing through behavior even when the language layer is fully active.

- **Humans** blend forward-looking optimization with backward-looking emotional state (grudges, revenge, social scorekeeping). The blend is often strategically suboptimal but psychologically load-bearing.
- **Cicero's planner** is forward-looking pure. It computes best moves from current state, weighted by predicted opponent behavior, without a penalty term for past injuries. This produces behavior that is recognizably *cleaner* than a human's — and exploitably so in the specific ways CaptainMeme documents.
- **The LM widens the press channel without changing the planner's signature.** Cicero's language is indistinguishable from humans on surface; its strategic decisions are recognizably planner-shaped. The architecture's separation shows through because the two components have different logics — the LM narrates, the planner decides, and the planner's forward-looking-pure logic doesn't get translated into grudge behavior by the LM.

This is architectural introspection from the outside. CaptainMeme didn't look at Cicero's code; he observed behavior and described what was different. What he described maps precisely onto "planner computes optimum, LM renders the choice." The pleading-ignorance failure is especially clean: a planner doesn't process intent-based appeals because positions don't care about intent.

## The N≥3 self-balancing observation

The [multiplayer coalition problem](./multiplayer-coalition-problem.md) predicts that in games with three or more players, the rest of the table should converge on opposing whoever is currently leading. This is a stable-strategy prediction: every remaining player's best move is to prevent the leader from winning, so they coordinate (implicitly or explicitly) against the leader.

In human play this often fails. Grudges interfere. A player who was recently wronged targets the wronger rather than the current leader. Vengeance pulls the coalition off optimum, and the leader sometimes coasts to victory while the other players are busy punishing each other.

**Forward-looking-pure planners don't have the grudge term.** Each Cicero independently computes "oppose the current leader" as its best move and the bots converge on the target without needing explicit coordination. The self-balancing dynamic executes cleanly in a way it usually doesn't with humans. CaptainMeme's game shows this: when he pulled ahead, the other bots (all forward-looking) started cooperating against him fluidly, without the grudge-induced deviations that would mess up the coalition in a human game.

**Scope criterion — where self-balancing holds.** Self-balancing requires that opposing the leader be *feasible and effective*. The game structure must reward coordinated resistance. In Diplomacy, Monopoly, and Catan it does — negotiation phases allow coordination, and the leader needs others' cooperation to extract further resources. In poker it doesn't — chips are the only resource, the leader has them, coordination isn't possible, and GTO rewards targeting the weakest player (they have less room to absorb losses). So the corollary is:

**Self-balancing holds when the game structure rewards coordinated resistance against the leader; it fails when the structure rewards targeting weakness instead.**

### Design implication

If N≥3 self-balancing is desirable in some multi-agent system (governance, market, agent team), forward-looking-pure agents will execute it more cleanly than human agents. The "no grudge" feature is a **genuine AI-design advantage for coordination problems that depend on equilibrium self-correction.**

This is not a small claim. The [Gödel governance problem](../philosophy/dynamics/the-godel-governance-problem.md) is partly about why concentration-of-power dynamics resist correction; if composite AIs execute the "oppose the leader" logic cleanly where humans don't, they might solve coordination problems human institutions struggle with. The catch: someone has to define who "the leader" is, and what "opposing" means, and those definitions are themselves adversarial choices. The advantage only holds inside a well-scoped coordination game.

## Complement to Diplodocus

The two Meta AI cases bracket the architecture cleanly:

| | Diplodocus (Gunboat) | Cicero (press) |
|---|---|---|
| Language layer | None | Full LM |
| Communication channel | Moves only (costly signals) | Moves + natural language |
| Strategic capability | Full — wins against experts | Full — ties expert for board top |
| What it proves | Strategic work lives in planner (removing LM doesn't break it) | Planner signature shows through even with LM active (LM doesn't mask forward-looking-pure behavior) |

Having both pins the architectural conclusion. If only Cicero existed, you could argue the LM was doing strategic work. If only Diplodocus existed, you could argue the LM would change things. Together: the strategic work is in the planner, the LM is a bandwidth amplifier, and the planner's signature is visible in behavior regardless of whether the LM is present.

## Connection to the cross-game LLM study

The [LLM Agents Across Strategic Games](./llm-agents-across-games.md) study documents three structural failures of bare LLMs: action bias, no mechanical model, rhetorical contagion. Each of those is exactly what you'd expect from an LM without a planner — language output without state simulation, plan maintenance, or verification against ground truth.

Cicero inverts each failure:

| LLM failure (bare LM) | Cicero counterpart (LM + planner) |
|---|---|
| Action bias — can't no-op | Planner permits hold as first-class option; bot doesn't over-trade or over-commit |
| No mechanical model — wants to build without roads, takes points reactively | Planner maintains full game state; moves are legal by construction |
| Rhetorical contagion — accepts framings without verification | Planner verifies claims against state; forward-interest arguments land, intent-appeals don't |

The bare-LLM failures are the specific symptoms of missing a planner. Composite systems don't exhibit them because the planner supplies what the LM alone can't. This is the clean inverse demonstration that the [planner-LM composites page](../planner-lm-composites.md) argues for.

## Open questions

- **Does the no-grudge advantage extend beyond game play?** If composite AIs execute self-balancing better than humans in games, is the same true in other coordination problems — market-making, governance, agent teams in business? The Gödel governance problem implies this would be significant if true.
- **Can humans train themselves into forward-looking-pure behavior?** Some of the vault's existing work (Stoicism, Buddhist detachment, rational-choice training) is effectively about reducing the grudge term. How much of the "AI advantage" is actually just "discipline advantage" that disciplined humans can replicate?
- **What are the edge cases where the no-grudge signature becomes a liability?** Grudge-based retaliation is costly for humans but *also* a commitment device — it makes threats credible. A forward-looking-pure agent can't make credible "if you cross me I'll ruin you even if it costs me" threats, which might weaken its negotiation position in some contexts. Is there a cost to pure forward-looking-ness that Cicero doesn't encounter in Diplomacy but would in other settings?
- **The exploit surface that survives.** CaptainMeme found two exploits that still worked (lying about future agreements once; forward-interest appeals). Are those stable exploits against planner-LM composites, or artifacts of this specific Cicero version? A benchmark for composite-AI strategic play would surface this.
- **Multi-AI coordination without explicit coordination.** CaptainMeme's game shows six Ciceros independently converging on opposing the leader without signaling coordination. Is this equivalent to what swarm-intelligence or stigmergy achieves in biology? Is there a general theory of "coordination by shared logic without coordination by explicit signal"?

## Tags

[game-ai](../../tags/game-ai.md), [games](../../tags/games.md), [ai](../../tags/ai.md), [agents](../../tags/agents.md), [game-theory](../../tags/game-theory.md)
