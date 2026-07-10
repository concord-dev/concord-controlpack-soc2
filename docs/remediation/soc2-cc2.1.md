# Required information-security policies are published, approved, and current

`SOC2-CC2.1` · framework **soc2** · severity **high** · Communication and Information

## What this control checks

SOC 2 CC2.1 requires the organization to communicate internally
the information needed to support the functioning of internal
control. Concord enforces the core operational artifact: a set of
Git-tracked markdown policies under docs/policies/, each declaring
policy_name, approved_by, approved_at, and last_reviewed_at in
frontmatter. By default the required policy set is: information-
security, acceptable-use, data-protection, access-control.

## Why it matters

Auditors do not accept "we have policies" without artifacts.
They want: where are they, who approved them, when were they last
reviewed, and how are they communicated. Git-versioned markdown
answers all four in one place: blame shows authorship, PR shows
approval, diff history shows review cadence, and the repo itself
is the communication channel for engineers.

## Evidence

Collected from the `github` source (`file_glob` evidence type).

## What a failure looks like

This control reports a finding when any of the following hold:

- no policy evidence collected
- required policy <value> is missing from docs/policies/
- policy <value> is missing required field <value>
- policy <value> has not been reviewed in over <value> days
- policy <value> has no version field (recommended for change history)

## Remediation

Bring each affected resource or attestation listed under *What a failure looks like* into compliance, then re-collect evidence. Estimated effort: **1w**. Automated fix available: **false**.

## How to re-verify

```
concord check --controls <pack>/controls --framework soc2 --control-id SOC2-CC2.1
```

A passing run reports this control green; in CI, `concord gate` exits non-zero while it fails.

## Cross-framework mappings

```
  iso27001:
  - "A.5.1"
  - "A.5.2"
  nist_csf:
  - "GV.PO-1"
  - "GV.PO-2"
  nist_800_53:
  - "PL-1"
  - "AC-1"
```
