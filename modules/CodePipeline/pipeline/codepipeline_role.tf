resource "aws_iam_role" "pipeline_role" {
  name               = "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-pipeline-role-${lower(var.Environment)}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
tags = {
    module = var.module
    purpose = "This role is for the codepipeline of ${lower(var.identifier)}"
  }
}

resource "aws_iam_role_policy_attachment" "codepipeline_role_policy_attachment" {
  count      = length(var.pipeline_role_policy_arn)
  policy_arn = var.pipeline_role_policy_arn[count.index]
  role       = aws_iam_role.pipeline_role.name
}