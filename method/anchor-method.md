---
status: active
created: 2026-06-05
published: true
layout: layouts/page.njk
title: "The Anchor Method"
---
# The Anchor Method
> The enemy of agent-driven work is **drift**. The cure is an **anchor** — a fixed reference the work must keep satisfying so it can't wander — installed as strong as your current grounding allows, and upgraded toward a hard gate as grounding crystallizes. The process *is* the skill; the transpiler, the gate, NNUE, the jira board are tools inside it.

**Links:** [Transpilation as a Grounding Strategy](../research/transpilation-as-grounding.md), [The LLM Grounding Problem](../research/llm-grounding-problem.md), [Principled LLM Code](../research/principled-llm-code.md), [Praxis: Agent Teams](../research/economics/praxis-agent-teams.md), [AI History — A Personal Arc](../research/ai-history-personal.md) · case studies: [na1-decompiler](https://github.com/chrisaacson69/na1-decompiler) (proof-driven), [pygone](https://github.com/chrisaacson69/pygone) (exploratory)

> *Process is not an exact science.* This is a **living playbook of warning signs and moves** the director uses judgment on — not a checklist. It accretes: every project adds signs. Born from the NA1 decompiler (where it was discovered, not designed) and stress-tested against the projects that drifted (camelot→DJ, monopoly, MOO1).

## The spine: the gate is the anti-drift anchor

The defining move is the **self-validating gate** — every change is *automatically proven* against a reference before it's kept, and *falls back to a safe form* if it can't be. NA1's gate: `lower(structured C) == bytecode CFG` on all 495 subs, or the fold reverts to an honest `goto`.

The gate is usually framed as "proves correctness." That undersells it. **The gate proves *grounding*** — it is how you *know* the work is faithful and not plausible-but-wrong — and because it pins every change to a fixed reference, **it makes drift structurally impossible.** NA1 never wandered because the gate wouldn't let it. The projects that hurt had no anchor.

→ Without a gate you are not "moving faster," you are drifting and won't find out until later.

## Drift is the real enemy (two directions)

- **Within-project:** the agent takes a long diversion and returns with nothing (*sprawl*); hallucination; losing the thread. (monopoly, MOO1 — *even when you knew exactly what you wanted.* Knowing the goal is **not** enough; the anchor must be installed **and enforced**.)
- **Across boundaries:** a spin-off forgets the tool you already built (the DJ tool not reusing the camelot tool); a project falls out of sync with the vault. → keep an explicit **registry of what's already built** and a **pointer discipline** at every project/vault seam ([[projects-are-pointers-norm]]). The developed form of this seam discipline is [Specimen & Thesis — The Two-Altitude Ledger](./specimen-and-thesis.md): the specimen↔thesis two-way ledger, and why its downward half rots.

## Grounding is a maturity axis, not a kickoff toggle

Projects often start *"ohh this is neat"* — not because they're unserious, but because **you** aren't grounded in what the thing *is* yet. Exploration grounds **the operator** (the grounding gradient applies to *you* reading an unfamiliar project, exactly as it applies to an LLM reading bytecode). NA1 ran the arc: *understand the mechanics → it's bytecode → it's a VM → build the decompiler → install the CFG gate.* The gate couldn't exist at the start; there was nothing identified to gate against yet.

**The transition trigger — install the gate the instant you can name a *ground truth* + a *cheap deterministic check* against it.** Before that, keep exploring (you're still grounding yourself) but install the *strongest anchor available now*: a north-star statement + a decision log + the built-tools registry.

- **Grounding can be partial/layered.** pygone: a real gate at the floor (perft move-counts, the ≤4096-byte budget) under an *open* strength frontier. Proof-driven in the substrate, exploratory at the edge — simultaneously.
- The "rigor dial" is a *consequence*: which anchor you can afford yet. Rigor is what you get for free once the anchor is a real gate.

## The team is the tie-it-together layer; context is its engine

Director / workers / QA / logs / "jira boards." This isn't bureaucracy — it's **context management**: small focused worker contexts, the **director holding the thread**, QA bound to the gate. It exists to kill *sprawl* — the agent wandering off and coming back empty. (Decision-class hierarchy: [Praxis: Agent Teams](../research/economics/praxis-agent-teams.md) — director handles the harder class, workers the line.)

## The director owns recalibration — the convergence gate the method was missing

A correctness gate proves each increment is *sound*. It says nothing about whether the increment-grind is still the **right move**. You can grind correct atoms forever while a wrong founding assumption silently caps the whole thing. So the director runs a **standing meta-check**:

**Warning signs of spinning** (heuristic — expect to find more):
- The *same* structural wall rejects N consecutive attempts (NA1: the **address-based gate** keeps blocking backward merges + interleaved switches — the phrase "address-ordered/based" appears 49× in the logs as the blocker).
- The case set *multiplies without closing* (atoms 5→7→8; rungs 5→7) despite inputs meant to stop it.
- Marginal return per increment collapses.
- "New approaches" produce only a minor process change, then get overrun.
- **Your "alternatives" are all the same *kind*** — they each change the *same component*, so the divergent set is fake. This is the most dangerous sign because it *feels* like recalibrating while staying trapped. (NA1: every fix ever proposed — atoms 1–8, "address-ordered emitter," "redirect predecessors" — touched the **reducer/emitter**; the gate's *equivalence relation* was never once a candidate in ~200 sessions.)

**The recalibration move — NOT tweaks** (they get overrun). Escalate from worker-grind ("invert the next case") to director-rethink ("**what assumption builds this wall** — the gate? the IR? a missing tool?"), then run a **tournament of genuinely divergent approaches** — *1 approach vs another*, e.g. address-based gate **vs.** a different IR — **not variations on one theme** (the `_COMBOS` grid was variations; it can't escape a wall baked into the theme). The gate judges the winner. When reactive discovery won't close the set, **enumerate the table forward** instead (the lowering-atlas move). Output is one of: a new tool, a dropped assumption, or an explicit *"this wall is acceptable — log it, move on."*

> **Check the set is real — name the dual.** For each candidate, name the *one component* it changes (discovery loop / reducer / emitter / **gate's equivalence relation** / IR). If they all name the same one, you have variations — go find the **dual**: the component every attempt has avoided. NA1's blind spot was loud once asked this way — every fix changed the *emit* to satisfy an address-based gate; nobody changed the *gate* to stop caring about address order (a reorder-invariant equivalence relation — and it's *cheaper* than the emitter rearchitecture).

> **Tool or approach? Don't let the incumbent eat the rival.** The dominant approach has *gravity* — it doesn't reject a new idea, it **assimilates** it, reducing a different *way of knowing* into "another input for the way you already work." The tell is in how the idea gets described: *"now we have N new tests to run"* = swallowed into a **tool** (more answers to the current question), vs *"now I can **derive** the class without testing"* = a real **approach** (it changes the question / what's derivable). It happens because **the incumbent owns the scoreboard** — a deductive rival ("read the compiler, *know* the lowering, invert the mechanism") pays off slowly, so judged by the incumbent's short metric (goto-delta-this-session) it always loses to the next quick empirical clue → "nahh," or demoted to a clue-generator. *A tournament isn't fair if the incumbent sets the win condition and the horizon.* So: **classify on arrival** (tool vs approach); give an approach its **own track, metric, and horizon**; **fund the understanding** (deductive approaches need runway the toy-loop won't pay); and treat **clue-collecting as a symptom** — *to invert something, learn how it works and invert **that**; gathering empirical output-clues is a confession you haven't learned the mechanism yet* (NA1: "compile C and observe the CFG" was the empirical crutch; "read GCC's CFG-construction passes and *know* the forward map" is the rival that kept getting eaten).

> **The director isn't a hero.** The point of the standing check is that good direction doesn't depend on a person staying vigilant — the **agent can run this meta-check for you** (this playbook was validated by running it on NA1, which surfaced the gate blind spot no amount of willpower had). The human's job is to *notice the flag and choose the move*, not to out-discipline drift unaided.

## The kickoff checklist (what a new project installs on day one)

1. **North-star** — one sentence: what is this, and what is it accountable to?
2. **Strongest anchor available now** — a real gate if you can name ground-truth + a cheap check; else north-star + decision log + built-tools registry. Enforce it.
3. **Team shape** — director + workers + QA(=gate); a board for tasks; a log for decisions/atoms.
4. **A standing recalibration check** on the director — the warning signs above, run every few increments.
5. **Seam discipline** — pointer pages at every project↔vault and project↔project boundary; the built-tools registry so spin-offs reuse, not reinvent.

## Success test for this method itself

Run the playbook on **NA1 right now**: does it fire the recalibration NA1 has been missing — *"you've hit the address-based gate N times; stop adding atoms, run address-gate vs. new-IR as a divergent tournament"*? A method that can't diagnose its own birthplace is just prose. (Secondary: the next "ohh this is neat" project kicks off anchored and doesn't sprawl.)

## Tags
[agent-teams](../tags/agent-teams.md) · [methodology](../tags/methodology.md)
