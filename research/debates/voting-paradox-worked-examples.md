---
status: active
created: 2026-08-20
published: true
layout: layouts/page.njk
title: "Worked Examples — The Impossibility Floor, With Arithmetic"
---
# Worked Examples — The Impossibility Floor, With Arithmetic
> Eight machine-checked ballot profiles that make the social-choice pathologies concrete, built for the [CGP Grey STV refutation](./cgp-grey-stv-too-good.md). **Two separate attacks, deliberately not blended:** *(A)* **impossibility** — no method satisfies every desideratum, so "the fair system" names a corner the theorems forbid; and *(B)* **underdetermination** — "STV" is not one rule, and the implementation choices the cartoon skips *decide the winner*. Attack B is the stronger one for a video and the one nobody makes. Headline result: **identical ballots, four ordinary rule-sets, three different councils.** Every number here is computed by [`tools/voting-paradoxes.py`](../../tools/voting-paradoxes.py) and re-derived on every `--selftest` run — none of it is asserted.

**Tool:** [`tools/voting-paradoxes.py`](../../tools/voting-paradoxes.py) — `--selftest` re-derives all eight claims from the raw ballots and exits non-zero if any stops holding. `--report` prints the tables below.
**Links:** [CGP Grey — "Too Good for Politicians to Allow" (STV)](./cgp-grey-stv-too-good.md) (**the parent review — this page is the arithmetic its Open Questions asked for**), [Government Formation](../philosophy/morality/legal-theory/government-formation.md) (Duverger + the impossibility floor), [Aggregation vs. Sorting](../philosophy/morality/legal-theory/aggregation-vs-sorting.md), [Game Theory as Normative, Not Descriptive](../../notes/game-theory-as-normative-not-descriptive.md), [Scope Confusion](../philosophy/morality/scope-confusion.md), [The Load-Bearing Word](./the-load-bearing-word.md)

> **Method page.** Not a transcript review — a reusable evidence bank. Built for a planned
> refutation video, so each example is stated in the form a hostile viewer would have to answer.

---

## 0. Precision first — don't fight looseness with looseness

The charge against the video is that it is **loose about the rules that let a candidate advance**. That charge is only survivable if the refutation is *tighter*, so every example below is labelled with **which result it actually demonstrates**. Bundling all of these under "Arrow's law" is the single most common way an otherwise-correct critique gets dismantled on camera.

| Result | What it actually says | Which examples below |
|---|---|---|
| **Arrow (1951)** | No ranked method over ≥3 alternatives can have universal domain + Pareto + **IIA** + non-dictatorship | §2 — **only this one is literally Arrow** |
| **Gibbard–Satterthwaite (1973/75)** | Every non-dictatorial deterministic method over ≥3 alternatives is **manipulable** | §5 |
| **Moulin (1988)** | No Condorcet-consistent rule satisfies **participation** for ≥4 candidates | §4 |
| *Monotonicity* | a **criterion**, not a theorem — IRV/STV simply fail it | §3 |
| *Condorcet criterion* | a **criterion** — elect the pairwise-beats-everyone candidate if one exists | §2 |
| *Majority criterion* | a **criterion** — Borda fails it | §7 |
| **Underdetermination** | not a theorem at all — an **empirical fact about the statute** | §6, §6a, §6b |

**The rhetorical order that works:** lead with §6 (the rules decide the winner — concrete, no theory needed), then §1 (five methods, five winners — no theory needed either), and only *then* name the theorems as the explanation for why this is unavoidable rather than a fixable bug. Theory last.

## 1. One electorate. Six methods. Five different winners.

111 voters, one fixed set of sincere preferences. Nobody changes their mind; only the counting rule changes.

| Voters | Ranking |
|---:|---|
| 16 | C > B > E > A > D |
| 12 | C > E > D > A > B |
| 12 | E > A > D > C > B |
| 22 | A > E > B > C > D |
| 30 | D > B > E > C > A |
| 19 | B > A > C > E > D |

| Method | Winner |
|---|---|
| Plurality (FPTP) | **D** |
| Two-round runoff | **C** |
| IRV / RCV | **A** |
| Borda | **E** |
| Coombs | **B** |
| Condorcet | **B** |

**Five of the five candidates win under some perfectly ordinary rule.** And a Condorcet winner *does* exist here (B), so the excuse "there was no majority will to find" is unavailable — there was a pairwise-dominant candidate and four of six methods missed him.

**The line this example buys:** *"the electorate did not decide this election — the rulebook did."* That is the whole impossibility argument in one table, before a single theorem is named.

## 2. Arrow proper — an irrelevant alternative flips the winner

