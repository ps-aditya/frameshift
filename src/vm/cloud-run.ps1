# cloud-run.ps1 — clean-room lab runner (inside the cloud VM, elevated PowerShell).
# Step 2: runs 36 checks. Steps 4-8: guided prompts, one action at a time, journal-first. No bulk.
$ErrorActionPreference = 'Continue'
function H($t) { Write-Output ""; Write-Output "=== $t ===" }
H 'STEP 2/9 - 36-check suite (read-only)'
powershell -NoProfile -ExecutionPolicy Bypass -File "$PSScriptRoot\..\tests\safety\Test-Refusals.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "$PSScriptRoot\..\tests\safety\Test-Matrix.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "$PSScriptRoot\..\tests\safety\Test-VisualCapture.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "$PSScriptRoot\..\tests\safety\Test-Guidance.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "$PSScriptRoot\..\tests\safety\Test-VisualPilot.ps1"
H 'STEP 3/9 - test env (you install, I verify)'
Write-Output 'Install these 6 startup apps yourself (defaults, allow startup): Spotify, Steam, Epic Games Launcher, Microsoft Edge (auto-launch on), Adobe Acrobat Reader, Notion.'
Write-Output 'Then press Enter and I will verify Tier0 sees them.'
Pause
powershell -NoProfile -ExecutionPolicy Bypass -File "$PSScriptRoot\..\inventory\Get-FrameShiftInventory.ps1" | Out-File -Encoding utf8 "$env:TEMP\fs-cloud-inv.json"
powershell -NoProfile -ExecutionPolicy Bypass -File "$PSScriptRoot\..\engine\Select-Eligible.ps1" -InventoryJson "$env:TEMP\fs-cloud-inv.json"
H 'STEP 4/9 - baseline (3x boot-to-ready + Event 100)'
Write-Output 'Reboot 3 times via Start > Power > Restart. After each boot, wait 2 min idle, then run:'
Write-Output '  powershell -NoProfile -ExecutionPolicy Bypass -File src\benchmark\Measure-BootBaseline.ps1'
Write-Output 'Record the 3 boot seconds + Event 100 durations in research/test-results/cloud-baseline.json (template below).'
H 'STEPS 5-8/9 - pilot + post + rollback (gated, one app, journal-first)'
Write-Output 'Say the target app here and I execute: precondition re-read -> journal -> consent check -> apply -> verify -> 3x post -> rollback -> verify.'
Write-Output 'Nothing runs until you name the app and confirm consent in this session.'
H 'STEP 9/9 - verdict'
Write-Output 'Labels: Improvement observed / No meaningful difference / Regression / Inconclusive / Not tested. No FPS guarantees, ever.'
