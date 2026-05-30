---
status: active
created: 2026-05-29
---
# Practicality vs. Precision — Legacy Slop and Principled LLM Code
> Software has always traded correctness for shippability, and the slop fossilizes. LLMs trained on that corpus inherit the median. But the LLM also collapses the cost of refactoring — which, for the first time in 35 years, threatens the economics that made "worse" win.

**Links:** [AI History — A Personal Arc](./ai-history-personal.md), [The Context Cache Hierarchy](../notes/context-cache-hierarchy.md), [Claude Code Skill Engineering](../notes/claude-code-skill-engineering.md), [LLM Grounding Problem](./llm-grounding-problem.md), [Planner-LM Composites](./planner-lm-composites.md), [Conservation of Complexity](../notes/conservation-of-complexity.md)

## The thesis in one line

Getting an LLM to write *principled* code instead of "stuff that kinda works" is not a training-data problem you wait out — it's a **persistence** problem you solve now, and the economics just tipped in its favor.

## 1. The fossil record is real

Code written under the constraints of one era doesn't die when the constraints lift — it fossilizes into the next layer. Early developers cut corners to fit memory and speed limits; those corners are still load-bearing decades later.

- You **cannot** name a file `CON`, `PRN`, `AUX`, or `NUL` in Windows 11. Those are reserved device names from MS-DOS 1.0, themselves inherited from CP/M (~1974). A 50-year-old shortcut, still enforced.
- The x86 still boots in 16-bit real mode. The A20 gate, the 2038 problem, DOS path semantics — strata, not bugs-of-the-moment.

The intuition "a bug in MS-DOS might still be in Windows 11" is **literally, verifiably true**. Software is geology: every layer carries the compromises of the one beneath it.

## 2. "Practicality won the day" has a name: worse-is-better

This isn't a vague lament — it's [Richard Gabriel's *worse-is-better*](https://www.dreamsongs.com/RiseOfWorseIsBetter.html) (1989). The simpler-but-incomplete "New Jersey" lineage (Unix, C) out-propagated the correct-but-complex "MIT/Stanford" lineage (Lisp, "the right thing") **because it was easier to ship and spread.** DRY, N-tier, OOP/OOD, proper async — all sensible, all routinely lost to "just make it work."

The crucial point: **worse-is-better was never an aesthetic claim. It was an economic one.** Correctness was expensive; practicality was cheap; the cheap thing dominated. Hold that — section 5 turns on it.

This is the same law as the **rubber-banding / friction pattern** — *"good enough at lower friction beats better at higher friction."* 2600-vs-Intellivision, USB-A-vs-C, AWS-vs-datacenter, and worse-is-better are **one dynamic in four domains.** The friction thesis doesn't just lament the slop; it *predicts* it.

## 3. The accretion failure mode (what I watched happen today)

Start from a simple idea, expand outward, never refactor. What's left is a pile of **one-use tools, not an integrated system.** This has a name too — Foote & Yoder's *Big Ball of Mud*.

The LLM workflow **amplifies** it structurally: each session adds locally, with no global view of the whole, so entropy only ever increases. Greenfield → expand → never integrate is the *default* trajectory unless something external holds the whole-system map.

## 4. LLMs inherit the median — but it's a default, not a ceiling

The weak framing: "LLMs are trained on erroneous code, so they carry it forward." True but shallow. The model isn't *stuck* at corpus quality — it regresses to corpus **median per session**, because nothing in a fresh session holds the standard higher.

This is the **verification-layer thesis** applied to code: sessionless models produce median output for the same reason sessionless *anything* fails — no accumulated state enforcing the bar. The same weights that emit slop will emit DRY, N-tier, properly-async, integrated code **when the architecture is pinned in persistent context.** Slop is a prior problem, not a capability problem.

## 5. The inversion — the part that's actually new

Worse-is-better won for 35 years on an *economic* argument: correctness cost too much to be worth it. **The LLM collapses the cost of refactoring.** Change the economics and you change the winner.

This is the first genuine challenger to worse-is-better since 1989 — not because anyone got more disciplined, but because the price of "the right thing" fell through the floor. Tech-debt repair that used to take a week now takes an afternoon.

**The catch:** cheap refactoring with no persistent spec to refactor *toward* is just cheap thrashing — faster slop. So the cost collapse makes the persistent-architecture layer *more* essential, not less. The two halves snap together:

> Cheap repair **+** a pinned architecture = "the right thing" finally becomes affordable.
> Cheap repair **alone** = slop at higher velocity.

## 6. The trap: don't chase "perfect"

The urge to take a big project and refactor until it's *perfect* is itself a known failure — second-system effect, gold-plating. Worse-is-better's revenge: sometimes the slop that "kinda works" genuinely **is** the right tradeoff.

So the thesis is not "always principled." It's **"hold the architecture in persistent state, and spend precision where the binding constraint rewards it"** — the *binding-constraint-determines-depth* lens. Architecture is necessary but not sufficient; the binding constraint decides whether the investment returns. A page that said "always avoid slop" would be wrong.

## Open questions

- What's the minimum persistent spec that actually holds an LLM to principled code across sessions — a `CLAUDE.md` architecture section? A living ADR log? A test suite as the real spec?
- Can the LLM be made to *propose* refactors continuously (entropy-reduction pressure) rather than only on request — turning section 3's default trajectory around?
- How do you detect drift in the *generated codebase* the way [The Context Cache Hierarchy](../notes/context-cache-hierarchy.md) detects drift in the *memory layer*? Same eviction-policy question, different substrate.

## Tags

[ai](../tags/ai.md), [history](../tags/history.md), [software-engineering](../tags/software-engineering.md)
