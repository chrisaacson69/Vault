#!/usr/bin/env python3
"""Separate a reaction video's commentator from the video they are playing.

A reaction capture interleaves two voices: the original video (played back, paused,
resumed) and the commentator talking over the pauses. Auto-captions don't label
speakers, but we usually have the ORIGINAL video's transcript too. Every stretch of
the reaction that also appears, in order, in the original is the original playing;
everything else is the commentator.

Method: tokenise both transcripts into normalised words (each word keeps its cue
timestamp), align them with difflib.SequenceMatcher (autojunk off), and keep matched
blocks of at least --min-run words as ORIGINAL. Two separate ASR passes over the same
audio disagree on the odd word, so gaps of up to --gap unmatched words *between* two
original runs are absorbed into the original. Consecutive words with one label become
one segment.

Rewinds (a passage played twice) are caught by a second pass that re-matches each
commentary stretch against the whole original.

Known limit: the commentator reading >= --min-run words of the original aloud (quoting
an on-screen takeaway) is labelled VIDEO. Raise --min-run to trade that for missing
short replays. Interjections of <= --gap words inside a played passage ("uh-huh",
"for sure") are absorbed into the VIDEO segment.

Input format is what tools/fetch-youtube-transcript.py emits (YAML frontmatter
optional):  [m:ss] some spoken text

Usage:
    py -3 tools/split-reaction.py REACTION ORIGINAL [--min-run 5] [--gap 3]
                                  [--speaker NAME] [--out PATH]
    py -3 tools/split-reaction.py --selftest

Output (stdout or --out): one segment per block,
    [0:38] NAME: words...
    [0:40] VIDEO @0:00-0:21: words...
where VIDEO carries the ORIGINAL's own timestamps, so a quote stays citable against
the original capture. Ends with coverage stats: how much of the original was played,
and how much of the reaction is commentary.
"""
import argparse
import difflib
import io
import re
import sys

CUE = re.compile(r"^\[(\d+):(\d{2})\]\s*(.*)$")
WORD = re.compile(r"[a-z0-9']+")
TAG = re.compile(r"\[[a-z ]+\]|>>")  # [music], [laughter], >> speaker marks


def read_words(path):
    """Return [(normalised_word, seconds, original_token)] for a transcript file."""
    out = []
    for line in io.open(path, encoding="utf-8"):
        m = CUE.match(line.strip())
        if not m:
            continue
        t = int(m.group(1)) * 60 + int(m.group(2))
        for tok in TAG.sub(" ", m.group(3)).split():
            for w in WORD.findall(tok.lower()):
                out.append((w, t, tok))
                break
    return out


def label(react, orig, min_run, gap):
    """Per reaction word: index into orig if it is the original playing, else None."""
    sm = difflib.SequenceMatcher(None, [w for w, _, _ in react], [w for w, _, _ in orig],
                                 autojunk=False)
    lab = [None] * len(react)
    allb = [b for b in sm.get_matching_blocks() if b.size > 0]
    for b in allb:
        if b.size >= min_run:
            for k in range(b.size):
                lab[b.a + k] = b.b + k
    # Extend runs through ASR slips: a block of ANY size continues the original if it
    # starts within `gap` words after the previous labelled block on BOTH sides
    # (reaction and original). Slip words in between are pinned to the original word
    # before them. Repeats until nothing changes, so runs grow forward and backward.
    changed = True
    while changed:
        changed = False
        for prev, nxt in zip(allb, allb[1:]):
            p_on = lab[prev.a] is not None
            n_on = lab[nxt.a] is not None
            if p_on == n_on:
                continue
            ga = nxt.a - (prev.a + prev.size)
            gb = nxt.b - (prev.b + prev.size)
            if not (0 <= ga <= gap and 0 <= gb <= gap):
                continue
            for k in range(prev.size):
                lab[prev.a + k] = prev.b + k
            for k in range(nxt.size):
                lab[nxt.a + k] = nxt.b + k
            for i in range(prev.a + prev.size, nxt.a):
                lab[i] = prev.b + prev.size - 1
            changed = True
    # absorb small gaps between two original runs that are both already labelled
    for prev, nxt in zip(allb, allb[1:]):
        if lab[prev.a] is None or lab[nxt.a] is None:
            continue
        lo, hi = prev.a + prev.size, nxt.a
        if 0 < hi - lo <= gap:
            for i in range(lo, hi):
                lab[i] = prev.b + prev.size - 1
    # Rewinds: the main alignment is monotonic, so a passage played twice matches only
    # once and the replay lands in a commentary stretch. Re-match each commentary
    # stretch against the WHOLE original and relabel any run >= min_run.
    ow = [w for w, _, _ in orig]
    i = 0
    while i < len(lab):
        if lab[i] is not None:
            i += 1
            continue
        j = i
        while j < len(lab) and lab[j] is None:
            j += 1
        seg = [w for w, _, _ in react[i:j]]
        if len(seg) >= min_run:
            sub = difflib.SequenceMatcher(None, seg, ow, autojunk=False)
            for b in sub.get_matching_blocks():
                if b.size >= min_run:
                    for k in range(b.size):
                        lab[i + b.a + k] = b.b + k
        i = j
    return lab


