#!/usr/bin/env python3
"""Print compact context for unresolved Git conflicts."""

from __future__ import annotations

import argparse
import difflib
import json
import re
import subprocess
import sys
from pathlib import Path
from typing import Any

START = re.compile(r"^<<<<<<<(?: (.*))?$")
BASE = re.compile(r"^\|\|\|\|\|\|\|(?: (.*))?$")
END = re.compile(r"^>>>>>>>(?: (.*))?$")


def git(root: Path, *args: str) -> str:
    """Run a read-only Git command and return stdout.

    Args:
        root: Repository root.
        *args: Arguments passed to Git.

    Raises:
        RuntimeError: If Git exits unsuccessfully.

    Example:
        ``git(Path.cwd(), "status", "--short")``
    """
    result = subprocess.run(
        ["git", "-C", str(root), *args], capture_output=True, text=True, check=False
    )
    if result.returncode:
        message = result.stderr.strip() or result.stdout.strip() or "unknown Git error"
        raise RuntimeError(message)
    return result.stdout


def repository_root(start: Path) -> Path:
    """Find the Git repository containing a path.

    Args:
        start: Path in the repository.

    Returns:
        The resolved repository root.

    Raises:
        RuntimeError: If the path is not in a Git repository.

    Example:
        ``root = repository_root(Path.cwd())``
    """
    return Path(git(start, "rev-parse", "--show-toplevel").strip()).resolve()


def unmerged_entries(root: Path) -> dict[str, dict[int, str]]:
    """Return unresolved paths and their index-stage object IDs.

    Args:
        root: Repository root.

    Returns:
        A mapping from path to stage/object-ID mappings.

    Example:
        ``entries = unmerged_entries(root)``
    """
    entries: dict[str, dict[int, str]] = {}
    for record in git(root, "ls-files", "-u", "-z").split("\0"):
        if not record:
            continue
        metadata, path = record.split("\t", 1)
        _, object_id, stage = metadata.split()
        entries.setdefault(path, {})[int(stage)] = object_id
    return entries


def text_lines(path: Path) -> list[str] | None:
    """Read a non-binary working-tree file as lines.

    Args:
        path: File to read.

    Returns:
        Text lines, or ``None`` for missing, directory, or binary files.

    Example:
        ``lines = text_lines(root / "src/main.py")``
    """
    if not path.is_file():
        return None
    try:
        text = path.read_text(encoding="utf-8", errors="replace")
    except OSError:
        return None
    return None if "\0" in text else text.splitlines()


def stage_lines(root: Path, path: str, stage: int) -> list[str] | None:
    """Read a path from a Git index stage.

    Args:
        root: Repository root.
        path: Repository-relative path.
        stage: Index stage: 1 is base, 2 ours, and 3 theirs.

    Returns:
        Text lines, or ``None`` when absent or binary.

    Example:
        ``ours = stage_lines(root, "src/main.py", 2)``
    """
    result = subprocess.run(
        ["git", "-C", str(root), "show", f":{stage}:{path}"],
        capture_output=True,
        text=True,
        check=False,
    )
    if result.returncode or "\0" in result.stdout:
        return None
    return result.stdout.splitlines()


def truncate(lines: list[str], maximum: int) -> list[str]:
    """Limit output while reporting omitted line count.

    Args:
        lines: Lines to limit.
        maximum: Maximum number of original lines.

    Returns:
        The limited lines.

    Example:
        ``short = truncate(lines, 40)``
    """
    if len(lines) <= maximum:
        return lines
    return [*lines[:maximum], f"... ({len(lines) - maximum} lines omitted)"]


