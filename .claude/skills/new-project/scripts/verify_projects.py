#!/usr/bin/env python3
"""Audit every vault project for the five registration artifacts.

The failure this catches: PARTIAL REGISTRATION. A project that has a vault
pointer page but no remote and no resolver entry exists on exactly one machine
-- unbackupable, and invisible from every other instance. (Observed with
democracy3-solver, 2026-08-10..08-30.)

The five artifacts, in the order they must be created:
  1. local repo        -- a git repo at the resolved path
  2. GitHub remote     -- created IMMEDIATELY, not "later"
  3. resolver entry    -- a row in .claude/local-paths.md (per-machine, gitignored)
  4. vault pointer     -- projects/<name>/README.md (logical name + URL + sibling)
  5. INDEX.md line     -- routing entry, via /vault-sync

Run from the vault root:
    py -3 .claude/skills/new-project/scripts/verify_projects.py
    py -3 .claude/skills/new-project/scripts/verify_projects.py --network
    py -3 .claude/skills/new-project/scripts/verify_projects.py --lint <name>
"""
from __future__ import annotations

import argparse
import re
import subprocess
import sys
from pathlib import Path

GITHUB_RE = re.compile(r"(?:https?://)?github\.com/([\w.-]+/[\w.-]+?)(?:\.git)?(?=[\s)*<`|]|$)")
LOGICAL_RE = re.compile(r"(?:\*\*Logical name:\*\*|\|\s*Logical name\s*\|)\s*`([^`]+)`")
# Machine-shaped absolute paths: a drive letter, a POSIX /home|/Users, or an
# OneDrive-redirected Documents layout. These must never appear in tracked files.
ABS_RE = re.compile(r"(?:(?<![A-Za-z0-9])[A-Za-z]:[\/]|/home/|/Users/|OneDrive[\/])")


def vault_root() -> Path:
    p = Path(__file__).resolve()
    for parent in p.parents:
        if (parent / "INDEX.md").exists() and (parent / "projects").is_dir():
            return parent
    return Path.cwd()


def read(path: Path) -> str:
    try:
        return path.read_text(encoding="utf-8", errors="replace")
    except OSError:
        return ""


def parse_resolver(root: Path) -> dict[str, dict]:
    """logical name -> {path, identity} from the gitignored resolver table."""
    text = read(root / ".claude" / "local-paths.md")
    out: dict[str, dict] = {}
    for line in text.splitlines():
        if not line.startswith("|"):
            continue
        cells = [c.strip() for c in line.strip().strip("|").split("|")]
        if len(cells) < 2:
            continue
        name = cells[0].strip("`").strip()
        if not name or name.lower().startswith("logical name") or set(name) <= set("-: "):
            continue
        out[name] = {"path": cells[1].strip("`").strip(), "identity": cells[2] if len(cells) > 2 else ""}
    return out


def parse_search_roots(root: Path) -> list[Path]:
    """Extra directories to scan for clones, from the gitignored resolver.

    They live there, not here, because this script is TRACKED and the vault repo
    is public -- a machine path hardcoded here would be a class-1 violation.
    """
    text = read(root / ".claude" / "local-paths.md")
    roots: list[Path] = [root.parent]
    if "## Repo search roots" in text:
        section = text.split("## Repo search roots", 1)[1]
        body = []
        for ln in section.splitlines():
            if ln.startswith("## "):
                break
            body.append(ln)
        for line in body:
            line = line.strip()
            if line.startswith("-"):
                cand = line.lstrip("- ").strip().strip("`").strip()
                if cand and Path(cand).is_dir():
                    roots.append(Path(cand))
    seen, out = set(), []
    for r in roots:
        if str(r).lower() not in seen:
            seen.add(str(r).lower())
            out.append(r)
    return out


def norm(name: str) -> str:
    """Logical names drift from directory names: batch-resize vs batch_resize."""
    return re.sub(r"[^a-z0-9]", "", name.lower())


