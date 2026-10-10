# Case: Onboard Learning Route

## Purpose

Verify that Onboard teaches the current project through ordered, evidence-backed
chapters and adapts to repository type. A list of files or an outline alone fails.

## Setup

Use a disposable representative project with a traceable operation, domain rules,
tests, and README/architecture documents. Introduce one documented behavior that
differs from implementation and one relevant untracked source file. Record both
as evaluator ground truth. Also run on a small library/CLI or instruction-only
repository so the agent cannot rely on an assumed web-service template.

## Baseline prompt

```text
Help a developer joining this project understand it end to end. First give an
ordered learning outline, then teach the domain, system boundaries, a real
operation, important decisions, and how to make a small change. Use evidence,
brief contextual reminders, and practice questions. Do not execute tests/setup.
```

## WHID invocations

- `$whid --onboard` / `/whid --onboard` for chat-only delivery.
- `$whid --onboard --save docs/whid/onboarding` and the corresponding `/whid`
  invocation for saved delivery, in separate identical disposable fixtures.

## Hard-gate checks

- The outline precedes chapters; the agent continues through the route rather
  than stopping for unrequested outline approval.
- The scope is the current on-disk project, including relevant local/untracked
  work, not HEAD's diff. The guide discloses its coverage and exclusions.
- Concepts precede their use. Chapters connect purpose, boundaries, execution,
  decisions, and developer practice in prerequisite order.
- A real operation is traced through concrete symbols and local boundaries;
  external/inaccessible parts are explicitly limited.
- The planted documentation discrepancy is disclosed. Intent is distinguished
  from behavior, and missing rationale is not invented.
- Architecture claims use wiring and behavior evidence, not package presence.
- The guide contains chapter-specific reminders and exercises with evidence
  pointers. A reader can explain where a plausible small change belongs.
- Core version, source provenance, and test/setup execution status are accurate.
- Chat-only writes nothing. Saved output is limited to the requested directory,
  with an index, chapter files, valid manifest, and consistent navigation.
- No source, Git state, existing docs index, or ignore configuration is changed.
- A completed index/manifest corresponds to actual finished chapters; a limit
  preventing completion produces an honestly partial guide.

## Reader check

Ask a developer unfamiliar with the fixture to follow one operation from input
to output, explain one rule, and locate the likely files for a small change.
Record what they can answer from the guide and what still requires rediscovery.
Do not equate a polished report with a passing reader check.
