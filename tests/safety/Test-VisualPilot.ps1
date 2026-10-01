# Test-VisualPilot.ps1 — full single-setting cycle on SANDBOX only. Zero UX impact.
# Simulates TaskbarAnimations pilot: journal-before-mutate, apply, verify, rollback, verify, cleanup.
$ErrorActionPreference = 'Stop'
$pass = 0; $fail = 0
function Ok($n) { Write-Output "PASS $n"; $script:pass++ }
function Bad($n,$e) { Write-Output "FAIL $n :: $e"; $script:fail++ }
$sb = 'HKCU:\Software\FrameShiftTest'
$j = "$env:TEMP\fs-visual-pilot-test.json"
try {
  if (Test-Path -LiteralPath $sb) { Remove-Item -LiteralPath $sb -Recurse -Force }
  New-Item -Path $sb -Force | Out-Null
  New-ItemProperty -LiteralPath $sb -Name 'TaskbarAnimations' -Value 1 -PropertyType DWord -Force | Out-Null
  # journal BEFORE mutate
  $orig = (Get-ItemProperty -LiteralPath $sb -Name 'TaskbarAnimations').TaskbarAnimations
  @{ rule='baseline.visual-effects-triage'; target='TaskbarAnimations(sandbox)'; original=$orig; status='journaled' } | ConvertTo-Json | Out-File -Encoding utf8 -LiteralPath $j
  if ((Test-Path -LiteralPath $j) -and $orig -eq 1) { Ok 'journal-before-mutate' } else { Bad 'journal' 'missing' }
  # apply + verify
  Set-ItemProperty -LiteralPath $sb -Name 'TaskbarAnimations' -Value 0
  if ((Get-ItemProperty -LiteralPath $sb -Name 'TaskbarAnimations').TaskbarAnimations -eq 0) { Ok 'apply-verified' } else { Bad 'apply' 'unverified' }
  # rollback + verify
  Set-ItemProperty -LiteralPath $sb -Name 'TaskbarAnimations' -Value $orig
  if ((Get-ItemProperty -LiteralPath $sb -Name 'TaskbarAnimations').TaskbarAnimations -eq 1) { Ok 'rollback-verified' } else { Bad 'rollback' 'unverified' }
  # real UX key untouched?
  $real = (Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarAnimations' -ErrorAction Stop).TaskbarAnimations
  if ($real -eq 1) { Ok 'real-ux-untouched' } else { Bad 'real-ux' "changed to $real" }
} catch { Bad 'exception' $_ } finally {
  if (Test-Path -LiteralPath $sb) { Remove-Item -LiteralPath $sb -Recurse -Force }
  if (Test-Path -LiteralPath $j) { Remove-Item -LiteralPath $j -Force }
  if (-not (Test-Path -LiteralPath $sb)) { Ok 'sandbox-cleaned' } else { Bad 'cleanup' 'left' }
}
Write-Output "---- $pass passed, $fail failed (UX changes: 0) ----"
if ($fail -gt 0) { exit 1 }
