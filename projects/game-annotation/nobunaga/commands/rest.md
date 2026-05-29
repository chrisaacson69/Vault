---
status: stub
created: 2026-05-24
command: Rest
menu_index: 17
driver: $ADB3
effect: (no dedicated effect handler — pure turn-skip)
---
# 17. Rest — Skip Turns to Recover

> Chapter 11: prompts for "Seasons" via `ui_helper_d351`, then "It will do you good." The lord skips that many turns (health/age interplay). The driver-call-index shows no EFFECT in the driver's host_call list — so this is a pure turn-advance mechanism, not a stat-mutator.

**Links:** [commands README](./README.md) · disasm/bank_01_vm.asm (driver $ADB3)

## What we expect

- **No province-record changes** from Rest itself.
- **Time advances** by the chosen number of seasons.
- During that time: normal turn-end events apply (harvests, AI turns, tax collection, loyalty drift).
- Lord-specific state outside the 26-byte province record may change (age, health) — those live in `daimyo_table_17` at `$752F`, not in the province table.

## Test runs

### Test 1: (planned — 1 season Rest)

This will mostly be a **diff baseline** — what happens in 1 season of "doing nothing"? Useful as the control case to subtract from other commands' diffs.

| value | pre | post (1 season later) | Δ | notes |
|---|---:|---:|---:|---|
| | | | | |

Also worth dumping daimyo table:
```
# extend sram-decode-province.py to also dump daimyo_table_17 at $752F
```

## Open questions

- What health/age change per season Rested?
- Does the lord's status (in daimyo_table_17 byte 6) change to "resting"?
- Does Rest forfeit tax/income for those seasons, or do they collect normally?
