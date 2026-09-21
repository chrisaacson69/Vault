---
status: active
created: 2026-09-18
published: true
layout: layouts/page.njk
title: "Pluto on the Brood War Ladder — APM Beats Strategy, and Why the Gradient Went There"
---
# Pluto on the Brood War Ladder — APM Beats Strategy, and Why the Gradient Went There
> An RL-trained Brood War bot (**Pluto**), hacked onto the official Remastered ladder by a third party, reached effective #1 and beat a top-7 Protoss with a build every human heuristic calls unplayable: two-base marine/medic/**ghost lockdown**, ~6,000 APM, appalling macro. **The counter (psi-storm) didn't stop being correct — the assumption it rests on (finite reaction time) stopped holding.** The bot did not find a better strategy in the human-reachable region; it found a region humans *can't reach* and won from there, while being visibly bad at everything humans are good at. That is exactly what an uncapped RL reward should be expected to produce, and it is the AlphaStar argument replayed with the APM cap removed.

**Links:** [Cognitive vs. Motor Skills](../cognitive-vs-motor.md) (this is the motor axis swamping the cognitive one), [Oracles as Objective Functions](../oracles-as-objective-functions.md) (the reward orders candidates; it does not know *why* one ranks higher), [The Hollow Opponent](./hollow-opponent-perceived-depth.md) (depth that lives in an assumption rather than the opponent), [Capability Without Leverage](./capability-without-leverage.md) (a unit's value is conditional on being able to *use* it — ghosts as the limiting case), [democracy3-solver](../../projects/democracy3-solver/README.md) (the same "optimizer found a move humans overlook" ambiguity, in a policy network)

## The specimen

Source: Artosis, ["AI Bot Takes over the StarCraft Ladder…"](https://www.youtube.com/watch?v=1vsTqNwHquE) (ArtosisTV, 20 min, 2026-09-18; transcript via yt-dlp auto-captions). Artosis cast AlphaStar for DeepMind, so he is the right observer for this.

- **Pluto** won the most recent SC1 AI competition, reportedly by a wide margin, using reinforcement learning. Its authors emailed Artosis in late August to get the games cast.
- Someone **unrelated to the authors** then ran it on the official Remastered ladder (Team Liquid thread, as reported in the video). It reached #5 global; the three accounts above it are drop-hackers, so effectively **#1** (2729 MMR). Some players allege it also map-hacks — unconfirmed.
- Korean pros were only learning a bot was on the ladder as the video was made, so its opponents to date did **not** know what they were playing.

**The game: Pluto (T) vs Paralyze (P)** — ex-SK Telecom, ASL veteran, Artosis's "easily top seven Protoss in the world."

| What the bot did | Human reading |
|---|---|
| Academy first, marine/medic vs Protoss | Non-viable cheese; storm, reavers, and gateway units all counter it |
| Factory very late; Starport + Science Facility on two base; Covert Ops → ghosts | No standard timing exists for this |
| Building placement "the ugliest I've ever seen" | Unusable for a human — production won't fit on one screen |
| Unguarded third CC, found and pushed back; CC landings mistimed | Wasted money and mining time |
| **Locked down its own siege tank** | Pure error |
| Tanks in the open, no upgrades; a random cloaked Wraith | Free kills for the opponent |
| Down 2 base vs 5, ~60+ probes against it | Artosis: the break point past which Terran "can't really win anymore" |
| Then: ghost lockdown + stimmed +1/+2 marines, two fronts, **~6,092 APM** | Wipes a storm-heavy army; game over |

Paralyze read the opening as a rush, played defensively (legs + storm on two base, third nexus at ~9:00 — extremely late), built a winning position by every macro measure, attacked into it, and lost the fight.

## Why storm lost — and what was actually abused

Psi-storm is a **positional** counter: its damage is conditional on the target staying inside the cloud for the duration. Its value is therefore bounded above by the opponent's reaction time. Ghost range 7 (marine 5 with the upgrade, dragoon 6), lockdown range 8. Against a controller that pre-splits, dodges every cast, and kites at max range on two screens simultaneously, the positional term goes to zero and only the raw range/DPS arithmetic is left — which marine/medic with upgrades wins. Ghosts being the **least-used unit in the game** is not incidental; it is the signature. Their value was entirely gated behind mechanics no human can pay for, so the human meta priced them at zero. Correctly, for humans.

Artosis's own line: "some of the best bots that I've seen do utilize ghosts because they can click more accurately and more quickly."

**The abused stat is a range gap, not the spell.** Ghost attack is 10 concussive — 2.5 damage to a dragoon — so ghosts never kill the mechanical core and the gun is irrelevant. What matters is **lockdown range 8 vs dragoon range 6**: a goon closing on a ghost is locked at 8 before it can fire at 6, every time, given an instant cast. The shuttle is mechanical and gets caught on approach at the same range; a locked shuttle cannot unload, so "perfect reaver micro" never happens. Reavers on the ground match range 8, but scarabs are slow and dodgeable at machine speed. Range is the *delivery*, lockdown is the *payload*, and the payload is what makes a 2-range gap worth anything against large units. Humans can't cash the gap because the cast has to be perfect; the meta priced it at zero for that reason.

## Why the gradient went there

The reward does not distinguish *better strategy* from *better mechanics*; it orders trajectories by win rate and the policy climbs where marginal return is highest ([oracles-as-objective-functions](../oracles-as-objective-functions.md) — an objective orders candidates, it does not explain them). Human strategy in this matchup has been optimized for 25 years; unlimited APM is virgin territory with a huge gradient. So the bot's badness at macro is not a defect it will grow out of — it is the *expected* shape of a policy whose reward is saturated along the cheap axis. Nothing in the objective pays it to fix building placement when lockdown micro wins the game anyway.

This is the [cognitive-vs-motor](../cognitive-vs-motor.md) split showing up as a *confound in a benchmark*: the motor axis is so cheap for the machine that it swamps the measurement on the cognitive axis. DeepMind had to bolt an APM cap and a camera constraint onto AlphaStar for exactly this reason — the uncapped version tells you nothing about strategy. Pluto on the ladder is AlphaStar with the cap removed and the pro not told.

## The generalization — "found a move humans overlook" is ambiguous

An optimizer that beats the human baseline with a move humans never make has done one of two things, and the win alone cannot tell you which:

1. **Genuine insight in the shared region** — a move the human *could* have made and evaluated, but didn't search.
2. **Exploiting a region the human evaluator could never search** — a move whose value depends on a resource (APM, precision, a clamp floor, an unmodeled subsystem) the human doesn't have or the model doesn't represent.

The vault already has this ambiguity in a policy network: [democracy3-solver](../../projects/democracy3-solver/README.md)'s optimizer "found" a crime rate of 0.000 with organized crime and black markets still active — the unclamped sum was −0.43, and the win was the clamp, not the policy. The alternate revenue path it found (gambling + prostitution, no equality cost) is plausibly type 1; the crime result was type 2. Same test applies in both places: **constrain the optimizer to the human's resource envelope and see what survives.** For Pluto that is an APM-capped rematch against a pro who knows what he's playing. Until that exists, the ladder result is a fact about mechanics, not about Brood War strategy.

## What capped and uncapped self-play would each test

**A cap prices sloppiness.** Uncapped, an action has a shadow price of zero: nothing charges the bot for walking units around bad placement, re-landing a CC, or locking down its own tank, so the reward never sees macro efficiency. Cap APM and clicks become a scarce budget — every click spent compensating for bad macro is a click not spent on micro — and the policy must allocate between them. The cap does not teach strategy directly; it gives macro a *price*, and the gradient follows the price. Same structure as the budget constraint in [democracy3-solver](../../projects/democracy3-solver/README.md): the binding constraint's shadow price is what ranks the moves. Cap design matters: AlphaStar's first cap was on *mean* APM and the agents learned to idle and burst to thousands in fights — it must be windowed and count effective actions, or it is capped in name only.

**Capped self-play** saturates the mechanics axis for both sides, so the remaining gradient is strategy and macro; the equilibrium should drift toward the human meta — or diverge from it somewhere specific, which would be a claim that the humans are wrong *there*. That is the version that can say something about Brood War strategy.

**Uncapped self-play** is where new ideas about the game itself might appear, and this matchup has a candidate. Protoss's entire mechanical core — dragoon, shuttle, reaver, arbiter, carrier, corsair — is lockdownable at range 8. What remains is the biological line: zealot, high templar, archon, dark templar. Legs + storm + DTs against vessel support is very nearly what Paralyze played, and it lost. If perfect-APM ghost/bio has no answer in the non-mechanical tree, uncapped self-play would not converge on anything human-like; it would converge on **"PvT is Terran-favored at the limit"** — a fact about the game, not about bots. Open until someone runs it.

## What this does and does not show (symmetric grounding)

- **Grounded:** the ladder placement (screenshot in video), the identity and calibre of the opponent, the build and the APM readout, Artosis's competence to judge what "normal" looks like.
- **Contested / single-sourced:** the RL claim and the "stolen and hacked" story both come via the Team Liquid post as relayed; the map-hack allegation is unverified either way; **one game**, in which the pro did not know he was facing a bot and by Artosis's reading tightened his play for a cheese that never came. Artosis flags every one of these himself and wants proper informed matches.
- **What would change the reading:** informed pros adapting (greedier play against a two-base bot) and still losing; or an APM-capped version still finding ghosts. Either would move weight from type 2 toward type 1.

## Tags
[games](../../tags/games.md), [game-ai](../../tags/game-ai.md), [strategy](../../tags/strategy.md), [machine-learning](../../tags/machine-learning.md), [ai](../../tags/ai.md)
