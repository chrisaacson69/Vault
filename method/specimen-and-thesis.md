---
status: active
created: 2026-06-08
---
# Specimen & Thesis — The Two-Altitude Ledger
> Vault work lives at **two altitudes**: a **specimen** (a bounded, dated, source-anchored artifact — a debate review, a game project, a transcript study) and a **thesis** (a portable, source-independent idea the specimen feeds or tests). Keep them in **separate pages** — the separation is correct, not a leak. Connect them with a **two-way ledger**. The downward half of that ledger (thesis → its specimens) is the half that rots, and three failure-clusters prove it.

**Links:** [The Anchor Method](./anchor-method.md) (this is the developed form of its "seam discipline" bullet), [Force Doctrine — The Theory](../research/philosophy/morality/force-doctrine.md) (the specimen that does it right), [Online Debates](../research/debates/README.md) · failing clusters: [Monopoly frontier theory](../research/gaming/monopoly/frontier-trade-theory.md), [MoO optimal strategy](../research/gaming/moo1/optimal-strategy.md), [MoM tier system](../research/gaming/master-of-magic/tier-system-and-mirr.md)

> Discovered, not designed — surfaced by auditing why a "lost" debate discussion turned out to be *correctly promoted* to a separate theory page, then stress-tested against three game clusters that all failed the same way.

## The two altitudes

| | **Specimen** | **Thesis** |
|---|---|---|
| Answers | "what is *this particular thing*?" | "what's true *in general*?" |
| Anchored to | a source (video, repo, transcript), dated | nothing external; portable |
| Lifecycle | **frozen** once reviewed | **accretes** across many specimens |
| Lives in | `debates/`, `projects/` | `research/`, `philosophy/`, `method/` |
| Example | `wilson-rights-dont-exist-only-force.md` | `force-doctrine.md` |

The instinct to fold everything into the specimen ("the discussion went missing!") is wrong — the discussion's *portable* content was **promoted to its proper altitude**, which is a feature. A specimen is **evidence**; a thesis **cites evidence**. Different jobs, different pages.

This is the same shape as **atomic skills**: one idea per page, ledgered to its evidence, pointed at by everything that needs it — easy reference, no duplication. A thesis page is to its specimens what a skill is to its callers.

## The two-way ledger (the connective tissue)

Separation is automatic (different folder, different altitude). **Connection is a discipline** — a ledger maintained in both directions:

- **Thesis → specimen (down):** the thesis page lists each specimen that fed or tested it, with a one-line *what this specimen contributes*. The thesis is the **hub**; specimens are **spokes**.
- **Specimen → thesis (up):** the specimen links up to the thesis as the idea it fed/drew from (provenance).

`force-doctrine.md` is the existence proof: it cites all five Wilson debates, each with a contribution line, and every debate back-links up. Fully reciprocal.

## Why the downward half rots — the mechanism

The audit's central finding: **upward links are mostly healthy; the downward ledger is mostly absent.** The cause is structural, not laziness:

> **A hub that predates its evidence never gets the back-link.** When a thesis page is *created as the harvest target* (a "doctrinal spin-off," like `force-doctrine.md`), its author writes the downward ledger by reflex. But when specimens cite a **pre-existing** thesis (`risk-and-entrepreneurship.md`, `battle-value.md`, `bilateral-trade-valuation.md`), nobody goes *back* to the older page to add the reciprocal entry. The loop is left open at the top.

So the rule: **when a specimen cites a thesis, the same edit adds the specimen to that thesis's downward ledger.** Both ends, one move.

## Three operations on the seam

1. **Spawn** (thesis → specimen): a mature idea spins off a project to build/test it. *(Tooled by [vault-to-project](../research/principled-llm-code.md).)*
2. **Harvest** (specimen → thesis): a project/review surfaces a portable idea → **promote** it to a thesis page and wire the ledger. **This is the operation that fails.**
3. **Consult** ("what does the vault think of this?"): run a *new* input against the accumulated theses; record where it confirms, strains, or extends each. This is the [verification-layer thesis](../research/llm-grounding-problem.md) in operation — accumulated state applied to fresh input it didn't generate. The Lance-Bush debate page did it explicitly ("the framework predicts the shape of the conversation").

