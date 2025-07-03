resource "aws_lambda_function" "this" {
  count         = var.create_lambda ? 1 : 0
  function_name = "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-lambda"
  role          = aws_iam_role.lambda_role.arn
  package_type  = var.package_type
  architectures = var.architectures
  memory_size   = var.memory_size
  timeout       = var.timeout
  description   = var.description

  dynamic "environment" {
    for_each = length(keys(var.environment_variables)) == 0 ? [] : [true]
    content {
      variables = var.environment_variables
    }
  }

  dynamic "image" {
    for_each = var.package_type == "Image" ? [true] : []
    content {
      image_uri = coalesce(var.image_uri, var.create_ecr_repo ? aws_ecr_repository.this[0].repository_url : null)
    }
  }

  dynamic "s3" {
    for_each = var.package_type == "Zip" ? [true] : []
    content {
      s3_bucket = coalesce(var.s3_bucket_name, var.create_s3_bucket ? aws_s3_bucket.code[0].id : null)
      s3_key    = var.s3_key
    }
  }

  dynamic "vpc_config" {
    for_each = var.attach_vpc ? [true] : []
    content {
      subnet_ids         = var.vpc_subnet_ids
      security_group_ids = var.create_sg ? [aws_security_group.this[0].id] : []
    }
  }

  dynamic "logging_config" {
    for_each = var.logging_enable ? [true] : []
    content {
      log_group             = var.logging_log_group
      log_format            = var.logging_log_format
      application_log_level = var.logging_log_format == "Text" ? null : var.logging_application_log_level
      system_log_level      = var.logging_log_format == "Text" ? null : var.logging_system_log_level
    }
  }

  handler = var.package_type == "Zip" ? var.handler : null
  runtime = var.package_type == "Zip" ? var.runtime : null
  layers  = var.package_type == "Zip" && var.create_layer ? [aws_lambda_layer_version.this[0].arn] : null
}
