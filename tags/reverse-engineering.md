# reverse-engineering
> Files about reading, annotating, and explaining existing code at a system level.

- [Game Annotation Series](../projects/game-annotation/README.md) — narrating already-disassembled code at a layer the comments don't reach
- [Adventure (Atari 2600)](../projects/game-annotation/adventure/README.md) — eight chapters from memory map through Easter egg
- [Mappy (Famicom/NES)](../projects/game-annotation/mappy/README.md) — eight chapters from reset/NMI through bonus rounds; cumulative LLM-interpretation findings build the NES idiom library
- [Utopia (Intellivision)](../projects/game-annotation/utopia/README.md) — eight chapters; full economic engine extracted from CP1610 source; closed-loop adaptive AI in 1981; M.U.L.E. queued as the next paired comparison
- [TIA Reference](../research/atari-2600/tia-reference.md) — Atari 2600 chip docs distilled for source-reading
- [NES Research](../research/nes/README.md) — PPU/APU/Mappers references distilled for source-reading
- [Transpilation as a Grounding Strategy](../research/transpilation-as-grounding.md) — the RE payoff: bytecode→C transpile (Nobunaga's Sea-16 VM) as the general technique, COBOL modernization as the application
- [pygone teardown](../projects/pygone/teardown.md) — the inverse of decompilation: readable Python compressed to a 4 KB blob; annotated search/eval stack
- [Decompiler is a Reverse Compiler — bottom-up atom inversion](../projects/game-annotation/nobunaga/decompiler-bottom-up-thesis.md) — census proves NA1's engine is 100% reducible (no irreducible control flow); the V2 "irreducible residue" was a top-down phantom; invert a finite compiler-lowering table instead
- [Lowering Atlas](../projects/game-annotation/lowering-atlas/README.md) — the forward complement: compile known C constructs through GCC `-O0`, catalog the CFG signature each leaves, source the finite atom table without reverse-engineering each sub one at a time
