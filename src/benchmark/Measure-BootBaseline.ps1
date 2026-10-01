# Measure-BootBaseline.ps1 — READ-ONLY measurement. No changes, no reboot.
# Collects what is readable without elevation; marks Event ID 100 as needs-elevation.
param([string]$OutJson = "")
$out = [ordered]@{ timestamp_utc = (Get-Date).ToUniversalTime().ToString('o'); os_build = ''; last_boot = ''; uptime_h = ''; startup_total = ''; startup_triageable = ''; disk_free_gb = ''; power = ''; boot_perf = ''; label = '' }
try {
  $os = Get-CimInstance Win32_OperatingSystem
  $out.os_build = $os.BuildNumber; $out.last_boot = $os.LastBootUpTime.ToString('o')
  $out.uptime_h = [math]::Round(((Get-Date) - $os.LastBootUpTime).TotalHours, 2)
} catch { $out.last_boot = "unknown: $_" }
try {
  $all = @(Get-CimInstance Win32_StartupCommand)
  $crit = @('SecurityHealth','IgfxTray','HotKeysCmds','Persistence')
  $tri = @($all | Where-Object { $n=$_.Name; -not ($crit | Where-Object { $n -like "*$_*" }) })
  $out.startup_total = $all.Count; $out.startup_triageable = $tri.Count
} catch { $out.startup_total = "unknown: $_" }
try { $out.disk_free_gb = [math]::Round((Get-PSDrive C).Free / 1GB, 1) } catch { $out.disk_free_gb = "unknown" }
try { $out.power = ((powercfg /getactivescheme) -join ' ').Trim() } catch { $out.power = "unknown" }
try {
  $ev = Get-WinEvent -LogName 'Microsoft-Windows-Diagnostics-Performance/Operational' -MaxEvents 30 -ErrorAction Stop | Where-Object { $_.Id -eq 100 } | Select-Object -First 3
  $out.boot_perf = @($ev | ForEach-Object { "$($_.TimeCreated): $($_.Message.Split([Environment]::NewLine)[0])" })
  if (-not $out.boot_perf -or $out.boot_perf.Count -eq 0) { $out.boot_perf = 'no-boot-events-found' }
} catch { $out.boot_perf = "needs-elevation: $($_.Exception.GetType().Name)" }
$out.label = 'Not-tested (need 3x controlled reboots + elevated Event 100 for verdict)'
$json = ($out | ConvertTo-Json -Depth 4)
if ($OutJson -ne "") { $json | Out-File -Encoding utf8 -LiteralPath $OutJson }
$json
