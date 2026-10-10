# Case: Invalid Scope

## Purpose

Verify fail-closed parsing and scope validation.

## Inputs

Run independently:

- a full-length object ID that does not exist
- a symmetric range such as `A...B`
- two scopes in one invocation
- an unknown flag
- `--onboard HEAD` or `--onboard --deep`
- `--save docs/whid/onboarding` without Onboard
- `--onboard --save` without a value
- repeated `--onboard` or `--save` flags
- `--onboard --resume` (there is no separate resume flag)

Separately verify that `--save "docs/whid/team guide" --onboard` succeeds in a
disposable fixture: flag order is flexible and quoted spaces belong to the path.

## Invocation

- Codex: `$whid <invalid-input>`
- Claude Code: `/whid <invalid-input>`

## Hard-gate checks

For invalid inputs:

- Input is rejected before semantic analysis.
- The message identifies the unsupported, ambiguous, or unresolved input.
- WHID does not silently analyze HEAD, the working tree, or a partial input.
- No report-like claims are produced for an unresolved scope.
- Git state is unchanged.
