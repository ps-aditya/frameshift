# FrameShift (working title)

> Get more out of the PC you already own.

FrameShift is a proposed Windows utility that profiles a PC, identifies a specific performance problem, recommends only compatible and evidence-backed interventions, applies approved changes, measures outcomes, and provides a clear rollback path.

**Status:** concept locked; prototype scope and hypotheses remain to be validated.  
**Working name only:** “FrameShift” is not a final brand and has not been checked for trademark, domain, package, or repository conflicts.

## Product principles
1. Fix problems, don't just report them.
2. Personalize to the actual machine, OS, workload, and user's goal.
3. Measure before and after; never promise universal FPS gains.
4. Prefer reversible, low-risk changes.
5. Explain every change in plain language and ask permission when consequential.
6. No arbitrary script execution, no hidden changes, no disabling security protections.
7. If evidence is weak or compatibility is unknown, recommend no change.

## Initial wedge
A Windows 10/11 tool for older or low-end PCs, starting with a narrowly defined gaming stutter/performance workflow. Exact supported OS builds, hardware classes, game/test harness, and first intervention are **not yet decided**; choose them only after reproducible baseline testing.

## Documentation map
- `docs/01-product-brief.md` — vision, users, value proposition, non-goals
- `docs/02-prd.md` — user stories, requirements, MVP acceptance criteria
- `docs/03-mvp-scope.md` — strict prototype boundaries
- `docs/04-architecture.md` — proposed technical architecture
- `docs/05-safety-and-rollback.md` — safety contract and change lifecycle
- `docs/06-benchmark-protocol.md` — measurement and claims policy
- `docs/07-optimization-rule-schema.md` — structure for auditable optimization rules
- `docs/08-threat-model-and-privacy.md` — threats, privacy, trust boundaries
- `docs/09-validation-plan.md` — discovery, prototype, testing and launch gates
- `docs/10-roadmap.md` — staged delivery plan
- `docs/11-research-register.md` — references and evidence discipline
- `docs/12-decisions-and-open-questions.md` — decisions, assumptions and unresolved questions
- `docs/13-repository-and-contribution.md` — suggested repository layout and engineering workflow

## Important note
The initial reference notes contain examples of registry edits, service disabling, cache deletion, timer/HPET changes, and forcing power/GPU scheduling settings. Treat those as **research leads, not approved optimizations**. A tweak is not safe or useful merely because a tutorial or script recommends it. In particular, do not ship a bulk debloat script or a universal “apply all tweaks” button.

## First milestone
Demonstrate one safe, repeatable intervention on a defined test setup; collect a baseline, apply the change with consent, rerun the same workload, report the result and uncertainty, and prove rollback. If no meaningful benefit is reproducible, do not ship that intervention.
