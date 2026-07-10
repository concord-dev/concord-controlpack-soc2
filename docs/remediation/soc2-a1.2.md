# Production AWS workloads have CloudWatch alarms and auto-scaling configured

`SOC2-A1.2` · framework **soc2** · severity **high** · Availability

## What this control checks

SOC 2 Availability A1.2 requires the entity to monitor system performance
and capacity, and to authorize and use system components based on
capacity demand. The operational form auditors look for is: critical
services have CloudWatch alarms on saturation metrics, and auto-scaling
groups exist for stateless tiers.

## Why it matters

Without alarms, capacity exhaustion shows up as customer impact. Without
auto-scaling, recovery from a spike requires manual intervention — which
is incompatible with the availability commitments most SOC 2 reports
list in section IV.

## Evidence

Collected from the `aws` source (`cloudwatch_alarms` evidence type).

## What a failure looks like

This control reports a finding when any of the following hold:

- no CloudWatch evidence collected (AWS collector misconfigured)
- no CloudWatch alarms configured — production workloads need at least saturation alarms (CPU, memory, latency)
- no Auto Scaling Groups configured — at least one stateless tier should auto-scale to satisfy A1.2
- CloudWatch alarm <value> is INSUFFICIENT_DATA — alarm logic may be broken
- ASG <value> has min==max — effectively a fixed-size group, not auto-scaling

## Remediation

Bring each affected resource or attestation listed under *What a failure looks like* into compliance, then re-collect evidence. Estimated effort: **4h**. Automated fix available: **false**.

## How to re-verify

```
concord check --controls <pack>/controls --framework soc2 --control-id SOC2-A1.2
```

A passing run reports this control green; in CI, `concord gate` exits non-zero while it fails.

## Cross-framework mappings

```
  iso27001:
  - "A.8.6"
  - "A.8.16"
  nist_csf:
  - "DE.CM-1"
  - "DE.AE-3"
```
