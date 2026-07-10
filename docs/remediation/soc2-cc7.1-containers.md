# Container images carry no unpatched CRITICAL or HIGH CVEs

`SOC2-CC7.1-containers` · framework **soc2** · severity **high** · System Operations

## What this control checks

Container images shipped to production must not carry unpatched
CRITICAL or HIGH vulnerabilities according to Snyk's image scan.
This complements the application-dependency CC7.1 control (Trivy
or Snyk SCA) by covering the base image and OS-package layer.

Production usage:
  1. Connect every production container to Snyk (UI or CLI).
  2. Set SNYK_TOKEN to an org-scoped API token.
  3. Add your Snyk org UUID to the env (or hard-code into params).
  4. concord check

Defaults can be tightened or loosened per-repo via concord.yaml:
  controls:
    params:
      SOC2-CC7.1-containers:
        max_critical: 0      # zero tolerance for critical CVEs
        max_high: 0          # zero tolerance for high CVEs in prod
        warn_only_targets:   # treat these as warn, not deny
          - "staging/*"

## Why it matters

Snyk's container product surfaces the same severity ranking as its
SCA product, so the policy reuses the org_issues thresholds verbatim
— just scoped to scan items of type=container_image. Per-image
project metadata is preserved so the deny message tells the on-call
engineer exactly which image is failing.

## Evidence

Collected from the `snyk` source (`container_issues` evidence type).

## What a failure looks like

This control reports a finding when any of the following hold:

- no Snyk container_issues evidence collected
- <value> CRITICAL container issue(s) open (threshold: <value>) — see warnings for affected images
- <value> HIGH container issue(s) open (threshold: <value>)
- [<value>] <value> in image <value> (<value>) — rebuild with patched base
- [<value>] <value> in image <value> has no fix yet — pin a workaround or accept the risk

## Remediation

Bring each affected resource or attestation listed under *What a failure looks like* into compliance, then re-collect evidence. Estimated effort: **variable**. Automated fix available: **false**.

## How to re-verify

```
concord check --controls <pack>/controls --framework soc2 --control-id SOC2-CC7.1-containers
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
  - "7.5"
  - "7.7"
  nist_800_53:
  - "RA-5"
  - "SI-2"
```
