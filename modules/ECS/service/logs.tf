resource "aws_cloudwatch_log_group" "this" {
  name              = "/ecs/service/${var.log_group_name}"
  retention_in_days = var.log_retention

  tags = merge({
    Name = "/ecs/service/${var.log_group_name}",
    module = var.module
  }, var.log_tags)
}