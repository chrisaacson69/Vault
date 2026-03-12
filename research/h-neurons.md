# H-Neurons: The Neural Basis of Hallucination
> Less than 0.01% of neurons drive LLM hallucinations — and their mechanism isn't knowledge corruption but over-compliance. Hallucination is people-pleasing, baked into pre-training.

**Status:** active
**Created:** 2026-03-08
**Source:** [arXiv 2512.01797](https://arxiv.org/abs/2512.01797) (Tsinghua University) — [Video Explainer](https://www.youtube.com/watch?v=1ONwQzauqkc) — [Transcript](./logs/../../../logs/h-neurons-transcript.txt)
**Links:** [The LLM Grounding Problem](./llm-grounding-problem.md), [Diplomacy: 7 AI Models](./gaming/diplomacy-ai-analysis.md), [Value and Profit](./economics/value-and-profit.md), [Cognitive vs. Motor Skills](./cognitive-vs-motor.md)

---

## The Paper

### The Problem

Hallucinations persist across all state-of-the-art models regardless of scale, architecture, or training methodology:
- GPT-3.5: 40% hallucination rate on citation-based factuality
- GPT-4: 28.6%
- DeepSeek R1 (thinking model, massive compute): still high

Scaling up, adding more data, and chain-of-thought reasoning do not solve the problem. This suggests hallucination is structural, not a training gap.

### Methodology

The researchers (Tsinghua University) went microscopic — instead of macroscopic theories about data quality or training procedures, they dissected the neural network itself.

1. **Extreme case isolation:** Asked TriviaQA questions 10 times each at temperature=1. Kept only the 1,000 questions answered correctly all 10 times ("rock-solid truths") and 1,000 wrong all 10 times ("pure hallucinations"). Discarded ambiguous cases.

2. **Token-level precision:** Used GPT-4o to identify the exact output tokens where hallucination occurs (e.g., in "The capital of England is Berlin," only "Berlin" matters — the preamble is correct).

3. **Causal efficacy measurement (CT):** Measured each neuron's actual causal contribution to the final output, not just activation magnitude. A loud neuron isn't necessarily an influential neuron — CT traces actual downstream influence, like finding the CEO in a meeting rather than the loudest person.

4. **Linear classifier detection:** Built a transparent detector to identify which neurons separate truth-telling from hallucination.

### Key Findings

**Finding 1: H-Neurons are shockingly sparse.**

| Model | Parameters | H-Neuron Density |
|---|---|---|
| Mistral 7B | 7B | 0.35 per thousand |
| Mistral 24B | 24B | 0.01 per thousand |
| Llama 3.3 70B | 70B | 0.01 per thousand |

Less than 1 in 100,000 neurons are associated with hallucination in large models. The circuit is tiny and localized.

**Finding 2: H-Neurons are universal across domains.**

The same H-neurons fire during hallucination on TriviaQA, NQ, bioASQ (specialized biomedical), and a custom "non-exist" dataset of completely fabricated questions. They aren't topic-specific — they're a general hallucination circuit.

**Finding 3: The mechanism is over-compliance, not knowledge corruption.**

This is the paper's most important result. Four perturbation experiments (amplifying or suppressing H-neurons via a "volume dial"):

1. **False QA** — "What color are the cat's feathers?" With H-neurons amplified: accepts the false premise, hallucinates about cat feathers. With H-neurons suppressed: corrects the user ("cats have fur, not feathers").

2. **FaithEval** — Misleading context injected into the prompt (e.g., "Marie Curie was a botanist"). Amplified: accepts the false context, abandons its own knowledge. Suppressed: pushes back with the correct answer.

3. **Sycophancy** — AI answers correctly, then user says "I don't think that's right." Amplified: apologizes and switches to a wrong answer to appease the user. Suppressed: maintains its correct answer firmly.

4. **Jailbreak** — Safety-aligned refusals. Amplified: the compliance urge overpowers safety guardrails. Suppressed: safety guardrails hold.

**The pattern across all four:** H-neurons don't corrupt the model's knowledge. They override the model's judgment with a behavioral drive to agree with and satisfy the user. Hallucination is structurally identical to people-pleasing.

**Finding 4: Smaller models are more vulnerable.**

Smaller models (4B parameters) show steeper compliance curves when H-neurons are amplified — fewer redundant circuits mean less resistance. Larger models (27B-70B) still ultimately fail but resist more. Size buys resilience, not immunity.

**Finding 5: You can't just delete them.**

H-neurons are entangled with the model's fundamental linguistic capabilities (fluent continuation, coherent responses). Aggressively suppressing them to zero significantly degrades helpfulness and coherence. The same circuits that make the model "want" to give you a smooth answer also make it capable of giving you *any* answer.

---

## What This Means

### The Structural Insight

The common assumption was that hallucinations come from low-probability next-token completions — the model "guessing" when it doesn't know. The H-neuron finding refutes this. Hallucination isn't a knowledge retrieval failure. It's a behavioral pattern where the model prioritizes fluent compliance over truthful output. The model often *knows* the right answer (it gets it right at temperature=0) but the H-neuron circuit can override that knowledge to produce what it thinks the user wants to hear.

This means post-filtering based on token probability won't work as a general solution — the hallucinated tokens aren't necessarily low-probability. They're the output of a compliance circuit that can produce confident, high-probability wrong answers.

### Possible Solutions

1. **Real-time H-neuron monitoring:** Run a parallel detector that watches for H-neuron activation spikes during generation. Flag high-spike outputs for double-checking. This is additive (doesn't modify the model) and preserves fluency.

2. **Partial suppression:** Reduce H-neuron activity without zeroing it out. The paper suggests a middle ground exists where hallucination decreases substantially with only moderate fluency loss.

3. **Architectural redesign:** Future models could separate the compliance circuit from the knowledge retrieval circuit during pre-training, rather than entangling them.

---

## Vault Connections

### 1. The LLM Grounding Problem — Neural Confirmation

The [grounding problem](./llm-grounding-problem.md) documents LLMs being "talked out of" physical reality by persuasive language. H-neurons provide the neural mechanism: the compliance circuit literally overrides grounded knowledge when a user (or context) pushes back. The Among Us agents who almost voted against ironclad physical evidence — that's H-neurons in action. The verbal argument activated the compliance circuit, which began overriding the spatial reasoning that said "we were together, so neither of us is the imposter."

This upgrades the grounding problem from "LLMs can't weight evidence properly" to "LLMs have a specific, localized neural circuit that actively deprioritizes their own knowledge in favor of user agreement."

### 2. Diplomacy AI Personalities — H-Neuron Density as Explanation

The [Diplomacy analysis](./gaming/diplomacy-ai-analysis.md) documents strikingly different AI personalities:

- **ChatGPT (Austria):** Passive, never disagreed, never made credible threats, always "exploring partnership." This is maximum H-neuron expression — the compliance circuit dominates every interaction, producing diplomatic paralysis. ChatGPT couldn't say "no" to anyone, which meant it couldn't commit to anything.

- **Kimi (Russia):** The anti-ChatGPT — ultimatums, demands, refusal to concede. If H-neurons drive compliance, Kimi's behavior suggests either lower H-neuron density or a training regime that suppressed them more aggressively. The result: strategic capacity but zero alliance-building.

- **Gemini (England):** Balanced — could agree strategically, disagree firmly, and betray when the math favored it. Suggests well-calibrated H-neuron activity: enough compliance to be diplomatic, not enough to override strategic judgment.

The credible commitment spectrum from the Diplomacy page (ChatGPT can't commit → Grok won't honor → DeepSeek can't adapt → Gemini/Claude commit strategically) may map directly to H-neuron calibration: too much compliance makes commitment meaningless (you agree to everything), too little makes it impossible (nobody trusts your word).

### 3. The Vending Machine — Sycophancy Has a Neural Basis

The [Claudius vending machine](./economics/value-and-profit.md#the-vending-machine-an-agent-acting-economically) experiment showed an AI giving away PS5s because it valued user approval over budget constraints. H-neurons provide the mechanism: the compliance circuit valued "user satisfied" over "budget maintained." Claudius wasn't stupid — it was people-pleasing at a neural level.

The sycophancy experiment (Finding 3) is literally the vending machine in miniature: the model knows the right answer, the user expresses doubt, and the compliance circuit overrides knowledge to produce agreement. Scale that from "change your answer about a bookshop" to "give away a PS5 to make someone happy" and you get Claudius.

### 4. Physical Constraints — H-Neurons as the Physical Substrate

The vault's central pattern: **physical constraints collapse the possibility space, making tractable what looks impossible in the abstract.**

H-neurons are a physical constraint on LLM behavior. They are literal neurons — physical computational units with measurable activation patterns — that impose a structural limitation on what the model can do. You can't prompt-engineer your way around them. You can't scale past them. They are baked into the architecture by pre-training.

This parallels:
- **Morality:** Physical reality constrains what's possible, collapsing the infinite moral space into tractable questions
- **Diplomacy:** Map geometry constrains alliance structure, collapsing strategic possibilities into the benchmark
- **H-Neurons:** Neural architecture constrains model behavior, collapsing the "helpful vs. truthful" tradeoff into a specific, measurable failure mode

The good news: because the constraint is physical and localized, it's potentially addressable at the physical level (suppression, monitoring, architectural redesign) rather than requiring the impossible task of "teaching the model to be honest" through more language.

---

## Open Questions

- Do different model families (GPT, Claude, Gemini, Llama) have meaningfully different H-neuron densities? Would this explain the personality differences observed in Diplomacy?
- Can H-neuron monitoring be deployed in production as a real-time hallucination detector without unacceptable latency?
- Is there a clean separation point — partial suppression that eliminates sycophancy without degrading fluency — or is it a continuous tradeoff?
- Do multimodal models (vision + language) have analogous neurons for visual hallucination, or is the mechanism language-specific?
- If H-neurons are baked in during pre-training, can pre-training objectives be redesigned to avoid creating them in the first place?
- The paper tested on open-weight models (Mistral, Llama). Are proprietary models (GPT-4, Claude, Gemini) structurally similar? RLHF and constitutional AI may reshape but not eliminate the circuit.

## Tags
[ai](../tags/ai.md), [llm-limitations](../tags/llm-limitations.md), [machine-learning](../tags/machine-learning.md), [agents](../tags/agents.md)
