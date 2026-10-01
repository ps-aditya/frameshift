# Phase 0 — Findings Log

## Interview #0 — founder / past self (2026-09-30)
Source: direct answers, pre-Phase 0.

Pains:
- Fear of irreversible damage; post-tweak desktop slower + stuttering → more fear.
- Recovery friction: manual System Restore; restore points created months earlier gone at time of need.
- Fear of data loss / permanent damage.
- In-game lag persisted after tweaks; gains only as accumulation of minute details.
- 100% disk pegged for hours on older systems → machine unusable for non-gaming needs.
- Wants before/after proof, properly implemented (found via gaming before/after).

Maps to: D-002 reversible-by-design, `docs/05-safety-and-rollback.md:34` (do not rely on Restore), `docs/06-benchmark-protocol.md:13` (no idle-RAM proxy for FPS).

## Test hardware (read-only, 2026-09-30)
- Dev box: Win10 Pro 22H2 19045, i3-2100 2C/4T, 10GB RAM, Intel HD Graphics 9.17.10.4459, 256GB SATA SSD (Zebronics).
- Caveats: already hand-optimized (baseline contaminated — inventory current tweaks before Phase 1); already SSD (100%-disk HDD case not reproducible here).
- Second box: work / uni laptop (notes, LeetCode, engineering) — observe-only for now. Win10, i5 6th-gen, UHD Graphics, M.2 SSD. Useful as modern-SSD negative / comparison case, not a mutation target.
- Open: add HDD-era VM or second box for disk/startup reproduction.

## Candidate ranking (interim, not selected)
- A. Gaming stutter on iGPU: metric FPS avg + 1% lows + frame-time spikes. Risk: high variance, old drivers; most popular fixes are Tier 3 out of MVP.
- B. 100% disk / slow startup / unusable system: metric disk active %, boot-to-ready, idle overhead window. Risk: classic fixes (SysMain-on-RAM, Prefetch delete, bulk debloat) are banned as generics per `docs/03-mvp-scope.md`.
- Cross-cutting: trust/undo + proof — required foundation, not the performance claim itself.

## D-007 validation checklist
- [ ] 5-8 interviews show demand for safe-minimum-first (not blind MAX)
- [ ] 1+ Tier 0/1 baseline candidates identified with mechanism + evidence
- [ ] One deep problem chosen with reproducible workload + metric + plausible rollback
- [ ] Support-matrix draft: OS builds + hardware classes we will / will not test
- [ ] Decision: promote / revise / drop D-007 before Milestone 3

## Next (to unblock Phase 1)
1. Post screener in 3 places using guide template.
2. Inventory current tweaks on i3 box (what was hand-optimized).
3. Capture work-laptop OS/disk class (observe-only).
4. Log interviews 1-8 in table format from guide; then select one problem.
