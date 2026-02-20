"""Crossfade engine — build transitions from scratch using numpy math."""

import numpy as np


# --- Fade curve generators ---

def linear_fade(n_samples):
    """Linear ramp from 1.0 to 0.0.

    Returns:
        tuple: (fade_out, fade_in) curves of length n_samples
    """
    fade_out = np.linspace(1.0, 0.0, n_samples)
    fade_in = np.linspace(0.0, 1.0, n_samples)
    return fade_out, fade_in


def equal_power_fade(n_samples):
    """Equal-power (constant power) crossfade — no volume dip in the middle.

    Uses cos/sin curves so that fade_out^2 + fade_in^2 = 1 at every sample.

    Returns:
        tuple: (fade_out, fade_in) curves of length n_samples
    """
    t = np.linspace(0, np.pi / 2, n_samples)
    fade_out = np.cos(t)
    fade_in = np.sin(t)
    return fade_out, fade_in


def s_curve_fade(n_samples):
    """S-curve (smooth) crossfade — slow start, fast middle, slow end.

    Uses a raised cosine for a natural-feeling transition.

    Returns:
        tuple: (fade_out, fade_in) curves of length n_samples
    """
    t = np.linspace(0, np.pi, n_samples)
    fade_out = (1 + np.cos(t)) / 2
    fade_in = (1 - np.cos(t)) / 2
    return fade_out, fade_in


FADE_CURVES = {
    "linear": linear_fade,
    "equal_power": equal_power_fade,
    "s_curve": s_curve_fade,
}


def get_fade_curves(fade_type, n_samples):
    """Get fade-out and fade-in curves by name.

    Args:
        fade_type: one of "linear", "equal_power", "s_curve"
        n_samples: length of the fade in samples

    Returns:
        tuple: (fade_out, fade_in) arrays
    """
    if fade_type not in FADE_CURVES:
        raise ValueError(
            f"Unknown fade type '{fade_type}'. "
            f"Available: {list(FADE_CURVES.keys())}"
        )
    return FADE_CURVES[fade_type](n_samples)


# --- Crossfade builders ---

def crossfade(track_out, track_in, overlap_samples, fade_type="equal_power"):
    """Build a crossfade between two tracks.

    track_out's last `overlap_samples` are faded out while
    track_in's first `overlap_samples` are faded in, then summed.

    Args:
        track_out: outgoing track audio array (full cued region)
        track_in: incoming track audio array (full cued region)
        overlap_samples: number of samples in the overlap zone
        fade_type: "linear", "equal_power", or "s_curve"

    Returns:
        numpy array: the complete joined audio
            [track_out solo] + [crossfaded overlap] + [track_in solo]
    """
    if overlap_samples <= 0:
        return np.concatenate([track_out, track_in])

    # Clamp overlap to available audio
    overlap_samples = min(overlap_samples, len(track_out), len(track_in))

    # Split into solo and overlap regions
    out_solo = track_out[:-overlap_samples]
    out_overlap = track_out[-overlap_samples:]
    in_overlap = track_in[:overlap_samples]
    in_solo = track_in[overlap_samples:]

    # Apply fade curves
    fade_out, fade_in = get_fade_curves(fade_type, overlap_samples)
    mixed_overlap = (out_overlap * fade_out) + (in_overlap * fade_in)

    return np.concatenate([out_solo, mixed_overlap, in_solo])


def clean_cut(track_out, track_in):
    """Hard cut — no overlap, no fade. One track ends, the next begins.

    Args:
        track_out: outgoing track audio (trimmed to cue point)
        track_in: incoming track audio (trimmed to cue point)

    Returns:
        concatenated audio
    """
    return np.concatenate([track_out, track_in])


def bars_to_samples(n_bars, bpm, sr):
    """Convert a number of bars to samples.

    Assumes 4/4 time (4 beats per bar).

    Args:
        n_bars: number of bars
        bpm: tempo in BPM
        sr: sample rate

    Returns:
        number of samples (int)
    """
    seconds_per_beat = 60.0 / bpm
    seconds_per_bar = seconds_per_beat * 4
    return int(n_bars * seconds_per_bar * sr)
