# Journal schema — startup-triage v0.1.0 (Tier 1, reversible)
# One JSON file per operation. Restrictive ACLs. Never replay blindly after crash.

# Example: journal/<yyyyMMdd-HHmmss>-startup-triage-<appname>.json
# {
#   "journal_id": "20251001-120000-startup-triage-Steam",
#   "rule_id": "baseline.startup-apps-triage",
#   "rule_version": "0.1.0",
#   "os_build": "19045",
#   "timestamp_utc": "2025-10-01T12:00:00Z",
#   "consent": { "granted": true, "at_utc": "2025-10-01T11:59:00Z", "scope": "Disable Steam startup entry only" },
#   "precondition": { "app": "Steam", "location": "HKCU\\...\\Run", "enabled_before": true, "command": "C:\\...\\steam.exe -silent" },
#   "operation": "disable-startup-entry",
#   "original_state": { "enabled": true, "value": "C:\\...\\steam.exe -silent" },
#   "verify": { "enabled_after": false, "method": "Get-CimInstance Win32_StartupCommand + registry re-read", "at_utc": "2025-10-01T12:00:30Z" },
#   "rollback": { "attempted": false, "verified": false, "method": "restore original value, re-read" },
#   "status": "applied-verified | applied-unverified | rolled-back-verified | failed-no-change"
# }

# Lifecycle enforced by executor (not yet implemented):
# 1. re-read precondition -> 2. write journal with original_state BEFORE mutate ->
# 3. mutate single entry -> 4. re-read verify -> 5. record status ->
# 6. on crash/partial: next launch inspects journal, offers resume/rollback, never blind replay.
# Distinguish rollback-attempted vs rollback-verified. Manual recovery note required if unverified.
