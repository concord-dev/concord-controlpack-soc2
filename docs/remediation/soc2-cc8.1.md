# Default branch is protected and requires reviewed changes

`SOC2-CC8.1` · framework **soc2** · severity **high** · Change Management

## What this control checks

SOC 2 CC8.1 requires that changes to production systems are authorized,
tested, and approved before deployment. For source-controlled systems
this means the default branch must be protected, require pull-request
review by at least one peer, require status checks to pass, and forbid
force-pushes and deletions.

## Why it matters

Without enforced branch protection a single developer can ship to
production unilaterally, defeating segregation of duties and removing
the auditor's evidence chain for code changes.

## Evidence

Collected from the `github` source (`branch_protection` evidence type).

## What a failure looks like

This control reports a finding when any of the following hold:

- no branch protection evidence collected
- default branch <value> is not protected
- default branch <value> does not require pull-request reviews
- default branch requires <value> approving reviews; minimum is <value>
- default branch does not require status checks
- default branch allows force pushes
- default branch allows deletions
- branch protection does not apply to administrators (enforce_admins is off)
- CODEOWNERS review is not required (recommended for high-stakes repos)
- linear history is not enforced (recommended)

## Remediation

Bring each affected resource or attestation listed under *What a failure looks like* into compliance, then re-collect evidence. Estimated effort: **30m**. Automated fix available: **false**.

## How to re-verify

```
concord check --controls <pack>/controls --framework soc2 --control-id SOC2-CC8.1
```

A passing run reports this control green; in CI, `concord gate` exits non-zero while it fails.

## Cross-framework mappings

```
  iso27001:
  - A.8.32
  - A.8.30
  nist_csf:
  - PR.IP-3
  cis_controls:
  - "16.7"
```