96 voters. This one profile is a **double**: an IIA violation *and* a Condorcet failure, which is the [Alaska 2022 center-squeeze](./cgp-grey-stv-too-good.md) shape in miniature.

| Voters | Ranking |
|---:|---|
| 40 | A > B > C |
| 37 | C > B > A |
| 19 | B > C > A |

IRV rounds: `A=40, B=19, C=37` → B eliminated → `A=40, C=56`. **IRV elects C.**

Now delete **A** — a *loser*, who won nothing — and re-count the same ballots:

**IRV elects B.**

Not one voter changed their B-vs-C ranking. The winner still flipped, because A's presence determined *who got eliminated first*. That is exactly the independence condition Arrow proved cannot be kept.

And in the same profile: **B beats A head-to-head, and B beats C head-to-head** — B is the Condorcet winner — while **A is the Condorcet loser** yet survives to the final round. The squeezed centrist dies first because first preferences, not pairwise strength, decide elimination order.

## 3. Non-monotonicity — helping your candidate hurts your candidate

67 voters. C wins.

| Voters | Ranking |
|---:|---|
| 18 | B > C > A |
| 12 | C > B > A |
| 8 | C > A > B |
| 29 | A > B > C |

Rounds: `B=18, C=20, A=29` → B eliminated → C=38, A=29. **C wins.**

Now **12 of the A-first voters change their minds and promote C to first** (A > B > C becomes C > A > B). Nothing else changes; the electorate is the same size; C is *strictly more popular* than before.

| Voters | Ranking |
|---:|---|
| 18 | B > C > A |
| 12 | C > B > A |
| 20 | C > A > B |
| 17 | A > B > C |

Rounds: `B=18, C=32, A=17` → **A** is now eliminated instead of B → A's 17 flow to B → B=35, C=32. **C loses.**

Gaining 12 first-preference votes cost C the election. The selftest verifies mechanically that the *only* difference between the two profiles is C moving **up** on 12 ballots.

**Why it matters beyond the curiosity:** this is the formal death of *"there's no point in strategizing about how everyone else votes."* If raising a candidate can defeat them, then sincere ranking is not weakly dominant, and a voter who knows the polls has something to compute.

## 4. The no-show paradox — voting makes you worse off

118 voters elect **C**. Then 9 more voters turn up whose sincere ranking is **B > D > C > A**.

| Voters | Ranking |
|---:|---|
| 21 | D > A > B > C |
| 33 | C > D > A > B |
| 16 | B > D > A > C |
| 21 | C > B > D > A |
| 27 | A > B > C > D |

- They **abstain** → **C** wins. They rank C *third*.
- They **vote** → **A** wins. They rank A *last*.

By casting sincere ballots they replaced their 3rd choice with their 4th. Staying home was strictly better. (Verified tie-break-free in both counts, so it is not an artefact of a coin-flip rule — a detail worth stating pre-emptively, because it is the first thing a critic will reach for.)

This is **Moulin's theorem**, not Arrow: no Condorcet-consistent rule can guarantee that participating never harms you, once there are four or more candidates.

## 5. Gibbard–Satterthwaite — burying your own favourite pays

100 voters, three candidates: Left, Centre, Right.

| Voters | Sincere ranking |
|---:|---|
| 35 | Right > Centre > Left |
| 33 | Left > Centre > Right |
| 32 | Centre > Left > Right |

Everyone sincere → Centre is eliminated first (32, fewest) → Centre's votes flow to Left → **Left wins.** The Right bloc gets its *worst* outcome.

Now **6 Right voters lie**, ranking Centre first (Centre > Right > Left):

| Voters | Reported ranking |
|---:|---|
| 29 | Right > Centre > Left |
| 6 | **Centre > Right > Left** |
| 33 | Left > Centre > Right |
| 32 | Centre > Left > Right |

Right (29) is now eliminated first, its votes flow to Centre, and **Centre wins** — which those 6 voters prefer to Left. **Betraying their own favourite got them a better result.** Electorate unchanged; only the reported rankings moved.

This is the concrete form of the claim the video denies outright. Gibbard–Satterthwaite says such a profile exists for *every* non-dictatorial deterministic method — so this is not a flaw of IRV that a better ranked system fixes.

## 6. THE HEADLINE — same ballots, same voters, three different councils

This is the direct answer to *"the video is loose about the rules that let a candidate advance."* Not a paradox, not a theorem: just **four combinations of two implementation choices that real jurisdictions actually make**, applied to one identical set of ballots.

