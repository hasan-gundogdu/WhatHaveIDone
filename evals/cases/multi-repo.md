# Multi-repository Quick/Deep

## Fixture
In an authorized multi-root workspace, prepare two independent Git roots `auth/` and `api/`, each with distinct HEAD, staged, unstaged and eligible untracked changes. Include one observable API/token contract referenced by both repos, one unrelated change, and a third `ui/` root that must be excluded from `--repos auth,api`. Create ambiguous duplicate basenames, a missing path and an out-of-workspace path for negative cases. Record pre/post Git status and file hashes.

## Acceptance scenarios (Codex and Claude Code)

1. `whid --repos auth,api`: analyses both roots' complete working-tree changes and omits `ui`. Identifies each root, its HEAD boundary, meaningful changes, and test execution status.
2. `whid --repos auth,api --deep`: uses Deep evidence strength/reach and questions, attributing every significant claim to the correct repo.
3. `whid --all`: covers all and only discovered Git roots in the authorized workspace; fails if the complete discovered set cannot be established.
4. Prove a changed shared authentication contract across `auth` and `api` using actual repository evidence; separately verify unrelated changes are not invented as linked.
5. Never treat commit hashes in independent repositories as one shared timeline; cross-repo relationship claims distinguish CONFIRMED, INFERRED and UNKNOWN.
6. `--repos auth,missing`, duplicate roots, ambiguous names, empty items, and unsupported comma-containing repository names fail before source reads, without partial analysis.
7. `--repos auth,api HEAD`, `--all A..B`, `--repos auth,api --onboard`, and multiple selector flags fail before writes or analysis.
8. `--all` with only one discoverable repository succeeds as a single-repo working-tree analysis without cross-repo assertions; `--all` with zero discovered repositories and `--repos auth` with one entry fail clearly.
9. Repositories outside the authorized workspace, nested repositories, and submodules are never traversed implicitly; Git state remains unchanged in all selected and unselected repos.
10. Verify no tested source or private data is copied into evaluation artifacts. Note any evidenced limits and undiscovered repos explicitly.

These scenarios are acceptance criteria, not completed semantic/cross-agent certification.
