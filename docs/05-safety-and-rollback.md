# 05 — Safety and Rollback Contract

## User trust contract
FrameShift must never silently make consequential system changes. It must explain the change, why it is eligible, what might go wrong, whether restart is needed, and how to undo it.

## Risk tiers
- **Tier 0 — Read-only:** inventory and measurement. No elevation unless unavoidable.
- **Tier 1 — Low-risk reversible preference:** narrowly scoped user-level setting with verified restoration.
- **Tier 2 — System-wide reversible change:** requires elevated privilege, explicit preview/consent, state capture and tested rollback.
- **Tier 3 — High-impact or uncertain:** services, broad app removal, security settings, boot configuration, drivers, firmware, kernel tools, power/voltage controls. Out of MVP.

Risk tier is not a guarantee. Every individual rule still requires review.

## Mandatory transaction lifecycle
1. Validate support and preconditions.
2. Show proposed change, risk and rollback path.
3. Obtain explicit consent.
4. Re-read current state to avoid stale assumptions.
5. Capture original state and persist journal.
6. Apply only typed, allowlisted operations.
7. Verify postconditions.
8. Record outcome.
9. If verification fails, offer/perform rule-specific rollback when safe.
10. Keep the user informed; never claim recovery until verified.

## Rollback requirements
- Store exact original values, not assumed defaults.
- Track each operation independently.
- Be idempotent where possible.
- Do not overwrite a value changed by the user or another app after FrameShift's action without warning and consent.
- Test rollback after app crash, partial failure, reboot, and app upgrade.
- Distinguish “rollback attempted” from “rollback verified”.
- Provide manual recovery instructions for any scenario the app cannot safely reverse.
- Windows System Restore may be unavailable or disabled; do not promise a restore point always exists or treat it as a substitute for rule-level rollback.

## Forbidden behavior
- No disabling Defender/firewall/Windows Update or reducing OS security.
- No arbitrary command execution from an LLM, website, plugin, or remote configuration.
- No hidden admin elevation, persistence, or silent changes.
- No mass deletion of user data, application packages, caches or system files.
- No bypassing UAC.
- No “apply all” action that conceals individual changes.
- No claim that a change is safe merely because a restore point was requested.

## Safety review checklist per rule
- Exact target and prior value capture
- OS/build and hardware compatibility
- User impact and failure modes
- Source/evidence review
- Apply tests
- Verify tests
- Rollback tests
- Partial-failure tests
- Admin requirement
- Reboot requirement
- Benchmark protocol
- Clear UI wording
- Security/privacy review
- Owner and review date
