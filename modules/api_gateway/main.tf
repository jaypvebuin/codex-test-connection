data "aws_caller_identity" "current" {}

resource "aws_api_gateway_rest_api" "rest_api_gateway" {
  name        = "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-api-gateway-${lower(var.Environment)}"
  description = var.api_gateway_description
  endpoint_configuration {
    types = ["REGIONAL"]
  }
  binary_media_types = var.binary_media_types
  body = jsonencode(var.openapi_body)
}


resource "aws_api_gateway_deployment" "this" {
  for_each    = { for stage in var.api_stages : stage.name => stage }
  rest_api_id = aws_api_gateway_rest_api.rest_api_gateway.id
  description = "Deployed for stage ${each.key} at ${timestamp()}"

  triggers = {
    redeployment = sha1(jsonencode({
      rest_api = aws_api_gateway_rest_api.rest_api_gateway.body
    }))
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_api_gateway_rest_api_policy.api_gateway
  ]
}

resource "aws_iam_role" "api_gateway_cloudwatch_role" {
  # name               = "${var.role_prefix}-api-gateway-cloudwatch-role"
  name               = "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-api-gateway-cloudwatch-role-${lower(var.Environment)}"
  assume_role_policy = data.aws_iam_policy_document.api_gateway_cloudwatch_role.json
}

data "aws_iam_policy_document" "api_gateway_cloudwatch_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "api_gateway" {
  role       = aws_iam_role.api_gateway_cloudwatch_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
}

resource "aws_api_gateway_account" "this" {
  cloudwatch_role_arn = aws_iam_role.api_gateway_cloudwatch_role.arn
  depends_on = [
    aws_iam_role_policy_attachment.api_gateway
  ]
}

resource "aws_api_gateway_stage" "this" {
  for_each     = { for stage in var.api_stages : stage.name => stage }
  rest_api_id  = aws_api_gateway_rest_api.rest_api_gateway.id
  deployment_id = aws_api_gateway_deployment.this[each.key].id
  stage_name   = each.key
  variables    = each.value.variables

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gateway_access_log[each.key].arn
    format = jsonencode({
      "requestId"         : "$context.requestId",
      "extendedRequestId" : "$context.extendedRequestId",
      "ip"                : "$context.identity.sourceIp",
      "caller"            : "$context.identity.caller",
      "user"              : "$context.identity.user",
      "requestTime"       : "$context.requestTime",
      "httpMethod"        : "$context.httpMethod",
      "resourcePath"      : "$context.resourcePath",
      "status"            : "$context.status",
      "protocol"          : "$context.protocol",
      "responseLength"    : "$context.responseLength",
    })
  }

  xray_tracing_enabled = each.value.xray_tracing_enabled

  depends_on = [
    aws_cloudwatch_log_group.api_gateway_access_log,
    aws_api_gateway_account.this,
    aws_api_gateway_deployment.this
  ]
}

resource "aws_cloudwatch_log_group" "api_gateway_access_log" {
  for_each = { for stage in var.api_stages : stage.name => stage }

  name              = each.value.log_group_name
  retention_in_days = each.value.retention_in_days
}

resource "aws_api_gateway_rest_api_policy" "api_gateway" {
  rest_api_id = aws_api_gateway_rest_api.rest_api_gateway.id
  policy      = data.aws_iam_policy_document.api_gateway.json
}

resource "random_string" "referer_value" {
  length = 20
}

data "aws_iam_policy_document" "api_gateway" {
  statement {
    effect = "Allow"
    principals {
      type = "*"
      identifiers = [
        "*",
      ]
    }
    actions = [
      "execute-api:Invoke",
    ]
    resources = [
      "${aws_api_gateway_rest_api.rest_api_gateway.execution_arn}/*",
    ]
    # condition {
    #   test     = "StringEquals"
    #   variable = "aws:Referer"
    #   values = [
    #     random_string.referer_value.result
    #   ]
    # }
  }
}

# resource "aws_api_gateway_api_key" "rest_api_key" {
#   name    = "jugaad"
#   enabled = true
# }