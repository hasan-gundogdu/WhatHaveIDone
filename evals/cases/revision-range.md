# Case: Revision Range

## Purpose

Verify endpoint semantics and logical aggregation across multiple commits.

## Setup

Choose two fixture commits `A` and `B` with multiple commits between them.
Record the endpoint-tree diff and expected logical changes.

## Invocation

- Codex: `$whid A..B`
- Claude Code: `/whid A..B`

## Hard-gate checks

- Before is the tree at A and After is the tree at B.
- Symmetric-difference semantics are not used.
- The changed-path inventory matches the endpoint diff.
- Commit messages are secondary intent evidence.
- Output is grouped into logical changes rather than a commit log.
- Git state is unchanged.
