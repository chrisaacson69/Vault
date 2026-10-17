---
status: active
created: 2026-10-16
---
# REA (Reverse Engineer Anything) — Candidate Tool and Harness Teardown
> An MCP harness that lets Claude Code drive Ghidra, IDA or Hopper in a question-and-answer loop. It was recorded as a candidate for moo1-re, then **torn down (2026-10-16) to see what a mature RE harness does that ours doesn't**. Not installed. Ghidra isn't installed either.

**Links:** [moo1-re](../../projects/moo1-re/README.md) · [Data-First RE](../../method/data-first-re.md) (the DOS overlay wall) · [The AI Decomp Wave](../ai-decomp-wave.md) (earlier video, same trend) · [Transpilation as Grounding](../transpilation-as-grounding.md) (why the KOEI work skipped Ghidra) · [Contract vs. Substrate](../contract-vs-substrate.md) (the frame for the comparison) · [Theory of the Firm](../economics/theory-of-the-firm.md) (build vs. buy) · [Jevons for Software](../economics/jevons-software-demand.md)

**Source:** [YouTube: Low Level, "I Tested The Viral Reverse Engineering Repo"](https://www.youtube.com/watch?v=qFEuYUfauNY) (~16 min, mostly an overview) · repo [morluto/rea](https://github.com/morluto/rea) (MIT, created 2026-04-14; shallow clone read at `d5be402`, 2026-10-17 +0800; 61 MB, TypeScript) · npm `rea-agents`

## What it is
- **An MCP server plus a ~355-line skill. It is not a decompiler.** You install the decompiler yourself (Ghidra, IDA, Hopper, Kuna or JEB). It also covers WASM, .NET, APK, Electron, firmware and packet captures.
- **What the video showed:** a rough Python rebuild of GNOME Calculator from its ~936 KB binary in 28 minutes. **His own caveat:** a plain Ghidra MCP with no REA gets similar results.

## Fit check (measured, not guessed)
- **DOS:** Ghidra loads MZ files as `x86:LE:16:Real Mode`, but `docs/ghidra-dos.md` says **appended overlays are excluded** from analysis. Checking the headers: **STARMAP.EXE is 563,328 bytes, and 281,392 of them (50%) are a Borland `FBOV` overlay**. ORION.EXE has a 33,792-byte `FBOV` overlay. So REA alone sees at most half of STARMAP, and the turn logic may be in the half it can't see. Getting past this would need a step that splits out the FBOV overlays first. This is zappatic's relocation/overlay wall again.
- **8-bit:** raw **NMOS 6502 only**, one image of up to 64 KB. No iNES headers, mappers, bank switching or 65816 support, and Ghidra can't decode KOEI bytecode. The use it does have here is as an **independent second decompiler for native 6502 code**, a cross-check on our own decompilers. That's verification-independence, not replacement.
- **Verdict:** using it on MOO1 now isn't worth the time and tokens. The overlay wall comes first, and 1oom already covers most of what a rebuild would give.

## What a mature harness does — and how ours compares
| REA technique | Our nearest equivalent | Read |
|---|---|---|
| Every result is an **Evidence record**: an ID, coverage, limitations, and observation vs. inference vs. unknown kept separate | The rule that a learned fact records its cause (projects SDK) | They enforce it **in the schema**. We enforce it in prose. Worth borrowing as a field convention for findings files. |
| **`record_unknown` / `update_unknown`**: a registry of open questions with revisions and supporting/contradicting evidence IDs | `## Open Questions` sections, matched with grep | Vault/CLAUDE.md already names our failure: questions get re-asked or answered without anyone noticing. This is the mechanical fix. **Strongest thing to borrow.** |
| "**Missing coverage is unknown, not absence**": a bounded negative search stays bounded | The zero-yield-is-a-wrong-path rule | Same instinct, with REA's version applied per result. |
| **Load-image verification**: digest the loaded program against the file bytes and relocations | The EXE byte-search verifier (moo1-re) | Verification-independence at the loader layer. Our tools assume the loader is right. |
| **Reconstruction obligation ledger**: a claim closes only when a verifier of *comparable authority* passes | The oracle ladder (data-first-re) | The same thing written as a closure rule. |
| **Summary first, then page through retained results**, with token-cost **measurements** in `experiments/analysis-efficiency/` (e.g. 4 selective replies cost more than 1 full dossier) | Coordinator holds context and curates the working set | They measure. We don't. Their numbers are relevant to cost-conscious runs. |
| Primitives over workflows; add a workflow only after repeated use shows it's needed (`docs/tool-design.md`) | Skills appear after a pattern repeats | Same rule. |
| `annotate_native_function` writes a name and reads it back, **but edits are discarded on close** | The `.toml` symbol registry, which persists | **We're ahead here.** REA is a per-delivery *contract*. The vault is *substrate*. |

**Could we build it?** The core is an MCP wrapper over headless Ghidra plus an evidence schema, so yes. But reuse beats rebuild: REA is MIT-licensed and already works. The part only we would build is the **persistence bridge**: exporting Ghidra annotations into our symbol registries so they survive the session.

## Discussion — the teardown (Chris, 2026-10-16)
- **Decision: borrow, don't replace.** *"I think its best to borrow tools/ideas from REA than to replace our harness."* Some of the table we found independently. The rest is worth adopting.
- **Code over prose.** *"Enforcing rules through code vs prose seems like a good idea.. only use tokens when we need inference."* That's the general form of the `raw/` hook: if a rule can be checked mechanically, it belongs in a schema or a hook, not in an instruction. The accounting and checklists (evidence records, the unknowns registry, the end-of-investigation checklist in REA's skill) are the first candidates.
- **Persistence was the point.** He's glad we persist better *"as we made this a key output of the tool."*
- **Multi-agent cost, as Chris has observed it:** *"I have seen multi-agent runs use up a week's worth of tokens in a couple days while a single threaded agent gets the job done in the same amount of real time (the agents have to keep pausing at token limits), for less budget."* Rate limits cancel out the parallel speedup, so the extra spend buys nothing. This fits REA's habit of measuring delivery cost instead of assuming it.
- **The DOS mapping isn't a dead end.** The overlay wall is real, but REA's DOS profile (Ghidra load segment fixed at `0x1000`, linear address = `seg×16+off`) makes zappatic's failed manual join ([part 5](../gaming/moo1/zappatic-stream/part05.md): RAM `0813:92FC` = Ghidra `1468:4B7C`, delta `0x7DD0`) solvable by formula. `0x1000 − 0x7DD = 0x0823 = 0x0813 + 0x10`, which is the PSP plus 16 paragraphs, the usual MZ image base. So for the **root module**, *Ghidra linear = DOSBox linear + (0x1000 − (PSP+0x10))×16*. *Claude's inference from one data point.* **Verified live the same day** (see Open Questions): the formula holds, and overlays turned out to be cheap too (one more term, at offset `:0000`).

