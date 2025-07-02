output "task_arn" {
  value = aws_ecs_task_definition.ecs_task.arn
}

output "task_role_name" {
  value = aws_iam_role.ecs_task_role.name
}

output "task_role_arn" {
  value = aws_iam_role.ecs_task_role.arn
}