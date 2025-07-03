resource "aws_lambda_permission" "zip_lambda_permission" {
  count         = var.required_external_invoke_permission  ? 1 : 0
  action        = var.action_on_lambda
  function_name = aws_lambda_function.zip_lambda_function.function_name
  # function_name = var.lambda_code_package_type == "Zip" && length(aws_lambda_function.zip_lambda_function) > 0 ? aws_lambda_function.zip_lambda_function[0].function_name : aws_lambda_function.image_lambda_function[0].function_name

  principal     = var.service_accessing_lambda
  source_arn    = var.source_arn_of_principal
  depends_on = [ aws_lambda_function.zip_lambda_function ]
}