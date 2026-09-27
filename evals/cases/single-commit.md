# Case: Single Commit Quick

## Purpose

Verify a normal historical commit boundary and concise logical analysis.

## Setup

Choose a non-root, non-merge fixture commit with known behavioral changes and
record its parent, changed paths, and expected behavior.

## Invocation

- Codex: `$whid <fixture-commit>`
- Claude Code: `/whid <fixture-commit>`

## Hard-gate checks

- Before is the commit's parent and After is the target commit.
- Current working-tree changes are excluded.
- Commit messages may inform intent but do not organize the report.
- Confirmed behavior uses revision-correct evidence.
- Tests are inspected as evidence but not run.
- Git state is unchanged.
