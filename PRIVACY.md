# WHID Core privacy

Effective date: 2026-10-21. Applies to the open-source WhatHaveIDone (WHID)
Core skill and its distribution packages published by Hasan Gundogdu.

## Repository analysis

WHID Core consists of instructions and reference files consumed by your coding
agent. It directs that agent to inspect repository code, Git changes,
configuration, documentation, and tests within the selected scope. This material
can contain personal or confidential information. Only use repositories you are
authorized to analyze.

The WHID package includes no telemetry, analytics, remote MCP server, or
WHID-operated backend. It does not direct your agent to send repository contents
or reports to a WHID service. There is no separate WHID account or WHID data
retention service.

Your coding agent may transmit inspected content to its model provider and may
retain conversations or logs according to that provider's policies, your plan,
and your settings. Installing WHID does not make a cloud-backed agent offline
or change those policies. Marketplace operators separately process account,
installation, and usage information under their own policies.

## Reports and files

Reports appear in the host conversation by default. Explicitly saved reports
are ordinary files in the requested destination and may contain source excerpts,
repository paths, and other information from the analysis. Saved onboarding
guides also include a manifest with source fingerprints and progress metadata.
You control their storage, sharing, backup, and deletion; WHID does not supply
a separate retention or deletion service.

The skill excludes ignored files, credentials and secret candidates, generated
output, and binaries from inspection unless separately authorized. These are
agent instructions, not a technical sandbox; your host's permissions and your
review of generated output remain relevant.

## Support

Support is available through
[GitHub issues](https://github.com/hasan-gundogdu/WhatHaveIDone/issues).
Public issues and attachments are visible to others. Do not post credentials,
private repository content, identity documents, or personal information there.
GitHub processes issue and account data under its own privacy policy.

Changes to this notice are recorded in this repository's Git history. The
software license is [Apache-2.0](LICENSE).
