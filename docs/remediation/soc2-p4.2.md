# Personal-data stores have lifecycle policies and write-protection

`SOC2-P4.2` · framework **soc2** · severity **high** · Privacy

## What this control checks

SOC 2 P4.2 requires the entity to dispose of personal information when
no longer needed. The operational form is: every bucket tagged
`pii=true` has an S3 lifecycle rule that expires objects (so deletion
is policy-driven, not manual), and object lock is configured to prevent
pre-retention destruction.

## Why it matters

Manual deletion misses things; lifecycle rules force a documented
retention window. Object lock prevents the deletion-window itself
from being abused. Together they map cleanly to "personal data is
disposed of on a schedule, not ad-hoc."

## Evidence

Collected from the `aws` source (`s3_lifecycle` evidence type).

## What a failure looks like

This control reports a finding when any of the following hold:

- no S3 storage evidence collected
- PII bucket <value> has no lifecycle policy — personal data cannot be disposed on schedule
- PII bucket <value> lifecycle policy has no expiration rule
- PII bucket <value> has no object-lock — destruction window can be bypassed

## Remediation

Bring each affected resource or attestation listed under *What a failure looks like* into compliance, then re-collect evidence. Estimated effort: **4h**. Automated fix available: **false**.

## How to re-verify

```
concord check --controls <pack>/controls --framework soc2 --control-id SOC2-P4.2
```

A passing run reports this control green; in CI, `concord gate` exits non-zero while it fails.

## Cross-framework mappings

```
  gdpr:
  - "Art.5(1)(e)"
  - "Art.17"
  iso27001:
  - "A.8.10"
```
