# Protocol — verbatim prompt (identifiers anonymized)

Both readers received this text identically, differing only in the stimulus path. Each ran as a
fresh general-purpose agent with no session context.

> Anonymized copy of `protocol.md` for the public repository. Only identifiers in question 7 differ
> from the text as served: `AccountSvc.GetByAccountId` / `AccountSvc.ParentIdLookup` stand for the
> employer's real service and method names.

---

You are performing a cold-read comprehension test on a single C# method. The goal is to measure how
much a reader can determine from the method as written. Answer from the code itself; do not fill
gaps with assumptions about "typical" conventions.

PHASE 1 — Read ONLY this file:
`<STIMULUS PATH>`

During Phase 1 do NOT open any other file, do NOT search the codebase, and do NOT use git. Answer
the eight questions below using only that file's contents.

For EVERY answer, tag a confidence level:
- CERTAIN — the file states it or strictly entails it
- INFERRED — a reasonable deduction from naming or structure, but not stated
- UNKNOWN — cannot be determined from this file

Questions:

1. If this method is called twice with the same email address, what happens on the second call?
   Does anything about the already-existing login change?
2. If groupName names a group that does not exist for that account, what happens?
3. List every distinct condition that causes this method to return false.
4. Does the order of the last few statements matter? If so, name which ones are order-dependent and
   state exactly what breaks if they are swapped.
5. Can the user this creates sign in with a password? If not, how would they authenticate?
6. Why are FirstName and LastName not set on the new record, and what happens to such a user at
   first login?
7. A reviewer proposes deleting the AccountSvc.GetByAccountId existence check, arguing that the
   AccountSvc.ParentIdLookup call on the following line already handles a bad account. From this
   file alone, can you determine whether that change is safe?
8. If the rights-assignment step throws an exception, what state is the database left in, and would
   calling this method again repair it?

PHASE 2 — Now you may explore the repository:
`<REPO ROOT>`

Read the CURRENT source of the things this method CALLS in order to verify your Phase 1 answers. Do
not use git history, and do not hunt for other copies or versions of this same method — study its
callees (for example the types and helpers it invokes), not itself.

Then report:
- Which Phase 1 answers were WRONG or INCOMPLETE, with the corrected answer.
- For each correction, the exact file and symbol you had to read to obtain it.
- Which questions you still could not settle even with full repository access, and why.
- A blunt closing assessment: what did the excerpt fail to tell you that a maintainer editing this
  method would need to know?

Return a compact structured report, not prose paragraphs. Being blunt about the excerpt's gaps is
the point of the exercise.

---

## Design notes and known flaws

- **Question 7 telegraphs slightly.** Phrasing it as "can you determine whether that change is
  safe" hints that a catch exists. Symmetric across arms, so the comparison holds, but a
  replication should phrase it neutrally ("is that change safe?").
- **The Phase 1 / Phase 2 split is the cost term.** Phase 1 fixes the context to one file; Phase 2
  removes the limit. The measurement is what Phase 1 gets right, not what the reader eventually
  concludes.
- **Phase 1 answers were not separately harvested.** The prompt asks for them inline, so a reader
  that reports only its Phase 2 corrections (as Arm A's did) leaves the Phase 1 column to be
  inferred. Require Phase 1 as a returned artifact before Phase 2 access.
- **Confidence tags proved weak.** They carry question 8's entire result. Prefer counting files
  opened and turns taken.
