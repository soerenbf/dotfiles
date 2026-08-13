# Document Lifecycle and Boundaries

## Relationship

```text
PRD                           Feature proposal                     ADR
required behavior      ->     reviewable technical design   ->    bounded decision record
what and why                  how and impact                       choice and rationale
                                      │
                                      └── Security issue proposal
                                          issue, scope, remediation
```

The flow is iterative, not a mandatory sequence. A proposal can reveal missing requirements; an ADR can precede, accompany, or revise a proposal. Not every feature needs every document.

## Selection Rules

Choose a **PRD** when readers need to agree on the problem, actors, observable behavior, priorities, acceptance criteria, safety properties, and scope. It is a behavioral contract, not an implementation plan.

Choose a **feature proposal** when reviewers need to evaluate a concrete system design, its alternatives, affected components, compatibility, migration, risks, documentation, and testing. At Concordium this fills the role commonly called an RFC.

Choose a **security issue proposal** when an internal audience needs to agree on whether a security issue exists, its root cause and affected scope, the security requirements for remediation, and a concrete solution. It is a specialized feature proposal, not a public advisory, incident report, or vulnerability disclosure. Use the general feature proposal instead when the security concern is only one part of a broader design.

Choose an **ADR** when a single consequential and durable technical choice deserves an independently discoverable rationale. An ADR should remain useful after its parent proposal becomes historical.

## Boundary Tests

- If changing the implementation would not change required behavior, the detail normally belongs in the feature proposal rather than the PRD.
- If the document covers an end-to-end feature rather than one choice, it is normally a feature proposal rather than an ADR.
- If the primary review questions are “is this exploitable?”, “what is affected?”, and “does this fix cover the issue?”, use a security issue proposal.
- If an option comparison is independently consequential, hard to reverse, or likely to be questioned later, extract an ADR and link it from the proposal.
- Do not duplicate full sections across documents. Link and summarize only the context needed for local comprehension.

## Traceability

Record links in both directions where practical:

- PRD: related proposal and ADRs when they exist.
- Feature proposal: originating requirements and related ADRs.
- ADR: parent proposal, affected requirement or design area, and decision forum.

Name the specific requirement, section, or decision being linked; a bare URL is weak traceability.

## Lifecycle Language

Suggested states:

- PRD, feature proposal, and security issue proposal: Draft, Proposed/In Review, Accepted, Rejected, Superseded.
- ADR: Not started, Proposed, Accepted, Rejected, Deprecated or Superseded.

Metadata, recommendations, and outcomes must agree. While review is open, say “current recommendation” rather than “it was decided.” Once accepted, replace “no final decision” language and record the actual consequences.

Separate temporary accommodations from the intended long-term decision. Give each a status, rationale, and removal condition.
