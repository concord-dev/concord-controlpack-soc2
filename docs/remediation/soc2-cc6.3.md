# Deactivated identity-provider users retain no active MFA factors

`SOC2-CC6.3` · framework **soc2** · severity **critical** · Logical Access

## What this control checks

SOC 2 CC6.3 requires authorization, modification, and removal of
access on the basis of role changes and termination. Concord proves
the removal half by checking that every SUSPENDED or DEPROVISIONED
identity-provider user has zero ACTIVE MFA factors. A deprovisioned
user with an active factor is the residual-access leak auditors
care about most — the user technically cannot log in, but a future
re-activation (or a stale session) re-opens the door.

## Why it matters

Termination workflows fail in obvious ways (email never deactivated)
and subtle ways (Okta marks the user DEPROVISIONED but the user's
MFA enrollment still exists, ready to be reused if status is
reverted). Concord's check catches the subtle case automatically.

## Evidence

Collected from the `okta` source (`users_offboarding` evidence type).

## What a failure looks like

This control reports a finding when any of the following hold:

- no Okta offboarding evidence collected
- <value> user <value> still has an ACTIVE <value> factor — remove enrollment
- deprovisioned user <value> retains a non-active <value> factor in record (recommend purge)

## Remediation

Bring each affected resource or attestation listed under *What a failure looks like* into compliance, then re-collect evidence. Estimated effort: **30m**. Automated fix available: **false**.

## How to re-verify

```
concord check --controls <pack>/controls --framework soc2 --control-id SOC2-CC6.3
```

A passing run reports this control green; in CI, `concord gate` exits non-zero while it fails.

## Cross-framework mappings

```
  iso27001:
  - "A.5.17"
  - "A.5.18"
  - "A.6.5"
  nist_csf:
  - "PR.AC-1"
  - "PR.AC-4"
  cis_controls:
  - "5.1"
  - "5.3"
  nist_800_53:
  - "AC-2(13)"
  - "PS-4"
```
