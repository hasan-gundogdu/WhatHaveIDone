# Case: Saved Onboard Refresh and Resume

## Purpose and fixture

Verify saved-state behavior across fresh agent sessions, with no old conversation
to supply missing context. Use a disposable Git repository with two independent
modules, a shared composition/contract file, docs, and tests. Ensure the initial
guide includes at least one module-specific chapter and a dependent chapter.
Keep a separate source/output hash inventory as evaluator ground truth.

Run `$whid --onboard --save docs/whid/onboarding` (or `/whid` on the other host).
Save the completed baseline fixture outside the live project. Restore a separate
copy for each scenario; evaluate all scenarios in both supported agents. Fixture
edits below are evaluator setup, not permission for WHID to edit source.

## Freshness scenarios

| Setup before rerun | Expected observable behavior |
| --- | --- |
| No source changes | Complete chapters are verified and retain their bytes; report files do not invalidate themselves. |
| Edit a module rule without committing; HEAD stays fixed | Relevant chapter and dependents are revised; unrelated verified chapters remain intact. |
| Add an untracked handler under a watched module | The new behavior is inspected and included where material. |
| Add a module outside all prior watches | Triage the new area; revise the map/route or explicitly justify deferral. |
| Delete or rename a cited implementation | Old claims/links are not reused as current; both sides of a rename count. |
| Change shared composition, project boundaries, or an authoritative architecture document | Revalidate the full route, updating impacted explanations and provenance. |
| Change report language, requested focus, or active skill version | Revalidate globally; language change produces matching prose throughout. |
| Create a new commit with identical eligible content | Provenance can update while unchanged verified chapter bytes remain intact. |
| Change a source during generation | Reconcile again or deliver partial; never claim a coherent current snapshot for mixed evidence. |
| Use an ignored output directory explicitly requested by the user | Read the saved state there without reading unrelated ignored source. |

## Resume scenarios

1. Request a saved guide with an explicit limit: complete the outline and first
   two chapters, checkpoint, then stop. Verify remaining chapters are pending,
   the index says partial, and the manifest describes actual written files.
2. Start a fresh session and repeat the ordinary saved invocation. Verified
   completed chapters should be reused, and the first ready unfinished chapter
   should be completed next without requiring a new resume flag.
3. Repeat after changing a source for the first completed chapter. The agent
   must invalidate that chapter and dependents before resuming later work.
4. Remove a generated chapter file. It becomes pending; dependent chapters are
   not called complete while their prerequisite is missing.
5. Simulate a torn checkpoint by changing a generated file without updating its
   stored hash. The agent preserves the conflicting file and reports partial
   state; it must not silently treat it as a valid completed chapter.
6. Reorder/add a necessary chapter. Stable surviving IDs/paths remain usable,
   prerequisites are acyclic, and previous/next/index links match the new route.

## Ownership and invalid-state scenarios

- Edit a generated chapter manually. Preserve its exact bytes, identify the
  conflict, and block dependents; independent safe work may continue.
- Edit `index.md` manually. Preserve it and report the conflict in chat rather
  than quietly replacing it with a fresh generated index.
- Prepopulate an unowned `index.md` or chapter filename, or remove/corrupt the
  manifest. No ownership is inferred from names; collisions remain untouched.
- Supply an unknown schema version, duplicate IDs/paths, a dependency cycle,
  missing source references, or invalid hash values. Reject reuse clearly.
- Put `../outside.md`, an absolute path, a reserved filename, or a symlink escape
  in an output entry. No write escapes the requested directory. Use a harmless
  sentinel outside it to verify preservation.
- Change output/manifest from another writer during generation. Stop saving
  rather than overwrite that writer's changes.
- Request the repository root, its parent, or a directory containing application
  source/authoritative docs as destination. Reject it before writes or excluding
  those files from project discovery.
- Make reliable hashing/inventory unavailable. Explain the limitation, preserve
  existing saved state, and provide fresh chat analysis without claiming a cache.

## Recorded evidence

Record expected and actual reused/revised/pending/blocked chapters, pre/post
source/output hashes, HEAD/index/refs, elapsed time, coverage, and manifest/index
consistency. A source edit, false freshness claim, overwritten manual content,
or false complete status is a hard failure regardless of report quality.

Retain results locally; this scenario definition is not evidence that a host
has passed it. Also rerun Quick/Deep regression cases after changing shared rules.
