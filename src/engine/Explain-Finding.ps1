# Explain-Finding.ps1 — TEMPLATED EXPLAINER, READ-ONLY. No LLM calls.
# Builds plain-language preview from rule fields + selector output only. Never invents commands.
param([Parameter(Mandatory=$true)][string]$SelectionJson)

$sel = Get-Content -LiteralPath $SelectionJson -Raw | ConvertFrom-Json
$lines = @()
$lines += 'FrameShift finding (startup/background overhead, Tier 1, reversible)'
$lines += ''
foreach ($e in $sel.eligible) {
  $lines += "Eligible: $($e.target)"
  $lines += "  Change: $($e.change)"
  $lines += '  Why this PC: startup entry enabled; boot/idle contention plausible on 2C/4T.'
  $lines += "  Risk: $($e.risk)"
  $lines += "  Reboot needed: $($e.reboot). Undo: $($e.undo)."
  $lines += '  Proof: 3x boot-to-ready before/after + Event ID 100; Inconclusive if noise.'
  $lines += ''
}
foreach ($i in $sel.ineligible) { $lines += "Ineligible: $($i.rule) - $($i.reason)" }
foreach ($r in $sel.reasons) { $lines += "Note: $r" }
$lines += ''
$lines += 'Consent required per app. Journal written before any change. No bulk apply.'
$lines -join "`n"
