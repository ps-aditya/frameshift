# FrameShift Tier0 Inventory — READ-ONLY. No Set-, Remove-, Stop-, Disable- calls.
# Usage: powershell -ExecutionPolicy Bypass -File Get-FrameShiftInventory.ps1
$ErrorActionPreference = 'Continue'
$profile = [ordered]@{}

$os = Get-CimInstance Win32_OperatingSystem
$profile['os_caption'] = $os.Caption
$profile['os_build'] = $os.BuildNumber
$profile['os_arch'] = $os.OSArchitecture

$cpu = Get-CimInstance Win32_Processor | Select-Object -First 1
$profile['cpu'] = $cpu.Name
$profile['cores_logical'] = "$($cpu.NumberOfCores)C/$($cpu.NumberOfLogicalProcessors)T"

$ramGB = [math]::Round((Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1GB, 2)
$profile['ram_gb'] = $ramGB

$gpu = Get-CimInstance Win32_VideoController | ForEach-Object { "$($_.Name) | driver $($_.DriverVersion)" }
$profile['gpu'] = @($gpu)

$profile['disks'] = @(Get-PhysicalDisk | ForEach-Object { "$($_.FriendlyName) | $($_.MediaType) | $([math]::Round($_.Size/1GB))GB | $($_.BusType)" })
$profile['volumes'] = @(Get-PSDrive -PSProvider FileSystem | ForEach-Object { "$($_.Name): $([math]::Round($_.Free/1GB,1))GB free of $([math]::Round(($_.Used+$_.Free)/1GB,1))GB" })

# Power scheme (read-only query)
try { $profile['power_scheme'] = (powercfg /getactivescheme) -join ' ' } catch { $profile['power_scheme'] = "unknown: $_" }

# Game Mode (HKCU, read-only)
try { $gm = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\GameBar' -Name 'AllowAutoGameMode' -ErrorAction Stop; $profile['game_mode_auto'] = $gm.AllowAutoGameMode } catch { $profile['game_mode_auto'] = 'unknown/not-set' }

# HAGS HwSchMode (HKLM, read-only; admin may be needed — label unknown if denied)
try { $h = Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers' -Name 'HwSchMode' -ErrorAction Stop; $profile['hags_hwschmode'] = $h.HwSchMode } catch { $profile['hags_hwschmode'] = 'unknown/not-set-or-denied' }

# Visual effects (read-only)
try { $v = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects' -ErrorAction Stop; $profile['visual_effects'] = ($v | Out-String).Trim() } catch { $profile['visual_effects'] = 'unknown/not-set' }

# Startup apps impact via CIM (read-only enumeration, no disable)
try { $profile['startup_apps'] = @(Get-CimInstance Win32_StartupCommand | Select-Object Name, Command, Location, User | ForEach-Object { "$($_.Name) | $($_.Location) | $($_.User)" }) } catch { $profile['startup_apps'] = @("unknown: $_") }

# Storage Sense (read-only)
try { $s = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy' -ErrorAction Stop; $profile['storage_sense'] = ($s | Out-String).Trim() } catch { $profile['storage_sense'] = 'unknown/not-set' }

$profile['note'] = 'Tier0 read-only. No changes made. Redact before sharing.'
$profile | ConvertTo-Json -Depth 4
