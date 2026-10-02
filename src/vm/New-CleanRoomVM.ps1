# New-CleanRoomVM.ps1 — STAGED, NOT RUN. Requires: cold-booted VT-x=True, elevated admin, Win10 22H2 ISO present.
# Creates ONE sequential clean-room VM: 2 vCPU, 3GB RAM, 30GB differencing VHDX, no network auto-bridging.
#Requires -RunAsAdministrator
param([Parameter(Mandatory=$true)][string]$IsoPath, [string]$VmName = 'FS-Clean-W10', [string]$VhdDir = 'C:\VMs\FrameShift')
$ErrorActionPreference = 'Stop'
if ((Get-CimInstance Win32_Processor).VirtualizationFirmwareEnabled -ne $true) { throw 'REFUSE: VT-x not visible to OS. Cold-boot (full shutdown, not fast restart) and re-verify first.' }
if (-not (Test-Path -LiteralPath $IsoPath)) { throw "REFUSE: ISO missing at $IsoPath" }
if ((Get-PSDrive C).Free -lt 40GB) { throw 'REFUSE: need 40GB free (ISO 6GB + VHDX 30GB + headroom)' }
New-Item -ItemType Directory -Force -Path $VhdDir | Out-Null
$sw = Get-VMSwitch | Select-Object -First 1
if (-not $sw) { New-VMSwitch -Name 'FS-Internal' -SwitchType Internal | Out-Null; $sw = Get-VMSwitch -Name 'FS-Internal' }
New-VM -Name $VmName -MemoryStartupBytes 3GB -Generation 2 -NewVHDPath "$VhdDir\$VmName-diff.vhdx" -NewVHDSizeBytes 30GB -SwitchName $sw.Name | Out-Null
Set-VMProcessor -VMName $VmName -Count 2
Set-VMDvdDrive -VMName $VmName -Path $IsoPath
Checkpoint-VM -Name $VmName -SnapshotName 'pre-install'
Write-Output "STAGED-OK: $VmName created, pre-install checkpoint taken. Install Win10 22H2 from console, then Checkpoint 'clean-installed' before any FrameShift run."
