# WhatHaveIDone Core v0.2 Distribution

## Package source

The repository is the distribution unit and `skills/whid/` is the canonical
skill directory. No generated vendor copy is committed.

## Supported hosts

- **v0.2 full-support targets:** Codex and Claude Code. The designation becomes
  release-certified only after both pass the clean-session dogfood matrix.
- **Best effort:** clients that implement the Agent Skills filesystem format
  and can provide Git/repository read access.

Host invocation syntax is documentation, not Core logic:

- Codex: `$whid [scope] [--deep]`
- Claude Code: `/whid [scope] [--deep]`
- Onboard: `$whid --onboard [--save <directory>]` or
  `/whid --onboard [--save <directory>]`, respectively.
- Other hosts: explicit skill invocation or an explicit natural-language WHID
  request.

## Install

User scope for both supported hosts:

```text
npx skills add hasan-gundogdu/WhatHaveIDone --skill whid --global --agent codex --agent claude-code
```

Project scope uses the same command without `--global`.

Manual fallback:

- Codex: copy `skills/whid/` to `~/.agents/skills/whid/`
- Claude Code: copy `skills/whid/` to `~/.claude/skills/whid/`

Codex detects local skill changes automatically; restart it if the update does
not appear. Claude Code users may use `/reload-skills` or start a new session.

## Maintain an installation

```text
npx skills update whid --global
npx skills remove --global whid
```

For a project-scoped removal, omit `--global`.

The verified `skills` 1.7.2 CLI supports updating a named global skill; its help
does not list the older `check` command. Use `npx skills list --global` for
non-updating inventory. Re-verify external installer behavior for each release.

## Portability constraints

Core must not depend on:

- `agents/openai.yaml` or vendor-specific metadata
- a host-specific tool name or tool allowlist
- hooks, MCP, a custom executable, or a custom installer
- POSIX-only or Windows-only filesystem paths
- a report template asset or a WHID-owned network service

Git is a required runtime capability. The host may perform equivalent read-only
inspection operations appropriate to its environment. Saved Onboard additionally
needs filesystem writes within the requested output directory and reliable
SHA-256 hashing. It remains instruction-only and does not install a helper.
If those capabilities are unavailable, the skill explains the limitation and
provides fresh chat analysis without claiming saved progress.

## Versioning and release

Development occurs on `main`. The skill frontmatter carries the intended Core
version, every report displays that exact value, and repository validation keeps
it aligned with `package.json`. The next target is `v0.2.0`, created only after
static checks and the expanded Codex/Claude dogfood matrix pass all hard gates.
The Onboard contract change advances the minor version from v0.1; it does not
imply that either version has passed release certification.

- Behavior or contract changes increment the minor version before 1.0.
- Corrections and evidence tuning increment the patch version.
- During pre-release dogfood, each validated iteration increments the
  prerelease suffix. Create matching tags only when their validation is recorded.
- Marketplace/plugin packages may be added after Core validation as thin
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
