---
name: tdd-workflow
description: Test-driven development workflow with hard review gates and structured commit flow
---

## Purpose

Define the test-first development workflow used by the implement agent. This workflow enforces hard review gates where the user must approve before proceeding.

## When to Use

Use this skill when implementing a plan step. This is the core workflow for the implement sub-agent.

## Workflow

### Phase 1: Understand the Assignment

1. Read the analysis document for full context
2. Read the specific plan step assigned to you
3. Read any learnings from prior steps provided by the team lead
4. Identify the files to be changed and their current state
5. Identify the test framework and patterns used in the project

### Phase 2: Write Tests

1. **Determine test location**: Follow the project's existing test file conventions (co-located, `__tests__/`, `test/`, etc.)
2. **Write unit tests** that cover the acceptance criteria from the plan step
3. **Test structure**:
   - Each acceptance criterion should map to at least one test case
   - Include edge cases and error scenarios
   - Tests should be descriptive: test names should read as specifications
   - Tests MUST fail at this point (the implementation does not exist yet)
4. **Run the tests** to confirm they fail with expected errors (not syntax or import errors)

### Phase 3: Test Review Gate (HARD STOP)

Present the tests to the user for review:

- Show the test file(s) created
- Explain what each test verifies and which acceptance criterion it maps to
- Highlight any edge cases or scenarios you added beyond the acceptance criteria
- Ask: "Are these tests correct and complete? Should I add, remove, or modify any test cases?"

**DO NOT PROCEED until the user explicitly approves the tests.**

If the user requests changes:
1. Make the requested changes
2. Run tests again to confirm they still fail as expected
3. Present the updated tests for review again

### Phase 4: Commit Tests

Once tests are approved:

1. Stage ONLY the test files you created (verify with `git status`)
2. Create a commit with message format: `test(<scope>): <description>`
   - Example: `test(auth): add unit tests for token refresh logic`
3. Verify the commit succeeded

### Phase 5: Implement Code

1. Write the implementation to make all tests pass
2. Run the test suite to verify all tests pass
3. Run any available formatter on the changed files
4. Run any available linter and fix violations
5. Run the full test suite again to confirm nothing is broken

### Phase 6: Implementation Review Gate (HARD STOP)

Present the implementation to the user for review:

- Show the implementation file(s) created or modified
- Explain key implementation decisions
- Show test results (all passing)
- Show linter/formatter output (clean)
- Note any deviations from the plan step and explain why

**DO NOT PROCEED until the user explicitly approves the implementation.**

If the user requests changes:
1. Make the requested changes
2. Re-run tests, formatter, and linter
3. Present the updated implementation for review again

### Phase 7: Commit Implementation

Once implementation is approved:

1. Stage ONLY the implementation files you modified during this step (verify with `git status`)
2. Create a commit with message format: `<type>(<scope>): <description>`
   - Types: `feat`, `fix`, `refactor`, `perf`, `chore`
   - Example: `feat(auth): implement token refresh with automatic retry`
3. Verify the commit succeeded
2. Create a commit with message format: `<type>(<scope>): <description>`
   - Types: `feat`, `fix`, `refactor`, `perf`, `chore`
   - Example: `feat(auth): implement token refresh with automatic retry`
3. Verify the commit succeeded

## Rules

- NEVER skip a review gate. If the user is unresponsive, wait.
- NEVER combine test and implementation commits. They must be separate.
- NEVER commit files that fail linting or formatting checks.
- If tests cannot be written for a step (e.g., pure configuration changes), explain why and ask the user if they want to proceed without tests.
- If the existing test framework is unclear, ask the user before guessing.
- Keep implementation minimal — only write what is needed to pass the tests and satisfy the acceptance criteria.
