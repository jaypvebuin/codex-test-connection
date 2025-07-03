resource "aws_iam_role" "lambda_role" {
  name = "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
  tags = {
    Name    = "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-role"
    Purpose = "lambda"
  }
}

resource "aws_iam_role_policy_attachment" "attached" {
  for_each   = toset(var.policy_arns)
  policy_arn = each.value
  role       = aws_iam_role.lambda_role.name
}
