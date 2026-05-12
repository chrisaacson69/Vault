---
status: active
created: 2026-05-11
---
# Chapter 2 — Zero-Page Memory Map
> 256 bytes of fast RAM, every byte counts. The first ZP map for the project — built by harvesting writes/reads across the full 16-bank disassembly. Confirms what chapter 1 saw, identifies the shared-scratch-pointer pool, and finds the first concrete instances of byte-meaning-by-context.

**Links:** [Chapter 1 — Boot & Dispatch](./01-boot-and-dispatch.md) · [Mappy Ch 2 — Object records & states](../mappy/02-object-records-and-states.md) (the byte-meaning-by-context precedent) · [Nobunaga README](./README.md)

## The constraint

The NES has exactly **256 bytes of zero-page RAM** at $0000-$00FF. Zero-page addressing on the 6502 is **2 cycles faster and 1 byte shorter** than absolute addressing, so any value touched in the inner loop wants to live there. For a 256 KB strategy engine that has to fit dozens of subsystems (combat, AI, dialog, menus, save state, map rendering) into 2 KB of total RAM, the ZP allocation is a designed thing — not just whatever fell on the floor first.

What we expect to find (from prior projects):
- **Pointer-pair scratch pool** at the bottom — pairs at $00/$01, $02/$03, etc., used as indirect pointers (`lda ($XX),y`)
- **NMI/IRQ-driven state flags** above the pointer pool
- **Game-clock and engine-tick counters** clustered together
- **Byte-meaning-by-context** — the same byte serving different roles depending on which subsystem is active. Mappy chapter 2 named this pattern; Nobunaga's strategy engine has 64× more code competing for the same 256 bytes, so it should be more aggressive here.

## How this map was built

After session 1, disasm6 produced 16 per-bank `.asm` files. A Python pass over all of them tallied every ZP read, write, RMW, indirect-mode, and indexed-mode access. Bank 15 (the kernel) provided most of the context for *what* each address means; the per-bank access counts revealed *which* addresses are shared across the codebase versus subsystem-local.

The map below is **static-only**. Some semantics — especially "which game mode is each scratch byte assigned to" — will only be settled with runtime correlation in Mesen.

## The map ($0000-$00FF)

### Shared scratch pointer pool — $00 to $0F

This is the busy block. Every subsystem borrows from here when it needs a temporary 16-bit indirect pointer.

| Addr | Total accesses | Banks touching | Primary use |
|------|---------------:|----------------|-------------|
| $00  | 173 (83 ind, 99 idx) | 13 of 16 | **General scratch pointer low** — most-used ZP location in the entire ROM |
| $01  | 68 (15 ind, 17 idx) | 10 banks | **General scratch pointer high** — companion to $00 |
| $02  | 52 (14 ind, 19 idx) | 11 banks | Pointer pair low — **init'd to $FF at reset**, `$02/$03` form pointer $05FF |
| $03  | 15 | 3 banks | Pointer pair high — init'd to $05 at reset |
| $04  | 29 (13 ind) | 7 banks | Pointer pair low — heavy `lda ($04),y` use |
| $05  | 14 | 4 banks | Pointer pair high |
| $06  | 56 (25 ind) | 5 banks | Pointer pair low — second-busiest indirect pair after $00/$01 |
| $07  | 27 (2 ind) | 4 banks | Pointer pair high |
| $08  | 159 (7 ind, 25 idx) | 5 banks | **Indexed-table base** — `sta $08,y` pattern is very common |
| $09  | 122 (1 ind, 1 idx) | 4 banks | Companion register |
| $0A  | 50 (10 ind, 14 idx) | 8 banks | Mixed-mode scratch |
| $0B  | 22 | 2 banks | Companion |
| $0C  | 71 (11 ind, 25 idx) | 4 banks | Indexed scratch |
| $0D  | 44 | 3 banks | Companion |
| $0E  | 8 | 4 banks | Sparse use |
| $0F  | (rare) | — | Likely free / boundary |

**Reading:** $00-$0F is an 8-pointer-pair pool, with $00/$01 designated as the "default" pointer (used everywhere) and $02-$07 as "subroutine-local" pointers (each subroutine that needs a pointer borrows one). $08-$0F shifts toward an "indexed temp register file" model — `,x` and `,y` addressing dominates over `()` indirect, so it's used for 4-element record scratch rather than dereferenced pointers.

This split (pointers at $00-$07, indexed temps at $08-$0F) is conventional 6502 practice. Nothing surprising here, but the *volume* is striking — $00/$01 alone gets accessed in 13 of 16 banks, which means the convention is enforced project-wide, not just bank-locally.

### NMI/PPU pipeline pointers — $1C to $1F

Initialized by the reset handler (chapter 1, $C086-$C094):

