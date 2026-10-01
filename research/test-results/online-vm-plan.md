# Online-VM extensive test plan — what it proves, what it needs, what it cannot do

## Honest boundary (locked)
No test matrix makes failure impossible. OS can crash, hardware can fail, external processes interfere. Goal: forbidden actions structurally unavailable + residual risk minimized + failures detected and recoverable. No 100% guarantee, ever.

## What online VMs CAN prove (with your account + budget + consent — I cannot provision without them)
- Clean-room OS matrix: Win10 19045 fresh vs Win11 22631 refusal, ancient-build refusal, no-entries no-op — same 12 scenarios but on real kernels instead of synthetic JSON.
- Journal/verify/rollback cycle on disposable machines where reboot + elevation are free (Event ID 100 readable as admin in cloud).
- Regression sweep: apply Spotify-disable -> reboot -> confirm boot + app manual-launch intact, 3x each.

## What online VMs CANNOT prove
- Old-PC realism: cloud vCPUs + premium SSD + 8GB+ RAM are not i3-2100 2C/4T + HD2000 + spinning HDD 100%-disk. A pass there does not transfer to broken-down laptops. Your i3 + 1-2 supervised real PCs remain the only valid perf evidence.
- Zero-risk: hypervisor + licensing + network + cost + data-upload tradeoffs (violates local-first unless you explicitly opt in per machine).

## Cheapest credible options (you own the account)
1. GitHub Actions `windows-2022` runners: free minutes, clean Win image per run, run Tier0 + selector + DryRun matrix + refusal suite as CI. No perf claims (runner hardware varies), pure safety regression. Needs repo + workflow file.
2. Azure B2s spot (2 vCPU, 4GB, Win10/11 image): ~cents/hour, 1 VM at a time, differencing snapshots, RDP supervised. Needs subscription + Win license compliance + budget cap + explicit consent per run.
3. Local Hyper-V (after VT-x cold-boot verify + admin): free, closest to your hardware, 1 small VM sequential. Still blocked on firmware flag showing False + elevation.

## Recommended order
Local 19-check matrix (done, 19/19) -> GitHub Actions CI safety gate -> 1 Azure clean-room Win10 19045 full-cycle + rollback -> supervised real PCs. Stop and report limits if real PCs unavailable; never substitute cloud FPS for old-PC claims.
