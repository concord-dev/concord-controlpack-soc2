# Confidential data stores have encryption-at-rest with customer-managed keys

`SOC2-C1.1` · framework **soc2** · severity **high** · Confidentiality

## What this control checks

SOC 2 C1.1 requires the entity to identify and maintain confidential
information consistently with confidentiality commitments. The
machine-checkable form: confidential S3 buckets / RDS / DynamoDB
use customer-managed KMS keys (not AWS-managed defaults), so key
rotation and revocation are within the org's control.

## Why it matters

AWS-managed keys (aws/s3, aws/rds) are operationally convenient but
rotate on AWS's schedule and cannot be revoked by the customer in a
breach. Customer-managed keys (CMKs) make C1.1 demonstrable.

## Evidence

Collected from the `aws` source (`storage_encryption` evidence type).

## What a failure looks like

This control reports a finding when any of the following hold:

- no encryption evidence collected
- confidential bucket <value> encrypted with an AWS-managed key (CMK required for C1.1)
- confidential RDS instance <value> encrypted with an AWS-managed key
- confidential DynamoDB table <value> encrypted with an AWS-managed key
- non-confidential bucket <value> has no encryption — consider enabling SSE-S3 as a baseline

## Remediation

Bring each affected resource or attestation listed under *What a failure looks like* into compliance, then re-collect evidence. Estimated effort: **8h**. Automated fix available: **false**.

## How to re-verify

```
concord check --controls <pack>/controls --framework soc2 --control-id SOC2-C1.1
```

A passing run reports this control green; in CI, `concord gate` exits non-zero while it fails.

## Cross-framework mappings

```
  iso27001:
  - "A.8.24"
  - "A.5.34"
  nist_csf:
  - "PR.DS-1"
```
