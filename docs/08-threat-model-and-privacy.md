# 08 — Threat Model and Privacy

## Assets to protect
- Windows integrity and bootability
- User files and installed applications
- Security posture
- System configuration and rollback journal
- Hardware inventory and performance logs
- User trust

## Threats
- A malicious or compromised rule/source causes unsafe changes.
- A bug applies a rule to an unsupported machine.
- A stale recommendation acts on settings changed since profiling.
- Partial failure leaves inconsistent system state.
- A report exposes device identifiers, usernames, paths or installed software.
- An untrusted process tampers with the journal.
- An attacker tricks the app into running arbitrary elevated commands.
- A benchmark produces misleading claims because of noisy conditions.

## Controls
- Local-first operation and no telemetry by default.
- Typed allowlisted operations; no arbitrary command strings.
- Signed releases and secure update channel before broad distribution.
- Rule review, version pinning and test coverage.
- Least privilege and narrowly scoped elevation.
- Precondition re-check immediately before mutation.
- Durable journal with restrictive permissions and integrity checks where practical.
- Redact usernames, serial numbers, machine names and paths from shareable reports.
- Explicit preview and consent for every mutation.
- Reproducible benchmark protocol.
- Dependency pinning, vulnerability review and build provenance as project matures.

## Privacy baseline
- Inventory and reports stay local by default.
- No account required for MVP.
- No automatic upload of crash logs or machine profiles.
- Export/share must be user initiated, with a preview of included fields.
- Document every collected field, purpose, retention period and deletion path.
- Do not collect game process lists or installed-app inventories unless needed for a specific feature and clearly disclosed.

## Incident response
If a shipped rule causes a credible regression:
1. Disable the rule in the next release/configuration and publish an advisory.
2. Preserve the exact rule version and reproduction details.
3. Tell affected users how to identify and reverse it.
4. Investigate scope and test rollback.
5. Re-enable only after review and regression tests.
