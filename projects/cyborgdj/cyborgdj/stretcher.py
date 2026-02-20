"""Time-stretching: change BPM without changing pitch."""

import numpy as np
import pyrubberband as pyrb


def time_stretch(audio, sr, original_bpm, target_bpm):
    """Stretch audio to match a target BPM.

    Args:
        audio: mono audio array
        sr: sample rate
        original_bpm: the track's native BPM
        target_bpm: desired BPM

    Returns:
        stretched audio array
    """
    if abs(original_bpm - target_bpm) < 0.01:
        return audio

    rate = target_bpm / original_bpm
    return pyrb.time_stretch(audio, sr, rate)


def recompute_bars_after_stretch(bar_frames, original_bpm, target_bpm):
    """Adjust bar frame positions after time-stretching.

    Time-stretching changes the duration, so bar positions shift proportionally.

    Args:
        bar_frames: original bar positions in samples
        original_bpm: BPM before stretching
        target_bpm: BPM after stretching

    Returns:
        adjusted bar_frames array
    """
    if abs(original_bpm - target_bpm) < 0.01:
        return bar_frames

    rate = target_bpm / original_bpm
    return (bar_frames / rate).astype(int)
