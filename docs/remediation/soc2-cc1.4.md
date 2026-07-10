# GitHub organization enforces a security baseline (2FA, secret scanning, default permissions)

`SOC2-CC1.4` · framework **soc2** · severity **critical** · Control Environment

## What this control checks

SOC 2 CC1.4 requires the organization to demonstrate a commitment
to attract, develop, and retain competent personnel, supported by
a control environment. For an engineering organization that lives
on GitHub, the operational baseline is org-wide 2FA enforcement
plus repo default permissions that aren't 'admin', plus
Dependabot / secret-scanning enabled on new repos by default.

## Why it matters

These four toggles together kill the most common org-level access
failures: (1) a contractor with no 2FA gets phished, (2) someone
creates a public repo by accident, (3) a developer pastes a secret
into a new repo with no scanning, (4) a new repo inherits admin
permissions for every org member. Concord catches each.

## Evidence

Collected from the `github` source (`org_security_policy` evidence type).

## What a failure looks like

This control reports a finding when any of the following hold:

- no GitHub organization policy evidence collected
- GitHub org does not require two-factor authentication for members
- GitHub org default repository permission is 'admin' (members get admin rights on every repo by default)
- GitHub org default repository permission is 'write' (members can push to every repo by default — consider 'read' with explicit grants)
- secret scanning is NOT enabled by default on new repositories
- secret-scanning push protection is NOT enabled by default on new repositories
- Dependabot alerts are NOT enabled by default on new repositories
- DCO sign-off is not required for web commits (recommended for OSS / contributor identity)

## Remediation

Bring each affected resource or attestation listed under *What a failure looks like* into compliance, then re-collect evidence. Estimated effort: **30m**. Automated fix available: **false**.

## How to re-verify

```
concord check --controls <pack>/controls --framework soc2 --control-id SOC2-CC1.4
```

A passing run reports this control green; in CI, `concord gate` exits non-zero while it fails.

## Cross-framework mappings

```
  iso27001:
  - "A.5.17"
  - "A.5.20"
  nist_csf:
  - "PR.AC-1"
  - "PR.AC-7"
  - "PR.IP-3"
  cis_controls:
  - "6.5"
  - "16.5"
```
