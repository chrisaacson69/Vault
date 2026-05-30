# Experiment — Does the daimyo AI target weakness, and do daimyo stats drive it?

> Companion to `tools/ai-war-logger.lua`. Settles empirically what the static
> walk could not: the AI's command scorer (`sub_B6B4`) sits behind the
> ext-opcode (math32) wall, so we measure the behavior instead of reading the
> formula. See memory `project-nobunaga-ai-war-architecture` for the decode.

## The two hypotheses (Chris's model)

The architecture confirms a **two-stage** war decision:

1. **"Do I attack?"** — `sub_B6B4` chooses a command (RNG-weighted scoring).
2. **"Who's my weakest neighbor?"** — target selection in the War driver (`$9850`).

The open questions:

- **H1 — Weakest-target.** When the AI declares war, is the target the
  lowest-army adjacent enemy, or is target choice ~random among neighbors?
- **H2 — Personality.** Does **War** correlate with high **DRIVE**, and
  develop/internal commands with high **IQ** (and other daimyo stats)?

## What the logger captures

Hooking the VM dispatcher (`$E867`) and firing on specific VM PCs:

| Event | Trigger | Logs |
|---|---|---|
| `ISSUE` | VM enters `$B79B` (AI command-issuer) | acting fief + dump of its daimyo record (7 bytes) |
| `CMD`   | a command driver entry while an ISSUE is pending | acting fief → command name |
| `WAR`   | War driver `$9850` | attacker, target-candidate vars, and **live army of every neighbor** with the weakest flagged |

Each `WAR` line is self-contained for H1: it prints the army of all the
attacker's neighbors and names the weakest, so you can read off whether the AI
picked it. Each `ISSUE`+`CMD` pair feeds H2: command chosen vs. the acting
clan's stats.

## Procedure

### Run 1 — calibration (one round)
1. Mesen 2 → Debug → **Script Window** → load `tools/ai-war-logger.lua` → **Run**.
2. Load a save where the AI will act (or start a scenario and pass to the AI).
   **Don't issue your own War while logging** — player wars log as `via PLAYER?`.
3. Let one full AI round play out. Copy the Script Window log.
4. **Confirm the two VERIFY items:**
   - **Target var.** On a `WAR` line, which of `$6F4F / $6F63 / $6F57 / $6F7D`
     holds a value that is actually a *neighbor* of the attacker? That one is the
     target. (Lock it in; ignore the others thereafter.)
   - **Daimyo offsets.** Match a `daimyo[f] raw:` dump against that clan's row in
     `50Diamyo.txt` (health/drive/luck/charisma/iq). Pin which `+k` offset is
     **drive** and which is **iq**. (If no row matches, the live record base
     `$752F`/stride `7` is wrong for the 50-fief — adjust `DMY_BASE`/`DMY_STRIDE`
     at the top of the Lua and re-run.)

### Runs 2+ — data collection
Replay several rounds (reload the same save for independent draws, or play on).
Aim for **≥30 AI fief-turns** and **≥10 observed wars** for the correlations to
mean anything. Save each log.

## Analysis

### H1 — weakest-target
For every `WAR` line, classify the target's rank among the attacker's neighbors
by army (1 = weakest). Tally:
- If targets cluster at rank 1 → **confirmed: AI attacks the weakest.**
- If targets spread across ranks → target choice is ~random; "weakness" is not
  the selector (or only a weak bias).
- Watch the *attacker-vs-target* army gap too: does the AI ever attack a
  neighbor that **outguns** it? If never, there's a "only attack if I'm stronger"
  gate even if it's not strictly the weakest.

### H2 — personality
Join each `CMD` (and each `WAR`) to the acting clan's `drive`/`iq` (from
`50Diamyo.txt`, or the calibrated live offsets). Then:
- **War-rate vs drive:** fraction of that clan's commands that were War,
  plotted against drive. Positive slope → confirms drive→war.
- **Develop/Grow/Build/Dam-rate vs iq:** same, against iq.
- Denominator caveat: `CMD` only captures commands routed through `$B79B`
  (the AI's develop/train *fast-path* may bypass the driver table). So this
  measures the distribution **among issued commands**, which still tests
  drive→War cleanly; it is not a per-fief-turn census. If a true denominator is
  needed, we add a hook once the ch13 turn-loop entry is pinned.

## If results say "yes" to both
Then the AI model is: *each acting fief, drive-weighted roll on whether to make
war; if yes, attack the weakest (or weaker-than-me) neighbor.* That makes the
`fief-analysis-50.py` **Army-threat** column directly predictive — a fief's
real danger ≈ (sum of stronger neighbors) × (their daimyo's drive). We can then
fold a drive-weighting into the threat metric. If "no" to H1, threat is flatter
(any neighbor can come) and the analysis should use degree + neighbor-drive, not
relative army.

## Files
- `tools/ai-war-logger.lua` — the logger (addresses + adjacency embedded).
- `50Fief.txt`, `50Diamyo.txt` — join tables for analysis.
- `adjacency-50.txt` — the neighbor lists (already embedded in the Lua).
