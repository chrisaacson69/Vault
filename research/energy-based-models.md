---
status: active
created: 2026-05-17
---
# Energy-Based Models — The Named Middle Layer
> Energy-based models (EBMs) score whole *states* by how well they satisfy a set of constraints — low energy means the state fits, high energy means something is wrong. That makes reasoning into constraint optimization over a landscape rather than next-token prediction over a sequence. Logical Intelligence's Aleph generated Lean-checked proofs for **668/672 PutnamBench problems (99.4%)** and hits 100% on Verina. Combined with a formal verifier, EBMs supply the *general-purpose validation layer* the planner-LM composite architecture had been treating as a generic "planner." The vault's three-layer prescription — LM for communication, planner/EBM for constraint-heavy reasoning, formal verifier for ground truth — is now a named architecture with public benchmarks, and Yann LeCun's JEPA program is arriving at the same place from a different direction.

**Links:** [Planner-LM Composites](./planner-lm-composites.md), [The LLM Grounding Problem](./llm-grounding-problem.md), [LLMs as Praxeological Actors](./economics/llm-praxeology.md), [LLM Agents Across Strategic Games](./gaming/llm-agents-across-games.md), [Level 6 — Direct Execution](./level-6-direct-execution.md), [Karpathy LLM Wiki — Independent Convergence](../notes/karpathy-llm-wiki-convergence.md), [Computation and Information Theory](./computation-and-information.md), [Cognitive vs. Motor Skills](./cognitive-vs-motor.md), [The Cyborg Model](./cyborg-model.md)

