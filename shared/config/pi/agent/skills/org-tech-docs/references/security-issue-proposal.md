# Security Issue Proposals

## Purpose

A security issue proposal is an internal, reviewable technical document used to agree on:

1. what security property the current system violates;
2. whether and how an attacker can reach the vulnerable behavior;
3. which components, configurations, and versions are affected;
4. what a complete remediation must guarantee; and
5. which technical solution should be adopted.

It is a specialized feature proposal. It is not a public advisory, incident report, disclosure timeline, implementation task list, or upgrade notice. Do not optimize its language for publication or add GHSA fields unless reviewers need them for the decision.

## Audience and Outcome

Primary readers are engineers responsible for the affected system and relevant security, architecture, operations, and testing reviewers. They should leave able to accept, reject, or narrow the issue assessment and proposed remediation.

Optimize for rapid review. Write the shortest document that supports the decision; for a bounded issue, prefer a few compact sections over a comprehensive security report. Put the conclusion of each section first, link supporting evidence instead of reproducing it, and avoid repeating the issue, impact, or scope in multiple forms. Add subsections only when they make a genuinely complex issue easier to navigate.

While review remains open, distinguish the **current recommendation** from accepted decisions. Once accepted, record the agreed issue scope, solution, rationale, and remaining follow-up explicitly.

## Collaborative Authoring

Start from the smallest useful evidence set: the report or observation, implicated code and tests, relevant design documents, supported releases, and experiments already performed. Respect the document's intended access boundary and do not copy exploit material or sensitive operational details into broader systems without the user's direction.

Begin with a short **issue summary** that gives reviewers an immediate working understanding of the vulnerable behavior, how it can be reached, and its practical security consequence. Draft it early from the available evidence and refine it as the assessment changes. It does not need to state a solution or final conclusion.

Then work through uncertainty in this order:

1. **Issue summary:** Establish a concise shared understanding before introducing the underlying security model.
2. **Security property:** State the invariant or trust boundary that should hold.
3. **Current behavior:** Trace attacker-controlled data or actions to the violating behavior.
4. **Reachability graph:** Map every known attacker-controlled entry point through nested structures and shared boundaries to the vulnerable operation.
5. **Impact:** Separate reproduced effects from evidence-backed inference and speculation.
6. **Scope:** Identify affected, unaffected, and unknown paths, versions, configurations, and deployments.
7. **Remediation requirements:** Define properties any acceptable solution must establish before selecting an implementation.
8. **Solution:** Evaluate the current recommendation against those requirements and meaningful alternatives.
9. **Verification:** Define the evidence needed to show both exploit prevention and absence of material regressions.

Ask targeted questions where evidence is missing. Do not silently decide disputed exploitability, impact, scope, or risk acceptance. Use diagrams when they clarify trust boundaries or reachability, and accompany them with a textual explanation.

A useful issue summary normally answers, in one or two short paragraphs:

- What does the affected system currently do?
- What attacker capability or untrusted input triggers the behavior?
- What concrete security consequence can result?
- What broad area appears affected, if already known?

Keep uncertainty visible with concise qualifiers rather than delaying the summary until every detail is settled. Do not overload it with root-cause mechanics, exhaustive scope, severity scoring, or remediation design; later sections carry that detail.

## Default Document Shape

Use [the template](../assets/security-issue-proposal-template.md) proportionately. The default document has:

1. an issue summary;
2. one compact analysis section;
3. a scope table;
4. the proposed solution;
5. verification and unresolved questions; and
6. a decision once one exists.

Alternatives and references are supporting sections, not mandatory ceremony. Omit irrelevant sections, empty headings, repeated background, exhaustive call-path inventories, and implementation detail that does not affect issue scope or solution acceptance. Put long traces, experiments, payloads, and test output in linked evidence when reviewers can verify them there.

## Evidence and Claim Language

Label material claims as needed:

- **Verified:** established by code, tests, supported-version inspection, or a reproducible experiment.
- **Inferred:** follows from identified behavior but has not been reproduced end to end.
- **Assumption:** treated as true for the proposal and capable of changing its conclusion.
- **Unknown:** requires investigation before the issue or design can be accepted.
- **Proposed:** future behavior or the current remediation recommendation.
- **Accepted:** explicitly approved behavior or decision.

Link code, tests, versions, and related documents precisely enough for reviewers to verify the claim. Avoid treating the absence of a known exploit as evidence that a path is safe.

## Reachability Graph

Include a compact reachability graph by default when more than one entry point exists or the path is not obvious. Its purpose is to let another engineer verify path coverage against the code without reconstructing the analysis from prose.

For nested messages, wire objects, ASTs, or deserialization paths, prefer an ASCII containment tree:

Use this fixed marker legend so readers can scan node roles without interpreting ad hoc notation:

- `E` — attacker control or externally reachable entry point;
- `P` — processing step needed to trace reachability from an entry point to vulnerable behavior;
- `V` — vulnerable check or operation.

