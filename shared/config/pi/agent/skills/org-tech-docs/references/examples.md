# Synthetic Structural Examples

These examples are fictional and intentionally short. They demonstrate document boundaries, not Concordium system facts.

## One Topic Across Three Documents

### PRD: Observable Requirement

> **Requirement:** Before a protected resource expires, a caller must have native permission and receive policy approval. At or after expiry, any caller can initiate recovery without policy approval.
>
> **Acceptance criterion:** Given an unavailable policy service and an expired resource, when any account requests recovery, then recovery succeeds and the resource cannot remain permanently locked.

The PRD defines required safety and recovery behavior. It does not choose how policy approval is encoded or invoked.

### Feature Proposal: End-to-End Design

> Add an optional policy-controller reference to protected-resource state. The runtime performs native authorization first, invokes the controller for pre-expiry operations, and commits controller effects atomically with the operation. Expiry recovery bypasses approval. The API, SDK, indexer, and operator documentation gain additive fields; mixed-version readers reject unknown encoded variants explicitly.

The proposal explains architecture, ordering, atomicity, affected components, and compatibility. It should link ADRs for independently significant choices.

### ADR: Bounded Choice

> **Question:** How should unrestricted recipients be represented?
>
> **Drivers:** unambiguous serialization, validation simplicity, and future evolution.
>
> **Options:** a dedicated `any` variant; field omission; a reserved item inside a recipient list.
>
> **Decision:** Use a dedicated variant. It is more explicit and prevents absence or an empty list from acquiring surprising semantics, at the cost of an additional schema variant.

The ADR records one choice and its rationale rather than reproducing the resource design.

## Good Status Language

**Proposed:**

> No final decision has been made. The current recommendation is Option 2 because it best preserves compatibility; reviewers should challenge the migration assumptions before acceptance.

**Accepted:**

> On 2027-01-15, the architecture group accepted Option 2. Existing clients retain their current invariant, while new clients must support the explicit empty-token variant. This adds validation complexity described below.

## Explicit Temporary Accommodation

> **Long-term decision:** encode unrestricted recipients as a dedicated variant.
>
> **Temporary accommodation:** the first development network uses a reserved sentinel because the schema migration is not yet available. Remove the sentinel before production activation; owner: Runtime Team.

This avoids presenting temporary implementation behavior as the architecture itself.

## Weak and Strong Traceability

Weak:

> Product requirements: <link>

Strong:

> Satisfies PRD UC 4, AC 2 (“recovery remains available when the controller fails”): <link to section>.

The latter tells a reviewer why the source matters and which claim to verify.
