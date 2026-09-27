# WhatHaveIDone

> AI wrote the code. Make sure you understand it.

WhatHaveIDone (WHID) is a vendor-neutral Agent Skill that helps developers
recover ownership of repository changes. It explains what changed, how the
change works, why it matters, and what else it may affect. WHID is an
understanding tool, not a generic code reviewer.

Core v0.1 is instruction-only, runs through the user's existing coding-agent
environment, and is read-only with respect to the analyzed repository. Codex
and Claude Code are the fully supported v0.1 targets. Other compatible Agent
Skills clients are best effort.

## What it produces

- **Quick** is the default: a focused, 3–5 minute ownership recap.
- **Deep** adds Before → After, execution flow, architecture reasoning,
  behavior-oriented test analysis, contextual questions, and compact evidence.
- Claims are marked `CONFIRMED`, `INFERRED`, or `UNKNOWN` according to their
  repository evidence.
- Reports show the active WHID Core version and use the user's language.

WHID activates only when explicitly invoked or when the user explicitly asks
for an ownership analysis of what they changed. It does not run or advertise
itself after ordinary coding, review, commit, or refactoring work.

## Install

Install for Codex and Claude Code at user scope:

```text
npx skills add hasan-gundogdu/WhatHaveIDone --skill whid --global --agent codex --agent claude-code
```

Omit `--global` for project-scoped installation. Start a new agent session
after installation. In Claude Code, `/reload-skills` can refresh skills when a
new session is inconvenient.

Manual fallback:

- Codex: copy `skills/whid/` to `~/.codex/skills/whid/`
- Claude Code: copy `skills/whid/` to `~/.claude/skills/whid/`

Update or remove:

```text
npx skills check
npx skills update
npx skills remove --global whid
```

`skills check` is not guaranteed to be a dry run. Use
`npx skills list --global` for a non-updating inventory.

## Use

Canonical forms:

```text
whid
whid HEAD
whid <commit>
whid A..B
whid --deep
whid <scope> --deep
```

Host syntax:

- Codex: `$whid [scope] [--deep]`
- Claude Code: `/whid [scope] [--deep]`
- Other clients: use their explicit skill syntax or ask the agent to use WHID.

With no scope, WHID analyzes staged, unstaged, and relevant untracked changes
between `HEAD` and the working tree. It never silently substitutes a different
scope when input is invalid.

## Safety and privacy

- WHID does not modify the analyzed repository or Git state.
- Tests are not run unless the user separately requests them.
- Ignored files, generated/vendor output, binaries, credentials, and
  secret-like content are not read without explicit permission.
- WHID requires no WHID-operated service; analysis occurs through the host
  coding agent's existing repository access and data policy.

## Status

The current release is an alpha of Core v0.1. A stable `v0.1.0` tag will be
created only after the cross-agent evaluation matrix passes all hard gates.
Reports display the exact active Core version so results can be traced to the
contract that produced them.

See the [documentation index](docs/README.md), the
[evaluation guide](evals/README.md), and the
[contribution guide](CONTRIBUTING.md).

## License

Licensed under the [Apache License 2.0](LICENSE). See [NOTICE](NOTICE) for
attribution.
