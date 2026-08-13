---
name: resolve-merge-conflicts
description: Resolve in-progress Git merge, rebase, cherry-pick, revert, or stash conflicts by inspecting compact conflict context, recovering the intent of each side, editing files safely, and validating the result. Use when Git reports unmerged paths or files contain conflict markers.
---

# Resolve Merge Conflicts

Resolve conflicts semantically, not by mechanically choosing `ours` or `theirs`. Preserve the intent of both changes when compatible; do not invent unrelated behavior.

This skill may edit conflicted files, but it MUST obey repository-local instructions governing Git operations. If Git writes are prohibited, do not stage files, run `git checkout`, continue or abort an operation, commit, reset, or otherwise mutate Git state. Instead, finish safe file edits, report what remains, and ask the user to perform the required Git commands.

## 1. Establish State

Read repository guidance such as `AGENTS.md` before changing anything.

Use read-only commands to identify the operation and unresolved paths:

```bash
git status --short
git status
git diff --name-only --diff-filter=U
git ls-files -u
```

Start with the bundled compact inspector rather than opening every conflicted file:

```bash
python3 ~/.pi/agent/skills/resolve-merge-conflicts/scripts/extract_conflict_context.py
```

Then inspect one file at a time:

```bash
python3 ~/.pi/agent/skills/resolve-merge-conflicts/scripts/extract_conflict_context.py \
  --file path/to/file
```

The script recognizes text, add/add, modify/delete, and index-only conflicts. Use `--json`, `--context`, or `--max-lines` when useful.

## 2. Recover Both Intents

For each conflict, determine why each side changed. Use the smallest useful combination of:

```bash
git log --oneline --decorate --graph --all -- path/to/file
git log -p -- path/to/file
git show <commit> -- path/to/file
git diff --cc -- path/to/file
git show :1:path/to/file  # merge base, when present
git show :2:path/to/file  # ours
git show :3:path/to/file  # theirs
```

Read related tests, callers, configuration, commit messages, PRs, and issues when they clarify intent. Do not infer correctness solely from branch names or recency.

### Ours/Theirs Warning

The labels are operation-relative:

- During a normal merge, `ours` is the checked-out branch and `theirs` is the merged branch.
- During a rebase, `ours` is generally the new base/upstream and `theirs` is the commit being replayed.

Confirm the active operation before interpreting either side.

## 3. Resolve One File at a Time

Choose among these outcomes:

1. **Combine both intents** when they are compatible.
2. **Choose one intent** when the other is obsolete or contrary to the operation's goal.
3. **Ask the user** when the intents are incompatible, product behavior is unclear, data may be lost, or deletion is ambiguous.

Edit the working-tree file directly and remove all conflict markers. Read more surrounding code only when compact context is insufficient.

Do not:

- blindly choose `ours` or `theirs`
- resolve every hunk the same way
- introduce behavior unsupported by either side
- discard migrations, tests, security checks, or error handling without understanding why
- use `git checkout --ours`, `git checkout --theirs`, `git add`, or another Git-writing command when local policy prohibits it

For rename, binary, submodule, directory/file, or modify/delete conflicts, inspect index stages and history. Ask before destructive or uncertain resolutions.

## 4. Re-check and Validate

After each file, re-run the inspector. Before declaring the content resolved, verify:

```bash
git diff --name-only --diff-filter=U
rg -n '^(<<<<<<<|=======|>>>>>>>)( |$)' <resolved-paths>
```

An unmerged index can remain until the user stages files; distinguish that expected state from unresolved file content.

Run the project's targeted formatter, type checker, linter, build, and tests for the touched area. Expand to broader checks when risk warrants it. Do not fix unrelated failures.

## 5. Report Clearly

Summarize:

- files and hunks resolved
- how competing intents were preserved or which trade-off was chosen
- ambiguous conflicts requiring user input
- checks run and their results
- remaining conflict markers or unmerged paths
- exact Git-writing steps the user must perform when policy prevents the agent from doing so

Never claim the merge or rebase is complete merely because conflict markers are gone. Completion also requires the appropriate staging and continuation steps, performed only when repository policy and user authorization allow them.
