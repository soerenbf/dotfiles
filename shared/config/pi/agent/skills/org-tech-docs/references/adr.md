# Architecture Decision Records

## Purpose

An ADR preserves the context, drivers, alternatives, outcome, and consequences of one consequential architectural decision. It is a durable memory aid, not a miniature feature proposal or a meeting transcript.

## When an ADR Is Warranted

Create an ADR when a choice is one or more of:

- difficult or costly to reverse;
- externally visible or compatibility-sensitive;
- security-, reliability-, or operability-critical;
- shared across components or teams;
- likely to be questioned or revisited later;
- one of several viable options whose trade-offs are not obvious.

Avoid an ADR for routine implementation details, easily reversible local choices, or decisions already explained durably in an accepted proposal when independent discovery has no value.

## Scope

Phrase the decision as one question. Provide only enough parent-feature context to understand that question. If the options require separate architectures or the outcome defines the entire feature, write or revise a feature proposal instead.

Use [../assets/adr-template.md](../assets/adr-template.md) proportionately.

## Lifecycle

- **Proposed:** options and current recommendation are open for review. Use “current assessment” and “recommended option.”
- **Accepted:** identify the chosen option, decision makers/date, consequences, and any temporary accommodation separately.
- **Rejected:** preserve why no option or proposal was accepted.
- **Deprecated/Superseded:** retain the historical record and link the replacement.

Never combine `Accepted` metadata with “no final decision yet,” or `Proposed` metadata with unqualified “it was decided.”

## Option Analysis

For each viable option state:

- concrete representation or behavior;
- advantages relative to the drivers;
- disadvantages, risks, and operational consequences;
- compatibility and evolution implications when material.

Use the same evaluation dimensions across options. Do not include a knowingly invalid option merely to make the preferred choice look stronger.

## Outcome and Consequences

The outcome must name the selected option and explain why its advantages dominate for the stated drivers. Record positive, negative, and neutral consequences, including follow-up obligations. Distinguish:

- long-term decision;
- temporary implementation or migration accommodation;
- unresolved follow-up decision.

An accepted ADR records what was decided, not only the preferred assessment.

## Common Failure Modes

- **Decision too broad:** split it or move the end-to-end design to a feature proposal.
- **Decision already made in a proposed ADR:** change wording to recommendation or update status after approval.
- **Outcome without consequences:** explain the costs the organization knowingly accepts.
- **Options without drivers:** readers cannot reconstruct why one won.
- **Stale snapshot:** supersede rather than rewriting historical rationale after the architecture changes.
- **Bare references:** say what meeting, proposal, requirement, or earlier ADR each link supports.
