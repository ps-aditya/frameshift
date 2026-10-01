# 03 — MVP Scope and Boundaries

## Proposed MVP
A local-first Windows desktop prototype for **one reproducible performance problem**, initially exploring gaming stutter or startup/background overhead on a small, explicitly supported set of older Windows PCs.

The exact first problem and intervention are not locked as facts. They must be selected after measuring a baseline and reviewing evidence. The product vision is locked; the first optimization rule is not.

## Include
- Read-only system inventory.
- One user goal.
- One or two narrowly scoped candidate rules, only if evidence and tests support them.
- Human-readable preview of each action.
- Consent before change.
- Pre-change snapshot/journal.
- Apply and postcondition verification.
- Rollback.
- Before/after benchmark report.
- Local logs with redaction.
- A “no safe action found” outcome.

## Exclude
- AI agent with arbitrary PowerShell execution.
- Bulk “debloat everything” workflows.
- Deleting Prefetch or broad system directories as a generic optimization.
- Disabling SysMain based only on a RAM threshold.
- Forcing Ultimate Performance, HAGS, HPET/BCDEdit or MMCSS registry values universally.
- Driver cleanup/replacement or kernel-level tools.
- Automatic changes to services, security, networking, update, backup, audio or accessibility settings without a separate reviewed scope.
- Automatic benchmark claims across unsupported games/devices.
- Silent startup persistence or scheduled background optimization.

## Rule selection gate
A candidate rule can enter the MVP only if:
1. The mechanism is understandable and supported by credible evidence.
2. The target system and conditions are narrowly specified.
3. It has a measurable expected outcome.
4. It has an explicit compatibility predicate.
5. It is reversible, or its irreversibility is clearly disclosed and it is excluded from MVP.
6. It has automated tests and a manual test procedure.
7. It does not weaken security or compromise core OS functionality.
8. Its benefit is reproducible on at least one defined setup and does not show unacceptable regressions.

## Development rule
Build the safety and measurement framework before expanding the tweak catalogue. One proven rule is more valuable than twenty unvalidated toggles.
