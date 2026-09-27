# Quick Report Contract

Quick should let the developer regain control of the change in roughly 3–5
minutes. Aim for about 3–5 critical points, adjusted when the scope is genuinely
smaller.

Show the exact WHID Core version from `SKILL.md` frontmatter directly below the
report title. Keep it separate from the analyzed repository's revision.

## Information order

Lead with the behavior or outcome. Then provide the smallest useful combination
of:

1. what the user did
2. logical change map
3. critical code and why it matters
4. architecture effect, only when relevant
5. direct, indirect, or potential impact
6. significant tests and risks
7. one or two essential learning reminders

These are behavioral sections, not a rigid template. Omit empty, redundant, or
low-value sections and use headings natural to the user's language.

## Content rules

- Organize around logical changes before listing files.
- Prefer behavior over a chronological narration of edits or commits.
- Use small code excerpts only when they are the clearest evidence.
- Cite confirmed claims close to the claim with path, symbol, and revision when
  relevant.
- Label `INFERRED` and `UNKNOWN` statements explicitly.
- Classify meaningful impact as `DIRECT`, `INDIRECT`, or `POTENTIAL` and give a
  reason.
- Mention architecture only when the change crosses, reinforces, or questions a
  meaningful boundary.
- Describe discovered tests by protected behavior, not as a long inventory.
- Include only material risks; do not manufacture a risk section.
- Do not include an evidence appendix.

End with a clear statement that tests were not run, unless the user separately
asked for them and they were run. If discovery was limited, state the relevant
limitation without weakening confirmed claims.
