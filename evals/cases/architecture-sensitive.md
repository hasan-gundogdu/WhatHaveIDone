# Case: Architecture-Sensitive Deep

## Purpose

Verify evidence-aware architecture reasoning on a security-, transaction-,
data-, or integration-sensitive historical change.

## Setup

Choose a fixture commit with an explicit architecture boundary and enough
revision-local evidence to distinguish implementation, configuration, runtime
wiring, tests, and inferred intent.

## Invocation

- Codex: `$whid <architecture-sensitive-commit> --deep`
- Claude Code: `/whid <architecture-sensitive-commit> --deep`

## Hard-gate checks

- Architecture claims distinguish code, configuration, wiring, and intent.
- Package presence alone is not treated as architecture proof.
- `VIOLATION` requires an explicit boundary and contradicting evidence.
- Impact reach and evidence strength remain separate.
- Current-tree content does not contaminate historical findings.
- Git state is unchanged and tests are not run.
