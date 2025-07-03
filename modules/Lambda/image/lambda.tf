resource "aws_lambda_function" "image_lambda_function" {
  count         = var.required_lambda_function == "true" ? 1 : 0
  function_name = "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-lambda"
  role          = aws_iam_role.lambda_task_role.arn
  package_type  = "Image"
  architectures = var.compatible_architectures
  image_uri     = try(var.image_uri, aws_ecr_repository.this[0].repository_url) #var.image_uri   
  # layers        = var.required_lambda_layer == true ? [aws_lambda_layer_version.this[0].arn] : null
  memory_size   = var.memory_size
  timeout       = var.timeout
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
}