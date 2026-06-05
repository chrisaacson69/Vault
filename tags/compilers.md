# compilers
> Files about how compilers lower source to code, and the inverse (decompilation / structuring).

- [Lowering Atlas](../projects/game-annotation/lowering-atlas/README.md) — compile known C control-flow constructs through GCC `-O0` and catalog the CFG signature each leaves; the finite inverse-lowering table for the Nobunaga decompiler, sourced forward
- [The Atom Table](../projects/game-annotation/lowering-atlas/atom-table.md) — construct → CFG fingerprint catalog (if/loop/switch/&&-||/guard-chain), cross-checked against NA1's reducer atoms
- [Decompiler is a Reverse Compiler — bottom-up atom inversion](../projects/game-annotation/nobunaga/decompiler-bottom-up-thesis.md) — NA1's engine is 100% reducible; decompilation = invert a finite table of compiler lowerings, bottom-up
