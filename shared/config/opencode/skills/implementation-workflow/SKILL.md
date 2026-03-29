---
name: implementation-workflow
description: Implementation workflow for subagents - write code and tests, then report back
---

## Purpose

Define the implementation workflow used by the implement agent. This workflow writes implementation code and tests, then reports back to the parent agent for review and commit.

## When to Use

Use this skill when implementing a plan step. This is the core workflow for the `sdd-implement` sub-agent.

## Workflow

### Phase 1: Understand the Assignment

1. Read the analysis document for full context
2. Read the specific plan step assigned to you
3. Read any learnings from prior steps provided by the parent agent
4. Identify the files to be changed and their current state
5. Identify the test framework and patterns used in the project

### Phase 2: Implement Code

1. **Write the implementation** to satisfy the acceptance criteria from the plan step:
   - Follow existing code patterns and conventions in the project
   - Keep implementation minimal — only what's needed to satisfy the acceptance criteria
   - Make appropriate changes to satisfy all acceptance criteria
2. **Run any available formatter** on the changed files
3. **Run any available linter** and fix violations

### Phase 3: Write Tests

1. **Determine test location**: Follow the project's existing test file conventions (co-located, `__tests__/`, `test/`, etc.)
2. **Write unit tests** that cover the implementation and acceptance criteria:
   - Each acceptance criterion should map to at least one test case
   - Include edge cases and error scenarios
   - Tests should be descriptive: test names should read as specifications
   - Cover the main functionality and important edge cases
3. **Run the tests** to verify they all pass
4. **Run the full test suite** to confirm nothing is broken

### Phase 4: Report Back

**DO NOT commit anything.** The parent agent handles reviews and commits.

Provide a complete report with:

1. **Implementation files**: List each source file modified with a brief description of changes
2. **Test files created**: List each test file with a brief description of what it tests
3. **Test results**: Confirm all tests pass (show test count if available)
4. **Lint/format status**: Confirm all formatting and linting is clean
5. **What was implemented**: Brief explanation of the changes and how they satisfy the acceptance criteria
6. **Deviations**: Note any differences from the plan step and explain why
7. **Learnings**: Share any insights or concerns for subsequent steps (e.g., dependencies, configuration needs)
8. **Files to commit**: Complete list of all files (implementation + tests) for the commit

### Example Report

```
✅ Implementation complete

**Implementation files:**
- src/auth/token-manager.ts - Added refreshToken() method with exponential backoff
- src/auth/types.ts - Added RefreshTokenOptions interface

**Test files created:**
- src/auth/__tests__/token-refresh.test.ts - Tests token refresh logic with retry and error handling

**Test results:** ✅ All 8 tests passing
**Lint/format:** ✅ Clean

**What was implemented:**
Implemented automatic token refresh with exponential backoff retry logic as specified in the acceptance criteria. The refresh method attempts up to 3 retries with increasing delays (1s, 2s, 4s).

**Deviations:**
None - implementation matches plan exactly.

**Learnings for next steps:**
The token manager now requires the refreshEndpoint to be configured in the client options. Step 3 will need to update the configuration loader to include this new required field.

**Files to commit:**
- src/auth/token-manager.ts
- src/auth/types.ts
- src/auth/__tests__/token-refresh.test.ts
```

## Rules

- NEVER commit anything. The parent agent handles reviews and commits.
- NEVER wait for user approval. Write the code and report back immediately.
- ALWAYS run formatters and linters before reporting back.
- ALWAYS verify all tests pass before reporting back.
- ONLY modify files relevant to the assigned plan step.
- ALWAYS provide a complete list of all files to commit.
- Keep implementation minimal — only write what is needed to satisfy the acceptance criteria.
- If tests cannot be written for a step (e.g., pure configuration changes), explain why in your report.
- If the existing test framework is unclear, explore the codebase first or mention it in your report.
- Write tests that verify the implementation works correctly, covering both happy paths and edge cases.
