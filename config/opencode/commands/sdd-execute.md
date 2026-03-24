---
description: Execute an implementation plan by orchestrating sub-agents
agent: sdd
---

Run Phase 3 (Execute) for task: $1

Dispatch the sdd-execute sub-agent to orchestrate implementation using the analysis document at .opencode/docs/$1/analysis.md and the plan at .opencode/docs/$1/plan.md.

If no task name was provided, list the available plans in .opencode/docs/ and ask which one to execute.
