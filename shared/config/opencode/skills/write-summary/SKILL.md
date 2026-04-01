---
name: write-summary
description: Template and guidelines for writing the final implementation handoff summary for a completed SDD task
---

## Purpose

Define the structure and quality standards for the final summary document produced after execution completes. This document is the fastest way for future SDD workflows to understand what actually shipped.

## When to Use

Use this skill when creating or updating `.opencode/docs/<task-name>/summary.md` at the end of an SDD workflow.

## Document Template

The summary document MUST follow this structure:

```markdown
# Implementation Summary: <Task Title>

> **Task**: <task-name>
> **Date**: <YYYY-MM-DD>
> **Analysis**: [analysis.md](./analysis.md)
> **Plan**: [plan.md](./plan.md)

## Outcome

1-2 paragraphs describing what shipped and why it matters.

## Delivered Changes

- <Major change 1>
- <Major change 2>
- <Major change 3>

## Key Files

| File | Role in Final Implementation |
|------|------------------------------|
| `path/to/file.ts` | Added X support |
| `path/to/test.ts` | Verifies Y behavior |

## Decisions and Deviations

| Type | Detail | Impact |
|------|--------|--------|
| Decision | Chose X over Y | Simplified rollout |
| Deviation | Skipped Z from original plan | Follow-up task needed |

## Operational Notes

- New commands, flags, migrations, or feature toggles
- Rollout or compatibility constraints
- Known limitations or follow-up work

## Reuse for Future Tasks

- Patterns or utilities worth reusing
- Areas that future tasks should inspect first
- Anything likely to surprise a future implementer
```

## Quality Standards

- Reflect final implementation reality, not the original intent alone
- Prefer concise bullets and tables over long narrative
- Reference concrete file paths for important changes
- Call out deviations from the plan explicitly
- Include enough operational detail that a future analysis can decide where to look next without re-reading the full history

## Updating the Document

When updating an existing summary document:

- Preserve the original sections and refresh them to match the latest implementation state
- Add newly discovered follow-ups or limitations
- Remove stale statements that no longer describe the final system
