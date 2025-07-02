resource "aws_codepipeline" "codepipeline" {
  name           = "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-codepipeline-${lower(var.Environment)}"
  role_arn       = aws_iam_role.pipeline_role.arn
  pipeline_type  = var.pipeline_type
  execution_mode = var.execution_mode
  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket[0].bucket
    type     = "S3"
  }

  dynamic "stage" {
    for_each = var.stages
    content {
      name = stage.value.stage_name
      # Iterate over actions within the stage
      dynamic "action" {
        for_each = stage.value.actions
        content {
          name     = action.value.action_name
          category = action.value.category
          owner    = action.value.owner
          provider = action.value.provider
          version  = "1"

          input_artifacts  = try(action.value.input_artifacts, [])
          output_artifacts = try(action.value.output_artifacts, [])

          configuration = action.value.configuration
        }
      }
    }
  }
  tags = {
    module = var.module
    purpose = "This codepipeline is of ${lower(var.identifier)}"
  }
}