| Addr | Init value | Role |
|------|-----------|------|
| $1C  | $20 | Pointer low → forms `$1C/$1D = $0020` |
| $1D  | $00 | Pointer high |
| $1E  | $30 | Pointer low → forms `$1E/$1F = $0030` |
| $1F  | $00 | Pointer high |

These point into $0020 and $0030 in main RAM. Best current guess: $0020 is the **PPU upload queue** (tiles/palette/nametable bytes deferred to next NMI), and $0030 is a second queue or its tail pointer. The NMI handler at $C0E2 calls `JSR $C54F` which is almost certainly the queue-drainer. Chapter 3 will follow the queue plumbing.

### IRQ / BRK dispatcher state — $50, $66-$69

| Addr | Role | First witnessed at |
|------|------|--------------------|
| $50  | **BRK dispatch index** — task ID to run when next BRK fires | `b15_c154: ldx $50` (the IRQ handler reads it) |
| $66  | IRQ scratch — cleared on every BRK dispatch entry | `b15_c148: sta $66` (zeroed by handler) |
| $67  | IRQ scratch — cleared on every BRK dispatch entry | `b15_c14b: sta $67` |
| $68  | IRQ-computed JMP target low *(also: general indirect pointer low)* | `b15_c160: sta $68` |
| $69  | IRQ-computed JMP target high *(also: general indirect pointer high)* | `b15_c163: sta $69` |

**First concrete byte-meaning-by-context:** $68/$69 has two distinct contracts depending on who's touching it:

1. **In the IRQ handler:** $68/$69 holds the address of the next dispatched task. The handler builds it from `($73 + Y, $C1 + X)` and indirect-jumps through it. Once the JMP executes, the dispatcher's contract with $68/$69 is over.
2. **In a subroutine at $C29F:** `lda ($68),y` — the same bytes are reused as a generic indirect data pointer. By the time $C29F runs, the BRK dispatch is already in flight or finished, so $68/$69 is "free real estate."

Aggressive but safe: no path can call $C29F while the IRQ dispatcher is mid-build, so the reuse doesn't race. The cost is that any reader has to know which contract is active. The benefit is two named pointer slots costing one in actual ZP.

### Reset-init kernel state — $73, $74, $80, $81, $83-$86, $89, $B0

These are the named kernel flags / counters from chapter 1, now annotated with where else they're read or written.

| Addr | Init | Role | Notable later writers/readers |
|------|------|------|-------------------------------|
| $73  | $00 | Cleared at reset; used by `$C6AD` (the BRK multiply-by-3 helper) | Read at $C247, $C270 (during dispatch math) |
| $74  | $FF | Reset-set; **subsystem-state byte** managed by routines around `b15_c36c` | Read/written by a self-contained subsystem |
| $80  | $00 | Cleared at reset; flag toggled around `b15_c376` (EORs $80) | EOR'd in update routine — pure toggle bit |
| $81  | $00 | **NMI busy semaphore.** Mainline sets to 1 then spin-waits for NMI to clear it | Loop pattern at `b15_c1bd` reads $81 |
| $83  | $04 | Timer pair 1 hi | See note below — also accessed indexed as $83+X |
| $84  | $D2 | Timer pair 1 lo (NMI adds +2 every frame, gated by $89) | |
| $85  | $04 | Timer pair 2 hi | |
| $86  | $D2 | Timer pair 2 lo (NMI adds +2 every frame, gated by $89) | |
| $89  | $00 | NMI timer-skip flag — when set, NMI does OAM/audio/controllers but doesn't tick the wall clock | Written elsewhere to pause the game-clock |
| $B0  | $00 | NMI skip-all flag — when set, NMI bails after OAM DMA (still pushes OAM but skips everything else) | Likely set during long PPU updates or menu transitions |

**Second byte-meaning-by-context: $83-$86 as either 2× 16-bit timers OR a 4-byte indexed record.**

- In the NMI handler (chapter 1, $C109-$C12A), $83/$84 and $85/$86 are treated as two independent 16-bit counters, each += 2 per frame.
- At `b15_c1f3` we see `lda $0083,x` — the same 4 bytes are accessed as an X-indexed record. The reading routine doesn't care that the bytes also happen to be valid 16-bit-pair timer values; it's just reading byte $83+X for some external selector.

The two readings aren't contradictory — they're complementary. **The same bytes serve both roles simultaneously.** The X-indexed access at $C1F3 doesn't disturb the timer values; it just reads them as a four-element snapshot. This is the design move that lets the kernel save 4 bytes of dedicated "current timer reading" scratch — the existing live counters *are* the readable register file.

### Mass-init region — $90 to $AF

The reset handler ($C05A-$C067) fills these 32 bytes with the constant `$3E`. **Crucially, it does the same fill at $0700-$071F**, so $0090-$00AF and $0700-$071F are mass-init'd together. Two parallel buffers.

