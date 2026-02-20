"""Audio loading and beat/bar position computation."""

import numpy as np
import soundfile as sf
import librosa


def load_track(file_path, target_sr=44100):
    """Load an audio file and return as mono float32 numpy array.

    Returns:
        tuple: (audio_array, sample_rate)
    """
    audio, sr = sf.read(file_path, dtype="float32")

    # Convert stereo to mono if needed
    if audio.ndim == 2:
        audio = np.mean(audio, axis=1)

    # Resample if needed
    if sr != target_sr:
        audio = librosa.resample(audio, orig_sr=sr, target_sr=target_sr)
        sr = target_sr

    return audio, sr


def detect_beats(audio, sr, bpm_hint=None):
    """Detect beat positions in audio.

    Args:
        audio: mono audio array
        sr: sample rate
        bpm_hint: optional known BPM to guide detection

    Returns:
        tuple: (bpm, beat_frames, beat_times)
            bpm: detected BPM
            beat_frames: beat positions in samples
            beat_times: beat positions in seconds
    """
    if bpm_hint:
        tempo, beat_frames = librosa.beat.beat_track(
            y=audio, sr=sr, bpm=bpm_hint, units="samples"
        )
    else:
        tempo, beat_frames = librosa.beat.beat_track(
            y=audio, sr=sr, units="samples"
        )

    bpm = float(np.atleast_1d(tempo)[0])
    beat_times = beat_frames / sr

    return bpm, beat_frames, beat_times


def beats_to_bars(beat_frames, beats_per_bar=4):
    """Group beat positions into bar positions.

    Args:
        beat_frames: array of beat positions in samples
        beats_per_bar: beats per bar (default 4 for 4/4 time)

    Returns:
        bar_frames: array of bar start positions in samples
    """
    return beat_frames[::beats_per_bar]


def bar_to_sample(bar_number, bar_frames):
    """Convert a bar number to a sample position.

    Args:
        bar_number: which bar (0-indexed)
        bar_frames: array of bar start positions in samples

    Returns:
        sample position, or None if bar_number is out of range
    """
    if bar_number < 0 or bar_number >= len(bar_frames):
        return None
    return int(bar_frames[bar_number])


def trim_to_bars(audio, bar_frames, start_bar, end_bar):
    """Extract audio between two bar positions.

    Args:
        audio: full audio array
        bar_frames: array of bar start positions in samples
        start_bar: first bar (inclusive)
        end_bar: last bar (exclusive)

    Returns:
        trimmed audio array
    """
    start_sample = bar_to_sample(start_bar, bar_frames)
    end_sample = bar_to_sample(end_bar, bar_frames)

    if start_sample is None:
        start_sample = 0
    if end_sample is None:
        end_sample = len(audio)

    return audio[start_sample:end_sample]


def load_and_prepare(track_spec, tracks_dir, target_sr=44100):
    """Load a track and compute its bar grid.

    Args:
        track_spec: dict from mix spec with file, original_bpm, cue_in_bar, cue_out_bar
        tracks_dir: path to directory containing audio files
        target_sr: target sample rate

    Returns:
        dict with keys: audio, sr, bpm, beat_frames, bar_frames, track_spec
    """
    import os
    file_path = os.path.join(tracks_dir, track_spec["file"])
    audio, sr = load_track(file_path, target_sr)

    bpm_hint = track_spec.get("original_bpm")
    bpm, beat_frames, beat_times = detect_beats(audio, sr, bpm_hint)

    bar_frames = beats_to_bars(beat_frames)

    return {
        "audio": audio,
        "sr": sr,
        "bpm": bpm,
        "beat_frames": beat_frames,
        "bar_frames": bar_frames,
        "spec": track_spec,
    }
