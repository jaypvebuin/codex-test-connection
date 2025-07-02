resource "aws_s3_bucket" "codepipeline_bucket" {
  count  = var.required_artifact_bucket ? 1 : 0
  bucket = "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-pipeline-artifact-bucket-${lower(var.Environment)}"
  tags = {
    module = var.module
    purpose = "This bucket is for the codepipeline artifacts of ${lower(var.identifier)}"
  }
}

resource "aws_s3_bucket_policy" "s3_policy" {
  count  = var.bucket_policy != "" ? 1 : 0
  bucket = aws_s3_bucket.codepipeline_bucket[0].id
  policy = var.bucket_policy

  # lifecycle {
  #   ignore_changes = [policy]
  # }
}