---
status: concept — exploring
created: 2026-04-09
---
# OOP Neurons — Object-Oriented Neural Network on GPU
> Build neurons as proper OOP objects on GPU and see what emerges. Not trying to rediscover matrix multiplication — exploring what the object paradigm reveals about neural computation.

**Links:** [AI History — Personal Arc](../../research/ai-history-personal.md), [ELIZA](../../research/eliza.md), [Cyborg Model](../../research/cyborg-model.md), [Cognitive vs. Motor Skills](../../research/cognitive-vs-motor.md), [PyTorch Learning](../pytorch-learning/README.md)

## Motivation

Chris coded ELIZA as an early project. Later, realized neurons map perfectly to OOP objects — encapsulated state, defined behavior, uniform interface, natural composition. But never explored what happens when you actually BUILD a network this way on modern hardware.

This is NOT about recreating TensorFlow. Matrix multiplication is the efficient way to compute neural networks. The question is: **what does the OOP representation reveal that the matrix representation hides?**

## Research Questions

1. **Interpretability** — Can you inspect individual Neuron objects mid-computation and understand what they're doing? Is this more informative than inspecting weight matrices?
2. **Heterogeneous architectures** — What happens when different neurons have different activation functions, different learning rules, different internal structure? Matrix frameworks assume homogeneity; OOP doesn't.
3. **Training without backprop** — Can Hebbian learning (local, per-object weight updates) + evolutionary selection produce useful networks for small problems? What do you lose vs backprop?
4. **Emergent behavior** — At what scale does OOP overhead make this impractical? Before that threshold, what patterns emerge that you wouldn't see in matrix-land?

## Possible Architecture

```python
class Neuron:
    def __init__(self, activation='relu'):
        self.weights = {}      # {input_neuron: weight}
        self.bias = 0.0
        self.activation = activation
        self.output = 0.0
        self.history = []      # for inspection/debugging
    
    def forward(self, inputs: dict) -> float:
        total = sum(self.weights[n] * inputs[n] for n in self.weights) + self.bias
        self.output = activate(total, self.activation)
        self.history.append(self.output)
        return self.output
    
    def connect(self, source_neuron, weight=None):
        self.weights[source_neuron] = weight or random()
    
    def hebbian_update(self, learning_rate=0.01):
        # "Neurons that fire together wire together"
        for source, weight in self.weights.items():
            self.weights[source] += learning_rate * source.output * self.output
```

## GPU Considerations

OOP on GPU is the hard part. Options:
- **CUDA kernels per neuron** — massive parallelism but memory overhead per object
- **CuPy / Numba** — Python objects with GPU-accelerated computation
- **Triton** — custom GPU kernels with Python syntax
- **Hybrid** — OOP structure on CPU, batch forward passes on GPU, update objects after

The hybrid approach is probably realistic for exploration — keep the object graph on CPU, vectorize the forward pass, but maintain per-neuron state and history for inspection.

## Phases

- [ ] Phase 1: Build basic Neuron class, connect into a small network, forward pass on CPU
- [ ] Phase 2: Implement Hebbian learning, test on XOR (the classic perceptron failure case)
- [ ] Phase 3: Add evolutionary selection — breed network configurations, select for fitness
- [ ] Phase 4: Move forward pass to GPU, keep object state on CPU
- [ ] Phase 5: Scale up — how far can this go before OOP overhead kills it?

## Tags

[ai](../../tags/ai.md), [python](../../tags/python.md), [machine-learning](../../tags/machine-learning.md)
