# Deep Report Contract

Deep should teach the developer the change without becoming an exhaustive
repository tour.

Show the exact WHID Core version from `SKILL.md` frontmatter directly below the
report title. Keep it separate from the analyzed repository's revision.

## Information order

Use the smallest useful set of these sections in the user's language:

1. intent and outcome
2. Before → After behavior
3. logical change map
4. runtime or execution flow
5. critical-code walkthrough by logical block
6. architecture analysis
7. impact analysis
8. behavior-oriented test analysis
9. risks and edge cases
10. essential and useful concepts
11. 3–5 contextual understanding questions
12. compact evidence appendix

Omit sections that do not add understanding. Do not force a runtime diagram,
architecture verdict, or risk list when the scope lacks enough material. The
evidence appendix is a Deep completion requirement whenever the report makes a
material claim. Questions may be omitted only when the analyzed scope cannot
support three distinct, non-redundant questions from its actual behavior,
tradeoffs, risks, or tests.

## Before → After

Describe observable behavior, state, data flow, or responsibility before and
after the scope. Tie both sides to the correct revision. Avoid restating added
and removed lines.

## Execution flow and walkthrough

Show where changed components participate in the actual call, event, request,
or persistence path. Mark changed nodes. Explain critical code in logical
blocks:

1. what changed
2. why it matters
3. where it fits

Do not explain every line or every language feature.

## Architecture and impact

Assess architecture from real boundaries and dependency flow. State the
evidence and use `CONSISTENT`, `QUESTIONABLE`, `VIOLATION`, or `UNKNOWN` only
when helpful. Keep `DIRECT`, `INDIRECT`, and `POTENTIAL` impact independent of
`CONFIRMED`, `INFERRED`, and `UNKNOWN` evidence strength.

## Tests, risks, and learning

Explain what behavior each relevant discovered test protects and what changed
behavior remains unproven in the explored context. State whether tests ran.
Include only plausible, change-specific risks and edge cases.

Teach concepts necessary to understand decisions introduced by the change.
Classify internally as essential, useful, or incidental; publish essential and
useful concepts only.

Create 3–5 questions from the real change when the analysis identifies at least
three distinct behaviors, tradeoffs, risks, or test gaps. Questions should
require the developer to explain behavior, tradeoffs, or impact, not recall
generic textbook definitions. Count them before finishing. Do not replace the
set with one broad architecture or product question; that question may be one
member of the set.

## Evidence appendix

Include a compact appendix in every Deep report that makes material claims,
even when those claims already have inline citations. Give important claims
stable identifiers and map each material claim to an entry containing its
strength, source type, path/symbol/revision evidence, and limitations. A small
table or compact list is sufficient. Do not dump every inspected file or raw
command output.
