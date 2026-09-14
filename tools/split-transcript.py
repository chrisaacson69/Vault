#!/usr/bin/env python3
"""Split a timestamped transcript into named segments.

Long live-event captures hold several debates plus hours of pre-show, ad reads
and commentary. Reviewing one debate means reading one segment, not scrolling a
six-hour file -- so slice once, name the slices, and point the review at them.

Input format is what tools/fetch-youtube-transcript.py emits:

    [12:34] some spoken text

where the timestamp is MM:SS with minutes running past 60 (e.g. [406:05]).

Usage
-----
    py -3 tools/split-transcript.py TRANSCRIPT SPEC [SPEC ...] [--outdir DIR]

Each SPEC is  start-end:slug  with times in whole minutes:

    py -3 tools/split-transcript.py raw/debates/transcript-mBsUENOg70g.txt \\
        0-42:preshow \\
        42-101:d1-contender-final-jones-thunder \\
        207-275:d3-dyer-molyneux

Writes  <transcript-stem>-<slug>.txt  beside the source (or into --outdir), each
with its original timestamps intact so quotes stay citable against the source.
A `-clean` sibling with timestamps stripped is written alongside each segment.

Exit status is non-zero if any segment comes out empty, which usually means the
range is wrong rather than the file.
"""
import argparse
import io
import os
import re
import sys

CUE = re.compile(r'^\[(\d+):(\d{2})\]')


def cue_minute(line):
    """Minute of this cue, or None if the line carries no timestamp."""
    m = CUE.match(line)
    return int(m.group(1)) if m else None


def parse_spec(spec):
    try:
        span, slug = spec.rsplit(':', 1)
        start, end = span.split('-')
        return int(start), int(end), slug
    except ValueError:
        raise SystemExit('bad spec %r -- want start-end:slug, e.g. 42-101:final' % spec)


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('transcript')
    ap.add_argument('spec', nargs='+')
    ap.add_argument('--outdir', help='directory for segments (default: alongside the source)')
    args = ap.parse_args()

    lines = io.open(args.transcript, encoding='utf-8').read().split('\n')
    stem = os.path.splitext(os.path.basename(args.transcript))[0]
    outdir = args.outdir or os.path.dirname(args.transcript) or '.'
    if not os.path.isdir(outdir):
        os.makedirs(outdir)

    failed = False
    for spec in args.spec:
        start, end, slug = parse_spec(spec)
        kept, minute = [], None
        for line in lines:
            m = cue_minute(line)
            if m is not None:
                minute = m
            # Untimestamped continuation lines inherit the last cue's minute.
            if minute is not None and start <= minute < end:
                kept.append(line)

        path = os.path.join(outdir, '%s-%s.txt' % (stem, slug))
        io.open(path, 'w', encoding='utf-8').write('\n'.join(kept) + '\n')

        clean = [CUE.sub('', l).strip() for l in kept]
        clean_path = os.path.join(outdir, '%s-%s-clean.txt' % (stem, slug))
        io.open(clean_path, 'w', encoding='utf-8').write('\n'.join(clean) + '\n')

        words = sum(len(l.split()) for l in clean)
        if not kept:
            print('!! EMPTY %s (%d-%d) -- check the range' % (path, start, end))
            failed = True
        else:
            print('%-64s %3d-%3dm  %5d cues  %6d words' % (path, start, end, len(kept), words))

    return 1 if failed else 0


if __name__ == '__main__':
    sys.exit(main())
