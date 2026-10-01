# 04 — Proposed Architecture

## Architectural principle
Deterministic, rule-based system mutation. AI may eventually help explain findings or summarize trusted documentation, but it must not invent and execute system commands.

## Components
1. **Desktop UI**
   - onboarding, goal selection, findings, consent, progress, result and rollback controls.
2. **Inventory collector (read-only)**
   - queries a narrow allowlist of Windows APIs/commands;
   - normalizes OS/hardware/settings facts into a typed local profile;
   - labels unavailable or uncertain values rather than guessing.
3. **Rule engine**
   - evaluates versioned eligibility predicates;
   - produces eligible/ineligible/not-enough-data decisions and reasons;
   - never executes rules supplied by remote content.
4. **Change executor**
   - handles only reviewed operations exposed by typed rule implementations;
   - requests elevation only for the specific action requiring it;
   - validates preconditions immediately before mutation.
5. **State journal**
   - stores prior values, intended operations, timestamps, rule/version identifiers, operation status and verification results;
   - stores no secrets.
6. **Verifier**
   - checks whether the desired state was reached and whether unexpected state changed.
7. **Benchmark harness**
   - runs a fixed, documented workload where supported;
   - records conditions, repetitions and raw observations.
8. **Report/export**
   - local human-readable report; explicit user action required to share it.

## Suggested implementation direction
Start with a Windows-native stack rather than selecting technology by fashion. Evaluate C#/.NET with WinUI 3 or WPF for native Windows APIs and installer/elevation integration. Keep the rule model and benchmark logic independent of the UI so they can be tested. PowerShell can be useful during prototyping, but do not ship a giant script as the security boundary.

## Data flow
Profile (read-only) → user goal → rule eligibility → recommendation preview → explicit consent → precondition re-check → journal original state → apply typed operation → verify → benchmark → report → optional rollback.

## Rule interface (conceptual)
- `id`, `version`, `title`, `description`
- `supported_os`, `hardware_predicates`, `workload_predicates`
- `preconditions`, `expected_mechanism`, `evidence_grade`
- `risk_level`, `user_visible_changes`, `reboot_required`
- `capture_state()`, `apply()`, `verify()`, `rollback()`
- `tests`, `known_limitations`, `source_links`, `last_reviewed`

## Failure handling
- If inventory is incomplete: do not apply.
- If preconditions changed since recommendation: cancel and re-evaluate.
- If state capture fails: do not mutate.
- If apply partially fails: attempt rule-specific rollback, then report exact status.
- If verification fails: do not claim success; offer rollback.
- If benchmark is noisy: mark inconclusive, not improved.
- If the app crashes: on next launch inspect the journal and offer recovery options; never blindly replay a mutation.

## Suggested storage
Use a small local database or versioned JSON journal with restrictive file permissions. Design a migration/versioning strategy before relying on persistent state. Keep original state records distinct from benchmark logs.
