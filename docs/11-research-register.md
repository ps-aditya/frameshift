# 11 — Research Register and Source Discipline

## Purpose
The supplied reference document is a starting map of ideas and projects, not a verified specification. It contains suggested tweak classes and a sample PowerShell script. Those commands must not be copied into production as a universal optimization routine.

## Sources mentioned in the supplied notes
These are research leads to inspect and verify before relying on them:
- Panjno YouTube channel — examples of consumer PC/game optimization tutorials; useful for understanding user expectations and common advice, not by itself proof that a tweak works.
- Chris Titus Tech WinUtil — open-source Windows utility; study its architecture, operation previews, maintenance and reversal behavior.
- Win11Debloat — open-source Windows debloating project; study scope and risks, not a default recipe.
- BleachBit / FluentCleaner — cleanup-tool behavior and boundaries.
- `just-maik/win-opti-resources` — candidate curated resource list mentioned in the notes; verify repository identity, maintenance, sources and licensing.
- Windows gaming optimization scripts on GitHub — useful for surveying approaches, but community scripts vary in quality and safety.

## Source hierarchy for a rule
1. Official Microsoft or hardware-vendor documentation for setting semantics, support and compatibility.
2. Peer-reviewed or well-designed controlled measurements, where available.
3. Reproducible experiments on the supported hardware/workload.
4. Credible independent technical analyses.
5. Community reports and video tutorials as hypotheses, not proof.

## Research ledger template
For every candidate, record:
- Claim and intended user outcome
- Exact setting/operation and supported OS builds
- Source URL, publication/update date and relevant passage
- Mechanism and plausible causal link
- Evidence quality and contradictory evidence
- Test hardware, workload, repetitions and raw data
- Side effects, regressions and security implications
- Rollback method and test results
- Rule owner, review date and status

## Specific caution
The supplied sample script proposes, among other things, forcing a power plan, editing MMCSS and HAGS registry values, disabling SysMain based on RAM, and deleting temporary/Prefetch contents. These are not approved recommendations. Do not ship them until each is independently reviewed and tested; a single RAM threshold or generic “gaming” label is not enough to establish suitability.

## Licensing and attribution
Before adapting code from any reference project, check its current license, notices, dependencies and attribution requirements. Keep copied code clearly separated from independently implemented ideas and document provenance.
