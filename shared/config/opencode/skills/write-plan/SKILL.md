---
name: write-plan
description: Template and guidelines for writing the implementation plan with detailed checklist steps
---

## Purpose

Define the structure and quality standards for the implementation plan produced during the planning phase. This plan is consumed by the execution agent to orchestrate work across sub-agents.

## When to Use

Use this skill when creating or updating the plan document at `.opencode/docs/<task-name>/plan.md`.

## Document Template

The plan document MUST follow this structure:

```markdown
# Implementation Plan: <Task Title>

> **Analysis**: [analysis.md](./analysis.md)
> **Date**: <YYYY-MM-DD>
> **Status**: Draft | In Progress | Complete

## Overview

1-2 paragraph summary of the implementation approach. Reference key decisions
from the analysis document.

## Prerequisites

List anything that must be true before implementation begins:
- [ ] Dependencies installed/available
- [ ] Environment configured
- [ ] Access/permissions confirmed
- [ ] Feature flags created (if applicable)

## Steps

### Step 1: <Short Title>

- **Description**: What this step accomplishes and why it comes at this position in the sequence.
- **Files**:
  - `path/to/file1.ts` — Description of changes
  - `path/to/file2.ts` — Description of changes
- **Dependencies**: None | Step N (explain why)
- **Acceptance criteria**:
  - [ ] Criterion 1
  - [ ] Criterion 2
- **Estimated scope**: Small (< 50 lines) | Medium (50-200 lines) | Large (200+ lines)
- **Status**: Pending | In Progress | Complete | Blocked
- **Notes**: Any additional context for the implementing agent.

### Step 2: <Short Title>
...

## Parallel Execution Groups

Identify which steps can run in parallel:

- **Group 1** (parallel): Steps 1, 2, 3
- **Group 2** (sequential, after Group 1): Step 4
- **Group 3** (parallel, after Group 2): Steps 5, 6

## Integration Verification

After all steps are complete:
- [ ] All unit tests pass
- [ ] Integration tests pass (if applicable)
- [ ] Linting passes with no new warnings
- [ ] Formatting is consistent
- [ ] No regressions in existing functionality

## Learnings Log

Capture insights gained during implementation that may affect subsequent steps:

| Step | Learning | Impact on Later Steps |
|------|----------|-----------------------|
| - | - | - |
```

## Guidelines

### Step Granularity

Each step should be:
- **Independently implementable**: A sub-agent can complete it without needing to do another step first (unless explicitly listed as a dependency)
- **Independently testable**: Has its own acceptance criteria that can be verified in isolation
- **Scoped to one concern**: A step should do one thing (e.g., "Add the data model" not "Add the data model and the API endpoint and the tests")

### Ordering

- Place foundational work first (data models, types, interfaces)
- Group related changes that must be consistent (e.g., API contract + client)
- Place integration and end-to-end steps last
- Maximize parallelism: prefer wide dependency graphs over deep chains

### Dependencies

- Only mark a step as dependent when there is a true data or API dependency
- "Step 3 depends on Step 1" means Step 3 cannot begin until Step 1 is complete
- If the dependency is only for testing purposes, note that: "Step 3 depends on Step 1 for integration testing but can be implemented in parallel"

### Updating the Plan

When the execute agent updates the plan during implementation:
- Update the **Status** field of completed steps
- Add entries to the **Learnings Log** that may affect future steps
- If a step needs to be split, add sub-steps (e.g., Step 3a, Step 3b)
- If a step is no longer needed, mark it as "Skipped" with a reason
- NEVER remove steps — preserve the history

### File References

For each file listed in a step:
- Use paths relative to the project root
- Describe what changes (not how — implementation details belong to the sub-agent)
- If a file does not exist yet, mark it as "(new)"