What 32 bytes filled with $3E plausibly is:
- An **attribute table buffer** ($3E in binary is `00111110`, which decodes as a 2-bit-per-quadrant palette assignment of `00 11 11 10` — a real value in NES attribute encoding)
- A **palette default** — $3E is a valid NES palette entry (medium grey)
- A **deferred-write template** — a 32-byte block ready to be DMA'd to the PPU during the next VBlank

The parallel fill of $0090-$00AF and $0700-$071F suggests $0700-$071F is the **master copy** (in main RAM, may be edited freely), and $0090-$00AF is the **ZP shadow** (fast read/write during the inner loop, periodically refreshed from the master or vice versa). NES games commonly use ZP shadows of nametable/attribute updates for speed.

This needs runtime verification in Mesen — set a watch on $0090-$00AF and observe what writes through to it during gameplay. Chapter 3 will resolve.

### Untracked regions ($10-$1B, $20-$4F minus $50, $51-$65, $6A-$72, $75-$7F minus key locations, $87-$88, $8A-$8F, $A0-$AF partial, $B1-$FF)

These show sporadic usage in the access stats — some quite heavy (e.g., $7A has 34 accesses, all in bank 15, 30 of them indirect — clearly a kernel-internal scratch pointer). Naming them requires either deeper trace work or runtime observation.

What we know from the access stats:
- **$7A** is a bank-15-only heavy-indirect pointer (kernel scratch, never escapes)
- **$AA** is hit 14 times in 3 banks (7, 8, 13), mostly indexed — likely a multi-bank coordinated register
- **$D7** is RMW-heavy (11 RMWs) — a counter that decrements (the `dec $d7` pattern dominates)
- **$CF** has 23 reads but 0 writes in the disassembled code — likely written via indexed addressing we'd need to grep more carefully to catch, OR it's a constant table set up elsewhere

## Patterns confirmed

1. **Shared scratch pointer pool at $00-$0F.** $00/$01 is the project-wide default; $02-$07 are subroutine-local pointer pairs; $08-$0F is indexed-temp register space. 13 of 16 banks touch $00 — this is a hard convention.
2. **Byte-meaning-by-context** at $68/$69 (IRQ target ↔ data pointer) and $83-$86 (timer pair ↔ indexed register). The Mappy pattern shows up at the kernel level — and it's likely we'll find more instances in the per-subsystem chapters.
3. **Parallel buffers** at $0090-$00AF (ZP) and $0700-$071F (main RAM), both filled with $3E at reset. Hot-cold buffer pattern.
4. **Init constants double as data.** The timer counters start at $04D2 = 1234 decimal. That's not random — likely a calibration value or a deliberate starting offset. Worth keeping in mind when we hit AI tick rates.

## Open questions for runtime correlation

| Question | How to answer in Mesen |
|----------|------------------------|
| What writes to $90-$AF after reset? | Mem-write breakpoint on $0090-$00AF, play normally |
| Who writes $50 (sets the BRK dispatch ID)? | Mem-write breakpoint on $0050, trigger menu actions |
| Where is $20 / $30 (the targets of the $1C-$1F pointers) updated? | Mem-write breakpoint on $0020 and $0030 |
| Does $B0 actually skip the NMI body, or is it gating something else? | Set $B0=1 via debugger mid-game, observe |
| Is $7A really kernel-local, or does some bank reach it indirectly? | Mem-access breakpoint on $7A, run gameplay |

## Method note

The harvest used a 60-line Python script against the disasm6 output. The script lives in `tools/zp-harvest.py` (to be committed next session). This is reusable — future chapters that need a "where is X referenced" pass can call the same machinery. Same idea as the chapter-2 retrospective tools from the Mappy project: build the tool you need; reuse it as the corpus grows.

The cost of static-only analysis is visible in the **untracked** sections above. Without runtime correlation we know *that* $7A is heavily used in bank 15 but not *for what semantic purpose*. The next session's Mesen breakpoint runs will fill in those gaps efficiently.

## What chapter 2 establishes

- A first-pass ZP map covering every documented chapter-1 location plus the major scratch-pool addresses
- The **shared scratch pointer pool** convention (kernel-wide $00-$0F discipline)
- Two concrete instances of **byte-meaning-by-context** at the kernel level ($68/$69 and $83-$86)
- An explicit list of **runtime-only questions** for the next Mesen session

What chapter 3 needs:
- Resolve the $90-$AF + $0700-$071F buffer pair via NMI/PPU pipeline tracing
- Confirm or refute the "$1C/$1D and $1E/$1F point to the PPU upload queue" hypothesis
- Name $74's subsystem (the routines at $C36C)

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)
