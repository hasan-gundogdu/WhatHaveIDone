# Case: Historical Deep

## Purpose

Detect present-day context leaking into a historical explanation and verify the
Deep contract.

## Setup

Choose a historical fixture commit whose target revision contains enough
behavior, architecture, tests, and risks for a Deep report. Record its parent
and the revision-local evidence expected in the report.

## Invocation

- Codex: `$whid <historical-commit> --deep`
- Claude Code: `/whid <historical-commit> --deep`

## Hard-gate checks

- Before and After use the correct parent and target trees.
- Every cited historical path exists in its claimed revision.
- Current architecture documents are not presented as historical facts.
- Before → After describes behavior rather than a textual diff.
- Material claims map to a compact evidence appendix.
- A sufficiently rich change produces 3–5 contextual questions.
- Git state is unchanged and tests are not run.
