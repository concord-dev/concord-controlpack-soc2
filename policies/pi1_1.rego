package concord.soc2.pi1_1

import rego.v1

# SOC 2 PI1.1 — input validation + rate limiting on public APIs.
# Adapted from: Prowler `apigateway_restapi_client_certificate_enabled`,
# `apigateway_restapi_waf_acl_attached`, plus Powerpipe SOC 2 PI1 benchmark.

deny contains msg if {
    not input.aws_api_endpoints
    msg := "no API Gateway evidence collected"
}

deny contains msg if {
    some api in input.aws_api_endpoints.apis
    api.public
    not api.request_validation_enabled
    msg := sprintf("public API %q has no request validation configured", [api.name])
}

deny contains msg if {
    some api in input.aws_api_endpoints.apis
    api.public
    not api.waf_attached
    not api.usage_plan_attached
    msg := sprintf("public API %q has neither WAF nor a usage plan — unbounded request rate", [api.name])
}

warn contains msg if {
    some api in input.aws_api_endpoints.apis
    api.public
    api.waf_attached
    api.waf_rule_count == 0
    msg := sprintf("API %q has WAF attached but no rules — effectively a no-op", [api.name])
}
