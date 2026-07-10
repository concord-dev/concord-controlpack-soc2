# Periodic access reviews are documented and current

`SOC2-CC6.2` · framework **soc2** · severity **high** · Logical Access

## What this control checks

SOC 2 CC6.2 requires the organization to authorize access and to
periodically review that access is still appropriate. Concord
enforces the operational artifact: a markdown file under
docs/access-reviews/<period>.md per review cycle, with reviewer,
scope, summary, and reviewed_at frontmatter. The most recent file
must be no older than 90 days by default — tighten in concord.yaml
if your policy demands quarterly or monthly.

## Why it matters

Auditors do not accept "we reviewed access in our heads last week."
They want artifacts: who reviewed, what scope (production AWS,
SaaS admins, customer data access), and what changed. Git-tracked
markdown is the cheapest, most auditable form because the diff
history proves "we actually changed access based on the review."

## Evidence

Collected from the `github` source (`file_glob` evidence type).

## What a failure looks like

This control reports a finding when any of the following hold:

- no access-review evidence collected
- no access-review documents found under docs/access-reviews/
- access-review <value> is missing required field <value>
- most recent access-review is <value> days old (max <value>) — schedule the next review cycle
- access-review <value> has no summary section (recommended)

## Remediation

Bring each affected resource or attestation listed under *What a failure looks like* into compliance, then re-collect evidence. Estimated effort: **4h**. Automated fix available: **false**.

## How to re-verify

```
concord check --controls <pack>/controls --framework soc2 --control-id SOC2-CC6.2
```

A passing run reports this control green; in CI, `concord gate` exits non-zero while it fails.

## Cross-framework mappings

```
  iso27001:
  - "A.5.18"
  - "A.5.19"
  nist_csf:
  - "PR.AC-4"
  - "PR.AC-6"
  nist_800_53:
  - "AC-2(7)"
  - "AC-6(7)"
```
