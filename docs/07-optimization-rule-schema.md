# 07 — Optimization Rule Schema

Rules should be reviewed, versioned, deterministic and independently testable. The following is a conceptual example, not a live optimization or a recommendation to change any Windows setting.

```yaml
id: example.rule-id
version: 0.1.0
title: Human-readable title
goal_tags:
  - stutter
supported_os:
  - Windows 11 <explicit supported build range>
eligibility:
  - condition: explicit typed predicate
    reason: why this condition matters
exclude_if:
  - condition: known incompatibility
    reason: risk explanation
evidence:
  grade: unreviewed
  sources: []
  summary: Mechanism and evidence must be reviewed before enabling.
risk:
  tier: 1
  summary: Plain-language risk
change:
  operations: []  # typed allowlisted operations only; no arbitrary shell
state:
  capture_fields: []
  verify_fields: []
rollback:
  operations: []
measurement:
  primary_metric: defined metric
  protocol_id: benchmark-protocol-id
reboot_required: unknown
owner: unassigned
last_reviewed: null
status: proposed
```

## Evidence grades
- **A — Strong:** credible primary/official evidence plus repeatable controlled testing for the defined scenario.
- **B — Moderate:** credible technical evidence and repeatable local tests, but limited independent replication or scope.
- **C — Preliminary:** plausible mechanism or community reports; use for research only, not automatic application.
- **D — Unsupported/contradicted:** do not ship.

Grades are internal shorthand, not a claim of scientific certainty. Include evidence limits and conflicts.

## Rule status lifecycle
`proposed → researching → lab-tested → reviewed → enabled-for-limited-release → generally-available → deprecated`

Any regression, OS update, driver change, security concern or failed rollback can move a rule back to review or disable it.

## Research notes on candidate tweak classes
The supplied reference notes mention debloating, telemetry changes, timer/HPET changes, MMCSS registry edits, SysMain, temporary-file cleanup, HAGS and power plans. These are **unapproved candidates**. Do not encode them as defaults or infer that a RAM threshold alone makes a change correct. Investigate each candidate's current Microsoft/vendor documentation, scope, compatibility, security effects, and repeatable outcome before writing an executable rule.