```text
<attacker-controlled trust-boundary input> [E1]
├─ <message or operation> [E2]
│  └─ <nested processing path> [P1]
│     └─ <vulnerable type or operation> [V1]
└─ <message or operation> [E3]
   └─ <alternate processing path> [P2]
      └─ <vulnerable type or operation> [V1]
```

Resolve every marker immediately below the graph with both an exact code symbol and a direct link to the relevant file or lines:

```markdown
- **[E1]** `<symbol>` — [`<file:lines>`](<direct code URL>)
- **[E2]** `<symbol>` — [`<file:lines>`](<direct code URL>)
- **[E3]** `<symbol>` — [`<file:lines>`](<direct code URL>)
- **[P1]** `<symbol>` — [`<file:lines>`](<direct code URL>)
- **[P2]** `<symbol>` — [`<file:lines>`](<direct code URL>)
- **[V1]** `<symbol>` — [`<file:lines>`](<direct code URL>)
```

The graph should:

- use the attacker-controlled trust-boundary input as its root;
- show externally reachable messages or operations as the main branches;
- preserve enough nested structure for reviewers to trace each path in code;
- terminate each complete path at the vulnerable type or operation;
- collapse paths only when doing so does not hide verification-relevant structure;
- classify verification-relevant nodes with the fixed `E` (entry), `P` (processing path), and `V` (vulnerable operation) markers and include the legend before the graph;
- do not invent additional marker classes; describe trust boundaries, validation, uncertainty, and consequences in node labels or prose;
- resolve every marker to the exact symbol and a clickable file or line reference immediately below the graph; markers backed only by prose or an unlinked path are incomplete;
- reuse the same marker where multiple paths converge on the same implementation;
- prefer commit-pinned permalinks with line ranges so references remain durable; when the code host supports stable symbol links, use those instead; avoid branch-relative line links that will drift;
- reference branching points, trust boundaries, enforcement points, and the vulnerable operation rather than annotating every data-only wrapper;
- distinguish verified paths from suspected or unknown paths;
- show validation or authorization boundaries when they affect exploitability; and
- fit on one screen when possible, with detail delegated to linked evidence.

Do not put long paths or URLs directly inside tree nodes; reference markers preserve the visual shape while the list below provides direct code navigation. Use a general directed graph instead when reachability cannot be represented clearly as containment. Accompany either form with a brief textual explanation so its meaning remains durable and accessible. The scope table remains authoritative for affected, unaffected, and unknown assessments; the graph explains reachability.

## Scope Analysis

Scope is broader than the first reproducer. Consider:

- all entry points reaching the same vulnerable operation;
- alternate encodings, message types, APIs, and indirect callers;
- trust level and privileges required at each entry point;
- supported versions, branches, configurations, and feature flags;
- resource, protocol, or deployment limits that alter exploitability;
- components that appear similar but preserve the security property;
- unknowns whose resolution could expand or narrow the issue.

State why excluded paths are unaffected. “Not observed” is an unknown, not an exclusion rationale.

## Remediation Design

State remediation requirements independently of implementation. Requirements should describe security properties such as bounded resource use, validation before side effects, authorization at the trust boundary, complete path coverage, or preservation of protocol invariants.

Then explain:

- where and how the proposed solution enforces each requirement;
- why the enforcement point covers the vulnerability class rather than one payload;
- compatibility, performance, operational, and complexity consequences;
- residual risk and optional defense in depth;
- viable alternatives and why they are rejected or deferred.

Do not require an alternative merely to fill the template. Include alternatives when they expose a meaningful trade-off or help establish why the recommendation is complete.

## Verification

Match verification to the claims made. Relevant evidence may include:

- a regression test for the demonstrated attack path;
- tests for every identified alternate entry point;
- boundary and malformed-input tests;
- resource or complexity measurements;
- compatibility tests for valid existing behavior;
- static reasoning or invariant checks where end-to-end tests are impractical.

A test showing that one reproducer fails is not by itself evidence that all affected paths are fixed. State what remains unverified.

## Common Failure Modes

- **Template-shaped verbosity:** gives every concept its own heading, repeats the same claim across sections, or includes detail that cannot change the review decision.
- **Advisory-shaped summary:** describes impact but omits the evidence and decisions needed to agree on scope and remediation.
- **Fix-first reasoning:** presents a patch before defining the security property it must restore.
- **Unverifiable reachability:** lists entry points in prose without showing how they converge on the vulnerable operation or where the trust boundaries are.
- **Reproducer-sized scope:** analyzes only the reported path rather than the shared vulnerable behavior.
- **Possibility presented as impact:** treats a theoretical consequence as demonstrated fact.
- **Unjustified exclusion:** labels a component unaffected without explaining the relevant difference.
- **Validation without placement:** says “validate input” without specifying the bound, enforcement point, or failure behavior.
- **Premature decision language:** presents a recommendation as accepted while material questions remain open.
- **Disclosure leakage:** includes sensitive exploit or rollout details that the intended internal discussion does not require.
