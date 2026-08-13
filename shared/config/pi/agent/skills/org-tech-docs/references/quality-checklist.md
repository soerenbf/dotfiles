# Technical Document Quality Checklist

Apply proportionately. A small ADR does not need the breadth of a cross-system feature proposal.

## Grounding and Accuracy

- Are material claims supported by linked documents, repository evidence, or named owners?
- Are current behavior, requirements, proposals, accepted decisions, and assumptions distinguishable?
- Are uncertain claims marked rather than presented as facts?
- Are terminology, identifiers, types, and examples consistent with primary sources?

## Reader and Decision

- Is the intended audience clear from the content and level of detail?
- Can the reader identify the requested decision or action?
- Does the document give enough context without reproducing related documents?
- Are goals, non-goals, and boundaries unambiguous?

## Completeness

- Are happy paths, rejection paths, boundary cases, recovery, and failure behavior covered where relevant?
- Are security, privacy, compatibility, operability, migration, rollback, and observability addressed when material?
- Are affected products, components, APIs, SDKs, data, tooling, documentation, and tests identified when material?
- Are alternatives and consequences credible rather than strawmen?

## Consistency

- Do metadata status, body language, current recommendation, and final outcome agree?
- Do acceptance criteria match their parent requirements?
- Does the proposal satisfy rather than contradict the PRD?
- Do linked ADR outcomes match the design incorporated into the proposal?
- Are normative terms used consistently: **must** for requirements, **should** for recommendations, **may** for permitted behavior?

## Clarity and Brevity

- Does each section answer its intended question?
- Can generic filler, repetition, or history be removed without losing meaning?
- Are overloaded terms defined and used consistently?
- Are open questions collected explicitly rather than hidden as question marks in design bullets?
- Are summaries written after and consistent with the body?

## Document Hygiene

- Remove template prompts and accidental placeholders.
- Mark intentional TBDs with an owner and resolution condition or date.
- Verify links and use durable destinations.
- Give every diagram alt text or a textual explanation of its components, flow, and conclusion.
- Avoid relying on inaccessible attachments or ephemeral image URLs.
- Ensure examples cannot be mistaken for normative definitions.

## Type-Specific Gates

### PRD

- Observable behavior is testable.
- Use cases identify actor, preconditions, main flow, and acceptance criteria.
- Requirements include negative and recovery behavior where material.
- Exact schemas and implementation plumbing appear only when they define externally required behavior.

### Feature Proposal

- Requirements are traceable.
- Architecture and data/control flow are understandable.
- Compatibility and migration are explicit.
- Significant choices link to ADRs or explain why no ADR is needed.
- Testing covers affected layers and failure paths.

### ADR

- Scope is one bounded decision.
- Drivers are prioritized enough to explain the choice.
- Options are viable and fairly compared.
- Outcome names the chosen option and consequences.
- Proposed ADRs use recommendation language; accepted ADRs use decision language.

## Review Result

Classify findings as:

1. **Blocking:** prevents a sound decision or contains a material contradiction/error.
2. **Important:** likely to confuse implementation, testing, operation, or future readers.
3. **Polish:** improves clarity without changing the decision.

State what was not verified. Never infer readiness solely from template completeness.
