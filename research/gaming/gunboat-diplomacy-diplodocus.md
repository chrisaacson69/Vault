---
status: active
created: 2026-04-23
published: true
layout: layouts/page.njk
title: "Gunboat Diplomacy and Diplodocus — The Planner Without the Mouth"
---
# Gunboat Diplomacy and Diplodocus — The Planner Without the Mouth
> Meta AI's Diplodocus plays Gunboat Diplomacy — the variant with no text communication — and beat every human in Meta's 2022 Speedboat Tournament. Because Gunboat strips the language layer entirely, Diplodocus's win is the cleanest available demonstration that strategic and social reasoning can live fully in a planner with no language model at all. Moves become costly signals; the planner learns the signaling grammar; the AI coordinates, allies, and stabs without saying a word.

**Source:** DiploStrats, "Diplodocus — The AI That Conquered Gunboat Diplomacy" — [YouTube](https://www.youtube.com/watch?v=AWQFhYSD7h4) — [Transcript](../../raw/videos/diplostrats-diplodocus-gunboat.txt). Paper: [arXiv 2210.05492](https://arxiv.org/abs/2210.05492) (Bakhtin et al., Meta AI, 2022).

**Links:** [Planner-LM Composites](../planner-lm-composites.md) (Diplodocus is the sharpest thesis-confirming case), [CaptainMeme vs. 6 Cicero (Press Diplomacy)](./cicero-press-diplomacy-captain-meme.md) (the LM-on companion case — same architecture with full language layer), [Diplomacy: 7 AI Models](./diplomacy-ai-analysis.md) (LLMs at standard Diplomacy; complementary case), [LLM Agents Across Strategic Games](./llm-agents-across-games.md), [The Multiplayer Coalition Problem](./multiplayer-coalition-problem.md), [The Nash Bargaining Problem](./nash-bargaining-problem.md), [LLM Grounding Problem](../llm-grounding-problem.md)

---

## What Gunboat Diplomacy is

Gunboat Diplomacy is standard Diplomacy with one rule change: **players cannot talk to each other.** No chat, no private messages, no public announcements. The game mechanics are otherwise identical — seven players, the same map, the same supply centers, the same unit types, the same simultaneous-move resolution.

The surface reading is that removing talk removes the heart of the game. The actual effect is the opposite — it reveals that most of the game's strategic content was already being carried by the move structure, and language was an amplifier rather than the substrate.

Good Gunboat players use orders and moves to communicate:

- **Pressure as intent signal.** Moving against a neighbor's home centers (e.g., England to the English Channel threatening Brest as France) signals attack intent clearly.
- **Support as alliance pitch.** Supporting another player's move into a contested space says "I want to work with you on this front." The support doesn't even have to succeed — its informational content survives even when the supported move doesn't happen.
- **Convoy/target/pattern.** Sending units toward a specific target signals where you want to operate; sending them away from a neighbor signals you don't intend to attack them this turn.
- **Build patterns.** What units you build where signals your long-horizon strategy — "two fleets after taking Trieste" tells Austria that Italy is locking into naval and can't credibly threaten Austrian homeland.
- **Retreat and disband choices.** Even non-move phases carry signal (see the Denmark disband below).

The signaling grammar is conventional but robust, and experienced Gunboat players converge on it. A competent Gunboat agent has to read it, emit into it, and adapt when opponents use it unconventionally.

## Meta's Speedboat Tournament and Diplodocus

In early 2022, Meta AI ran a Gunboat tournament pitting human Diplomacy players against several AI variants — Dora, BR-bots, and two variants of a new AI called **Diplodocus** (High and Low). DiploStrats (the video's creator, an expert tournament player) finished as the highest-scoring *human*. He did not win.

**Final ELO standings (per Meta's paper):**
1. Diplodocus High
2. A human player
3. Diplodocus Low

DiploStrats estimates he was around fifth in this ranking. By tournament score, the two Diplodocus variants placed first and third with DiploStrats second; by ELO the ranking above held.

Dora and BR-bots were weaker — Dora in particular failed at a specific kind of human-legibility (it signaled alliance by supporting *into another player's home centers*, a move other Dora instances recognized but humans interpreted as either attack or surrender, and responded by destroying Dora). Diplodocus fixed this.

## DiploStrats's "Five Keys of Gunboat AI"

The video's organizing framework — a qualified expert naming what a Gunboat AI has to do:

1. **Tactics.** Solid one-versus-one positional play, approximately at the level of strong human players.
2. **Cooperation.** Coordinate moves with an aligned player — predict what they're doing, issue supports that are likely to match their actions, push fronts forward together.
3. **Signaling / persuasion.** Communicate intent through moves in a way human players will interpret correctly, and recognize when a signaling pitch is likely to be *accepted* versus wasted.
4. **Self-interest.** Know when to stab. An alliance that keeps the AI in second place going into the endgame is a mistake; the AI has to reassess continuously and switch sides when switching is optimal.
5. **Imitation.** Appear human. If the AI is identifiable — whether by excessive aggression (Diplodocus Low's failure), unusual signaling (Dora's failure), or any stable machine-distinct pattern — human players gang up on it and destroy it. Being superhuman is a tactical liability unless the AI also blends in.

Diplodocus Low hit keys 1-4 and failed key 5 (too stabby, too many fronts, identifiable). Diplodocus High hit all five. DiploStrats explicitly credits key 5 as the step he did not expect any AI to clear.

## The Denmark Disband — costly signaling in pure form

The single sharpest moment in the video, narrated in Game 117.

DiploStrats (playing England) is in alliance with Diplodocus (Germany). The alliance has frayed; DiploStrats has abandoned his home centers to contest Scandinavia, deliberately making France disproportionately strong to force Germany to choose sides. Germany attacks him, then has a retreat decision for a unit at Denmark.

Two retreat options are tactically advantageous:
- **Baltic Sea** — contest Denmark or Sweden; defend the home front
- **Heligoland Bight** — potential sneak attack into Denmark; defend Kiel

Diplodocus takes neither. It **disbands the unit**. Forgoes both retreats and plays a unit down.

DiploStrats reads this as follows: *the AI had no way to make its alliance intent clearer through available moves, so it spent a unit to send the signal.* The unit loss IS the signal. Nothing else about the retreat options made sense — no center was about to be recaptured, no build was coming to replace it. The disband was a deliberate costly act whose only function was communication.

This is Spence (1973) signaling theory in its purest game-theoretic form: **actions that cannot be cheaply faked reveal information that speech cannot.** Text can be lied about at zero cost. A disbanded unit cannot. The AI figured out that in a medium where no cheap-talk channel exists, the costly-signal channel is the only way to communicate — and used it at a precisely optimal moment.

DiploStrats: *"This was the move that shocked me... the AI deliberately took a drastic action in weakening itself specifically to convey its alliance intention to me, and in doing so successfully convinced me to side with it."*

## Why Gunboat is the sharpest test of the planner-LM composite thesis

The [Planner-LM Composites](../planner-lm-composites.md) thesis argues that strategic and social reasoning live in the planner, not the language model, and that bare LLMs don't meet the bar for agency because they lack the planner. Cicero (the standard-Diplomacy version) is evidence for this but partial — Cicero has both a planner and a language model, and you can argue about which component does the real work.

**Gunboat removes the language model entirely.** Diplodocus has no LM component. It communicates only through moves. And it won. That upgrades the thesis from "Cicero suggests" to "Gunboat demonstrates":

- Strategic capability (tactics, cooperation, signaling, self-interest) lives in the planner. The planner can do all of it.
- The language model's role is bandwidth multiplier, not source of competence. When language is available, the LM widens the communication channel; when it isn't, the planner still carries the strategic content through the move channel.
- Social reasoning — reading intent, forming and timing alliances, maintaining credibility, appearing human — is not linguistic per se. It's pattern recognition and signaling, and signaling can happen in any sufficiently expressive channel, not just language.

The imitation requirement (key 5) adds a subtle point: the planner has to model the *interpretive expectations of the opponents*. Diplodocus had to appear human to avoid being ganged up on. This is theory-of-mind operating at the planner layer without any language involvement. The planner isn't just computing optimal moves; it's computing moves that will be interpreted in a specific way by a specific kind of observer. That's a cognitive capability we usually associate with language-and-social-cognition being coupled. Gunboat shows they can be decoupled.

## Costly signaling vs. cheap talk — the analytical frame

Classical game theory distinguishes:
- **Cheap talk.** Communication with no resource commitment. Text in negotiation games. Can be lied about at zero cost; its informational content depends entirely on incentive alignment between speaker and listener.
- **Costly signaling.** Communication that commits resources. The cost is what makes the signal credible — if the signal were free, anyone could send it and the information content would collapse.

Diplomacy supports in standard play are already costly signals (units committed). Gunboat is the pure case — only costly signals exist, no cheap talk channel at all. The game becomes a signaling-only coordination problem, and the planner has to master the signaling grammar to win.

Three implications:

1. **Credibility is structural in costly-signal channels.** A player in standard Diplomacy can say "I promise to support you" and lie. In Gunboat, they can only *do* the support, and the doing is the promise. The credibility is guaranteed by the channel, not by the speaker's honesty.
2. **Cheap-talk channels carry the risk of degradation.** Once a cheap-talk channel exists, players must model each others' honesty; the channel's information content is a function of that honesty modeling. Removing the cheap channel removes the honesty-modeling burden and compresses communication into the act-as-signal form.
3. **LLM trading-game failures have a costly-signaling diagnosis.** The Catan LLM failures include "rhetorical contagion" — claims propagate through the language channel without verification. In a costly-signaling channel this wouldn't happen, because claims couldn't be cheaply uttered in the first place. The planner-LM composite architecture has to manage this: cheap-talk channels are useful but require verification against costly-signal reality. Bare LLMs don't do the verification; composites can.

## What remains open

This is one expert's analysis of a tournament played two years before the current moment, via two narrated games. The thesis this page argues for is strong but the evidence base could use more:

- **The paper** ([arXiv 2210.05492](https://arxiv.org/abs/2210.05492)) has the architectural details of Diplodocus — worth reading directly to see how the planner represents and selects costly signals mechanically. Not yet ingested into the vault; flag as follow-up.
- **More games.** DiploStrats played ~60 tournament games; this video narrates two. The "Battle for Humanity" series he references was abandoned before completion. A full game-by-game review would surface more structural patterns.
- **Direct Diplodocus vs. Cicero comparison.** Both exist; comparing their strategic profiles would help separate "what Gunboat forced out of the planner" from "what the LM adds to the full Diplomacy version."
- **Other costly-signaling-only games.** Does the same architectural decomposition work for negotiation variants of Catan without trade talk, or Monopoly without agreement chat? The vault's [Monopoly project](../../projects/monopoly/README.md) could test this directly.

## Connection to the vault's other threads

- [Planner-LM Composites](../planner-lm-composites.md) — the thesis this page upgrades to demonstrated
- [Nash Bargaining Problem](./nash-bargaining-problem.md) — cheap talk vs. costly signaling is the communication-channel axis missing from the current page; worth absorbing
- [Multiplayer Coalition Problem](./multiplayer-coalition-problem.md) — the alliance/betrayal dynamics this video documents are exactly the coalition formation/breaking the vault already models
- [LLM Grounding Problem](../llm-grounding-problem.md) — Gunboat forces reasoning outside the language channel entirely; the strongest available counter-case to the claim that LLMs can do strategic reasoning purely from text

## Tags

[game-ai](../../tags/game-ai.md), [games](../../tags/games.md), [ai](../../tags/ai.md), [agents](../../tags/agents.md), [game-theory](../../tags/game-theory.md)
