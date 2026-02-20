"""Mix engine — reads a mix spec and produces a continuous audio file."""

import json
import os

import numpy as np
import soundfile as sf

from .loader import load_and_prepare, trim_to_bars
from .stretcher import time_stretch, recompute_bars_after_stretch
from .crossfader import crossfade, clean_cut, bars_to_samples
from .effects import apply_gain, apply_eq


def load_spec(spec_path):
    """Load a mix spec JSON file.

    Returns:
        dict: the parsed mix specification
    """
    with open(spec_path, "r") as f:
        return json.load(f)


def prepare_track(track_spec, tracks_dir, target_sr):
    """Load, analyze, stretch, and trim a single track.

    Returns:
        dict: prepared track data with keys: audio, sr, bpm, bar_frames, spec
    """
    print(f"  Loading: {track_spec['name']}...")
    data = load_and_prepare(track_spec, tracks_dir, target_sr)

    # Time-stretch to target BPM
    original_bpm = track_spec["original_bpm"]
    target_bpm = track_spec["target_bpm"]
    if abs(original_bpm - target_bpm) >= 0.01:
        print(f"  Stretching: {original_bpm:.2f} -> {target_bpm:.2f} BPM...")
        data["audio"] = time_stretch(
            data["audio"], data["sr"], original_bpm, target_bpm
        )
        data["bar_frames"] = recompute_bars_after_stretch(
            data["bar_frames"], original_bpm, target_bpm
        )
        data["bpm"] = target_bpm

    # Trim to cue points
    cue_in = track_spec.get("cue_in_bar", 0)
    cue_out = track_spec.get("cue_out_bar")
    if cue_out is None:
        cue_out = len(data["bar_frames"])
    print(f"  Trimming: bars {cue_in} to {cue_out}...")
    data["audio"] = trim_to_bars(data["audio"], data["bar_frames"], cue_in, cue_out)

    # Rebase bar_frames to the trimmed audio
    if cue_in < len(data["bar_frames"]):
        offset = data["bar_frames"][cue_in]
        end_idx = min(cue_out, len(data["bar_frames"]))
        data["bar_frames"] = data["bar_frames"][cue_in:end_idx] - offset
    else:
        data["bar_frames"] = np.array([0])

    # Apply gain
    gain_db = track_spec.get("gain_db", 0)
    if gain_db != 0:
        print(f"  Gain: {gain_db:+.1f} dB")
        data["audio"] = apply_gain(data["audio"], gain_db)

    return data


def execute_transition(track_out_data, track_in_data, transition_spec, sr):
    """Execute a single transition between two prepared tracks.

    Args:
        track_out_data: prepared outgoing track dict
        track_in_data: prepared incoming track dict
        transition_spec: transition parameters from mix spec
        sr: sample rate

    Returns:
        numpy array: the joined audio
    """
    trans_type = transition_spec.get("type", "crossfade")
    out_name = track_out_data["spec"]["name"]
    in_name = track_in_data["spec"]["name"]

    if trans_type == "clean_cut":
        print(f"  Transition: {out_name} -> {in_name} [clean cut]")
        return clean_cut(track_out_data["audio"], track_in_data["audio"])

    # Crossfade
    overlap_bars = transition_spec.get("overlap_bars", 16)
    fade_type = transition_spec.get("fade_type", "equal_power")
    bpm = track_in_data["bpm"]

    overlap_samples = bars_to_samples(overlap_bars, bpm, sr)
    print(
        f"  Transition: {out_name} -> {in_name} "
        f"[{fade_type} crossfade, {overlap_bars} bars, "
        f"{overlap_samples / sr:.1f}s]"
    )

    # Apply transition EQ to the overlap regions if specified
    out_audio = track_out_data["audio"]
    in_audio = track_in_data["audio"]

    eq_out = transition_spec.get("eq_outgoing")
    if eq_out:
        # Apply EQ only to the outgoing track's overlap tail
        tail_start = max(0, len(out_audio) - overlap_samples)
        tail = out_audio[tail_start:]
        tail = apply_eq(tail, sr, eq_out)
        out_audio = np.copy(out_audio)
        out_audio[tail_start:] = tail

    eq_in = transition_spec.get("eq_incoming")
    if eq_in:
        # Apply EQ only to the incoming track's overlap head
        head = in_audio[:overlap_samples]
        head = apply_eq(head, sr, eq_in)
        in_audio = np.copy(in_audio)
        in_audio[:overlap_samples] = head

    return crossfade(out_audio, in_audio, overlap_samples, fade_type)


