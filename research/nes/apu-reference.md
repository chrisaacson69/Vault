---
status: reference
created: 2026-04-26
---
# APU Reference (NES)
> Load-bearing facts about the Audio Processing Unit (integrated into the Ricoh 2A03) for reading NES sound code. Curated from nesdev.org/wiki.

**Links:** [NES Research](./README.md), [PPU Reference](./ppu-reference.md), [Game Annotation Series](../../projects/game-annotation/README.md)

## Five channels

The APU has **5 fixed-function sound generators**:

| # | Channel | Registers | What it produces |
|---|---|---|---|
| 1 | Pulse 1 | $4000–$4003 | Variable-duty square wave (12.5%, 25%, 50%, 75%) |
| 2 | Pulse 2 | $4004–$4007 | Same as Pulse 1 |
| 3 | Triangle | $4008–$400B | Quantized triangle wave (no volume control) |
| 4 | Noise | $400C–$400F | Pseudo-random noise (32 frequencies, 2 modes) |
| 5 | DMC | $4010–$4013 | 7-bit PCM samples (delta modulation) |

Plus control registers:

| Addr | Name | Purpose |
|---|---|---|
| $4015 | Status / Enable | Enable channels (write); read length-counter status |
| $4017 | Frame Counter | 4-step or 5-step sequencer mode, IRQ inhibit |

## Compared to the TIA

The 2600's TIA had 2 channels, 5-bit volume, 32 fixed pitches per channel — the iconic "2600 audio" sound. The NES APU has **2.5× the channels**, *real* envelopes, sweeps, length counters, and *sampled audio* via DMC. Composers got actual instruments instead of bleeps. This is the audio side of the storytelling-vs-logic shift — NES games carry music that *expresses* something, where 2600 audio could only punctuate.

## Pulse channel mechanics ($4000–$4003 / $4004–$4007)

Each pulse channel has 4 registers, all writable in any order during note setup.

| Reg | Bit layout | Fields |
|---|---|---|
| $4000 / $4004 | `DDLC NNNN` | Duty (DD), Length halt + envelope loop (L), Constant volume flag (C), Volume/envelope rate (NNNN) |
| $4001 / $4005 | `EPPP NSSS` | Sweep enable (E), Period (PPP), Negate (N), Shift (SSS) |
| $4002 / $4006 | `LLLL LLLL` | Timer low byte |
| $4003 / $4007 | `LLLL Lhhh` | Length counter load (LLLL L), Timer high (hhh) |

**Frequency formula:** `f = CPU_clock / (16 × (t + 1))` where t is the 11-bit timer (low byte from $4002, high 3 bits from $4003).

**Silencing condition:** if t < 8, channel is silenced. Sweep can also silence by driving frequency out of range.

**Duty cycle** sets the waveform shape: 12.5%, 25%, 50%, 75% — different timbres from the same frequency. Composers vary duty for melodic vs accompaniment voices.

## Triangle channel ($4008–$400B)

| Reg | Bit layout | Fields |
|---|---|---|
| $4008 | `CRRR RRRR` | Length-counter halt + linear-counter control (C), Linear counter reload (RRRRRRR) |
| $400A | `LLLL LLLL` | Timer low |
| $400B | `LLLL Lhhh` | Length counter load, Timer high |

**No volume control** — triangle plays at fixed volume when active. Frequency is **one octave below the pulse channels at the same timer value**.

The triangle has both a length counter (like other channels) AND a separate 7-bit linear counter — both must be non-zero for output. Useful for note durations independent of envelope.

**Quirk:** "Silencing" the triangle just halts its waveform position; it outputs the *last value*, not zero. Causes the famous "click" if not handled.

## Noise channel ($400C–$400F)

| Reg | Bit layout | Fields |
|---|---|---|
| $400C | `--LC NNNN` | Length halt (L), Constant volume (C), Volume/envelope rate (NNNN) |
| $400E | `M--- PPPP` | Mode (M, 0 = normal noise, 1 = "buzzy" tone), Period (PPPP — 4-bit lookup) |
| $400F | `LLLL L---` | Length counter load |

