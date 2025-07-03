output "lambda_arn" {
  value = var.create_lambda ? aws_lambda_function.this[0].arn : null
}

output "lambda_name" {
  value = var.create_lambda ? aws_lambda_function.this[0].function_name : null
}

output "lambda_invoke_arn" {
  value = var.create_lambda ? aws_lambda_function.this[0].invoke_arn : null
}

output "ecr_repository_url" {
  value = (var.create_ecr_repo && var.package_type == "Image") ? aws_ecr_repository.this[0].repository_url : null
}

output "code_bucket" {
  value = (var.create_s3_bucket && var.package_type == "Zip") ? aws_s3_bucket.code[0].id : null
}
