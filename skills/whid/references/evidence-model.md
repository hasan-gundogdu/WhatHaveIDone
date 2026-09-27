# Evidence Model

Use an internal evidence ledger throughout analysis. It is a reasoning aid, not
a mandatory output schema.

## Evidence strength

- `CONFIRMED`: Direct repository or user evidence supports the claim.
- `INFERRED`: Strong indirect evidence supports the claim, but a necessary
  link is not directly established.
- `UNKNOWN`: The explored evidence cannot support a reliable conclusion.

These labels describe evidence strength, not numerical model confidence.
Preserve the English uppercase labels in reports written in another language.

## Impact reach

Keep impact reach separate from evidence strength:

- `DIRECT`: The changed behavior or code directly affects the target.
- `INDIRECT`: A dependency, call, event, or data flow strongly connects the
  target to the change.
- `POTENTIAL`: An effect is plausible but not fully established.

A `POTENTIAL` impact can still be `CONFIRMED` when repository evidence directly
proves the risk path exists but not that it will occur. Conversely, a proposed
`DIRECT` impact may be `INFERRED` if runtime wiring was not found.

## Architecture status

Use `CONSISTENT`, `QUESTIONABLE`, `VIOLATION`, or `UNKNOWN` when an architecture
assessment adds value. Use `VIOLATION` only when an explicit boundary and the
contradicting dependency or behavior are both confirmed.

## Evidence sources

Useful types include:

- `CODE`
- `TEST`
- `CONFIG`
- `PROJECT_REFERENCE`
- `DOCUMENTATION`
- `COMMIT`
- `USER_INPUT`

Commit messages and documentation can establish stated intent, not actual
runtime behavior by themselves. Code can show implementation, but configuration
or composition may be needed to show that a path is active.

## Ledger fields

For every important claim, record mentally or in temporary working notes:

- claim
- evidence strength
- impact reach when applicable
- reason
- precise path, symbol, and revision evidence
- limitations or missing link

Do not expose private chain-of-thought or raw scratch notes. Publish the concise
claim, classification, evidence reference, and limitation needed for the user
to verify it.

## Citation rules

In Quick, place compact path/symbol/revision references next to confirmed
claims. Explicitly label inferred and unknown claims. Do not add a large
appendix.

In Deep, connect every material claim to a compact evidence appendix. Prefer
symbol or narrow line references when available; line numbers alone can drift
between revisions, so include the revision for historical evidence.

Avoid absolutes unsupported by the search boundary. For tests, use “no related
test was found in the explored context,” and describe where you looked.
