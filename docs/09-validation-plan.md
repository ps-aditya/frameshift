# 09 — Validation Plan

## Phase 0: Problem discovery (days 1–3)
- Interview 5–8 people who use older/low-end Windows PCs.
- Ask what feels slow, what they tried, what failed, and what they are afraid to change.
- Ask them to demonstrate the issue on their own device where possible.
- Record the game/app, OS, hardware, symptom and current workaround.
- Avoid leading with “Would you use an optimizer?” Ask about real recent behavior.
**Gate:** choose one frequent, measurable, bounded problem.

## Phase 1: Reproduce and measure (days 4–5)
- Define the support matrix and one repeatable workload.
- Capture several baseline runs.
- Identify plausible causes and candidate interventions.
- Read primary/vendor documentation and compare credible independent evidence.
**Gate:** can the issue and baseline be reproduced reliably?

## Phase 2: Safety-first prototype (days 6–10)
- Build read-only inventory.
- Implement a single candidate rule only if it passes the evidence gate.
- Add preview, consent, state journal, verification and rollback before broadening.
- Automate tests for eligibility, apply, failure and rollback.
**Gate:** can the app prove the operation happened and reverse it?

## Phase 3: Independent testing (days 11–14)
- Test on the developer's machine and 5–10 independent testers if feasible.
- Include at least one ineligible system to verify safe refusal.
- Collect baseline/post data with consent; don't silently collect telemetry.
- Record confusion, failed actions, regressions and rollback outcomes.
**Gate:** no unresolved high-severity safety issue; outcome is repeatable enough to justify a limited release.

## Phase 4: Small public release (weeks 3–4)
- Publish source, support matrix, evidence notes, limitations and known issues.
- Share a technical demo showing baseline, one intervention, result and rollback.
- Recruit users through relevant communities and direct outreach; avoid unsupported FPS claims.
- Use issue templates to collect reproducible bug reports.
**Gate:** independent users can complete the workflow without live developer assistance.

## Validation metrics
- Real problem frequency and current workaround cost.
- Eligible/actionable rate.
- Apply verification and rollback success.
- Regression and incident rate.
- Percentage of inconclusive benchmark results.
- User comprehension and trust.
- Independent successful use and repeat usage.

## Stop/pivot criteria
- If no reliable measurable benefit appears, do not manufacture a result.
- If the effect is hardware- or workload-specific, narrow the support claim.
- If users primarily need diagnosis rather than changes, keep the read-only report as a supporting feature, not a forced pivot.
- If safe rollback cannot be guaranteed for an intervention, exclude it.
