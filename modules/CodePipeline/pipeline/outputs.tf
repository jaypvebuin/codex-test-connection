output "artifact_bucket" {
  value = aws_s3_bucket.codepipeline_bucket[0].id
}

# output "appliction_build" {
#   value = var.required_build == true ? aws_codebuild_project.appliction[0].name : null
# }

# output "owasp_dependency_build" {
#   value = var.required_sast == true ? aws_codebuild_project.dependency_check[0].name : null #aws_codebuild_project.dependency_check[0].name
# }

# output "sonar_build" {
#   value = var.required_sast == true ? aws_codebuild_project.sonar[0].name : null
# }

# output "codestarsourceconnectionArn" {
#   value = data.aws_codestarconnections_connection.example.arn
# }





# output "zap_dependency_build" {
#   value = var.required_dast == true  ? aws_codebuild_project.zap[0].name : null #aws_codebuild_project.dependency_check[0].name
# }