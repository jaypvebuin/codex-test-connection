resource "aws_appautoscaling_target" "ecs_target" {
  count = var.require_service_autoscaling ? 1 : 0
  max_capacity       = var.max_capacity
  min_capacity       = var.min_capacity
  resource_id        = "service/${var.cluster_name}/${aws_ecs_service.ecs_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
  tags = {
    module = var.module
  }
#   tags = merge({
#     Name = var.name
#   }, var.tags)
}

resource "aws_appautoscaling_policy" "ecs_target_cpu" {
  count = var.require_service_autoscaling ? 1 : 0
  name               = "${lower(var.vendor)}-${var.project_name}-${lower(var.Environment)}-${var.service_name}-scaling-policy-cpu"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target[0].resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target[0].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value       = var.auto_scaling_cpu_target_value
    scale_in_cooldown  = 300
    scale_out_cooldown = 60
  }
}



# resource "aws_iam_role" "ecs-autoscale-role" {
#   count = var.Environment == "prod" ? 1 : 0
#   name  = "${lower(var.maintainer)}-${var.project_name}-${lower(var.Environment)}-${var.service_name}-ecs-scale-application"
#   tags = merge({
#     Name = var.name
#   }, var.tags)

#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": "sts:AssumeRole",
#       "Principal": {
#         "Service": "application-autoscaling.amazonaws.com"
#       },
#       "Effect": "Allow"
#     }
#   ]
# }
# EOF
# }

# resource "aws_iam_role_policy_attachment" "ecs-autoscale" {
#   count      = var.Environment == "prod" ? 1 : 0
#   role       = aws_iam_role.ecs-autoscale-role[0].id
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole"
# }




# resource "aws_appautoscaling_target" "ecs_target" {
#   count              = var.Environment == "prod" ? 1 : 0
#   max_capacity       = var.max_capacity
#   min_capacity       = var.min_capacity
#   scalable_dimension = "ecs:service:DesiredCount"
#   service_namespace  = "ecs"
# }

# resource "aws_appautoscaling_policy" "cpu" {
#   count = var.enable_autoscaling ? 1 : 0

#   name               = "${var.name}-cpu-autoscaling"
#   policy_type        = "TargetTrackingScaling"
#   resource_id        = aws_appautoscaling_target.ecs[0].resource_id
#   scalable_dimension = aws_appautoscaling_target.ecs[0].scalable_dimension
#   service_namespace  = aws_appautoscaling_target.ecs[0].service_namespace

#   target_tracking_scaling_policy_configuration {
#     target_value       = var.autoscaling_target_cpu_utilization
#     predefined_metric_specification {
#       predefined_metric_type = "ECSServiceAverageCPUUtilization"
#     }
#     scale_in_cooldown  = 300
#     scale_out_cooldown = 300
#   }
# }

# # # resource "aws_iam_role" "ecs-autoscale-role" {
# # #   count = var.Environment == "prod" ? 1 : 0
# # #   name  = "${lower(var.maintainer)}-${var.project_name}-${lower(var.Environment)}-${var.service_name}-ecs-scale-application"
# # #   tags = merge({
# # #     Name = var.name
# # #   }, var.tags)

# # #   assume_role_policy = <<EOF
# # # {
# # #   "Version": "2012-10-17",
# # #   "Statement": [
# # #     {
# # #       "Action": "sts:AssumeRole",
# # #       "Principal": {
# # #         "Service": "application-autoscaling.amazonaws.com"
# # #       },
# # #       "Effect": "Allow"
# # #     }
# # #   ]
# # # }
# # # EOF
# # # }

# # # resource "aws_iam_role_policy_attachment" "ecs-autoscale" {
# # #   count      = var.Environment == "prod" ? 1 : 0
# # #   role       = aws_iam_role.ecs-autoscale-role[0].id
# # #   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole"
# # # }




# # # resource "aws_appautoscaling_target" "ecs_target" {
# # #   count              = var.Environment == "prod" ? 1 : 0
# # #   max_capacity       = var.max_capacity
# # #   min_capacity       = var.min_capacity
# # #   scalable_dimension = "ecs:service:DesiredCount"
# # #   service_namespace  = "ecs"
# # #   resource_id        = "service/${var.cluster_name}/${aws_ecs_service.ecs_service.name}"
# # #   role_arn           = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/ecs.application-autoscaling.amazonaws.com/AWSServiceRoleForApplicationAutoScaling_ECSService"
# # #   tags = merge({
# # #     Name = var.name
# # #   }, var.tags)
# # # }

# # # resource "aws_appautoscaling_policy" "ecs_target_cpu" {
# # #   count              = var.Environment == "prod" ? 1 : 0
# # #   name               = "${lower(var.maintainer)}-${var.project_name}-${lower(var.Environment)}-${var.service_name}-scaling-policy-cpu"
# # #   policy_type        = "TargetTrackingScaling"
# # #   resource_id        = aws_appautoscaling_target.ecs_target[0].resource_id
# # #   scalable_dimension = aws_appautoscaling_target.ecs_target[0].scalable_dimension
# # #   service_namespace  = aws_appautoscaling_target.ecs_target[0].service_namespace

# # #   target_tracking_scaling_policy_configuration {
# # #     predefined_metric_specification {
# # #       predefined_metric_type = "ECSServiceAverageCPUUtilization"
# # #     }
# # #     target_value = 50
# # #   }
# # #   depends_on = [aws_appautoscaling_target.ecs_target]
# # # }


# # # resource "aws_appautoscaling_policy" "ecs_target_memory" {
# # #   count              = var.Environment == "prod" ? 1 : 0
# # #   name               = "${lower(var.maintainer)}-${var.project_name}-${lower(var.Environment)}-${var.service_name}-scaling-policy-memory"
# # #   policy_type        = "TargetTrackingScaling"
# # #   resource_id        = aws_appautoscaling_target.ecs_target[0].resource_id
# # #   scalable_dimension = aws_appautoscaling_target.ecs_target[0].scalable_dimension
# # #   service_namespace  = aws_appautoscaling_target.ecs_target[0].service_namespace

# # #   target_tracking_scaling_policy_configuration {
# # #     predefined_metric_specification {
# # #       predefined_metric_type = "ECSServiceAverageMemoryUtilization"
# # #     }
# # #     target_value = 50
# # #   }
# # #   depends_on = [aws_appautoscaling_target.ecs_target]
# # # }

# # # data "aws_caller_identity" "current" {}