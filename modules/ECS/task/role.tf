resource "aws_iam_role" "ecs_task_role" {
  name = var.role_name
  tags = merge({
    Name = var.role_name,
    module = var.module
  }, var.role_tags)
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs_task_role_policy" {
  for_each   = toset(var.policy_arn)
  policy_arn = each.value
  role       = aws_iam_role.ecs_task_role.name
}

# resource "aws_iam_policy" "ecs_task_policy" {
#   name        = "vb-jugaad-task-role-policy-dev"
#   path        = "/"
#   description = "Policy for ecs task"

#   # Terraform's "jsonencode" function converts a
#   # Terraform expression result to valid JSON syntax.
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = [
#         "lambda:InvokeFunction",
#         "lambda:InvokeFunctionUrl"
#         ]
#         Effect   = "Allow"
#         Resource = "*"
#       },
#     ]
#   })
# }