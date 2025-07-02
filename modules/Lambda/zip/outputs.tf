# output "image_lambda_invoke_arn" {
#   value = var.lambda_code_package_type == "Image" && length(aws_lambda_function.image_lambda_function) > 0 ? aws_lambda_function.image_lambda_function[0].invoke_arn : null
# }

output "zip_lambda_invoke_arn" {
  value = aws_lambda_function.zip_lambda_function.invoke_arn
}

# output "image_lambda_arn" {
# value = var.lambda_code_package_type == "Image" && length(aws_lambda_function.image_lambda_function) > 0 ? aws_lambda_function.image_lambda_function[0].arn : null
# }

output "zip_lambda_arn" {
  value = aws_lambda_function.zip_lambda_function.arn
}

# output "image_lambda_name" {
# value = var.lambda_code_package_type == "Image" && length(aws_lambda_function.image_lambda_function) > 0 ? aws_lambda_function.image_lambda_function[0].function_name : null
# }

output "zip_lambda_name" {
  value = aws_lambda_function.zip_lambda_function.function_name
}

# output "ecr_repository_url" {
# value = var.lambda_code_package_type == "Image" ? aws_ecr_repository.this[0].repository_url : null
# }