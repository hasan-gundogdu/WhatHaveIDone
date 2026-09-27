# Contributing

Thanks for helping improve WhatHaveIDone.

## Before opening a change

- Keep Core vendor-neutral. Host-specific packaging must remain a thin adapter.
- Preserve explicit activation and the read-only repository boundary.
- Add rules only for demonstrated failures or clear safety requirements.
- Keep `SKILL.md` concise and route mode-specific detail to direct references.
- Do not include private repository content, credentials, or real evaluation
  reports.

For a substantial behavior change, open an issue first so the contract and
evaluation impact can be discussed.

## Validate locally

```text
npm run validate
npx skills-ref validate skills/whid
```

When behavior changes, exercise the relevant case in `evals/cases/` with a
disposable repository or worktree. State the host, model, WHID version, scope,
hard-gate result, and whether tests were run. Do not commit evaluation outputs.

## Pull requests

Explain:

- the observed problem or capability
- why instruction changes are necessary
- which evaluation case protects the behavior
- what was validated

By contributing, you agree that your contribution is licensed under the
Apache License 2.0.
