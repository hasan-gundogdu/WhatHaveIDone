# WhatHaveIDone Core v0.2 Design

## Purpose

WHID restores developer understanding of a repository change or a current
project. The canonical implementation is the Agent Skill at `skills/whid/`;
product documents explain the contract but do not override the installed skill
at runtime.

## Boundary

Core v0.2 contains portable instructions and references only. It does not
contain host-specific metadata, hooks, allowed-tool declarations, MCP servers,
custom installers, report assets, or a WHID-owned service. In particular,
`agents/openai.yaml` and Claude-specific metadata are distribution concerns,
not Core requirements.

Codex and Claude Code are validation targets, not forks. Both consume the same
`SKILL.md` and reference files. A future host adapter may expose discovery or
marketplace metadata, but it must point to the canonical Core rather than copy
its behavior.

## Runtime contract

WHID is explicitly activated. Normal coding, review, commit, or refactoring
requests must not trigger it or cause an unsolicited WHID suggestion.

All modes accept one optional `--repo <name-or-path>` selector. Quick/Deep
also accept `--repos <repo1,repo2,...>` or `--all` for working-tree analysis
of the explicitly selected workspace repositories. Repository selectors are
mutually exclusive. `--all` works with one discovered repository. Quick/Deep
accept one optional Git scope plus one optional `--deep` flag. Quick
is the default. Onboard accepts `--onboard` and an optional `--save <directory>`;
it rejects scopes and `--deep`, and `--save` is invalid in change-analysis modes.
Duplicate/unknown flags, ambiguous repository selection, and missing values
fail before analysis or writes.

Reports use the user's language and default to chat. Quick/Deep remain read-only
and may be saved only outside the repository. An explicit saved-Onboard request
authorizes managed report files in that directory, inside or outside the repo.
No mode mutates Git state. Tests/setup require a separate request.

## Change-analysis flow

```text
explicit request
  → parse mode and scope
  → resolve the exact selected set of repositories within the authorized workspace
  → validate Git scope without mutation
  → establish Before and After
  → discover only relevant repository context
  → group file changes into logical changes
  → trace behavior, architecture, and impact
  → build an internal evidence ledger
  → render Quick or Deep in the user's language
```

Every stage has an observable completion condition:

1. Parsing ends with exactly one supported Git scope, one mode, and at most
   one repository selector. Repository resolution selects exactly the requested roots or
   stops with an actionable ambiguity/error.
2. Scope resolution ends with explicit Before/After states and a complete
   changed-path inventory, including relevant untracked files.
3. Discovery ends when enough context exists to explain the highest-impact
   logical changes; it does not imply reading the whole repository.
4. Analysis ends when important claims have evidence labels and limitations.
5. Delivery ends with a non-mutating report and an explicit test-execution
   statement.

## Repository selection

- `--repo` is an independent repository selector, not a Git revision scope;
  it is valid for Quick, Deep, and Onboard. A unique directory basename from
  discoverable workspace repositories or an explicit workspace-root-relative
  directory path can identify a repository.
- Only when no repository selector is supplied, use an unambiguous host active
  repo. If the active repo is unknown and multiple roots are plausible, ask
  rather than silently choosing.
- Limit discovery to the authorized workspace and repositories explicitly
  provided by the user. Reject out-of-workspace paths, duplicate name matches,
  nonexistent or non-root paths, bare repositories, and unsupported multi-repo
  selectors. Anchor subsequent Git and filesystem reads to the resolved root.
- All reports identify the selected repository. Onboard `--save` relative paths
  resolve from that repo root. Nested Git repositories are not traversed.
- Multi-repo Quick/Deep opt in with `--repos` (two or more distinct, resolvable
  entries) or `--all` (all discovered authorized workspace Git roots, including
  a singleton). Do not infer undiscovered repositories from the filesystem.
  Reject `--all` only for an empty or ambiguous discovery set, not a singleton.
  Both selectors reject Git revision scopes and Onboard; cross-repository
  historical and onboarding flows are deferred.
