# [Security Issue Proposal] <Issue>

| Field | Value |
| --- | --- |
| Status | Draft |
| Owner | <owner> |
| Reviewers | <reviewers> |
| Last updated | <date> |

## Issue Summary

<In one or two short paragraphs, explain the vulnerable behavior, how an attacker or untrusted input can trigger it, the practical security consequence, and the broad affected area if known. Keep uncertainty visible. Do not include the solution.>

## Analysis

<Explain only what reviewers need to evaluate the issue: the expected security property, how current behavior violates it, attacker prerequisites, root cause, and demonstrated or inferred impact.>

### Reachability Graph

<Show the attacker-controlled trust-boundary input as the root, the messages or operations that expose the vulnerable behavior as branches, and the vulnerable type or operation as the leaves. Use a containment tree for nested messages or deserialization paths. Classify referenced nodes using the fixed legend below. Resolve every marker after the graph with the exact code symbol and a direct link to the relevant file or lines; do not leave markers supported only by prose or an unlinked path. Reuse a marker when paths converge on the same code. Mark uncertain paths in words. Omit the graph only when there is one direct, obvious path.>

**Legend:** `E` = attacker control or externally reachable entry point; `P` = processing step needed to trace reachability; `V` = vulnerable check or operation.

```text
<attacker-controlled input> [E1]
├─ <entry point or message> [E2]
│  └─ <nested processing path> [P1]
│     └─ <vulnerable type or operation> [V1]
└─ <entry point or message> [E3]
   └─ <alternate processing path> [P2]
      └─ <vulnerable type or operation> [V1]
```

- **[E1]** `<symbol>` — [`<file:lines>`](<direct code URL>)
- **[E2]** `<symbol>` — [`<file:lines>`](<direct code URL>)
- **[E3]** `<symbol>` — [`<file:lines>`](<direct code URL>)
- **[P1]** `<symbol>` — [`<file:lines>`](<direct code URL>)
- **[P2]** `<symbol>` — [`<file:lines>`](<direct code URL>)
- **[V1]** `<symbol>` — [`<file:lines>`](<direct code URL>)

## Scope

| Area | Assessment | Rationale and evidence |
| --- | --- | --- |
| <component, path, version, or configuration> | Affected / Unaffected / Unknown | <why> |

## Proposed Solution

<Describe the security requirements and current implementation recommendation together. Explain where enforcement occurs, why it covers all affected paths, and any material trade-off or residual risk. Use recommendation language until accepted.>

## Alternatives

<Include only meaningful alternatives needed for the decision and briefly explain why they are not recommended. Omit this section if none exist.>

## Verification

<Concise evidence plan covering the demonstrated attack, alternate affected paths, relevant boundaries, and preservation of valid behavior. State material gaps.>

## Open Questions

- <Only questions that can change the issue assessment, scope, or solution; include an owner or resolution condition when useful.>

## Decision

<Once reviewed, record the accepted issue assessment, scope, solution, and rationale. Omit while no decision exists if status already makes that clear.>

## References

- <code, test, experiment, report, or related design>
