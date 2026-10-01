# 10 — Roadmap

## Milestone 0: Lock the problem
Deliverables: user interview notes, first use case, supported-system matrix, evidence register.
Exit: one measurable problem selected.

## Milestone 1: Read-only profiler
Deliverables: inventory collector, local profile, privacy note, unsupported-system handling.
Exit: stable output on supported and unsupported machines; no mutations.

## Milestone 2: Safety and measurement foundation
Deliverables: rule model, operation journal, consent UI, benchmark harness, rollback contract, test harness.
Exit: simulated rule passes apply/verify/failure/recovery tests.

## Milestone 3: First validated intervention
Deliverables: one reviewed rule, compatibility checks, baseline/post report, rollback.
Exit: repeatable result on a defined setup, no unacceptable regression, verified rollback.

## Milestone 4: Closed beta
Deliverables: installer, signed or otherwise integrity-verifiable builds, issue templates, known-issues page.
Exit: independent testers can use it safely; high-severity incidents resolved.

## Milestone 5: Public prototype
Deliverables: public repository, demo video, evidence pages, release notes, support policy.
Exit: independent adoption and useful feedback; retention and successful outcomes measured.

## Later, not promised
- More game and workload coverage.
- Startup responsiveness and disk/memory workflows.
- More hardware/OS combinations.
- Optional opt-in anonymized aggregate diagnostics, only after privacy review.
- Rule updates with integrity verification and rollback.

## What not to do yet
Do not build a giant tweak database, AI agent, cloud dashboard, updater, or polished marketing site before one end-to-end safe intervention works.
