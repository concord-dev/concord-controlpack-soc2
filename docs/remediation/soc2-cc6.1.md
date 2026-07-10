# Every active identity-provider user has strong MFA enrolled

`SOC2-CC6.1` · framework **soc2** · severity **critical** · Logical Access

## What this control checks

SOC 2 CC6.1 requires logical-access security measures appropriate
to the data being protected. For modern SaaS organizations, the
operational form of CC6.1 every auditor expects is "all employees
authenticate via SSO with MFA enforced." Concord queries the
identity provider (Okta in v0) for every ACTIVE user, fetches
each user's enrolled factors, and fails the control if any user
relies solely on SMS, voice, email, or security questions —
factors that are well-documented as bypassable.

## Why it matters

A single user without strong MFA is enough to make CC6.1 fail
audit. Worse, the operational risk is concrete — SIM-swap and
voice-phishing attacks against single-factor or SMS-only accounts
are the most common cause of B2B SaaS breaches. Strong MFA means
TOTP, push, WebAuthn/FIDO2, or hardware token.

## Evidence

Collected from the `okta` source (`users_mfa` evidence type).

## What a failure looks like

This control reports a finding when any of the following hold:

- no Okta evidence collected
- active user <value> has no strong MFA factor enrolled (TOTP, push, WebAuthn, or hardware token required)
- user <value> has only one strong MFA factor (two recommended for device-loss redundancy)
- user <value> still has weak factors (SMS/call/email) enrolled alongside strong MFA — remove to prevent phishing-fallback

## Remediation

Bring each affected resource or attestation listed under *What a failure looks like* into compliance, then re-collect evidence. Estimated effort: **1h**. Automated fix available: **false**.

## How to re-verify

```
concord check --controls <pack>/controls --framework soc2 --control-id SOC2-CC6.1
```

A passing run reports this control green; in CI, `concord gate` exits non-zero while it fails.

## Cross-framework mappings

```
  iso27001:
  - "A.5.17"
  - "A.5.18"
  nist_csf:
  - "PR.AC-1"
  - "PR.AC-7"
  cis_controls:
  - "6.3"
  - "6.4"
  nist_800_53:
  - "IA-2(1)"
  - "IA-2(2)"
```
