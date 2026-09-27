# WhatHaveIDone Core v0.1 Distribution

## Package source

The repository is the distribution unit and `skills/whid/` is the canonical
skill directory. No generated vendor copy is committed.

## Supported hosts

- **v0.1 full-support targets:** Codex and Claude Code. The designation becomes
  release-certified only after both pass the clean-session dogfood matrix.
- **Best effort:** clients that implement the Agent Skills filesystem format
  and can provide Git/repository read access.

Host invocation syntax is documentation, not Core logic:

- Codex: `$whid [scope] [--deep]`
- Claude Code: `/whid [scope] [--deep]`
- Other hosts: explicit skill invocation or an explicit natural-language WHID
  request.

## Install

User scope for both supported hosts:

```text
npx skills add hasan-gundogdu/WhatHaveIDone --skill whid --global --agent codex --agent claude-code
```

Project scope uses the same command without `--global`.

Manual fallback:

- Codex: copy `skills/whid/` to `~/.codex/skills/whid/`
- Claude Code: copy `skills/whid/` to `~/.claude/skills/whid/`

Start a new session after installation. Claude Code users may use
`/reload-skills` when needed.

## Maintain an installation

```text
npx skills check
npx skills update
npx skills remove --global whid
```

For a project-scoped removal, omit `--global`.

The verified `skills` 1.7.0 CLI may apply updates during `skills check`; it is
not a guaranteed dry-run command. Use `npx skills list --global` for inventory
without requesting an update check. This behavior belongs to the external
installer and must be re-verified for each release.

## Portability constraints

Core must not depend on:

- `agents/openai.yaml` or vendor-specific metadata
- a host-specific tool name or tool allowlist
- hooks, MCP, a custom executable, or a custom installer
- POSIX-only or Windows-only filesystem paths
- a report template asset or a WHID-owned network service

Git is a required runtime capability. Shell examples in the skill describe Git
semantics; the host may perform equivalent read-only operations appropriate to
its environment.

## Versioning and release

Development occurs on `main`. The skill frontmatter carries the intended Core
version, every report displays that exact value, and repository validation keeps
it aligned with `package.json`. The first release tag is `v0.1.0`, created only
after static checks and the Codex/Claude dogfood matrix pass all hard gates.

- Behavior or contract changes increment the minor version before 1.0.
- Corrections and evidence tuning increment the patch version.
- During pre-release dogfood, each validated iteration increments the
  prerelease suffix and uses a matching Git tag.
- Marketplace/plugin packages may be added after v0.1 validation as thin
  adapters. They must not fork Core behavior.

Installation commands and client support can change upstream, so release
verification must test the documented add, update, and remove flows instead of
assuming documentation alone proves compatibility.

## Static validation

Release validation installs the official Agent Skills reference library and
runs `skills-ref validate skills/whid`. The repository's `npm run validate`
check additionally enforces direct reference reachability, relative-link
integrity, size limits, and the vendor-neutral Core boundary. A hosted CI
workflow may be added later without changing the Core contract.
