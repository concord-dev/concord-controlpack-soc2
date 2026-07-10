# A control-activities register documents each implemented control with owner and review status

`SOC2-CC5.1` · framework **soc2** · severity **high** · Control Activities

## What this control checks

SOC 2 CC5.1 requires the organization to select and develop control
activities that contribute to the mitigation of risks. Concord
enforces a register of those activities: one markdown file per
activity at docs/control-activities/<name>.md, declaring control_id
(mapping to a SOC 2 / ISO 27001 / NIST control), owner, status
(implemented, planned, ad_hoc, deprecated), and last_audited_at.

## Why it matters

The register is the gap-analysis tool an auditor uses to scope an
engagement. Without it, the conversation degenerates to "what
controls do you have?" — and the answer is invariably "let me get
back to you." A Git-tracked register makes that question
answerable in 30 seconds and provides immediate evidence for
every other CC question.

## Evidence

Collected from the `github` source (`file_glob` evidence type).

## What a failure looks like

This control reports a finding when any of the following hold:

- no control-activities register evidence collected
- control-activities register has <value> entries; minimum is <value>
- control register entry <value> is missing required field <value>
- control register entry <value> has invalid status <value> (must be implemented|planned|ad_hoc|deprecated)
- control register entry <value> was last audited over <value> days ago
- control register entry <value> is still planned (not implemented) — confirm a target date
- control register entry <value> is ad_hoc — consider formalizing for audit

## Remediation

Bring each affected resource or attestation listed under *What a failure looks like* into compliance, then re-collect evidence. Estimated effort: **1w**. Automated fix available: **false**.

## How to re-verify

```
concord check --controls <pack>/controls --framework soc2 --control-id SOC2-CC5.1
```

A passing run reports this control green; in CI, `concord gate` exits non-zero while it fails.

## Cross-framework mappings

```
  iso27001:
  - "A.5.7"
  - "A.5.36"
  nist_csf:
  - "GV.PO-1"
  - "ID.GV-1"
  nist_800_53:
  - "CM-1"
  - "PM-9"
```
