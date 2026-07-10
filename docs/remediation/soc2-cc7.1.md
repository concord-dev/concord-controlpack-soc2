# No unpatched critical or high vulnerabilities present in the codebase

`SOC2-CC7.1` · framework **soc2** · severity **high** · System Operations

## What this control checks

SOC 2 CC7.1 requires vulnerabilities to be identified and remediated
on a documented cadence. Concord enforces a zero-tolerance default
for CRITICAL severity vulnerabilities and a configurable HIGH ceiling.

Production usage:
  1. Add to CI before `concord check`:
       trivy fs --format json --output .concord/trivy.json .
  2. Export CONCORD_TRIVY_REPORT=$PWD/.concord/trivy.json
  3. concord check

Defaults can be tightened or loosened per-repo via concord.yaml:
  controls:
    params:
      SOC2-CC7.1:
        max_critical: 0    # zero tolerance for critical
        max_high: 5        # allow up to 5 high vulns
        warn_on_fixable: true

## Why it matters

Trivy's open-source filesystem scan is the cheapest viable evidence
for CC7.1. The control proves three things to an auditor: (1) you
are actively scanning, (2) the scan is recent, and (3) you remediate
above the threshold you declared in your security policy. Concord
ships the threshold as a Rego constant so the policy itself is the
audit evidence — no separate "security policy doc" required.

## Evidence

Collected from the `file` source (`trivy_report` evidence type).

## What a failure looks like

This control reports a finding when any of the following hold:

- no Trivy scan evidence collected
- Trivy report has no Results array — scan likely failed or produced empty output
- <value> CRITICAL vulnerabilities present (threshold: <value>) — see warnings for fix paths
- <value> HIGH vulnerabilities present (threshold: <value>)
- [<value>] <value> in <value>@<value> — upgrade to <value>
- [<value>] <value> in <value> has no fix available yet — document exception or apply workaround

## Remediation

Bring each affected resource or attestation listed under *What a failure looks like* into compliance, then re-collect evidence. Estimated effort: **variable**. Automated fix available: **false**.

## How to re-verify

```
concord check --controls <pack>/controls --framework soc2 --control-id SOC2-CC7.1
```

A passing run reports this control green; in CI, `concord gate` exits non-zero while it fails.

## Cross-framework mappings

```
  iso27001:
  - "A.8.8"
  - "A.8.29"
  nist_csf:
  - "DE.CM-8"
  - "RS.MI-3"
  cis_controls:
  - "7.1"
  - "7.5"
  nist_800_53:
  - "RA-5"
  - "SI-2"
```
