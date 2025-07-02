output "codebuild_project_arn" {
  value = aws_codebuild_project.this.arn
}

# output "codestarsourceconnectionArn" {
#   value = data.aws_codestarconnections_connection.example.arn
# }

output "codebuild_name" {
  value = aws_codebuild_project.this.name
}