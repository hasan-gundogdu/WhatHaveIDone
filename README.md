# WhatHaveIDone

> AI wrote the code. Make sure you understand it.

WhatHaveIDone (WHID) is a vendor-neutral Agent Skill that helps developers
recover ownership of repository changes and learn an unfamiliar project. It
explains behavior, execution flow, architecture, and the concepts needed to
work on the code. WHID is an understanding tool, not a generic code reviewer.

Core v0.2 is instruction-only and runs through the user's existing coding-agent
environment. Quick and Deep are read-only; Onboard may save a guide to an
explicitly requested report directory. Codex and Claude Code are full-support
validation targets, with release certification subject to the cross-agent matrix.
Other compatible Agent Skills clients are best effort.

## What it produces

- **Quick** is the default: a focused, 3–5 minute ownership recap.
- **Deep** adds Before → After, execution flow, architecture reasoning,
  behavior-oriented test analysis, contextual questions, and compact evidence.
- **Onboard** builds an ordered Markdown learning route through the current
  project: domain, system map, real end-to-end flows, decisions, development
  workflow, and contextual practice. Saved guides support chapter refresh/resume.
- Claims are marked `CONFIRMED`, `INFERRED`, or `UNKNOWN` according to their
  repository evidence.
- Reports show the active WHID Core version and use the user's language.

WHID activates only when explicitly invoked, explicitly requested for WHID
onboarding, or asked for an ownership analysis of what changed. It does not run or advertise
itself after ordinary coding, review, commit, or refactoring work.

## Install

Install for Codex and Claude Code at user scope:

```text
npx skills add hasan-gundogdu/WhatHaveIDone --skill whid --global --agent codex --agent claude-code
```

Omit `--global` for project-scoped installation. Codex detects local skill
changes automatically; restart Codex if the update does not appear. In Claude
Code, use `/reload-skills` or start a new session.

Manual fallback:

- Codex: copy `skills/whid/` to `~/.agents/skills/whid/`
- Claude Code: copy `skills/whid/` to `~/.claude/skills/whid/`

Update or remove:

```text
npx skills update whid --global
npx skills remove --global whid
```

The verified `skills` 1.7.2 CLI supports updating WHID by name.
For a manually copied skill, replace the installed `skills/whid/` contents
with those from the desired commit instead of expecting the CLI to update it. Use
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
whid --repo Flowenda.API
whid --repo Flowenda.Auth HEAD~3..HEAD --deep
whid --repos Flowenda.API,Flowenda.Auth
whid --repos Flowenda.API,Flowenda.Auth --deep
whid --all
whid --all --deep
whid --onboard
whid --onboard --save docs/whid/onboarding
whid --repo Flowenda.API --onboard --save docs/whid/onboarding
```

Host syntax:

- Codex: `$whid [--repo <name-or-path> | --repos <names> | --all] [scope] [--deep]`
- Claude Code: `/whid [--repo <name-or-path> | --repos <names> | --all] [scope] [--deep]`
- Onboard: `$whid [--repo <name-or-path>] --onboard [--save <directory>]` or
  `/whid [--repo <name-or-path>] --onboard [--save <directory>]`, respectively.
- Other clients: use their explicit skill syntax or ask the agent to use WHID.

`--repo` selects exactly one Git repository from the authorized workspace,
using a unique repository directory name or an explicit workspace-relative
repository-root path. With no selector, WHID uses the unambiguous active repository;
if more than one is plausible, it asks you to choose. Paths outside the
workspace and ambiguous names are rejected. Multi-repo analysis (`--repos`,
`--all`) is opt-in for Quick/Deep working-tree analysis: `--repos` accepts
comma-separated unique repository names or paths, while `--all` selects the
complete discoverable authorized workspace set, even a single repository.
`--repos` requires two distinct roots; `--all` requires one and rejects
ambiguous discovery. Both reject unresolved selections and do not accept
historical Git scopes or `--onboard`. Cross-repo findings require evidence; independent
Git histories are never treated as a shared timeline.

With no scope in Quick/Deep, WHID analyzes staged, unstaged, and relevant untracked changes
between `HEAD` and the working tree. It never silently substitutes a different
scope when input is invalid.

Onboard analyzes the current on-disk project and rejects Git scopes and `--deep`.
`--save` is Onboard-only. Relative directories resolve from the repository root;
quote paths containing spaces. Without a save request, the guide appears in chat.

## Saved onboarding guides

The directory contains `index.md`, ordered chapter Markdown files, and
`manifest.json`. The index gives learning goals, navigation, coverage, evidence
gaps, source provenance, and completion status. Chapters connect real code to
short concept reminders and project-specific exercises.

Repeat the saved invocation to refresh or resume. WHID verifies source and
output fingerprints, reuses unchanged chapters, revisits affected chapters and
dependents, and continues unfinished work. Dirty edits and new files count even
when HEAD is unchanged. Shared architecture changes can require revalidation of
the whole route; fingerprinting still incurs filesystem I/O.

Saved guides supplement authoritative project docs. They do not validate their
own claims. User-edited chapters and unrelated files are preserved and conflicts
are reported. HTML rendering is outside v0.2.

## Safety and privacy

- Quick/Deep and chat-only Onboard do not modify the analyzed repository.
- Saved Onboard writes only managed reports in the requested dedicated directory,
  inside or outside the repository; it does not modify source or Git state.
- Quick/Deep reports may be saved only to an explicitly requested external path.
- Tests are not run unless the user separately requests them.
- Ignored files, generated/vendor output, binaries, credentials, and
  secret-like content are not read without explicit permission.
- WHID requires no WHID-operated service; analysis occurs through the host
  coding agent's existing repository access and data policy.

## Status

The current version is `0.2.0-alpha.2`. A stable `v0.2.0` tag will be
created only after the cross-agent evaluation matrix passes all hard gates.
Reports display the exact active Core version so results can be traced to the
contract that produced them. Onboarding evaluation scenarios are defined;
their presence does not imply completed cross-agent certification.

See the [documentation index](docs/README.md), the
[evaluation guide](evals/README.md), and the
[contribution guide](CONTRIBUTING.md).

## License

Licensed under the [Apache License 2.0](LICENSE). See [NOTICE](NOTICE) for
attribution.