def fmt(t):
    return f"{t // 60}:{t % 60:02d}"


def segments(react, orig, lab):
    segs, i = [], 0
    while i < len(react):
        is_orig = lab[i] is not None
        j = i
        while j < len(react) and (lab[j] is not None) == is_orig:
            j += 1
        words = " ".join(tok for _, _, tok in react[i:j])
        span = None
        if is_orig:
            span = (orig[lab[i]][1], orig[lab[j - 1]][1])
        segs.append((react[i][1], is_orig, span, words, j - i))
        i = j
    return segs


def render(segs, react, orig, lab, speaker):
    lines = []
    for t, is_orig, span, words, _n in segs:
        if is_orig:
            lines.append(f"[{fmt(t)}] VIDEO @{fmt(span[0])}-{fmt(span[1])}: {words}")
        else:
            lines.append(f"[{fmt(t)}] {speaker}: {words}")
    matched_orig = {k for k in lab if k is not None}
    n_comm = sum(1 for k in lab if k is None)
    lines.append("")
    lines.append(f"-- original words played: {len(matched_orig)}/{len(orig)} "
                 f"({100 * len(matched_orig) / max(1, len(orig)):.1f}%)")
    lines.append(f"-- reaction words that are commentary: {n_comm}/{len(react)} "
                 f"({100 * n_comm / max(1, len(react)):.1f}%)")
    lines.append(f"-- segments: {sum(1 for s in segs if s[1])} video, "
                 f"{sum(1 for s in segs if not s[1])} commentary")
    return "\n".join(lines) + "\n"


def selftest():
    import os
    import tempfile
    orig = ["[0:00] the quick brown fox jumps over the lazy dog today",
            "[0:05] and then it ran far away into the deep green forest"]
    react = ["[0:00] hey guys welcome back let us watch",
             "[0:03] the quick brown fox jumps over the lazy dog today",
             "[0:08] wow that fox is fast honestly",          # commentary
             "[0:11] and then it ran far away into the deep [music] grin forest",  # ASR slip
             "[0:15] hold on let me rewind that",
             "[0:17] the quick brown fox jumps over the lazy"]  # replay of a played passage
    d = tempfile.mkdtemp()
    po, pr = os.path.join(d, "o.txt"), os.path.join(d, "r.txt")
    io.open(po, "w", encoding="utf-8").write("\n".join(orig) + "\n")
    io.open(pr, "w", encoding="utf-8").write("---\ntitle: x\n---\n" + "\n".join(react) + "\n")
    o, r = read_words(po), read_words(pr)
    lab = label(r, o, 5, 3)
    segs = segments(r, o, lab)
    kinds = [s[1] for s in segs]
    assert kinds == [False, True, False, True, False, True], kinds
    assert segs[4][3] == "hold on let me rewind that", segs[4]
    assert segs[5][2] == (0, 0), "a replay must map back to the original's timestamps"
    assert segs[0][3].startswith("hey guys"), segs[0]
    assert segs[2][3] == "wow that fox is fast honestly", segs[2]
    assert "grin forest" in segs[3][3], "ASR slip inside a run must be absorbed"
    assert segs[3][2] == (5, 5), segs[3][2]
    # the absorbed slip must not extend past the last run
    lab2 = label(r, o, 50, 3)  # min-run too long: nothing matches
    assert all(x is None for x in lab2)
    print("selftest ok")


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("reaction", nargs="?")
    ap.add_argument("original", nargs="?")
    ap.add_argument("--min-run", type=int, default=5)
    ap.add_argument("--gap", type=int, default=3)
    ap.add_argument("--speaker", default="COMMENTATOR")
    ap.add_argument("--out")
    ap.add_argument("--selftest", action="store_true")
    a = ap.parse_args()
    if a.selftest:
        selftest()
        return
    if not (a.reaction and a.original):
        ap.error("REACTION and ORIGINAL are required")
    r, o = read_words(a.reaction), read_words(a.original)
    lab = label(r, o, a.min_run, a.gap)
    text = render(segments(r, o, lab), r, o, lab, a.speaker)
    if a.out:
        io.open(a.out, "w", encoding="utf-8").write(text)
        print(text.strip().splitlines()[-3:], sep="\n")
    else:
        sys.stdout.reconfigure(encoding="utf-8")
        sys.stdout.write(text)


if __name__ == "__main__":
    main()
