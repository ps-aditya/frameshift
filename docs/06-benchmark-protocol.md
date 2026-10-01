# 06 — Benchmark and Evidence Protocol

## Purpose
Avoid confusing normal variance with a real performance gain. Report what was measured, under which conditions, and how certain the conclusion is.

## Define the outcome before testing
For each experiment, choose one primary metric and a small number of secondary metrics. Examples depend on the workload:
- Game frame rate: average FPS and frame-time percentiles (e.g. 1% lows) using a repeatable capture method.
- Stutter: frame-time distribution and count/duration of defined frame-time spikes.
- Startup: elapsed time from a defined start event to a defined ready state.
- Background overhead: CPU, memory and disk activity during a defined idle/workload window.

Do not substitute idle RAM use for game performance unless that relationship is being directly tested.

## Test protocol
1. Record machine, OS build, driver versions, power state, temperature context if available, workload version/settings and active background tasks.
2. Fix resolution, graphics settings, scene/route, game version, power connection and capture tool.
3. Warm up where appropriate and allow thermal/power behavior to stabilize.
4. Run multiple baseline repetitions.
5. Apply only the candidate intervention; avoid bundling unrelated changes.
6. Reboot only if the rule requires it, then restore the same test conditions.
7. Run the same number of post-change repetitions.
8. Where feasible, repeat an A/B/A or reversal sequence to detect drift and reversibility.
9. Record raw data and exclusions; do not cherry-pick runs.
10. Report median and spread, not just the best run. Use confidence intervals or an appropriate statistical test when sample size and design support it.
11. Test for regressions in secondary outcomes and stability.
12. Test rollback and rerun the workload where relevant.

## Result labels
- **Improvement observed:** change exceeds ordinary measured variation under this test.
- **No meaningful difference observed:** result is within the noise/defined practical threshold.
- **Regression observed:** outcome worsened or an important side effect occurred.
- **Inconclusive:** too few valid runs, unstable conditions, or noisy measurements.
- **Not tested:** no compatible test environment.

## Claims policy
- Never claim “X% faster on all PCs.”
- Distinguish measured results on a specific test system from expected outcomes elsewhere.
- Publish test conditions and limitations with any headline result.
- Keep raw results and the rule version associated with them.
- A single machine proves feasibility, not general effectiveness.
- User anecdotes are useful signals, not controlled evidence.

## Initial validation bar
For an MVP candidate: repeatable effect on a defined test machine, no unacceptable regressions, and successful rollback. Before broad public claims, test multiple representative systems and report the sample size and variance.
