"""Audio effects for transitions — EQ, gain, filtering via pedalboard."""

import numpy as np


def apply_gain(audio, gain_db):
    """Apply gain in decibels.

    Args:
        audio: audio array
        gain_db: gain adjustment in dB (positive = louder, negative = quieter)

    Returns:
        gained audio array
    """
    factor = 10.0 ** (gain_db / 20.0)
    return audio * factor


def apply_eq(audio, sr, eq_params):
    """Apply EQ using pedalboard.

    Args:
        audio: mono audio array (float32)
        sr: sample rate
        eq_params: list of EQ band dicts, each with:
            - type: "highpass", "lowpass", "low_shelf", "high_shelf", "peak"
            - frequency: center/cutoff frequency in Hz
            - gain_db: gain for shelf/peak filters (ignored for pass filters)
            - q: Q factor (default 0.707)

    Returns:
        EQ'd audio array
    """
    from pedalboard import (
        Pedalboard,
        HighpassFilter,
        LowpassFilter,
        LowShelfFilter,
        HighShelfFilter,
        PeakFilter,
    )

    effects = []
    for band in eq_params:
        band_type = band["type"]
        freq = band["frequency"]
        q = band.get("q", 0.707)

        if band_type == "highpass":
            effects.append(HighpassFilter(cutoff_frequency_hz=freq))
        elif band_type == "lowpass":
            effects.append(LowpassFilter(cutoff_frequency_hz=freq))
        elif band_type == "low_shelf":
            effects.append(LowShelfFilter(
                cutoff_frequency_hz=freq,
                gain_db=band.get("gain_db", 0),
                q=q,
            ))
        elif band_type == "high_shelf":
            effects.append(HighShelfFilter(
                cutoff_frequency_hz=freq,
                gain_db=band.get("gain_db", 0),
                q=q,
            ))
        elif band_type == "peak":
            effects.append(PeakFilter(
                cutoff_frequency_hz=freq,
                gain_db=band.get("gain_db", 0),
                q=q,
            ))

    if not effects:
        return audio

    board = Pedalboard(effects)

    # Pedalboard expects (channels, samples) shape
    audio_2d = audio.reshape(1, -1)
    processed = board(audio_2d, sr)
    return processed.flatten()


def apply_eq_automation(audio, sr, eq_params, n_steps=8):
    """Apply EQ that changes over the duration of the audio.

    Splits audio into n_steps chunks, applies progressively stronger EQ.
    Useful for transitions where you want EQ to ramp (e.g., gradually cut lows
    on the outgoing track).

    Args:
        audio: mono audio array
        sr: sample rate
        eq_params: EQ band dicts (same format as apply_eq)
            Include "gain_db_start" and "gain_db_end" for ramping.
        n_steps: number of chunks to process

    Returns:
        processed audio array
    """
    chunk_size = len(audio) // n_steps
    output = np.zeros_like(audio)

    for i in range(n_steps):
        start = i * chunk_size
        end = start + chunk_size if i < n_steps - 1 else len(audio)
        chunk = audio[start:end]
        t = i / (n_steps - 1) if n_steps > 1 else 1.0

        # Interpolate EQ parameters for this chunk
        step_params = []
        for band in eq_params:
            step_band = dict(band)
            if "gain_db_start" in band and "gain_db_end" in band:
                step_band["gain_db"] = (
                    band["gain_db_start"] + t * (band["gain_db_end"] - band["gain_db_start"])
                )
            step_params.append(step_band)

        output[start:end] = apply_eq(chunk, sr, step_params)

    return output
