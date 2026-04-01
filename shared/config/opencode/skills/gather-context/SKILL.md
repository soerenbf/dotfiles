---
name: gather-context
description: Gathers and cross-references context from Linear, Confluence, and GitHub for a given task
---

## Purpose

Systematically collect all relevant context for a task from multiple sources (Linear, Confluence, GitHub) and cross-reference them to build a complete picture.

## When to Use

Use this skill when you need to understand the full scope of a task by pulling information from project management tools, documentation, and code repositories.

## Procedure

### 1. Identify the Task

- Determine the task identifier (Linear issue ID, GitHub issue/PR number, or Confluence page title)
- If the user provides a vague description, search across all sources to locate the canonical task

### 2. Gather from Linear

- Fetch the primary issue details: title, description, status, assignee, labels, priority
- Fetch parent issues and sub-issues to understand hierarchy
- Check the project and initiative the issue belongs to for broader context
- Read any comments on the issue for discussion and decisions
- Note blocking/blocked-by relationships

### 3. Gather from Confluence

- Search for pages related to the task by title, keywords, and linked issue IDs
- Read product/feature specification documents
- Read technical design documents
- Check for ADRs (Architecture Decision Records) relevant to the domain
- Read inline and footer comments for ongoing discussions

### 4. Gather from GitHub

- Search for related issues and PRs by keywords and cross-references
- Read linked PRs for prior implementation attempts or related work
- Check open issues in the relevant repository for related bugs or feature requests
- Review recent commits in the affected area of the codebase for recent changes

### 5. Cross-Reference

For each piece of information found, verify consistency across sources:

- **Requirements**: Do the Linear issue description, Confluence spec, and GitHub issue agree on what needs to be built?
- **Scope**: Are there scope differences between what the product doc says and what the engineering issue describes?
- **Status**: Is the current status in Linear consistent with any linked PRs or recent commits?
- **Terminology**: Are the same concepts referred to by the same names across all sources?
- **Acceptance criteria**: Do they exist? Are they consistent across sources?

### 6. Compile Findings

Organize all gathered context into a structured summary:

- **Sources consulted** (with links/IDs)
- **Consistent facts** (agreed upon across sources)
- **Inconsistencies found** (with specifics from each source)
- **Gaps identified** (information missing from all sources)
- **Open questions** (things that need user clarification)

## Important Notes

- Always cite the source for each piece of information (e.g., "Linear issue LIN-123", "Confluence page ID 456789")
- Do NOT assume that any single source is authoritative over others — flag conflicts
- If a source is unavailable or returns errors, note this explicitly rather than silently skipping it
- Prefer recent information over stale information when timestamps are available
