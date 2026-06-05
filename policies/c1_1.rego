package concord.soc2.c1_1

import rego.v1

# SOC 2 C1.1 — confidential data uses customer-managed encryption keys.
# Adapted from: Prowler `s3_bucket_kms_encryption`, `rds_instance_storage_encrypted_kms`,
# `dynamodb_tables_kms_cmk_encryption_enabled`.
# input.aws_encryption.{buckets,rds_instances,dynamodb_tables} each carry an
# `encryption: {type, kms_key_id, customer_managed}` block.

deny contains msg if {
    not input.aws_encryption
    msg := "no encryption evidence collected"
}

deny contains msg if {
    some b in input.aws_encryption.buckets
    b.confidential
    not b.encryption.customer_managed
    msg := sprintf("confidential bucket %q encrypted with an AWS-managed key (CMK required for C1.1)", [b.name])
}

deny contains msg if {
    some r in input.aws_encryption.rds_instances
    r.confidential
    not r.encryption.customer_managed
    msg := sprintf("confidential RDS instance %q encrypted with an AWS-managed key", [r.identifier])
}

deny contains msg if {
    some t in input.aws_encryption.dynamodb_tables
    t.confidential
    not t.encryption.customer_managed
    msg := sprintf("confidential DynamoDB table %q encrypted with an AWS-managed key", [t.name])
}

warn contains msg if {
    some b in input.aws_encryption.buckets
    not b.confidential
    not b.encryption.configured
    msg := sprintf("non-confidential bucket %q has no encryption — consider enabling SSE-S3 as a baseline", [b.name])
}
