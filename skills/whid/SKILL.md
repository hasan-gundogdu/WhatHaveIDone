---
name: whid
description: Explain repository changes or build an ordered developer onboarding guide. Use only for explicit WHID invocations, WHID onboarding requests, or ownership recaps of what the user changed. Do not activate for ordinary coding, explanation, review, commit, or refactoring work.
license: Apache-2.0
compatibility: Requires Git and repository inspection capabilities. Saved onboarding additionally requires filesystem writes and SHA-256 hashing in the host environment.
metadata:
  author: hasan-gundogdu
  version: "0.2.0-alpha.2"
---

# WhatHaveIDone

Restore developer understanding of a change or a project. Explain behavior
before files and distinguish evidence from inference. Quick and Deep analyze
changes without modifying the repository. Onboard teaches the current project;
only an explicitly requested saved guide may write to its report directory.

## Activation boundary

Run only after an explicit WHID invocation, an explicit WHID onboarding request,
or an explicit request to explain what the user changed. Do not run automatically,
offer a WHID report, or append one after normal coding, review, commit, or
refactoring work.

Accept these canonical forms:

```text
whid
whid HEAD
whid <commit-ish>
whid A..B
whid --deep
whid <scope> --deep
whid --repo <name-or-path> [<scope>] [--deep]
whid --repos <repo1,repo2,...> [--deep]
whid --all [--deep]
whid --onboard
whid --onboard --save <directory>
whid --repo <name-or-path> --onboard [--save <directory>]
```

Treat flag order as flexible. Repository selectors are mutually exclusive:
`--repo <name-or-path>` for exactly one repository, `--repos <repo1,repo2,...>`
for two or more, or `--all` for all discovered workspace repositories (one
repository is valid). Quick/Deep accept at most one Git scope and one `--deep`
flag, but `--repos` and `--all` accept only working-tree scope (no Git
revisions). Onboard accepts at most one `--repo`, one `--onboard` flag, and
optionally one `--save` with a nonempty directory argument (quote paths
containing spaces). It accepts
neither a Git scope nor `--deep`. `--save` is Onboard-only. Reject duplicate or
unknown flags, missing arguments, `A...B`, multiple scopes, and unresolved
revisions or repositories with a clear error before analysis or writes. Never substitute a mode
or scope after validation fails.

Quick is the default. Use Deep only when `--deep` is present or the user
explicitly requests a deep change analysis. Use Onboard only when `--onboard`
is present or the user explicitly requests WHID project onboarding. An explicit
natural-language request to save that guide to a directory is equivalent to
`--save`. Repeating the saved invocation refreshes or resumes it automatically;
there is no separate resume flag. Write the report in the user's language;
preserve identifiers and evidence labels as written in this skill.

Directly below every report title, write
`WHID Core version: <metadata.version>`. Copy the value exactly from this
file's frontmatter. Do not infer it from a Git tag, package file, host, or
repository being analyzed.

## Load the applicable guidance

- For every run, read [the evidence model](references/evidence-model.md).
- For Quick, read [the Quick report contract](references/quick-report.md).
- For Deep, read [the Deep report contract](references/deep-report.md).
- For Onboard, read [the Onboard report contract](references/onboard-report.md).
- For saved Onboard only, also read
  [the onboarding state contract](references/onboarding-state.md).
- For a commit, merge commit, root commit, or revision range, also read
  [historical analysis](references/historical-analysis.md).

These references are terminal: do not look for additional instruction files
inside them.

## Resolve the repository (all modes)

Resolve the target repository set *before* inspecting source content, resolving
Git revisions, or writing an Onboard guide. `--repo` selects one repository and
is not a commit scope. `--repos` and `--all` explicitly select multiple
repositories when present; `--all` may select just one. No selector ever
changes Git state.

- Discover only repositories exposed by the host's current workspace or
  explicitly supplied in the user request; do not recursively crawl arbitrary
  parent directories, sibling directories, or the user's filesystem.
