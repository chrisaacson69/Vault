# Results — relayed, not verbatim

**Provenance warning.** Both reader transcripts were 0 bytes when checked. What follows is condensed
from the orchestrating session's log by the agent that ran the experiment. It is faithful to the
reported content but is not the readers' original text, which no longer exists. Treat the
per-question table as the measurement and the findings lists as summarised.

## Phase 1 — file-restricted answers

Arm A = verbose (48 method comment lines). Arm B = trimmed (10).

| # | Question | Arm A | Arm B |
|---|---|---|---|
| 1 | Second call, same email | correct | correct |
| 2 | Unknown `groupName` | correct | correct |
| 3 | Every `false` path | correct | correct |
| 4 | Statement order | order-dependencies + `Save`→`Refresh` **certain** | order-dependencies, `Save`→`Refresh` only **inferred** |
| 5 | Can they password-login? | correct | **UNKNOWN** |
| 6 | Why no FirstName/LastName? | correct | **UNKNOWN** |
| 7 | Can the FARCUS check be deleted? | had the claim, flagged it unverifiable from the file | **UNKNOWN** |
| 8 | Rights step throws | correct | correct |

Tally: 4 needed no comment, 3 needed one (5, 6, 7), 1 degraded in certainty (4).

All three comment-dependent questions concern facts residing in other files: `VerifyPassword`'s
null-hash behaviour, `LoginV2`'s blank-name redirect, and `GetParentCustNum`'s passthrough.

**Caveat:** Arm A's column is reconstructed. Reader A reported only its Phase 2 corrections, so its
Phase 1 state was inferred from statements like "Phase 1 correct and now verified." Reader B
reported Phase 1 explicitly.

## Findings, with independent verification

Verified by the orchestrating agent against the live repository after the readers finished.

| Claim | Reader | Status |
|---|---|---|
| `eUsers` keyed on `UserName` alone (no `AccountID`), so the existence check matches site-wide | both | **CONFIRMED** — `[DatabaseKeyField("UserName")]` is the only key; `GetByKey` selects by key |
| `EmailRegistration`'s existing-user branch returns before the approved/excluded-domain and has-admin gates | A | **CONFIRMED** — the branch fills the name, issues a code, returns; gates sit below |
| `UserTypeID = 1`, `AccountDisabled = 0`, `EmailVerified = false` duplicate constructor defaults | A | **CONFIRMED** — set at `_userTypeID`/`_accountDisabled`/`_emailVerified` in `eUsers()`, and `eUsers(string)` chains `: this()`. Initially misjudged as unsupported because the first check grepped property names rather than backing fields |
| Passing a **child** code to `GetSelectableByAccount` returns only universal groups, so an account-level `groupName` silently fails to match | A | **CONFIRMED** by inspection of the `(AccountId is null or AccountId = @AccountId)` filter |
| `GetParentCustNum` cannot replace the existence check — returns its input unchanged for an unknown account | both | **CONFIRMED** |
| `ManageUsersPageBase` writes an unusable random password on passwordless admin add, where this method leaves `PasswordData` NULL | B | **CONFIRMED** — two live conventions for the same intent |
| `BPLoginCodes.NormalizeEmail` upper-cases its key while this method stores the email as typed | B | **CONFIRMED but narrow** — scoped to login-code and throttle keys, not the `eUsers` lookup, which SQL collation handles |
| `GetByKey` → `Save()` race yields a PK violation and a `false` return, contradicting the documented contract | A | **NOT VERIFIED** — plausible from the non-atomic sequence; not tested |
| `spBOXRefresheTaskAuth` may delete-then-insert without a transaction | A, B | **UNVERIFIABLE** — the proc is not in the repository |

## What neither reader could settle with full repository access

- Whether `spBOXRefresheTaskAuth` behaves correctly for a universal (null-`AccountId`) group, or
  wraps its delete+insert in a transaction. **The proc is not in the repo at all** — no `.sql`
  defines it. This is the out-of-repo oracle class, and it is where the unrecoverable failure lives.
- Whether `eUsers.AccountID` is FK-constrained (no DDL in the repo).
- Collation-dependent case sensitivity of the `UserName` key lookup.

## Consequences that came out of the run

Findings that changed the code or the decisions, in the session that ran the experiment:

1. **The global-keying no-op.** A cross-account duplicate returns `true` and provisions nothing for
   the requested account, so a bulk feed reports success for a row that never landed. Escalated as a
   defect **by the orchestrating agent**, which proposed three remediations and recommended one.
   The two readers *reported* the contract mismatch; neither proposed a fix. This distinction
   matters for the envelope-class argument: the read-only readers described, the agent with edit
   rights moved to act.
2. **The resolution was domain knowledge, supplied by the human.** A cross-parent duplicate is
   possible in principle but would have to be forced, because approved domains partition email
   domains across parents. Nothing in the repository states this. It was then written into the code
   as a comment at the guard — the specimen for the page's "operational envelope" row.
3. **The partition is weaker than stated.** `box_BPApprovedDomains` is keyed on `id`, not
   `domainName`, so nothing prevents two rows claiming one domain; `GetByDomainName` returns a
   single row. The invariant is convention plus a single-row lookup, not a constraint.
