resource "aws_ecs_service" "ecs_service" {
  name                               = var.service_name
  cluster                            = var.cluster
  task_definition                    = var.task_definition
  desired_count                      = var.desired_count
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.deployment_maximum_percent
  launch_type                        = var.launch_type
  scheduling_strategy                = var.scheduling_strategy
  platform_version                   = var.platform_version
  force_new_deployment               = var.force_new_deployment
  enable_execute_command             = var.enable_execute_command
  enable_ecs_managed_tags            = var.enable_ecs_managed_tags
  availability_zone_rebalancing      = var.availability_zone_rebalancing

  tags = merge({
    Name = var.service_name,
    module = var.module
  }, var.service_tags)
  # deployment_controller {
  #     type = "CODE_DEPLOY"
  # }
  network_configuration {
    security_groups  = [aws_security_group.sg_service.id]
    subnets          = var.subnets
    assign_public_ip = var.assign_public_ip
  }

  # load_balancer {
  #   target_group_arn = var.target_group_arn
  #   container_name   = var.container_name
  #   container_port   = var.container_port
  # }

  dynamic "load_balancer" {
    for_each = var.load_balancer == null ? [{}] : var.load_balancer

    content {
      target_group_arn = load_balancer.value.target_group_arn
      container_name   = load_balancer.value.container_name
      container_port   = load_balancer.value.container_port
    }
  }

  lifecycle {
    ignore_changes = [
      # desired_count,
      #task_definition
      load_balancer
    ]
  }
}

