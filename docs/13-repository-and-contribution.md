# 13 — Repository and Contribution Guide

## Suggested repository structure
```text
frameshift/
├── README.md
├── LICENSE
├── CONTRIBUTING.md
├── SECURITY.md
├── CHANGELOG.md
├── docs/
│   ├── 01-product-brief.md
│   ├── 02-prd.md
│   ├── 03-mvp-scope.md
│   ├── 04-architecture.md
│   ├── 05-safety-and-rollback.md
│   ├── 06-benchmark-protocol.md
│   ├── 07-optimization-rule-schema.md
│   ├── 08-threat-model-and-privacy.md
│   ├── 09-validation-plan.md
│   ├── 10-roadmap.md
│   ├── 11-research-register.md
│   └── 12-decisions-and-open-questions.md
├── src/
│   ├── app/
│   ├── inventory/
│   ├── rules/
│   ├── executor/
│   ├── journal/
│   ├── verifier/
│   └── benchmark/
├── tests/
│   ├── unit/
│   ├── integration/
│   ├── safety/
│   └── benchmark/
└── research/
    ├── evidence-ledger.csv
    └── test-results/
```

## Branching and review
- Use short-lived branches and small pull requests.
- Every change that mutates system state needs explicit safety review.
- No rule can be enabled by default through an unreviewed PR.
- Require tests for eligibility, apply, verify, rollback and failure handling.
- Keep raw benchmark data and test conditions with published results.

## Issue template fields
- OS build and relevant hardware (redact identifiers)
- Exact symptom and reproduction steps
- Expected vs observed behavior
- Rule ID/version, if applicable
- Relevant local report with sensitive fields removed
- Whether rollback was attempted and verified
- Whether the issue is reproducible

## Release discipline
- Version the app and rule catalogue separately.
- Publish supported OS/hardware matrix and known issues.
- Sign releases when practical and provide integrity hashes.
- Never quietly change what a rule does after user consent.
- Deprecate unsafe/stale rules and document why.

## Security reporting
Provide a SECURITY.md with a private contact path before inviting broad testing. Do not ask users to post raw system inventories publicly.