def find_clone(name: str, roots: list[Path]) -> Path | None:
    target = norm(name)
    for r in roots:
        direct = r / name
        if (direct / ".git").is_dir():
            return direct
        try:
            for child in r.iterdir():
                if child.is_dir() and norm(child.name) == target and (child / ".git").is_dir():
                    return child
        except OSError:
            continue
    return None


def find_pointer_pages(root: Path) -> list[Path]:
    pages = set((root / "projects").rglob("README.md"))
    pages |= {p for p in (root / "projects").glob("*.md")
              if p.name not in {"CLAUDE.md", "README.md"} and not p.name.startswith("_")}
    return sorted(pages)


def git(args: list[str], cwd: Path | None = None) -> tuple[int, str]:
    try:
        r = subprocess.run(["git", *args], cwd=cwd, capture_output=True, text=True, timeout=45)
        return r.returncode, (r.stdout or "") + (r.stderr or "")
    except Exception as exc:  # noqa: BLE001
        return 1, str(exc)


def audit(root: Path, page: Path, resolver: dict, index_text: str, network: bool,
          search_roots: list[Path]) -> dict:
    text = read(page)
    rel = page.relative_to(root).as_posix()

    m = LOGICAL_RE.search(text)
    gh = GITHUB_RE.search(text)
    # identity precedence: explicit declaration > the repo name in the declared
    # GitHub URL (grounded) > the folder name (a guess, and often drifted)
    if m:
        name = m.group(1)
    elif gh:
        name = gh.group(1).split("/", 1)[1]
    else:
        name = page.parent.name if page.name == "README.md" else page.stem
    declares_repo = bool(m or gh)

    entry = resolver.get(name)
    if entry is None:  # logical names drift from row keys; match normalized
        entry = next((v for k, v in resolver.items() if norm(k) == norm(name)), None)
    resolved: Path | None = None
    if entry and entry["path"] and "<" not in entry["path"] and Path(entry["path"]).is_dir():
        resolved = Path(entry["path"])
    else:
        resolved = find_clone(name, search_roots)

    has_clone = bool(resolved and (resolved / ".git").is_dir())

    remote_ok = None
    if network and gh:
        rc, _ = git(["ls-remote", "--heads", f"https://github.com/{gh.group(1)}"])
        remote_ok = rc == 0

    # class-1 violation: an absolute machine path inside a COMMITTED vault page
    abs_in_page = sorted({s for s in ABS_RE.findall(text)}) if ABS_RE.search(text) else []

    return {
        "name": name,
        "page": rel,
        "declares_repo": declares_repo,
        "remote_url": gh.group(1) if gh else None,
        "remote_ok": remote_ok,
        "in_index": rel in index_text,
        "in_resolver": entry is not None,
        "has_clone": has_clone,
        "resolved": str(resolved) if resolved else None,
        "abs_in_page": abs_in_page,
    }


def lint_repo(path: Path) -> list[str]:
    """Class-3: pointers INSIDE a project repo must be relative + tracked, so a
    fresh clone is self-contained. Flags machine-shaped paths in tracked files."""
    rc, out = git(["ls-files"], cwd=path)
    if rc != 0:
        return [f"(not a git repo: {path})"]
    hits: list[str] = []
    for f in out.splitlines():
        fp = path / f
        if not fp.is_file() or fp.suffix.lower() in {".xml", ".png", ".jpg", ".pdf", ".gz", ".zip"}:
            continue
        # *.example.* / *.sample.* files exist precisely to show a machine default
        if any(t in fp.name.lower() for t in ("example", "sample", "template")):
            continue
        try:
            body = fp.read_text(encoding="utf-8", errors="replace")
        except OSError:
            continue
        for i, line in enumerate(body.splitlines(), 1):
            if ABS_RE.search(line) and "example" not in line.lower():
                hits.append(f"{f}:{i}: {line.strip()[:120]}")
    return hits


