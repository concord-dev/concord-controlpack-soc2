# A documented monitoring strategy describes alerts, owners, and review cadence

`SOC2-CC4.1` · framework **soc2** · severity **high** · Monitoring Activities

## What this control checks

SOC 2 CC4.1 requires the organization to select, develop, and
perform ongoing evaluations of its controls. Concord enforces the
operational artifact: a Git-tracked monitoring strategy doc that
declares what is monitored, who owns each alert class, the review
cadence, and how alert quality is measured (false-positive rate,
mean-time-to-acknowledge).

## Why it matters

"We have monitoring" is not evidence. A strategy doc forces three
questions auditors care about: (1) is everything important
monitored, (2) are alerts routed to humans who can act on them,
(3) is alert quality reviewed so monitoring stays effective rather
than becoming background noise.

## Evidence

Collected from the `github` source (`file_glob` evidence type).

## What a failure looks like

This control reports a finding when any of the following hold:

- no monitoring-strategy evidence collected
- no monitoring strategy doc found under docs/monitoring/
- monitoring strategy <value> is missing required field <value>
- monitoring strategy <value> has not been reviewed in over <value> days
- monitoring strategy <value> has no alert_quality_review field — recommend tracking FP rate and MTTA

## Remediation

Bring each affected resource or attestation listed under *What a failure looks like* into compliance, then re-collect evidence. Estimated effort: **1d**. Automated fix available: **false**.

## How to re-verify

```
concord check --controls <pack>/controls --framework soc2 --control-id SOC2-CC4.1
```

A passing run reports this control green; in CI, `concord gate` exits non-zero while it fails.

## Cross-framework mappings

```
  iso27001:
  - "A.8.16"
  nist_csf:
  - "DE.CM-1"
  - "DE.AE-2"
  - "DE.DP-5"
  nist_800_53:
  - "CA-7"
  - "AU-6"
```
