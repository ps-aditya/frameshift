# Day 5 — Spotify Pilot Report (honest, 2026-10-01)

Problem: startup/background overhead on Win10 19045, i3-2100 2C/4T, SSD.
Candidate: disable Spotify startup entry only (Tier 1, v0.1.0). Test candidate, NOT a guaranteed win.

## What was proven
- Perceive: Tier0 inventory, 12 startup entries (8 triageable, 4 critical excluded).
- Decide: selector eligible Spotify + 7 others; HAGS advise-only refusal correct.
- Authorize: per-app consent for Spotify only. No bulk.
- Act+verify: Approved bytes 2->3 (disabled), Run intact; re-read verified.
- Recover: rollback 3->2 (enabled), re-read verified. Status rolled-back-verified.
- Machine left unchanged (Spotify re-enabled, count back to 12/8). No security/Update/Defender touched.

## What was NOT proven
- Boot-time improvement: label Not-tested. Needs 3x controlled reboots + elevated Event ID 100 (currently UnauthorizedAccessException without admin). Uptime 34.68h since last boot; no reboot forced.
- Disk free fell 71.1 -> 67.3 GB during pilot week: flag for storage recommendations, not a claim.
- Single machine proves feasibility of safety cycle, not general effectiveness. i3 box already hand-optimized + SSD: do not generalize to HDD or Win11.

## Verdict
Safety cycle: PASS (apply-verified + rollback-verified, journaled).
Performance effect of Spotify disable on this box: INCONCLUSIVE / NOT-TESTED until reboot series.
Next per scope: visual-effects capture design, then storage/power guidance — one rule at a time, same journal gate.
