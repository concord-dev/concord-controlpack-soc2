# An incident response runbook exists, names an on-call owner, and was reviewed within the last year

`SOC2-CC7.2` · framework **soc2** · severity **high** · System Operations

## What this control checks

SOC 2 CC7.2–CC7.5 require the organization to monitor system
components, detect anomalies, and respond to security incidents.
Concord enforces the foundational artifact: a Git-versioned IR
runbook at docs/incident-response/*.md naming severity levels,
escalation path, and on-call owner. Without a current runbook,
every incident becomes a fire-drill — and every auditor's CC7
question becomes a multi-week scramble.

## Why it matters

Incidents are stress events; the runbook is what people actually
open in those moments. Auditors check three things: does it exist,
is it current (reviewed within ~12 months), and does it name a
human on-call owner. Concord validates all three from the YAML
frontmatter of the runbook files themselves.

## Evidence

Collected from the `github` source (`file_glob` evidence type).

## What a failure looks like

This control reports a finding when any of the following hold:

- no incident-response runbook evidence collected
- no incident-response runbook found under docs/incident-response/
- IR runbook <value> is missing required field <value>
- IR runbook <value> has not been reviewed in over <value> days
- IR runbook <value> has no communication_plan section (recommended for customer notification)
- IR runbook <value> has no post_mortem_template reference (recommended)

## Remediation

Bring each affected resource or attestation listed under *What a failure looks like* into compliance, then re-collect evidence. Estimated effort: **1d**. Automated fix available: **false**.

## How to re-verify

```
concord check --controls <pack>/controls --framework soc2 --control-id SOC2-CC7.2
```

A passing run reports this control green; in CI, `concord gate` exits non-zero while it fails.

## Cross-framework mappings

```
  iso27001:
  - "A.5.24"
  - "A.5.25"
  - "A.5.26"
  nist_csf:
  - "RS.RP-1"
  - "RS.CO-1"
  - "RS.AN-1"
  nist_800_53:
  - "IR-1"
  - "IR-4"
  - "IR-8"
```
