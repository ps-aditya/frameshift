# FrameShift Portable (Day 6) — run without installing

## Contents
- `src/inventory/Get-FrameShiftInventory.ps1` — read-only profile
- `src/engine/Select-Eligible.ps1` + `Explain-Finding.ps1` — eligible/ineligible + plain preview
- `src/benchmark/Measure-BootBaseline.ps1` — read-only measurement (Event 100 needs elevation)
- `src/rules/baseline.startup-apps-triage-0.1.0.md` — rule, proposed
- `src/journal/schema-startup-triage.md` — journal contract + example file

## Supervised run (Day 7, with permission, no forced changes)
1. `powershell -ExecutionPolicy Bypass -File src\inventory\Get-FrameShiftInventory.ps1`
2. Save JSON, run selector, read explainer output to user.
3. One app only, explicit consent, journal BEFORE change, re-read verify.
4. Offer rollback test immediately; record applied/rolled-back-verified.
5. Measurement: 3x reboots only if user agrees + admin for Event 100; else label Not-tested.

## Limitations (ship with build)
- Win10 19045 only. Win11/HDD out. HAGS/Ultimate/SysMain/bulk-debloat/HPET/MMCSS/pagefile/driver-replace out.
- No zero-risk promise: very-low-risk by design, failures detected + journaled + recoverable where tested.
- Redact SID/machine-name/paths before sharing any JSON.
- i3 pilot box was pre-optimized + SSD: results there do not transfer.
