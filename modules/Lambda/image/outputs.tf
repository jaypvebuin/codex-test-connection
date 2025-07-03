output "image_lambda_invoke_arn" {
  value = var.required_lambda_function ? aws_lambda_function.image_lambda_function[0].invoke_arn : null
}

# output "zip_lambda_invoke_arn" {
#   value = var.lambda_code_package_type == "Zip" && length(aws_lambda_function.zip_lambda_function) > 0 ? aws_lambda_function.zip_lambda_function[0].invoke_arn : null
# }

output "image_lambda_arn" {
  value = var.required_lambda_function ? aws_lambda_function.image_lambda_function[0].arn : null
}

# output "zip_lambda_arn" {
#   value = var.lambda_code_package_type == "Zip" && length(aws_lambda_function.zip_lambda_function) > 0 ? aws_lambda_function.zip_lambda_function[0].arn : null
# }

output "image_lambda_name" {
  value = var.required_lambda_function ? aws_lambda_function.image_lambda_function[0].function_name : null
}

# output "zip_lambda_name" {
#   value = var.lambda_code_package_type == "Zip" && length(aws_lambda_function.zip_lambda_function) > 0 ? aws_lambda_function.zip_lambda_function[0].function_name : null
# }

output "ecr_repository_url" {
  value = var.required_repo_for_image_lambda == "true" ? aws_ecr_repository.this[0].repository_url : null
}