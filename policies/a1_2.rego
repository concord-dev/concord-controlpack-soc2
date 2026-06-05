package concord.soc2.a1_2

import rego.v1

# SOC 2 A1.2 — availability monitoring.
# Adapted from: hub.powerpipe.io/mods/turbot/aws_compliance — soc_2_a_1_2 benchmark.
# input.aws_cloudwatch is the normalized response from the AWS collector:
#   { fetched_at, alarms: [ {name, namespace, metric, state} ],
#     autoscaling_groups: [ {name, min_size, max_size, desired_capacity} ] }

deny contains msg if {
    not input.aws_cloudwatch
    msg := "no CloudWatch evidence collected (AWS collector misconfigured)"
}

deny contains msg if {
    count(input.aws_cloudwatch.alarms) == 0
    msg := "no CloudWatch alarms configured — production workloads need at least saturation alarms (CPU, memory, latency)"
}

deny contains msg if {
    count(input.aws_cloudwatch.autoscaling_groups) == 0
    msg := "no Auto Scaling Groups configured — at least one stateless tier should auto-scale to satisfy A1.2"
}

warn contains msg if {
    some alarm in input.aws_cloudwatch.alarms
    alarm.state == "INSUFFICIENT_DATA"
    msg := sprintf("CloudWatch alarm %q is INSUFFICIENT_DATA — alarm logic may be broken", [alarm.name])
}

warn contains msg if {
    some asg in input.aws_cloudwatch.autoscaling_groups
    asg.min_size == asg.max_size
    msg := sprintf("ASG %q has min==max — effectively a fixed-size group, not auto-scaling", [asg.name])
}
