# A current risk register documents each identified risk with owner, severity, and mitigation

`SOC2-CC9.2` · framework **soc2** · severity **high** · Risk Mitigation

## What this control checks

SOC 2 CC9.2 requires a documented process for identifying, assessing,
and responding to risks. The operational artifact every auditor
expects is a risk register. Concord checks for markdown files at
docs/risk-register/*.md with required frontmatter: title, severity,
owner, mitigation_status (one of: open, mitigated, accepted,
transferred), and reviewed_at (within the freshness window).

## Why it matters

Risk registers in spreadsheets rot — they become snapshots from the
last audit cycle, disconnected from the systems they describe. Git-
versioned markdown registers carry diff history, blame, and PR
review for free, and Concord can verify their freshness without
out-of-band reminders to the security team.

## Evidence

Collected from the `github` source (`file_glob` evidence type).

## What a failure looks like

This control reports a finding when any of the following hold:

- no risk register evidence collected
- risk register is empty — at least one identified risk required for SOC 2 CC9.2 evidence
- risk register entry <value> is missing required field <value>
- risk register entry <value> has invalid mitigation_status <value> (must be open|mitigated|accepted|transferred)
- risk register entry <value> has invalid severity <value>
- risk register entry <value> has not been reviewed in over <value> days
- risk register entry <value> is <value> severity and still open — schedule treatment

## Remediation

Bring each affected resource or attestation listed under *What a failure looks like* into compliance, then re-collect evidence. Estimated effort: **1d**. Automated fix available: **false**.

## How to re-verify

```
concord check --controls <pack>/controls --framework soc2 --control-id SOC2-CC9.2
```

A passing run reports this control green; in CI, `concord gate` exits non-zero while it fails.

## Cross-framework mappings

```
  iso27001:
  - "A.5.7"
  - "A.5.8"
  nist_csf:
  - "ID.RA-1"
  - "ID.RA-5"
  - "ID.RA-6"
  nist_800_53:
  - "RA-3"
  - "PM-9"
```
