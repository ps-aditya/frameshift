# Rule: baseline.visual-effects-triage v0.1.0 — DRAFT, NOT ENABLED
# Status: proposed. Capture design only; no executor yet.
id: baseline.visual-effects-triage
version: 0.1.0
title: Per-setting visual-effects adjustment (captured, reversible)
observed_this_pc:
  VisualEffects_key: absent (defaults active — must capture as absent, not assume)
  Advanced: { TaskbarAnimations: 1, ListviewAlphaSelect: 1 }
  Desktop: { DragFullWindows: 1, FontSmoothing: 2, UserPreferencesMask: present-binary }
capture_design: record each value or absence separately; UserPreferencesMask as full byte array
change: one named setting at a time via SystemPropertiesPerformance path equivalent, never blanket registry wipe
verify: re-read same keys
rollback: restore exact values or delete keys created by us if originally absent
metric: window reopen + drag responsiveness Likert, NOT FPS
gate: executor only after capture round-trip test on this box
