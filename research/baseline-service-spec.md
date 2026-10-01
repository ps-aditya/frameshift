# FrameShift Baseline Service — Model Response Spec (Phase 0 output)

Goal: answer "what is the best safe minimum for THIS pc?" without watching videos or running games. Deterministic, no arbitrary commands, per `docs/04-architecture.md`.

## Input (Tier 0 read-only inventory, local only)
`os_build, cpu, ram_gb, gpu + driver + wddm, disk_type + free_pct, laptop_battery, power_mode, game_mode, hags_state, visual_effects, startup_apps[{name, impact, enabled}], storage_sense, background_apps`

No usernames, serials, paths in shared output per `docs/08-threat-model-and-privacy.md`.

## Credible-only source hierarchy actually used (2026-09-30, no accounts)
1. Microsoft Support 4002019 (12 solutions: updates, Storage Sense, startup triage, visual effects, Best performance, optimize drives) — primary for Tier 1.
2. Microsoft DirectX blog HAGS (2020-06-30, Pronovost): opt-in, off by default, needs WDDM 2.7+ + hw + driver, transparent not faster; comments show freezes/Blender breakage.
3. Microsoft Learn startup/compat + boot-performance (OEM preload main delay, disk-bound boot, Task Manager impact High/Med/Low thresholds).
4. Controlled tests: FrameSync Labs Jan 2025 (HAGS +0.3% avg, +1.6% 1% low, +1GB VRAM cost); MSFS forum A/B (Game Mode/HAGS ±1-2 FPS = noise); CS2-opt 3-run (HAGS +6.5 FPS high-end only, power plans within noise 890-894 FPS); BabelTech 23-game Win10 vs Win11; HowToGeek boot test (Baseline 70s→51s all-off→59s selective; 27s→20s→23s).
5. GitHub credible-only: WinUtil MIT 63k stars `config/preset.json` (Standard/Minimal/Advanced + Essential vs Advanced-caution + Undo Selected + restore point; FAQ lists Essential safe: telemetry/activity/location/temp/disk-cleanup/restore-point); Win11Debloat 56k stars wiki Reverting-Changes + open issues #730/#734 (bulk risk, Restore-dependent); cs2-opt scheduler doc (HAGS ON only for RTX40/50+RX9000, OFF for X3D/older, NetworkThrottlingIndex FFFFFFFF increases DPC latency — refutes common guide claim).

Panjno-grade videos: YouTube direct fetch blocked without login; confirmed via titles/descriptions/search excerpts + Acer guide crediting Panjno for Game Bar disable + similar 14-tweak / registry / VRAM-compression videos. Treated as Grade C hypotheses per `docs/11-research-register.md`, never as proof. No comment scraping (ToS + noise); used GitHub issues + blog comments as failure signals only.

## Rules (only these enabled for baseline)
- `baseline.startup-apps-triage` Tier1 B — eligible if 1+ High/Medium impact non-essential enabled; per-app consent; capture Enabled state + registry/Startup-folder path; verify Task Manager state; rollback re-enable; metric boot-to-ready + Event ID 100.
- `baseline.visual-effects-best-perf` Tier1 B(resp)/C(FPS) — eligible always; capture per-effect flags; verify; rollback restore; metric responsiveness Likert + reopen time, NOT FPS claim.
- `baseline.storage-sense-cleanup` Tier1 B(space)/C(FPS) — eligible if free<20% or temp>5GB; Storage Sense + Disk Cleanup only; never Prefetch; verify free space; rollback N/A (deletion disclosed, no system files).
- `baseline.power-mode-check` Tier1 C — eligible if desktop or plugged-in laptop; Best performance/High perf only, never force Ultimate on unsupported SKU; capture GUID; verify `powercfg /getactivescheme`; rollback restore GUID.
- `baseline.game-mode-hags-advise` Tier0 C — advise-only: show current + requirements (HAGS needs WDDM2.7+ + reboot; i3-2100 HD2000 = ineligible → safe-refusal demo); no auto-toggle in baseline.
- Explicitly NOT in service: SysMain/Prefetch generic off (D/Tier3), bulk AppX (D/Tier3), ISLC/HPET/BCDEdit/MMCSS/pagefile-manual (D/Tier3), driver auto-replace (A-advice/Tier0-only).

## Response shape (model output)
`eligible[{rule_id, version, why_this_pc, exact_change, risk, reboot, undo}] + ineligible[{rule_id, reason}] + no-op when none + before/after{metric, median+spread, label: Improvement/No-difference/Regression/Inconclusive} + journal_id`

Failure closed-loop: incomplete inventory → no apply; stale precondition → cancel; capture fail → no mutate; verify fail → offer rollback; noisy bench → Inconclusive. Never claim from idle RAM/disk alone per `docs/06-benchmark-protocol.md:13`.

## Why this fixes for people
Covers Microsoft's own 12 solutions but personalized + journaled + measured, instead of Panjno-style "apply 14 tweaks" or WinUtil Advanced one-click. Your boxes: i3-2100/SSD = startup/visual/storage eligible, HAGS/game-mode ineligible (proves safe refusal); i5-6th/M.2 = comparison/negative case. Next: implement Tier0 inventory → one Tier1 rule → A/B/A bench → verified rollback on i3 box.