- **Quota** — *Droop* (⌊V/(S+1)⌋+1) or *Hare* (V/S). Both are in real use.
- **Surplus transfer** — *Gregory* (fractional: all of the winner's ballots move at reduced weight) or a *whole-ballot sample* (a subset of physical ballots moves at full weight). Both are in real use; several jurisdictions have drawn the sample **at random**.

172 voters, 3 seats:

| Voters | Ranking |
|---:|---|
| 22 | C > B > A > D > E |
| 35 | A > B > D > E > C |
| 18 | C > B > E > A > D |
| 29 | C > E > B > D > A |
| 31 | C > E > A > B > D |
| 37 | C > B > A > E > D |

| Quota | Surplus rule | Council elected |
|---|---|---|
| Droop | Gregory | **B, C, E** |
| Droop | Whole-ballot | **A, C, E** |
| Hare | Gregory | **A, B, C** |
| Hare | Whole-ballot | **B, C, E** |

**Three different three-member councils from one set of ballots.** Every voter's preferences are identical in all four counts. What changed is a paragraph of statute that the cartoon covers with the phrase "their surplus votes get transferred."

### 6a. The quota alone decides it

Surplus rule held fixed at Gregory; only the quota changes:

| Quota | Council |
|---|---|
| Droop | **A, B, D** |
| Hare | **A, D, E** |

### 6b. The surplus-transfer rule alone decides it

Quota held fixed at Droop; only the transfer method changes:

| Transfer | Council |
|---|---|
| Gregory (fractional) | **B, D, E** |
| Whole-ballot sample | **B, C, D** |

**Why this is the best material for a video.** It needs no theorem, no counterintuitive paradox, and no social-choice literacy from the audience. It says: *you cannot advocate "STV" — there is no such single thing. Name your quota and name your surplus rule, because those choices, not the voters, picked the third seat.* And it lands precisely on the gap the review already identified — the mechanism the cartoon glosses fastest is the most consequential one.

The random-sample variant sharpens it further: where the surplus is drawn by lot, **a recount of the same ballots can seat a different person.** That is not a paradox about voters. It is a property of the statute.

## 7. Majority-criterion failure — Borda overrides an outright majority

Found by the selftest itself, as a *failed sanity check* — which is the best provenance an example can have.

| Voters | Ranking |
|---:|---|
| 60 | A > B > C |
| 40 | B > C > A |

A holds an outright **60%** first-preference majority. Plurality, runoff, IRV, Coombs and Condorcet all elect A. **Borda elects B** (A: 120, B: 140).

Useful as the fairness-pluralism example: Borda is not broken, it is optimising something else — mean rank rather than majority support. Which is the point. *"Fair" has no single referent*, so "the fairest system" is a category error, and every method is an answer to a question the advocate usually declines to state.

## 8. How to deploy these

- **Lead with §6, not Arrow.** The rules-decide-the-winner table needs no theory and cannot be answered by "well, no system is perfect" — because it is not a claim about systems, it is a claim about *this* system being underspecified.
- **Then §1.** Five winners, one electorate. Still no theory.
- **Only then the theorems**, and *name them correctly* (§0). The theorems explain why §1 and §6 are permanent rather than fixable — that is their job in the argument, and it is the last job, not the first.
- **Pre-empt the tie-break dodge.** §4 is verified tie-break-free precisely because "that's just an artefact of your tie-breaking rule" is the standard escape.
- **Concede what's true.** FPTP's pathologies are real; STV *is* a genuine improvement on several axes. The target is the **oversell** — "maximizes happiness," "no point in strategizing," "too good to allow" — not the mechanism. The [parent review](./cgp-grey-stv-too-good.md) already establishes that the strongest version of this critique is scope-bounded, and overreaching here would hand back the advantage.
- **Keep IRV and STV distinct.** Single-winner IRV and multi-winner STV share an engine but not a failure profile; §2–§5 are single-winner results and §6 is multi-winner. Blurring them is the same looseness being criticised.

## 9. Open questions

- **§6 uses a deterministic stand-in for the random draw.** The `whole` transfer rule here takes the last-arriving ballots rather than a genuine random sample. That is enough to prove *the rule matters*, but a true Monte-Carlo over random draws would let the page state a **distribution of councils** from one ballot set — a strictly stronger and more filmable claim. Worth doing before a video.
- **Batch elimination is unmodelled.** Some jurisdictions eliminate several trailing candidates at once to save rounds. That is a third implementation lever and almost certainly changes winners too; it is not yet in the tool.
- **Ballot truncation.** All profiles here are fully ranked. Real ballots are truncated and exhaust, which is where much real-world RCV controversy lives (exhausted ballots mean winners with less than a true majority of ballots cast). Not yet modelled.
- **Is there a profile where all six methods give six different winners?** The search found five. Six should exist with more candidates; not yet located.

## Tags
[politics](../../tags/politics.md) · [philosophy](../../tags/philosophy.md) · [debates](../../tags/debates.md)
