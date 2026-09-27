# ADR 0002: Validate Instruction-Only Git Scope Handling First

- Status: Accepted
- Date: 2026-09-27

## Context

Git scope correctness is a hard requirement. Working-tree analysis must include
relevant untracked files, and historical analysis must not leak present-day
repository state into past revisions. A deterministic helper could make scope
inventory repeatable, but it would add portability and maintenance cost before
there is evidence that instructions are insufficient.

## Decision

Implement v0.1 as an instruction-only skill. Validate it with fixed scenarios,
the same scopes in Codex and Claude Code, and a skills-free baseline.

If the same scope or historical hard-gate failure is reproducible twice in the
same supported agent, stop the release and design a deterministic helper that
only inventories Git scope. Such a helper must not perform semantic analysis
or render reports.

## Consequences

- v0.1 remains portable and easy to inspect.
- Evaluation evidence, rather than speculation, determines whether code is
  introduced.
- A single hard-gate failure triggers instruction tightening and a rerun.
- A repeated failure blocks release instead of being hidden by report polish.
