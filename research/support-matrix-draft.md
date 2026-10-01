# Support Matrix Draft — Milestone 0 exit proposal (2026-09-30)

## Proposed first problem (to lock)
**B. Startup / background overhead → slow boot-to-ready + system unusable under load.**
Why, per evidence:
- Grade B, Tier 1 only (startup-triage per-app, visual-effects, Storage Sense) vs gaming-stutter where HAGS/power/Game-Bar are Grade C Tier 2 and HAGS ineligible on both available boxes.
- Measurable without game: boot-to-ready time + Event ID 100 + Task Manager Startup impact + disk active % idle window, per `docs/06-benchmark-protocol.md`.
- Safest rollback: re-enable startup entry, restore visual flags — vs Tier 3 service/boot risks.
- Still serves gamers: background overhead is the CPU/disk contention behind stutter on 2C/4T + old iGPU.

Gaming stutter stays as Milestone 4+ follow-up once baseline service proves trust. Initial wedge in README stays valid as direction; exact first workflow = startup/background per D-005 open.

## Supported (Phase 1 lab)
- OS: Windows 10 Pro 22H2 build 19045 64-bit only. Win11 explicitly out for now (different Game Mode/HAGS/VBS paths, Win10 EOL 2025-10-14 noted — lab use only, no security claims).
- Box A (primary, mutable only after journal): i3-2100 2C/4T, 10GB RAM, Intel HD Graphics 9.17.10.4459, 256GB SATA SSD. Caveat: already hand-optimized — inventory deltas first.
- Box B (observe-only, safe-refusal + comparison): Win10, i5 6th-gen UHD, M.2 SSD. No mutations.

## Explicitly unsupported (must refuse with reason)
- Any HDD 100%-disk case (no HDD box available — do not claim).
- HAGS enable on HD2000 / UHD 6th-gen (no WDDM 2.7+ support → ineligible demo).
- Ultimate Performance force on laptop/battery or unsupported SKU.
- SysMain/Prefetch generic off, bulk AppX, ISLC/HPET/BCDEdit/MMCSS/pagefile-manual (Tier 3, Grade D).
- Driver auto-replace, BIOS/firmware, Defender/Update changes.

## Exit check
Lock B + this matrix → build Tier0 inventory → implement 1 Tier1 rule (startup-triage) → A/B bench → verified rollback. If boot delta is noise, mark Inconclusive per protocol — do not pivot to riskier rule to manufacture win.