- Only when **none** of `--repo`, `--repos`, or `--all` is supplied, use the
  host's unambiguous active repository, if there is one. If multiple roots are
  plausible and no active repository is established, stop and ask which to
  use. Never choose the first discovered or silently analyze a workspace
  container.
- With `--repo`, accept an exact unique repository directory basename among
  discoverable workspace repositories, or an explicit directory path. Paths
  resolve from the host's workspace root when available, otherwise from the
  host's working directory. An explicit path must designate an accessible Git
  working-tree root in the authorized workspace, not merely a nested directory
  inside a different repo. Reject missing or duplicate name matches, paths
  outside the authorized workspace, bare repos, and ambiguous workspace roots;
  list safe candidate repository names/paths when possible.
- Confirm the selected root using read-only Git inspection; Git operations and
  source discovery thereafter must be anchored to that root, never the host's
  incidental working directory. Do not enter other Git repositories, including
  nested repositories or submodules, during analysis.
- Show the resolved repository identity/path in every report alongside the
  analysis scope. For saved Onboard, resolve a relative `--save` directory from
  the *selected repository root*; validate the destination and output ownership
  there under the existing Onboard state rules.
- For `--repos`, split its single argument on commas, trim entries, and require
  two or more distinct repository roots after resolving each entry under the
  single-repository safety rules. Reject empty items, duplicate roots, name
  collisions, inaccessible paths, or any unresolved entry; never silently
  omit failed targets. Quoted paths with spaces are accepted; commas within
  repository names/paths are not supported.
- For `--all`, enumerate the finite set of repositories exposed by the current
  authorized workspace, without recursively exploring arbitrary directories.
  Require at least one; a single discovered repo is analyzed normally, without
  invented cross-repo findings. If workspace boundaries or the discovered set
  are ambiguous, fail rather than claiming complete coverage. Explicitly state
  every selected root before source inspection.
- Multi-repository selection supports Quick and Deep working-tree analysis only.
  Reject `--onboard`, `--save`, commit scopes, and revision ranges in multi-repo
  invocations before reading content or writing anything. Each selected repo has
  its own HEAD and staged, unstaged, relevant untracked inventory; never compare
  commit IDs or file paths between repositories as if they share a Git history.
- Analyze each selected repository independently using the existing Quick/Deep
  evidence discipline. For two or more selected roots, synthesize only evidenced
  cross-repository effects: inspect actual provider contracts and consumer
  expectations, callers, dependencies, configurations, or integrations. Show
  which changed behavior connects them and what remains unverified. Mark
  unverified links `INFERRED` or `UNKNOWN`. Local source compatibility is not
  proof of deployment compatibility; do not invent runtime connections from
  matching names. Attribute sources and effects to their repositories.
- Bound analysis to selected roots; do not traverse unselected repositories,
  nested Git repos, or submodules. Provide one coherent report with repository
  identities, per-repo scope/limits, prioritized logical changes, cross-repo
  findings (when evidenced), and tests-execution status for each repository.
  Explicitly list selected repositories with no relevant changes. When two or
  more roots are selected but no cross-repo relationship is evidenced, say so.

## Route the work

For `--repos`/`--all` Quick/Deep, inventory each selected repository under the
rules above, then follow the Quick/Deep contract with repository-attributed
evidence. Synthesize cross-repository effects only for two or more roots.
For Onboard, follow the Onboard contract, then the shared Tests and delivery
rules below. Its scope is the current working-tree project, not a Before/After
diff. Do not apply the change-analysis pipeline to it. For Quick/Deep, follow
the remaining scope and change-analysis sections.

For every mode, inspect candidate paths by name, type, and size before content.
Do not read ignored files, binaries, generated/vendor output, `.env` files,
credential or secret candidates, or private keys without explicit permission.
Do not follow symlinks or traverse submodules/other repositories implicitly;
record these as scope limits. Saved Onboard may read its explicitly requested
report directory even if ignored; that exception does not admit ignored source.

## Resolve the change scope

