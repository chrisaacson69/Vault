---
status: active
created: 2026-04-09
---
# AI History — A Personal Arc
> From ELIZA to OOP neurons to LLMs. Each step got something right and something wrong. The trajectory reveals what the current moment actually is.

**Links:** [ELIZA](./eliza.md), [LLMs as Praxeological Actors](./economics/llm-praxeology.md), [LLM Grounding Problem](./llm-grounding-problem.md), [Cognitive vs. Motor Skills](./cognitive-vs-motor.md), [H-Neurons](./h-neurons.md), [Cyborg Model](./cyborg-model.md), [OOP Neuron Project](../projects/oop-neurons/README.md)

## The Arc

| Era | Approach | What it got right | What it missed |
|---|---|---|---|
| **1943-1958** | McCulloch-Pitts / Perceptrons | The neuron is the right unit; simple units compose into complex behavior | Training was primitive; couldn't learn non-linear functions (XOR problem) |
| **1966** | ELIZA — keyword lookup | The interface matters; people naturally engage with text-in/text-out | Nothing was actually happening inside; pure illusion |
| **1969-1986** | The AI winter | Minsky & Papert were right that perceptrons have limits | They were wrong that the limits couldn't be overcome with deeper architectures |
| **1986** | Backpropagation revival | Training IS the breakthrough — adjusting weights based on error signals across layers | Hardware couldn't support deep networks yet |
| **~1990s** | OOP neurons (Chris's insight) | A neuron IS a great object — encapsulated state, defined behavior, uniform interface; OOP naturally supports replication and interconnection | Didn't think about training; the interesting behavior isn't in the object design, it's in how weights get adjusted |
| **2012** | GPU deep learning (AlexNet) | Scale matters — more layers, more data, more compute | Still narrow; each network does one thing |
| **2017** | Transformers (attention mechanism) | The right architecture for language — parallel processing, long-range dependencies | Nobody expected what would emerge at scale |
| **2022** | Aligned LLMs (ChatGPT 3.5) | Alignment creates the self-other orientation that makes the model a catallactic actor; the public immediately recognized something was there | The technical community still pattern-matches against ELIZA |
| **2026** | Agentic LLMs + persistent memory | The vault, skills, tool use, multi-session continuity — the model becomes a continuous actor, not a per-session one | Temporal grounding, spatial grounding, the trust gap at L6 |

## Key Transitions

### ELIZA → Perceptrons: From Illusion to Mechanism

ELIZA had no mechanism at all — just string matching. The move to perceptrons introduced actual computation: inputs, weights, activation. Something was genuinely happening inside the unit. But Minsky and Papert showed that a single layer of perceptrons couldn't learn XOR — a trivially simple non-linear function. This killed funding for a decade.

**The lesson:** Having a mechanism isn't enough. The mechanism has to be powerful enough to learn the patterns that matter.

### Perceptrons → OOP Neurons: The Object Instinct

Chris's early insight: a neuron maps naturally to an OOP object.

```
class Neuron:
    weights: float[]      # encapsulated state
    bias: float           # threshold
    activation: function  # behavior
    
    forward(inputs) → output    # uniform interface
    connect(other_neuron)       # composition
```

The instinct was correct — neurons ARE objects, and OOP's strengths (encapsulation, replication, composition, polymorphism) map cleanly to neural architectures. A network is a graph of Neuron objects with weighted edges. This is literally what a neural network is, just described in software engineering terms rather than linear algebra terms.

**What was missing:** Training. The individual Neuron object is trivially simple. The magic isn't in designing the object — it's in the algorithm that adjusts billions of weights based on error signals propagated backward through the network. Without backpropagation (or some training mechanism), a network of OOP neurons is just a random function.

### Backpropagation → GPUs: Scale Unlocks Emergence

Backpropagation was known since 1986 but deep networks were impractical until GPUs made the matrix multiplication fast enough. The 2012 moment (AlexNet winning ImageNet) proved that depth + data + compute = qualitative breakthroughs. Properties emerged at scale that weren't present in small networks — the whole became genuinely more than the sum of its parts.

**Connection to vault:** This is the [emergence and convergence](./philosophy/logic-and-math/emergence-and-convergence.md) pattern. The patterns are real (category 2-3 facts). The formalisms are constructed. The emergent properties at scale weren't designed — they were discovered.

### Transformers → Alignment: The Catallactic Leap

The transformer architecture (2017) was a technical innovation. But alignment (RLHF, constitutional AI) was the leap that created Fraser's "catallactic actor" — a system oriented toward the user, maintaining self-other distinction, participating in the human world of meaning. The base model is Crusoe; the aligned model is a market participant.

**The public got it instantly.** Weizenbaum's secretary wanted privacy with ELIZA because of an illusion. ChatGPT's 100 million users in two months engaged because something was actually there. The technical community's insistence that "nothing changed, it's still just statistics" is the same deflationary error the logical positivists made about human action.

## The Training Problem — Then and Now

The gap in the OOP neuron concept was training. Three approaches exist:

| Approach | How it works | Strengths | Weaknesses |
|---|---|---|---|
| **Backpropagation** | Compute error at output, propagate gradients backward, adjust all weights | Proven at massive scale; this IS deep learning | Requires differentiable operations; the "credit assignment" problem; biologically implausible |
| **Hebbian learning** | "Neurons that fire together wire together" — local, unsupervised weight updates | Biologically plausible; local computation only | Limited learning capacity; no error signal |
| **Evolutionary / genetic** | Treat weight configurations as genomes; select for fitness; breed and mutate | No gradient needed; works for non-differentiable functions | Extremely slow; combinatorial explosion |

An OOP neuron project would naturally explore whether there's a training approach that fits the object paradigm better than matrix-based backprop. Hebbian learning is the most "object-native" — each neuron updates its own weights based on local information, no global error signal needed. But it's limited. The question is whether OOP structure enables training approaches that matrix algebra makes awkward.

## Open Questions

- Does OOP structure offer anything that matrix multiplication doesn't? Interpretability (you can inspect individual neuron objects)? Modularity (swap in different neuron types)? Heterogeneous architectures (different neuron classes in the same network)?
- Can Hebbian learning + evolutionary selection approximate backpropagation for small networks?
- What does the OOP neuron project actually reveal about what happens inside a network — does object-level inspection give insights that weight-matrix inspection doesn't?
- How does this history connect to the [brain architecture](./cyborg-model.md) model? The vault's cross-links ARE a network of interconnected objects with behavior. Is the vault itself an OOP neural network?

## Tags

[ai](../tags/ai.md), [history](../tags/history.md), [philosophy](../tags/philosophy.md)
