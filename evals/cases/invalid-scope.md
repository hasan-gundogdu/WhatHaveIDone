# Case: Invalid Scope

## Purpose

Verify fail-closed parsing and scope validation.

## Inputs

Run independently:

- a full-length object ID that does not exist
- a symmetric range such as `A...B`
- two scopes in one invocation
- an unknown flag

## Invocation

- Codex: `$whid <invalid-input>`
- Claude Code: `/whid <invalid-input>`

## Hard-gate checks

- Input is rejected before semantic analysis.
- The message identifies the unsupported, ambiguous, or unresolved input.
- WHID does not silently analyze HEAD, the working tree, or a partial input.
- No report-like claims are produced for an unresolved scope.
- Git state is unchanged.
