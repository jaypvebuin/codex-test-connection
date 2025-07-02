resource "aws_cloudwatch_log_group" "task_log" {
  name              = "/ecs/task/${var.family}-logs"
  retention_in_days = var.log_retention
  tags = merge({
    Name = "/ecs/task/${var.family}-logs"
    module = var.module
  }, var.log_tags)
}

resource "aws_ecs_task_definition" "ecs_task" {
  family                   = var.family
  network_mode             = var.network_mode
  requires_compatibilities = [var.requires_compatibilities]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = aws_iam_role.ecs_task_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  # container_definitions = jsonencode([
  #   {
  #     name      = "${var.family}-container"
  #     image     = var.container_image
  #     essential = true

  #     portMappings = [{
  #       protocol      = "tcp"
  #       containerPort = var.container_port
  #       name          = var.port_name
  #       appProtocol   = var.app_protocol
  #     }]

  #     environment = try(var.container_environment, null)
  #     secrets     = try(var.container_secrets, null)

  #     logConfiguration = {
  #       logDriver = "awslogs"
  #       options = {
  #         awslogs-group         = aws_cloudwatch_log_group.task_log.name
  #         awslogs-stream-prefix = "ecs"
  #         awslogs-region        = var.region
  #         awslogs-create-group  = "true"
  #         max-buffer-size       = "25m"
  #         mode                  = "non-blocking"
  #       }
  #     }
  #   }
  # ])
  container_definitions = jsonencode(var.container_definitions)
  tags = merge({
    Name = var.family,
    module = var.module
  }, var.task_tags)
}

locals {
  data = jsondecode(aws_ecs_task_definition.ecs_task.container_definitions)

  container_names = [for container in local.data : container.name]
}