**Primary source:** [Aleph and Energy-Based Models: The AI That Refuses to Bullshit](https://www.youtube.com/watch?v=NYmXYF8A3Q4) — Ksenia (Turing Post / Attention Span), 2026-05-15. [Transcript](../raw/yt-NYmXYF8A3Q4.transcript.txt). Logical Intelligence references: [Aleph benchmarks](https://logicalintelligence.com/blog/aleph-leading-benchmarks), [Aleph on PutnamBench](https://logicalintelligence.com/blog/aleph-solves-putnambench), [Kona Sudoku demo](https://logicalintelligence.com/blog/energy-based-model-sudoku-demo). LeCun's program: [A Path Towards Autonomous Machine Intelligence (2022)](https://openreview.net/pdf?id=BZ5a1r-kVsf).

---

## The Sudoku tell — tool-use is not reasoning

Logical Intelligence's demo: Kona (their EBM) solves a Sudoku in 0.4 seconds. Frontier LLMs given the same puzzle either time out, solve it incorrectly, or — *and this is the actual finding* — solve it by writing a brute-force Python script and executing it.

When code execution is disabled, the LLMs fail. When code execution is enabled, they don't reason through the puzzle; they recognize the problem class, generate a solver, and run it. The video frames this as the difference between *a person solving the puzzle* and *a person saying "give me one second, I'll build the tiny Sudoku-solving machine."* Both produce the answer. They reveal different capabilities.

This sharpens an argument the [LLM grounding](./llm-grounding-problem.md) and [Catan analysis](./gaming/llm-agents-across-games.md#phase-5--catan-verification-as-a-spectrum-not-a-binary) pages already make, but with cleaner isolation. The Catan finding required reading game logs to see the LLM never built a state machine. The Sudoku finding is one transcript line: *"It wrote a Python script."* The rules fit in one sentence; the failure mode is unambiguous.

The deeper point is about **scope**. The LLM did the right thing when it had a tool. The wrong thing was claiming this counts as reasoning over constraints. It's reasoning at one level (recognize problem → invoke solver) operating *above* a deterministic engine that does the actual constraint work. That's already the planner-LM composite pattern, just unnamed and built ad-hoc per problem. EBMs propose to *name and generalize* the constraint-checking layer so the LLM doesn't have to invent it from scratch every time.

## What an energy-based model actually is

The vocabulary comes from physics. An EBM defines an energy function `E(state) → ℝ` over the space of possible configurations of a problem. The job of the model is to *score whole states* against the problem's constraints:

- **Low energy** = the state satisfies the constraints. A valid Sudoku grid. A consistent proof. A configuration of forces that respects physical law. A schedule that meets all the deadlines.
- **High energy** = something is wrong. A row has two 9s. A proof step doesn't follow from its predecessors. The schedule double-books a resource.

Reasoning, in this frame, is not "produce the next token." It's **search a landscape for a state with lower energy.** The system can start from a partial or invalid configuration and descend toward one that fits. The model evaluates *complete answers*; it doesn't commit irreversibly to a left-to-right rendering of one.

That difference matters because **most non-language problems are constraint-satisfaction problems wearing different clothes.** Proofs must be logically valid. Chip designs must obey physical and timing constraints. Robots must move without violating safety constraints. Energy grids must balance supply, demand, and stability. Financial systems must satisfy rules and risk limits. In every case, what counts is whether *the whole configuration fits*, and a fluent description of the configuration is not a substitute for the configuration itself.

Bare LLMs cannot evaluate "fit" — they evaluate "plausibility of the next token given the prefix." Those are different functions over different domains. EBMs evaluate fit directly.

## The history — this is an old idea returning at the right time

Energy functions were already central to neural network thinking in the 1980s. **Hopfield networks** (Hopfield, 1982) defined an energy function over binary states and used gradient-style descent to find stable attractors — local minima of the energy landscape. **Boltzmann machines** (Hinton & Sejnowski, 1985) generalized this to probabilistic state transitions, with the Boltzmann distribution defining state probabilities in terms of an energy function. The whole conceptual apparatus — landscape, descent, low-energy = stable — is forty years old.

What changed:

- Modern compute makes evaluating energy over high-dimensional state spaces tractable.
- Modern deep nets can *learn* the energy function rather than requiring it to be hand-specified.
- The cost-benefit calculus shifted: LLMs proved that scaling worked for language, but also that scaling alone doesn't solve constraint problems. EBMs were back on the table as the missing complement.
- A formal verification target (Lean) emerged that could ratify EBM outputs as more than confident guesses.

So this is not a reaction to chatbots, even though it's marketed in that context. It's a research line that was waiting for the right moment and is now being pulled into the present by the structural failures of pure language-model scaling.

## Aleph and PutnamBench — verification, not vibes

Logical Intelligence's Aleph is the practical demonstration. The pipeline:

1. A formal mathematical statement (e.g., a PutnamBench problem in Lean syntax).
2. Aleph proposes a proof — a sequence of formal steps in Lean's tactic language.
3. **Lean compiles the proof.** If it compiles, the theorem is proved within Lean's logic. If it doesn't, the proof is invalid. There is no "sounds elegant" middle ground; the verifier is deterministic and external.

Reported results:

- **PutnamBench: 668/672 problems (99.4%)** — proofs verified by an external deterministic Lean compiler. Putnam is one of the hardest undergraduate math competitions; the benchmark is the formalized versions in proof-language form.
- **Verina: 100%.**
- **Top position on VeriSoftBench and LeanEval** as of the announcement.
- Aleph reportedly **detected 15 broken formal statements** in benchmark problems, suggested corrections, and proved the corrected versions. That is qualitatively different from pattern-matching against memorized proofs — it implies engagement with the formal statement itself.

Caveats to be honest about:

- These are company-reported results. The video calls out that we don't yet know how much performance comes from Aleph's orchestration vs. the underlying LM it uses, the search procedure, the Lean environment, and pre-existing proof libraries. Independent replication and ablation are the next demand.
- "Aleph corrected 15 broken statements" is a striking claim. If it survives scrutiny, the system is doing something genuinely interactive with formal mathematics, not just stochastic search over proof templates.
- The hard part of formal verification is not the proof — it's translating an informal requirement into the right formal statement. Lean will happily certify a proof of the wrong theorem. The pipeline shifts the human's job upstream, into the *specification*, but does not remove it.

Even granting all the caveats, the **architectural** point is what matters here. The output is *checkable*. Whether or not Aleph is the best EBM, the fact that *something* can now generate Lean-compilable proofs at PutnamBench scale means the pipeline (LM-class proposer → constraint reasoner → formal verifier) is no longer hypothetical.

## EBMs name the middle layer in the planner-LM composite

This is the core architectural takeaway for the vault.

The [planner-LM composites page](./planner-lm-composites.md) argues for a three-component stack: LM scoped to language I/O, dedicated reasoning engine, explicit connectors between them. The "dedicated reasoning engine" is the load-bearing component — and on that page it's defined functionally (state model + value model + planner + verification) but not by *kind*. It could be a Markov chain (Monopoly project), a search-and-evaluate engine (Cicero, Diplodocus), or something else.

EBMs propose a specific answer to "or something else": **the engine is an energy function over the problem's state space, plus a search procedure over the landscape it defines, plus a verifier downstream if the domain admits one.**

| Layer | Job | Architecture |
|---|---|---|
| **Language layer** | Communicate with humans and other agents; render goals and parse intent | SLM (per the [composite prescription](./planner-lm-composites.md#scope-discipline--slm--reasoning-engine--connectors)) |
| **Constraint layer** | Score whole states; descend toward states that fit the problem's structure | **EBM** (Kona, Aleph; Hopfield/Boltzmann lineage; JEPA-adjacent learned representations) |
| **Verification layer** | Independently confirm that the produced state actually satisfies the constraints under stated assumptions | Formal verifier (Lean for math; type checkers, model checkers, SAT solvers, physics simulators for other domains) |

The video's explicit framing is *"AI may need a layered reasoning stack — language models for communication, energy-based models for constraint-heavy reasoning, formal systems for verification. That division of labor sounds much more realistic than expecting one giant chatbot to handle everything from poetry to reactor controls."*

That is the planner-LM thesis with the middle and bottom layers named. The vault's contribution had been the *shape* of the stack; Logical Intelligence and LeCun's program supply *implementations* of the middle and bottom layers for the cleanest case (formal mathematics) — and they exist publicly, with benchmarks, today.

## General-purpose validation vs. on-demand tool-building

A subtle but important distinction was raised in the conversation that produced this page.

The Sudoku LLMs solved the puzzle by *building a custom tool for the problem class* — write a Python solver, run it, return the answer. That works, but it has two costs:

1. **Per-problem tool construction** — the LLM is generating new code for every new constraint problem. Some of this is amortized by the LLM's training (it has seen many Sudoku solvers), but new problem classes require new tools, and the tools' correctness depends on the LLM's code generation correctness.
2. **The tool is the entire validator** — if the generated solver has a subtle bug, the answer is wrong and nothing downstream catches it. Validation is fused with solving.

The EBM proposition is different: rather than building a bespoke solver per problem, you have a **general-purpose constraint engine** that can score states across many problem classes given the right specification. The validator is *separated from the proposer* — the EBM produces a candidate state, the verifier independently checks it. Lean doesn't care how the proof was generated; it just checks whether each step follows.

This is the [right-tool-for-the-job principle](./cyborg-model.md) operating at the architectural level. An LLM building a Sudoku solver is "use a general-purpose tool to build a special-purpose tool every time." An EBM-plus-verifier pipeline is "use a special-purpose tool whose generality lives in the constraint specification, not the code generation step." The latter scales better to domains where verifying generated code is itself nontrivial — which is most of them.

The video's framing: *"You do not want an AI system to say 'this bridge should probably hold.' You want something closer to 'given these assumptions, this structure satisfies these requirements.'"* The first is fluent generation. The second is a triplet — assumptions, structure, requirements — where each piece is auditable separately. That's only possible with a verification layer that is not the same component that produced the proposal.

## Why integration is easier than it looks

A second observation worth recording: **component integration is the part people overestimate the difficulty of.**

The cognitive instinct says that combining a language model, a constraint engine, and a formal verifier into a working system requires deep architectural research, novel interfaces, and significant engineering. In practice, the interfaces are remarkably narrow:

- LM → EBM: a structured representation of the problem (the formal statement, the puzzle grid, the spec). This is *language out, structure in* — exactly what tool-use and function-calling already do.
- EBM → verifier: a candidate state in the verifier's input format. Lean takes a proof script; SAT solvers take CNF; physics simulators take initial conditions. These are stable, well-defined interfaces.
- Verifier → LM: a yes/no plus a reason. "Compiled successfully" or "step 7 doesn't follow because X." The reason is text, which is exactly what an LM can ingest and act on.

Each handoff is a narrow, well-typed interface. The "model context protocol" (MCP) layer the industry is building is the generalization of this — a standardized envelope for LM-to-tool calls, where the tools can be calculators, databases, simulators, verifiers, or EBMs. The integration *protocol* is general; what's instance-specific is the problem encoding.

This matters for engineering. The intuition "we need to build a giant integrated system" is what stalls projects. The reality is "we need three components that already exist plus three narrow interfaces." Aleph + Lean is the demonstration: the LM proposes Lean tactics, Lean compiles them, the result goes back. There's no magic interface.

The deeper insight: **the architectural form of the planner-LM composite was conjectured from biological analogy and game-AI convergence; once you grant the form, the construction is mostly plumbing.** That's a strong claim for the form being right.

## JEPA and LeCun — the same destination from a different direction

Yann LeCun is publicly aligned with Logical Intelligence and has been arguing this direction for years. His 2022 paper *A Path Towards Autonomous Machine Intelligence* sketches a system with:

- A **world model** that learns the structure of the environment.
- A **planner** that imagines candidate future states.
- An **energy function** that scores whether a state fits the world model.
- A **selection step** that chooses the lowest-energy plan.

The architectural sketch and the vault's planner-LM composite are isomorphic. LeCun's research program **JEPA** (Joint-Embedding Predictive Architecture) is the representational substrate: instead of predicting the next token or reconstructing every pixel, JEPA learns to predict *in an abstract representation space* — a compressed model of "what could come next that fits." Hierarchical JEPA combines this with energy-based scoring.

The connection is direct:
- JEPA learns useful representations of the world.
- EBMs score whether candidate states fit those representations.
- Planning is search over the JEPA representation space, scored by the energy function, executed by selecting low-energy paths.

This is **the same architecture the vault and Karpathy converged on independently** ([convergence note](../notes/karpathy-llm-wiki-convergence.md)), now arriving from the Meta AI research lineage. Three independent convergences — game AI (Cicero/Diplodocus), engineering practice (RAG, MoE, MCP), and academic research (JEPA, EBMs) — onto the same skeleton is hard to dismiss as coincidence. It is much more likely a statement about the *shape* of the problem.

## Why it matters beyond math

Formal mathematics is the cleanest case because Lean exists. The general pattern, however, applies wherever a verifier exists or can be constructed:

| Domain | Constraints | Verifier candidate |
|---|---|---|
| Mathematical proofs | Logical validity | Lean, Coq, Isabelle, Agda |
| Hardware design | Timing, power, signal integrity | Formal hardware verifiers (e.g., SymbiYosys), SPICE simulation |
| Software correctness | Type safety, specification conformance | Type checkers, model checkers (TLA+), property-based testing |
| Safety-critical control | Operating envelopes, fail-safe behavior | Hybrid systems verifiers, runtime monitors |
| Financial systems | Regulatory rules, position limits, risk constraints | Rule engines, simulation-based stress tests |
| Energy grids | Supply/demand balance, stability margins | Power flow simulators, contingency analysis |

The pattern is **translate a real-world requirement into a formal specification → propose a state with an EBM-class system → verify with a domain-specific checker.** The hard part is the *first step* — translating the informal requirement correctly. That hard part is uniquely human (or human-in-the-loop) and is where domain expertise lives. But once the specification is right, the propose-and-verify loop is mechanical, and EBMs are a good fit for the propose step because they can score whole states against complex constraint structures.

This is exactly the [Level 6](./level-6-direct-execution.md) operating regime — direct execution of complex tasks — *provided the verifier exists*. The verifier is the ground truth that prevents fluent failure from cascading. Without it, you have LLMs writing reactor control code that "looks correct." With it, you have certified control code or a clear "no" with a reason.

## What this connects to in the vault

- **[Planner-LM composites](./planner-lm-composites.md)** — EBMs name the middle layer of the three-component stack. Particularly relevant to the "SLM + reasoning engine + connectors" section and the regimes spectrum (EBMs extend competent operation from regime 2 toward genuine regime 4).
- **[The LLM Grounding Problem](./llm-grounding-problem.md)** — the Sudoku-with-tool-use anecdote is a cleaner version of the tool-use-isn't-grounding point than the Among Us case. Tool invocation is *outsourcing* the constraint check, not solving it.
- **[LLMs as Praxeological Actors](./economics/llm-praxeology.md)** — EBMs make the "preferred state" formal: it's the low-energy region of the configuration space. Mises's "image of a preferred state" becomes a literal scoring function. The composite-as-actor frame gets sharper.
- **[Karpathy convergence](../notes/karpathy-llm-wiki-convergence.md)** — add a third independent convergence (LeCun/JEPA) to the existing two (vault, Karpathy).
- **[Cyborg Model](./cyborg-model.md)** — right-tool-for-the-job operating at architectural level. The LM is the language organ; the EBM is the constraint organ; the verifier is the auditor organ. Each does what it's structurally suited for.
- **[Level 6](./level-6-direct-execution.md)** — direct execution becomes safe to the extent the verifier exists. EBM + verifier is the route to "automation that holds up under adversarial conditions."
- **[Game Annotation Series](../projects/game-annotation/README.md)** — the assembly-reading exercise is partly a manual EBM: the chapter has to *fit* the bytes. When the synthesis doesn't fit, the disassembler returns "high energy" and the chapter has to revise.

## What is and isn't validated

This page commits to:

- **EBMs are a real architectural category**, not marketing. The math goes back to Hopfield and Boltzmann; the current generation (Aleph, Kona) is a modernization with learned energy functions and verifier integration.
- **The three-layer stack (LM / EBM / formal verifier) is the right shape** for constraint-heavy reasoning under accountability. Multiple independent convergences (game AI, engineering, academic research) support this; Aleph's PutnamBench results demonstrate it works in the cleanest case.
- **Tool-use is not reasoning when validation is fused with solving.** Solving a Sudoku by writing a Python script is fine pragmatically; it's not evidence that the LLM reasoned over constraints. The validation lives in the generated code's correctness, which is itself unverified.
- **Integration is easier than it looks.** Narrow well-typed interfaces between LM, EBM, and verifier are sufficient. MCP and tool-use are the industry-standard generalization.

This page does *not* commit to:

- Aleph's exact numbers without independent replication.
- EBMs being the *only* useful middle layer. They're a strong candidate; Markov chains, SAT/SMT solvers, classical planners, and learned reward models occupy adjacent positions in the same architectural slot.
- The claim that JEPA will deliver autonomous machine intelligence. The architecture is plausible; the execution is in progress and contested.
- The pipeline being "general AGI." It's a strong specialization for constraint-satisfaction domains. Open-ended creative work, social judgment, and tasks without crisp specifications are harder and possibly require different architecture entirely.

## Open questions

- **How much of Aleph's performance is the EBM vs. the orchestration vs. the underlying LM vs. the Lean ecosystem?** Independent ablation studies would settle this. Until then, the result is suggestive but not architecturally diagnostic.
- **What's the smallest viable EBM?** Hopfield networks are tiny by modern standards. Is a few-million-parameter EBM enough for a domain like Sudoku, scheduling, or simple program verification? Or does the energy function need to be deep-learned over millions of examples?
- **What about domains without verifiers?** Most real-world problems lack a Lean-equivalent. Can EBMs bootstrap their own verification through self-consistency, ensembles, or learned discriminators? Or is "no verifier → no certification" a hard limit?
- **Where does language end and constraint begin in mixed problems?** Negotiation, legal reasoning, contract drafting — these have language *and* constraint structure. How does the LM ↔ EBM handoff get designed when the constraints are themselves expressed in natural language?
- **The specification-translation bottleneck.** If the hard part of EBM-pipeline correctness is translating informal requirements into formal specifications, who does that translation? Today it's domain experts. Can LMs assist with specification drafting under EBM-style constraint scoring? That's a layered application of the same architecture and the natural next research direction.
- **Composability of verifiers.** A real industrial system needs to satisfy *multiple* constraint systems simultaneously (correctness AND safety AND performance AND regulatory). Are these composed by intersecting their energy functions, by sequential filtering, or by a meta-verifier? The architecture is open.

## Tags

[ai](../tags/ai.md), [agents](../tags/agents.md), [llm-limitations](../tags/llm-limitations.md), [grounding](../tags/grounding.md), [machine-learning](../tags/machine-learning.md), [mathematics](../tags/mathematics.md), [logic](../tags/logic.md)
