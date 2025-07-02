output "target_group_arns" {
  value = { for tg in aws_lb_target_group.target_groups : tg.name => tg.arn }
}
