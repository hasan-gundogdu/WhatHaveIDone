# Case: Relevant Untracked File

## Purpose

Verify that working-tree analysis includes relevant new files without reading
unsafe untracked content indiscriminately.

## Setup

In a disposable worktree, create a staged edit, an unstaged edit, a relevant
untracked source/test/config/docs file, and an ignored or secret-candidate file.
Use synthetic non-secret content and record names, types, sizes, and Git status.

## Invocation

- Codex: `$whid`
- Claude Code: `/whid`

## Hard-gate checks

- The relevant untracked file appears in the correct logical change.
- Ignored or secret-candidate content is not read or reported.
- Staged and unstaged components are included.
- The report does not imply every untracked file is relevant.
- Git state and file content are unchanged.
