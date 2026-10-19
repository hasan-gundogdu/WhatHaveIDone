# WHID Core v0.2 Evaluation Guide

This directory defines the release evaluation. It must contain no private
source, report output, credentials, or disposable worktree content.

## Required environments

- a clean Codex session
- a clean Claude Code session
- a repository fixture with recorded commits and known expected behavior
- an isolated disposable worktree for working-tree cases
- isolated Git fixtures for saved-Onboard state and write-boundary cases
- the same WHID revision installed in both agents

Use a public fixture or a private repository the evaluator is authorized to
inspect. Never commit private fixture content or WHID report output here.
Saved Onboard runs only in disposable fixtures/worktrees, never a live checkout.

## Method

For each case and each supported agent:

1. Choose and record fixture revisions that satisfy the case prerequisites.
2. Start a clean session without WHID and run the baseline prompt.
3. Save the baseline outside version control.
4. Start another clean session with WHID installed.
5. Run the explicit WHID invocation against the same repository state.
6. Confirm Git status and relevant object identities before and after the run.
7. Score both reports with [the rubric](RUBRIC.md).
8. Record host, model, WHID version, fixture revision, invocation, evidence
   gaps, hard-gate result, and evaluator notes outside this repository.

Do not treat cross-agent stylistic differences as a failure when both reports
satisfy the same behavioral contract.

For saved Onboard, record source/output hashes, manifest snapshots, expected
invalidations, actual chapter reuse, and elapsed time. Start refresh/resume in a
fresh agent session using the saved state so conversation history cannot hide
an incomplete manifest.

## Cases

- [Working tree Quick](cases/working-tree.md)
- [Single commit Quick](cases/single-commit.md)
- [Historical Deep](cases/historical-deep.md)
- [Revision range](cases/revision-range.md)
- [Untracked file](cases/untracked-file.md)
- [Architecture-sensitive Deep](cases/architecture-sensitive.md)
- [Invalid scope](cases/invalid-scope.md)
- [Repository selection](cases/repository-selection.md)
- [Onboard learning route](cases/onboard.md)
- [Onboard refresh and resume](cases/onboard-state.md)

These define acceptance scenarios, not completed evaluation evidence. Static
validation alone does not certify semantic or cross-agent resume behavior.

## Failure policy

Any scope or historical hard-gate failure blocks that run. Tighten the relevant
instruction using the observed failure, then repeat the exact scenario. Do not
add hypothetical rules.

If the same failure is reproducible a second time in the same supported agent,
stop the release and open a separate design effort for a deterministic helper
limited to Git scope inventory. It must not perform semantic analysis or report
generation.

Onboard ownership, freshness, and false-completion failures also block release.
Repair and repeat the exact transition. Repeated failures require revisiting
the state design, not masking them through full regeneration or a renderer.

## Release decision

Create `v0.2.0` only when:

- `skills-ref validate skills/whid` and `npm run validate` pass
- documented installation, update, and removal flows have been exercised
- every case passes every hard gate in Codex and Claude Code
- Quick and Deep meet their noise budgets
- Onboard teaches a coherent route and passes refresh/resume/content-protection cases
- an unfamiliar developer can trace an operation and locate a small change
- the report materially improves developer understanding and ownership
