---
status: active
created: 2026-10-07
published: true
layout: layouts/page.njk
title: "The AI Decomp Wave — Outside Confirmation"
discussion: folded-in
---
# The AI Decomp Wave — Outside Confirmation
> A popular explainer on AI agents decompiling games gives the same reason the vault's method works: decompilation has an answer key, so an agent can check its own work. Chris took it as outside confirmation that others are doing similar things and we are on the right track. The video covers the flashy outputs (ports, mods). The vault works on the quieter layer: mechanics, automation, TAS and readability.

**Links:** [Repairing LLM Code — The Two Oracles](./repairing-llm-code.md) — the vault already went past the video here: the answer key covers only *correctness*, [Transpilation as a Grounding Strategy](./transpilation-as-grounding.md) — why we built our own decompilers instead of using Ghidra, [The Contract Model vs. the Substrate Model](./contract-vs-substrate.md) — agent field notes as a substrate that compounds, [Failure as Mandate](./philosophy/dynamics/failure-as-mandate.md) — Chris's moderate IP position, [KOEI AI & combat evolution](./gaming/koei-ai-combat-evolution.md) — a sample of the "mechanics" output, [Game Annotation Series](../projects/game-annotation/README.md)

**Source:** [YouTube — Slop Architect](https://www.youtube.com/watch?v=rRQzrQLZRWM) (~18 min, references events through 2026-10-03) — [transcript](../raw/yt-rRQzrQLZRWM.transcript.txt), [meta](../raw/yt-rRQzrQLZRWM.meta.md)

## What the video claims
1. **Decompilation has an answer key.** A matching decomp has to recompile byte-for-byte identical to the original. So an agent can write, compile, compare and retry all night, and run as a swarm because a game breaks into thousands of separate functions. Tools: Ghidra, debuggers, compilers, and play-testing through faked inputs and screenshots as a second check.
2. **The speed claims.** Hand-done decomps took 2–6 years (OoT, Paper Mario, Majora's Mask). *LSD Dream Emulator* had all 1,446 functions matched in about a month, with all the C written by Claude Code. decomp.dev counted 13 games ever at 100% before September and 24 more since, with about half showing AI in their history (the narrator's own count). On MW2, one person ran 17 Claude agents for about 2 months and matched ~¾ of ~16k functions, using ~200B tokens on a $200/month plan.
3. **What gets built on top.** GoldenEye was decompiled by humans over 9 years, then turned into a native PC port in 43 days. Melee hit 100% with Claude as the #4 contributor. Halo (2001) runs on a 3DS and hosted a 128-player match. "Universal Modder" is a Claude Code plugin whose agents write **field notes** back to the project "so the next agent starts smarter."
4. **The pushback and the hype.** The Pokémon decomp projects ban AI, and the Zelda/Banjo recomp developers fight "slop comps." Most X-inside-Y mashups are pass-throughs (both games running at once), not decomps. "Fortnite rewritten in Rust in half a day" was a prototype. Real work takes weeks or months, with people steering.
5. **The legal and industry case.** Reverse engineering for compatibility can be fair use (*Sega v. Accolade*, *Sony v. Connectix*), but rebuilding a game exactly is murkier. That's why projects ship no assets and you bring your own copy. Takedowns are already happening (the MW2 tracker, Fallout New York). Mods became whole genres (CS, Dota, battle royale, auto-chess), so studios should work with modders rather than sue them.

## Discussion
**Chris's read: confirmation, not news.** *"It was mostly acknowledgment that others are doing similar things and we are on the right track."*

- **Flashy vs. mechanics.** *"He is mostly focusing on the 'flashy' bits this type of work can create. Ports and mods tend to get headlines because they create new works that people find value in. We have just explored mechanics, automation and even now TAS as a way to extend the life of the current game."* The vault's output is *understanding* of the original (e.g. the [KOEI AI study](./gaming/koei-ai-combat-evolution.md)), not a new game made from it.
- **Legality: ideas vs. code.** *"The code is copyright, but the ideas are not. Conversions to new languages should be fair game, but releasing a modified version of the same codebase starts to cross lines. We have only ever released conversions to my knowledge."* He agrees with the video's industry conclusion: *"accepting a modding community is usually the right call for any game as it extends the life of it."*
  - *Claude's caveat (unresolved):* US copyright law lists a **translation** as a kind of derivative work, so a language conversion is not automatically safe. Ranked by how defensible the output is: **analysis of mechanics** (ideas, clearly safe) > **interoperability/research decomp with no ROM included** (e.g. [GK](../projects/game-annotation/nes/gk/README.md): "ROM not included") > **a modified version of the same code**. On this ranking the research pages are the most defensible output, more than the repos. This is not legal advice.
- **The answer key is something we already learned.** *"I am not sure we ever tried to compile C to exact bin, but we have proven bytecode to bin. But proving answers by checking against the code is something we learned well."* That is the [two-oracle](./repairing-llm-code.md) correctness layer, reached independently.
- **Our own decompilers, not Ghidra.** *"We didn't use Ghidra, instead we built our own decompilers."* This follows from classifying the architecture first: KOEI's titles are a bespoke bytecode VM, which Ghidra's 6502/65816 support doesn't cover ([transpilation-as-grounding](./transpilation-as-grounding.md)).
- **Skills plus self-improving docs.** *"I like how he gives examples of skills to help create new mods, and even better the documentation so the process improves, which is kinda like what we do."* The field notes are the same idea as `/label-walk` plus the memory system. The difference is maintenance: the vault registers new notes in an index and evicts old ones, while the plugin as described only appends.

## Where the vault is ahead, and the one thing to borrow
- **Ahead:** the answer key certifies *correctness*. *Readability* has no lower oracle ([two oracles](./repairing-llm-code.md)). Naming and data/var-walks, the step from "matches" to "understood," is the part the video never mentions.
- **Borrow:** in a matching decomp, the *C itself* is certified by round-trip. In the vault's pipeline, C is checked against the asm but never recompiled. That gap is how a dangling `goto` survived in v2. See open questions.

## Open Questions
- **A C→KOEI-bytecode recompiler** (the inverse of the decompiler) would certify the C by byte-identical round-trip, the matching-decomp standard. Would it replace the proposed asm-differential certifier in [repairing-llm-code](./repairing-llm-code.md)'s open questions, or add to it? Raised as an idea, not a plan.
- Where exactly does a published *conversion* sit legally (derivative-work translation vs. interoperability fair use)? Unresolved, and Chris's view and Claude's caveat differ.

## Tags
[ai](../tags/ai.md), [decompilation](../tags/decompilation.md), [reverse-engineering](../tags/reverse-engineering.md), [grounding](../tags/grounding.md), [claude](../tags/claude.md), [youtube](../tags/youtube.md)
