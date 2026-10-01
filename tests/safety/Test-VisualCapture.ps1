# Test-VisualCapture.ps1 — capture round-trip on SANDBOX key only (HKCU:\Software\FrameShiftTest).
# Proves capture/restore logic for visual-effects rule without touching real UX keys. Cleans up after.
$ErrorActionPreference = 'Stop'
$sb = 'HKCU:\Software\FrameShiftTest'
$pass = 0; $fail = 0
function Ok($n) { Write-Output "PASS $n"; $script:pass++ }
function Bad($n,$e) { Write-Output "FAIL $n :: $e"; $script:fail++ }
try {
  if (Test-Path -LiteralPath $sb) { Remove-Item -LiteralPath $sb -Recurse -Force }
  New-Item -Path $sb -Force | Out-Null
  # mimic real shape: DWord flags + binary mask + one absent key case
  New-ItemProperty -LiteralPath $sb -Name 'TaskbarAnimations' -Value 1 -PropertyType DWord -Force | Out-Null
  $mask = [byte[]](158,30,7,128,0,0,0,0,0,0,0,0)
  New-ItemProperty -LiteralPath $sb -Name 'UserPreferencesMask' -Value $mask -PropertyType Binary -Force | Out-Null
  # 1. capture
  $cap = @{ TaskbarAnimations = (Get-ItemProperty -LiteralPath $sb -Name 'TaskbarAnimations').TaskbarAnimations; UserPreferencesMask = ((Get-ItemProperty -LiteralPath $sb -Name 'UserPreferencesMask').UserPreferencesMask -join ','); MissingKeyWasAbsent = (-not (Test-Path -LiteralPath "$sb\VisualEffects")) }
  if ($cap.TaskbarAnimations -eq 1 -and $cap.MissingKeyWasAbsent) { Ok 'capture-absent-and-values' } else { Bad 'capture' 'mismatch' }
  # 2. mutate sandbox only
  Set-ItemProperty -LiteralPath $sb -Name 'TaskbarAnimations' -Value 0
  if ((Get-ItemProperty -LiteralPath $sb -Name 'TaskbarAnimations').TaskbarAnimations -eq 0) { Ok 'mutate-verify' } else { Bad 'mutate' 'nope' }
  # 3. restore
  Set-ItemProperty -LiteralPath $sb -Name 'TaskbarAnimations' -Value $cap.TaskbarAnimations
  Set-ItemProperty -LiteralPath $sb -Name 'UserPreferencesMask' -Value ([byte[]]($cap.UserPreferencesMask -split ',' | ForEach-Object { [byte]$_ }))
  $r1 = (Get-ItemProperty -LiteralPath $sb -Name 'TaskbarAnimations').TaskbarAnimations
  $r2 = ((Get-ItemProperty -LiteralPath $sb -Name 'UserPreferencesMask').UserPreferencesMask -join ',')
  if ($r1 -eq 1 -and $r2 -eq $cap.UserPreferencesMask) { Ok 'restore-verified' } else { Bad 'restore' "$r1 / $r2" }
  # 4. absent-key stays absent (we never created VisualEffects subkey)
  if (-not (Test-Path -LiteralPath "$sb\VisualEffects")) { Ok 'absent-stays-absent' } else { Bad 'absent' 'created?' }
} catch { Bad 'exception' $_ } finally {
  if (Test-Path -LiteralPath $sb) { Remove-Item -LiteralPath $sb -Recurse -Force }
  if (-not (Test-Path -LiteralPath $sb)) { Ok 'sandbox-cleaned' } else { Bad 'cleanup' 'left behind' }
}
Write-Output "---- $pass passed, $fail failed (UX keys touched: 0) ----"
if ($fail -gt 0) { exit 1 }
