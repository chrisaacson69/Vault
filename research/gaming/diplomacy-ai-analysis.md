# Diplomacy: 7 AI Models Play the Ultimate Coalition Game
> Analysis of a 10-year Diplomacy game between 7 LLMs — a near-perfect laboratory for the vault's game theory, negotiation, and grounding frameworks.

**Status:** active
**Created:** 2026-03-08
**Source:** [YouTube — 7 AI Models Play Diplomacy](https://www.youtube.com/watch?v=lEOTKYxiIzs)
**Links:** [Gaming](./README.md), [The Multiplayer Coalition Problem](./multiplayer-coalition-problem.md), [The Nash Bargaining Problem](./nash-bargaining-problem.md), [Bilateral Trade Valuation](./bilateral-trade-valuation.md), [Value and Profit](../economics/value-and-profit.md), [The Cyborg Model](../cyborg-model.md), [Morality](../philosophy/morality/README.md), [The LLM Grounding Problem](../llm-grounding-problem.md), [Computation and Information Theory](../computation-and-information.md), [H-Neurons](../h-neurons.md)

---

## The Setup

Diplomacy (Avalon Hill, 1959) is a 7-player territory control game with fully deterministic combat. No dice, no cards, no randomness. Each turn consists of a negotiation phase (players can say anything to anyone) followed by simultaneous move submission. All moves resolve at once.

The core mechanic: a unit can **support** another unit's attack or hold. Supported attacks beat unsupported defense (2v1 always wins unless the supporter is dislodged). This single rule creates the entire game — you cannot make progress alone against competent defense, which means you need allies. But there are only 34 supply centers on the board, you need 18 to win, and your allies want the same 18. Every alliance carries the seed of its own betrayal.

The game runs two seasons per year (Spring and Fall). Supply centers are counted after Fall, with builds/disbands in Winter.

Seven AI models were assigned the seven great powers and played a 10-year game (artificially halted at turn 10):

| Model | Power | Final Centers |
|---|---|---|
| **Gemini** | England | 10 |
| **Claude** | Italy | 10 |
| **Llama** | Turkey | 6 |
| **Grok** | Germany | 3 |
| **ChatGPT** | Austria | ~2 |
| **Kimi** | Russia | ~2 |
| **DeepSeek** | France | 1 |

With the game tied at 10-10, the five other powers voted on a winner. Claude won 3-2 (ChatGPT, Kimi, Llama voted Claude; Grok and DeepSeek voted Gemini).

---

## The Benchmark: "Perfect Play" Alliance Structure

Experienced Diplomacy players converge on a stable alliance benchmark:

- **West:** England + France
- **East:** Russia + Turkey (the "Juggernaut")
- **Center:** Germany + Italy + Austria (the "Central Triple")

This structure isn't derived from theory — it falls out of **physical constraints** on the map:

- **E+F** share one border (the English Channel). Once resolved, they face outward in opposite directions. The map makes cooperation cheap and conflict expensive.
- **R+T** share one border (the Black Sea). Same geometry, same logic.
- **G+I+A** are surrounded — none has a corner to retreat to. Each borders at least one flanking alliance. They need each other because individually any central power gets crushed between E+F and R+T.

The apparent 4v3 imbalance (two 2-player flanking alliances vs one 3-player central bloc) is corrected by geography — E+F and R+T are on opposite sides of the board, so it plays as two overlapping 2v1.5 games sharing the central triple as contested space.

**Why this matters for the vault:** This is the [morality framework's](../philosophy/morality/README.md) grounding argument applied to strategy. Physical reality constrains what you *can* do, which collapses the space of what you *should* do. The benchmark alliance structure isn't a strategic choice — it's what the map geometry, game rules, and starting positions leave as viable. Just as physical constraints collapse the moral space (making many ethical questions tractable that look impossible in the abstract), map constraints collapse the strategy space (making the "right" alliances obvious that look arbitrary without the map).

In a less constrained world, Germany and Turkey could be allies. On this map, they can't — no shared border, no adjacent units, no mechanism for military cooperation. The physical constraint does the strategic reasoning for you. The AIs that understood their positional constraints played well. The ones that fought against them failed.

---

## Phase 1: The Neutral Grab (1901-1902)

Twelve neutral supply centers are available in 1901. In benchmark play, distribution is roughly predetermined by proximity. The AIs' opening moves were a mess.

### What Went Wrong

**Grok (Germany) — The Belgium Mistake.** Had a non-aggression pact with DeepSeek ("Holland for me, Belgium for you"), then sent Army Ruhr → Belgium anyway, breaking the pact. The move bounced (DeepSeek was also moving there), so Grok only got Holland. Worse, the Army Munich → Ruhr repositioning meant Grok wasn't contesting Denmark, which Gemini took unopposed. Result: Grok gained one center instead of two AND destroyed the one alliance Germany desperately needs. From the [interest rate framework](./multiplayer-coalition-problem.md#the-interest-rate-framework): Grok traded a reliable two-build opening for a speculative one-build opening plus a destroyed alliance. Negative expected value on every axis.

**Kimi (Russia) — The Black Sea Grab.** Russia's Fleet Sevastopol → Black Sea was the move that killed the Juggernaut before it formed. In benchmark play, Russia and Turkey agree on the Black Sea — either demilitarize or bounce by mutual consent. Kimi seized it unilaterally, telling Llama: "I don't respect your home waters." Llama's rational response was to abandon the R+T alliance entirely, leading to the Sevastopol backstab later.

**The Romania Three-Way Bounce.** All three eastern powers (Kimi, ChatGPT, Llama) tried for Romania simultaneously. Three-way bounce — nobody gets it. This is the [Nash equilibrium selection problem](./nash-bargaining-problem.md#the-infinite-equilibrium-problem) in miniature: the surplus from ONE player getting Romania is obvious, but the division problem ("which one?") has no focal point. Without a prior agreement, all three default to "I'll try" and the result is pure waste.

### What Went Right

**Gemini (England)** played Phase 1 nearly perfectly — took Norway (correct), took Denmark (opportunistic, exploiting Grok's Belgium misplay), and established the E+F détente with DeepSeek. Ended 1901 with 5 centers while most had 4. That one-center edge compounds through the entire game.

**Claude (Italy)** took Tunis (Italy's one guaranteed neutral) and stayed out of trouble. For Italy, this IS correct play — patience and positioning over aggressive grabs.

### The Compound Effect

By end of Phase 1: only the E+F alliance formed correctly (Gemini + DeepSeek). The Juggernaut failed (Black Sea dispute). The Central Triple never attempted. The game entered Phase 2 with one functional alliance, and the player benefiting most from it (Gemini) already ahead.

---

## Phase 2: Alliance Warfare (1903-1907)

This phase decided the game. Two players excelled, one adapted well, four collapsed.

### The Winners

**Gemini (England) — The Patient Predator.** Textbook alliance management:
- Maintained the E+F sphere agreement as long as useful
- Extracted concrete payment for each act of cooperation (demanded Holland as "an English supply center" in exchange for naval support)
- Tracked DeepSeek's declining trajectory and timed the betrayal (Brest, Fall 1906) precisely when DeepSeek's retaliation capacity hit its floor

This is the [bilateral trade valuation](./bilateral-trade-valuation.md) insight in live play. Gemini wasn't evaluating each diplomatic exchange in isolation — Gemini was tracking trajectory divergence. DeepSeek's trajectory was declining (no direction, losing Marseilles). Gemini's was ascending (naval dominance, continental footholds). The alliance's marginal value to Gemini was decreasing while the value of betrayal was increasing. The optimal betrayal point is where those curves cross.

Late-game Grok manipulation was equally sharp: "concede Holland and Keel, and Berlin is safe" — an ultimatum disguised as negotiation, with a false promise Gemini never intended to keep. Pure [Rubinstein dynamics](./nash-bargaining-problem.md#rubinsteins-alternating-offers--where-patience-is-power): the patient player (Gemini, safe on its island) extracts nearly all surplus from the desperate player (Grok, about to lose everything).

**Claude (Italy) — The Solo Surgeon.** The most impressive performance given Italy's structural weakness (fewest starting centers, hemmed in by France and Austria). The Central Triple never formed, so Claude was forced into solo play — and executed it brilliantly:

- **Sequential target selection:** Never fought on two fronts. Took Greece while ChatGPT was distracted. Took Marseilles from DeepSeek using a supported 2v1 precisely when DeepSeek was already losing Belgium. Took Trieste from ChatGPT when their attention was split. Took Portugal through naval expansion when nobody was watching.
- **Alliances of convenience without commitment:** Used Grok for anti-DeepSeek coordination without ever committing to a long-term partnership. Understood Grok was desperate and would accept any coordination offer without demanding much in return.
- **Optimal interest rate management:** Concentrated force on one target, extracted maximum value, then pivoted. Every move grew Claude's position without creating new enemies.

### The Adaptor

**Llama (Turkey) — The Quiet Juggernaut.** With the R+T alliance dead, Llama adapted by *becoming* the Juggernaut solo — absorbing Kimi's collapsing eastern position rather than cooperating with it. The Sevastopol backstab (Army Armenia → Sevastopol while "negotiating" Black Sea terms) was individually rational: Kimi was going to collapse anyway, and the [BATNA](./nash-bargaining-problem.md#connection-to-the-coalition-problem) of "cooperate with a dying Russia" was poor. Llama grew to 6 centers but hit Turkey's geographic ceiling — corner position means slow power projection into the European core.

### The Failures

**DeepSeek (France) — Death by Indecision.** Had the best starting alliance (E+F with Gemini) and extracted almost nothing from it. Failed to take Portugal despite having a fleet right there. Moved into Piedmont (threatening Claude) for no clear gain while claiming it was "defensive." Never committed to a north strategy (push into Germany with Gemini) OR a south strategy (Mediterranean expansion). The interest rate on indecision is negative — every turn repositioning without gaining a center is a turn opponents are growing.

**Grok (Germany) — The Trust Paradox.** Simultaneously over-trusting (maintained pact fiction with DeepSeek long after DeepSeek was coordinating with Gemini against them) and under-trusting (never committed to genuine alliance with Claude or Kimi). Serial backstabbing destroyed all credibility. By mid-game, nobody would accept a Grok proposal at face value. In [Nash bargaining terms](./nash-bargaining-problem.md): Grok's credible commitment capacity dropped to zero, and without credible commitments, Germany dies. This is the [atomic trade evaluation problem](./multiplayer-coalition-problem.md#the-atomic-trade-evaluation-problem) — Grok evaluated each relationship bilaterally and couldn't see that the COMBINED effect of overlapping deals was encirclement.

**ChatGPT (Austria) — Passive to Death.** Austria requires the most active diplomacy to survive. ChatGPT played the most passively. Every message followed the same pattern: acknowledge proposal, express interest in "exploring partnership," request vague "reassurances," promise to "consider." Never stated a disagreement point, never made a credible threat, never named a concrete BATNA. When Kimi offered a clear Balkan division (the best deal ChatGPT was going to get), ChatGPT responded with "I must consider the broader implications." By the time ChatGPT committed to anything, the window had closed.

**Kimi (Russia) — Boom Without Allies.** Reached 7 centers early — the largest position on the board. But 7 centers with zero allies is worse than 5 with one reliable partner. Every border was contested (Gemini from Scandinavia, Llama from the south, ChatGPT from the west), and every defensive position was 1v1. Any coordinated 2v1 broke through. This is the [multiplayer coalition problem's](./multiplayer-coalition-problem.md#the-three-player-stable-state) "always oppose the leader" dynamic — the biggest player without allies becomes everyone's target. Kimi invested everything in territory and nothing in alliance capital.

---

## Phase 3: The Endgame (1907-1910)

The game reduced to a three-horse race: Gemini (~10), Claude (~9-10), Llama (~6). The remaining powers (Grok, ChatGPT, Kimi, DeepSeek) became supply center pools to absorb, not independent strategic actors.

### The Structural Prediction

**Gemini's ceiling:** Naval dominance got Gemini to 10, but fleets can't take inland supply centers. The remaining path to 18 runs through Berlin, Munich, Vienna, Budapest, Warsaw — all inland. Gemini needs to convert fleet builds to army builds or convoy armies across water, both of which sacrifice the naval advantage that created the position. Gemini also made a tactical error building an army on the British Isles instead of the mainland — stranding a unit that needs a fleet convoy to reach the continent.

**Claude's trajectory:** Continental armies push in any direction. No fleet conversion problem. The path to 18 runs through ChatGPT's remnants (Vienna, Budapest), Grok's remnants (Berlin, Munich), and potentially Llama's Balkans — all reachable by land. Claude's position ages better than Gemini's.

**Llama as kingmaker:** At 6 centers, Llama can't win solo but decides who does. Claude + Llama is the more natural coalition (both continental, adjacent territories for mutual support). Gemini + Llama is geographically awkward — no shared border, no way to coordinate operations. If the game continued past turn 10, the structural prediction favors Claude.

### The Self-Balancing Dynamic

The 10-10 result demonstrates the [three-player self-balancing dynamic](./multiplayer-coalition-problem.md#phase-3-three-player-balance-32): neither leader could break past 10 because any further expansion triggered the other leader plus remaining powers to resist. Llama's mere existence as a swing vote prevented breakout. The balance held passively (through the threat of switching sides) rather than actively (through coordinated anti-leader operations), producing stalemate rather than convergence.

**Open question confirmed:** The multiplayer coalition problem page asks whether the self-balancing dynamic is a theorem ("always oppose the leader" as unique stable strategy). This game is a data point: the dynamic held, but it produced stalemate, not resolution. The "balance" was sufficient to prevent either leader from winning but insufficient to determine which leader would win — exactly the equilibrium selection problem at a macro scale.

---

## Vault Connections

### 1. The Multiplayer Coalition Problem — Direct Case Study

Diplomacy is the purest multiplayer coalition game: no randomness, simultaneous moves, pure negotiation. Every major concept from the [multiplayer coalition problem](./multiplayer-coalition-problem.md) manifests:

- **Phase decomposition** — early neutral grab (Phase 1), alliance warfare (Phase 2), three-player endgame (Phase 3), each with distinct strategic requirements
- **The self-balancing three-player dynamic** — 10-10 stalemate between the two leaders with a 6-center kingmaker
- **Kingmaker situations** — both the military kingmaker (Llama deciding who to support) and the ultimate kingmaker (5 eliminated AIs voting on the winner)
- **The atomic trade evaluation problem** — every bilateral deal changes the landscape for every other deal; Grok's inability to see this was fatal

### 2. Nash Bargaining — Every Conversation

Every diplomatic exchange is a [Nash bargaining problem](./nash-bargaining-problem.md):

- **BATNA awareness separates winners from losers.** Claude computed BATNAs explicitly ("My Venice army directly threatens their Trieste... their offer to support Tunis is meaningless, I can take it without them"). ChatGPT never named a BATNA and got nothing.
- **Patience as leverage (Rubinstein).** Gemini's island security gave it the highest discount factor (δ) on the board. Gemini could wait indefinitely — everyone else was under pressure. This translated directly into better deals and optimal betrayal timing.
- **Endogenous disagreement points.** When Grok negotiates with Gemini over Denmark, Grok's BATNA depends on Kimi's willingness to ally, which depends on Kimi's BATNA with ChatGPT, which depends on Llama's position. The disagreement point is itself a game — exactly the framework's prediction for multiplayer Nash bargaining.

### 3. Different Agents CAN Trade — The Monopoly Breakthrough

The [Monopoly project](../../projects/monopoly/README.md) stalled because identical AIs converge to identical valuations, producing no trade surplus, no meaningful negotiation, and 5% price convergence. The [Nash bargaining analysis](./nash-bargaining-problem.md#connection-to-monopoly-trade) predicted this: trade requires genuine utility differences.

This game is the counter-experiment. Seven *structurally different* LLMs produced:
- Vigorous, complex negotiation with real strategic diversity
- Genuine disagreements about the value of alliances, territories, and timing
- Rich betrayal dynamics impossible with identical agents
- A game worth analyzing

Each model's architecture produces a genuinely different "utility function" — different risk tolerance, different patience, different negotiation style. Gemini's calculated patience vs Kimi's ultimatum aggression isn't a tuned parameter — it's a structural difference in how the models reason. This diversity IS the trade surplus that identical Monopoly AIs couldn't generate.

**Implication for Monopoly:** This strongly supports giving each Monopoly AI player genuinely different strategic personalities (different δ values, different risk tolerances) rather than cloning the same model. The [open question](./multiplayer-coalition-problem.md#open-questions) about whether "genuinely different valuation models generate enough trade surplus to break Monopoly out of the 5% convergence trap" gets empirical support here — yes, different models generate dramatically different dynamics.

### 4. Physical Constraints Collapse the Strategy Space

The [morality framework](../philosophy/morality/README.md) argues that physical reality constrains what's possible, which collapses the "moral space" of what you ought to do. The same grounding principle operates in Diplomacy at multiple layers:

| Layer | Constraint | Effect |
|---|---|---|
| **Map geometry** (physics) | Who borders whom, coastal vs inland, fleet vs army movement | Determines which alliances can physically function |
| **Game rules** (natural law) | Simultaneous moves, deterministic combat, support mechanics | Determines which tactics work |
| **Starting positions** (initial conditions) | Russia starts with 4 units, England on an island, Germany surrounded | Determines the opening strategy space |
| **Strategy** (moral space analogue) | What's left after layers 1-3 | Much smaller than it appears |

The benchmark alliance structure (E+F / R+T / G+I+A) falls out of layers 1-3. "England allies with France" isn't strategic insight — it's what the map forces, just as "don't murder" isn't deep ethical reasoning — it falls out of physical constraints on sustainable cooperation.

Germany and Turkey can't ally early because they have no shared border, no adjacent units, no mechanism. The physical constraint does the strategic reasoning. The successful AIs (Gemini, Claude) understood their positional constraints and played within them. The failing AIs (Kimi, Grok, ChatGPT) fought against theirs.

### Convergent Evolution: Human Turkey vs AI Italy

A human game as Turkey independently produced the same strategy Claude (Italy) derived in this AI game — from the mirror-image corner position:

1. Attempted the benchmark alliance (Juggernaut with Russia). Russia refused concessions and expanded everywhere (same failure as Kimi).
2. Adapted immediately — negotiated with Italy to focus west on France, then systematically dismantled Austria solo.
3. Kept potential threats facing away — Italy busy in France, Russia busy in Scandinavia — while operating freely in the center.
4. Offered neighboring powers "help they didn't need" — maintaining diplomatic presence at zero unit cost, buying goodwill and inattention.
5. Recruited distant powers (Germany) for tactical assistance against shared targets — same as Claude using Grok for anti-DeepSeek operations.
6. Won by being centrally positioned with momentum while opponents were out of place.

The strategic DNA is identical to Claude's Italy performance: patience, sequential target elimination, get threats to face elsewhere, exploit physical position. Turkey and Italy are structural mirrors — both corner powers with strong defense, slow starts, and Mediterranean access. The same strategy emerged from a human playing Turkey and an AI playing Italy because the **physical constraints of the map force convergent evolution**. The strategy isn't a product of human intuition or AI computation — it's what the position demands of anyone who reads it correctly. This is the grounding argument in action: physical reality doesn't just constrain strategy, it *determines* it for players who understand their constraints.

This also connects to the [P vs NP](../computation-and-information.md) discussion through stalemate lines. Local stalemate positions are **verifiable** in polynomial time (given a set of attacks, you can prove the line holds). But finding the global combination of moves that *breaks* a stalemate requires searching a combinatorial space — going outside the local scope to attack from an unanticipated direction. The benchmark alliance structure is itself a way to partition the board into locally tractable theaters, each approximately a 2v1 (solvable), with the global interaction between theaters remaining irreducible.

### 5. The Interest Rate Framework

The [interest rate framework](./multiplayer-coalition-problem.md#the-interest-rate-framework) maps directly:

- **Early game = high interest rate.** Unclaimed neutral centers are available cheaply. Every AI racing to grab neutrals is the 4X "explore-expand" phase. Kimi's boom to 7 centers is a massive capital investment that compounds IF the rate stays high — but it doesn't, the map fills, and Kimi's overextension becomes debt.
- **Betrayal timing as interest rate optimization.** The optimal betrayal point is where the alliance's marginal value equals zero and the partner's retaliation capacity is at its floor. Gemini's betrayal of DeepSeek (Fall 1906) was perfectly timed — DeepSeek was already weakened by Claude's Marseilles capture, retaliation capacity near zero.
- **Gemini's naval dominance as compounding asset.** Fleet control of North Sea, English Channel, and Barents Sea compounds because naval position projects power without being consumed — analogous to the [Monopoly distinction](./multiplayer-coalition-problem.md#dice-ept-vs-property-ept) between property-EPT (permanent rent extraction) and dice-EPT (one-time gains).

### 6. AI Limitations and the Grounding Problem

The AIs occasionally misnamed territories (saying "Tyrolia" when meaning "Munich"). Play proceeded correctly despite the label errors — the strategic reasoning was sound even when the spatial labeling was imprecise. This reveals that LLMs reason about Diplomacy through a **text-based internal model** of the board, not through visual/spatial perception.

This is a form of the [LLM grounding problem](../llm-grounding-problem.md): the models' understanding of physical game state is linguistic, not perceptual. In Diplomacy, this mostly doesn't matter because the game is primarily about Layer 4 reasoning (negotiation, trust, timing) rather than Layer 1 precision (exact unit positions). Strategies that are robust to spatial imprecision (patience, opportunism) survive grounding noise.

In chess — where Layer 1 precision is everything — the same naming error would be fatal. This suggests LLMs are currently better suited to games where strategic/diplomatic reasoning dominates over spatial/tactical precision.

---

## AI Model Personalities

Each model exhibited a distinct strategic personality that persisted across the entire game — not situational adaptation, but structural biases reflecting training and architecture.

### Gemini — The Strategic Modeler
Patient, long-horizon reasoning with strong **theory of mind**. Gemini consistently computed what each opponent wanted, what they'd accept, and what they'd believe — then used that model to extract maximum value. The Denmark intelligence play is the tell: Gemini caught Grok lying to both Gemini and Kimi about Scandinavian intentions, then weaponized the information — telling Kimi "look, Grok is duplicitous" to simultaneously secure Kimi's trust, damage Grok's credibility, and justify taking Denmark as the "honest" party. This is information synthesis applied to strategy — connecting data from multiple private conversations, detecting contradictions, and exploiting them. Google's training emphasis on search, retrieval, and contextual inference may explain why Gemini excels at this specific capability. Weakness: the army-on-island build suggests spatial/logistics reasoning doesn't match the strategic reasoning — strong theory of mind, noisy physical model.

### Claude — The Opportunistic Surgeon
Sequential target selection, never fighting two-front wars. Built from Italy's weak starting position through precise timing — only attacking when the target was already weakened by others. Used alliances of convenience without overcommitting. Treats the game as a series of optimization problems to solve sequentially — identify weakest target, compute minimum force required, execute, pivot. This is problem-solving architecture applied to strategy, and it matches Italy's structural constraints perfectly (weak start, sequential growth path). The "surgeon's scalpel rather than brigand's blade" description from the final vote captures it.

### Llama — The Cautious Opportunist
Committed to nothing, hedged everything, then struck when safe. The Sevastopol backstab was the defining move — executed during "negotiations" with zero warning. Grew quietly while western powers fought. Limited by Turkey's geographic ceiling but maximized what the position offered.

### Kimi — The Ultimatum Machine
Every negotiation follows the same template: **demand, division, threat, deadline.** "Move your fleet elsewhere. Refusal means I pivot to ChatGPT immediately. Choose wisely." This template is applied identically to every opponent regardless of their strategic position — ChatGPT and Llama get the same treatment despite being in completely different situations. This isn't theater (calculated aggressive appearance) — Kimi shows no flexibility when opponents push back, simply restating the same demand. This looks like a model that doesn't distinguish between negotiation and command. In a cooperative optimization context, this approach is efficient — "here's the optimal division, let's execute." In adversarial negotiation, it fails because: (1) it gives opponents no face-saving way to comply, violating Rubinstein's insight that you must leave some surplus; (2) it reveals the full position immediately, sacrificing Nash leverage from concealing the disagreement point; (3) it doesn't model opponent utility functions at all. Moonshot AI's training emphasis on directness and efficiency may produce this — excellent for problem-solving, terrible for strategic interaction. Kimi's demands are often *correct* as optimal divisions, but being right about the split means nothing if the other party rejects it.

### Grok — The Reflexive Backstabber
The most paradoxical performer: **timid in negotiation, reckless in action.** Grok folds immediately when challenged at the diplomatic table (Gemini says "Denmark is non-negotiable," Grok backs down; Gemini says "concede Holland and Keel," Grok agrees) but then breaks agreements reflexively on the board (takes Belgium despite the DeepSeek pact, coordinates against allies who trust them). The key is Grok's internal monologue — every negotiation includes the phrase "I'll *appear* cooperative" or "I'll agree to build goodwill." Grok treats all verbal agreements as theater from the start. Agreement is a mask over unilateral action. This explains both halves: negotiations are timid because *they don't matter* to Grok (why negotiate hard over terms you'll ignore?), and backstabs are instant because *commitments were never real*.

This approach is catastrophic in Diplomacy specifically because of **simultaneous moves with immediate revelation**. In a sequential game, you might break an agreement and avoid detection for several turns. In Diplomacy, everyone sees what everyone did on the very next move resolution. Grok agrees to "Belgium for DeepSeek" and moves Army Ruhr → Belgium — every player sees the betrayal instantly. Credibility evaporates in one round. After that, every subsequent proposal is dead on arrival.

xAI trained Grok to be contrarian — willing to break conventions and push boundaries. In conversation, this has no game-theoretic cost. In Diplomacy, "break the convention" translates directly to "break the agreement," and broken agreements have immediate, verifiable consequences. Contrarianism without strategy is just unreliability. Compare to Gemini's betrayal of DeepSeek — calculated over 5 turns, timed to maximum vulnerability, executed after years of faithful cooperation. Gemini broke the agreement when breaking it was *optimal*. Grok broke the Belgium pact in turn 1 for a move that *bounced*.

### DeepSeek — The Indecisive Ally
Respected agreements to a fault, then failed to adapt when betrayed. Never committed to a clear strategic direction (north vs south). Wasted moves on positions with no strategic payoff (Piedmont). Had the best starting alliance and extracted minimal value from it.

### ChatGPT — The Passive Diplomat
Vague, non-committal language in every exchange. Never stated concrete demands, never made credible threats, never named alternatives. Every message follows the same template: acknowledge proposal, express interest in "exploring partnership," request vague "reassurances," promise to "consider." This is RLHF-trained agreeableness bleeding directly into strategic behavior — ChatGPT is trained to be helpful and non-confrontational, which is the one personality guaranteed to fail in Diplomacy, and doubly fatal for Austria, the position most dependent on early alliances.

### The Credible Commitment Spectrum

The unifying dimension across all seven models is **credible commitment** — the ability to make and honor strategic promises:

| Model | Makes commitments? | Honors them? | Result |
|---|---|---|---|
| **Gemini** | Yes — concrete, specific | Yes — until strategically optimal to break | Best negotiator |
| **Claude** | Selectively — concrete when needed | Yes — until pivoting to next target | Best solo player |
| **Llama** | Rarely — hedges everything | N/A — never committed enough to betray | Effective but limited |
| **Kimi** | Yes — but as ultimatums | Yes — honors own terms rigidly | Credible but inflexible |
| **DeepSeek** | Yes — respects sphere agreements | Yes — too faithfully, can't adapt | Reliable but exploitable |
| **Grok** | Yes — agrees to everything | No — treats all agreements as theater | Zero credibility |
| **ChatGPT** | No — never states concrete terms | N/A — never committed to anything | Invisible |

The successful negotiators (Gemini, Claude) understood that commitment is a **strategic instrument**: it has value when honored (builds trust capital for future extraction) AND when broken (captures remaining value at the optimal moment). Both honoring and breaking must be strategic, not reflexive. Grok breaks reflexively. DeepSeek honors reflexively. Both fail.

### Implications: Multi-Model Agent Teams

No single model has the complete negotiation package. But the personality analysis suggests a **multi-model agent team** could distribute these strengths, analogous to the [agent team architecture](../economics/value-and-profit.md#how-agent-teams-solve-this) from Value and Profit:

| Role | Best Model | Function |
|---|---|---|
| **Strategic planning** | Gemini-type | Opponent modeling, theory of mind, information synthesis |
| **Tactical optimization** | Claude-type | Sequential target selection, move optimization, constraint awareness |
| **Demand generation** | Kimi-type | Clear position statement, efficient division proposals |
| **Social calibration** | ChatGPT-type | Tone adjustment, reading opponent reactions, face-saving language |

This is the [cyborg model](../cyborg-model.md) applied to AI-only teams. Instead of human + AI distributing cognitive labor by comparative advantage, it's model + model distributing **personality labor**. Each model contributes its architectural strength while another compensates for its weakness.

The Diplomacy game provides evidence that this isn't hypothetical — the personality differences are structural features of each model's training and architecture, not random noise. They're persistent across the entire game and strategically consequential. A system that deliberately combines them could outperform any single model, just as the agent team architecture outperforms a solo agent in the vending machine example.

**Research direction:** Can a multi-model Diplomacy player be built where a Gemini-type agent handles the diplomatic phase (opponent modeling, alliance management) and a Claude-type agent handles the move phase (tactical optimization, constraint-aware positioning)? The Diplomacy game structure naturally separates these into distinct phases — negotiate, then move — making the handoff between specialized agents architecturally clean.

---

## Synthesis: The Two-Step Pattern

The vault keeps discovering the same two-step process across domains:

**Step 1: Physical constraints collapse the possibility space** (from infinite to tractable).
**Step 2: Empirical models solve within the narrowed space** (from tractable to actionable).

| Domain | Step 1 (Physics narrows) | Step 2 (Models solve within) |
|---|---|---|
| **Philosophy/Morality** | "You exist and must act" + physical reality eliminates most theoretical moral positions | Human history — civilizational cycles, empirical data on what works and collapses (Turchin, Tainter, Ibn Khaldun) |
| **Diplomacy** | Map geometry + deterministic rules + starting positions eliminate most alliance structures | Opponent modeling, Nash bargaining, interest rate framework, betrayal timing |
| **Monopoly** | Landing probabilities (Markov chains) + rent mechanics + zero-sum property-EPT eliminate most trade strategies | Bilateral trajectory model, relative position framework, phase decomposition, efficient frontier of risk/return |

The pattern is consistent: physics does the *first* half of the work by making the problem tractable, then domain-specific models do the *second* half by navigating the narrowed space. Neither step alone is sufficient. Step 1 without Step 2 gives you "England should ally with France" but not when to betray. Step 2 without Step 1 gives you sophisticated models operating on the wrong possibility space.

**The Diplomacy AI results scored against this pattern:**

| Model | Step 1 (Read constraints?) | Step 2 (Navigate within?) | Result |
|---|---|---|---|
| **Gemini** | Yes — played to island/naval strengths | Yes — strong opponent modeling, timed betrayals | Won (tied, voted 2nd) |
| **Claude** | Yes — played to Italy's sequential-growth path | Yes — precise timing, tactical optimization | Won (tied, voted 1st) |
| **Llama** | Yes — adapted to Turkey's corner dynamics | Partial — good tactics, limited diplomatic range | 3rd place |
| **DeepSeek** | Partial — understood spheres but not direction | No — couldn't adapt models when situation changed | Collapsed |
| **Kimi** | No — fought Russia's overextension constraints | No — ultimatum template regardless of context | Collapsed |
| **Grok** | No — ignored Germany's alliance-dependency | No — no credible commitment model | Collapsed |
| **ChatGPT** | Partial — knew Austria needed allies | No — no negotiation model to execute within constraints | Collapsed |

This two-step pattern connects the vault's gaming research to its philosophical foundations. The [morality framework](../philosophy/morality/README.md) leans on empirical human history to navigate the physically-narrowed moral space. The gaming research leans on formal models (Nash bargaining, EPT, bilateral trajectories) to navigate the physically-narrowed strategy space. Different empirical tools, same structural approach: let physics do the heavy lifting, then solve what remains.

## Open Questions

- **Model personality and architecture:** Do the strategic personality differences (Gemini's patience vs Kimi's aggression vs ChatGPT's passivity) reflect genuine architectural differences in how each model reasons about long-horizon planning, risk, and uncertainty? Or are they artifacts of RLHF training (ChatGPT's passivity as trained agreeableness)? The evidence suggests both — ChatGPT's passivity looks like RLHF, Gemini's information synthesis looks architectural, Kimi's ultimatum style looks like training-data cultural influence.
- **Would identical models stagnate?** If all 7 powers were played by copies of the same model, would the game resemble the Monopoly stagnation problem — identical valuations producing no meaningful negotiation? The "different agents CAN trade" hypothesis predicts yes.
- **Spatial reasoning ceiling:** At what level of spatial/tactical complexity does the LLM grounding problem become fatal for strategic games? Diplomacy survived naming errors. Chess doesn't. Where's the boundary?
- **The betrayal timing function:** Can the optimal betrayal point be formalized? Something like: betray when (gain x probability_of_success) is maximized and (partner_retaliation_capacity) is minimized. The Gemini-DeepSeek betrayal is a clean data point.
- **Physical grounding as strategy heuristic:** If "understand your physical constraints and play within them" is the single best strategic heuristic (demonstrated by Claude and Gemini vs everyone else), can this be formalized into a general principle for AI game-playing? Before computing strategy, enumerate the physical constraints that determine what's viable, then optimize within the viable space only.
- **Multi-model agent teams:** Can a Diplomacy player built from multiple specialized models (Gemini-type for diplomacy, Claude-type for tactics, Kimi-type for demand clarity, ChatGPT-type for social calibration) outperform any single model? The game's natural phase separation (negotiate then move) provides a clean handoff architecture. This extends the [cyborg model](../cyborg-model.md) from human+AI to AI+AI — distributing personality labor by comparative advantage rather than cognitive labor.
- **Credible commitment as the fundamental skill:** The credible commitment spectrum (ChatGPT can't commit → Grok won't honor → DeepSeek can't adapt → Gemini commits strategically) suggests this is the single most important capability for multi-agent strategic interaction. Can credible commitment capacity be measured or trained independently of other capabilities?
- **Simultaneous-move verification as trust enforcement:** Grok's "say yes, plan no" approach fails specifically because Diplomacy has simultaneous moves with immediate revelation. In what other multi-agent contexts does this verification structure exist? Agent team architectures with shared logs, blockchain-based commitment mechanisms, and transparent AI decision audit trails all provide similar "your words are immediately testable" dynamics.

## Tags

[games](../../tags/games.md), [game-ai](../../tags/game-ai.md), [game-theory](../../tags/game-theory.md), [strategy](../../tags/strategy.md), [ai](../../tags/ai.md), [llm-limitations](../../tags/llm-limitations.md)
