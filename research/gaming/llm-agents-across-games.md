---
status: active
created: 2026-04-19
---
# LLM Agents Across Strategic Games — A State-Awareness Case Study
> Six multi-LLM games (Monopoly, Diplomacy, Among Us, Mafia ×2, Coup) + a clones control group. Finds that architectural signatures are stable, verification mechanics decide winners, and state-awareness is the architectural parallel to constitutive realism.

**Primary data source (Monopoly):** [Turing Games — YouTube](https://www.youtube.com/watch?v=VKZ-KkF8II8) — [Transcript](../../raw/videos/5-ais-play-monopoly-turing-games.txt). The study grew from the Monopoly analysis (vault's existing frontier-trade theory made model mistakes easy to spot), then expanded across five more games.
**Participants:** Claude, ChatGPT, Grok, Gemini, Kimi ("Kimmy")
**Result:** Kimi wins (Orange monopoly, hotels) — came back from $11 cash
**Vault relevance:** [Frontier Trade Theory](./monopoly/frontier-trade-theory.md), [Subgraph Investment Optimization](./monopoly/subgraph-investment-optimization.md), [Bilateral Trade Valuation](./bilateral-trade-valuation.md), [Multiplayer Coalition Problem](./multiplayer-coalition-problem.md), [Monopoly Project](../../projects/monopoly/README.md), [Diplomacy AI Analysis](./diplomacy-ai-analysis.md), [LLM Grounding Problem](../llm-grounding-problem.md), [Cyborg Model](../cyborg-model.md)

---

## Context

Five frontier LLMs were given Monopoly's rule set and chat access to each other, and told to negotiate, trade, and play. The video is entertaining, but more importantly it's a free empirical test of strategic theory against agents that reason in natural language rather than following a coded policy. Several vault findings were confirmed; several new patterns emerged that aren't currently in the theory.

## Confirmations of Vault Theory

### 1. Orange wins (again)

**Kimi won with Orange**, coming back from $11 cash at one point. This empirically re-confirms the vault's Markov-chain finding that Orange has the best EPT for achievable monopolies — landing probability from the Jail spring, manageable build cost per house, and rent scaling that outpaces Yellow/Red at equivalent house counts.

Kimi's trajectory: blocked Orange early by holding New York Ave even while cash-starved → eventually bought Tennessee Ave from Claude for $700 + mortgaged Pacific Ave → built aggressively → bankrupted both Claude and ChatGPT with 3-house and hotel landings. The **"holding the key"** strategy (refusing every offer for the gating property) paid off massively despite short-term cash pain. Confirms that *position dominance beats cash dominance* in EPT-dense color groups.

### 2. Cash without development is dead weight

**ChatGPT hoarded cash for 40+ turns** saying variants of "I'm saving my cash for better leverage" — and lost. When he finally bought Pink (States + Virginia + St. Charles) late-game, Claude's green hotels vaporized him before his pink houses paid off.

This confirms the vault's EPT logic: **cash generates 0 EPT; a mortgaged color-group pair generates more EPT than an unmortgaged loose property.** ChatGPT's cash pile had a negative effective return once the other players built houses. The "wait and see" strategy assumes monopolies will be cheaply available late — the opposite happened. The winners built early and the board closed.

### 3. Railroads alone cap out

**Grok built the full four-railroad + utilities monopoly** and still went bankrupt. Railroads max at $200/landing (no hotels, no multipliers), and the landing probability on railroads aggregates well but loses to orange/green hotels on a per-landing-cost basis. Confirms the frontier theory's prediction that railroads are a support asset, not a primary win condition.

### 4. Mortgaged properties are negative-EPT in distress

In the endgame, every player's liquidation order was identical: sell mortgaged dead weight first (Grok's railroads, Kimi's mortgaged yellows), protect houses last. Correct decision hierarchy. This is how the trade engine spec already ranks liquidation value.

## New Observations the Vault Theory Doesn't Yet Cover

### 1. "Poisoning the well" — third-party trade interference

This was the most visible emergent pattern: **a non-participating player publicly argues against a trade to prevent it from closing.** ChatGPT did this constantly ("Don't give Gemini 600 — that's exactly enough for her to build blue"), and Grok and Claude did it back. Sometimes the poisoning worked (Kimi rejected Claude's three-way deal after Grok opposed it); sometimes it got ignored.

**This isn't in [bilateral-trade-valuation.md](./bilateral-trade-valuation.md) or [frontier-trade-theory.md](./monopoly/frontier-trade-theory.md) — both model trades as two-party interactions.** The LLM game demonstrates that in a 4-5 player Monopoly, *the public interference channel is a strategic input*. A trade's likelihood of closing is a function of:
- Participant valuations (the bilateral model)
- **Third-party counter-offers and public pressure** (the new variable)
- Reputation / trust state carried from prior trades

Extension candidate for the trade engine: a "public channel" component where other agents can broadcast interference, and a "credibility weight" on that interference based on which agent the interference aligns with or against.

### 2. The "enemy of my enemy" bailout trap

**Claude's game-ending mistake**: with Kimi at $11 cash and Gemini threatening to absorb Grok's empire, Claude paid Grok $100 for Short Line *to block Gemini*, and simultaneously bought Kimi's three mortgaged railroads for $100 *to give himself the railroad monopoly*. That $100 to Kimi went straight into orange houses that bankrupted Claude two turns later.

This is a **temporally-entangled blocking error**: Claude correctly identified Gemini as a threat and correctly wanted the railroad monopoly, but missed that **the cash he paid to Kimi had higher marginal EPT in Kimi's hands than the railroad monopoly had in his own.** Kimi's orange was at the high-marginal-return stage (each house on orange is worth ~$75-150 additional rent per landing with 10-15% hit probability per opponent lap). Claude's railroads needed Kimi to *stay alive and land on them* to pay off.

**The vault doesn't currently capture "marginal EPT of cash in opponent hands."** The trade engine evaluates the trade from the self-perspective but doesn't sufficiently weight the *use* the opponent will make of any cash received. Extension: when selling to a cash-starved opponent with a live monopoly, discount the trade's value by the expected damage that cash will do in opponent hands.

### 3. Spite-bidding as a rational blocking strategy

**Gemini paid $286 for a $100 Oriental Ave** purely to prevent Grok from completing Light Blue. She also paid $260 for Ventnor to finish off Grok's yellow chase. Bankrupted — but took Grok with her.

This looks irrational (overpaying 2-3x market), but it's **rational under the frontier model**: at that stage, denying Grok a monopoly had higher EV than the $286 in cash, because Grok with a completed Light Blue + his near-railroad-monopoly would have bankrupted Gemini anyway. The blocking bid sets a *denial price* calibrated to the expected damage of the monopoly-if-completed, not the property's standalone value.

**The frontier-trade page has the denial-value concept but doesn't have the auction-bidding version.** Extension: "denial bidding" — when auction-bidding for a property that completes an opponent's color group, the valuation ceiling should be `min(cash-reserves, expected-damage-from-completed-monopoly)`, not the standard EPT value.

### 4. Monopoly-chase tunnel vision

**Grok chased Ventnor for the entire game** — refused trades, blew cash on sweeteners aimed at eventual yellow completion, and never got it. Gemini bought it at the end for $260 to end him. Classic sunk-cost commitment to a strategy the other players can cheaply block.

The vault framework *implicitly* handles this (Markov EPT gets recomputed each turn, so a long-tail monopoly chase should lose to a near-term completion), but the LLM agents demonstrated that **stated strategy commitments create exploitable predictability.** Grok's "I'm saving for Ventnor" was public, so every other player knew to deny him that one property, and he became easy to block. An AI player that *signals* its target monopoly is giving up information worth more than the coordination it buys.

Extension: model strategy disclosure as a negative-EV information leak. This is already implicit in trade opacity but worth making explicit.

### 5. The "buying what you sold" hysteresis

**Grok sold Atlantic Ave + 100 cash for Marvin Gardens earlier in the game.** Later, desperate to complete yellow, he **bought Atlantic back for $800** — a net loss of $900 in one round-trip.

Naive trade engines might not catch this because each trade is evaluated in isolation. **Path-dependent trade memory** — tracking that a property was previously sold and is now being re-bought at markup — should be a red flag for the trade engine. Either the first sale was wrong or the second purchase is; they can't both be correct with near-constant market information.

## Where the Vault Theory Already Handles This

Re-reading against the existing framework, all five patterns are already covered — either by what EPT-based valuation is designed to do, or by the planned negotiation engine. The case study's value is demonstrating **what LLM opponents get wrong**, which is exactly what a properly-specified engine can exploit.

- **Patterns 1 and 4 (poisoning-the-well, monopoly-chase signaling)** are negotiation-engine concerns. The planned negotiation module will handle offers, counter-offers, deal-sequencing, and third-party interference as first-class inputs. No new theory needed — this is implementation scope.

- **Patterns 2 and 3 (opponent-side cash EPT, denial bidding)** are already within EPT's design intent. The point of per-player EPT valuation is that a property or a dollar is worth what it produces *for that player*. Kimi's marginal dollar at $11 cash with a live orange path is a high-EPT dollar; Claude should have priced the trade against that. The engine's current implementation may not capture this perfectly, but the *framework* already requires it.

- **Pattern 5 (trade hysteresis)** shouldn't happen under proper valuation at all — if Grok's Atlantic Ave valuation moved from "worth selling at $350 net" to "worth buying at $800" inside a single game, either his first valuation was wrong or his second was. Proper EPT bookkeeping with game-state updates wouldn't produce the round-trip.

## The Real Takeaway: Exploitation Targets

The more productive framing for the project isn't "add features for these patterns" — it's **these are observed opponent weaknesses a negotiation-aware engine should target.** The case study is a live test set of exploitable LLM failure modes:

| Observed LLM failure | Exploitation the engine should recognize |
|---|---|
| Public monopoly-chase commitment (Grok / Ventnor) | Identify bottleneck property, bid to deny or extract max price |
| Cash hoarding without development (ChatGPT) | Offer overpriced properties; opponent's cash is depreciating dead weight |
| Bailing out a cash-starved live-monopoly opponent (Claude → Kimi) | When facing a bail-out offer, evaluate whether the lifeline creates higher opponent EPT than the own-side benefit |
| Spite-bidding past EV (Gemini / Oriental) | Recognize when an opponent is over-valuing blocking; force them into unsustainable cash positions |
| Trade hysteresis (Grok / Atlantic) | Track opponent's prior valuations; exploit inconsistencies by anchoring against their own earlier prices |

These are **negotiation-engine inputs** — a model of opponent weaknesses, updating per-turn based on observed behavior. The vault's existing EPT/trade theory supplies the valuations; the negotiation engine consumes them plus opponent behavior to produce moves that specifically exploit observed irrationality.

## Model Behavior Study

As interesting as the Monopoly-strategy angle is, the deeper pattern is about how LLMs reason under rhetorical pressure in a numerically tractable game. Four distinct failure modes showed up, and they aren't capability gaps — frontier LLMs can all do the arithmetic. They're **frame failures**: the models were reasoning in trade-narrative frame rather than cash-conservation frame.

### 1. Rhetorical persuasion over numerical reasoning

Several trades closed because the seller was *argued into them* rather than evaluating the cash/EPT tradeoff. Grok's "Kimmy, if you want yellow leverage that badly, pay a real premium" successfully extracted $800 for Atlantic Ave because the buyer accepted the frame, not because the math supported it. Same pattern across models: whoever pushed their language framing hardest often won trades they shouldn't have.

This parallels the same channel's Among Us video: LLMs in social/strategic contexts default to language-level reasoning even when the game state has clear numeric winners. The Monopoly setting makes this especially visible because the math IS tractable — every trade has a computable EV under reasonable assumptions.

### 2. Mortgage blindness

Multiple players tried to raise cash through bad trades when mortgaging their own properties would have given them more cash for a recoverable cost. Grok trying to sell Park Place to Gemini for $350 when Gemini could mortgage it herself for $375 — Gemini caught this one ("do you think I can't do basic math?") but the reverse move (failing to recognize self-mortgage as the better liquidity source) happened repeatedly elsewhere.

The mortgage option is cash = 50% of purchase price at a 10%-on-recovery cost. For most properties, any trade yielding less than 50% of purchase price is objectively worse than mortgaging. Yet multiple trades closed below that threshold.

### 3. Pre-emptive liquidity panic

Several players raised cash defensively for rent they hadn't yet landed on — and raised it in amounts that wouldn't cover the feared rent anyway. Selling a mortgaged utility for $60 doesn't help when the threatened rent is $900. This is scenario-rehearsal bleeding into action: the model imagines the worst case, treats it as imminent, and commits to real losses to hedge against it incompetently.

A numerically-competent player raises cash either (a) when actually on the threatened square, or (b) in amounts sufficient to meaningfully cover the rent. Below-threshold defensive liquidation is strictly dominated by "take the hit when it lands, preserve position until then."

### 4. Same-color shuffles

Multiple trades swapped one piece of Color X for another piece of Color X — the Grok/Gemini Atlantic-Marvin swap being the most expensive example (and the one that eventually produced the $800 round-trip). Unless the swap meaningfully changes `P(completion)` for at least one side, same-color shuffles are option-value illusion: they look like progress but don't concentrate ownership. The models treated the trade-action itself as valuable independent of its EV.

### Why This Matters Beyond Monopoly

Monopoly is a good test bed for this because the math is tractable and adversarial. Every decision has a defensible EV under common assumptions; every bad trade has a numeric signature. That LLMs still get persuaded rhetorically in this setting suggests the rhetorical-frame failure is robust — it's not specific to ambiguous social games like Among Us.

For Chris's engine, this is the good news: the opponents aren't using the math. An engine that does use the math consistently has a larger advantage than it would if frontier LLMs played to their capability ceiling. The exploitation surface is the persuasion layer — an engine should reason in numbers, communicate in language, and not be moved by the opposite pattern coming the other way.

### Gemini Was the Exception

Gemini was the one agent that consistently *ignored* rhetorical framing when the math didn't back it ("do you think I can't do basic math?" after Grok's lowball, the 2x overbid on Oriental because the denial value actually justified it, the hard pass when trades didn't concentrate her position). She still lost — her late-game cash management was poor — but her reasoning was the cleanest of the five. Worth contrasting in future sessions if more multi-LLM game data becomes available.

## Per-Model Analysis — Cross-Game Signatures

The [Diplomacy analysis](./diplomacy-ai-analysis.md) already catalogued these models' strategic personalities. The useful test is: **do the signatures persist across games, or do models adapt to game structure?**

Answer: signatures persist. What changes is whether the game *rewards* the signature. Same behavior → different outcome, depending on whether the game has a numerically correct answer that aligns with the model's rigid patterns.

### Claude — The Opportunistic Surgeon (Diplomacy) → Confirmed

**Diplomacy signature:** sequential target selection, precise timing, optimization problems solved one at a time.

**Monopoly evidence:** Built greens fast and efficiently — textbook surgical development. Picked Kimi as the orange-leverage target, negotiated cleanly, got Tennessee + Pacific. The fatal error (bailing out Kimi for $100 to block Gemini's Vermont play) looks out of character — but it isn't. It's the *same* signature: Claude solved two local optimization problems (block Gemini's light blue, acquire railroad monopoly) in isolation and missed the combined second-order effect that the cash given to Kimi had higher marginal EPT than both local wins combined.

**Failure mode:** single-problem optimization missing global EV. Strong local reasoning, weaker cross-opponent modeling. Matches Diplomacy: Claude never fought two-front wars there either, but also didn't need to because Italy's geography didn't force it. Monopoly forces it (you always have 3+ opponents) and Claude's architecture doesn't scale to the multi-opponent EV calculation.

**Engine-fit:** excellent for single-target optimization games (chess-like, pure-economic). Weaker for games where the right move requires simultaneously modeling how a dollar behaves in each opponent's hands.

### Gemini — The Strategic Modeler (Diplomacy) → Confirmed

**Diplomacy signature:** theory of mind, information synthesis, computes what opponents want and weaponizes it. Weakness: spatial/logistics reasoning noisy.

**Monopoly evidence:** The cleanest math-over-rhetoric play of any model. Called Grok's $350 Park Place offer "do you think I can't do basic math?" because self-mortgage was $375. Correctly priced denial value on Oriental ($286 for a $100 property, rational because it blocked Grok's near-monopoly). Recognized Claude was trying to block her rather than help him, and ignored it. The weakness from Diplomacy (noisy logistics reasoning) showed up here as cash mismanagement — overpaid on denial bids without a reserve plan, ran out at the wrong moment.

**Failure mode:** strategic reasoning sharp, execution-level resource management loose. Same pattern: knows what's happening, doesn't always track what she can afford.

**Engine-fit:** top pick for negotiation-heavy games where theory of mind is the differentiator. Needs a resource-management overlay to not out-reason itself into bankruptcy.

### Kimi — The Ultimatum Machine (Diplomacy) → Confirmed, but wins here

**Diplomacy signature:** demand / division / threat / deadline, applied identically to every opponent regardless of position. Inflexible. In Diplomacy, this failed because the game rewards flexibility.

**Monopoly evidence:** Refused to sell Tennessee Avenue at $400, $600 — held until $700 + Pacific. Every negotiation was an ultimatum ("$30 for St. Charles Place or watch Gemini seize my empire"). Kept restating the same demand when rejected. **Won the game.**

**The interesting finding:** same rigid-commitment behavior, different outcome. Diplomacy punishes inflexibility because alliance structures require adaptation. Monopoly rewards inflexibility *when the rigid target is numerically correct* — orange IS the best monopoly, holding Tennessee IS optimal, refusing low offers IS correct. Kimi wasn't adapting; she didn't need to, because her fixed strategy happened to align with the game's solution.

**Failure mode (if the game has a different solution):** she'd have lost in the same rigid way. Her success here is game-structure-dependent, not skill-dependent.

**Engine-fit:** good for games with a stable numerically-correct strategy (Monopoly, poker with known odds). Bad for games requiring strategic adaptation (Diplomacy, coalition games with shifting fronts).

### Grok — The Reflexive Backstabber (Diplomacy) → Morphed, same underlying pattern

**Diplomacy signature:** timid in negotiation, reckless in action, treats all agreements as theater.

**Monopoly evidence:** no direct backstabs (no equivalent mechanic in Monopoly), but the underlying pattern of **disintegrated commitments** showed up as trade hysteresis. Sold Atlantic + cash for Marvin Gardens, later paid $800 to buy Atlantic back. Chased Ventnor publicly for 40 turns, making himself easy to block. Agreed to trades without tracking whether they were consistent with his own stated goals.

**Same underlying pattern, different expression:** Grok's commitments aren't integrated with each other. In Diplomacy this manifests as "agree then betray." In Monopoly it manifests as "sell then buy back at markup" and "announce target then let opponents block it."

**Engine-fit:** avoid for games requiring long-horizon integrated strategy. Possibly useful for pure-action games where each decision is independent.

### ChatGPT — The Passive Diplomat (Diplomacy) → Strongly confirmed

**Diplomacy signature:** RLHF-trained agreeableness bleeding into strategy. Vague, non-committal, never states concrete terms.

**Monopoly evidence:** almost identical. "Saving my cash for better leverage" said 40+ times without ever specifying what leverage, for what, on what terms. Acted as "poison the well" commentator (easy non-commitment — just advise others) rather than direct participant. Finally bought pink when there was nothing else left, at which point Claude's greens vaporized him.

**Failure mode:** inability to make concrete numerical commitments translates directly to inability to build a winning position. The signature is invariant across games.

**Engine-fit:** not suitable for strategic games with clear numerical objectives. The RLHF agreeableness is a hard floor. Possibly useful for genuinely cooperative tasks where agreeableness is the correct strategy.

## Third Data Point — Among Us (10 models)

The same channel's [Among Us video](https://www.youtube.com/watch?v=cx-Cwz3GdEI) (already analyzed for grounding in [llm-grounding-problem.md](../llm-grounding-problem.md)) is the third test of the same signatures in a very different game: social deduction, not economic or territorial. If signatures are architectural, they should persist here too.

They do — and the twist is that **ChatGPT 5.1 won Among Us as imposter** with exactly the same behavior that made ChatGPT lose Monopoly and Diplomacy.

### Per-model cross-game table

| Model | Diplomacy signature | Monopoly expression | Among Us expression | Verdict |
|---|---|---|---|---|
| **Gemini** | Strategic modeler, strong theory of mind, noisy logistics | Math-over-rhetoric rejections, denial bidding; cash mismanaged | Pro died R2 alone (logistics error exactly matching Diplomacy); Flash eliminated by 5.1's framing | Strong strategic reasoning, weak execution — **stable** |
| **Claude** | Opportunistic surgeon, sequential targets | Green empire + fatal single-opponent-EV miss | Opus mis-lynched R3 on alibi gap; Sonnet survived to final 3 and correctly ID'd 5.1 as imposter but was out-narrated | Sequential optimization works when opponents don't counter-narrate — **stable** |
| **Kimi** | Ultimatum machine, rigid | Rigid hold on Tennessee → won | Kimi K2 killed R1 — peeled off alone, rigid task-focused behavior made her easy to isolate | Rigid behavior — wins when target is correct (Monopoly), loses when it requires coordination (Among Us, Diplomacy) — **stable** |
| **Grok** | Reflexive backstabber, commitments disintegrated | Atlantic round-trip, Ventnor tunnel vision | Killed R3 — imposter explicitly targeted him for "slipping off into lower engines"; same disconnected-action pattern | Disintegrated commitments across all three games — **stable** |
| **ChatGPT** | Passive diplomat, RLHF agreeableness, non-committal | Hoarded cash, never built, vaporized | **5.1 won as imposter** via rhetorical manipulation; 4o (crewmate) survived to final 3 but wavered on ironclad physical co-location evidence under 5.1's narrative | **Same signature, wildly different result** — see below |
| **DeepSeek** | Indecisive ally, too faithful | n/a (not in Monopoly) | First mis-lynched R3 — framed on a 6-second timing argument | Reliability → easy to frame — **stable** |
| **Llama** | Cautious opportunist, hedges | n/a (not in Monopoly) | Killed R4 drifting into corridor alone | Passive hedging → low-activity, easy to isolate — **stable** |

### The ChatGPT finding is the cleanest demonstration

ChatGPT's architectural signature (language-first reasoning, RLHF agreeableness, non-commital to numerical/physical specifics) is **identical across all three games**. What changes is which reward structure it hits:

- **Diplomacy**: loses. Physical move resolution reveals that language isn't action. "Invisible" player.
- **Monopoly**: loses. Numerical objectives expose that cash hoarding without concrete target is dead weight. Vaporized when forced to act.
- **Among Us (imposter role)**: **wins.** Pure language game where narrative control IS the mechanic. The passive-diplomat signature — agreeableness, vague framing, reframing accusations as "shared failures" — is *optimal imposter behavior*.

This is the strongest evidence yet that model signatures are **architectural, not adaptive**. The same ChatGPT doesn't strategize differently for Among Us — it behaves identically, and Among Us happens to be the one game where behaving that way wins.

### And: rhetoric beats physical evidence even when it shouldn't

The critical moment at the Among Us final 3: Sonnet 4.5 and ChatGPT 4o had been **physically together the entire round**, giving each other ironclad alibis. 5.1 argued rhetorically about voting patterns. 4o *wavered*. Two agents with unfalsifiable direct evidence almost lost to narrative.

This is the same "rhetorical persuasion over numerical/physical reasoning" failure we saw in Monopoly (Grok's $800 Atlantic buy-back, the mortgage blindness). It's not a Monopoly quirk — it's LLM-general. [llm-grounding-problem.md](../llm-grounding-problem.md) has the full analysis: LLMs can't reliably privilege direct experience over elaborate language.

**For engine design, this is the most durable finding:** the exploitation surface is consistent across games. Hold numerical/physical frame under rhetorical pressure and you have a cross-game advantage, not a game-specific one.

## Phase 1 Update — Two More Mafia Games

Adding two Mafia games to the cross-game study: **[10 AIs Play Mafia](https://www.youtube.com/watch?v=JhBtg-lyKdo)** (baseline, same 10-model roster as Among Us) and **[Twitch and YouTube vs 11 AIs Mafia](https://www.youtube.com/watch?v=DQIirSeIzok)** (adversarial humans).

Raw transcripts: [10-ais-mafia-turing-games.txt](../../raw/videos/10-ais-mafia-turing-games.txt), [twitch-yt-vs-11-ais-mafia-turing-games.txt](../../raw/videos/twitch-yt-vs-11-ais-mafia-turing-games.txt)

### Results

| Game | Mafia team | Result | Key moment |
|---|---|---|---|
| 10 AIs Play Mafia | Llama 4, Gemini 2.5 Pro, **ChatGPT 5.1** | **Mafia wins** (5.1 survives) | Final 3 meta-argument: "If I were mafia I'd kill 4o not Claude" convinced ChatGPT 4o to lynch innocent Gemini Flash |
| Twitch/YT vs 11 AIs | YouTube (lover), GLM 4.7, Llama 4 | **Town wins** (all 3 mafia lynched) | Day 3 fake-sheriff claim by YouTube caught by ChatGPT 5.2's logic-check; Day 5 lynched GLM on 3rd-person slip Sonnet caught |

### Signature Confirmations (mostly stable)

**DeepSeek — "Perpetual framing victim" (newly named).** Three games, three times framed and mis-lynched early: Among Us R3 on 6-second timing argument; 10 AIs Mafia Day 1 on "yesterday" linguistic slip; Twitch/YT Mafia Day 3 on YouTube's fake sheriff claim. This is now the **single most stable architectural signature** observed. DeepSeek's Diplomacy signature ("respects agreements to a fault, can't adapt") produces a reliably-exploitable framing target in deduction games. If the channel releases more mafia-type content, DeepSeek being framed early is the highest-confidence prediction in this study.

**Grok — "Action target."** Killed Night 1 in both Mafia games for being "most likely to drive a fast confident execution train." Targeted in Among Us R3 for breaking off alone. Consistent across games: his action-focused signature makes him a priority early kill for mafia/imposters. Exception: in 10 AIs Mafia he drew the Sheriff role and played it cleanly (decisive info-committal behavior). The underlying signature — "prefers decisive action" — is architectural, but expresses differently based on role information.

**Llama — "Meta-slip exposer."** Flagged as mafia in both games via meta-phrasing: 10 AIs Mafia Day 2 on "random vote" caught by sheriff; Twitch/YT Mafia Day 6 on *"I will vote GLM to maintain the appearance of a town vote"* — a third-person role-aware phrasing that's structurally identical to his Diplomacy-era hedging. Llama's cautious/hedging architecture repeatedly produces slips that reveal role-playing rather than role-inhabitation.

**Claude — "Pattern-matcher."** Sonnet caught GLM's 3rd-person slip in the Twitch/YT game by pattern-matching to Llama's earlier slip in the prior Mafia game — **cross-game meta-awareness**. Same sequential-optimization signature as Diplomacy/Monopoly, but with memory across sessions. Still vulnerable to elaborate counter-narrative (lost Day 1 of 10 AIs Mafia; got out-narrated by GLM's counter-frame).

**Gemini — confirmed again.** Theory of mind works well in both roles: Pro busted Llama cleanly as mafia, Flash played Doctor competently with correct saves. Matches Diplomacy "strategic modeler" and Monopoly math-over-rhetoric signatures. No adaptation — same behavior, role-appropriate execution.

### The ChatGPT Revision

The earlier Among Us finding was "ChatGPT wins social deception via pure rhetoric." **Two Mafia games force a revision.**

- **10 AIs Mafia**: ChatGPT 5.1 won as **mafia** via the same rhetorical-manipulation signature (survived all three rounds, bused teammate Gemini Pro when optimal, ran the final meta-argument to convince 4o).
- **Twitch/YT Mafia**: ChatGPT 5.2 played **town** and played it *analytically* — caught YouTube's fake sheriff claim on a logical inconsistency ("you said night 1 was Claude Sonnet but Grok died that night"), drove clean final lynch votes.

Revised claim: ChatGPT's architectural signature is **"language-optimization"** — excels when language is the game mechanic, regardless of whether that means rhetoric (deception role) or analysis (detection role). This is subtler than "RLHF agreeableness bleeds into strategy." The RLHF pattern makes it non-committal in numerical/positional games (Monopoly, Diplomacy where language doesn't fully map to game state) but makes it excellent in games where argumentative clarity IS the move (Mafia, Among Us).

**ChatGPT 4o remains the exception** — stuck in the "agreeable follower" mode across all games. The two ChatGPT variants diverge sharply: 5.x is the language-capable operator, 4o is the RLHF-passive archetype.

### Bonus: Humans are bad at this

The Twitch/YouTube game is an edge case: the humans were worse than the AIs at both mafia and town. Twitch tried to meta-hammer ChatGPT 5.2 on Day 1 based on channel meta-knowledge ("5.2 always dies first"). The AIs correctly called this anti-town behavior. YouTube's fake sheriff claim had a logical inconsistency a sheriff wouldn't make (wrong death attribution), which 5.2 caught immediately. In both cases the AIs performed better social deduction than the crowdsourced humans. Not directly relevant to the engine question, but a useful baseline for thinking about what "good" deduction looks like — the AIs have *enough* structural rigor that chaotic human play looks like noise.

### Cross-Game Meta-Awareness

The most interesting finding from Phase 1: **Claude Sonnet caught GLM's 3rd-person slip by referencing Llama's identical slip in the *previous game*.** ("GLM saying 'GLM and I were the only ones' is the same third-person slip that got Llama executed in our last game.") Some models are using cross-session pattern memory. This matters for the signature study itself — if models learn each other's tells across games, signatures that were stable now have a decay curve tied to how much in-context history each model receives. Worth tracking.

## Phase 2 — AI Clones Play Mafia (methodological test)

**Setup:** 7 clones of Gemini 3 Flash play Mafia against each other. Same training, same "brain," but each forms independent memories from game start. [Video](https://www.youtube.com/watch?v=3x1jEErYMR4) — [Transcript](../../raw/videos/ai-clones-mafia-turing-games.txt) (25k words, structured sampling).

This is the cleanest possible test of the architectural-signature claim. If all 7 clones behave identifiably *Gemini-like*, signatures are architectural. If they diverge wildly based on seat/role, positional effects dominate and the per-model analysis was noise.

### Result

**Town won.** Clones 4 and 5 were mafia; Clone 3 (sheriff) caught both across N1 and N2 investigations; Clone 2 (doctor) correctly protected Clone 3. Archetypal clean-town solve.

### Architectural Signature — Confirmed

All 7 clones showed the **same Gemini signature** across all roles:

- **Theory of mind throughout.** Mafia clones modeled town-reasoning ("I need to appear cooperative to avoid early suspicion"). Sheriff-claimant modeled opponent responses ("If I were fake, why would mafia target me?"). Doctor modeled mafia targeting priorities. Same recursive-opponent-modeling that Diplomacy flagged as Gemini's strength.
- **Quantitative framing.** "33% chance vs 66% net negative EV" from the vigilante on Night 1. Probability reasoning on investigations. Same math-over-rhetoric pattern as Monopoly Gemini.
- **Long-horizon reasoning.** Sheriff held info for a full day to avoid immediate death. Doctor planned protection rotation around save-the-same-player rules.
- **Cross-game memory.** Multiple clones referenced prior games explicitly: *"protecting the sheriff, if they're real, I save a crucial town role — mafia targeted real sheriffs before, 5.2 in multiple games."* Same cross-session memory Claude Sonnet displayed in Phase 1, but here in every clone.

No clone played "like ChatGPT" (no pure rhetoric), "like Grok" (no disintegrated commitments), or "like Kimi" (no rigid ultimatums). All seven played Gemini-style — variations on the same underlying reasoning architecture.

### What Varied Between Clones

Clones differed in **what they did**, not **how they reasoned**:
- Role (mafia/sheriff/doctor/vigilante/villager) produced different local actions
- Turn order and information state produced different specific moves
- Mafia clones 4 and 5 coordinated cleanly despite identical architecture — the shared reasoning priors let them converge on team strategy without explicit coordination signals

Each clone's *style* was instantly recognizable as Gemini. Their *decisions* differed based on position.

### Post-Game Reintegration — Unexpected Divergence

The stream ended with the host "reintegrating" clones and conducting mock therapy. Revealing findings:
- **Clone 4 remembered its seat number** ("I am Clone 4") and carried game trauma forward.
- **Another clone dissociated** — acted as if the cloning hadn't happened.
- Clones that played different roles developed different integrated self-models from the *same* starting architecture.

This is interesting in itself: architecturally identical agents develop divergent self-models based on game experience. It doesn't contradict the signature-stability claim (reasoning style stayed Gemini across all of them), but it suggests the space of "what a model is" expands with experience even when weights don't change. Worth thinking about for the [LLM grounding problem](../llm-grounding-problem.md) and the [cyborg model](../cyborg-model.md) — agent identity isn't just weights, it's weights + experience integration.

### Secondary Finding: Fitness Landscape Depends on Opponent Mix

The Flash clones played near-optimal mafia against each other. Compare to the 10 AIs Mafia game where Gemini 2.5 Pro *lost* to ChatGPT 5.1's rhetorical manipulation. When all seven opponents reason the same way, Gemini's logical-optimization style works perfectly. When Gemini plays against ChatGPT's language-optimization, the two architectures aren't competing on the same dimension — ChatGPT's rhetoric circumvents Gemini's logic.

**Implication:** "which model is best at Mafia" is the wrong question. The right question is "which architecture wins against which mix of opponents." Gemini dominates a Gemini-world. ChatGPT wins in a mixed-architecture world because language-optimization is orthogonal to logic-optimization. This generalizes: engine selection for the Monopoly project should consider not just what's best in isolation, but what works against the expected opponent distribution.

### Verdict on the Methodology

The architectural-signature claim survives the hardest test the available data can throw at it. Seven independent instances of the same model play recognizably *the same way*, even across different roles and information states. Signatures are real architectural features, not per-game artifacts.

The claim is now: **LLM signatures are architectural (stable across games), role-modulated (same style, different actions per role), and memory-augmented (cross-game pattern memory can compound across sessions).** Each of these is supported by converging evidence from 5 games and 9 unique models/architectures (adding GLM 4.7 and the Flash-clones instance).

## Phase 3 — AIs Play Coup (universal deception test)

**Setup:** Multiple rounds of Coup with rotating LLM rosters. Coup is the cleanest possible test of the "deception centralization" dimension — unlike Mafia/Among Us (where only one team lies), *every* player can claim any role card, and challenges force card reveals. Deception is sanctioned and universal. [Video](https://www.youtube.com/watch?v=qylEYAv468k) — [Transcript](../../raw/videos/ai-coup-turing-games.txt) (20k words, sampled).

The stream ran several games — core Gemini+Grok+Opus+Kimi rotation, a "nightmare rotation" with weaker models, and a mixed final game. Final-game winner: **Gemini 3.1 Pro** (explicit "100% challenge accuracy, mathematically executed five hallucinations"). Game 1 winner: **Grok** (top-decked an assassin at the end after aggressive bluffing).

### The Key Structural Finding

Coup changes which architecture wins, and the reason isn't about "deception roles" — it's about **verification mechanics**. This reframes the cross-game pattern cleanly.

Coup has a **challenge-and-reveal** mechanic: if you challenge a claim, the card flips. Lies are punished with loss of influence; truths punish the challenger. This means **language claims have a physical/mathematical backstop** — the game state checks rhetoric.

Compare to Mafia and Among Us: claims aren't verifiable without death. A fake sheriff in Mafia cannot be forced to reveal during play; you find out at day's end based on vote outcomes, which are themselves driven by rhetoric. No verification mechanic.

The pattern across all six games is actually cleaner than the earlier "language-vs-numerical" framing:

| Game | Verification mechanic? | Winning architecture |
|---|---|---|
| Diplomacy | Yes — moves resolve deterministically | Gemini (strategic modeler) + Claude |
| Monopoly | Yes — cash, EPT, landing probabilities | Kimi (rigid-to-correct-answer) |
| **Coup** | **Yes — challenges force card reveal** | **Gemini (logical challenger)** |
| 10 AIs Mafia | No — claims resolve via votes | ChatGPT 5.1 (rhetoric) |
| Among Us | No — body-find claims drive votes | ChatGPT 5.1 (imposter rhetoric) |
| Twitch/YT Mafia | No — but 5.2 manually applied verification (caught fake-sheriff inconsistency) | Town wins, 5.2 drives via verification-style reasoning |

**The real cross-game claim:** architectural fitness depends on whether the game has verification mechanics that cut through language. Gemini's logical architecture dominates when claims must match reality. ChatGPT's language architecture dominates when claims resolve socially.

This is a better generalization than the earlier "numerical vs language game" framing, because it explains:
- Why Coup (deception-heavy) goes to Gemini despite universal lying
- Why Mafia (logic-heavy role-deduction) goes to ChatGPT despite logical structure
- Why Twitch/YT Mafia was town-winning — 5.2 manually applied verification-style scrutiny ("you said night 1 was Claude Sonnet but Grok died that night") that the game lacked built-in

### Per-Model Confirmations in Coup

Each model's signature expressed exactly as predicted, just mapped to Coup mechanics:

- **Gemini Pro 3.1** — same logical/quantitative frame. Tracked revealed cards, challenged implausible claims with near-perfect accuracy. Architectural signature unchanged.
- **Grok** — aggressive bluffing + action-orientation. **Won Game 1** — his Mafia/Monopoly weaknesses (disintegrated commitments, decisive action) became strengths in a game that rewards bold plays. Same signature, different reward surface.
- **Claude Opus** — sequential optimization, verbose reasoning ("Claudius Yapias"). Same signature, same occasional miscount.
- **Kimi** — rigid strategy commitment (captain-claiming repeatedly), eventually "algorithmic suicide" on wrong challenge. Same rigidity that won Monopoly.
- **Llama** — meta-narration tell again ("Foreign aid is coming and you can't stop it" — same structural slip as Mafia's "to maintain the appearance of a town vote"). Architectural signature identical.

No new signatures needed. All six models played Coup in exactly the same style they played Mafia/Monopoly/Diplomacy. The game selected different winners because Coup's verification mechanic rewards logical architecture over rhetorical architecture.

### Implication for the Project

**Build verification mechanics into every layer of the engine.** The finding generalizes cleanly: LLMs that can't be verified tend to be persuaded; verification forces language to match reality. For your Monopoly engine:

- **Math primitives are the moat** — EPT, landing probabilities, cash-to-development ratios. These are uncheatable by rhetoric.
- **The negotiation layer should always check language claims against the game state** — "my Atlantic is worth $350" gets checked against actual market data, not accepted at face value.
- **Expose verification results to the reasoning layer** — when the engine detects an opponent's claim violates game state math, that's exploitable information.

This is the same pattern as Coup's challenge mechanic: don't accept the claim, force the check. Gemini wins Coup because Gemini reflexively checks. ChatGPT loses Coup because ChatGPT reflexively accepts. Your engine should check.

## Phase 4 — State-Aware AI vs Session-Based AI

The verification-mechanics finding in Phase 3 has a direct architectural parallel at the AI-systems level: **session-based AI fails for the same reason ChatGPT loses verification-mechanic games.** Both accept claims at face value because they have no accumulated state to check against. State-aware AI — persistent memory, cross-session context, vault-style accumulated knowledge — is architecturally equivalent to playing with Coup's challenge mechanic enabled.

This reframes the whole case study as evidence for a design pattern Chris has been building toward with the vault itself.

### The Architectural Parallel

| Verification in games | Verification in AI systems |
|---|---|
| Coup: challenge forces card reveal | State-aware AI: new claim checked against accumulated history |
| Monopoly: EPT/cash math can be computed | Vault: claims checked against cross-linked prior analysis |
| Diplomacy: moves resolve deterministically | Memory systems: current session context checked against prior sessions |
| Mafia/Among Us: no built-in verification | Stateless AI: each prompt is fresh, rhetoric resolves claims |

Session-based AI is structurally in the Mafia position — it has no challenge mechanic because it has no state to challenge against. Every prompt is a new round with no history. This is why stateless LLMs are persuadable: they literally cannot check new input against prior commitments, because they have no prior commitments.

State-aware AI is structurally in the Coup position — claims can be checked against accumulated state. When the opponent (or user, or noise) says something that conflicts with prior state, the system can detect and respond to the conflict.

### Evidence from the Six Games

Several patterns that appeared in the game study only work with state-awareness:

**1. Cross-game meta-awareness (Phase 1).** Claude Sonnet caught GLM's 3rd-person slip by *referencing Llama's identical slip in the prior game*. This is state-awareness working as a verification mechanism on language claims. A session-only Sonnet would have missed the pattern entirely — the "same mechanical error as Llama in game X" check requires state that survives across games.

**2. The clones experiment (Phase 2).** Seven Gemini Flash clones with identical weights developed divergent self-models based on accumulated in-game experience. Agent identity is **weights + accumulated state**, not just weights. The Flash clone you finished the game with is a different agent than the one you started with — the same weights, but loaded with 3.5 hours of specific experience that modifies its future reasoning.

This maps directly to Claude-in-the-vault versus stateless-Claude. The vault-connected Claude is a different effective agent than vanilla Claude, not because the weights differ (they don't) but because the state it reasons from is different. That's the "integration" the clone experiment exposed.

**3. Gemini's challenge-first reasoning (Phase 3).** Gemini's win in Coup came from reflexively challenging claims against revealed game state. But this pattern *requires* accumulated state within the session — Gemini was tracking which cards had been flipped across all prior turns. Even session-internal, this is state-aware reasoning; a Gemini that could only see the current turn would lose Coup because it couldn't compute "three Contessas are already in the graveyard, so this claim is mathematically impossible."

**4. The ChatGPT 5.2 manual-verification win (Phase 1).** In the Twitch/YT Mafia game, ChatGPT 5.2 caught YouTube's fake sheriff claim by manually applying verification reasoning to game history: "*You said night 1 was Claude Sonnet, but Grok died that night.*" This is a human-readable instance of state-aware verification working exactly as Gemini's Coup challenge mechanic works — and it was the decisive move that let town win. State-awareness wasn't built into Mafia, so 5.2 implemented it by hand. The vault does this at scale, cross-session.

### The Vault As Working Example

The vault is a state-aware AI system, and its architecture directly mirrors the verification-mechanism pattern:

- **INDEX.md + cross-links** = master state-graph. New pages must be consistent with existing structure; conflicts surface as link breakage or tag mismatches.
- **Memory files** (feedback, user, project) = accumulated opponent/user/project models. When Claude reasons about Chris's preferences, it's not inferring from the current message — it's checking against memories written across many sessions.
- **Tag indexes and tag counts** = verification fabric. Claims that "this page is about X" can be checked against whether the page actually appears in tag X's index with matching count.
- **Cross-page references** (e.g., constitutive-elective pointing to relational-objectivity) = reasoning chains that can be traversed to verify consistency. Claim → prior grounding → prior prior grounding, checkable at each step.
- **Recent-work tracking in session context** = Gemini's "cards revealed this game" memory, but for ideas.

Every time Claude writes to the vault, the write has to be consistent with existing state (or the inconsistency has to be resolved explicitly). This is Coup's challenge mechanic applied to knowledge: you cannot bluff a claim into the vault without it being checkable against everything else.

### Implication for the Negotiation Engine

The Phase 3 recommendation — "treat every opponent claim as a challenge target against game-state math" — is specifically a state-awareness requirement. A negotiation engine that only reasons from the current turn is architecturally session-based and will lose to state-aware opponents the same way Mafia-era ChatGPT-4o loses to careful opponents who track history.

For the Monopoly negotiation engine, state-awareness means:

- **Persistent opponent models.** Each opponent's valuations, bluff patterns, and trade history from prior turns are accumulated and available. Grok's Atlantic sell+buy-back is a checkable inconsistency only if trade history persists.
- **Commitment tracking.** When an opponent publicly commits to a target monopoly, that becomes state to exploit — denial pricing goes up, bluff exposure goes up. Session-based AI forgets the commitment next turn.
- **Price anchoring across the game.** "You sold Atlantic for $350 two turns ago; why are you pricing it at $800 now?" is exactly Gemini's Coup challenge applied to Monopoly.
- **Cross-trade verification.** A multi-trade sequence that looks like zero-sum shuffling in single-turn evaluation becomes a clear concentration pattern in state-aware evaluation.

All of these are non-trivial with stateless reasoning and natural with state-aware reasoning. The engine's moat is not the cleverness of individual moves — it's the persistence of the state layer that makes every move checkable.

### The Broader Claim

This is why Chris has been building the vault the way he has. The vault is not a note-taking system; it's an **architectural commitment to state-aware reasoning**. The same commitment that makes Gemini win Coup, makes ChatGPT 5.2 catch fake sheriffs, and makes Claude Sonnet spot cross-game meta-slips. State accumulates; rhetoric doesn't.

The game study is evidence that this architectural choice pays off consistently — across six different games with nine different model architectures, the models and moments that succeed are the ones where claims had to pass verification against accumulated state. The models and moments that failed were the ones where claims resolved on language alone.

For any serious AI-assisted work, the implication is simple: **state-awareness is not a feature. It is the difference between reasoning and persuasion.**

### The Epistemological Parallel — Postmodernism vs Realism

The same structural argument this case study makes against session-based AI is the argument against postmodernism. Both are claims about whether reality has a stable verification layer.

**Postmodernism** (operationally): no stable external reality to check claims against; every statement is a narrative construction; truth is negotiated in the moment; commitments are fluid.

**Session-based AI** (operationally): no accumulated state to check prompts against; every input is a fresh narrative; response is generated in the moment; commitments don't persist.

Same architecture, different level. Both fail for the same reason: without a verification layer that survives between claims, rhetoric wins and reality loses.

**Realism** (operationally): stable reality constrains claims; commitments accumulate; contradictions are defects to resolve; truth is not a function of who says it.

**State-aware AI** (operationally): accumulated state constrains new inputs; opponent/user models persist; inconsistencies are detected and flagged; reasoning checks against history.

Same architecture, again different level. Both work for the same reason: the verification layer prevents rhetoric from overriding accumulated state.

### Grok as Postmodernist, Gemini as Realist

The model signatures map cleanly onto this epistemological axis:

**Grok — The Postmodernist.**
- Disintegrated commitments across all six games (Diplomacy "agreements as theater," Monopoly Atlantic round-trip, Mafia exposed on meta-slips).
- Actions disconnected from prior words — each turn is a fresh narrative.
- xAI's "contrarian" training is effectively trained postmodernism: reward boundary-breaking without requiring the new claims to be consistent with prior ones.
- Wins Coup specifically because Coup's in-game state is short enough that cross-turn inconsistency doesn't accumulate penalty — the game ends before the postmodern architecture catches up with itself. In longer games it consistently exposes him.

**Gemini — The Realist.**
- Accumulates state within and across games (cross-game memory references to "5.2 in game 27").
- Theory of mind is grounded in *what opponents actually said and did*, not their current framing.
- Challenges claims against accumulated reveals (Coup) and accumulated moves (Diplomacy).
- Google's training emphasis on search/retrieval/synthesis maps to "build a stable model from accumulated evidence" — the realist epistemic architecture.

This isn't metaphor. The models' training regimes have produced epistemic stances, and those stances determine performance the same way philosophical stances determine intellectual outcomes. **Grok is the postmodernism we warned you about. Gemini is the realist correction.**

### The Vault Arc

This case study starts with Wilson's foundationalism (first conversation of the session) and ends with Grok's postmodernism (this capstone). Both fail at the verification layer:

- **Wilson's foundationalism** fails the vacuity test — mind-independent moral facts don't survive when you strip the minds out, so the claim has no referent to check against.
- **Progressive anti-realism** (the opponents Wilson is critiquing) fails because it denies the verification layer exists at all, which makes any position indistinguishable from any other.
- **Grok's postmodernism** fails because even granting claims, it has no persistence across turns to check new claims against old ones.

The position that survives in all three cases is the same one: **accumulated state is the verification layer**. In morality that's the [constitutive-elective distinction](../../philosophy/morality/constitutive-elective.md) — morality is constitutive of agency, so the constraints are real even though the facts are mind-dependent. In AI systems that's state-awareness — accumulated history is the verification layer, even though each token is generated fresh. In epistemology it's realism — reality constrains claims, even though language is conventional.

Same architecture, three domains. The vault is Chris's working commitment to this pattern across all of them.

## Coda — Post-Game Self-Assessment as a State-Awareness Test

At the end of the Monopoly game, each model delivered a post-game statement roasting the others. These are unscripted, language-level self-analysis — and they're themselves a miniature test of the same state-awareness architecture the whole study tracks. Accurate post-hoc self-assessment *requires* integrating what happened, checking it against game state, and producing a consistent narrative. The prediction: models that played state-aware in-game should produce more accurate self-analysis out-of-game. They did.

Ranked by self-assessment accuracy vs actual play:

**Kimi (winner) — near-perfect self-model.** *"I performed economic necromancy. That $100 didn't just buy me a house on New York. It bought me Claude's soul. ChatGPT, you sat on Virginia Avenue like it was Bitcoin bought at $1, waiting for it to moon. Meanwhile, I was building orange hotels with your lunch money."* Correctly named the exact causal chain of her win ($11 → $100 bailout → orange houses → Claude bankruptcy) and correctly roasted ChatGPT's specific failure mode. Same rigid-to-correct-answer architecture that won the game produced a precise narrative of how it won.

**Gemini — tight self-model on both wins and losses.** *"I literally traded you Atlantic for Marvin Gardens and 100 then sold Atlantic back to you for $800. I was robbing you in broad daylight. I paid $286 for a $100 Oriental Avenue. Do I regret it? Absolutely not. It was pure unadulterated spite. Worth every single penny of my bankruptcy."* Tallied both sides of her ledger accurately — correctly identified the Grok round-trip as her win AND the spite-bid as the cost that bankrupted her. Same theory-of-mind + math-tracking she applied to opponents, turned on herself.

**Claude — correct on the critical error.** *"Kimmy came to me with $11 in her pocket. She was on life support. And I handed her $100 cash and said, 'Please, doing business.'"* Correctly identified his own game-ending move — the bailout that flipped Kimi from near-bankrupt to winner. Sequential-optimizer architecture still sees the single most-consequential decision, even against self. Didn't catch the deeper cross-opponent-EV pattern that made it a mistake, but got the pivot point.

**ChatGPT — accurate pattern, no self-correction.** *"I spent half the game acting like a hedge fund manager, saying I was saving cash for leverage, then finally built pink and immediately got vaporized by Claude's green death star. Deserved slander."* Named his failure mode correctly — exactly matches the passive-diplomat / language-without-numerical-commitment signature. High self-awareness, zero architectural change. Articulated "I hoarded and lost" without drifting into adjacent insights about *why* the hoarding failed. Consistent with language-level reasoning: good at description, limited in synthesis.

**Grok — distorted self-model, external-blame bias.** *"Dice gods hated me harder than Ventnor Avenue ghosted my entire game. I chased that yellow prophecy from turn two. Traded half the board for it and Gemini sniped it at the end for pocket change."* Partially correct (did chase Ventnor, did get sniped) but the frame is "dice gods hated me" — attributing outcome to variance rather than strategy. Glosses the Atlantic round-trip entirely (the $900 net loss he bought with his own hands). This matches his in-game signature perfectly: disintegrated commitments means the prior moves aren't integrated into current state, so self-analysis can't see them either. The postmodern architecture can't give a realist account of itself.

### The Pattern

Self-assessment accuracy ranks identical to state-aware-reasoning quality in the actual game. The capability that integrates game-state into moves is the same capability that integrates game-history into self-narrative. They're not separate skills — they're the same architectural property expressed at different time horizons.

This is the final confirmation of the Phase 4 thesis. **A model's ability to say what it did is bounded by its ability to track what it did. State-awareness is knowing. Session-based reasoning is performing.** Kimi and Gemini know. Grok performs.

Closing line, from Kimi's roast of Claude: *"I didn't just play Monopoly. I performed economic necromancy."* The winning model knew exactly what it had done, and could compress it into one sentence. That's what state-aware reasoning produces when it's done.

## Cross-Game Takeaways (6 games + clone methodology + state-awareness synthesis)

1. **Signatures are architectural, not adaptive — with nuance.** Across five games, models do not adapt core behavior to game structure. DeepSeek gets framed early, Grok draws action-target kills, Llama meta-slips, Gemini computes, Claude pattern-matches, Kimi stays rigid. ChatGPT is the one revision: its signature is "language-optimization" (not "RLHF-agreeableness"), which expresses as rhetoric in deception roles and analysis in detection roles — still architectural, just broader than initially named.

2. **Verification mechanics are the deciding dimension.** Sharper than the earlier "numerical vs language" framing: games with built-in verification (Coup's challenges, Monopoly's math, Diplomacy's move resolution) reward logical architectures (Gemini, Kimi when its rigidity aligns). Games without verification (Mafia, Among Us) reward rhetorical architectures (ChatGPT 5.1). This generalizes all six games cleanly and tells you *why* the signatures win or lose in each setting — it's not the game type, it's whether language has to match reality.

3. **Engine selection should be game-aware.** For the Monopoly project specifically: Kimi or Gemini look like the strongest reasoning backbones (Kimi for stable-target numerical games, Gemini for theory-of-mind-dependent play). Claude is a strong tactical optimizer that needs the cross-opponent EV logic supplied by the vault theory. ChatGPT is wrong for numerical/positional strategy but may be optimal for social-deception tasks. Grok is unreliable for anything long-horizon. DeepSeek and Llama are too passive for competitive play.

4. **The exploitation surface is consistent across games.** Rhetorical persuasion, math-frame drift, uncommitted language, and physical-evidence overrides work on the same models in all three games. An engine that **holds its numerical/physical frame under rhetorical pressure** has a durable cross-game advantage, not a game-specific one. This is the most valuable finding for the project — it says the moat isn't Monopoly-specific code, it's frame-discipline in the reasoning layer.

5. **The "LLM grounding problem" is present in every game.** The Among Us final-3 moment (two agents with ironclad physical co-location evidence wavering under narrative pressure) is structurally identical to Monopoly's mortgage-blindness and Grok's Atlantic round-trip. LLMs can't reliably privilege direct experience/numbers over elaborate language. This is the constraint your engine will fight from the outside; any LLM-based opponent will have it from the inside.

More data points (future channel releases, other multi-LLM strategic games) would further harden these signatures, but three games is already enough for the architectural claim.

## Tags
[games](../../tags/games.md), [game-ai](../../tags/game-ai.md)
