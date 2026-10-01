# Invoke-StartupTriage.ps1 — TYPED EXECUTOR. DryRun by default. No bulk, no invent.
# Modes: DryRun (default, read-only plan) | Apply (requires -ConsentFile + journal write succeeds first).
# Invariants enforced: no-auth-no-mutate, unknown-means-stop, journal-before-mutation, verify-or-fail.
param(
  [Parameter(Mandatory=$true)][string]$Target,
  [ValidateSet('DryRun','Apply')][string]$Mode = 'DryRun',
  [string]$ConsentFile = '',
  [string]$JournalOut = ''
)
$ErrorActionPreference = 'Stop'
function Refuse([string]$why) { Write-Output (@{ status='refused'; reason=$why } | ConvertTo-Json -Compress); exit 0 }

$critical = @('SecurityHealth','IgfxTray','HotKeysCmds','Persistence')
foreach ($c in $critical) { if ($Target -like "*$c*") { Refuse "critical entry $Target excluded" } }

# OS gate
$os = Get-CimInstance Win32_OperatingSystem
if ($os.BuildNumber -ne '19045') { Refuse "unsupported OS build $($os.BuildNumber), need 19045" }

# Precondition re-read (fresh, never cached)
$runPath = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run'
$apprPath = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run'
try { $runVal = (Get-ItemProperty -LiteralPath $runPath -Name $Target -ErrorAction Stop).$Target }
catch { Refuse "unknown state: Run value for $Target missing ($($_.Exception.Message))" }
try { $appr = (Get-ItemProperty -LiteralPath $apprPath -Name $Target -ErrorAction Stop).$Target }
catch { Refuse "unknown state: StartupApproved for $Target missing" }
if ($appr[0] -eq 3) { Refuse "already-disabled: $Target (no-op, nothing to do)" }

$plan = [ordered]@{ status='planned'; target=$Target; operation='disable-startup-entry'; run_value=$runVal; approved_before=($appr -join ','); change='set StartupApproved[0]=3, keep Run intact'; verify='re-read approved=3 + Run intact'; rollback='restore approved[0]=2' }
if ($Mode -eq 'DryRun') { $plan | ConvertTo-Json -Depth 4; exit 0 }

# Apply gate: explicit consent file + journal path required
if ($ConsentFile -eq '' -or -not (Test-Path -LiteralPath $ConsentFile)) { Refuse 'no-auth-no-mutate: consent file missing' }
if ($JournalOut -eq '') { Refuse 'no-auth-no-mutate: journal path missing' }
$journal = [ordered]@{ journal_id=''; rule_id='baseline.startup-apps-triage'; rule_version='0.1.0'; target=$Target; original_state=@{ run_value=$runVal; approved=($appr -join ',') }; status='journaled-ready-to-apply' }
try { $journal | ConvertTo-Json -Depth 4 | Out-File -Encoding utf8 -LiteralPath $JournalOut } catch { Refuse "journal-before-mutation failed: $_" }

try { Set-ItemProperty -LiteralPath $apprPath -Name $Target -Value ([byte[]](3,0,0,0,0,0,0,0,0,0,0,0)) } catch { Refuse "apply failed, no change verified: $_" }
$after = (Get-ItemProperty -LiteralPath $apprPath -Name $Target).$Target
$runAfter = (Get-ItemProperty -LiteralPath $runPath -Name $Target).$Target
if ($after[0] -ne 3 -or $runAfter -ne $runVal) { Refuse 'verify failed: postcondition not met, offer rollback' }
@{ status='applied-verified'; target=$Target; approved_after=($after -join ','); run_intact=($runAfter -eq $runVal); journal=$JournalOut } | ConvertTo-Json -Depth 4
