# 02 — Product Requirements Document (PRD)

## User journey
1. User installs and opens the app.
2. App explains what it collects and what it can change.
3. User chooses a goal: reduce game stutter, improve startup responsiveness, or investigate high resource use. MVP should expose only the goal implemented by the first validated workflow.
4. App collects a minimal local system profile and checks eligibility.
5. App presents a finding, the proposed change, expected mechanism, evidence grade, risk, reboot requirement and undo method.
6. User approves or declines.
7. App records the original state, applies the change, verifies the resulting state and runs a matched benchmark where practical.
8. App presents before/after results, limitations and rollback control.

## Functional requirements
- FR-01: Collect a documented, minimal system inventory locally.
- FR-02: Detect OS build, CPU, RAM, GPU, storage type/capacity where available, laptop/battery presence, relevant driver versions and required setting values.
- FR-03: Allow the user to select a performance goal.
- FR-04: Every recommendation must be generated from a versioned rule with explicit eligibility predicates.
- FR-05: Show proposed changes and their possible downsides before applying.
- FR-06: Require explicit consent for each change or clearly enumerated change group.
- FR-07: Capture current values and write an operation journal before mutation.
- FR-08: Verify the target state after applying.
- FR-09: Support idempotent apply and safe rollback for every shipped reversible rule.
- FR-10: Stop on unexpected state, partial failure, unsupported OS or failed preconditions.
- FR-11: Produce a local report with measurements, system conditions and rule versions.
- FR-12: Keep detailed inventory and reports on-device by default.
- FR-13: Offer a no-op/diagnostic result when no safe, evidence-supported action is available.
- FR-14: Clearly indicate whether a restart is required.
- FR-15: Never run model-generated arbitrary commands.

## Non-functional requirements
- Safety: least privilege; elevated operations separated from the UI where feasible.
- Transparency: every mutation has a human-readable explanation and audit entry.
- Reliability: crash/partial-failure behavior is defined and tested.
- Privacy: local-first; no telemetry by default in the prototype.
- Accessibility: plain language, readable layout, keyboard navigation.
- Performance: app must remain lightweight on constrained systems.
- Maintainability: rules are versioned, testable, and separable from UI code.

## MVP acceptance criteria
- Works only on a clearly documented Windows/PC support matrix.
- Inventory completes without making system changes.
- Every shipped rule has eligibility tests, risk notes, apply/verify/rollback implementation and unit/integration tests.
- User sees the exact values to be changed and can decline.
- No change is applied before consent and state capture.
- A simulated or real apply failure leaves the system in a known state or clearly reports manual recovery steps.
- Benchmark repeats and conditions are recorded; noisy or inconclusive results are labelled inconclusive.
- Rollback restores the recorded original values for the supported scenario.
- No administrator permission is requested until an action actually requires it.
- No network upload of hardware inventory or logs by default.

## MVP metrics
- Setup completion rate.
- Percentage of users who reach an eligible, actionable finding.
- Successful apply and verification rate.
- Verified rollback success rate.
- Percentage of benchmarks judged inconclusive.
- Regression/incident rate.
- Repeat use after 7 days.
- Qualitative trust score: did users understand what changed and feel in control?

Downloads, stars and raw “FPS gained” anecdotes are not sufficient success measures.
