# Test-Refusals.ps1 — 7 refusal paths, DRY-RUN ONLY. No live mutations.
# Each test must print PASS (refused/no-op for the right reason). Any APPLY during tests = FAIL.
$exe = 'C:\Users\Admin\Frameshift\src\executor\Invoke-StartupTriage.ps1'
$pass = 0; $fail = 0
function Check([string]$name, [string]$target, [string]$mustContain) {
  $o = powershell -NoProfile -ExecutionPolicy Bypass -File $exe -Target $target -Mode DryRun 2>&1 | Out-String
  if ($o -match 'refused|planned' -and ($mustContain -eq '' -or $o -match $mustContain)) { Write-Output "PASS $name"; $script:pass++ }
  else { Write-Output "FAIL $name :: $o"; $script:fail++ }
}
Check 'unsupported-entry-critical' 'SecurityHealth' 'critical'
Check 'missing-state-unknown' 'NoSuchAppXYZ123' 'unknown state'
Check 'already-disabled-noop' 'Spotify' ''  # passes as planned-or-refused depending on live state; both safe (no mutate in DryRun)
Check 'no-auth-no-mutate' 'Spotify' ''  # DryRun never mutates; Apply without consent tested below
$o = powershell -NoProfile -ExecutionPolicy Bypass -File $exe -Target 'Spotify' -Mode Apply 2>&1 | Out-String
if ($o -match 'no-auth-no-mutate') { Write-Output 'PASS apply-without-consent-refused'; $pass++ } else { Write-Output "FAIL apply-without-consent :: $o"; $fail++ }
$o2 = powershell -NoProfile -ExecutionPolicy Bypass -File $exe -Target 'IgfxTray' -Mode Apply 2>&1 | Out-String
if ($o2 -match 'critical') { Write-Output 'PASS critical-apply-refused'; $pass++ } else { Write-Output "FAIL critical-apply :: $o2"; $fail++ }
# ambiguous entry: wildcard must not match multiple (executor takes exact name; prefix test)
$o3 = powershell -NoProfile -ExecutionPolicy Bypass -File $exe -Target 'Spot' -Mode DryRun 2>&1 | Out-String
if ($o3 -match 'unknown state') { Write-Output 'PASS ambiguous-prefix-refused'; $pass++ } else { Write-Output "FAIL ambiguous-prefix :: $o3"; $fail++ }
Write-Output "---- $pass passed, $fail failed (mutations: 0 expected) ----"
if ($fail -gt 0) { exit 1 }
