resource "aws_codebuild_project" "this" {
  name         = "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-codebuild-project-${lower(var.Environment)}"
  service_role = aws_iam_role.codebuild_role.arn
  environment {
    compute_type                = var.build_compute_type
    image                       = var.build_environment_image
    type                        = var.build_environment_type
    image_pull_credentials_type = var.image_pull_credentials_type
    privileged_mode             = var.privileged_mode

    dynamic "environment_variable" {
      for_each = var.environment_variable

      content {
        name  = try(environment_variable.value.name, null)
        value = try(environment_variable.value.value, null)
        type  = try(environment_variable.value.type, null)
      }
    }
  }
  artifacts {
    type = var.artifact_type
  }
  source {
    type      = var.source_type
    buildspec = var.buildspec_filename
  }
  dynamic "vpc_config" {
    for_each = try(var.vpc_config, [{}])
    content {
      vpc_id             = try(vpc_config.value.vpc_id, null)
      subnets            = try(vpc_config.value.subnets[*], [])
      security_group_ids = try(vpc_config.value.security_group_ids, [])
    }
  }
  logs_config {
    cloudwatch_logs {
      group_name  = "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-cloudwatch-loggroup-${lower(var.Environment)}"
      stream_name = "aws/codebuild/${lower(var.identifier)}-codebuild"
    }
  }
  tags = {
    module = var.module
    purpose = "This is the codebuild project for ${var.identifier}"
  }
}
