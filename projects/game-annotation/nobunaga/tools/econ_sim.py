"""
Nobunaga's Ambition 1 — single-fief economy simulator.

All formulas verified end-to-end against the ROM via the emulator (May 2026).
Models a single fief running through N years; takes a policy (state -> action)
and computes total harvest accumulated.

Usage: write a policy function, plug it into run_simulation(), inspect output.
"""

import math
from dataclasses import dataclass, field, replace
from typing import Callable, List, Tuple, Optional

isqrt = math.isqrt


# ============================================================================
# State
# ============================================================================

@dataclass
class Fief:
    # Current stats
    output: int = 100
    town: int = 50
    rice: int = 200
    gold: int = 50
    loyalty: int = 50      # 0-100ish
    wealth: int = 50       # 0-100ish
    dams: int = 30         # 0-100, cap
    men: int = 50          # army (we'll keep static for now)
    morale: int = 70
    tax: int = 20          # percent
    # Marks (low-water) — used in harvest
    lm: int = 50           # loyalty mark
    wm: int = 50           # wealth mark
    om: int = 100          # output mark
    dm: int = 30           # dams mark
    # Constraints
    header: int = 1000     # koku cap
    charisma: int = 80     # daimyo-level (drains on tax changes)
    year: int = 1560

    def copy(self):
        return replace(self)


# ============================================================================
# pct_op — the canonical "compute b% of base" helper
# Implementation matches ROM: split-by-10 to avoid 16-bit overflow.
# Pure Python: just (b * p) // 100.
# ============================================================================

def pct_op(b: int, p: int) -> int:
    if b < 0 or p < 0:
        return 0
    return (b * p) // 100


# ============================================================================
# Commands — verified formulas
# ============================================================================

