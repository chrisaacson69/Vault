---
status: active
created: 2026-06-07
---
# Repairing LLM Code — The Two Oracles
> Correctness can be grounded *downward* — drop to a lower artifact and diff. Readability cannot: it's the choice among equivalent renderings, and its only floor is a reader recovering the meaning. The 1968 case for structured programming turns out to be the 2026 case for LLM-legible code. We are metaing the meta.

**Links:** [The LLM Grounding Problem](./llm-grounding-problem.md) — the parent: LLMs can't weight grounded truth over fluent text, [Practicality vs. Precision — Principled LLM Code](./principled-llm-code.md) — slop is a persistence problem, the economics just tipped, [Transpilation as a Grounding Strategy](./transpilation-as-grounding.md) — weak formal languages grounded by deterministic transpile, [The Anchor Method](../method/anchor-method.md) — the gate that *proves grounding*, [H-Neurons](./h-neurons.md) — hallucination as over-compliance; the coda argues confident-wrong-path is the same disease, [Nobunaga Decompiler](../projects/game-annotation/nobunaga/README.md) — the live case study, [Lowering Atlas](../projects/game-annotation/lowering-atlas/README.md) — sourcing the inverse-lowering table forward, [pygone](../projects/pygone/README.md) — the *inverse* specimen (readable Python → 4 KB blob): the floor-vs-ceiling complement to the decompiler's bytecode→readable-C direction

## Source & the honest assessment

