# Technical Feature Proposals

## Purpose

A feature proposal is a reviewable technical design for an end-to-end feature. It is equivalent to an RFC in common engineering terminology. It translates product requirements into architecture, interfaces, component changes, compatibility behavior, migration, and verification plans.

## Audience and Outcome

Primary readers include architects, implementing engineers, security and operations reviewers, QA, SDK and application owners, and other affected teams. They should leave able to decide whether the design is sound, feasible, compatible, operable, and sufficiently specified to implement.

## Expected Content

Use [../assets/feature-proposal-template.md](../assets/feature-proposal-template.md) proportionately.

### Summary, Context, and Requirements

Summarize the proposal after drafting the body. Link the originating PRD or requirements and state goals, non-goals, constraints, and design drivers. Do not duplicate the PRD.

### Technical Design

Explain system context, major components, state, operations, interfaces, data and control flow, authorization, failure semantics, and observability. Use diagrams when relationships or sequences are hard to explain in prose, and accompany every diagram with a durable textual explanation.

Add domain-specific detail only when needed. Protocol proposals may require state-machine rules, serialization, signature domains, chain migration, SDK propagation, wallet behavior, and explorer/indexer impact. Backend or application proposals may require API contracts, storage, deployment, privacy, and service-level behavior instead.

### Alternatives and ADRs

Explain meaningful design alternatives at the feature level. Extract a separate ADR when a choice is consequential, independently discoverable, difficult to reverse, or likely to be revisited. Link the ADR and incorporate its outcome; do not maintain two conflicting option analyses.

### Compatibility and Migration

Separate backward compatibility, forward compatibility, compile-time impact, runtime impact, data migration, rollout, rollback, and mixed-version behavior where relevant. Name affected consumers rather than saying only “the ecosystem.”

### Delivery Concerns

Identify component ownership and dependencies without turning the proposal into a task tracker. Specify documentation changes and a layered test strategy including negative paths, regression, integration, and end-to-end coverage where material.

## Writing Rules

- Label present behavior, proposed behavior, accepted ADR outcomes, and open questions distinctly.
- Keep normative terms consistent with linked requirements.
- Define serialization and schemas precisely only when they are part of compatibility or interoperability.
- Give open questions owners and resolution conditions. Do not hide uncertainty as question marks in bullets.
- State assumptions whose invalidation would change the design.
- Explain why omitted concerns are irrelevant when reviewers would reasonably expect them.

## Common Failure Modes

- **Architecture overview without decisions:** state concrete proposed behavior and trade-offs.
- **Component list without flow:** show how state and control move through components.
- **Compatibility asserted, not analyzed:** identify old producers/consumers and mixed versions.
- **Open design presented as final:** separate recommendation from accepted decision.
- **Overloaded proposal:** extract bounded architectural choices into ADRs.
- **Template residue:** remove prompts, empty headings, comments to named reviewers, and stale questions before review.
