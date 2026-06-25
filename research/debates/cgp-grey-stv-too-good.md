---
status: active
created: 2026-06-25
discussion: folded-in
---
# CGP Grey — "The Voting System That's Actually Too Good for Politicians to Allow" (STV)
> Advocacy explainer for Single Transferable Vote, framed as the obviously-fairer system incumbents suppress. Adversarial review: stress-test the claims against social-choice theory.

**Date:** 2026-06-25 (video: 2014, re-titled re-upload)
**Source:** [YouTube — CGP Grey](https://www.youtube.com/watch?v=l8XOZJkozfI) — [Transcript](../../raw/debates/cgp-grey-voting-too-good.en.srt)
**Participants:** CGP Grey (advocate for STV) vs — (no opponent; this is a one-sided explainer, so the "opposition" is the adversarial read)
**Result:** n/a — advocacy piece, not a debate
**Vault relevance:** [Game Theory as Normative, Not Descriptive](../../notes/game-theory-as-normative-not-descriptive.md), [Convergence Is a Process, Not a Destination](../../notes/convergence-as-process.md), [Directional Truth and the Discrete Trap](../../notes/directional-truth-and-the-discrete-trap.md), [Scope Confusion](../philosophy/morality/scope-confusion.md)

---

## Context
CGP Grey's "Politics in the Animal Kingdom" — a cartoon (Queen Lion fixing her jungle council) that walks through STV mechanics and argues it's strictly better than first-past-the-post. The re-upload title ("too good for politicians to allow") adds a populist suppression frame. It's a teaching classic; the adversarial value is that it makes strong, clean claims that mature social-choice theory complicates.

## Argument Structures

### Grey's case (advocacy)
1. **Problem with FPTP.** Single-member districts + most-votes-wins: a plurality bloc (monkeys, ~5/15) sweeps *every* district, so a minority of the population takes the whole council; ~2/3 per district go unrepresented. Compounded by gerrymandering ("the independent advisers weren't as independent as they appeared").
2. **Constraint.** Queen Lion wants to maximize citizens "happy with the result" *while keeping local representatives* — so pure party-list PR (abolish districts) is rejected.
3. **Mechanism — STV.** Multi-member districts. Quota = total votes ÷ seats (33% for 3 seats). Voters *rank* candidates. (a) Anyone over quota wins immediately; their **surplus** transfers to next choices. (b) If seats remain, **eliminate last place** and transfer their votes to next choices. Repeat until seats filled.
4. **Claimed advantages.**
   - **Honest voting:** "there's no point in strategizing about how everyone else votes" — vote your true favorite without fear of wasting it.
   - **More proportional**, so "monkeying with the borders matters less" (gerrymandering blunted).
   - **Almost everyone gets a local rep they actually voted for.**
   - The whole process "is designed to **maximize the number of citizens happy** with the result."

## Discussion
*(built live with Chris.)*

**Chris's frame — Arrow as "the Gödel paper of voting systems."** The decisive lens isn't any single STV flaw; it's the impossibility result underneath all of it. **Every voting system is a compromise with tradeoffs; none is "perfect."** Arrow's Impossibility Theorem is to voting what Gödel is to formal systems — a proof that the thing being sold (a fully fair / optimal aggregation) *cannot exist*. So a video like Grey's is **advocacy** for an RCV/STV-type system that simply declines to mention the impossibility floor: its two headline claims ("maximize voter happiness," "no point in strategizing") are precisely the two corners Arrow and Gibbard–Satterthwaite prove are empty.
> Chris: "This rings heavily against what I'd call the Gödel paper of voting systems — all voting systems are just compromises, none of them are 'perfect' as they all have tradeoffs. This is just trying to create more advocacy for an RCV-type system, whose flaws I believe I've already shown."

*(Prior vault treatment Chris was referring to: [`government-formation.md`](../philosophy/morality/legal-theory/government-formation.md) §266 — single-seat RCV still **collapses to two viable options** (Duverger's law); only multi-seat fills make third-party votes "not wasted." That page shows the Duverger flaw of single-winner RCV; this page is the focused voting-systems treatment that builds on it.)*

**Why the "no strategy" claim is false — the mechanism Grey hides (Chris's thread).** Grey *shows* the leader's surplus being transferred to another candidate but never explains **how** — and that hidden step is where strategy enters. The chain:

1. **STV is just multi-seat RCV.** Its engine = rank ballots → eliminate last place / transfer surplus of winners → repeat. So whatever strategy-dependence RCV (single-winner IRV) has, STV inherits — *because RCV is the underlying factor.* (Chris: "because [RCV] is [strategy-dependent], so is this method.")
2. **Why RCV itself is strategy-dependent (the part we hadn't laid out):**
   - **Sequential elimination → order matters.** Who survives each round depends on first-choice tallies, so transferring votes changes *who gets eliminated when*. Outcomes are path-dependent on elimination order.
   - **Non-monotonicity.** There exist ballot profiles where ranking your favorite *higher* causes them to *lose* (it changes who's eliminated upstream, redirecting transfers against them). Sincere ranking is therefore not always optimal — the definition of strategy-dependent. Real case: **Burlington VT 2009** mayoral IRV — elected a non-Condorcet winner and exhibited non-monotonicity.
   - **Center-squeeze → favorite-betrayal returns.** A broadly-liked centrist with few *first* choices is eliminated early, before second-choice support can rescue them. Voters learn to insincerely rank the "electable" compromise first — the exact wasted-vote fear Grey claims STV abolishes.
3. **The surplus transfer is undefined as stated.** "Give the extra votes to their second choice" presumes "the extra votes" is a *specific set of ballots*. It isn't. Competing rules give **different winners**: random-sample (non-deterministic — recounts differ), Gregory/fractional (transfer *all* the winner's ballots at weight = surplus÷total), Meek (iterative, computer-only). The cartoon's fastest handwave is its most consequential mechanism — and another surface for strategy.

**Net:** Gibbard–Satterthwaite already guarantees these scenarios exist for *any* ranked system; the above is the concrete machinery for STV specifically. So "no point in strategizing" isn't simplified — it's **false**, and false in the direction that flatters the pitch.

**Duverger connection.** FPTP single-seat drives a two-party equilibrium (strategic desertion of third parties). Single-seat RCV softens the *mechanical* wasted-vote logic but center-squeeze + non-monotonicity re-introduce strategic incentives, and empirically single-seat RCV still trends two-bloc (Australia's IRV lower house). Multi-seat STV is the one configuration that genuinely breaks Duverger (proportional, minor parties win) — **but multi-seat is exactly where Grey's prized "local representative" dissolves.** The locality↔proportionality tradeoff he waved away is the same tradeoff, returning.

**Credit due — and the scope confusion that limits it (Chris).** Genuine concession: **STV/RCV really is better at matching many candidates to many outputs** — proportional representation at a *single defined level* works as Grey shows. The flaw is that **Grey never says which level**, and proportionality does **not compose across nested levels**:
- *Proportional to which population?* A district, a state, the nation are different bodies. A system where each state sends a delegation proportional to *its own* internal split does **not** yield a nationally-proportional legislature (states differ in size/composition; thresholds and rounding compound). National proportionality and local representation are in tension, not harmony.
- *We don't run one nationwide election for all 435 House seats.* The polity is a **nested federation**; Grey's "kingdom" is a single undifferentiated body, which is exactly what lets "proportionality" read as unambiguous. Collapsing the levels is the sleight.
- *Districts are the decomposition device* — one (imperfect) solution that makes the problem tractable at a level where "local representative" is even meaningful. The cartoon treats districts as the disease; they're a deliberate answer to the level problem.
- *The at-large alternative has its own pathologies* (the California case, our prime illustration). Imagine California filling *all* its U.S. House seats from one statewide at-large ballot with ~100 candidates:
  - **Mechanical:** under most-votes-win, a statewide 51% can sweep **every** seat (more disproportionate than districts); under STV, ~52-way ranked ballots at a ~1.9% Droop threshold — administrative + cognitive nightmare, wild fragmentation.
  - **Epistemic (Chris):** a voter in LA cannot meaningfully evaluate 100 candidates spanning the whole state — they'll know nothing about candidates from the north. Districts shrink the choice to a *knowable* set; at-large exceeds the voter's evaluative capacity, so "ranking" becomes noise or party-label reflex.
  - **Skew / domination (Chris):** at-large lets **densely-populated areas impose representatives on regions they aren't part of** — LA/SF pluralities determine who "represents" the rural north. Districts exist precisely to stop population centers from governing communities they don't live in. This is a *federalism/locality* value, not an efficiency one, and STV-at-large erases it.

  "Just enlarge the district for proportionality" therefore hits infeasibility, an information ceiling, *and* a geographic-domination failure — three separate walls, not one.

So the credit is real but **scope-bounded**: STV does proportional many-to-many matching *at one level*; Grey smuggles that across levels into a nested federation where "the" proportionality isn't even well-defined. → [Scope Confusion](../philosophy/morality/scope-confusion.md), [Accounting Identities as Domain-Matching](../economics/accounting-identities-as-domain-matching.md) ("which restriction / which domain" is the unasked question).
> Chris: "Which proportionality is he talking about? Does he think all states should send proportional electors? What if that doesn't match the proportionality across the nation? We don't elect all 435 reps in one nationwide vote, so what he wants isn't feasible. Districts are one solution to solve this at a state level — it might be bad, but a state like California trying to elect all its congressmen in one vote has its own problems."

**The deeper move — "unfair to whom?" / proportionality ≠ fairness (Chris — the load-bearing point).** Grey's opening: each district's voters pick the monkey, so the council is all monkeys, which he calls "disproportional" and therefore **unfair** ("quite rightly," the citizens are unhappy). But he never asks *unfair to whom?* Ask each district and it would call its *own* result **fair** — the monkey won its district outright; **no district would say its result is unfair.** So "unfair" is not a property of the outcome; it requires a **criterion Grey never states and never defends**.
- The smuggled premise is **population-proportionality = fairness.** He finds *no* reason the district scheme is unfair — only that it doesn't match the distribution *he* thinks it should produce. That's **begging the question**: assume the goal, then label its absence "unfair."
- And the premise cuts the opposite way from how it's sold: **pure population-proportionality would *increase* urban dominance** — cities hold the most people, so proportional-to-population means *more* city-voter control of everything, not less. Bounded areas (districts, states, an upper house) exist **precisely to stop population centers from governing communities they don't live in**. Grey's "fix" worsens the exact thing the structure is built to check. Proportional-to-population ≠ proportional-to-bounded-area, and he never argues that *population* is the right reference frame.
- *Steelman:* Grey's implicit criterion — equal per-capita influence on the body's composition (one-person-one-vote → proportional) — is a coherent value. The point isn't that it's wrong; it's that it's **one contested value among several**, not a neutral fact, and the rival criterion (equal representation of bounded communities; anti-domination) is *why real senates are deliberately non-proportional* (US Senate: 2/state, the Connecticut Compromise). Aimed at a "council/senate," Grey's critique attacks the design rationale of upper houses without noticing.
> Chris: "He claims an all-monkey senate is disproportional and thus unfair — but unfair to who? Each district would say its own result is fair; no district would argue its result is unfair. So how does he reach that conclusion? He hasn't shown *why* population-proportionality is the goal — just that he advocates a system that tries to create it. And if everything were proportionality, elections would be *even more* dominated by city voters, not less."

**On "too good for politicians to allow" (Chris).** A nonsense / thought-terminating frame: STV isn't rare because it's suppressed for being too good — it's rare for the real reasons assembled here (impossibility floor, strategy-dependence, count complexity, the locality/proportionality tension, and the scope problem above).

### Seeds
1. **The load-bearing oversell: "no point in strategizing."** Gibbard–Satterthwaite says *no* non-dictatorial ranked system over ≥3 candidates is strategy-proof. STV reduces favorite-betrayal pressure but is not immune. Is "less strategic" being sold as "non-strategic"? (→ game-theory-as-normative: the clean claim smuggles in an impossibility.)
2. **Non-monotonicity.** Under STV you can make your preferred candidate *lose* by ranking them *higher* (and help them by ranking them lower), because of elimination order. Most voters would call that perverse. The cartoon's tidy transfers hide it — does honesty about this sink the "obviously fair" frame?
3. **"Maximize voter happiness" vs Arrow.** There is no aggregation that maximizes a global happiness; Arrow proves every ranked system violates *some* reasonable criterion. Grey asserts a global optimum social choice says can't exist. Is this the **discrete-destination trap** — one tradeoff-posture sold as THE answer? (→ convergence-as-process, directional-truth)
4. **Proportionality is bounded by district magnitude.** With 3 seats the real (Droop) threshold is ~25%; a 20% minority still gets nothing. Grey uses the Hare quota (33%) and tiny districts yet calls it "proportional." **Locality vs proportionality is a real frontier he presents as fully resolved** — bigger districts = more proportional but less local. Where's the actual tradeoff curve?
5. **The surplus-transfer handwave.** "Give the extra votes to their second choice" — but *which* ballots are the surplus? Random sample vs fractional (Gregory) gives *different winners*, and this is where real-world complexity, arbitrariness, and manipulability live. The hardest step is the one the cartoon glosses fastest.
6. **Condorcet / center-squeeze failure.** A candidate who beats every rival head-to-head can be eliminated early under STV/IRV. Is "maximize happiness" even the right objective, vs "elect who the majority prefers pairwise"? Different objective → different system; the choice is a *value* judgment, not a fact.

## Toolkit / Vault Position
Reusable moves this review crystallized:
- **The "which reference population?" diagnostic.** When someone argues for *proportionality* (or any aggregate-fairness property), ask *proportional with respect to which body?* If the polity is nested (district/state/nation), the property is **not scale-invariant** and the levels can't be jointly satisfied. Naming the level usually dissolves the argument. (Generalizes the [accounting-identities domain-matching](../economics/accounting-identities-as-domain-matching.md) move to political aggregation.)
- **The "empty-corner" tell.** Advocacy that promises a corner the impossibility theorems forbid — "maximizes happiness" (Arrow), "no point strategizing" (Gibbard–Satterthwaite) — is laundering a value choice as a theorem. The format (here, a friendly cartoon) is what hides the missing impossibility floor.
- **"States pick presidents, not 'the people' — always have" (Chris's illustration).** A one-liner that surfaces the bounded-area design hiding under "majority rule": presidential selection is state-mediated, and the Electoral College number itself encodes the blend — **538 = 435 (House, proportional) + 100 (Senate, equal-state) + 3 (DC)**. The non-proportionality is the design, not a defect.
- **The blend resolves "which equality?"** Because no single fairness-equality is groundable as *the* one (Arrow / scope / "unfair to whom?"), a mature constitution **institutionalizes several at once and balances them** (proportional House + equal-state Senate = the Connecticut Compromise). That's the founders' answer to the question Grey skips — and the constructive close to this review's Open Q3.
- **Vault position:** the choice of voting system is **irreducibly normative** (which fairness property do you sacrifice?), *not* a technical optimum. FPTP's pathologies are real (directional truth); STV is a real but *scope-bounded* improvement; "STV is THE fair system, suppressed by cowards" is the discrete-destination overshoot. This is [game-theory-as-normative](../../notes/game-theory-as-normative-not-descriptive.md) applied to social choice. Promoted into [government-formation.md](../philosophy/morality/legal-theory/government-formation.md) (the impossibility-floor + scope subsection).

## Vault Connections
- [Government Formation](../philosophy/morality/legal-theory/government-formation.md) — owns Duverger's Law; now also the impossibility-floor + scope-of-proportionality home this review feeds (two-way ledger).
- [Game Theory as Normative, Not Descriptive](../../notes/game-theory-as-normative-not-descriptive.md) — voting is mechanism design; impossibility theorems mean the "best" system imports value choices, not math.
- [Convergence Is a Process, Not a Destination](../../notes/convergence-as-process.md) — "maximize happiness" presumes a stance-independent optimum that doesn't exist.
- [Directional Truth and the Discrete Trap](../../notes/directional-truth-and-the-discrete-trap.md) — STV sold as a discrete destination overshoots the directional truth ("FPTP has bad pathologies").
- [Scope Confusion](../philosophy/morality/scope-confusion.md) — "which proportionality?" is the level/scope error at the heart of Grey's proportionality pitch.

## Open Questions
- **Surplus-transfer strategy mechanics** — we named that random-sample vs Gregory vs Meek give different winners; we did *not* work a concrete profile showing a *strategic* exploit of the chosen rule. Worth a worked example if this ever needs to be airtight.
- **Was Gibbard–Satterthwaite persisted before?** Chris recalls it from a prior conversation; a full-vault grep finds it **only** on this page (not in `government-formation.md` or elsewhere) — so it was conversational and is now first persisted here. Flag in case a buried/discarded page resurfaces.
- **The normative criterion choice** — *(largely resolved in discussion)* the answer isn't "pick the one true criterion" but **blend competing equalities across institutions** (proportional House + equal-state Senate; the Electoral-College arithmetic). The founders' bicameral/EC design is the worked answer to the question Grey skips. What's still genuinely live: how a *single-body* election (where you can't split the blend across two chambers) should weight locality vs proportionality — STV is one such single-body compromise, just an oversold one.

## Tags
[game-theory](../../tags/game-theory.md), [politics](../../tags/politics.md), [scope-confusion](../../tags/scope-confusion.md), [debates](../../tags/debates.md)
