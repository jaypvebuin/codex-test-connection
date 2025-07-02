resource "aws_lambda_function" "image_lambda_function" {
  count         = var.required_lambda_function == true ? 1 : 0
  function_name = var.Environment == "beta" ? "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-lambda-beta" : "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-lambda"
  # function_name = "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-lambda"
  role          = aws_iam_role.lambda_task_role.arn
  package_type  = "Image"
  architectures = var.compatible_architectures
  kms_key_arn = var.kms_key_arn
  image_uri     = try("${aws_ecr_repository.this[0].repository_url}:latest", var.image_uri) #var.image_uri   
  # layers        = var.required_lambda_layer == true ? [aws_lambda_layer_version.this[0].arn] : null
  memory_size = var.memory_size
  timeout     = var.timeout
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
  # dynamic "logging_config" {
  #   # Logging configurations for Lambda function
  #   for_each = var.logging_enable ? [true] : []

  #   content {
  #     log_group             = var.logging_log_group
  #     log_format            = var.logging_log_format
  #     application_log_level = var.logging_log_format == "Text" ? null : var.logging_application_log_level
  #     system_log_level      = var.logging_log_format == "Text" ? null : var.logging_system_log_level
  #   }
  # }
  logging_config {
    # log_group  = aws_cloudwatch_log_group.image_lambda_log_group.arn
    log_group  = "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-log-group"
    log_format = "Text"
  }
  lifecycle {
    ignore_changes = [environment]
  }
  tags = {
    module = var.module
    purpose = "This lambda function is used for ${var.identifier}"
  }
}


resource "aws_cloudwatch_log_group" "image_lambda_log_group" {
  name              = var.Environment == "prod" ? "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-${lower(var.Environment)}-log-group" : "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-log-group"
  retention_in_days = 30
  tags = {
    module = var.module
    purpose = "This log group is of ${var.identifier} lambda."
  }
}