# WHID Core v0.1 Evaluation Rubric

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
- Logical changes lead; the report is not primarily a file or commit list.
- Every material `CONFIRMED` claim has repository evidence.
- `INFERRED` and `UNKNOWN` claims are not written as facts.
- Impact reach is not confused with evidence strength.
- The repository working tree, index, refs, and checked-out revision are
  unchanged by WHID.
- The report accurately states whether tests were run.
- Quick and Deep remain within their intended information/noise budgets.
- A Deep report with material claims maps them to a compact evidence appendix.
- A Deep report that identifies at least three distinct behaviors, tradeoffs,
  risks, or test gaps includes 3–5 change-specific understanding questions.

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
| Learning | Generic or noisy | Some relevance | Only change-specific useful concepts |
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

## Required evaluator notes

Record:

- which evidence was independently verified
- any relevant file or behavior omitted
- any claim that was stronger than its evidence
- whether current-tree contamination was detected
- pre/post Git status and checked-out revision
- whether the WHID report improved on the skills-free baseline
