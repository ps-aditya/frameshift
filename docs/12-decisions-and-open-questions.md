# 12 — Decisions and Open Questions

## Decisions locked
- **Product direction:** automated, personalized PC optimization inspired by the accessibility and breadth of Panjno-style tutorials.
- **Target:** people using older or low-end PCs who need performance but may not be able to upgrade hardware and do not want to spend hours researching tweaks.
- **Product behavior:** detect, select, explain, apply, measure and provide rollback; not merely diagnose.
- **Trust posture:** local-first, transparent, conservative and reversible by design.
- **Evidence posture:** no universal performance claims; no unvalidated “apply all” recipe.
- **Initial platform direction:** Windows desktop, with exact supported versions still to be specified.
- **Working codename:** FrameShift, pending name checks.

## Open questions to resolve through discovery/testing
1. Which first problem is most common and painful: game stutter, startup slowness, high disk activity, or another issue?
2. Which game/workload can be benchmarked repeatably on available hardware?
3. Which Windows versions/builds are worth supporting first?
4. Which single intervention has a plausible mechanism, credible evidence, measurable outcome and safe rollback?
5. What is the smallest useful hardware inventory?
6. Which native stack is best for the developer's skill and target APIs?
7. How will rules be updated and integrity-verified?
8. What minimum sample is needed before a public performance claim?
9. What support burden can the project realistically maintain?
10. Is the temporary name available and legally usable? No check has been performed.

## Assumptions to test, not treat as facts
- Users want automated changes more than a diagnostic report.
- A sufficiently safe and measurable first intervention exists for the chosen cohort.
- Users will trust a tool that shows evidence and rollback.
- The user problem is frequent enough to justify repeat use.
