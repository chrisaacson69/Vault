---
status: reference
created: 2026-05-17
---
# Claude Code Skill Engineering — Principles & Vault Audit
> The best use of Claude is **tools-layer tools and pointers**. Three independent sources converge on this: Anthropic's EBM/JEPA architectural prescription (LM → constraint engine → verifier), Anthropic engineers' published skill patterns (description → instructions → tools, with most leverage in tools), and Pocock's 68k-star repo executing the pattern in practice. Same architecture at three scales — between models, within a skill, across a catalog. The LLM is the language organ; the real work is deterministic tools that the LLM coordinates through pointer-based markdown. This page is the unified thesis, the reference card, the audit of the 9 current vault skills, and the borrowables list from Pocock.

**Links:** [Working With Claude](./working-with-claude.md), [Karpathy LLM Wiki — Independent Convergence](./karpathy-llm-wiki-convergence.md), [The Context Cache Hierarchy](./context-cache-hierarchy.md), [Principled LLM Code](../research/principled-llm-code.md), [Career Strategy — The Performative Loop](../career/strategy.md), [Tools Roadmap](../career/tools-roadmap.md), [Planner-LM Composites](../research/planner-lm-composites.md), [Energy-Based Models](../research/energy-based-models.md), [Level 6 — Direct Execution](../research/level-6-direct-execution.md), [Game Annotation Series](../projects/game-annotation/README.md) — ch 7 methodology shift is the canonical "build a feedback loop" exercise

