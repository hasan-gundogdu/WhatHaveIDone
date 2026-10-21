# WhatHaveIDone

> AI wrote the code. Make sure you understand it.

WHID is a free, Apache-2.0 Agent Skill for understanding repository changes and
learning unfamiliar projects. It uses the coding agent you already use and
requires Git plus repository access. Your agent provider's usage costs and data
policies still apply. There is no WHID-operated service or separate API key.

- Quick: explain working-tree changes, a commit, or a revision range.
- Deep: trace Before/After behavior, execution flow, architecture, tests, impact,
  evidence, and contextual understanding questions.
- Multi-repo: explicitly select repositories and connect changes through actual
  contracts and consumer expectations. Quick/Deep working-tree analysis only.
- Onboard: learn one current project in order; optionally save, refresh, or resume
  a Markdown guide in an explicitly requested directory.

Use `$whid` in Codex. In a Claude Code plugin installation, use the namespaced
skill `/whid:whid`; standalone skill installations use `/whid`. Examples:

```text
$whid HEAD --deep
$whid --all --deep
$whid --repos api,web
$whid --onboard
/whid:whid HEAD --deep
/whid:whid --all --deep
```

Quick/Deep do not modify the analyzed repositories. Saved Onboard writes only
managed guide files in the requested directory. Tests are inspected as evidence
and run only on a separate request. Findings distinguish repository evidence,
inference, and unknowns. This prerelease does not claim completed cross-agent
release certification.

[Source and full usage](https://github.com/hasan-gundogdu/WhatHaveIDone) ·
[Support](https://github.com/hasan-gundogdu/WhatHaveIDone/issues) ·
[License](https://github.com/hasan-gundogdu/WhatHaveIDone/blob/main/LICENSE)
