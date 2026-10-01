# Candidate Grades — Top 11 Panjno/GitHub Claims (2026-09-30, public sources only, no accounts)

Method: Panjno-style claims surveyed via public search excerpts (YouTube fetch blocked) + GitHub WinUtil (61k stars) / Win11Debloat (56k stars) docs + Microsoft Learn/Support as primary source per `docs/11-research-register.md`. Grades per `docs/07-optimization-rule-schema.md`. Tiers per `docs/05-safety-and-rollback.md`. No transcripts scraped, no logins.

## Passes to lab-test as D-007 safe-minimum (Tier 0/1, Grade A/B)
- `baseline.visual-effects-best-perf` — Tier 1, Grade B for responsiveness (C for FPS). Microsoft Support documented, reversible per-setting, capture + rollback trivial. 8-gate: needs metric = desktop responsiveness, NOT FPS claim.
- `baseline.startup-apps-triage` — Tier 1, Grade B for boot-to-ready. Microsoft Support + PC Manager documented. Must be per-app consent + capture, never bulk. Candidate for first baseline.
- `baseline.storage-sense-cleanup` — Tier 1, Grade B for space / C for FPS. Microsoft documented. Scope strictly to Storage Sense + Disk Cleanup; Prefetch delete explicitly excluded (Grade D).
- `baseline.driver-update-guidance` — Tier 0 guidance only, Grade A as advice. Executor must NOT auto-replace drivers per `docs/01-product-brief.md` non-goals. Show version + vendor link, user acts.

## Research-only (Tier 1/2, Grade C — needs per-machine A/B/A, no universal)
- `baseline.game-mode-enable` — Tier 1, Grade C. Microsoft: on by default, aims consistency not flat boost. Windows Central tests: little effect high-end, may help background-heavy low-end; some reports of crashes when forcing. Fail universal: effect workload-specific.
- `baseline.game-bar-disable` — Tier 1, Grade C. Community/Panjno claim of random drops; Microsoft treats as feature. Side effect: lose capture/share. Needs per-machine test.
- `baseline.power-plan-high-perf` — Tier 2, Grade C. Microsoft lists Best performance mode, but Ultimate Performance SKU-limited, battery/thermal cost on laptops, reboot/policy quirks. Excluded as universal per `docs/03-mvp-scope.md`.
- `baseline.hags-enable` — Tier 2, Grade C. Requires WDDM 2.7+ + supported GPU/driver (Intel HD 2000 on i3-2100 does NOT qualify; i5-6th UHD also unlikely). Mixed stutter reports, MPO/DWM interaction build-dependent. Excluded as universal. Critical: ineligible on both your boxes — perfect safe-refusal test.

## Do-not-ship generic (Grade D, Tier 3)
- `baseline.sysmain-disable-generic` — Tier 3 service, Grade D generic. Microsoft + TheWindowsClub: leave default best; only consider if malfunction with high CPU/disk. GitHub SSD-always-disable tables are insufficient predicate. Banned generic per `docs/03-mvp-scope.md`.
- `baseline.debloat-appx-bulk` — Tier 3, Grade D as perf claim. WinUtil docs themselves warn Advanced = caution + restore point; Win11Debloat issues (#730 hang on Copilot, #734 domain fail) + revert relies on Restore + Store reinstall (Store itself may be removed). Breaks Update/WinRE months later per 2026 reports. Your disappearing-restore-point pain applies directly. Excluded bulk.
- `baseline.timer-hpet-mmcss-pagefile-group` — Tier 3, Grade D. Boot/kernel, manual pagefile risks instability, no Microsoft support as gaming fix. Excluded.

## What this means for D-007
Safe-minimum = visual-effects + startup-triage + storage-sense only, each individually consented + journaled + verified. Everything else stays researching until reproducible on defined box with `docs/06-benchmark-protocol.md` runs.