def parse_hunks(lines: list[str], context: int) -> tuple[list[dict[str, Any]], str | None]:
    """Parse diff3-style conflict markers from working-tree text.

    Args:
        lines: File contents split into lines.
        context: Surrounding lines to retain.

    Returns:
        Parsed hunks and an optional parse error.

    Example:
        ``hunks, error = parse_hunks(lines, 2)``
    """
    hunks: list[dict[str, Any]] = []
    cursor = 0
    while cursor < len(lines):
        match = START.match(lines[cursor])
        if not match:
            cursor += 1
            continue
        start = cursor
        ours_label = match.group(1) or "ours"
        cursor += 1
        ours: list[str] = []
        base: list[str] = []
        theirs: list[str] = []
        base_label: str | None = None
        while cursor < len(lines) and lines[cursor] != "=======":
            base_match = BASE.match(lines[cursor])
            if base_match:
                base_label = base_match.group(1) or "base"
                cursor += 1
                while cursor < len(lines) and lines[cursor] != "=======":
                    base.append(lines[cursor])
                    cursor += 1
                break
            ours.append(lines[cursor])
            cursor += 1
        if cursor >= len(lines):
            return hunks, f"unterminated conflict at line {start + 1}"
        cursor += 1
        while cursor < len(lines) and not END.match(lines[cursor]):
            theirs.append(lines[cursor])
            cursor += 1
        if cursor >= len(lines):
            return hunks, f"unterminated conflict at line {start + 1}"
        end_match = END.match(lines[cursor])
        theirs_label = end_match.group(1) if end_match and end_match.group(1) else "theirs"
        end = cursor
        cursor += 1
        hunks.append(
            {
                "start_line": start + 1,
                "end_line": end + 1,
                "before": lines[max(0, start - context) : start],
                "ours_label": ours_label,
                "ours": ours,
                "base_label": base_label,
                "base": base if base_label else None,
                "theirs_label": theirs_label,
                "theirs": theirs,
                "after": lines[cursor : cursor + context],
            }
        )
    return hunks, None


def conflict_type(stages: list[int], hunk_count: int) -> str:
    """Classify a conflict using index stages and marker count.

    Args:
        stages: Available index stages.
        hunk_count: Number of parsed marker hunks.

    Returns:
        A concise conflict type.

    Example:
        ``kind = conflict_type([1, 2], 0)``
    """
    if hunk_count:
        return "text"
    stage_set = set(stages)
    return {
        frozenset({2, 3}): "add/add",
        frozenset({1, 2}): "deleted-by-them",
        frozenset({1, 3}): "deleted-by-us",
        frozenset({1, 2, 3}): "index-only",
    }.get(frozenset(stage_set), "unmerged")


def report_for(root: Path, path: str, stages: dict[int, str], context: int) -> dict[str, Any]:
    """Build a report for one unresolved path.

    Args:
        root: Repository root.
        path: Repository-relative path.
        stages: Index stages for the path.
        context: Surrounding hunk lines to include.

    Returns:
        A serializable report.

    Example:
        ``report = report_for(root, path, stages, 2)``
    """
    lines = text_lines(root / path)
    hunks, error = parse_hunks(lines, context) if lines is not None else ([], None)
    stage_numbers = sorted(stages)
    return {
        "path": path,
        "stages": stage_numbers,
        "conflict_type": conflict_type(stage_numbers, len(hunks)),
        "marker_hunks": len(hunks),
        "parse_error": error,
        "hunks": hunks,
    }


def index_preview(root: Path, path: str, maximum: int) -> dict[str, Any]:
    """Build a compact base/ours/theirs preview.

    Args:
        root: Repository root.
        path: Repository-relative path.
        maximum: Maximum lines per section.

    Returns:
        Stage contents and an ours/theirs unified diff.

    Example:
        ``preview = index_preview(root, path, 40)``
    """
    base = stage_lines(root, path, 1)
    ours = stage_lines(root, path, 2)
    theirs = stage_lines(root, path, 3)
    preview: dict[str, Any] = {
        "base": truncate(base, maximum) if base is not None else None,
        "ours": truncate(ours, maximum) if ours is not None else None,
        "theirs": truncate(theirs, maximum) if theirs is not None else None,
    }
    if ours is not None and theirs is not None:
        diff = list(difflib.unified_diff(ours, theirs, "ours", "theirs", lineterm=""))
        preview["ours_vs_theirs_diff"] = truncate(diff or ["(no textual diff)"], maximum)
    return preview


