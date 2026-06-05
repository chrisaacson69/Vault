# code-golf
> Files about extreme size/space optimization of programs as a design constraint.

- [pygone](../projects/pygone/README.md) — a full chess engine crushed under 4096 bytes; the constraint drives the architecture (e.g. dropping the FEN parser entirely)
- [pygone teardown](../projects/pygone/teardown.md) — the verified 80 KB → 4 KB build pipeline
- [The 4K frontier: floor vs ceiling](../projects/pygone/floor-vs-ceiling.md) — ice4/c4ke annotate every feature with Elo-per-byte; the byte limit caps the artifact, not the design effort
