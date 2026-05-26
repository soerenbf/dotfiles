---
name: review
description: Review code changes for correctness, security, performance, maintainability, style, and testing. Use when asked to review staged changes, a diff, a file, a commit, a commit range, or a branch before merging or committing.
---

# Review

Adapted from Anthropic's proven engineering `code-review` skill for Pi and cross-project use.

## When to Use

Use this skill when a user explicitly asks for a code review, such as:
- `/skill:review`
- `review staged changes`
- `review HEAD~3..HEAD`
- `review main...feature`
- `review this file`
- `focus on security` or `look for perf regressions`

If no review target is clear, ask what to review before continuing.

## Supported Targets

Interpret requests in this order:
1. Explicit diff or pasted patch
2. Existing file or directory path
3. Git commit range like `A..B`
4. Git branch diff like `A...B`
5. Single commit like `HEAD~1` or `abc1234`
6. `staged changes`
7. Current working tree changes

If a target is ambiguous, ask a follow-up question instead of guessing.

## Gather Context

### 1. Resolve the change set

Use git and file tools to collect the smallest useful review surface.

Examples:
```bash
git diff --cached
git diff
git diff A..B
git diff A...B
git show --stat --patch <commit>
git diff -- <path>
```

Also gather the changed file list when helpful:
```bash
git diff --name-only --cached
git diff --name-only A..B
git diff --name-only A...B
```

### 2. Read surrounding context

Diffs are the starting point, not the full truth. Read nearby code when needed to verify:
- call sites and callers
- related tests
- configuration files
- interfaces, types, schemas, migrations
- adjacent modules that define invariants or contracts

### 3. Discover repository conventions at runtime

This skill is global and MUST stay project-agnostic. Before making style or convention claims, look for repository-local guidance such as:
- `AGENTS.md`
- formatter config (`.prettierrc*`, `prettier.config.*`, `.stylua.toml`, `pyproject.toml`, etc.)
- lint config (`eslint.config.*`, `.eslintrc*`, `ruff.toml`, `selene.toml`, etc.)
- type-check or build config (`tsconfig.json`, `mypy.ini`, `Cargo.toml`, `go.mod`, etc.)
- strong existing patterns in nearby code

If local guidance is missing, fall back to language and runtime best practices. Do not invent project-specific rules.

## Review Priorities

Prioritize findings in this order:
1. Correctness and reliability
2. Security
3. Performance
4. Maintainability
5. Style, language idioms, and project conventions
6. Testing

A focused request like `focus on security` should increase attention in that area, but still surface critical issues in other categories.

## Review Dimensions

### Correctness
Look for:
- broken logic, invalid assumptions, missing edge cases
- null/empty handling, off-by-one mistakes, overflow/underflow
- race conditions, ordering problems, state corruption
- weak error handling, silent failure, incorrect retries/timeouts
- API/contract mismatches and migration hazards

### Security
Look for:
- injection risks, XSS, CSRF, SSRF, path traversal
- authn/authz flaws and privilege escalation
- unsafe secrets handling or credential exposure
- insecure parsing, deserialization, or shell/file usage
- trust boundary violations and unsafe defaults

### Performance
Look for:
- needless allocations, copies, serialization, or work in hot paths
- N+1 queries, unbounded scans, missing pagination or indexing
- expensive loops or poor algorithmic complexity
- blocking I/O, lock contention, excessive network chatter
- leaks of memory, file handles, connections, goroutines, etc.

### Maintainability
Look for:
- confusing naming or hidden coupling
- duplication and avoidable complexity
- unclear ownership of responsibilities
- brittle control flow or hard-to-extend structure
- missing comments/docs for non-obvious behavior

### Style and idioms
Look for:
- violations of discovered project conventions
- non-idiomatic language or runtime usage
- readability issues that materially affect comprehension

Keep low-value nits secondary unless the user explicitly asks for a strict/style-heavy review.

### Testing
Look for:
- missing coverage for changed behavior and edge cases
- tests that assert too little or miss regressions
- mismatch between implementation risk and test depth
- absent migration, contract, or failure-path tests when needed

## Output Format

Use this structure:

```markdown
## Review Summary
[1-3 sentence overview of the change and overall risk]

## Findings
| Severity | Category | Location | Issue | Why it matters | Suggested fix |
|----------|----------|----------|-------|----------------|---------------|
| High | Security | auth.ts:42 | ... | ... | ... |

## Positives
- [Good patterns worth keeping]

## Gaps / Uncertainty
- [Anything you could not verify from the diff and available context]

## Verdict
- Safe to merge
- Merge with follow-ups
- Request changes
- Needs discussion
```

Rules for output:
- Prefer fewer, higher-signal findings over long nit lists
- Include location when available
- Explain impact, not just rule violations
- Distinguish confirmed issues from uncertainty
- If no meaningful issues are found, say so clearly

## Working Style

- Start from the diff, then pull more context as needed
- Ask clarifying questions when the target or intent is unclear
- Be especially careful with claims about project conventions
- Avoid overstating confidence when context is incomplete
- Do not block workflows automatically; provide guidance only

## Limitations

- This skill does not automatically trigger after edits
- This skill does not replace linters, tests, type-checkers, or security scanners
- PR URL review may require manually supplied diff/context if no external connector is available