def print_section(title: str, lines: list[str] | None) -> None:
    """Print an indented report section.

    Args:
        title: Section heading.
        lines: Content, or ``None`` when unavailable.

    Example:
        ``print_section("ours", ["line"])``
    """
    print(f"{title}:")
    if lines is None:
        print("  (not present)")
    elif not lines:
        print("  (empty)")
    else:
        for line in lines:
            print(f"  {line}")


def print_detail(root: Path, report: dict[str, Any], maximum: int) -> None:
    """Render one detailed conflict report.

    Args:
        root: Repository root.
        report: Report from :func:`report_for`.
        maximum: Maximum lines per section.

    Example:
        ``print_detail(root, report, 40)``
    """
    print(f"== {report['path']} ==")
    print(f"type: {report['conflict_type']}")
    print(f"stages: {', '.join(map(str, report['stages']))}")
    if report["parse_error"]:
        print(f"parse-error: {report['parse_error']}")
    if not report["hunks"]:
        preview = index_preview(root, report["path"], maximum)
        for key in ("ours", "base", "theirs", "ours_vs_theirs_diff"):
            if key in preview:
                print_section(key.replace("_", " "), preview[key])
        return
    for number, hunk in enumerate(report["hunks"], 1):
        print(f"\n[hunk {number}] current lines {hunk['start_line']}-{hunk['end_line']}")
        print_section("before", truncate(hunk["before"], maximum))
        print_section(f"ours ({hunk['ours_label']})", truncate(hunk["ours"], maximum))
        if hunk["base"] is not None:
            print_section(f"base ({hunk['base_label']})", truncate(hunk["base"], maximum))
        print_section(f"theirs ({hunk['theirs_label']})", truncate(hunk["theirs"], maximum))
        diff = list(
            difflib.unified_diff(
                hunk["ours"], hunk["theirs"], hunk["ours_label"], hunk["theirs_label"], lineterm=""
            )
        )
        print_section("ours vs theirs diff", truncate(diff or ["(no textual diff)"], maximum))
        print_section("after", truncate(hunk["after"], maximum))


def main() -> int:
    """Run the conflict-context CLI.

    Returns:
        Process exit code: zero on success and two for invalid input or Git errors.

    Example:
        ``raise SystemExit(main())``
    """
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--repo", default=".", help="Path inside the target repository")
    parser.add_argument("--file", action="append", default=[], help="Conflicted path to inspect; repeatable")
    parser.add_argument("--all", action="store_true", help="Inspect all conflicted paths")
    parser.add_argument("--json", action="store_true", help="Emit JSON")
    parser.add_argument("--context", type=int, default=2, help="Surrounding lines per hunk")
    parser.add_argument("--max-lines", type=int, default=40, help="Maximum lines per section")
    args = parser.parse_args()
    if args.all and args.file:
        parser.error("--all cannot be combined with --file")
    if args.context < 0 or args.max_lines < 1:
        parser.error("--context must be non-negative and --max-lines must be positive")
    try:
        root = repository_root(Path(args.repo).resolve())
        entries = unmerged_entries(root)
        reports = [report_for(root, path, entries[path], args.context) for path in sorted(entries)]
        requested = set(args.file)
        selected = reports if args.all else [r for r in reports if r["path"] in requested]
        missing = requested - {r["path"] for r in reports}
        if missing:
            raise RuntimeError(f"conflicted path not found: {', '.join(sorted(missing))}")
        if args.json:
            output = selected or reports
            for report in output:
                if not report["hunks"]:
                    report["index_preview"] = index_preview(root, report["path"], args.max_lines)
            print(json.dumps({"repo_root": str(root), "conflicted_files": output}, indent=2))
        elif selected:
            for index, report in enumerate(selected):
                if index:
                    print()
                print_detail(root, report, args.max_lines)
        else:
            print(f"repo: {root}\nconflicted files: {len(reports)}")
            for report in reports:
                stages = ",".join(map(str, report["stages"]))
                print(
                    f"- {report['path']} | type={report['conflict_type']} "
                    f"| stages={stages} | hunks={report['marker_hunks']}"
                )
            if reports:
                print("use --file <path> for compact hunk details or --all for every file")
    except RuntimeError as error:
        print(f"error: {error}", file=sys.stderr)
        return 2
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
