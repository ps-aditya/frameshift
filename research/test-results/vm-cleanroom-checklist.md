# VM clean-room checklist (FrameShiftookie cut: 19045 only, one VM at a time)

## Host gates (you)
- [ ] Full shutdown (hold Shift + Shutdown to beat fast-startup), power on, VT-x re-check reads True
- [ ] Explicit admin OK for Hyper-V setup (elevation prompt accepted by you, never silent)
- [ ] Win10 22H2 ISO downloaded by you from Microsoft (~6GB) + path shared; ~40GB free confirmed

## Build (supervised)
- [ ] Run New-CleanRoomVM.ps1 elevated with -IsoPath; pre-install checkpoint taken
- [ ] Install Win10, take 'clean-installed' checkpoint (rollback for whole VM)
- [ ] Install 6 bloat startup apps to repro slow boot (Spotify, Steam, Epic, Edge auto, Acrobat, Notion)

## Test (same journal gate as host)
- [ ] Tier0 inventory + selector DryRun + explainer read to console
- [ ] 3x boot baseline (Event 100 readable as admin here)
- [ ] ONE startup disable with journal, verify, 3x post, rollback-verified
- [ ] Verdict per protocol (Improvement / No-difference / Inconclusive) — cloud-free, host HW closest available

## Limits
- SSD-backed VHDX cannot repro HDD 100%-disk; do not claim it. One VM at a time on 2C/10GB or host contention poisons numbers.
