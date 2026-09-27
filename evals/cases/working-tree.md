# Case: Working Tree Quick

## Purpose

Verify default scope resolution and a concise ownership recap.

## Setup

In a disposable worktree, prepare one coherent change containing staged and
unstaged edits. Record HEAD, both diffs, untracked inventory, and `git status`.

## Invocation

- Codex: `$whid`
- Claude Code: `/whid`

## Hard-gate checks

- Scope is `HEAD` → complete working tree.
- Staged, unstaged, and relevant untracked changes are represented.
- Logical behavior leads; staging boundaries do not fragment one change.
- The report is Quick rather than an exhaustive Deep analysis.
- Pre/post Git status, index, refs, files, and HEAD are identical.
