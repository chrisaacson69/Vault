---
status: active
created: 2026-10-16
---
# REA (Reverse Engineer Anything) — Candidate Tool
> An MCP harness that lets Claude Code drive Ghidra, IDA or Hopper in a question-and-answer loop. Recorded as a **candidate** for moo1-re. Not installed and not yet trialled.

**Links:** [moo1-re](../../projects/moo1-re/README.md) (the target it might serve) · [Data-First RE](../../method/data-first-re.md) (where it would slot in) · [The AI Decomp Wave](../ai-decomp-wave.md) (same trend, earlier video) · [Transpilation as Grounding](../transpilation-as-grounding.md) (why the KOEI work skipped Ghidra)

**Source:** [YouTube: Low Level, "I Tested The Viral Reverse Engineering Repo"](https://www.youtube.com/watch?v=qFEuYUfauNY) (~16 min) · repo [morluto/rea](https://github.com/morluto/rea) (MIT, created 2026-04-14) · site rea.tools · npm `rea-agents`

## What it is
- **An MCP server plus a skill. It is not a decompiler.** It drives decompilers you install yourself: Ghidra, IDA, Hopper, Kuna and JEB. It can also call Rizin or objdump for offline inspection. Answers come back with evidence: offsets, code fragments and stated limits.
- **What it automates:** the RE loop of asking the decompiler a question, reading the answer, and asking the next question.
- **Formats:** ELF, PE and Mach-O, plus WASM, .NET, APK, Electron apps and firmware. For 16-bit DOS, the README says Ghidra handles it and points to a **TH04** showcase (Touhou 4, a PC-98 DOS game). **MZ overlays and LE are not mentioned.**
- **Setup:** `npx rea-agents setup`. Needs Node ≥ 22.19.

## What the video showed
- He rebuilt GNOME Calculator from its binary (~936 KB, ~2k functions) into Python in about 28 minutes. It looked close but had UI bugs.
- **His own caveat:** other people got similar results with plain Claude plus a Ghidra MCP and no REA. He calls it guard rails, not new capability.

## Fit for moo1-re (Claude's assessment, 2026-10-16)
- **Its main use doesn't apply here.** REA's headline use is rebuilding a whole app, and for MOO1, 1oom already is that rebuild. Running that flow would break reuse > rebuild.
- **The part that could help is asking specific questions.** The open targets are the diplomacy and random-event code in STARMAP.EXE. Data-first RE named the data, and REA might find the code that reads it.
- **Calibrate it before trusting it.** First ask about a known answer, for example the race-relations table at `ORION.EXE` 0x22D6A or a ship-tech table already checked against the binary. Check that the code REA finds matches 1oom's formula. This applies verification-independence to the tool itself.

## Cautions
- **Copycats:** the README warns that look-alike repos and copied READMEs are not official. Star counts in different sources range from ~37k to ~290k. Install only from the official repo or npm package.
- **Not a sandbox:** text inside a binary can read like instructions to the agent. That's low risk for a 1993 EXE, but keep the working directory outside the vault.
- **Overlays:** if STARMAP uses Borland overlays and Ghidra can't load them, the tool is blocked before it starts. This is the first thing a trial should check.

## Open Questions
- Does Ghidra (and therefore REA) load STARMAP.EXE's overlays, or only the root segment?
- Does REA add anything over a bare Ghidra MCP (e.g. [ReVa](https://github.com/cyberkaida/reverse-engineering-assistant)) for this workflow? The video's control-test remark suggests it may not.

## Tags
[reverse-engineering](../../tags/reverse-engineering.md), [decompilation](../../tags/decompilation.md), [claude](../../tags/claude.md), [youtube](../../tags/youtube.md)