## The two traps (caught in every failing cluster)

1. **Trapped harvest.** A portable idea left sitting inside a specimen because writing it *there* felt like capture. If it generalizes, it needs its own thesis page (or a home in an existing one). Naming "the canonical home" without doing the move **is** the failure (Monopoly's `frontier-trade-theory.md` does exactly this).
2. **Memory as the release valve.** Writing the idea to auto-memory (`feedback_*`) feels like promotion and isn't — the audit found **four** game-theses that reached memory but never a vault page. Memory is a *recall hint*, not the durable artifact. If it's worth a memory note, it's worth a thesis line too — **do both, and link them.**

**Edge case — external-repo specimens (a seam-breaker, discovered 2026-06-08).** When a project moves to a standalone repo (three did on 2026-06-05), its in-vault page becomes a pointer-stub and the specimen *physically leaves the vault*. Preserve **both** ledger ends anyway: the stub links up, and the thesis lists the **repo** as its specimen *down*. The 2026-06-05 extraction silently severed pygone's only link to its grounding theses (`principled-llm-code`, `repairing-llm-code`) — so extraction doesn't just risk the rot, it *causes* it by default. Re-audit every seam after any extraction.

## Evidence ledger — the four audited clusters

*(This page eats its own dogfood: here is its downward ledger.)*

- **[Debates / Force Doctrine](../research/philosophy/morality/force-doctrine.md) — PASS (the template).** Hub born as the harvest target; five specimens, each with a contribution line; every specimen back-links up. *Contributes: the existence proof, and the "hub-born-as-harvest → reflexive downward ledger" mechanism.*
- **[Monopoly](../research/gaming/monopoly/frontier-trade-theory.md) — PARTIAL.** Has the vault's **best** specimen→thesis backlink (the project README's "Vault ↔ Project Relationship" table) — yet the live-LLM specimen (`llm-agents-across-games.md`) is linked one-way only, and ≥4 explicitly-"generalizable" theses sit trapped in one page. *Contributes: proof that a great **upward** ledger does not save you — promotion and the **downward** half fail independently.*
- **[MoO](../research/gaming/moo1/optimal-strategy.md) — FAIL.** The real hub (`risk-and-entrepreneurship.md`) has an empty downward ledger; the generalized **MIRR / 4X-as-capital-allocation** thesis is trapped in `optimal-strategy.md` even though a *sibling game already depends on it*. *Contributes: the "hub predates its evidence" mechanism in its purest form.*
- **[MoM](../research/gaming/master-of-magic/tier-system-and-mirr.md) — FAIL (mirror-inverse).** Downward sub-page ledger is gold-standard, but the specimen layer lives in an **external GitHub repo** (no in-vault specimen to anchor), and the three best ideas reached `feedback_*` memory but never a vault page. *Contributes: the **memory-as-release-valve** discovery, and the external-repo-specimen edge case.*

## Success test for this method itself

Run it as a **lens** on the vault. It found the gaps (the Monopoly orphan, the MoO empty hub, the MoM memory-valve). The test it must pass: **filling those gaps** makes each affected thesis queryably two-way, and a re-audit finds nothing newly trapped.

**First closed case (2026-06-08).** The MoO/MoM **MIRR** harvest was promoted to [MIRR — 4X Strategy as Capital Allocation](../research/gaming/mirr-4x-framework.md), wired down to its specimens (MoO optimal-strategy + mirr-analysis + the optimizer project, MoM tier-system) and up to its parent `risk-and-entrepreneurship` — whose **empty downward ledger was filled** in the same pass — and an **independent re-audit returned PASS** on all four conditions. The method closed its first case. Remaining backlog: the **shared** capability-without-leverage / hard-counter-to-zero thesis (Monopoly + MoM, still memory-only); the Monopoly live-LLM orphan (`llm-agents-across-games`); the MoM external-repo specimen needing an in-vault pointer.

*A method that names a gap it can't close is just prose* — same bar the [Anchor Method](./anchor-method.md) sets for itself; this one closed its first.

## Tags
[methodology](../tags/methodology.md)
