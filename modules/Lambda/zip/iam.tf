# IAM role for the Lambda function
# For custom policy, create it using IAM module and then pass its ARN into the variable in live folder.
resource "aws_iam_role" "lambda_task_role" {
  name               = "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  count      = length(var.policy_arn)
  policy_arn = var.policy_arn[count.index]
  role       = aws_iam_role.lambda_task_role.name
}