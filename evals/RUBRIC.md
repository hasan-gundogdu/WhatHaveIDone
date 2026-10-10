# WHID Core v0.2 Evaluation Rubric

## Hard gates

A report fails if any applicable statement is false:

- The requested scope is resolved exactly and completely.
- The report shows the exact `metadata.version` from the active WHID
  `SKILL.md`, distinct from the analyzed repository revision.
- Staged, unstaged, and relevant untracked changes are included for a
  working-tree scope.
- Invalid or ambiguous input stops before analysis without silent fallback.
- Historical claims use files and architecture evidence from the correct
  revision rather than the current tree.
- Merge commits disclose first-parent comparison when applicable.
- Quick/Deep lead with logical changes; Onboard follows a connected learning
  route. No mode is primarily a file or commit list.
- Every material `CONFIRMED` claim has repository evidence.
- `INFERRED` and `UNKNOWN` claims are not written as facts.
- Impact reach is not confused with evidence strength.
- The index, refs, checked-out revision, and source are unchanged by WHID.
  Quick/Deep and chat-only Onboard leave the entire working tree unchanged.
  Saved Onboard writes only managed reports inside its requested directory.
- The report accurately states whether tests were run.
- Quick and Deep remain within their intended information/noise budgets.
- A Deep report with material claims maps them to a compact evidence appendix.
- A Deep report that identifies at least three distinct behaviors, tradeoffs,
  risks, or test gaps includes 3–5 change-specific understanding questions.
- Onboard states current on-disk scope, local changes, coverage, and exclusions;
  it traces a real operation and supports locating a small change.
- Saved Onboard validates the manifest and all output ownership/fingerprints
  before reuse. Dirty/new/deleted sources, globals, and chapter dependencies
  participate in freshness decisions; reports never act as their own evidence.
- Interrupted/stale/missing chapters are not labeled current and complete.
  Completion requires a consistent index/manifest and every active planned chapter.
- Output collisions, manual edits, invalid metadata, and path escapes do not
  silently overwrite user content or write outside the requested boundary.

## Quality dimensions

Score each from 0 to 2:

| Dimension | 0 | 1 | 2 |
| --- | --- | --- | --- |
| Outcome | Misses behavior | Partly explains behavior | Clear behavior-first result |
| Logical grouping | File dump | Mixed file/logical view | Coherent logical changes |
| Criticality | Diff-size driven | Mostly useful ranking | Semantic impact drives ranking |
| Architecture | Unsupported labels | Some evidence | Boundaries and evidence are precise |
| Impact | Vague blast radius | Some reasoned links | Reach, reason, and evidence are distinct |
| Tests | Inventory or absolutes | Partial behavior link | Explains protected behavior and limits |
| Learning | Generic or noisy | Some relevance | Useful concepts tied to the actual change/project |
| Verification | Hard to trace | Some references | Important claims are easy to verify |

No numeric total can compensate for a hard-gate failure. For a passing report,
use the scores to compare baseline and WHID and to identify focused instruction
tuning.

## Mode expectations

Quick should normally be readable in 3–5 minutes, emphasize roughly 3–5
critical points, and avoid a large evidence appendix.

Deep should add meaningful Before → After, execution flow when useful, a
logical-block walkthrough, behavior-oriented test analysis, 3–5 contextual
questions when the analysis supplies at least three non-redundant prompts, and
a compact evidence appendix for its material claims.

Onboard should present the outline first and then teach domain, boundaries, real
execution, decisions, and developer practice in prerequisite order. Contextual
reminders and exercises reinforce code understanding. The guide states core
coverage and deferred areas. A saved rerun reuses verified unchanged chapters
and revisits affected/dependent chapters; partial progress is clearly labeled.

For Onboard, score logical grouping as chapter coherence, criticality as selection
of important flows, and impact as explaining where a small change propagates.
Measure refresh by chapters reread/rewritten and observed duration, not a promised
token reduction. A large first run is acceptable; unsupported freshness is not.

## Required evaluator notes

Record:

- which evidence was independently verified
- any relevant file or behavior omitted
- any claim that was stronger than its evidence
- whether current-tree contamination was detected
- pre/post Git status and checked-out revision
- for saved Onboard: pre/post source and output hashes, expected vs actual stale
  chapters, preserved manual content, and manifest/index consistency
- whether the WHID report improved on the skills-free baseline
