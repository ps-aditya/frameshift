# Select-Eligible.ps1 — SAFE SELECTOR, READ-ONLY. No system changes.
# Reads Tier0 inventory JSON (from Get-FrameShiftInventory.ps1) + rule v0.1.0.
# Outputs eligible / ineligible / no-op with reasons. Deterministic, no LLM, no commands generated.
param([Parameter(Mandatory=$true)][string]$InventoryJson)

$inv = Get-Content -LiteralPath $InventoryJson -Raw | ConvertFrom-Json
$out = [ordered]@{ eligible = @(); ineligible = @(); noop = $false; reasons = @() }

# OS gate: only Win10 19045 in Phase 1 matrix
if ($inv.os_build -ne '19045') { $out.ineligible += @{ rule='baseline.startup-apps-triage'; reason="unsupported OS build $($inv.os_build), need 19045" }; }
else { $out.reasons += 'OS 19045 in matrix' }

# HAGS advise-only check (never auto-toggle): flag ineligible for auto-action
if ($inv.hags_hwschmode -eq 'unknown/not-set-or-denied') { $out.reasons += 'HAGS state unknown/absent -> advise-only, safe-refusal demo (HD2000 has no WDDM2.7 support)' }

# Startup triage: filter system-critical (never touch)
$critical = @('SecurityHealth','IgfxTray','HotKeysCmds','Persistence')
$candidates = @($inv.startup_apps | Where-Object { $n=$_; -not ($critical | Where-Object { $n -like "*$_*" }) })
if ($candidates.Count -eq 0) { $out.noop = $true; $out.reasons += 'no non-critical startup entries -> no-op' }
else {
  foreach ($c in $candidates) {
    $name = ($c -split '\|')[0].Trim()
    $out.eligible += @{ rule='baseline.startup-apps-triage'; version='0.1.0'; target=$name; change="disable startup entry for $name only"; risk='app still installed, launches manually'; reboot=$true; undo="re-enable $($name)" }
  }
  $out.reasons += "$($candidates.Count) triageable entries found, $($critical.Count) critical excluded"
}
$out | ConvertTo-Json -Depth 5