- For each repository independently inventory HEAD → working tree; anchor
  read-only Git and inspection to that root. Synthesize architectural and
  integration effects only with evidence across two or more selected roots:
  distinguish provider contract, consumer expectation, and unverified deployment
  compatibility. Mark unconfirmed links `INFERRED` or `UNKNOWN`; do not interpret
  independent Git histories as one timeline. Attribute claims, limits, unchanged
  repositories, and test execution to their roots. Never silently omit a target.

## Scope model

- No scope means `HEAD` → working tree, including staged, unstaged, and
  relevant untracked files.
- `HEAD` or another commit-ish means first parent → target.
- A root commit means empty tree → target.
- A merge commit uses first parent and discloses that choice.
- `A..B` means tree at A → tree at B. Commit messages are intent context, not
  the report's organizing structure.
- `A...B`, multiple scopes, and unresolved refs fail without fallback.

Historical analysis never checks out a revision. Current operational
instructions remain safety constraints; revision-local documentation is
historical architecture evidence only.

## Onboarding flow and persistent state

```text
explicit Onboard request
  → resolve current working-tree scope and documentation map
  → validate destination and reconcile saved state, when requested
  → present ordered learning route with prerequisites
  → trace real operations and draft chapters in reading order
  → verify evidence and checkpoint each completed chapter
  → verify freshness, navigation, coverage, and completion
```

The canonical runtime contracts are [Onboard Report](../../skills/whid/references/onboard-report.md)
and [Onboarding State](../../skills/whid/references/onboarding-state.md). They define
the chapter content and manifest schema; do not maintain a second schema here.

The design chooses Markdown chapters plus a small JSON progress/verification
manifest over a new renderer or indexing service. A chapter is both a teaching
unit and a unit of reuse. Prerequisites preserve narrative order and propagate
staleness. Source fingerprints, watched module paths, and global inputs determine
what needs revisiting; generated prose cannot validate itself.

Source inventory includes eligible untracked and dirty files, excludes report
output, and is rechecked before claiming freshness. Unassigned changed paths
require triage, so adding a module cannot evade refresh merely because old
chapters never cited it. Reuse avoids repeated semantic reading but still incurs
filesystem I/O. Broad changes can invalidate the full route.

Saving is an explicit v0.2 exception to v0.1's repository-wide read-only rule.
It is limited to owned report files in the requested directory. Output hashes
protect manual edits; checkpoints and integrity checks make interruptions visible.
A torn checkpoint may require resolving a preserved file conflict rather than
silently regenerating the directory. There is no claim of multi-file atomicity.

## Safety and privacy

WHID does not change source, existing project documentation outside the requested
Onboard directory, or Git state. Quick/Deep saved files remain external. Saved
Onboard may create/update only managed output in its explicitly requested directory,
with path containment and existing-content checks. WHID does not read ignored
content, generated/vendor output, binaries, `.env` files, credentials, secret
candidates, or private keys without explicit permission. Untracked files are
triaged by path, type, and size before content is considered. A saved Onboard
destination may be read even if ignored; this does not authorize ignored source
reads. Symlinks and other repositories are not implicitly traversed.

Core uses the host's existing repository access and requires no WHID-owned
server. Cloud history, API sync, dashboards, billing, and HTML rendering are
outside v0.2. Local saved Markdown onboarding guides are included.

## Evidence model

Evidence strength (`CONFIRMED`, `INFERRED`, `UNKNOWN`) is independent of impact
reach (`DIRECT`, `INDIRECT`, `POTENTIAL`). Architecture assessments may use
`CONSISTENT`, `QUESTIONABLE`, `VIOLATION`, or `UNKNOWN`; `VIOLATION` requires
strong repository evidence.

The internal evidence ledger is an analysis discipline, not a required public
schema. Quick cites evidence near claims without a large appendix. Deep binds
important claims to a compact evidence appendix. Onboard binds them to chapter
evidence lists; its manifest tracks progress/freshness and is not an evidence ledger.
