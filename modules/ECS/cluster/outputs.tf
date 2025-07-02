output "cluster_log" {
  value = aws_cloudwatch_log_group.cluster_log[*].name
}

output "cluster_name" {
  value = aws_ecs_cluster.ecs_cluster.name
}

output "cluster_arn" {
  value = aws_ecs_cluster.ecs_cluster.arn
}