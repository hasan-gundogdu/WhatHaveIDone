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

- Codex: `$whid [--repo <name-or-path> | --repos <names> | --all] [scope] [--deep]`
- Claude Code: `/whid [--repo <name-or-path> | --repos <names> | --all] [scope] [--deep]`
- Onboard: `$whid [--repo <name-or-path>] --onboard [--save <directory>]` or
  `/whid [--repo <name-or-path>] --onboard [--save <directory>]`, respectively.
- Git scopes may accompany only single-repository analysis; `--repos`/`--all`
  are working-tree Quick/Deep only. `--all` is valid even with one discoverable root.
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
- Marketplace/plugin packages are thin adapters around the canonical skill.
  Their presence does not certify Core behavior or imply directory approval.

Installation commands and client support can change upstream, so release
verification must test the documented add, update, and remove flows instead of
assuming documentation alone proves compatibility.

## Free marketplace packages

All three listings are intended to be **Free**, with the Apache-2.0 license
preserved. The user's coding-agent plan and usage costs still apply.

The root `plugin.json` supplies portable identity and OpenAI directory metadata.
`.claude-plugin/plugin.json` supplies Claude identity, and
`.claude-plugin/marketplace.json` exposes the same root as a Git-hosted Claude
Code marketplace. These adapters never change `skills/whid/`.
The shared [package README](../../packaging/README.md) is self-contained, so
archives do not need the repository's entire documentation tree.

Build from the public repository on Windows with Node.js and PowerShell:

```text
npm run package:marketplaces
```

The builder checks version/identity alignment and repository validation, then
writes `dist/<Core-version>/` (ignored by Git):

- `whid-<version>-codex.zip`: root portable manifest, canonical skill,
  square SVG icon, README, LICENSE, and NOTICE.
- `whid-<version>-claude.zip`: `.claude-plugin/plugin.json`, canonical skill,
  icon, README, LICENSE, and NOTICE.
- `whid-<version>-agensi.zip`: SKILL.md at the archive root, its references,
  LICENSE, and NOTICE.
- `listing.txt`, `SHA256SUMS.txt`, and `build-info.json`: reusable listing copy,
  archive hashes, and source commit/dirty-state provenance. Listing price is
  an instruction for the submission form, not an enforced manifest setting.

Every ZIP entry is read back and compared byte-for-byte with its allowlisted
source. Generated archives contain no repository history or local evaluation
outputs. Validate Claude's manifest separately with `claude plugin validate .`
and validate the extracted Claude archive before uploading. Local validation
does not replace each directory's scans or the Core behavioral eval matrix.

Publish in this order, updating this document with actual listing URLs only
after the listings exist:

1. **Codex:** upload the Codex ZIP to the existing/new plugin at the
   [OpenAI plugin portal](https://platform.openai.com/plugins), complete the
   verified publisher identity and listing fields, resolve scan findings, submit,
   then publish the approved version. Select a free listing if the portal offers
   pricing. WHID needs a coding-agent surface with Git and repository access;
   installing it in a chat without those capabilities does not grant them.
2. **Claude:** push the adapters to the public source before submitting its
   repository root through the
   [directory portal](https://claude.ai/directory/manage). The ZIP is also useful
   for local testing and direct sharing; the official submission reads GitHub.
   A paid Claude plan and a connected GitHub identity with push access are
   required. Claude Code plugin installs expose `/whid:whid`; standalone skill
   installs expose `/whid`.
3. **Agensi:** upload the Agensi ZIP in the
   [Creator Dashboard](https://www.agensi.io/dashboard), use the prepared listing
   copy, explicitly choose Free, and complete its scan/review process. Confirm
   current account requirements in the dashboard: the creator guide mentions
   Stripe even for free listings, while the seller page ties payouts to paid
   listings. Do not assume a payment account is required for this free package.

No listing has been submitted or approved merely because these files exist.
Publisher/contact details and any declarations in the portals must describe
the actual publisher and the host agent's repository/data access accurately.

### Initial Codex upload, 2026-10-21

The first `0.2.0-alpha.2` ZIP was uploaded under the verified individual
publisher. The draft exists but is **not submitted or published**. The portal
reported the blocking finding: “We are not accepting more skills-only
submissions at this time.” Packaging fixes cannot remove this admission limit.
It also required privacy and terms URLs, limited default prompts to three,
and flagged pricing/subscription language in the description. The local package
was updated for those metadata findings; upload/portal revalidation is still
required, and the privacy URL must exist on the public source branch first.

[Existing OpenAI draft](https://platform.openai.com/plugins/manage/plugins_6ad8b96f3fc4819193ac100db542ad07)
(publisher access required). Continue this draft if intake reopens; do not
create duplicate submissions or add an unnecessary MCP server to bypass intake.

## Releasing marketplace updates

Increment the Core and both manifest versions together, run the relevant
behavioral evaluations and package build, inspect the archives, then publish
the same source revision through each existing listing. Do not create a new
listing for every version. Build again from the release commit so provenance
records the published source; do not present a dirty build as a tagged release.

- **OpenAI directory:** bundled skill, asset, and metadata changes require a
  new complete ZIP on the existing plugin, checks/review, and publication.
  A GitHub push alone does not update this uploaded package.
- **Claude directory:** track the release branch (normally `main`); the
  directory discovers commits through scheduled checks or a GitHub webhook.
  Each version is scanned and published according to the applied review and
  auto-publish settings. A tag does not advance automatically.
- **Git-hosted Claude Code marketplace:** bump the manifest version and push.
  Users run `claude plugin update whid@whid-marketplace`, or receive updates
  if they enabled that marketplace's auto-update setting. This is distinct
  from approval in Anthropic's public directory.
- **Agensi:** the published content is uploaded, so plan to update the existing
  listing with a rebuilt skill package. Confirm the precise update controls and
  review requirements in the creator dashboard; automatic GitHub syncing has
  not been established.

Sources checked on 2026-10-21:
[OpenAI packaging](https://developers.openai.com/plugins/build/plugins),
[OpenAI updates](https://developers.openai.com/plugins/deploy/submission),
[Claude directory submission and updates](https://claude.com/docs/plugins/submit),
[Claude Code distribution](https://code.claude.com/docs/en/plugins/publish), and
[Agensi creator guide](https://www.agensi.io/learn/how-to-sell-skills-on-agensi).

## Static validation

Release validation installs the official Agent Skills reference library and
runs `skills-ref validate skills/whid`. The repository's `npm run validate`
check additionally enforces direct reference reachability, relative-link
integrity, size limits, and the vendor-neutral Core boundary. A hosted CI
workflow may be added later without changing the Core contract.
