resource "aws_iam_role" "codebuild_role" {
  name               = "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-build-role-${lower(var.Environment)}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
tags = {
    module = var.module
    purpose = "This role is for the codebuild project of ${var.identifier}"
  }
}

resource "aws_iam_role_policy_attachment" "codebuild_role_policy_attachment" {
  count      = length(var.codebuild_role_policy_arn)
  policy_arn = var.codebuild_role_policy_arn[count.index]
  role       = aws_iam_role.codebuild_role.name
}