## Discussion — the closing claims
Low Level's three concerns: (1) all software becomes abandonware (who maintains a one-shot clone?), (2) clones are a supply-chain risk, (3) companies will protect their IP by moving software to the cloud, VDI or web apps.

- **Chris: buy vs. build.** *"It is like buying a house vs building it yourself. Can I vibe-code Adobe? Maybe. Do I want to spend the time to do so? Probably not."* There's still value in *doing* the thing (understanding), and that's separate from replacing the product.
- **Claude's tie-in:** this is [Coase](../economics/theory-of-the-firm.md). Cheaper production moves the build/buy boundary inward, but it doesn't remove it. **Concern 1 is the reason why:** the cost that didn't fall is *maintenance*, the [cyborg model's](../cyborg-model.md) input that stays expensive. [Jevons](../economics/jevons-software-demand.md) predicts more software, not less paid software.
- **Symmetric check on concern 3:** the true core is that work moving server-side is real and ongoing. But subscription revenue was already driving that move, so RE tools aren't needed to explain it. And his "can't RE a web app" is only partly true, since REA itself observes browser behavior. The IP line is still code vs. ideas (see the [legality discussion](../ai-decomp-wave.md)).

## Open Questions
- ~~Does Ghidra load STARMAP.EXE's overlays?~~ **Resolved 2026-10-16: no.** REA excludes appended overlays, and half of STARMAP is FBOV (measured above).
- Would an FBOV overlay splitter (one raw image per overlay, loaded by Ghidra) unlock Ghidra for MOO1? Is anything in 1oom or zappatic's notes already that splitter? *(2026-10-16: the layout is decoded, giving 25 overlays, each `[file, size, fixups]` from the root stubs (`dos_addr.py map`). A splitter is now just slicing. Not built.)*
- ~~Does the root-module formula hold on a second DOSBox match with an observed PSP? If so, it answers the address-join half of [data-first-re](../../method/data-first-re.md)'s DOS-debugger question.~~ **Resolved 2026-10-16 → yes, live, for both EXEs.** Steam DOSBox 0.74: PSP `0192` observed (MCB owner), B = `01A2`. Relocations match 2990/2991 (STARMAP) and 1899/1900 (ORION); the one miss in each is a saved-vector variable. All 31 table-sweep tables sit at `B×16 + file_off − header`. **FBOV overlays load at `<buffer>:0000`**, so a runtime offset *is* the in-overlay offset: zappatic's fleet-count `inc` `4E23:1839` = overlay #71 + `0x1839`, and was observed live at `4DF4:1839`. The Ghidra form (B = `0x1000`) is still unverified (not installed). Tool + evidence: moo1-re `tools/dos_addr.py`, `notes/dos-address-join.md`.
- ~~Should the vault adopt an unknowns registry (REA's `record_unknown`) as a tool over the `## Open Questions` sections?~~ **Resolved 2026-10-16 → yes, derived:** [`tools/open-questions.py`](../../tools/README.md#open-questionspy--the-open-questions-registry-the-recall-half-of-reuse-over-rebuild) generates [the registry](../../notes/open-questions.md) from the pages. Kept: ID, status, asking page, resolved-by links, resolution note. Dropped: the revision counter (git does that) and contradicted-by (nothing on the pages marks it).
- Does REA add anything over a bare Ghidra MCP (e.g. [ReVa](https://github.com/cyberkaida/reverse-engineering-assistant))? The video suggests not much.

## Tags
[reverse-engineering](../../tags/reverse-engineering.md), [decompilation](../../tags/decompilation.md), [claude](../../tags/claude.md), [youtube](../../tags/youtube.md)
