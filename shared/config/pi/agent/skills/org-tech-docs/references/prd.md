# Product Requirements Documents

## Purpose

A PRD establishes the product problem, scope, and observable behavior that engineering and product stakeholders can implement and verify. In Concordium technical product areas, a PRD may be technically precise, but it should avoid selecting implementation mechanisms unless they are themselves externally required behavior.

## Audience and Outcome

Primary readers include product owners, architects, engineers, QA, security, and affected ecosystem teams. They should leave able to answer:

- What problem are we solving and for whom?
- What behavior is required?
- Which failure, safety, and recovery properties are mandatory?
- What is explicitly outside scope?
- How will we determine whether each requirement is satisfied?

## Expected Content

Use [../assets/prd-template.md](../assets/prd-template.md) proportionately.

### Problem Statement

Describe the present limitation, affected actors, consequences, and why existing behavior is insufficient. Avoid beginning with the preferred implementation.

### Product-Level Solution

Describe the capability and its behavioral boundaries. State how it fits existing behavior, especially compatibility and safety invariants. Do not prescribe exact serialization, language types, entrypoint names, or repository plumbing unless product behavior depends on them.

### Use Cases

For each independently valuable or risky behavior, include:

- priority: Must-Have, Should-Have, or another agreed scheme;
- primary actor;
- relevant preconditions;
- main success flow;
- Given/When/Then acceptance criteria.

Include negative, authorization, boundary, atomicity, failure, recovery, and compatibility cases where material. Do not force every acceptance criterion into a separate use case; choose the structure that is easiest to verify.

### Non-Functional Requirements

Use NFRs for cross-cutting guarantees such as security boundaries, atomicity, failure behavior, compatibility, resource limits, observability, reliability, and operability. Write them as testable requirements, not aspirations.

### Scope

Make exclusions explicit, particularly tempting adjacent behavior. Distinguish permanent safety exclusions from delivery-scope deferrals.

## Writing Rules

- Use **must** for requirements, **should** for desired but negotiable behavior, and **may** for permission.
- Give each requirement one source of normative truth. Repeat critical invariants only when local readability justifies it.
- Keep acceptance criteria observable. Avoid internal call order unless ordering is an externally necessary guarantee such as authorization before mutation.
- Identify TBD priorities or release targets as unresolved rather than disguising them as requirements.
- Link related proposals and ADRs when they exist; do not require them before the PRD can be useful.

## Common Failure Modes

- **Solution disguised as problem:** rewrite the problem independently of the preferred mechanism.
- **Implementation plan in the PRD:** move schemas, component changes, and migration mechanics to the feature proposal.
- **Only happy paths:** add denial, rollback, boundary, and recovery behavior.
- **Verbose duplication:** consolidate repeated guarantees into an NFR and reference it locally.
- **Untestable words:** replace “easy,” “secure,” “fast,” or “user-friendly” with observable criteria or an explicitly owned research question.
