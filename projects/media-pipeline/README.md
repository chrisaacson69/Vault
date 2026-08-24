---
status: draft
created: 2026-08-24
---
# Media Pipeline — controlled `md` → video
> **DRAFT — scoped 2026-08-24, not yet implemented.** The harness that turns a vault page into a finished video. Standing goal from `project_superscalar_agents_and_media_pipeline` (2026-05-29): *"controlled md → video… make a project page that homes the generator list, so it's never re-searched."* This is that page.

**Links:** [Watching the Solver Learn](../../method/watching-the-solver-learn.md) (the observation-layer argument, same family), [The Anchor Method](../../method/anchor-method.md), [Projects SDK](../CLAUDE.md), [career-slides skill](../../.claude/skills/career-slides/SKILL.md) (**the existing spine — extend, don't rebuild**), [cyborgdj](../cyborgdj/README.md), [camelot-from-youtube](../camelot-from-youtube/README.md), [Lemonade Stand Experiment](../../research/economics/lemonade-stand-agents.md) (harness-quality thesis)

---

## The thesis this project is built on

Three independent 2026 specimens, reviewed 2026-08-24, all point the same way: **output quality tracked harness quality more than model quality.**

| Specimen | The harness | What it bought |
|---|---|---|
| [Genspark lemonade stands](../../research/economics/lemonade-stand-agents.md) | "Lemonade OS" — instruction layer + desktop control | Two agents ran real-world businesses end to end (badly, but autonomously) |
| [Pezzza's PPO gladiator](../../method/watching-the-solver-learn.md) | Live arena view + 4-signal training dashboard | Two objective bugs found *by watching*, fixed in minutes |
| Stefan 3D AI — [72-hour game](https://www.youtube.com/watch?v=k9cbm5jSOxk) | Unreal 5.8 native MCP + YBE add-on + Asset Hub | A playable 3D platformer in 3 days, solo |

**Chris's read:** a good harness is the deal in creating content. This project builds ours.

## Start from what exists — do not rebuild

`career-slides` **already runs a working `md` → video path**: vault page → Marp deck → HTML → PNG frames → `ffmpeg` → `mp4`. That is the spine. This project widens it, it does not replace it.

Reuse-over-rebuild applies hardest here, because the tempting move — "write a video generator" — would discard a working pipeline.

## The boundary discipline (borrowed from Stefan)

The most transferable thing in the 72-hour video is not a tool, it is a **refusal**. He names what the AI does badly and keeps a human there:

> *"All models, especially Claude Code, are not that good at vision… for this task, right now, it's not really helpful, I would say at all."* — on scene assembly and lighting, which he does by hand, along with collision meshes and collectible placement.

And the working division of labour, in one line:

> *"I don't know how to do the right blueprint here, but I know that it should slide by X."*

**Human supplies intent and constraint; AI supplies implementation.** He also notes vagueness costs *both* accuracy and money — *"it will spend way more tokens because it will need to do a screenshot."*

So this project must state, up front and honestly, **which stages are agent-run and which are hand-run**, and revise that boundary from evidence rather than optimism.

## Goals

- [ ] **Home the generator list.** The standing ask from memory: one table of language-friendly image / audio / video generators with what each is good for, VRAM needs, and licence. Never re-searched.
- [ ] **Widen the `md` → video spine** past Marp slides: B-roll, generated stills, voiceover, captions.
- [ ] **Build the observation layer** — the [method page's](../../method/watching-the-solver-learn.md) argument applies to content, not just solvers: a preview you can watch mid-render without killing the run, plus per-stage timing and cost.
- [ ] **Write the boundary table** — agent-run vs hand-run per stage, with the reason, revised as evidence arrives.
- [ ] **Decide the control language.** `md` as grounded control surface, generators as deterministic tools, LLM orchestrating via pointers (the `tools-and-pointers` shape).

## Open questions for the implementation session

- **What is the unit of control?** One `md` page → one video, or a scene-list `md` where each block names its generator and inputs? The second is more like Stefan's asset workflow and probably survives revision better.
- **Where is the deterministic seam?** The vault's rule is generators-are-tools, LLM-orchestrates. So what exactly must be reproducible from the `md` alone — every frame, or just the structure?
- ~~What is the *content* equivalent of a Class B bug?~~ — **Already answered, from our own work** (Chris, recalled 2026-08-24). Generating **mouth positions** for a presenter character produced *"completely different variations of the character"* per pose: each output satisfied the request (it is a mouth position) while silently violating the constraint nobody wrote down — **it is the same character**. Every output valid, the set unusable. That is textbook [Class B](../../method/watching-the-solver-learn.md#two-classes-of-objective-bug--and-only-one-is-findable-from-inside): no error, no failed check, and only a human looking at the sheet sees it.

  **The fix is the same remedy the vault keeps arriving at** — when you cannot appeal to intent, put the constraint in the specification: *constrain the number of positions and hand-map the expressions.* Note that this is also what the industry does — `presentation-generator-spec.md` Tier 2 already names **Rhubarb**, which maps audio onto a small fixed viseme set rather than generating each mouth freely. **A fixed pose sheet is a constraint-encoding device**, not a limitation.

  **Design consequence for this project:** identity-bearing assets (character, style, palette) must be **generated once and reused**, never regenerated per frame. Per-frame generation has no identity constraint and will drift.

  *Open extension:* Chris's hypothesis that today's generative video shows the same failure in **lip-sync/mouth-matching** — plausible and the same root cause, but **unverified**; worth a look before it's asserted.
- **Hardware:** the 16 GB RTX 50-series card mentioned in the 2026-05-29 memory — is it in place? Local generation vs API changes the whole design.

## Notes

- **Not started.** Drafted at the end of a long session; implementation is deliberately a fresh session — different work, clean commit point.
- The three-specimen harness thesis above is the reusable finding; the rest of this page is scoping and should be treated as revisable.

## Tags

[methodology](../../tags/methodology.md) · [ai](../../tags/ai.md) · [agents](../../tags/agents.md)