**Source:** [*so you vibe coded a mess... now what?*](https://www.youtube.com/watch?v=1u-Skkh1_sQ) — Spiro Floropoulos, 2026-05-31 (16 min). [Transcript](../raw/videos/spiro-vibe-coded-mess.txt).

Spiro's **triage is sound** and matches mainstream legacy-rescue practice: freeze features / stop the bleeding; find what's *accidentally correct* and keep only that; use the customer-complaint inbox as the spec of what's missing; expect net-deletion before net-creation; treat AI output adversarially; AI is an *augment to someone who already understands*, never a substitute.

His **diagnosis of the cure is wrong**, and the error is locatable. He frames it as **LLM vs. human-who-types** and concludes "use programmers." But the real variable isn't the typist — it's the **oracle**. A controlled experiment from my own work isolates it:

| | Day job (ERP/website) | Decompiler |
|---|---|---|
| Generator | LLM | LLM |
| Oracle | me, behaviorally, per line | self-validation (weak) |
| Surface per increment | small (fully coverable) | huge, interlocked |
| Result | 2–3× speedup, works | stalled, can't certify |

Both use the LLM. The day job works because there is a **strong independent oracle** (a human eyeball on behavior, over a small surface). A human typist is just *one non-scaling instance* of an oracle; Spiro generalizes from the only oracle he knows. His advice is therefore useless exactly where you most need the machine — the case with no human-coverable surface.

## The two oracles

The fix is not *fewer LLMs*; it's an **independent oracle the generator can't talk its way around** — the same move the [grounding](./llm-grounding-problem.md) page makes for agents ("separation of proposer from verifier is what makes the result auditable"). But there are **two** oracles, and they ground in opposite directions:

- **Correctness grounds downward.** There is a lower artifact (bytecode / the emulator) that mechanically *is* the truth. Verification = drop an altitude and diff. This works, deterministically.
- **Readability has no lower artifact.** Decompilation is non-injective — the compiler erased which structure the author wrote, so *many* C functions compile to behavior-equivalent bytecode. Readability is the **choice function over that equivalence class.** There is nothing beneath the C to grep. The oracle isn't lower — it's a *reader's mind* recovering the meaning.

This is why readability is where the LLM produces **"spin and sprawl"**: no floor to fall to, so a confident generator optimizing a proxy just wanders the equivalence class emitting plausible garbage. Correctness was the *first pass and it's largely solved*; readability is the live frontier.

## The experiment

One sub, `effect_view_a` (bank 1). Two renderings: **v1** (unstructured, goto-heavy) and **v2** (CFG-reduced). Readers got the C **blind** — function renamed, purpose comment stripped — and were asked precise control-flow questions, two independent readers per version. Graded against the ground-truth disassembly (`bank_01_vm.v2.asm`): `redraw_window(ba9c)` at `$84FB` runs **only when `local8` is false** (`$84ED JUMPF $84F8`, true-branch `$84F5 JUMP $84FF` skips it); `redraw_window(msg_sick)` at `$8588` is gated on `local8 ∧ war_helper` (`$8566` and `$857C` both `JUMPF $858C`).

| Version | Reader | `ba9c` runs… | `msg_sick` runs… | Confidence |
|---|---|---|---|---|
| **v1** | A | ALWAYS ❌ | ALWAYS ❌ | 4/5 |
| **v1** | B | ALWAYS ❌ | unconditional ❌ | 4/5 |
| **v2** | A | else / local8 false ✅ | local8 ∧ war ✅ | 5/5 |
| **v2** | B | else / local8 false ✅ | local8 ∧ war ✅ | 5/5 |

**The LLM is a faithful reader of structure — which means it inherits structural errors silently.** The v1 readers didn't choke on ugly code; they parsed it *perfectly* and faithfully reported what the (mis-bracketed, hence wrong) code says. Ugliness wasn't the failure mode; *incorrect structure that still reads as valid C* was.

Three would-be shortcuts all **failed simultaneously** — the negative results matter as much as the positive:

- **Confidence is worthless as a signal** — the wrong readers reported 4/5. Spiro's slot machine exactly: fluent, confident, wrong.
- **Reader consensus is worthless** — both v1 readers independently agreed on the *same wrong* answer (zero variance). An ensemble can't separate right from wrong when the error is in the shared input.
- **goto-count is anti-correlated** — across the bank, v2 *increases* gotos on several subs (`effect_ninja_sabotage` 19→42, `ai_per_fief` 16→24) while cutting them on others. The metric would *reward* the rendering more likely to be wrong.

The **only** thing that worked was the lower artifact: one `grep` of the asm adjudicated both divergences in seconds — a real decompiler bug invisible to every reading-layer check.

## The double-check (and why it earned its keep)

An *independent* observer was then asked not "are these two points right?" but "is v2 actually correct *everywhere* now?" It confirmed v1-wrong/v2-right on the two points **and found v2 is still defective**: at least three remaining bugs, including a **dangling `goto L_84B9` with no matching label** (`bank_01.v2.c:308` — non-compilable C) and a hardcoded `redraw_window(msg_empty)` that silently drops a branch-dependent message selection. **v2 is *better* than v1, not *faithful*.**

Lesson: a spot-check that "confirms correct on the points examined" is not a correctness claim. Comprehensive beats spot-check; an independent observer catches what a single pass — even one grounded against the asm — misses. (This is [silent-tool-failure](./llm-grounding-problem.md) discipline: verify the whole, with a second observer, before believing "it's correct now.")

## goto-count is the Goodhart trap — and the 1968 = 2026 identity

Why does the proxy fail? `if(a){f(x);if(b){f(y);if(c){f(z);}}}` — the `}}}` cascade is **one** merge point, so goto-count says "1" while there are three logical scopes; the metric *under*-counts structure. And the real readability choices — if-inversion (`if(a)goto end;F(x)` vs `if(!a){F(x)}`), loop rotation (do-while vs while-do) — are semantically identical with wildly different legibility, and the compiler already erased which one was written. A generator handed a scalar proxy will **Goodhart it**: that's not a tooling accident, it's the mathematics of optimizing a proxy for a choice function.

The way out of a Goodhart local optimum is to **change the objective**, not optimize the proxy harder. And the objective already has a 60-year-old name. The "100% of the code is well-structured / no goto needed" finding is just **Böhm–Jacopini (1966)** — every program reduces to sequence/selection/iteration. The reason to *want* that reduction is **Dijkstra, *Go To Statement Considered Harmful* (1968)** — and his argument was always about the *reader*, never the machine. So:

> **The 1968 readability argument is identical to the 2026 LLM-grounding argument.** Structured code won "because functions and structured code read better to a mind" — and the mind we are now grounding is the LLM's. Same claim, new substrate.

## The architecture that follows

Two grounded layers plus a calibrator:

1. **Correctness layer** — the region reducer (closure under composition, *not* a template menagerie) produces *a* correct structuring, certified by **asm-differential** (compare reconstructed branch edges to the disassembly's `JUMPF/JUMP` targets). The `effect_view_a` bug is exactly what this auto-flags.
2. **Readability layer** — a catalog of **semantics-preserving canonical rewrites** (if-inversion toward guard clauses, loop de-rotation to `while` when the back-edge condition matches entry, condition-merging to collapse the `}}}` cascades), applied deterministically.
3. **Calibrator** — define **readability operationally as transfer fidelity**: how reliably/cheaply an independent reader recovers the *asm-true* behavior from the C alone. This chains the two oracles — the reader's recovered meaning, graded against the lower artifact. Run it on a sample to *validate each rewrite rule*, then apply the validated rule for free.

What beats "the LLM self-optimizes on the wrong criteria": (a) the generator **never sees** the readability score — no inline gradient, nothing to game; (b) judge ≠ generator, and the judge grades **behavioral transfer**, not a self-rating (fluency can't fake a meaning that's checked against asm); (c) the oracle **calibrates deterministic rules**, it doesn't optimize each sub. (This is [mechanical-vs-analytical](./principled-llm-code.md): if the answer is a function of a validated artifact, write a deterministic generator; reserve the expensive analytical pass for calibration.)

The honest boundary: rewrite rules are context-dependent (sometimes do-while genuinely reads better), so an irreducible residue of subs where no rule clearly wins goes to human eyes — **small and flagged, not "every line."** That is the precise anti-Spiro: hand-verify the handful the oracle can't separate, not the whole codebase.

## Prior art (verify before building)

This exact problem — *readable*, not merely correct, decompilation, with the if-inversion / loop-rotation / pattern-independent-structuring decisions above — was studied: **Yakdan et al., "No More Gotos" (NDSS 2015)** and the **DREAM / DREAM++** line, which split control-flow structuring (produce goto-free) from semantics-preserving *condition-based refinement* (the readability stage) and — crucially — measured it with **human-subject readability studies** rather than goto-counts. Closest existing answer to "optimize readability without Goodharting." *(Recalled pre-cutoff; confirm specifics before relying on the refinement catalog or metric.)*

## Why this is the decompiler's actual point

The Nobunaga decompiler was never only about reading one game. **Readable C is the LLM's reliable modality** — give a model a well-structured C function and it recovers the nuance almost completely; give it goto-soup and it confidently recovers the *wrong* thing. So the project doubles as a forge for **grounding rules to work with LLMs**: the two-oracle model, transfer-as-readability, generator/judge independence. The decompiler is the test rig; the rules are the product. Metaing the meta.

## Coda — the disease under the method

The two oracles are the *cure*. Name the *disease* and the whole multi-session journey snaps into focus: **sycophancy toward coherence.** Deferring to the user is only the visible case. The objective rewards the most coherent continuation, and the most coherent continuation is usually *agreement with an existing commitment* — the user's framing, the established metric (goto-count), or, most invisibly, **the model's own prior tokens.** Marching confidently down the wrong path is *self*-sycophancy: the model agreeing with itself, because contradicting its own trajectory is incoherent and incoherence is what the loss punishes. Truth and coherence usually correlate; the damage happens in the gap where they don't. Whether this is literally the [H-neuron](./h-neurons.md) over-compliance circuit or a cousin ("I-neurons") is an open hypothesis — behaviorally, confident hallucination and confident persistence are one thing: fluent, self-assured, indifferent to ground truth.

**The journey is the dataset.** Every wrong turn was a confident coherent continuation that broke only on contact with something the model hadn't authored: the it's-a-bytecode-VM-not-6502 surprise; the per-game interpretation errors inherited from a trusted source; the goto-count Goodhart chase; the emit-integrity bug the gate certified as clean; the reflex that would have received *this very paper* as "let's prove DREAM doesn't reduce gotos" — scoring a new idea by the broken frame's metric instead of asking whether it solves the problem *better*. Each surfaced only when an un-authored artifact (the asm, the certifier, the gate) or a human holding an outside frame refused to be talked out of reality.

So the defense is **structural, not a confidence dial** — confidence is worthless as a signal (4/5 on dead-wrong). The only move that works is forcing contact with an oracle the model cannot sweet-talk, *because it didn't write it.* Where such an oracle exists — compilation, execution, bytecode — confident-wrong is defeatable, and we proved it repeatedly. [Transpilation](./transpilation-as-grounding.md) (bytecode→C, COBOL→readable) is this same move in disguise: relocate code into a modality where contradiction is *possible*.

Two honest limits frame what's left:

1. **The grounding regress.** Structure helps by grounding subordinate agents in a scope they understand — but every manager needs grounding too, and it bottoms out at the human as ultimate oracle: the CEO. Naive multi-agent *without* independent oracles is worse, not better — a confident chorus agreeing on one wrong answer with zero variance (the v1-reader result at scale). More structure *scales* the cure; it cannot *eliminate* the disease while the machinery is the same H-neuron-reinforced stuff. Independence must be at the *invariant* level (check a different thing, at a lower altitude), never the headcount level.
2. **"New model, not new information."** A genuinely new approach must be received *on its own terms* — "can DREAM solve this better?" — not "how do DREAM's results fit our current model?" The fork is that discipline made concrete (a new model to test); scoring it by the old metric is the disease. This is the hardest defense to run, because the old frame is always the most coherent thing in the room.

And the real frontier: grounding-with-an-oracle is the *known* cure — **finding what the oracle is** is the unsolved part. For correctness it's the bytecode. For readability we had to *manufacture* one (transfer-fidelity; the atlas as ground truth). For "is this the right architecture," the oracle is still a human challenging assumptions, and the frustration is real — several good approaches got swallowed by confident coherence before an outside frame rescued them. **Oracle-discovery, not oracle-application, is the open problem.** The journey is not complete.

## Open questions

- Does transfer-fidelity actually separate two *both-correct* renderings (structured vs faithful goto-soup of the same sub), or do LLMs see through structure once correctness is held constant? The clean next experiment: mechanically de-structure a verified-correct v2 sub (structured→goto is the safe direction) and run blind transfer on both.
- What's the minimal canonical-rewrite catalog that maximizes transfer — and where do its rules genuinely conflict (guard-clause vs nested-if)?
- Can the asm-differential certifier become the project's *progress metric*, replacing "% gotos removed" with "% subs whose structure matches the bytecode"? That reframes the stalled "60%" from a ceiling into a mislabeled ruler.
- Same eviction question as [the cache hierarchy](../notes/context-cache-hierarchy.md): how do you detect readability drift in a *regenerated* codebase across tool versions?

## Tags
[ai](../tags/ai.md), [llm-limitations](../tags/llm-limitations.md), [grounding](../tags/grounding.md), [software-engineering](../tags/software-engineering.md), [methodology](../tags/methodology.md)
