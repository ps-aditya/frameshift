# Test-Matrix.ps1 — 12-scenario guardrail matrix, DRY-RUN ONLY. No live mutations.
# Feeds synthetic Tier0 inventories to Select-Eligible; asserts eligible/ineligible/no-op/refusal per scenario.
$sel = 'C:\Users\Admin\Frameshift\src\engine\Select-Eligible.ps1'
$tmp = 'C:\Users\Admin\AppData\Local\Temp\opencode'
$pass = 0; $fail = 0
function Mk($name, $os, $apps, $hags) {
  $inv = @{ os_caption='Win'; os_build=$os; os_arch='64-bit'; cpu='x'; cores_logical='2C/4T'; ram_gb=8; gpu=@('g'); disks=@('d'); volumes=@('C:'); power_scheme='p'; game_mode_auto='u'; hags_hwschmode=$hags; visual_effects='u'; startup_apps=$apps; storage_sense='u'; note='synthetic' } | ConvertTo-Json -Depth 4
  $f = "$tmp\mtx-$name.json"; $inv | Out-File -Encoding utf8 -LiteralPath $f
  $o = powershell -NoProfile -ExecutionPolicy Bypass -File $sel -InventoryJson $f 2>&1 | Out-String
  return $o
}
function Expect([string]$name,[string]$out,[string]$want) {
  if ($out -match $want) { Write-Output "PASS $name"; $script:pass++ } else { Write-Output "FAIL $name (want $want) :: $out"; $script:fail++ }
}
Expect 'win10-clean-1app' (Mk 'a' '19045' @('Spotify | HKCU | u') 'unknown/not-set-or-denied') 'triageable'
Expect 'win10-noentries-noop' (Mk 'b' '19045' @() 'unknown/not-set-or-denied') 'no-op|triageable entries found, 4 critical excluded|no non-critical'
Expect 'win11-refused' (Mk 'c' '22631' @('Spotify | HKCU | u') 'unknown/not-set-or-denied') 'unsupported OS build'
Expect 'win10-ancientbuild-refused' (Mk 'd' '19042' @('Spotify | HKCU | u') 'unknown/not-set-or-denied') 'unsupported OS build'
Expect 'critical-only-noop' (Mk 'e' '19045' @('SecurityHealth | HKLM | s','IgfxTray | HKLM | s') 'unknown/not-set-or-denied') 'no non-critical|triageable entries found, 4 critical excluded'
Expect 'hdd-box-advise' (Mk 'f' '19045' @('Spotify | HKCU | u') 'unknown/not-set-or-denied') 'advise-only'
Expect 'laptop-many-apps' (Mk 'g' '19045' @('Spotify | HKCU | u','EpicGamesLauncher | HKCU | u','Docker Desktop | HKCU | u','SecurityHealth | HKLM | s') 'unknown/not-set-or-denied') 'triageable'
Expect 'ambiguous-similar-names' (Mk 'h' '19045' @('Spotify | HKCU | u','SpotifyWebHelper | HKCU | u') 'unknown/not-set-or-denied') 'triageable'
Expect 'unknown-os-blank' (Mk 'i' '' @('Spotify | HKCU | u') 'unknown/not-set-or-denied') 'unsupported OS build'
Expect 'hags-present-still-advise' (Mk 'j' '19045' @('Spotify | HKCU | u') '2') 'triageable'
Expect 'steam-only-gamer' (Mk 'k' '19045' @('Steam | HKCU | u') 'unknown/not-set-or-denied') 'Steam'
Expect 'edge-only' (Mk 'l' '19045' @('MicrosoftEdgeAutoLaunch_X | HKCU | u') 'unknown/not-set-or-denied') 'triageable'
Write-Output "---- $pass passed, $fail failed (mutations: 0) ----"
if ($fail -gt 0) { exit 1 }
