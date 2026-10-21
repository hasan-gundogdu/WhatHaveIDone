# WhatHaveIDone Documentation

## Architecture

- [Core Design](architecture/CORE-DESIGN.md) — canonical skill boundary,
  runtime contract, scope model, and evidence discipline.
- [Distribution](architecture/DISTRIBUTION.md) — installation, support tiers,
  portability, validation, version policy, and free marketplace packaging/updates.
- [Package README](../packaging/README.md) — standalone usage shipped in plugin ZIPs.
- [Privacy](../PRIVACY.md) — repository access, host data handling, and saved reports.
- [Onboard Report](../skills/whid/references/onboard-report.md) — ordered learning
  route, chapter content, and completion criteria.
- [Onboarding State](../skills/whid/references/onboarding-state.md) — saved output,
  manifest schema, freshness, ownership, refresh, and resume.

## Decisions

- [ADR 0001: Agent Skills Core](decisions/0001-agent-skills-core.md) — one
  vendor-neutral canonical skill.
- [ADR 0002: Eval-First Git Strategy](decisions/0002-eval-first-git-strategy.md)
  — instruction-only scope handling with a measured helper fallback.

These ADRs record v0.1 decisions. Core v0.2 retains the instruction-only,
vendor-neutral approach and adds the scoped saved-Onboard exception described
in Core Design.

## Evaluation

- [Evaluation Guide](../evals/README.md) — reproducible cross-agent procedure.
- [Rubric](../evals/RUBRIC.md) — hard gates and report-quality criteria.
