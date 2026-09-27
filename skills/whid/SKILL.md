---
name: whid
description: Analyze repository changes to restore developer understanding and code ownership. Use only when the user explicitly invokes WHID, requests a WHID Quick or Deep analysis, or explicitly asks for an ownership recap of what they changed. Do not activate for ordinary coding, explanation, review, commit, or refactoring work.
license: Apache-2.0
compatibility: Requires Git and a coding agent with read access to the repository and shell or equivalent Git inspection capabilities.
metadata:
  author: hasan-gundogdu
  version: "0.1.0-alpha.2"
---

# WhatHaveIDone

Restore the user's ownership of a change. Explain behavior before files, group
the diff into logical changes, and distinguish evidence from inference. Never
modify the repository while performing a WHID analysis.

## Activation boundary

Run only after an explicit WHID invocation or an explicit request to explain
what the user changed. Do not run automatically, offer a WHID report, or append
one after normal coding, review, commit, or refactoring work.

Accept these canonical forms:

```text
whid
whid HEAD
whid <commit-ish>
whid A..B
whid --deep
whid <scope> --deep
```

Treat flag order as flexible. Accept at most one scope and one `--deep` flag.
Reject `A...B`, multiple scopes, unknown flags, and unresolved revisions with a
clear error. Never substitute another scope after validation fails.

Quick is the default. Use Deep only when `--deep` is present or the user
explicitly requests a deep analysis. Write the report in the user's language;
preserve identifiers and evidence labels as written in this skill.

Directly below every report title, write
`WHID Core version: <metadata.version>`. Copy the value exactly from this
file's frontmatter. Do not infer it from a Git tag, package file, host, or
repository being analyzed.

## Load the applicable guidance

- For every run, read [the evidence model](references/evidence-model.md).
- For Quick, read [the Quick report contract](references/quick-report.md).
- For Deep, read [the Deep report contract](references/deep-report.md).
- For a commit, merge commit, root commit, or revision range, also read
  [historical analysis](references/historical-analysis.md).

These references are terminal: do not look for additional instruction files
inside them.

## Resolve the scope

First confirm the repository root and that Git can resolve the requested scope.
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

1. Parse the explicit request, mode, and scope.
2. Resolve and validate the Git scope without mutation.
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

Return the report in chat by default. Save it only when the user explicitly
requests an exact destination outside the analyzed repository. If the requested
path is inside that repository, explain the read-only boundary and ask for an
external destination instead. WHID never writes to the analyzed repository.

Before finishing, verify:

- the scope in the report matches the validated scope
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
