# A risk-assessment methodology is documented with owner, cadence, and last review

`SOC2-CC3.1` · framework **soc2** · severity **high** · Risk Assessment

## What this control checks

SOC 2 CC3.1 requires the organization to specify objectives with
sufficient clarity to enable the identification and assessment of
risks. Concord enforces a documented methodology at
docs/policies/risk-assessment-process.md describing the process
owner, methodology (qualitative / quantitative / hybrid), review
cadence, and last review date. This methodology is what the risk
register (CC9.2) is *output of* — auditors check both the artifact
and the process that produces it.

## Why it matters

A risk register without a documented process behind it is
suspicious to an auditor — it suggests risks were enumerated
once and never re-evaluated as the system, threat model, or
organization changed. Forcing the methodology to be a versioned
artifact ensures the process gets reviewed alongside the
register itself.

## Evidence

Collected from the `github` source (`file_glob` evidence type).

## What a failure looks like

This control reports a finding when any of the following hold:

- no risk-assessment-process evidence collected
- no risk-assessment process documented at docs/policies/risk-assessment-process.md
- risk-assessment process <value> is missing required field <value>
- risk-assessment process <value> declares invalid methodology <value> (must be qualitative|quantitative|hybrid)
- risk-assessment process <value> has not been reviewed in over <value> days
- risk-assessment process <value> has no rating_scale field (recommended for consistent severity scoring)

## Remediation

Bring each affected resource or attestation listed under *What a failure looks like* into compliance, then re-collect evidence. Estimated effort: **1d**. Automated fix available: **false**.

## How to re-verify

```
concord check --controls <pack>/controls --framework soc2 --control-id SOC2-CC3.1
```

A passing run reports this control green; in CI, `concord gate` exits non-zero while it fails.

## Cross-framework mappings

```
  iso27001:
  - "A.5.4"
  - "A.5.7"
  nist_csf:
  - "ID.RA-1"
  - "ID.RA-3"
  - "ID.RM-1"
  nist_800_53:
  - "RA-1"
  - "RA-3"
  - "PM-9"
```
