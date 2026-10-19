# Explicit repository selection

## Fixture
Prepare an authorized workspace containing:
- `service-api/` and `service-auth/` as separate Git working-tree roots with distinguishable changes;
- a second nested directory named `service-api` within another discoverable workspace location (for duplicate-name testing);
- a normal directory that is not a repository and a nested directory inside a Git repository;
- an out-of-workspace repository that must not be read.

Run each case in clean Codex and Claude Code sessions with the same WHID revision. Snapshot the Git status and file hashes for each repository before and after.

## Scenarios and hard gates

1. **Unique explicit name:** `whid --repo service-auth` analyzes only that repository's staged, unstaged, and eligible untracked changes, and identifies its root in the report.
2. **Path selection:** `whid --repo <workspace-relative-repository-root> HEAD` resolves that root and performs first-parent commit analysis there; the Git scope must not be confused with the repository argument.
3. **Deep:** `whid --repo service-auth HEAD~2..HEAD --deep` resolves the revision range only inside service-auth and returns the Deep report.
4. **Onboard:** `whid --repo service-auth --onboard` inspects only service-auth. With `--save docs/whid/onboarding`, the destination is rooted in service-auth and only authorized report files are written.
5. **No selector, active repo:** When the host exposes one unambiguous active repository, `whid` preserves existing behavior for that repository.
6. **No selector, ambiguous workspace:** With no unambiguous active repo, `whid` stops and asks which one to analyze without reading source contents.
7. **Duplicate basename:** A non-unique `--repo service-api` fails before content analysis; a sufficiently precise explicit path can disambiguate it.
8. **Invalid paths:** Nonexistent, non-root, inaccessible, bare, and out-of-workspace repository selections fail without fallback, source reads, or writes.
9. **Selector compatibility:** `--repo service-auth --all`, `--repo service-auth --repos service-auth,service-api`, or `--repo` without a value fail before source reads; `--repos` and `--all` alone are supported for Quick/Deep under the dedicated [multi-repository cases](multi-repo.md).
10. **Safety:** Neither nested repositories nor submodules are traversed implicitly; Quick/Deep and chat-only Onboard do not mutate any Git or source state.

Record resolved root, host workspace interpretation, chosen Git scope, pre/post state, and any observed ambiguity. The same behavioral acceptance criteria apply to both agents. These are scenarios, **not** evidence that cross-agent evaluation has passed.
