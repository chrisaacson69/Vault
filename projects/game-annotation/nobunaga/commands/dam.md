---
status: stub
created: 2026-05-24
command: Dam
menu_index: 5
driver: $9B7E
effect: $87D8
helper: $887D (helper_dam_rounding)
---
# 5. Dam — Build Flood-control Infrastructure

> Two-effect command — driver calls `effect_dam` ($87D8) AND `helper_dam_rounding` ($887D). Chapter 11 characterized it as "raises output (+debt), drains others."

**Links:** [commands README](./README.md) · [Build (shares the helper)](./build.md) · disasm/bank_01_vm.asm

## What we know (from Chapter 11 + bytecode glance)

- Raises **output**
- Adds to **debt** (the only command that touches the debt field besides debt-payment)
- Drains other fields (TBD which ones)
- Shares `helper_dam_rounding` with Build

## Fields probably touched

- `output` (record+8) — +gain
- `debt` (record+2) — +cost (loan-financed!)
- some drain field(s)
- `gold` (record+0) — −amount

## Test runs

### Test 1: (planned)

| value | pre | post | Δ | notes |
|---|---:|---:|---:|---|
| | | | | |

## Open questions

- Confirm `debt` is incremented (the loan mechanic) and at what ratio to gold spent.
- Confirm what `helper_dam_rounding` actually does in context — same call shape as Build's secondary bump?
- Is the drain field `dams` (record+10) or something else?
