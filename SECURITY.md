# Security Policy

WHID reads repository content through the permissions and data policy of the
host coding agent. Quick/Deep and chat-only Onboard must not modify the analyzed
repository. Saved Onboard may write only managed report files within the requested
dedicated directory, protecting existing manual content and rejecting path escapes.
No mode may change source or Git state, read secret-like content without explicit
permission, or send source code to a WHID-operated service.

## Reporting a vulnerability

Use GitHub's private vulnerability reporting for this repository. Do not open a
public issue containing credentials, private source code, exploit details, or
other sensitive material.

Include the affected WHID version, host, invocation, repository-state category
(working tree, commit, range, or saved onboarding state), and a minimal synthetic reproduction when
possible. Never attach real secrets.
