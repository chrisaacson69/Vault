---
name: debate-review
description: Fetch and read a debate transcript (YouTube or file), then DISCUSS it with Chris and fold that discussion into a vault page. The discussion is the deliverable; the summary is only a springboard. Use when the user shares a debate link or transcript for review.
user-invocable: true
allowed-tools: Read, Edit, Write, Glob, Grep, Bash, Agent, WebFetch
---

## What this skill is — and is NOT

This skill is **interaction**, not summary-plus-LLM-analysis.

The job is: fetch a transcript → give Chris a *lean* springboard → **actually discuss it with him** → fold his thinking into the page. The value is **Chris's fresh, in-the-moment reaction** — the threads he pulls, his own retorts, the connections he makes while it's live in his head. That is not reconstructable later by writing more analysis, which is why a missed discussion is *lost*, not deferred.

**A polished, comprehensive, single-voice analysis with no discussion folded in is a FAILURE of this skill, not a success.** A rich "Toolkit" / "Structural Problems" / "Open Questions" monologue is camouflage: it *looks* finished, so the discussion gets skipped. Do not let the summary masquerade as the deliverable. When in doubt, write *less* summary and *talk more*.

The failure mode this skill exists to prevent: write a beautiful one-pass page, narrate to Chris that you're "capturing" his points, and persist none of it. (This has happened — an entire rights-vs-duties side conversation was lost this way.) **Capture is not capture until it is written to disk and Chris can see where.**

---

## Two altitudes — review vs thesis, and the ledger between them

A debate produces work at **two altitudes**, and they live in **two pages**, not one. (A vault-wide audit confirmed this separation is correct *and* that the link between the two rots if not disciplined.)

- **The review (specimen)** — `research/debates/<name>.md`. Bounded, dated, source-anchored: what was said, who conceded, how the move played. The discussion's *debate-specific* content lands here (`## Discussion`). It is **evidence, not theory**.
- **The thesis (doctrinal spin-off)** — a **portable, source-independent** idea the debate merely *sparked*, living in its home folder (`philosophy/...`, `research/...`) and citing the debate as one specimen among several. (`force-doctrine.md` is the thesis; the Wilson debates are its specimens.)

When the discussion surfaces something **portable** — true beyond this one debate — it does NOT belong buried in the review. **Promote it** to a thesis page (new, or append to an existing one) and wire the ledger **both ways**:
- **Thesis → specimen (down):** add this debate to the thesis page's evidence list with a one-line *what this specimen contributes*. **This downward half is the one that rots** — the audit found it missing on nearly every pre-existing hub (a hub that predates its evidence never gets the back-link). Do not skip it.
- **Specimen → thesis (up):** the review's Toolkit / Vault-Position links up to the thesis as the doctrine it fed.

**Two traps the audit caught in every cluster — avoid both:**
1. **Trapped harvest.** A portable idea left sitting inside the review (or a project doc) because writing it *there* felt like capture. If it generalizes, it gets its own thesis page or a home in an existing one. Naming "the canonical home" without doing the move *is* the failure.
2. **Memory as the release valve.** Writing the idea to auto-memory (`feedback_*`) is **not** promotion — the audit found four game-theses that reached memory but never a vault page. Memory is a recall hint, not the durable artifact. If it's worth a memory note, it's worth a thesis line too — do both, and link them.

---

## Procedure

### 1. Acquire the transcript

