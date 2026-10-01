# 01 — Product Brief

## Working title
**FrameShift** (temporary codename; naming clearance not performed).

## One-line description
A personalized Windows PC optimization assistant that safely applies and measures targeted fixes so people can get more from hardware they cannot yet replace.

## Problem
People using older or low-end PCs often face stuttering, slow startup, high background resource use, or inconsistent game performance. Existing advice is fragmented across long videos, forum posts, scripts and generic “optimizer” tools. Users must guess which advice applies to their exact PC and may not understand the risks or how to undo a change.

## Target user
A person with an older or constrained Windows PC who:
- needs better performance for games or everyday use;
- may not be able to buy new hardware;
- does not want to spend hours learning system internals or trying random tweaks;
- needs a low-friction tool they can download and trust.

## Job to be done
“When my PC struggles, help me identify and safely apply changes that suit my machine, prove whether they helped, and let me undo them.”

## Promise
**Personalized optimization, measured results, and a way back.** The product must not promise that software can overcome hard hardware limits.

## Differentiation hypothesis
Not the largest tweak library. The differentiator is a conservative decision engine that selects an intervention based on system facts and the user's goal, explains the trade-off, verifies the result, and rolls back when needed.

## Product pillars
- **Profile:** hardware, OS, drivers and relevant settings.
- **Diagnose:** connect the user's stated symptom to measurable evidence.
- **Select:** match only compatible rules with an evidence grade.
- **Apply:** show the exact proposed change and obtain consent.
- **Verify:** compare matched before/after measurements.
- **Recover:** store prior values and support reliable rollback.
- **Explain:** plain-language reasons, uncertainty and limitations.

## Non-goals for the first release
- “One click makes every PC faster.”
- Universal FPS guarantees or percentage claims without test evidence.
- AI-generated shell commands executed on the user's machine.
- Mass removal of Windows apps/services.
- Driver replacement, BIOS/firmware changes, overclocking, undervolting, voltage changes, or third-party driver packs.
- Disabling Defender, firewall, Windows Update, backups, restore mechanisms, accessibility features, audio, printing or networking.
- Cloud account requirement or uploading detailed system inventory by default.
- Supporting every Windows version, game and hardware combination at launch.

## Success definition
A first-time user can understand the recommended action, consent to it, see a credible result (including “no measurable improvement”), and reverse the change without needing to understand Windows internals.

## Risks
1. Tweaks may have no effect or regress performance.
2. Results vary with drivers, games, thermal state, power mode and background load.
3. “Optimizer” products are distrusted because of aggressive or opaque behavior.
4. Administrative privileges and system mutation raise security and support burdens.
5. Benchmark noise can be mistaken for a real improvement.
6. Windows versions and vendor drivers change; rules can become stale.
