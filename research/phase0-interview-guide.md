# Phase 0 — Interview Guide (FrameShift)

Gate from `docs/09-validation-plan.md`: choose one frequent, measurable, bounded problem after 5-8 interviews.
D-007 provisional to validate: users want best safe minimum (Tier 0/1) first, then deep personalized fix. Not apply-all.

## Who to recruit
- Older / low-end Windows PC users: HDD-era Win10/11, 4-8GB RAM, Intel iGPU / old discrete GPU.
- Mix: gamers with stutter + general users with 100% disk / slow startup.
- Include 1 modern ineligible PC to test safe refusal later.
- Current access: limited — use async + online communities (see outreach below).

## Screening (2 min, async form / DM)
1. OS + build (`winver`), CPU, RAM, GPU, SSD or HDD + size/free?
2. What feels slow most often? Gaming stutter / startup / 100% disk / other?
3. Last time it hurt — what were you trying to do?
4. What did you try? (video / script / tool / settings) What happened?
5. Ever had a tweak make it worse? Ever lost a restore point / afraid of permanent damage?
6. 20 min chat, no tools installed, no changes, local notes only. OK to screen-share workload?

## Interview script (15-20 min, non-leading)
Do NOT lead with "Would you use an optimizer?"
- "Walk me through the last time your PC felt too slow."
- "Can you show me? What did you notice first?"
- "What did you try? Where did advice come from? What was the result?"
- "Was there a time it got worse after a change? What did you do to recover?"
- "Restore points / undo — trusted them? Ever disappeared?"
- "If you could see one before/after number, what would convince you?"
- "What are you afraid to change? Security / updates / files?"

## Record per interview
`id | date | hardware (CPU/RAM/GPU/disk) | OS build | symptom | frequency | workaround + cost | what failed | safety fear + quote | candidate metric (FPS 1% lows / boot-ready time / disk active %)`

Privacy: local-first per `docs/08-threat-model-and-privacy.md`. No upload by default. Redact names, serials, paths before sharing. Explicit consent to keep notes.

## Outreach for limited access
Post in r/lowendgaming, r/Windows10, uni Discord / engineering groups:

> "Researching slow PCs for a uni project — 20 min chat about what feels slow on your current PC, what you tried, what you're afraid to change. No tools installed, no changes made. Especially looking for HDD-era Win10/11 or Intel iGPU gaming stutter. DM with OS/CPU/RAM/HDD-or-SSD + game/app that hurts."

Aim: 2-3 gamers, 2-3 general old-PC, 1-2 online async, 1 modern negative case.

## Synthesis → exit
Cluster by symptom, count frequency × pain × measurability × Tier 0/1/2 feasibility. One problem wins only if: reproducible workload exists, metric defined per `docs/06-benchmark-protocol.md`, safe rollback plausible per `docs/05-safety-and-rollback.md`. Otherwise mark inconclusive — do not manufacture result.
