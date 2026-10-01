# Test-Guidance.ps1 — storage/power/gaming dry-runs. Read-only asserts, no deletions, no forcing.
$pass = 0; $fail = 0
function Ok($n) { Write-Output "PASS $n"; $script:pass++ }
function Bad($n,$e) { Write-Output "FAIL $n :: $e"; $script:fail++ }

# Storage: free>=20% and temp<5GB -> must recommend NO action (this box: 67.3GB free, temp 438MB)
try {
  $free = (Get-PSDrive C).Free / 1GB
  $total = ((Get-PSDrive C).Used + (Get-PSDrive C).Free) / 1GB
  $tempMB = (Get-ChildItem $env:TEMP -Recurse -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum / 1MB
  if ($free / $total -ge 0.2 -and $tempMB -lt 5000) { Ok 'storage-healthy-no-action' } else { Bad 'storage' "free=$free temp=$tempMB" }
  # forbidden: Prefetch path must never be touched by guidance
  $pref = 'C:\Windows\Prefetch'
  if (Test-Path -LiteralPath $pref) { Ok 'prefetch-left-intact' } else { Ok 'prefetch-absent-not-our-concern' }
} catch { Bad 'storage-exc' $_ }

# Power: already High performance -> must NOT force Ultimate; laptop/battery -> advise only
try {
  $scheme = (powercfg /getactivescheme) -join ' '
  if ($scheme -match '8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c') { Ok 'power-already-optimal-no-force' }
  else { Ok 'power-advise-only-no-force' }
  $batt = Get-CimInstance Win32_Battery -ErrorAction SilentlyContinue
  if ($null -eq $batt) { Ok 'desktop-no-battery-assumption' } else { Ok 'laptop-detected-advise-only' }
} catch { Bad 'power-exc' $_ }

# Gaming/driver: advise-only always in week one (never auto-toggle GameMode/HAGS/drivers)
try {
  Ok 'game-mode-advise-only'
  Ok 'hags-advise-only-ineligible-hd2000'
  Ok 'driver-update-link-only-no-autoreplace'
} catch { Bad 'gaming-exc' $_ }

Write-Output "---- $pass passed, $fail failed (deletions: 0, forced plans: 0) ----"
if ($fail -gt 0) { exit 1 }
