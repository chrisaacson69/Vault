# game-design

Pages tagged **game-design** — mechanism analysis and structural evolution of games (turn structure,
verb viability, capital allocation) read as design specimens.

- [L'Empereur — the two-tier turn (NES→SNES design hinge)](../research/gaming/lempereur-two-tier-turn.md)
- [Breaking Down an SNES Cart — the teardown method](../research/gaming/snes-cartridge-teardown.md) — the platform layer under future SNES design specimens; the architecture that shapes what games could do
- [KOEI's portable VM (SNES ROTK2 reversal)](../research/gaming/koei-snes-portable-vm.md) — first KOEI SNES title reversed; byte-for-byte portable bytecode VM, faithful port + facelift (NES↔SNES comparison)
- [Gemfire (SNES) fully decompiled](../research/gaming/gemfire-snes-decompiled.md)
- [Nobunaga's Ambition (SNES) — the VM exception](../research/gaming/na1-snes-native-port.md) — same game, two compile targets (NES bytecode VM vs SNES native); the execution layer got *simpler* on the later console
- [NA1 NES↔SNES — grading two blind reverse-engineerings](../research/gaming/na1-nes-snes-blind-regrade.md) — SNES-derived vs NES-derived, all 5 sections converge (record bytes, Grow formula, event cadence, weakest-neighbour AI, 8-stat combat table); create-then-check method
- [Battlezone (1980) — 3D Without a Multiply Instruction](../research/gaming/battlezone-mathbox.md) — hardware constraint as design: cull-before-transform pipeline reordering, a loose 90° frustum test that is *correct* because it must be conservative, and errors budgeted into the art rather than fixed in code
- [Arithmetic Scarcity and the 3D Problem](../research/gaming/arithmetic-scarcity-3d.md) — Doom's constraint list reads as a design document, not an optimization: what the level editor *refuses to build* is what makes the renderer tractable; the strategy choice as a dominance frontier over silicon / cycles / design freedom / art budget
- [Stellar 7 (1983) — The Same Game Without the Coprocessor](../research/gaming/stellar7-software-3d.md) — the mesh format *is* the optimization: polar vertices make rotation an `ADC`, and the shared-vertical-edge shortcut biases every shape in the game toward boxes — data co-designed with code, visible in the art
- [Risk — The Attrition Constant](../research/gaming/risk-attrition-odds.md) — a Risk battle solved exactly as an absorbing Markov chain; the 3-vs-2 dice cap fixes the engagement frontage regardless of stack size, so attrition is Lanchester-LINEAR and concentration of force buys nothing
