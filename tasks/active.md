# Active Tasks & Goals
> Current things to do, tracked and linked.

**Updated:** 2026-02-17

## In Progress

### GitHub Migration
Move `source/repos/` projects to GitHub. The vault stays local with relative markdown links; repo READMEs are self-contained.

**Architecture:**
- The vault is its own GitHub repo. All internal links use relative paths — works locally and on GitHub natively.
- Code projects (`source/repos/*`) are separate GitHub repos.
- Vault project pages use `**Repo:**` to point outward to GitHub URLs for the code repos. These are the only non-relative links in the vault.

**Steps:**
- [ ] Chris: compile list of all `source/repos/` projects needing vault pointers
- [ ] Create vault project pages for any that don't have one yet
- [ ] Init git in vault, push to GitHub
- [ ] Init git in each code repo (where missing), push to GitHub
- [ ] Update vault `**Repo:**` fields from local paths to GitHub URLs

**Projects with vault pages already:**
- [Triangular Arbitrage](../projects/triangular-arbitrage/README.md)
- [Slay](../projects/slay/README.md)
- [DJ Set 1](../projects/dj-set-1/README.md) (repo: `camelot_from_youtube`)

**Projects needing vault pages:**
- _(Chris compiling list)_

## Up Next
_Nothing yet._

## Someday / Maybe
_Nothing yet._
