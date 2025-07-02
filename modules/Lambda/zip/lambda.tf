resource "aws_lambda_function" "zip_lambda_function" {
  # count         = var.required_lambda_function == "true" ? 1 : 0
  function_name = "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-lambda"
  role          = aws_iam_role.lambda_task_role.arn
  package_type  = "Zip"
  architectures = var.compatible_architectures
  s3_bucket     = try(var.s3_bucket_name, aws_s3_bucket.this[0].id) #aws_s3_bucket.this[0].id
  s3_key        = var.s3_bucket_key
  layers        = var.required_lambda_layer == true ? [aws_lambda_layer_version.this[0].arn] : null
  memory_size   = var.memory_size
  timeout       = var.timeout
  handler       = var.handler
  runtime       = var.runtime
  dynamic "environment" {
    for_each = length(keys(var.environment_variables)) == 0 ? [] : [true]
    content {
      variables = var.environment_variables
    }
  }
  dynamic "vpc_config" {
    for_each = var.vpc_subnet_ids != null ? [true] : []
    content {
      security_group_ids = [aws_security_group.sg[0].id]
      subnet_ids         = var.vpc_subnet_ids
    }
  }
  dynamic "logging_config" {
    # Logging configurations for Lambda function
    for_each = var.logging_enable ? [true] : []
    content {
      log_group             = var.logging_log_group
      log_format            = var.logging_log_format
      application_log_level = var.logging_log_format == "Text" ? null : var.logging_application_log_level
      system_log_level      = var.logging_log_format == "Text" ? null : var.logging_system_log_level
    }
  }
  depends_on = [aws_lambda_layer_version.this]
}