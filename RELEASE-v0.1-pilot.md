# FrameShift v0.1-pilot — one problem, one rule, one promise

## Scope (locked)
- Problem: startup/background overhead on **Windows 10 22H2 build 19045 only**. Win11 refused by design (different Game Mode/HAGS/VBS paths — validation pending, not prejudice).
- One live rule: per-app startup-entry disable (Spotify-class, HKCU only, no admin). Everything else is read-only advice text.
- Not a bloat/AppX remover. No AI execution. No bulk apply. No driver/Defender/Update/SysMain/Prefetch/HAGS/HPET/MMCSS/pagefile changes.

## Promise
Preview the exact entry, explain consequence, capture original state, ask per-app permission, verify the change, measure honestly (including Inconclusive), roll back verified on request. Refuse when ineligible or uncertain.

## Run (portable, no install)
1. Download the v0.1-pilot ZIP from GitHub Releases, check SHA256 against the published value.
2. Extract, double-click `Run.bat` (runs Tier0 profile → eligibility → explainer; changes nothing by itself).
3. Approve at most ONE app when asked. Reboot only if you agree to measure; Event-100 boot timing needs one elevation otherwise verdict stays Not-tested.

## Rollback
Re-run, choose Rollback, confirm the journal ID. Restores the exact captured bytes and re-verifies. Uninstall = rollback-all + delete folder.

## Known issues / will-not-fix in v1
- Win11, HDD 100%-disk, non-19045 builds: refused, not broken — by design.
- Single startup disable on SSD may show seconds or Inconclusive boot delta; reported as-is, never inflated.
- Restore points attempted best-effort only; may be absent (disclosed, never relied upon).
- SmartScreen may warn (unsigned pilot); verify SHA256. No telemetry leaves the machine; redact SID/host before sharing logs.
- Support: file an issue with OS build, symptom, rule/journal ID, rollback state. Do not post raw inventories publicly.
