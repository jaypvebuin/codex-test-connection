output "arn_value" {
  value = aws_api_gateway_rest_api.rest_api_gateway.execution_arn
}

# output "key_value" {
#   value = aws_api_gateway_api_key.rest_api_key.value
# }

output "id" {
  value = aws_api_gateway_rest_api.rest_api_gateway.id

}

# output "stage_name" {
#   value = aws_api_gateway_stage.this[each.key].stage_name
# }

output "referer_value" {
  value = random_string.referer_value.result
}

# output "log_group_name" {
#   value = aws_cloudwatch_log_group.api_gateway_access_log[each.key].name
# }
