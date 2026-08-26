# Cold-read A/B — comment value at fixed context (2026-08-26)

Capture backing [Comments and the Distance to an Oracle](../../../research/comment-oracle-distance.md).

Measures whether a reader restricted to a single file answers behavioural questions correctly
**with** a comment set and incorrectly **without** it. Two arms, identical code, differing only in
comment volume.

## Files

| File | What it is |
|---|---|
| `sample-a-verbose.cs.txt` | Arm A stimulus — 125 lines, 48 method comment lines + 2 framing |
| `sample-b-trimmed.cs.txt` | Arm B stimulus — 87 lines, 10 method comment lines + 2 framing |
| `protocol.md` | The exact prompt both readers received, verbatim |
| `results-relayed.md` | Reader outputs, condensed from the session log, plus independent verification |

Both stimuli are byte-exact as served. Identifiers are **real** here (this is `raw/`); the research
page anonymises them.

## Source of the two arms

One method, `eUsers.CreateUserByGroup`, from a private production C# codebase (ASP.NET 4.8 /
SQL Server). Arm A is commit `e097923ac`; Arm B is commit `4667bbb8e`, which is A after a
human comment trim. Both extracted programmatically — doc comment through the method's closing
brace — and each given the same 2-line framing preamble.

## What the run produced

Of 8 questions, at Phase 1 (file-restricted): **4 needed no comment** (both arms correct),
**3 needed the comment** (Arm A correct, Arm B `UNKNOWN`), **1 was answered either way** but
Arm A held it as certain where Arm B only inferred it.

The 3 comment-dependent questions all concerned facts residing in *other files*.

## Limitations — read before citing any number

1. **n = 1 per arm.** One reader per condition, two agents total. This is not a distribution; it
   is a single paired observation. The [prior blind-reader
   experiment](../../../research/repairing-llm-code.md) found two readers agreeing on the *same
   wrong answer* with zero variance, which is precisely why one reader per arm cannot separate
   "the comment helped" from "this reader dug harder."

2. **Reader transcripts are lost.** Both agent output files were 0 bytes when checked. Nothing
   verbatim survives; `results-relayed.md` is condensed from the orchestrating session's log. The
   *stimuli and protocol* are preserved, so the experiment is reproducible — the original run is
   not archivable.

3. **Phase 1 was captured asymmetrically.** The protocol asked for Phase 1 answers with confidence
   tags before Phase 2. Reader B reported its Phase 1 state explicitly; Reader A reported only its
   *corrections*, so Arm A's Phase 1 column was reconstructed by inference from A's Phase 2 report.
   A replication must demand Phase 1 answers as a separate artifact before Phase 2 begins.

4. **The arms differ by more than comment volume.** The trim also reworded the XML `<param>` tags:
   Arm B's reads "the Parent Account the login belongs to," stating the parent relationship more
   directly than Arm A's longer version. So Arm B *gains* a fact while losing 38 comment lines. At
   n=1 per arm this is a live alternative explanation for the parent-resolution questions.

5. **Cost was measured by self-report on one question.** The eighth question's result rests on the
   reader's own certain-vs-inferred tag. Confidence is not a reliable signal. Phase 2 produced a
   better instrument — files opened, turns taken — which a replication should apply uniformly.

## For a replication

Serve `protocol.md` unchanged, one fresh reader per arm, and require the Phase 1 answer set to be
returned and stored *before* granting repository access. Vary the context budget rather than fixing
it at one file if the goal is to test the distance axis rather than a single point on it.
