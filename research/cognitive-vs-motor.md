# Cognitive Ability vs. Motor Skills
> LLMs and autopilot NNs solve fundamentally different problems with fundamentally different architectures. Even humans have separate systems for thinking and moving.

**Status:** stub — data dump for future exploration
**Created:** 2026-02-12
**Links:** [Cyborg Model](./cyborg-model.md), [LLM Grounding Problem](./llm-grounding-problem.md)

## The Core Distinction

There are two fundamentally different types of intelligence at play:

### Cognitive / Deliberative (System 2)
- Planning, reasoning, language, analysis, judgment
- Slow, sequential, energy-intensive
- **Human hardware:** Prefrontal cortex
- **AI equivalent:** Large Language Models (transformers)
- Operates on abstract representations — text, symbols, concepts

### Sensorimotor / Reactive (System 1)
- Real-time physical control, spatial awareness, reflexes, coordination
- Fast, parallel, unconscious, trained through repetition
- **Human hardware:** Cerebellum, motor cortex, basal ganglia
- **AI equivalent:** Convolutional NNs, reinforcement learning, autopilot systems
- Operates on sensory data — images, lidar, force feedback, proprioception

## Why This Matters

These are **architecturally separate** — in both humans and AI:

- A human can reason about how to drive (cognitive) while their body handles the steering, braking, and micro-adjustments (motor). These are different brain systems.
- An LLM can reason about what a robot should do (cognitive) but cannot directly control the motors. A separate NN handles real-time physical control.
- Tesla's autopilot and ChatGPT are both "AI" but share almost nothing architecturally. They solve different problems with different approaches.

## Implications for the Cyborg Model

Current AI agent teams (Opus 4.6, Claude Code) are **pure cognitive systems.** They reason, plan, coordinate, and generate — all in the text/code domain. They have no motor component.

Physical world interaction requires either:
1. **Humans** — who have both cognitive and motor systems integrated
2. **Robots** — which need both an LLM-like planning layer AND a motor control layer
3. **Hybrid systems** — AI plans, human or robot executes physically

This is why "execution" still has a human column in the [cyborg model](./cyborg-model.md). The cognitive execution gap is closing fast. The motor execution gap is a different problem entirely.

## Topics to Explore
- How do the two systems interact in humans? (Cognitive override of reflexes, muscle memory, flow states)
- What's the state of robotics in closing the motor gap?
- Can LLMs serve as the "planning layer" for robotic systems effectively?
- How does latency affect the cognitive/motor boundary? (Real-time control needs millisecond response; LLMs operate in seconds)
- The training difference: motor skills train on continuous sensory streams with immediate feedback; cognitive skills train on discrete symbols with delayed feedback — mirrors the CEO training problem
- Embodied cognition theory: does true understanding require a body?

## Tags
[ai](../tags/ai.md), [llm-limitations](../tags/llm-limitations.md), [cognitive-motor](../tags/cognitive-motor.md)
