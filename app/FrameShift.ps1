# FrameShift v0.1-pilot -- SCAN -> UNDERSTAND -> RECOMMEND -> OPTIMIZE -> VERIFY
# One live rule (per-app startup disable, HKCU, Win10 19045). Everything else is advice or refusal.
# No bulk apply. No model-generated commands. AI diagnosis has a deterministic fallback (used by default).
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$invScript = Join-Path $root 'src\inventory\Get-FrameShiftInventory.ps1'
$selScript = Join-Path $root 'src\engine\Select-Eligible.ps1'
$exeScript = Join-Path $root 'src\executor\Invoke-StartupTriage.ps1'
$benchScript = Join-Path $root 'src\benchmark\Measure-BootBaseline.ps1'
$tmp = $env:TEMP

function Get-AIDiagnosis($inv, $sel) {
  # Deterministic fallback is the default. If FS_AI_TEXT is set (reviewed model output pasted by operator),
  # it is shown as an extra labeled paragraph; it never changes eligibility or actions.
  $parts = @()
  $parts += "This PC runs Windows build $($inv.os_build) with $($inv.cpu) ($($inv.cores_logical)), $($inv.ram_gb) GB RAM, $($inv.gpu -join '; ')."
  $tri = @($sel.eligible).Count
  if ($tri -gt 0) { $parts += "Several applications launch with Windows ($tri triageable). Reducing unnecessary startup load is the highest-confidence optimization available." }
  else { $parts += "Startup load looks lean. There is no high-confidence startup optimization right now." }
  $parts += "Storage guidance and power mode are advice-only in this pilot. SysMain changes and HAGS forcing are not recommended for this configuration and will not be offered."
  if ($env:FS_AI_TEXT -ne $null -and $env:FS_AI_TEXT -ne '') { $parts += "[AI note - advisory only, does not change actions] " + $env:FS_AI_TEXT }
  return ($parts -join "`n`n")
}

function Show-Cards($inv, $sel, $map) {
  Write-Host ""
  Write-Host "---------- WHAT SHOULD YOU OPTIMIZE? ----------"
  $i = 0
  foreach ($e in @($sel.eligible)) {
    $i++
    Write-Host ""
    Write-Host ("[{0}] RECOMMENDED: Reduce startup load - {1}" -f $i, $e.target)
    Write-Host "    Why this PC: starts automatically; on 2C/4T boot and background contention is the plausible bottleneck."
    Write-Host ("    Action: disable startup entry. Risk: {0}. Undo: {1}." -f $e.risk, $e.undo)
    $map["$i"] = $e.target
  }
  $vol = @($inv.volumes)[0]
  Write-Host ""
  Write-Host ("[*] LOW PRIORITY: Storage cleanup - {0}. Advice only, nothing deleted by this app." -f $vol)
  Write-Host ("[*] ADVICE ONLY: Power mode - current {0}. No plan will be forced." -f $inv.power_scheme)
  Write-Host "[*] ADVICE ONLY: Visual effects - capture design pending. No blanket change offered."
  Write-Host "[*] ADVICE ONLY: Drivers and Game Mode - vendor links and guidance only, never auto-applied."
  Write-Host "[X] NOT RECOMMENDED: Disable SysMain - SSD-era generic rule is unsupported for this config. Do nothing."
  Write-Host "[X] NOT RECOMMENDED: Force HAGS - graphics hardware and OS state are not an appropriate target. Do nothing."
}

Write-Output "==================================================="
Write-Output " FrameShift - Get more from the PC you already own."
Write-Output " Checks your hardware and config, recommends only"
Write-Output " optimizations that make sense for YOUR machine."
Write-Output "==================================================="
Write-Output ""
Read-Host "Press Enter to Scan My PC" | Out-Null

Write-Output ""
Write-Output "Scanning (read-only, nothing changed)..."
powershell -NoProfile -ExecutionPolicy Bypass -File $invScript | Out-File -Encoding utf8 "$tmp\fs-app-inv.json"
$inv = Get-Content -LiteralPath "$tmp\fs-app-inv.json" -Raw | ConvertFrom-Json
powershell -NoProfile -ExecutionPolicy Bypass -File $selScript -InventoryJson "$tmp\fs-app-inv.json" | Out-File -Encoding utf8 "$tmp\fs-app-sel.json"
$sel = Get-Content -LiteralPath "$tmp\fs-app-sel.json" -Raw | ConvertFrom-Json

