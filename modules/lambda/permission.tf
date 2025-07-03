resource "aws_lambda_permission" "this" {
  count         = var.create_permission && var.create_lambda ? 1 : 0
  action        = var.action_on_lambda
  function_name = aws_lambda_function.this[0].function_name
  principal     = var.service_accessing_lambda
  source_arn    = var.source_arn_of_principal
  depends_on    = [aws_lambda_function.this]
}
