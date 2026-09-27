# WHID Core v0.1 Evaluation Guide

This directory defines the release evaluation. It must contain no private
source, report output, credentials, or disposable worktree content.

## Required environments

- a clean Codex session
- a clean Claude Code session
- a repository fixture with recorded commits and known expected behavior
- an isolated disposable worktree for working-tree cases
- the same WHID revision installed in both agents

Use a public fixture or a private repository the evaluator is authorized to
inspect. Never commit private fixture content or WHID report output here.

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

## Cases

- [Working tree Quick](cases/working-tree.md)
- [Single commit Quick](cases/single-commit.md)
- [Historical Deep](cases/historical-deep.md)
- [Revision range](cases/revision-range.md)
- [Untracked file](cases/untracked-file.md)
- [Architecture-sensitive Deep](cases/architecture-sensitive.md)
- [Invalid scope](cases/invalid-scope.md)

## Failure policy

Any scope or historical hard-gate failure blocks that run. Tighten the relevant
instruction using the observed failure, then repeat the exact scenario. Do not
add hypothetical rules.

If the same failure is reproducible a second time in the same supported agent,
stop the release and open a separate design effort for a deterministic helper
limited to Git scope inventory. It must not perform semantic analysis or report
generation.

## Release decision

Create `v0.1.0` only when:

- `skills-ref validate skills/whid` and `npm run validate` pass
- documented installation, update, and removal flows have been exercised
- every case passes every hard gate in Codex and Claude Code
- Quick and Deep meet their noise budgets
- the report materially improves developer understanding and ownership