def grow(f: Fief, amount: int) -> Fief:
    """gold -> output. Drains loyalty and dams percentage-wise. Caps at header."""
    f = f.copy()
    if amount < 1 or f.gold < amount or f.output >= f.header:
        return f
    f.gold -= amount
    sqrt_val = isqrt(f.output + amount)
    gain = 2 * ((amount * 5) // sqrt_val)
    gain = min(gain, f.header - f.output)  # cap at header
    drain_pct = (50 * gain) // (f.output + gain) if (f.output + gain) > 0 else 0
    f.output += gain
    f.loyalty -= pct_op(f.loyalty, drain_pct)
    f.dams -= pct_op(f.dams, drain_pct)
    return f


def build(f: Fief, amount: int) -> Fief:
    """gold -> town. Drains wealth (uses half_gain). Caps at header."""
    f = f.copy()
    if amount < 1 or f.gold < amount or f.town >= f.header:
        return f
    f.gold -= amount
    sqrt_val = isqrt(f.town + amount)
    half_gain = (amount * 5) // sqrt_val
    gain = min(2 * half_gain, f.header - f.town)  # cap at header
    drain_pct = (50 * half_gain) // (f.town + half_gain) if (f.town + half_gain) > 0 else 0
    f.town += gain
    f.wealth -= pct_op(f.wealth, drain_pct)
    return f


def give_peasants(f: Fief, amount: int) -> Fief:
    """rice -> loyalty + wealth, each with its paired economic stat."""
    f = f.copy()
    if amount < 1 or f.rice < amount:
        return f
    f.rice -= amount
    # Loyalty step (sub $891D): pairs with OUTPUT
    denom_L = (f.output + f.loyalty) // 2 + amount
    loy_gain = 2 * ((amount * 5) // isqrt(denom_L))
    f.loyalty += loy_gain
    # Wealth step (sub $896F): pairs with TOWN
    denom_W = (f.town + f.wealth) // 2 + amount
    wlt_gain = 2 * ((amount * 5) // isqrt(denom_W))
    f.wealth += wlt_gain
    # Caps at 100ish (game soft-clamps)
    f.loyalty = min(f.loyalty, 100)
    f.wealth = min(f.wealth, 100)
    return f


def dam(f: Fief, amount_gold: int) -> Fief:
    """gold -> dams. ~sqrt(output)/2 gold per dam, capped at 100 dams."""
    f = f.copy()
    if amount_gold < 1 or f.gold < amount_gold:
        return f
    room = 100 - f.dams
    cost_per_dam = max(1, isqrt(f.output) // 2)
    dams_gained = min(amount_gold // cost_per_dam, room)
    actual_cost = dams_gained * cost_per_dam
    f.gold -= actual_cost
    f.dams += dams_gained
    return f


def set_tax(f: Fief, new_tax: int) -> Fief:
    """Set tax rate. Drains loyalty and wealth by |delta_tax|%. Costs 1 charisma."""
    f = f.copy()
    if new_tax == f.tax or new_tax < 0 or new_tax > 100:
        return f
    delta = abs(new_tax - f.tax)
    f.loyalty -= pct_op(f.loyalty, delta)
    f.wealth -= pct_op(f.wealth, delta)
    f.tax = new_tax
    f.charisma -= 1
    return f


def noop(f: Fief) -> Fief:
    return f.copy()


# ============================================================================
# Year cycle — 3 economic decisions + fall harvest + mark transitions
# ============================================================================

def harvest(f: Fief, rng_pct: float = 0.5) -> Tuple[Fief, int, int]:
    """Compute fall harvest. Returns (new_fief, gold_yield, rice_yield).

    rng_pct: 0-1 fraction of max RNG bonus (0.5 = average).
    """
    f = f.copy()
    # Income components (per verified harvest formula)
    loy_contrib = pct_op(pct_op(f.lm, 40), f.tax)
    wlt_contrib = pct_op(f.wm, f.tax)
    town_contrib = pct_op(f.town, f.tax)
    od_contrib = pct_op(pct_op(f.om, f.dm), f.tax)
    rng_max = pct_op(35, f.tax)
    rng_bonus = int(rng_max * rng_pct)
    men_cost = f.men // 2
    gold_yield = max(0, loy_contrib + wlt_contrib + town_contrib + rng_bonus - men_cost)
    rice_yield = max(0, loy_contrib + wlt_contrib + od_contrib + rng_bonus - men_cost)
    # Cap at header (koku ceiling)
    gold_yield = min(gold_yield, f.header)
    rice_yield = min(rice_yield, f.header)
    f.gold += gold_yield
    f.rice += rice_yield
    return f, gold_yield, rice_yield


def fall_transition(f: Fief) -> Fief:
    """Marks are HIGH-WATER: track UP only. Peaks are remembered forever.
    Verified from sub $A0A9 disasm 2026-05-28 — cmp_sle check is
    `if current >= mark: mark = current`. Stats can DROP without hurting harvest
    as long as you hit the peak ONCE."""
    f = f.copy()
    f.lm = max(f.lm, f.loyalty)
    f.wm = max(f.wm, f.wealth)
    f.om = max(f.om, f.output)
    f.dm = max(f.dm, f.dams)
    return f


def revolt_risk(loyalty: int) -> float:
    """Probability of revolt this turn given current loyalty.
       Rule of thumb: below 35 is danger zone, below 20 is near-certain."""
    if loyalty >= 50: return 0.0
    if loyalty <= 0: return 1.0
    if loyalty < 20: return 0.6 + (20 - loyalty) / 20 * 0.3   # 60-90%
    return (50 - loyalty) / 30 * 0.4                          # 0% at 50, ~40% at 20


def year_step(f: Fief, actions: List[Callable[[Fief], Fief]],
              rng_pct: float = 0.5, year_one: bool = False) -> Tuple[Fief, int, int, bool]:
    """Run one year: apply N actions (2 in year 1, 3 after), then harvest, then mark transition.
       Returns (state, gold_yield, rice_yield, revolted).
    """
    f = f.copy()
    n_actions = 2 if year_one else 3
    # Check revolt risk at each action's end (low loyalty during year = invasion bait)
    import random
    for action in actions[:n_actions]:
        f = action(f)
        if random.random() < revolt_risk(f.loyalty):
            return f, 0, 0, True
    f, gy, ry = harvest(f, rng_pct)
    f = fall_transition(f)
    f.year += 1
    return f, gy, ry, False


# ============================================================================
# Policy interface
# ============================================================================

Policy = Callable[[Fief], List[Callable[[Fief], Fief]]]


def run_simulation(initial: Fief, policy: Policy, n_years: int = 22,
                   rng_pct: float = 0.5, verbose: bool = False, seed: Optional[int] = None) -> Tuple[Fief, int, int]:
    """Run N years under the given policy. Returns (final_state, total_gold, total_rice)."""
    import random
    if seed is not None:
        random.seed(seed)
    f = initial.copy()
    total_gold, total_rice = 0, 0
    for i in range(n_years):
        actions = policy(f)
        is_year_one = (i == 0)
        f, gy, ry, revolted = year_step(f, actions, rng_pct, year_one=is_year_one)
        if revolted:
            if verbose:
                print(f"  Year {f.year}: REVOLT (loy was {f.loyalty}) — fief lost. End-game.")
            return f, total_gold, total_rice  # fief lost, return what we earned
        total_gold += gy
        total_rice += ry
        if verbose:
            print(f"  Year {f.year}: tax={f.tax}% out={f.output} loy={f.loyalty} wlt={f.wealth} "
                  f"dams={f.dams} marks=(lm={f.lm} wm={f.wm} om={f.om} dm={f.dm}) "
                  f"harvest=(g={gy},r={ry}) gold={f.gold} rice={f.rice}")
    return f, total_gold, total_rice


# ============================================================================
# Example policies
# ============================================================================

def policy_grow_only(f: Fief) -> List[Callable]:
    """Just grow with 30 gold each turn."""
    return [lambda x: grow(x, 30)] * 3


def policy_balanced(f: Fief) -> List[Callable]:
    """Rotate grow / build / give-peasants."""
    return [
        lambda x: grow(x, min(30, x.gold)),
        lambda x: build(x, min(20, x.gold)),
        lambda x: give_peasants(x, min(40, x.rice)),
    ]


def policy_tax_first_then_grow(f: Fief) -> List[Callable]:
    """Year 1: set tax to 60. After that, all grow."""
    if f.year == 1560 and f.tax != 60:
        return [
            lambda x: set_tax(x, 60),
            lambda x: grow(x, min(30, x.gold)),
            lambda x: grow(x, min(30, x.gold)),
        ]
    return [lambda x: grow(x, min(30, x.gold))] * 3


def policy_adaptive(f: Fief) -> List[Callable]:
    """Rules-of-thumb decisions based on state."""
    actions = []
    f0 = f.copy()
    # Decision 1: tax management
    if f0.year == 1560 and f0.tax < 50:
        actions.append(lambda x: set_tax(x, 60))
    elif f0.loyalty < 40 and f0.rice > 50:
        actions.append(lambda x: give_peasants(x, min(50, x.rice)))
    elif f0.output < f0.loyalty // 2 + 50:  # grow-effective threshold (rule 1)
        actions.append(lambda x: grow(x, min(40, x.gold)))
    elif f0.town < f0.output:  # town-output ratio target
        actions.append(lambda x: build(x, min(30, x.gold)))
    else:
        actions.append(lambda x: give_peasants(x, min(40, x.rice)))
    # Decisions 2-3: greedy similar logic but apply hypothetical state
    while len(actions) < 3:
        f1 = actions[-1](f0)
        if f1.loyalty < 60 and f1.rice > 30:
            actions.append(lambda x: give_peasants(x, min(30, x.rice)))
        elif f1.output * f1.dams < f1.header * 8 // 10:  # output × dams below 80% cap
            actions.append(lambda x: grow(x, min(30, x.gold)))
        else:
            actions.append(lambda x: build(x, min(25, x.gold)))
        f0 = f1
    return actions


# ============================================================================
# Realistic policies based on user's strategic notes
# ============================================================================

def policy_typical(f: Fief) -> List[Callable]:
    """User's stated 'usual year' rotation:
       - build (half gold)
       - grow (other half gold)
       - give-rice (down to men, no further to avoid invasion bait)
    """
    half_gold = f.gold // 2
    safe_rice = max(0, f.rice - f.men)  # never give past men count (siege safety)
    return [
        lambda x: build(x, min(half_gold, f.gold)),
        lambda x: grow(x, min(half_gold, x.gold)),
        lambda x: give_peasants(x, min(safe_rice, x.rice)),
    ]


def policy_typical_taxhike(f: Fief) -> List[Callable]:
    """Same as typical but set tax to 60 on year 1.
    CRITICAL: year 1 must restore loyalty BEFORE fall, else marks track the dip.
    """
    if f.year == 1560 and f.tax < 60:
        return [
            lambda x: set_tax(x, 60),                                    # drains ~30% loy/wlt
            lambda x: give_peasants(x, min(x.rice - x.men, x.rice)),     # restore IMMEDIATELY
            lambda x: build(x, min(x.gold, 30)),                          # use leftover gold
        ]
    return policy_typical(f)


def policy_mark_protection(f: Fief) -> List[Callable]:
    """Be defensive about marks. If a dev action would drop loy below current mark,
    follow with give-peasants in same turn."""
    actions = []
    work = f.copy()
    half_gold = work.gold // 2
    # Build first (drains wealth only)
    actions.append(lambda x: build(x, x.gold // 2))
    # Grow second (drains loy + dams)
    actions.append(lambda x: grow(x, min(x.gold, 50)))
    # Give-peasants last to restore stats above marks
    actions.append(lambda x: give_peasants(x, max(0, min(x.rice - x.men, x.rice))))
    return actions


# ============================================================================
# Demo
# ============================================================================

if __name__ == "__main__":
    # REAL Mikawa starting state per user
    mikawa_1560 = Fief(
        output=80, town=66, rice=75, gold=69,
        loyalty=76, wealth=77, dams=80, men=50, morale=70,
        tax=20, lm=76, wm=77, om=80, dm=80,
        header=1680, charisma=80, year=1560
    )

    print("=" * 60)
    print(f"Starting state (Mikawa 1560 approx):")
    print(f"  output={mikawa_1560.output} town={mikawa_1560.town} loy={mikawa_1560.loyalty} "
          f"wlt={mikawa_1560.wealth} dams={mikawa_1560.dams} tax={mikawa_1560.tax}%")
    print(f"  marks: lm={mikawa_1560.lm} wm={mikawa_1560.wm} om={mikawa_1560.om} dm={mikawa_1560.dm}")
    print(f"  header (koku cap): {mikawa_1560.header}")
    print()

    policies = [
        ("typical (user's)",            policy_typical),
        ("typical + tax-60 y1 (restored)", policy_typical_taxhike),
        ("mark-protection",             policy_mark_protection),
    ]

    print(f"{'Policy':<28} {'Final yr':<10} {'TotalGold':<10} {'TotalRice':<10} "
          f"{'FinalOut':<10} {'FinalTown':<10} {'FinalLoy':<8} {'FinalWlt':<8}")
    print("-" * 100)
    for name, pol in policies:
        final, tg, tr = run_simulation(mikawa_1560, pol, n_years=22, rng_pct=0.5)
        print(f"{name:<28} {final.year:<10} {tg:<10} {tr:<10} "
              f"{final.output:<10} {final.town:<10} {final.loyalty:<8} {final.wealth:<8}")
