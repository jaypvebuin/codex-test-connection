data "aws_iam_policy_document" "policy_doc" {
  dynamic "statement" {
    for_each = var.iam_policy_statements
    content {
      effect    = try(statement.value.effect, "")
      actions   = try(statement.value.actions, [])
      resources = try(statement.value.resources, [])
      dynamic "condition" {
        for_each = try(statement.value.condition, [])
        content {
          test     = try(condition.value.test, "")
          variable = try(condition.value.variable, "")
          values   = try(condition.value.values, [])
        }
      }
    }
  }
}

resource "aws_iam_policy" "policy" {
  name        = "${var.vendor}-${var.project_name}-${var.identifier}-policy-${var.environment}"
  description = var.iam_policy_description
  policy      = data.aws_iam_policy_document.policy_doc.json
  tags = merge({
    Name = var.iam_policy_name,
    # module = var.module
  }, var.tags)

  depends_on = [data.aws_iam_policy_document.policy_doc]
}