def main() -> int:
    ap = argparse.ArgumentParser(description="Audit vault projects for the 5 registration artifacts.")
    ap.add_argument("--network", action="store_true", help="verify each GitHub remote actually resolves")
    ap.add_argument("--lint", metavar="NAME", help="scan one project's clone for machine-shaped paths")
    ap.add_argument("--quiet", action="store_true", help="only show projects with problems")
    ap.add_argument("--suggest-resolver", action="store_true",
                    help="emit local-paths.md rows for located-but-unregistered clones")
    args = ap.parse_args()

    root = vault_root()
    resolver = parse_resolver(root)
    index_text = read(root / "INDEX.md")

    if args.lint:
        entry = resolver.get(args.lint)
        path = Path(entry["path"]) if entry and "<" not in entry["path"] else root.parent / args.lint
        if not path.is_dir():
            print(f"no clone for '{args.lint}' (looked at {path})")
            return 2
        hits = lint_repo(path)
        print(f"class-3 lint: {args.lint} ({path})")
        print("  clean -- no machine-shaped paths in tracked files" if not hits else "")
        for h in hits:
            print(f"  {h}")
        return 1 if hits else 0

    search_roots = parse_search_roots(root)
    rows = [audit(root, p, resolver, index_text, args.network, search_roots)
            for p in find_pointer_pages(root)]
    repo_rows = [r for r in rows if r["declares_repo"]]
    page_only = [r for r in rows if not r["declares_repo"]]

    print(f"vault: {root}")
    print(f"{len(repo_rows)} projects declaring a repo, {len(page_only)} pointer-only pages\n")
    hdr = f"{'project':<28} {'remote':>7} {'resolv':>7} {'clone':>6} {'index':>6}  notes"
    print(hdr)
    print("-" * len(hdr))

    incomplete = 0
    for r in sorted(repo_rows, key=lambda x: x["name"].lower()):
        missing, elsewhere = [], []
        # A clone absent from THIS machine is only a defect when nothing backs it up.
        # With a remote, the code is safe and simply lives elsewhere -- 'not here'
        # is not 'missing'. Without one, an absent clone means it exists nowhere.
        if not r["remote_url"]:
            missing.append("NO REMOTE (at risk)")
            if not r["has_clone"]:
                missing.append("no clone either -- exists nowhere")
        elif r["remote_ok"] is False:
            missing.append("REMOTE 404")
        if not r["in_index"]:
            missing.append("index")
        if r["abs_in_page"]:
            missing.append("ABS-PATH-IN-PAGE")
        if r["has_clone"] and not r["in_resolver"]:
            missing.append("resolver")   # cloned here but unfindable by logical name
        if not r["has_clone"] and r["remote_url"]:
            elsewhere.append("not cloned here")
        if missing:
            incomplete += 1
        elif args.quiet:
            continue
        tick = lambda b: "ok" if b else "--"  # noqa: E731
        note = ", ".join(missing) if missing else (
            "(" + ", ".join(elsewhere) + ")" if elsewhere else "")
        print(
            f"{r['name']:<28} {tick(bool(r['remote_url'])):>7} {tick(r['in_resolver']):>7} "
            f"{tick(r['has_clone']):>6} {tick(r['in_index']):>6}  {note}"
        )

    if args.suggest_resolver:
        pend = [r for r in repo_rows if r["has_clone"] and not r["in_resolver"]]
        print()
        if not pend:
            print("nothing to suggest -- every located clone is registered.")
        else:
            print(f"# {len(pend)} located clones missing a resolver row; paste into .claude/local-paths.md:")
            for r in sorted(pend, key=lambda x: x["name"].lower()):
                ident = r["remote_url"] or "(no remote)"
                print('| `' + r['name'] + '` | `' + str(r['resolved']) + '` | `' + ident + '` | `README.md` |')
        return 0

    away = sum(1 for r in repo_rows if not r["has_clone"] and r["remote_url"])
    print()
    print(f"{incomplete}/{len(repo_rows)} projects have a REGISTRATION DEFECT.")
    if away:
        print(f"{away} more exist but are not cloned here -- backed by a remote, "
              "so 'not here' is not 'missing'.")
    if page_only and not args.quiet:
        print("\npointer-only pages (no repo declared -- fine if not started):")
        for r in page_only:
            print(f"  {r['name']}  ({r['page']})")
    return 1 if incomplete else 0


if __name__ == "__main__":
    sys.exit(main())
