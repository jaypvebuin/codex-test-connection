resource "aws_lambda_function_url" "this" {
  count              = var.create_function_url && var.create_lambda ? 1 : 0
  function_name      = aws_lambda_function.this[0].function_name
  authorization_type = var.authorization_type
  dynamic "cors" {
    for_each = var.cors != null ? [true] : []
    content {
      allow_credentials = try(cors.value.allow_credentials, null)
      allow_origins     = try(cors.value.allow_origins, null)
      allow_methods     = try(cors.value.allow_methods, null)
      allow_headers     = try(cors.value.allow_headers, null)
      expose_headers    = try(cors.value.expose_headers, null)
      max_age           = try(cors.value.max_age, null)
    }
  }
  depends_on = [aws_lambda_function.this]
}
