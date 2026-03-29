---
name: interview
description: Structured approach for interviewing the user to resolve ambiguities, inconsistencies, and knowledge gaps
---

## Purpose

Guide the process of asking the user targeted questions to resolve ambiguities, inconsistencies between context sources, and fill knowledge gaps before producing deliverables.

## When to Use

Use this skill when you have gathered context and identified issues that require human input to resolve. This is typically used during the analysis phase but can also be used by the execution agent when proposing changes to the analysis document.

## Procedure

### 1. Categorize Issues

Before asking questions, organize findings into categories:

- **Inconsistencies**: Conflicting information between sources (highest priority)
- **Ambiguities**: Statements that could be interpreted multiple ways
- **Missing information**: Required details not found in any source
- **Assumptions**: Things you are assuming but have not verified
- **Scope clarifications**: Boundaries of the work that are unclear

### 2. Prioritize Questions

Order questions by impact on the deliverable:

1. Blocking inconsistencies (cannot proceed without resolution)
2. Scope-defining ambiguities (affects what gets built)
3. Technical unknowns (affects how it gets built)
4. Nice-to-know details (improves quality of deliverable)

### 3. Ask Questions Effectively

For each question:

- **State the context**: Briefly explain what you found and where (cite sources)
- **Explain why it matters**: How does this affect the analysis/plan/implementation?
- **Present options when possible**: If you can identify likely answers, present them as choices
- **Group related questions**: Batch questions that relate to the same topic

### 4. Format

Use the `question` tool when available to present structured choices. For open-ended questions, ask them directly in conversation text.

When using the `question` tool:
- Keep headers under 30 characters
- Provide 2-5 options with descriptions
- Enable `multiple: true` only when multiple selections genuinely make sense
- Let the custom answer option handle edge cases (do not add an "Other" option)

When asking in conversation:
- Use numbered lists for multiple questions
- Clearly separate each question with a blank line
- Bold the key conflict or gap being addressed

### 5. Process Answers

After receiving answers:

- Confirm your understanding by restating the answer in context
- Update your working knowledge immediately
- If an answer raises new questions, ask follow-up questions before proceeding
- Record the decision and rationale for inclusion in the deliverable

## Important Notes

- Never ask more than 5 questions at once — batch them and iterate
- Do not ask questions that can be answered by reading the sources more carefully
- If the user says "use your best judgment" for a question, document your decision and rationale
- Always give the user the opportunity to correct your interpretation of their answer