Write-Output ""
Write-Output "---------- YOUR PC ----------"
Write-Output ("Windows : {0} build {1} {2}" -f $inv.os_caption, $inv.os_build, $inv.os_arch)
Write-Output ("CPU     : {0} ({1})" -f $inv.cpu, $inv.cores_logical)
Write-Output ("RAM     : {0} GB" -f $inv.ram_gb)
Write-Output ("GPU     : {0}" -f ($inv.gpu -join '; '))
Write-Output ("Storage : {0}" -f ($inv.disks -join '; '))
Write-Output ("Power   : {0}" -f $inv.power_scheme)
if ($inv.chassis -ne $null) { Write-Output ("Chassis : {0} (3=desktop, 9-10=laptop, 31/32=convertible; unknown if blank)" -f $inv.chassis) }
$nElig = @($sel.eligible).Count
Write-Output ""
Write-Output ("Status  : Your PC has {0} optimization opportunities." -f $nElig)
foreach ($r in @($sel.reasons)) { Write-Output ("Note    : {0}" -f $r) }
foreach ($x in @($sel.ineligible)) { Write-Output ("Blocked : {0} - {1}" -f $x.rule, $x.reason) }

Write-Output ""
Write-Output "---------- WHAT FRAMESHIFT FOUND ----------"
Write-Output (Get-AIDiagnosis $inv $sel)

$map = @{}
Show-Cards $inv $sel $map
if ($nElig -eq 0) { Write-Output ""; Write-Output "Nothing safe and eligible right now. That is a valid result - no changes made."; exit 0 }

Write-Output ""
$pick = Read-Host ("Choose ONE number to optimize (1-{0}), or 0 to exit without changes" -f $nElig)
if ($pick -eq '0' -or -not $map.ContainsKey($pick)) { Write-Output "Exited. No changes made."; exit 0 }
$target = $map[$pick]

Write-Output ""
Write-Output "---------- BEFORE YOU APPLY ----------"
Write-Output ("FrameShift will change: {0} startup behavior (disable auto-start only)." -f $target)
Write-Output "Current state will be saved first so the change can be reversed."
Write-Output "App stays installed and launches manually. No other entry is touched."
$yes = Read-Host ("Type YES to consent to this exact change, anything else cancels")
if ($yes -ne 'YES') { Write-Output "Cancelled. No changes made."; exit 0 }

$stamp = Get-Date -Format "yyyyMMdd-HHmmss"
$consentFile = "$tmp\fs-consent-$stamp.txt"
$journalFile = "$tmp\fs-journal-$stamp-$($target -replace '[^A-Za-z0-9]','').json"
"consent: YES for $target at $(Get-Date -Format o)" | Out-File -Encoding utf8 -LiteralPath $consentFile

Write-Output ""
Write-Output "Applying through allowlisted operation (journal first)..."
$applyOut = powershell -NoProfile -ExecutionPolicy Bypass -File $exeScript -Target $target -Mode Apply -ConsentFile $consentFile -JournalOut $journalFile 2>&1 | Out-String
Write-Output $applyOut
if ($applyOut -notmatch 'applied-verified') { Write-Output "Stopped: verification did not pass. System left as found or journal records the state. Rollback offered on request."; exit 1 }

Write-Output ""
Write-Output "---------- RESULT ----------"
Write-Output "Optimization applied and verified."
Write-Output "Before: startup entry enabled. After: startup entry disabled, program intact."
Write-Output "Boot-time effect: measuring needs 3 controlled reboots plus elevated Event-100 read."
$bench = powershell -NoProfile -ExecutionPolicy Bypass -File $benchScript 2>&1 | Out-String
Write-Output $bench
Write-Output "Measured result: no boot improvement claimed today. Journal: $journalFile"

Write-Output ""
$rb = Read-Host "Type ROLLBACK to restore the original state now, anything else to keep the optimization"
if ($rb -eq 'ROLLBACK') {
  $j = Get-Content -LiteralPath $journalFile -Raw | ConvertFrom-Json
  $bytes = [byte[]]($j.original_state.approved -split ',' | ForEach-Object { [byte]$_ })
  Set-ItemProperty -LiteralPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run' -Name $target -Value $bytes
  $chk = (Get-ItemProperty -LiteralPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run' -Name $target).$target
  if (($chk -join ',') -eq $j.original_state.approved) { Write-Output "Rollback verified: original state restored." }
  else { Write-Output "Rollback UNVERIFIED: expected $($j.original_state.approved) but read $($chk -join ','). Manual recovery: re-enable in Task Manager Startup tab." }
} else { Write-Output "Kept. Re-run this app anytime to roll back with the journal above." }