**Primary sources (three videos, one architecture):**
- [Aleph and Energy-Based Models](https://www.youtube.com/watch?v=NYmXYF8A3Q4) — Turing Post, 2026-05-15. The three-layer reasoning stack (LM / EBM / formal verifier). ([transcript](../raw/yt-NYmXYF8A3Q4.transcript.txt))
- [How Anthropic Engineers ACTUALLY Prompt Claude Code](https://www.youtube.com/watch?v=qOvc9IUKEIc) — Austin Marchese, 2026-05-15. Three-layer skill structure (description / instructions / tools). ([transcript](../raw/yt-qOvc9IUKEIc.transcript.txt))
- [He Open-Sourced His Claude Folder. 68K Stars](https://www.youtube.com/watch?v=z0y1nuiXdoc) — Bitwise AI, 2026-05-10, walking [mattpocock/skills](https://github.com/mattpocock/skills). 17 atomic markdown files pointing at scripts and shared docs. ([transcript](../raw/yt-z0y1nuiXdoc.transcript.txt))

---

## The unified thesis — tools and pointers at three scales

The same architectural claim shows up three times, from three different angles:

| Scale | What gets separated | The LLM's job | The tools' job |
|---|---|---|---|
| **Between models** ([EBM](../research/energy-based-models.md)) | Language model ↔ Energy-based constraint engine ↔ Formal verifier (Lean) | Communicate, render intent | Score whole states against constraints; certify the score |
| **Within a skill** (Marchese) | Description ↔ Instructions ↔ Tools (scripts, APIs, references) | Trigger and orchestrate | Do the deterministic work |
| **Across a catalog** (Pocock) | 17 atomic SKILL.md files ↔ shared scripts ↔ project docs (CONTEXT.md, ADRs) | Pick the right skill, follow its short playbook | Each tool does one thing reliably |

The pattern is fractal. Whether you're designing a research-grade reasoning system (EBM + Lean) or a personal skills repo (Pocock), the same shape recurs: **a small fluent component routes work to a larger deterministic substrate, with explicit narrow interfaces between them.** The mistake — at every scale — is asking the fluent component to do the deterministic work. That's "LLM solves Sudoku by writing a Python script per problem" (no shared validator), "skill that's all prompt and no tools" (regenerated logic every session), or "12-agent orchestrated framework" (process owns the work, no way to fix specific failures).

Pocock's repo is the empirical proof at the bottom scale: 68,000 stars in 90 days for a folder of markdown files, beating Spec-Kit and BMAD on stars while being a fraction of their complexity. *"Markdown the agent reads on demand. No runtime, no orchestrator, no 12-agent hierarchy."* The market voted for the smaller, atomic, pointer-based pattern over the framework-with-process pattern. The same vote ratifies the [planner-LM composites](../research/planner-lm-composites.md) architectural prescription at one layer up, and the [EBM three-layer stack](../research/energy-based-models.md) at one layer above that.

**The actionable form of the thesis:** if you can use code instead of an LLM, you should. If you must use an LLM, scope it to language coordination and put the actual work in tools the LLM points at. The architecture compounds because tools accumulate while prompts evaporate.

---

## The 4 rules + 2 patterns

| # | Rule | Vault status |
|---|---|---|
| 1 | **Prompt skills, not Claude.** Skills are the application layer; OS analogy — Anthropic builds the model, you build the apps. | ✅ Doing this. 9 user-invocable skills cover the recurring vault work. |
| 2 | **Skills are more than prompts.** Three layers: *description* (gating auto-invoke), *instructions* (the playbook), *tools* (scripts, APIs, references). Most leverage lives in layer 3, but most people stop at layer 2. | ⚠️ Layer 3 is light — see [gap #1](#gap-1-saved-scripts-the-srt-cleaning-tell). |
| 3 | **Build composable, not custom.** Small focused reusable skills > one giant skill. | ✅ Strong. Dispatcher → handler → specific tool hierarchy ([[feedback_skill_layers]]). vault-ingest → content-extract → video-extract → yt-dlp. |
| — | Pattern A: **Save scripts inside skills.** *"Claude kept rewriting the same Python script every session."* Code is deterministic, tokens are stochastic. | ❌ **Not applied** — see [gap #1](#gap-1-saved-scripts-the-srt-cleaning-tell). |
| — | Pattern B: **Invocation flags.** `user-invocable: false` hides from `/`-menu (agent-only). `disable-model-invocation: true` forces user-only (high-risk: deploy, send-message, delete). | ⚠️ All 9 skills are `user-invocable: true`; none use the inverse flags. Fine today, worth a guideline — see [gap #2](#gap-2-no-flag-discipline-for-future-risk). |
| 4 | **Skills get smarter every session.** *"Is this a one-time fix or should this be in the skill forever?"* Update the skill after every use; the compounding loop. | ⚠️ Implicit — memory system covers part of it. Worth an explicit trigger — see [gap #3](#gap-3-the-compounding-loop-is-not-explicit). |

## Where the vault is already doing this right

The principles aren't new news — they're external validation of choices already baked into the vault's skill setup since it was built. Specifically:

- **Layer 1 descriptions are sharp.** Every skill has trigger phrases ("when the user says X, Y, or Z"). Marchese's #1 specific recommendation. Already in place.
- **Composability over monoliths.** vault-ingest doesn't do extraction itself — it dispatches to `shared/content-extract.md`, which dispatches to `shared/video-extract.md`, which calls `yt-dlp`. Three levels of indirection, each replaceable. ([[feedback_skill_layers]] is the memory entry naming this.)
- **Cross-skill chaining.** vault-ingest calls vault-sync at the end. debate-review consumes the same content-extract pipeline. Each skill stays atomic; the dispatchers compose them.
- **Pointer-based markdown does the work.** SKILL.md files are short (60–80 lines). The actual procedural knowledge lives in `shared/*.md` files that multiple skills link to. Updates to a shared file propagate to every skill that references it. This is Marchese's "improvements compound" point applied at the file level.
- **The architecture is the portfolio.** ([[user_career_priorities]]) Anthropic engineers are publicly making the same argument to a 167k-subscriber audience. The market is converging.

## Audit findings — where the vault deviates

### Gap #1: Saved scripts (the SRT-cleaning tell) — ✅ **FIXED 2026-05-17**

**The pattern:** Marchese quotes Barry: *"Claude kept rewriting the same Python script every session, so we asked Claude to save it inside the skill as a tool. Now we just run the script and that makes everything a lot more consistent, a lot more efficient."*

**The vault's tell:** `shared/video-extract.md` described SRT cleaning as a 5-step procedure that Claude executed ad-hoc, regenerating inline Node code every ingest. In the 2026-05-17 session this happened *three times* across three video ingests — same logic, three stochastic regenerations.

**The fix (applied 2026-05-17):**
- [`.claude/shared/scripts/clean-srt.js`](../.claude/shared/scripts/clean-srt.js) — strips sequence numbers, timestamps, consecutive duplicates; emits flat transcript
- [`.claude/shared/scripts/yt-meta.js`](../.claude/shared/scripts/yt-meta.js) — extracts the fields actually used from yt-dlp's `info.json` (title, channel, duration, upload_date, view_count, truncated description)
- `shared/video-extract.md` updated to point at both scripts instead of describing the procedure

Invocation is now `node .claude/shared/scripts/clean-srt.js <in> <out>` and `node .claude/shared/scripts/yt-meta.js <info.json>`. Deterministic, cheap, repeatable. **This is the unified thesis applied to itself** — the skill's tool layer is now actual saved tools, not regenerated prompt fragments.

**Still candidate for future scripts** (lower priority — only fix once the pattern repeats):
- yt-dlp invocation as a shell wrapper with the standard vault flags locked in
- SRT cleaning extension to preserve paragraph breaks if a future ingest needs it

### Gap #2: No flag discipline for future risk

**The pattern:** two flags exist that none of the current skills use:
- `user-invocable: false` — hides skill from `/`-menu; only dispatchers call it. Good for low-level sub-skills.
- `disable-model-invocation: true` — only the human can call it; the model can't auto-invoke. Good for destructive or external-effect actions (deploy, force-push, send-message, delete-vault-pages).

**Current state:** all 9 vault skills are `user-invocable: true` and none disable model invocation. *This is fine for what they do* — every current skill is read/write inside the vault directory, no external effects. But the moment a skill is added that, say:
- Pushes to GitHub
- Sends an email or Slack
- Deletes pages
- Deploys infrastructure

...the `disable-model-invocation: true` pattern should be the default, not an afterthought.

**Recommended guideline (vault-specific):**

| Skill action class | `user-invocable` | `disable-model-invocation` |
|---|---|---|
| Read-only / synthesis | `true` | `false` (default) |
| Vault-local write (current skills) | `true` | `false` |
| External effect (push, send, deploy) | `true` | **`true`** |
| Internal sub-skill called by dispatcher only | **`false`** | `false` |

No retrofitting needed on existing skills. This is a forward-looking rule for the next skill that crosses a system boundary.

### Gap #3: The compounding loop is not explicit

**The pattern:** Marchese's rule #4 — *"Every time you run a skill and the output isn't exactly what you want, ask: is this a one-time fix or should this be in the skill forever? If forever, update the skill."* Compound improvements every session.

**Current state:** the vault's memory system does part of this (corrections become `feedback_*` memories, picked up next session). But there's no explicit "after the skill finishes, audit it" trigger. Improvements happen when Chris notices them; they don't happen by default.

**Two ways to make this explicit:**

1. **At the end of each skill's procedure**, add a step: *"If anything in this session would have been better as a skill rule, propose the change."* Cheap but adds noise to every run.

2. **A meta-skill `/audit-skill <name>`** that takes a skill name + recent chat history and proposes additions. Marchese gives the prompt template: *"Review the back and forth I just had after using this skill. Can we enhance the skill so this is handled automatically or we don't make the same mistake again?"* Doesn't run every session; runs when something felt off.

Option 2 is more in keeping with vault style — discrete, on-demand, doesn't bloat the per-skill procedures.

## The shared principle

The reason these patterns work is the same reason the vault works at the *knowledge* level: **minimal locally-stored content, pointers to authoritative sources, the system gets smarter through accumulation rather than rewriting.**

| Layer | Vault knowledge | Vault skills |
|---|---|---|
| Atomic unit | A vault page (~60-80 lines, single topic) | A SKILL.md (~60-80 lines, single procedure) |
| Composition | Cross-links to other pages | Pointers to shared/*.md and other skills |
| Compounding | Memory entries + page updates per session | Skill updates + saved scripts per session |
| Discovery | INDEX.md, tag files, Grep | Skill `description` fields, `/`-menu |
| Failure mode | Pages that duplicate or drift | Skills that rewrite the same logic |

The two architectures rhyme because they're solving the same problem: *how does a generative system maintain a body of competence that grows monotonically across sessions instead of resetting each time?* Both answer with structured markdown and pointer-based composition. The skill architecture is the vault architecture applied to procedure instead of knowledge.

This page completes the symmetry: the vault has explicit guidance for creating pages ([vault-page.md](../.claude/shared/vault-page.md), [vault-sync](../.claude/skills/vault-sync/SKILL.md)). Now it has the symmetric guidance for creating skills.

### The deeper unification — drift is re-derivation

The two architectures don't merely *rhyme*; they fail by the **same mechanism**, at three layers:

| Layer | Re-derivation looks like | Result | The instance page |
|---|---|---|---|
| **Code** | regenerating architecture from corpus median each session | slop, one-use tools, big ball of mud | [Principled LLM Code](../research/principled-llm-code.md) |
| **Memory** | re-deriving a fact you couldn't recall (index over budget → partial load) | content drift | [The Context Cache Hierarchy](./context-cache-hierarchy.md) |
| **Tools** | rebuilding the same script because you couldn't find it (the SRT tell) | duplicate tools | this page (Gap #1) |

**Drift is accumulated variance from re-derivation.** Each re-derivation draws a fresh *stochastic* sample; the samples diverge from the canonical artifact; that divergence *is* the drift. Tokens are stochastic, artifacts are deterministic — re-deriving reintroduces the variance you already paid to eliminate. The cure is identical at every layer: **point to the artifact, don't re-derive it** ("the point, not the principle," generalized).

Duplication specifically is a **recall failure** — the artifact exists but isn't surfaced in the hot layer (`description` field, shared index), so it's rebuilt. That's the same nondeterministic-recall problem that drives memory drift. So the anti-drift janitor has two faces that are really one: **eviction** keeps the hot layer from bloating (push content down, leave a pointer); **registration** keeps artifacts discoverable (so they're invoked, not rebuilt). Both keep the map matching the territory. `/vault-heartbeat` is the natural home for this consolidation pass — today it lints knowledge-link health only; the memory-hygiene check ([context cache hierarchy](./context-cache-hierarchy.md)) and the skill compounding-loop ([Gap #3](#gap-3-the-compounding-loop-is-not-explicit)) are the two unbuilt faces.

## Worked example: Pocock's catalog as the executed pattern

[mattpocock/skills](https://github.com/mattpocock/skills) is the principles operating at scale: 17 skills, 68k stars in 90 days, no runtime, no orchestrator. Most of the catalog is programming-specific (the vault doesn't need most of it), but several patterns transfer directly and the architectural lessons apply universally.

### Four named failure modes (Pocock's framing)

Pocock organizes his catalog around four failure modes of AI coding agents. They map cleanly onto failure modes the vault has already documented from other angles:

| Pocock's failure mode | Vault's framing for the same thing |
|---|---|
| **Misalignment** — "no one knows exactly what they want; communication gap between user and agent" → fix with `/grill-me` (friction applied to *you*) | [LLM grounding](../research/llm-grounding-problem.md) at the requirements layer — the agent renders fluent code against an unverified spec; grilling forces the spec to be grounded before code generation. |
| **Verbosity** — "agent uses 20 words where 1 will do; no shared language" → fix with `CONTEXT.md` per project (domain glossary) | The vault is this pattern at the Chris↔Claude relationship scale. CONTEXT.md is per-repo; the vault is per-collaborator. Same architectural move at different scales — see [CONTEXT.md ↔ vault parallel](#contextmd-↔-vault-parallel-same-pattern-two-scales) below. |
| **Code doesn't work** — "no feedback loop; agent flying blind" → fix with `/tdd` (red-green-refactor, vertical slices) and `/diagnose` (six-phase debugging) | Direct application of the [planner-LM composite](../research/planner-lm-composites.md) principle: proposer separated from verifier. Tests are the verifier; the LLM is the proposer; the *vertical slice* forces them to alternate per iteration instead of fusing. |
| **Ball of mud** — "agents accelerate software entropy" → fix with `/improve-codebase-architecture`, `/zoom-out` | This is the [vault-heartbeat](../.claude/skills/vault-heartbeat/SKILL.md) pattern at the codebase layer — periodic structural review against drift. The vault has this for knowledge; Pocock has it for code. |

The convergence is the takeaway: failure modes of AI-assisted work are *the same failure modes* whether the work is code or knowledge management. The fixes have the same shape — separate proposer from verifier, accumulate shared language, build feedback loops, audit structure periodically. The architecture is the answer in both domains.

### `/diagnose` Phase 1 — the masterpiece

The most actionable single artifact in Pocock's repo is `/diagnose` Phase 1: *"Build a feedback loop."* Pocock's quote: ***"Build the right feedback loop and the bug is 90% fixed."***

He gives ten ranked ways to construct one, from most-leverage to last-resort:

1. **Failing test** at whatever seam reaches the bug
2. **Curl / HTTP script** against a running dev server
3. **CLI invocation** with a fixture input, diffing stdout against a known-good snapshot
4. **Headless browser script** (Playwright / Puppeteer)
5. **Replay a captured trace** (network request, payload, event log)
6. **Throwaway harness** — minimal subset of the system exercising the bug code path
7. **Property / fuzz loop** — 1000 random inputs, look for the failure mode
8. **Bisection harness** — automate "boot at state X, check, repeat" for `git bisect run`
9. **Differential loop** — same input through old vs new, diff outputs
10. **HITL bash script** — last resort; drive *a human* through a structured loop so the signal is still captured

Plus the meta-rule: *"Treat the loop as a product. Once you have a loop, ask: can I make it faster, sharper, more deterministic? A 30-second flaky loop is barely better than no loop. A 2-second deterministic loop is a debugging superpower."*

**This is the methodology shift you discovered independently in Nobunaga chapter 7** ([[project_6502_annotation_series]] memory). Mesen Memory Viewer + diff-after-controlled-change replaced hours of static disassembly — that's "build a feedback loop" applied to ROM reverse-engineering. Pocock's contribution is the generalized form with a priority ranking. Worth pinning to memory and applying explicitly when the next hard problem shows up.

### CONTEXT.md ↔ vault parallel — same pattern, two scales

Pocock's `CONTEXT.md` solves the verbosity failure mode by giving the agent a shared language per project. His example: *"There's a problem when a lesson inside a section of a course is made real (i.e. given a spot in the file system)"* → *"There's a problem with the materialization cascade."* Same bug, half the tokens, codebase becomes navigable.

**The vault is the same pattern at one scale up.** Per-repo CONTEXT.md teaches the agent a project's jargon; the vault + memory teaches Claude *Chris's* jargon across all projects and sessions. "Constitutive realism," "planner-LM composite," "scope confusion," "the verification layer thesis" — these are vault-internal vocabulary that lets Claude reason concisely about Chris's positions without re-deriving them each session. The vault is `CONTEXT.md` for the Chris↔Claude relationship.

**Concrete action this implies:** for any active vault project where there's repeatable Claude work, a per-project `CONTEXT.md` is a cheap win. The strongest candidate is `projects/game-annotation/nobunaga/` — the VM bytecode / syscall / SRAM / frame-pointer vocabulary has been hammered out across 13 chapters and is currently distributed across the chapter pages. A single CONTEXT.md extracting the canonical jargon would save tokens on every future chapter session and prevent vocabulary drift. *Not done this session — flagged as a follow-up.*

### Borrowables — what to grab from Pocock and where it fits

Most of Pocock's catalog is programming-workflow. The vault is knowledge-management. But several skills/patterns transfer cleanly:

| Pocock skill | Vault fit | Notes |
|---|---|---|
| `/grill-me` | Direct fit | Replaces the ad-hoc "discuss before bulk processing" step in `vault-ingest`. Pocock's version is 8 lines of frontmatter + one paragraph — fork as-is and adapt the trigger phrases. |
| `/diagnose` | Direct fit for any debugging | Use for: game-annotation bugs (disassembler issues, ROM analysis blockers), vault-heartbeat issue investigation, project code. Phase 1 ranking is the meat. |
| `/tdd` | Direct fit for any code project | Monopoly, Slay/Slay-C, OOP-neurons — anything where you're actually writing code with Claude. The horizontal-vs-vertical-slicing critique is sharp and lines up with the [planner-LM composite](../research/planner-lm-composites.md) thesis. |
| `/handoff` | Direct fit | Long sessions that hit context limits — compact to a handoff doc, restart cleanly. Useful for the longer game-annotation chapters. |
| `/write-a-skill` | Direct fit | Better-modeled version of the `/audit-skill` idea from Gap #3 above. Fork Pocock's structure. |
| `CONTEXT.md` pattern | Project-level adoption | Per-project glossary file. Strongest candidate is nobunaga (see above). |
| `skills.sh` installer / distribution-as-feature | Forward-looking career play | Publishing a sanitized version of the vault skills as a public repo would be a portfolio artifact in itself — see [career strategy](../career/strategy.md). The "architecture IS the portfolio" thesis literally executed; Pocock's 68k stars in 90 days are the proof of audience demand. |

### What *not* to copy

Most of the engineering-specific Pocock skills (`/triage`, `/to-prd`, `/to-issues`, `/improve-codebase-architecture`, `/zoom-out`, `/prototype`, `/setup-pre-commit`, `/migrate-to-shoehorn`) are scoped to active multi-developer codebases with issue trackers and PR workflows. The vault doesn't have that shape and the projects mostly don't either. Leave them where they are; reference them by URL if a future project graduates into that shape.

## Recommended next steps (in priority order)

1. ✅ **Gap #1 fixed 2026-05-17** — clean-srt.js and yt-meta.js saved into `.claude/shared/scripts/`, video-extract.md updated to point at them. *(Verified still in place 2026-05-29.)*
2. **Add the flag-discipline table to `shared/README.md`** as the forward-looking rule for new skills. No code change to existing skills. ~5 minutes when convenient.
3. ~~Fork `/grill-me`, `/diagnose`, `/handoff`, `/write-a-skill` from Pocock~~ — **OBSOLETE 2026-05-29: Claude Code now ships all four natively** as built-in skills, so no vault fork is needed. The platform absorbed the work item. (Canonical example of [drift is re-derivation](#the-deeper-unification--drift-is-re-derivation) at the roadmap layer — the plan drifted from reality until verified against ground truth.)
4. **Write `projects/game-annotation/nobunaga/CONTEXT.md`** distilling the VM/bytecode/syscall vocabulary from the chapters into a single glossary file. Token savings start immediately on the next nobunaga session. *(Confirmed still missing 2026-05-29 — genuinely open.)*
5. **Optional, forward-looking:** sanitize-and-publish a public vault-skills repo as a portfolio artifact ([[user_career_priorities]] — architecture IS the portfolio). Lower urgency; high signal value when timed right.

## What changed in this audit pass (2026-05-17)

- **Fixed Gap #1.** `clean-srt.js` + `yt-meta.js` now live in `.claude/shared/scripts/`. `shared/video-extract.md` updated to point at them. This is the unified thesis applied to itself — the skill's tool layer is now actual tools, not regenerated prompt fragments.
- **Added the unified thesis section** linking EBM (research/energy-based-models.md), Marchese principles, and Pocock catalog as three scales of the same architecture.
- **Added Pocock catalog analysis + borrowables.** `/diagnose` Phase 1 connected to the Nobunaga ch 7 methodology shift; CONTEXT.md / vault parallel articulated.
- **Vault skills audit verdict unchanged** at the structural level — still well-aligned with the principles, now with one fewer gap and a clearer roadmap for the remaining three.

## Tags

[ai](../tags/ai.md), [workflow](../tags/workflow.md), [tools](../tags/tools.md), [agents](../tags/agents.md)
