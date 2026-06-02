---
status: active
created: 2026-06-02
command: Send
menu_index: 4
driver: $9A5D
effect: $8BE5 (capacity helper)
---
# 4. Send — Ship Resources Between Provinces

> **Rich walkthrough: [send.html](./send.html).** Ship rice **and** gold to one of your other provinces. Zero attrition — the only limit is the receiver's headroom. The snowball engine.

**Links:** [commands README](./README.md) · [appendix §Send](../appendix-formulas.md) · [inter-fief transfer doctrine](../11-strategic-engine-complete.md) · disasm/bank_01_vm.asm (driver $9A5D, capacity $8BE5)

## Formula (bytecode-verified)

```
; per resource (rice, then gold) — $8BE5
capacity = min( target.header − target.field,    ; receiver headroom
                source.available )               ; can't send what you lack
amount   = number_input(cap = capacity)

; applied at confirm — NO attrition, exactly 1:1
target.rice += rice_amt;  source.rice −= rice_amt
target.gold += gold_amt;  source.gold −= gold_amt
```

- **Zero attrition** — every koku and gold piece arrives. (The earlier "~3% travel attrition" was a misread.)
- The only cap is the **receiver's** remaining capacity (`header − current`) and the sender's stock.
- Moves rice AND gold in one command: two capacity checks, two number entries, one cart. Animation id 17.

## Strategic

A maxed-out fief is a pure **pump** — ship its whole surplus to the frontier each turn at no loss. Pair with **Give** (converts shipped rice → loyalty/morale) and Grow/Build on the receiving end. Doctrine: when a donor's surplus exceeds ~3–4× a recipient's, ship; when the donor is capped, always ship.
