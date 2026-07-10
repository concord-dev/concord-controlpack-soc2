# Public-facing APIs enforce schema validation and rate limiting

`SOC2-PI1.1` · framework **soc2** · severity **medium** · Processing Integrity

## What this control checks

SOC 2 PI1.1 requires the entity to obtain and document policies around
inputs to processing. The machine-checkable form is: every public-facing
API Gateway / ALB-fronted endpoint has request validation enabled and
a usage plan / WAF rule capping requests.

## Why it matters

Unvalidated input is the root cause of most processing-integrity
findings auditors flag (silent type coercion, off-by-one truncation,
JSON-injection). Schema validation + rate limiting are the cheapest
durable controls to point at during a PI1 walkthrough.

## Evidence

Collected from the `aws` source (`api_gateway` evidence type).

## What a failure looks like

This control reports a finding when any of the following hold:

- no API Gateway evidence collected
- public API <value> has no request validation configured
- public API <value> has neither WAF nor a usage plan — unbounded request rate
- API <value> has WAF attached but no rules — effectively a no-op

## Remediation

Bring each affected resource or attestation listed under *What a failure looks like* into compliance, then re-collect evidence. Estimated effort: **1d**. Automated fix available: **false**.

## How to re-verify

```
concord check --controls <pack>/controls --framework soc2 --control-id SOC2-PI1.1
```

A passing run reports this control green; in CI, `concord gate` exits non-zero while it fails.

## Cross-framework mappings

```
  iso27001:
  - "A.8.26"
  nist_csf:
  - "PR.DS-6"
```
