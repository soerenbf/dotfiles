---
name: org-tech-docs
description: Create or review Concordium technical documents, including product requirements documents (PRDs), technical feature proposals and RFCs, architecture decision records (ADRs), decision docs, and technical designs. Use this skill whenever the user asks to draft, refine, structure, assess, or review one of these documents, even if they only say “proposal,” “requirements,” or “decision record.”
---

# Organization Technical Documents

Create documents that let their intended readers understand required behavior, review a technical design, or recover the rationale for a decision. Ground claims in available evidence and adapt depth to the product area; do not assume every document concerns protocol architecture.

This workflow is adapted from Anthropic's [`doc-coauthoring`](https://github.com/anthropics/skills/blob/main/skills/doc-coauthoring/SKILL.md) skill. It retains context gathering, iterative refinement, and reader testing while making the process proportional, harness-neutral, and suitable for document review.

## Select the Document Type

Read [references/document-lifecycle.md](references/document-lifecycle.md) when the requested type is unclear or related documents may be needed.

| Reader need | Document | Primary question |
| --- | --- | --- |
| Agree on observable behavior and scope | PRD | What must the product do, and why? |
| Review a technical design before committing | Feature proposal / RFC | How should the feature be built? |
| Preserve one consequential technical choice | ADR | What did we decide, and why? |

A technical feature proposal is Concordium's equivalent of an RFC. Do not introduce RFC as a separate document unless the user's local convention distinguishes it.

Load only the relevant guidance and template:

- PRD: [references/prd.md](references/prd.md) and [assets/prd-template.md](assets/prd-template.md)
- Feature proposal: [references/feature-proposal.md](references/feature-proposal.md) and [assets/feature-proposal-template.md](assets/feature-proposal-template.md)
- ADR: [references/adr.md](references/adr.md) and [assets/adr-template.md](assets/adr-template.md)

If the user supplies an organizational template, use it instead of the asset while retaining applicable guidance and quality checks. Templates are defaults: omit irrelevant sections and add domain-specific sections only when they help reviewers. Read [references/examples.md](references/examples.md) when examples would clarify document boundaries, lifecycle language, or traceability.

## Choose a Mode

- **Create or refine:** Follow the co-authoring workflow below.
- **Review:** Read [references/quality-checklist.md](references/quality-checklist.md), inspect source material as needed, and report evidence-backed findings before suggested edits. Do not rewrite unless asked.
- **Freeform:** If the user declines the structured workflow or wants to skip a stage, comply and retain the relevant grounding and quality checks.

## Ground the Document

Before drafting, retrieve the smallest useful source set:

- user-provided notes, templates, and existing drafts;
- linked PRDs, feature proposals, ADRs, meeting decisions, and work items;
- relevant repository code, schemas, tests, and local guidance;
- connected Confluence, Jira, or other organizational sources when authorized.

Distinguish explicitly between:

- verified current behavior;
- stated requirements;
- proposed design;
- accepted decisions;
- assumptions and open questions.

Never invent organizational facts or silently resolve material uncertainty. Ask targeted questions or mark the uncertainty. Verify sensitive technical claims against primary sources where practical.

## Co-Authoring Workflow

### 1. Gather Context

Establish:

1. document type and lifecycle state;
2. primary audience and desired decision or action;
3. applicable template and destination;
4. related documents and sources of truth;
5. scope, constraints, deadlines, stakeholders, and known disagreements.

Invite the user to provide shorthand, an unstructured context dump, links, or source locations. Read accessible sources before asking questions they already answer. Then ask only the highest-value unanswered questions; scale the count to complexity.

Context is sufficient when you can discuss edge cases and trade-offs without needing the basic problem re-explained. Confirm material assumptions before drafting.

### 2. Structure and Refine

Propose a structure from the selected guidance or use the supplied template. Start with the section carrying the greatest uncertainty; write summaries last.

For each substantial section:

1. clarify its purpose and missing facts;
2. brainstorm options only when exploration adds value;
3. let the user keep, remove, or combine ideas;
4. draft into the target document;
5. apply surgical edits from feedback;
6. check what can be removed without losing necessary meaning.

Scale the process. A bounded ADR may be drafted in one pass; a large PRD may be refined use case by use case. Do not force repetitive brainstorming or questions after the answer is clear.

Near completion, reread the entire document for flow, duplication, contradictions, generic filler, terminology drift, and links between requirements, design, and decisions. Apply [references/quality-checklist.md](references/quality-checklist.md).

When editing a file, make targeted changes rather than repeatedly replacing the entire document. Preserve the author's meaning and local voice.

### 3. Test With a Context-Isolated Reader

Test whether the document works without hidden conversational context:

1. Predict 5–10 realistic questions the intended audience will ask.
2. Give a fresh subagent or model only the document and those questions when available.
3. Ask it to identify ambiguity, assumed knowledge, contradictions, and unsupported conclusions.
4. Compare its answers with the intended meaning.
5. Fix gaps and repeat until no material new issue appears.

If no isolated reviewer is available, provide the questions and a short manual test prompt for the user. Do not claim independent reader testing occurred when it did not.

## Review Output

For review requests, order findings by impact. For each finding include:

- location or section;
- issue;
- why it matters to the intended reader or decision;
- a concrete correction.

Separate blocking issues, important improvements, and optional polish. End with unresolved questions and a brief readiness assessment. If no material issue exists, say so and identify any verification not performed.

## Final Responsibility

Before declaring a document ready:

- confirm facts, links, status, and decision language;
- ensure diagrams have durable textual explanations;
- remove stale prompts and placeholders or mark intentional TBDs with owners;
- remind the user that the document owner and reviewers remain responsible for correctness and approval.
