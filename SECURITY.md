# Security Policy

WHID reads repository content through the permissions and data policy of the
host coding agent. It must not modify the analyzed repository, read secret-like
content without explicit permission, or send source code to a WHID-operated
service.

## Reporting a vulnerability

Use GitHub's private vulnerability reporting for this repository. Do not open a
public issue containing credentials, private source code, exploit details, or
other sensitive material.

Include the affected WHID version, host, invocation, repository-state category
(working tree, commit, or range), and a minimal synthetic reproduction when
possible. Never attach real secrets.
