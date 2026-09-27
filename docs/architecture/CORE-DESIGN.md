# WhatHaveIDone Core v0.1 Design

## Purpose

WHID restores developer understanding of a repository change. The canonical
implementation is the Agent Skill at `skills/whid/`; product documents explain
the contract but do not override the installed skill at runtime.

## Boundary

Core v0.1 contains portable instructions and references only. It does not
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

The input is one optional Git scope plus one optional `--deep` flag. Quick is
the default. The report is returned in the user's language in chat unless the
user explicitly requests a file outside the analyzed repository. The analysis
is read-only and tests are not run unless separately requested.

## Analysis flow

```text
explicit request
  → parse mode and scope
  → validate Git scope without mutation
  → establish Before and After
  → discover only relevant repository context
  → group file changes into logical changes
  → trace behavior, architecture, and impact
  → build an internal evidence ledger
  → render Quick or Deep in the user's language
```

Every stage has an observable completion condition:

1. Parsing ends with exactly one supported scope and one mode.
2. Scope resolution ends with explicit Before/After states and a complete
   changed-path inventory, including relevant untracked files.
3. Discovery ends when enough context exists to explain the highest-impact
   logical changes; it does not imply reading the whole repository.
4. Analysis ends when important claims have evidence labels and limitations.
5. Delivery ends with a non-mutating report and an explicit test-execution
   statement.

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

## Safety and privacy

WHID does not modify repository files or Git state. An explicitly requested
saved report must be written outside the analyzed repository. WHID does not read ignored
content, generated/vendor output, binaries, `.env` files, credentials, secret
candidates, or private keys without explicit permission. Untracked files are
triaged by path, type, and size before content is considered.

Core uses the host's existing repository access and requires no WHID-owned
server. Hosted services and persistent report storage are outside Core v0.1.

## Evidence model

Evidence strength (`CONFIRMED`, `INFERRED`, `UNKNOWN`) is independent of impact
reach (`DIRECT`, `INDIRECT`, `POTENTIAL`). Architecture assessments may use
`CONSISTENT`, `QUESTIONABLE`, `VIOLATION`, or `UNKNOWN`; `VIOLATION` requires
strong repository evidence.

The internal evidence ledger is an analysis discipline, not a required public
schema. Quick cites evidence near claims without a large appendix. Deep binds
important claims to a compact evidence appendix.