Use the repository root already selected above and confirm Git can resolve the requested scope.
Use read-only Git inspection. Do not checkout, switch, reset, restore, stash,
clean, add, commit, or write repository files.

### No scope: working tree

Use `HEAD` as Before and the complete working tree as After. Inventory all of:

- staged changes
- unstaged changes
- untracked paths

Inspect untracked paths by name, type, and size before content. Include relevant
source, configuration, test, migration, and documentation files. Do not read
ignored files, binaries, generated/vendor output, `.env` files, credential or
secret candidates, or private keys without explicit user permission.

Do not collapse staged and unstaged state in a way that loses either change.
The final logical analysis may combine them when they implement the same
behavior.

### `HEAD` or another commit-ish

Resolve the input to exactly one commit. Compare its first parent with the
target. For a root commit, compare the empty tree with the target. For a merge
commit, use the first parent and disclose that boundary in the report.

### `A..B`

Resolve both endpoints to commits and compare the tree at A with the tree at B.
Read commit messages in `A..B` only as possible intent evidence. Do not organize
the report as a commit-by-commit dump.

Scope resolution is complete only when Before, After, comparison semantics, and
the changed-path inventory are explicit. If they cannot be established, stop
and explain the unresolved input.

## Keep operational and historical instructions separate

Current repository/agent instructions govern safe operation. When analyzing a
historical scope, use architecture documents and project structure from the
target revision as evidence about that time. Never treat a current file as if it
existed in the historical revision. Do not checkout to inspect old content.

## Analyze the change

Follow this sequence:

1. Parse the explicit request, mode, repository selection, and Git scope.
2. Resolve the exact set of selected repositories and validate each Git scope
   without mutation.
3. Establish Before and After from the correct repository states.
4. Identify changed symbols and observable behaviors.
5. Group related files and symbols into logical changes.
6. Rank business behavior, security, public contracts, data/schema,
   persistence, transactions, concurrency, integrations, errors, state
   transitions, and architecture boundaries above formatting or naming noise.
7. Expand only as needed through callers, callees, interfaces,
   implementations, composition, persistence, and tests.
8. Build an internal evidence ledger for every important claim.
9. Render the applicable Quick or Deep report contract.

Do not infer architecture from package presence alone. Prefer explicit
instructions, dependency/project references, interfaces and implementations,
runtime composition, and actual call or event paths.

Discovery is complete when there is enough evidence to explain the highest
impact logical changes and material limitations. Do not read the entire
repository by default.

## Tests

Inspect relevant tests as behavior evidence. Do not run tests unless the user
also explicitly asks to run them. Never say “there are no tests” based on
limited discovery; say “no related test was found in the explored context.”
State whether tests were run in every report.

## Deliver safely

For Quick/Deep, return the report in chat by default. Save it only when the user
explicitly requests an exact destination outside the analyzed repository. If the
requested path is inside that repository, explain the read-only boundary and ask
for an external destination instead.

For Onboard, return an ordered Markdown guide in chat unless a save directory
was explicitly requested. That request authorizes creating and updating only
the generated guide files and manifest within that directory, inside or outside
the repository. Follow the state contract to protect existing content. Never
stage, commit, change refs, edit source/configuration, or update existing project
documentation outside that directory. A saved destination grants no authority
to run tests or setup commands.

Before finishing Quick/Deep, verify:

- all selected repositories and per-repository scopes in the report match
  their validated identities
- logical changes lead and file lists support them
- important claims carry the correct evidence strength
- impact reach is not confused with evidence strength
- historical claims use revision-correct evidence
- tests are described accurately and execution status is explicit
- every material claim in a Deep report maps to a compact evidence appendix
- a Deep report that identifies at least three distinct behaviors, tradeoffs,
  risks, or test gaps includes 3–5 change-specific understanding questions;
  one broad open question does not satisfy this check
- empty or low-value sections were omitted
- no repository or Git state was changed

Before finishing Onboard, verify the report contract's completion checks and,
when saved, the state contract's freshness, checkpoint, and write-boundary checks.