def render_mix(spec, tracks_dir=None, output_path=None):
    """Render a complete mix from a spec.

    Args:
        spec: parsed mix specification dict
        tracks_dir: override for tracks directory (default: from spec)
        output_path: override for output file path (default: from spec)

    Returns:
        numpy array: the rendered mix audio
    """
    if tracks_dir is None:
        tracks_dir = spec.get("tracks_dir", ".")
    if output_path is None:
        output_path = spec.get("output_file", "output/mix.wav")

    sr = spec.get("sample_rate", 44100)
    tracks = spec["tracks"]
    transitions = spec.get("transitions", [])

    # Build a lookup from track id to transition spec
    trans_lookup = {}
    for t in transitions:
        key = (t["from_track"], t["to_track"])
        trans_lookup[key] = t

    # Prepare all tracks
    print(f"Preparing {len(tracks)} tracks...")
    prepared = []
    for track_spec in tracks:
        data = prepare_track(track_spec, tracks_dir, sr)
        prepared.append(data)
        print(f"  -> {track_spec['name']}: {len(data['audio']) / sr:.1f}s")

    # Execute transitions sequentially
    print(f"\nExecuting {len(transitions)} transitions...")
    result = prepared[0]["audio"]

    for i in range(1, len(prepared)):
        prev_id = tracks[i - 1]["id"]
        curr_id = tracks[i]["id"]
        trans_spec = trans_lookup.get(
            (prev_id, curr_id),
            {"type": "clean_cut"},  # default to clean cut if no transition defined
        )

        # Build temporary track dicts with the current state of audio
        out_data = {**prepared[i - 1], "audio": result}
        in_data = prepared[i]

        # For the transition, we need the outgoing track to be just result,
        # and the incoming track to be the next prepared track
        result = execute_transition(
            {"audio": result, "spec": prepared[i - 1]["spec"], "bpm": prepared[i - 1]["bpm"]},
            in_data,
            trans_spec,
            sr,
        )

    # Normalize to prevent clipping
    peak = np.max(np.abs(result))
    if peak > 1.0:
        print(f"\nNormalizing (peak was {peak:.3f})...")
        result = result / peak * 0.95

    # Write output
    os.makedirs(os.path.dirname(output_path) or ".", exist_ok=True)
    sf.write(output_path, result, sr)
    duration = len(result) / sr
    minutes = int(duration // 60)
    seconds = duration % 60
    print(f"\nRendered: {output_path} ({minutes}:{seconds:05.2f})")

    return result


def render_transition(spec, transition_index, tracks_dir=None, output_path=None):
    """Render just a single transition for quick preview/iteration.

    Args:
        spec: parsed mix specification dict
        transition_index: which transition to render (0-indexed)
        tracks_dir: override for tracks directory
        output_path: override for output file path

    Returns:
        numpy array: the transition audio
    """
    if tracks_dir is None:
        tracks_dir = spec.get("tracks_dir", ".")
    if output_path is None:
        output_path = f"output/transition_{transition_index}.wav"

    sr = spec.get("sample_rate", 44100)
    transition = spec["transitions"][transition_index]

    # Find the two tracks involved
    from_id = transition["from_track"]
    to_id = transition["to_track"]

    from_spec = next(t for t in spec["tracks"] if t["id"] == from_id)
    to_spec = next(t for t in spec["tracks"] if t["id"] == to_id)

    print(f"Rendering transition: {from_spec['name']} -> {to_spec['name']}")

    # Prepare both tracks
    out_data = prepare_track(from_spec, tracks_dir, sr)
    in_data = prepare_track(to_spec, tracks_dir, sr)

    # Execute transition
    result = execute_transition(out_data, in_data, transition, sr)

    # Normalize
    peak = np.max(np.abs(result))
    if peak > 1.0:
        result = result / peak * 0.95

    # Write
    os.makedirs(os.path.dirname(output_path) or ".", exist_ok=True)
    sf.write(output_path, result, sr)
    duration = len(result) / sr
    print(f"Rendered: {output_path} ({duration:.1f}s)")

    return result