16 noise periods via lookup table. The "buzzy" mode (bit 7 set) produces a metallic timbre — not pseudo-random — used for hi-hat and snare-like sounds.

## DMC channel ($4010–$4013)

| Reg | Bit layout | Fields |
|---|---|---|
| $4010 | `IL-- RRRR` | IRQ enable (I), Loop (L), Frequency rate (RRRR) |
| $4011 | `-DDD DDDD` | Direct load — set 7-bit counter directly |
| $4012 | `AAAA AAAA` | Sample address (decoded as `%11AAAAAA AA000000`) |
| $4013 | `LLLL LLLL` | Sample length (`%LLLL LLLL0001` bytes) |

Plays back 7-bit delta-modulated PCM from a sample in CPU address space ($C000–$FFFF). Used for **drum hits, voice samples, percussive accents** that the synthesized channels can't reproduce.

**Trade-off:** DMC samples eat ROM space (sample storage) and steal CPU cycles (DMA-style fetches that can stall the CPU mid-instruction). Heavy DMC use causes the famous "DMC glitch" with controller reads.

## Frame counter ($4017)

Two modes, set by bit 7 of $4017:

| Mode | Sequence | Effect |
|---|---|---|
| **4-step** (bit 7 = 0) | env, env+len/sweep, env, env+len/sweep+IRQ | ~240 Hz envelope clock, ~120 Hz length/sweep, **frame IRQ enabled** |
| **5-step** (bit 7 = 1) | env, env+len/sweep, env, (silent), env+len/sweep | ~192 Hz envelope, ~96 Hz length/sweep, **no IRQ** |

Most games use 5-step mode to disable the frame IRQ (it conflicts with cleaner mapper-IRQ usage and DMC IRQ).

The frame counter is what advances envelopes and length counters — it's the APU's own internal clock independent of game frame timing.

## Status / Enable ($4015)

**Write:** bits 0–4 enable Pulse 1 / Pulse 2 / Triangle / Noise / DMC respectively. A bit clear → that channel's length counter is forced to 0 (silencing it). DMC bit (4) starts/stops sample playback.

**Read:** returns flags — bit per channel says "length counter > 0," plus DMC sample-active and IRQ flags. Reading is the only way to query channel activity.

## Length counter

A 5-bit value lookup-loaded into a length counter that decrements at the frame counter's rate (~120 Hz NTSC in 4-step mode). When it reaches zero, the channel is silenced. Used to play notes of a specific duration without the CPU re-clocking each note.

The high 5 bits of $4003 / $4007 / $400B / $400F index into a 32-entry table of length values. Loading any of these triggers "key on" for the corresponding channel (also resets phase, etc.).

## Envelope

Pulse and Noise channels have a shared envelope unit:
- Either constant volume (set bit 4 of $4000/$4004/$400C → use bottom 4 bits as volume)
- Or decay envelope (clear bit 4 → volume starts at 15 and decays at the rate in bottom 4 bits)
- Loop bit (bit 5) makes the envelope restart instead of staying at 0 — useful for sustained notes with vibrato.

## Sweep (pulse only)

Each pulse channel has a sweep unit ($4001/$4005) that automatically modulates its frequency over time:
- **Enable** (bit 7), **period** (bits 6–4), **negate** (bit 3), **shift** (bits 2–0)
- Adds or subtracts (period >> shift) from the timer value at each sweep clock.
- Used for sliding pitches, "pew" sounds, kick drum approximations.

## Practical APU programming pattern

For a single note:
1. Write duty + envelope to $4000 (or equivalent).
2. Write sweep to $4001 (or disable with $08 = no shift, no negate, sweep off).
3. Write timer low to $4002.
4. Write timer high + length counter to $4003. **The length counter write is the "key on."**

Continuous music driver:
- Maintain a "music engine" struct in CPU RAM with note, octave, duration, current pattern position per channel.
- Each frame (in NMI or via separate music timer): advance the pattern position, decode the next note, write the 4-byte sequence per channel.
- Length counters and envelopes do most of the per-note work; the engine just sets new notes at musical intervals.

## Tags

[6502](../../tags/6502.md) · [reverse-engineering](../../tags/reverse-engineering.md)
