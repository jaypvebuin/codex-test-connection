resource "aws_lambda_function_url" "zip_function_url" {
  count              = var.required_function_url == true ? 1 : 0
  function_name      = aws_lambda_function.zip_lambda_function.function_name
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
  depends_on = [aws_lambda_function.zip_lambda_function]
}
