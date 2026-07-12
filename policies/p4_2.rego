package concord.soc2.p4_2

import rego.v1

# SOC 2 P4.2 — personal-data disposal via lifecycle policies.
# Adapted from: Prowler `s3_bucket_lifecycle_enabled`, `s3_bucket_object_lock`.
# input.aws_storage.buckets[] each carry tags, lifecycle, object_lock.

deny contains msg if {
    not input.aws_storage
    msg := "no S3 storage evidence collected"
}

deny contains msg if {
    some b in input.aws_storage.buckets
    is_pii(b)
    not b.lifecycle.enabled
    msg := sprintf("PII bucket %q has no lifecycle policy — personal data cannot be disposed on schedule", [b.name])
}

deny contains msg if {
    some b in input.aws_storage.buckets
    is_pii(b)
    b.lifecycle.enabled
    not has_expiration_rule(b)
    msg := sprintf("PII bucket %q lifecycle policy has no expiration rule", [b.name])
}

warn contains msg if {
    some b in input.aws_storage.buckets
    is_pii(b)
    not b.object_lock.enabled
    msg := sprintf("PII bucket %q has no object-lock — destruction window can be bypassed", [b.name])
}

# doc 31 §4 — no fail-open tag gates: a resource with no 'pii' tag is neither confirmed in-scope
# nor out-of-scope, so every deny above skips it and it would pass silently.
# Warn on the unclassified resource instead of ignoring it.

warn contains msg if {
    some resource in input.aws_storage.buckets
    not classified(resource)
    msg := sprintf("S3 bucket %q has no pii tag, so this control's checks did not apply to it — tag pii=true to bring it into PII scope or pii=false to confirm it is out of scope", [resource.name])
}

is_pii(b) if {
    b.tags.pii == "true"
}

has_expiration_rule(b) if {
    some rule in b.lifecycle.rules
    rule.expiration_days > 0
}

classified(resource) if resource.tags.pii == "true"

classified(resource) if resource.tags.pii == "false"
