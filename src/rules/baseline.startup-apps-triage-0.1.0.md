# Rule: baseline.startup-apps-triage v0.1.0 — DRAFT, NOT ENABLED
# Status: proposed. Needs lab test + review before limited release.
id: baseline.startup-apps-triage
version: 0.1.0
title: Disable one non-essential startup app (per-app consent)
goal_tags: [boot-slow, background-overhead]
supported_os: [Windows 10 22H2 build 19045 64-bit]
eligibility:
  - condition: startup entry exists and enabled
    reason: no-op otherwise
  - condition: app not SecurityHealth / antivirus / Intel gfx / system-critical
    reason: never triage security or bring-up
  - condition: Task Manager impact Medium/High OR user marks unneeded at boot
    reason: measurable boot/idle effect plausible
exclude_if:
  - condition: laptop on battery with user needing app on the go
    reason: availability cost
  - condition: app required for uni/work login flow
    reason: avoid breaking day-1 use
evidence: { grade: B, summary: Microsoft Support + Learn boot guidance + HowToGeek multi-run boot delta; FPS claim excluded }
risk: { tier: 1, summary: App still installed, launches manually; boot faster, app starts only when opened }
change: { operations: [disable-startup-entry] }
state: { capture_fields: [location, command, enabled], verify_fields: [enabled] }
rollback: { operations: [restore-startup-entry] }
measurement: { primary_metric: boot-to-ready seconds + Event ID 100, secondary: idle CPU/disk 5-min window }
reboot_required: yes (to measure)
owner: unassigned
last_reviewed: null
status: proposed
