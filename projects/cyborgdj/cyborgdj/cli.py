"""CyborgDJ command-line interface."""

import argparse
import sys

from .engine import load_spec, render_mix, render_transition


def main():
    parser = argparse.ArgumentParser(
        description="CyborgDJ — Human writes the score, machine executes the mix.",
    )
    parser.add_argument(
        "spec",
        help="Path to mix spec JSON file",
    )
    parser.add_argument(
        "--tracks-dir",
        help="Override tracks directory (default: from spec file)",
    )
    parser.add_argument(
        "--output", "-o",
        help="Override output file path (default: from spec file)",
    )
    parser.add_argument(
        "--transition", "-t",
        type=int,
        help="Render only this transition (0-indexed). Omit for full mix.",
    )
    parser.add_argument(
        "--list-transitions",
        action="store_true",
        help="List all transitions in the spec and exit.",
    )

    args = parser.parse_args()

    spec = load_spec(args.spec)

    if args.list_transitions:
        print("Transitions:")
        tracks_by_id = {t["id"]: t for t in spec["tracks"]}
        for i, trans in enumerate(spec.get("transitions", [])):
            from_name = tracks_by_id[trans["from_track"]]["name"]
            to_name = tracks_by_id[trans["to_track"]]["name"]
            t_type = trans.get("type", "crossfade")
            overlap = trans.get("overlap_bars", 0)
            print(f"  [{i}] {from_name} -> {to_name} ({t_type}, {overlap} bars)")
        sys.exit(0)

    if args.transition is not None:
        render_transition(
            spec,
            args.transition,
            tracks_dir=args.tracks_dir,
            output_path=args.output,
        )
    else:
        render_mix(
            spec,
            tracks_dir=args.tracks_dir,
            output_path=args.output,
        )


if __name__ == "__main__":
    main()