Follow [content-extract.md](../../shared/content-extract.md) for source detection and extraction.
- **YouTube — FIRST TRY, on this machine, every time:**
  ```bash
  py -3 tools/fetch-youtube-transcript.py "<url-or-id>" "raw/debates/transcript-<VIDEOID>.txt"
  ```
  **Do NOT start with `yt-dlp` here.** `www.youtube.com` is SNI-blocked on this network, so `yt-dlp`, `curl` and `WebFetch` all die at the TLS handshake — that is settled and must not be re-debugged. The saved tool drives headless Chrome over QUIC via CDP and mints the POT token the caption endpoint requires. Verified working 2026-09-07 (1,552 cues, first try). Full background + the tested dead ends: [video-extract.md](../../shared/video-extract.md) and the `yt-dlp` memory.
  - ⚠ **A 0-byte HTTP 200 from the caption endpoint is a missing POT token — not a network block and not "this video has no captions."** An in-page `fetch` of `ytInitialPlayerResponse.captions…baseUrl` returns exactly this, even from a logged-in browser. Do not conclude captions are ungenerated on that evidence.
  - **Fallback if CDP is unavailable:** scrape the YouTube transcript panel from the DOM (*Show transcript* → `transcript-segment-view-model` elements, **not virtualised**, so a full hour is present at once), then move the text out by POSTing it to a throwaway `127.0.0.1` HTTP listener — YouTube's CSP allows that, while both clipboard routes fail. Lower fidelity (the panel merges cues) but it needs nothing installed.
  - **Metadata without a browser:** if the channel is mirrored on a PeerTube instance (Word War Debate is, at `vid.samtripoli.com`), `/api/v1/videos?sort=-publishedAt` and `/api/v1/videos/<shortUUID>` return titles, **full descriptions**, durations and view counts as JSON — i.e. resolutions and side assignments — and reach this machine when YouTube does not. Partial mirrors: a first look, never a census.
  - Then strip timestamps for a cleaned copy. Save both to `Vault/raw/debates/` (never modified — it's the source of truth).
- Ask for start/end timestamps if not given; extract the debate portion. **Ask whether to include the post-debate panel / audience Q&A** — that looser exchange is often where the real signal is, and excluding it by default is part of how this skill thinned out.
- Non-YouTube URL: `WebFetch`. If bot-blocked, ask Chris to clip it to `raw/` and point you at the file.

### 2. Draft a LEAN springboard (not the deliverable)

Create the page now, but keep this pass **deliberately thin**. It exists to give Chris something to react to, not to be the finished product:
- Participants, format, core thesis of each side.
- Argument structures — *what was actually said*, numbered, factual. This is the one part that's legitimately yours to write in full.
- **3–6 discussion seeds** — the actual point of this step. Provocations, open questions, spots where a vault framework bears, places Chris is *likely to have a take*. Phrase them as openings, not conclusions.

**Do NOT pre-write** the Toolkit, the "vault's position," elaborate structural teardowns, or resolved Open Questions. Those are **outputs of the discussion**, not inputs. Writing them now is exactly the over-polishing that crowds out the conversation.

Set `discussion: pending` in the frontmatter (see template).

### 3. DISCUSS — the core phase (required, blocking)

Put the seeds to Chris and **actually talk**. Then:

- **Follow him.** The discussion is driven by what's fresh in his mind; it is often long and branches unpredictably. Go where he goes — don't herd him back to your outline.
- **Capture as you go, and PERSIST immediately.** As each substantive point lands, append it to the page's `## Discussion` section (or a `raw/debates/<name>-discussion-notes.md` scratch file) *that turn* — do not hold it only in conversation memory. Conversation memory is not storage.
- **Verify the capture out loud.** After writing, tell Chris what was saved and where (`file:section`). This is the guard against silent-capture loss — it must be a real write he can see, not a narrated intention. (See the vault's silent-tool-failure / verify-ground-truth discipline.)
- **Attribute his contributions.** His retorts, examples, and framings go in as *his* — "Chris's move:", a `> ` quote, or a clearly-marked take. The whole point is to preserve *his* voice, distinct from your analysis.
- **Don't finalize until Chris signals done.** The discussion ends when he says it ends, not when your outline is full.

**If Chris is not available to discuss right now:** stop after step 2. Leave `discussion: pending`, tell him the page is a springboard awaiting discussion, and STOP. Do **not** backfill with more LLM monologue and present it as complete — that is the exact regression this rewrite fixes.

### 4. Finalize — split the harvest across the two altitudes

Once the discussion has happened:
- **Review page (specimen):** lean summary up top, a prominent attributed `## Discussion` section, Toolkit / Open Questions **only insofar as they emerged from the discussion**. Flip frontmatter to `discussion: folded-in`.
- **Promote the portable parts (thesis):** for each idea that generalizes beyond this debate, create or update its thesis page and **wire the two-way ledger** (see "Two altitudes" above). If unsure whether something is portable, *ask Chris* — that judgment is part of the discussion, not a post-hoc cleanup.
- **No release-valve shortcut:** a `feedback_*` memory note does not substitute for the thesis page.

### 5. Arguments over rhetoric

Chris cares about **argument structure and logical validity**, not who "won" stylistically. Focus on unsupported premises, scope confusion, and connections to vault frameworks. Where a fallacy occurs, explain WHY it matters — don't just label it (see [The Fallacy Fallacy](../../../research/philosophy/tangents/the-fallacy-fallacy.md)). Ignore personal attacks and delivery — ideas, not individuals.

### 6. Update vault infrastructure

Run the [vault-sync](../../shared/vault-page.md) procedure: `research/debates/README.md`, `INDEX.md`, tag files + counts, and cross-links into every referenced vault page.

---

## Page template

```markdown
---
status: active
created: YYYY-MM-DD
discussion: pending | folded-in
---
# Debate Title
> One-line thesis summary.

**Date:** YYYY-MM-DD
**Source:** [Platform — Channel](URL) — [Transcript](../../raw/debates/transcript-file.txt)
**Participants:** Name (position) vs Name (position)
**Result:** outcome if known
**Vault relevance:** [linked pages]

---

## Context
Brief background — why this caught our attention.

## Argument Structures
### Side A
Numbered, factual — what was actually said.
### Side B
Numbered, factual.

## Discussion
The core of the page. Chris's reactions, the threads he pulled, his retorts and
examples — attributed and in his voice. Built live during step 3, persisted as it
happened. If this section is thin, the skill was not run correctly.

## Toolkit / Vault Position    ← only if it emerged from the discussion
Reusable moves and the vault's stance, as developed WITH Chris (not pre-written).
If a point here is portable, PROMOTE it to a thesis page and link up to it (don't trap it).

## Vault Connections
Bulleted links with a one-line reason each.

## Open Questions
What's still live — including discussion threads worth resuming.

## Tags
[tag links]
```

`discussion: pending` is a visible, queryable marker: a page stuck on `pending` is one where the conversation never happened — surfacing it is how we keep this from silently regressing again.
