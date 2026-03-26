---
name: write-analysis
description: Template and guidelines for writing the analysis document that serves as the single source of truth for implementation
---

## Purpose

Define the structure and quality standards for the analysis document produced during the analyse phase. This document becomes the single source of truth for implementation.

## When to Use

Use this skill when creating or updating the analysis document at `.opencode/docs/<task-name>/analysis.md`.

## Document Template

The analysis document MUST follow this structure:

```markdown
# Analysis: <Task Title>

> **Task**: <Linear/GitHub issue identifier and link>
> **Date**: <YYYY-MM-DD>
> **Status**: Draft | Review | Final

## 1. Context

### 1.1 Background
Brief description of the feature/change and why it is needed. Reference the product
motivation from Confluence or the originating issue.

### 1.2 Sources
| Source | Reference | Description |
|--------|-----------|-------------|
| Linear | LIN-XXX   | Issue title |
| Confluence | Page ID / Title | Document title |
| GitHub | owner/repo#123 | Issue/PR title |

## 2. Requirements

### 2.1 Functional Requirements
Numbered list of what the system must do. Each requirement should be:
- Testable
- Unambiguous
- Traceable to a source

### 2.2 Non-Functional Requirements
Performance, security, accessibility, compatibility constraints.

### 2.3 Out of Scope
Explicitly list what is NOT included in this task.

## 3. Technical Context

### 3.1 Affected Components
List the modules, services, packages, or files that will be touched.

### 3.2 Dependencies
External services, libraries, or internal modules this work depends on.

### 3.3 Existing Behavior
Describe current behavior that will change. Include code references where relevant.

### 3.4 Related Prior Work
If this task builds on earlier SDD work, summarize the most relevant prior tasks:

| Task | Summary | Reusable Decisions | Files/Areas to Revisit |
|------|---------|--------------------|------------------------|
| add-token-refresh | Added refresh token lifecycle | Reuse token storage approach | `src/auth/*` |

## 4. Constraints

### 4.1 Technical Constraints
Architectural, platform, or technology constraints that limit implementation choices.

### 4.2 Business Constraints
Deadlines, backward compatibility, migration requirements, feature flags.

## 5. Decisions

Record decisions made during analysis. Each entry:

| ID | Decision | Rationale | Alternatives Considered |
|----|----------|-----------|------------------------|
| D1 | ... | ... | ... |

## 6. Open Questions

Questions that remain unresolved after the analysis phase. Each entry:

- **Q1**: <question>
  - **Impact**: What is blocked or affected
  - **Proposed resolution**: Suggested approach if no answer is available

## 7. Acceptance Criteria

Concrete, testable criteria for when this task is done. Format:

- [ ] AC1: <criterion>
- [ ] AC2: <criterion>
```

## Quality Standards

- Every requirement MUST be traceable to at least one source in section 1.2
- If prior SDD work exists, section 3.4 SHOULD reference the prior `summary.md` first and only fall back to `plan.md`/`analysis.md` as needed
- Every decision MUST include rationale and alternatives considered
- Acceptance criteria MUST be specific enough to write tests from
- The document MUST NOT contain implementation details (that belongs in the plan)
- Use precise language: "must", "should", "may" per RFC 2119 conventions
- Keep sections concise — link to external documents rather than duplicating content

## Updating the Document

When updating an existing analysis document:

- Change the Status field to reflect the current state
- Add a changelog entry at the bottom of the document with date and description of change
- Do NOT delete information — strike it through and add the replacement
- If requirements change, update acceptance criteria to match
