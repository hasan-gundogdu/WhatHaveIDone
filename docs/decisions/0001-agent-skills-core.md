# ADR 0001: Use One Vendor-Neutral Agent Skills Core

- Status: Accepted
- Date: 2026-09-27

## Context

WHID should work in multiple coding agents without allowing each integration to
develop different analysis behavior. Codex and Claude Code both support
filesystem-based Agent Skills, while vendor metadata and marketplace packaging
are different concerns.

## Decision

Maintain one canonical skill named `whid` under `skills/whid/`, following the
open Agent Skills structure. Keep all behavior in `SKILL.md` and its directly
linked references. Treat Codex and Claude Code as full v0.1 validation targets
and other compatible clients as best effort.

Do not add `agents/openai.yaml`, Claude-specific metadata, custom installers,
hooks, MCP configuration, or duplicated host implementations to Core v0.1.

## Consequences

- Behavior changes are made once and tested in both supported hosts.
- Host-specific invocation and installation remain documentation-level
  adapters.
- Marketplace polish is deferred until Core behavior is validated.
- Capabilities unique to one host cannot become hidden Core requirements.
