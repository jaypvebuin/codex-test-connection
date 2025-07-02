locals {
  service_configs = [
    # apply-approve-service
    {
      # identifier = "apply-approve-service"
      module = "microservices"
      count = var.microservice_resources[var.environment]
      service_name                       = "vb-jugaad-apply-approve-service-${lower(var.environment)}"
      cluster                            = try(module.ecs_cluster["0"].cluster_arn,null)
      task_definition                    = try(module.ecs_task["0"].task_arn,null)
      desired_count                      = var.services_task_count[var.environment]["apply-approve-service"]
      deployment_minimum_healthy_percent = 100
      deployment_maximum_percent         = 200
      launch_type                        = "FARGATE"
      scheduling_strategy                = "REPLICA"
      platform_version                   = "LATEST"
      force_new_deployment               = true
      enable_execute_command             = true
      service_tags = {
        CreatedBy = "Terraform"
      }

      sg_name     = "vb-jugaad-apply-approve-service-sg-${lower(var.environment)}"
      description = "vb-jugaad-apply-approve-service-sg-${lower(var.environment)}"
      vpc_id      = var.vpc_id[var.environment] ## replance with your vpc
      dev_service_ingress_sg = [
        {
          from_port       = 3000,
          to_port         = 3000,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [var.internal_lb_sg[var.environment]]
        },
        {
          from_port       = 3000,
          to_port         = 3000,
          description     = "traffic from external load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [module.listeners.sg_id]
        }
        # {
        #   from_port       = 6379,
        #   to_port         = 6385,
        #   description     = "traffic from sidekiq redis",
        #   protocol        = "tcp",
        #   cidr_blocks     = [data.aws_ssm_parameter.sidekiq_trusted_ip.value]
        #   security_groups = null
        # }
      ]
      service_ingress_sg = [
        {
          from_port       = 3000,
          to_port         = 3000,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [var.internal_lb_sg[var.environment]]
        },
        {
          from_port       = 3000,
          to_port         = 3000,
          description     = "traffic from external load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [module.listeners.sg_id]
        }
        # {
        #   from_port       = 6379,
        #   to_port         = 6385,
        #   description     = "traffic from sidekiq redis",
        #   protocol        = "tcp",
        #   cidr_blocks     = null
        #   security_groups = [data.aws_ssm_parameter.sidekiq_trusted_ip.value]
        # }
      ]
      service_egress_sg = [{
        port        = 0,
        description = "anywhere",
        protocol    = "-1",
        cidr_blocks = ["0.0.0.0/0"]
        },
        {
          port        = 0,
          description = "anywhere",
          protocol    = "-1",
          cidr_blocks = ["0.0.0.0/0"]
      }]
      sg_tags = {
        Purpose = "service SG"
      }
      subnets          = var.subnet_ids[var.environment]
      assign_public_ip = false


      # target_group_arn = module.target_groups.target_group_arns["vb-jugaad-apply-approve-tg-dev"]
      # container_name   = "vb-jugaad-apply-approve-task-definition-dev-container"
      # container_port   = 80 
      require_service_autoscaling = true
      max_capacity = var.services_scaling_max_count["apply-approve-service"]
      min_capacity = var.services_scaling_min_count["apply-approve-service"]
      cluster_name = module.ecs_cluster["0"].cluster_name

      load_balancer = [{
        target_group_arn = module.target_groups.target_group_arns["vb-jugaad-apply-approve-tg-${lower(var.environment)}"]
        container_name   = "vb-jugaad-apply-approve-task-definition-${lower(var.environment)}-container"
        container_port   = 3000
      }]


      log_group_name = "/ecs/vb-jugaad-apply-approve-service-${lower(var.environment)}"
      log_retention  = 30
      log_tags = {
        Purpose = "log group for service"
      }
      availability_zone_rebalancing = var.environment == "dev" ? "DISABLED" : "ENABLED"
      enable_ecs_managed_tags       = var.environment == "dev" ? false : true
    },
    # form-details-service
    {
      # identifier = "form-details-service"
      module = "microservices"
      count = var.microservice_resources[var.environment]
      service_name                       = "vb-jugaad-form-details-service-${lower(var.environment)}"
      cluster                            = try(module.ecs_cluster["0"].cluster_arn,null)
      task_definition                    = try(module.ecs_task["1"].task_arn,null)
      desired_count                      = var.services_task_count[var.environment]["form-details-service"]
      deployment_minimum_healthy_percent = 100
      deployment_maximum_percent         = 200
      launch_type                        = "FARGATE"
      scheduling_strategy                = "REPLICA"
      platform_version                   = "LATEST"
      force_new_deployment               = true
      enable_execute_command             = true
      service_tags = {
        CreatedBy = "Terraform"
      }

      sg_name     = "vb-jugaad-form-details-service-sg-${lower(var.environment)}"
      description = "vb-jugaad-form-details-service-sg-${lower(var.environment)}"
      vpc_id      = var.vpc_id[var.environment] ## replance with your vpc
      dev_service_ingress_sg = [
        {
          from_port       = 3000,
          to_port         = 3000,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [var.internal_lb_sg[var.environment]]
        },
        {
          from_port       = 3000,
          to_port         = 3000,
          description     = "traffic from external load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [module.listeners.sg_id]
        }
        # {
        #   from_port       = 6379,
        #   to_port         = 6385,
        #   description     = "traffic from sidekiq redis",
        #   protocol        = "tcp",
        #   cidr_blocks     = [data.aws_ssm_parameter.sidekiq_trusted_ip.value]
        #   security_groups = null
        # }
      ]
      service_ingress_sg = [
        {
          from_port       = 3000,
          to_port         = 3000,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [var.internal_lb_sg[var.environment]]
        },
        {
          from_port       = 3000,
          to_port         = 3000,
          description     = "traffic from external load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [module.listeners.sg_id]
        }
        # {
        #   from_port       = 6379,
        #   to_port         = 6385,
        #   description     = "traffic from sidekiq redis",
        #   protocol        = "tcp",
        #   cidr_blocks     = null
        #   security_groups = [data.aws_ssm_parameter.sidekiq_trusted_ip.value]
        # }
      ]
      service_egress_sg = [{
        port        = 0,
        description = "anywhere",
        protocol    = "-1",
        cidr_blocks = ["0.0.0.0/0"]
        },
        {
          port        = 0,
          description = "anywhere",
          protocol    = "-1",
          cidr_blocks = ["0.0.0.0/0"]
      }]
      sg_tags = {
        Purpose = "service SG"
      }
      subnets          = var.subnet_ids[var.environment]
      assign_public_ip = false


      load_balancer = [{
        target_group_arn = module.target_groups.target_group_arns["vb-jugaad-form-details-tg-${lower(var.environment)}"]
        container_name   = "vb-jugaad-form-details-task-definition-${lower(var.environment)}-container"
        container_port   = 3000
      }]
      # target_group_arn = module.target_groups.target_group_arns["vb-jugaad-form-details-tg-dev"]
      # container_name   = "vb-jugaad-form-details-task-definition-dev-container"
      # container_port   = 80
      require_service_autoscaling = true
      max_capacity = var.services_scaling_max_count["form-details-service"]
      min_capacity = var.services_scaling_min_count["form-details-service"]
      cluster_name = module.ecs_cluster["0"].cluster_name

      log_group_name = "/ecs/vb-jugaad-form-details-service-${lower(var.environment)}"
      log_retention  = 30
      log_tags = {
        Purpose = "log group for service"
      }
      availability_zone_rebalancing = var.environment == "dev" ? "DISABLED" : "ENABLED"
      enable_ecs_managed_tags       = var.environment == "dev" ? false : true

    },
    # notification-service
    {
      module = "microservices"
      # identifier = "notification-service"
      count = var.microservice_resources[var.environment]
      service_name                       = "vb-jugaad-notification-service-${lower(var.environment)}"
      cluster                            = try(module.ecs_cluster["0"].cluster_arn,null)
      task_definition                    = try(module.ecs_task["2"].task_arn,null)
      desired_count                      = var.services_task_count[var.environment]["notification-service"]
      deployment_minimum_healthy_percent = 100
      deployment_maximum_percent         = 200
      launch_type                        = "FARGATE"
      scheduling_strategy                = "REPLICA"
      platform_version                   = "LATEST"
      force_new_deployment               = true
      enable_execute_command             = true
      service_tags = {
        CreatedBy = "Terraform"
      }

      sg_name     = "vb-jugaad-notification-service-sg-${lower(var.environment)}"
      description = "vb-jugaad-notification-service-sg-${lower(var.environment)}"
      vpc_id      = var.vpc_id[var.environment] ## replance with your vpc
      dev_service_ingress_sg = [
        {
          from_port       = 3000,
          to_port         = 3000,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [var.internal_lb_sg[var.environment]]
        },
        {
          from_port       = 3000,
          to_port         = 3000,
          description     = "traffic from external load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [module.listeners.sg_id]
        }
        # {
        #   from_port       = 6379,
        #   to_port         = 6385,
        #   description     = "traffic from sidekiq redis",
        #   protocol        = "tcp",
        #   cidr_blocks     = [data.aws_ssm_parameter.sidekiq_trusted_ip.value]
        #   security_groups = null
        # }
      ]
      service_ingress_sg = [
        {
          from_port       = 3000,
          to_port         = 3000,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [var.internal_lb_sg[var.environment]]
        },
        {
          from_port       = 3000,
          to_port         = 3000,
          description     = "traffic from external load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [module.listeners.sg_id]
        }
        # {
        #   from_port       = 6379,
        #   to_port         = 6385,
        #   description     = "traffic from sidekiq redis",
        #   protocol        = "tcp",
        #   cidr_blocks     = null
        #   security_groups = [data.aws_ssm_parameter.sidekiq_trusted_ip.value]
        # }
      ]
      service_egress_sg = [{
        port        = 0,
        description = "anywhere",
        protocol    = "-1",
        cidr_blocks = ["0.0.0.0/0"]
        },
        {
          port        = 0,
          description = "anywhere",
          protocol    = "-1",
          cidr_blocks = ["0.0.0.0/0"]
      }]
      sg_tags = {
        Purpose = "service SG"
      }
      subnets          = var.subnet_ids[var.environment]
      assign_public_ip = false

      require_service_autoscaling = true
      max_capacity = var.services_scaling_max_count["notification-service"]
      min_capacity = var.services_scaling_min_count["notification-service"]
      cluster_name = module.ecs_cluster["0"].cluster_name

      load_balancer = [{
        target_group_arn = module.target_groups.target_group_arns["vb-jugaad-notify-tg-${lower(var.environment)}"]
        container_name   = "vb-jugaad-notification-task-definition-${lower(var.environment)}-container"
        container_port   = 3000
      }]

      log_group_name = "/ecs/vb-jugaad-notification-service-sg-${lower(var.environment)}"
      log_retention  = 30
      log_tags = {
        Purpose = "log group for service"
      }
      availability_zone_rebalancing = var.environment == "dev" ? "DISABLED" : "ENABLED"
      enable_ecs_managed_tags       = var.environment == "dev" ? false : true

    },
    # pdf-service
    {
      module = "microservices"
      # identifier = "pdf-service"
      count = var.microservice_resources[var.environment]
      service_name                       = "vb-jugaad-pdf-service-${lower(var.environment)}"
      cluster                            = try(module.ecs_cluster["0"].cluster_arn,null)
      task_definition                    = try(module.ecs_task["3"].task_arn,null)
      desired_count                      = var.services_task_count[var.environment]["pdf-service"]
      deployment_minimum_healthy_percent = 100
      deployment_maximum_percent         = 200
      launch_type                        = "FARGATE"
      scheduling_strategy                = "REPLICA"
      platform_version                   = "LATEST"
      force_new_deployment               = true
      enable_execute_command             = true
      service_tags = {
        CreatedBy = "Terraform"
      }

      sg_name     = "vb-jugaad-pdf-service-sg-${lower(var.environment)}"
      description = "vb-jugaad-pdf-service-sg-${lower(var.environment)}"
      vpc_id      = var.vpc_id[var.environment] ## replance with your vpc
      dev_service_ingress_sg = [
        {
          from_port       = 3000,
          to_port         = 3000,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [var.internal_lb_sg[var.environment]]
        },
        {
          from_port       = 3000,
          to_port         = 3000,
          description     = "traffic from external load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [module.listeners.sg_id]
        }
        # {
        #   from_port       = 6379,
        #   to_port         = 6385,
        #   description     = "traffic from sidekiq redis",
        #   protocol        = "tcp",
        #   cidr_blocks     = [data.aws_ssm_parameter.sidekiq_trusted_ip.value]
        #   security_groups = null
        # }
      ]
      service_ingress_sg = [
        {
          from_port       = 3000,
          to_port         = 3000,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [var.internal_lb_sg[var.environment]]
        },
        {
          from_port       = 3000,
          to_port         = 3000,
          description     = "traffic from external load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [module.listeners.sg_id]
        }
        # {
        #   from_port       = 6379,
        #   to_port         = 6385,
        #   description     = "traffic from sidekiq redis",
        #   protocol        = "tcp",
        #   cidr_blocks     = null
        #   security_groups = [data.aws_ssm_parameter.sidekiq_trusted_ip.value]
        # }
      ]
      service_egress_sg = [{
        port        = 0,
        description = "anywhere",
        protocol    = "-1",
        cidr_blocks = ["0.0.0.0/0"]
        },
        {
          port        = 0,
          description = "anywhere",
          protocol    = "-1",
          cidr_blocks = ["0.0.0.0/0"]
      }]
      sg_tags = {
        Purpose = "service SG"
      }
      subnets          = var.subnet_ids[var.environment]
      assign_public_ip = false

      require_service_autoscaling = true
      max_capacity = var.services_scaling_max_count["pdf-service"]
      min_capacity = var.services_scaling_min_count["pdf-service"]
      cluster_name = module.ecs_cluster["0"].cluster_name

      load_balancer = [{
        target_group_arn = module.target_groups.target_group_arns["vb-jugaad-pdf-tg-${lower(var.environment)}"]
        container_name   = "vb-jugaad-pdf-task-definition-${lower(var.environment)}-container"
        container_port   = 3000
      }]

      log_group_name = "/ecs/vb-jugaad-pdf-service-sg-${lower(var.environment)}"
      log_retention  = 30
      log_tags = {
        Purpose = "log group for service"
      }
      availability_zone_rebalancing = var.environment == "dev" ? "DISABLED" : "ENABLED"
      enable_ecs_managed_tags       = var.environment == "dev" ? false : true

    },
    # report-service
    {
      module = "microservices"
      # identifier = "report-service"
      count = var.microservice_resources[var.environment]
      service_name                       = "vb-jugaad-report-service-${lower(var.environment)}"
      cluster                            = try(module.ecs_cluster["0"].cluster_arn,null)
      task_definition                    = try(module.ecs_task["4"].task_arn,null)
      desired_count                      = var.services_task_count[var.environment]["report-service"]
      deployment_minimum_healthy_percent = 100
      deployment_maximum_percent         = 200
      launch_type                        = "FARGATE"
      scheduling_strategy                = "REPLICA"
      platform_version                   = "LATEST"
      force_new_deployment               = true
      enable_execute_command             = true
      service_tags = {
        CreatedBy = "Terraform"
      }

      sg_name     = "vb-jugaad-report-service-sg-${lower(var.environment)}"
      description = "vb-jugaad-report-service-sg-${lower(var.environment)}"
      vpc_id      = var.vpc_id[var.environment] ## replance with your vpc
      dev_service_ingress_sg = [
        {
          from_port       = 3000,
          to_port         = 3000,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [var.internal_lb_sg[var.environment]]
        },
        {
          from_port       = 3000,
          to_port         = 3000,
          description     = "traffic from external load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [module.listeners.sg_id]
        }
        # {
        #   from_port       = 6379,
        #   to_port         = 6385,
        #   description     = "traffic from sidekiq redis",
        #   protocol        = "tcp",
        #   cidr_blocks     = [data.aws_ssm_parameter.sidekiq_trusted_ip.value]
        #   security_groups = null
        # }
      ]
      service_ingress_sg = [
        {
          from_port       = 3000,
          to_port         = 3000,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [var.internal_lb_sg[var.environment]]
        },
        {
          from_port       = 3000,
          to_port         = 3000,
          description     = "traffic from external load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [module.listeners.sg_id]
        }
        # {
        #   from_port       = 6379,
        #   to_port         = 6385,
        #   description     = "traffic from sidekiq redis",
        #   protocol        = "tcp",
        #   cidr_blocks     = null
        #   security_groups = [data.aws_ssm_parameter.sidekiq_trusted_ip.value]
        # }
      ]
      service_egress_sg = [{
        port        = 0,
        description = "anywhere",
        protocol    = "-1",
        cidr_blocks = ["0.0.0.0/0"]
        },
        {
          port        = 0,
          description = "anywhere",
          protocol    = "-1",
          cidr_blocks = ["0.0.0.0/0"]
      }]
      sg_tags = {
        Purpose = "service SG"
      }
      subnets          = var.subnet_ids[var.environment]
      assign_public_ip = false

      require_service_autoscaling = true
      max_capacity = var.services_scaling_max_count["report-service"]
      min_capacity = var.services_scaling_min_count["report-service"]
      cluster_name = module.ecs_cluster["0"].cluster_name

      load_balancer = [{
        target_group_arn = module.target_groups.target_group_arns["vb-jugaad-report-tg-${lower(var.environment)}"]
        container_name   = "vb-jugaad-report-task-definition-${lower(var.environment)}-container"
        container_port   = 3000
      }]

      log_group_name = "/ecs/vb-jugaad-report-service-sg-${lower(var.environment)}"
      log_retention  = 30
      log_tags = {
        Purpose = "log group for service"
      }
      availability_zone_rebalancing = var.environment == "dev" ? "DISABLED" : "ENABLED"
      enable_ecs_managed_tags       = var.environment == "dev" ? false : true

    },
    # announcement-service
    {
      module = "announcement"
      count = var.announcement_resources[var.environment]
      identifier = "announcement-service"
      service_name                       = "vb-jugaad-announcement-be-service-${lower(var.environment)}"
      cluster                            = try(module.ecs_cluster["3"].cluster_arn,null)
      task_definition                    = try(module.ecs_task["5"].task_arn,null)
      desired_count                      = var.services_task_count[var.environment]["announcement-service"]
      deployment_minimum_healthy_percent = 100
      deployment_maximum_percent         = 200
      launch_type                        = "FARGATE"
      scheduling_strategy                = "REPLICA"
      platform_version                   = "LATEST"
      force_new_deployment               = true
      enable_execute_command             = true
      service_tags = {
        CreatedBy = "Terraform"
      }

      sg_name     = "vb-jugaad-announcement-be-service-sg-${lower(var.environment)}"
      description = "vb-jugaad-announcement-be-service-sg-${lower(var.environment)}"
      vpc_id      = var.vpc_id[var.environment] ## replance with your vpc
      dev_service_ingress_sg = [
        {
          from_port       = 80,
          to_port         = 80,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [var.internal_lb_sg[var.environment]]
        },
        {
          from_port       = 80,
          to_port         = 80,
          description     = "traffic from external load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [module.listeners.sg_id]
        }
        # {
        #   from_port       = 6379,
        #   to_port         = 6385,
        #   description     = "traffic from sidekiq redis",
        #   protocol        = "tcp",
        #   cidr_blocks     = [data.aws_ssm_parameter.sidekiq_trusted_ip.value]
        #   security_groups = null
        # }
      ]
      service_ingress_sg = [
        {
          from_port       = 80,
          to_port         = 80,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [var.internal_lb_sg[var.environment]]
        },
        {
          from_port       = 80,
          to_port         = 80,
          description     = "traffic from external load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [module.listeners.sg_id]
        }
        # {
        #   from_port       = 6379,
        #   to_port         = 6385,
        #   description     = "traffic from sidekiq redis",
        #   protocol        = "tcp",
        #   cidr_blocks     = null
        #   security_groups = [data.aws_ssm_parameter.sidekiq_trusted_ip.value]
        # }
      ]
      service_egress_sg = [{
        port        = 0,
        description = "anywhere",
        protocol    = "-1",
        cidr_blocks = ["0.0.0.0/0"]
        },
        {
          port        = 0,
          description = "anywhere",
          protocol    = "-1",
          cidr_blocks = ["0.0.0.0/0"]
      }]
      sg_tags = {
        Purpose = "service SG"
      }
      subnets          = var.subnet_ids[var.environment]
      assign_public_ip = false

      # load_balancer = [{}]
      # require_service_autoscaling = true
      # max_capacity = var.services_scaling_max_count["report-service"]
      # min_capacity = var.services_scaling_min_count["report-service"]
      # cluster_name = module.ecs_cluster["3"].cluster_name

      load_balancer = [{
        target_group_arn = module.target_groups.target_group_arns["vb-jugaad-ysn-reporting-tg-${lower(var.environment)}"]
        container_name   = "vb-jugaad-announcement-be-task-definition-${lower(var.environment)}-container"
        container_port   = 80
      }]

      log_group_name = "/ecs/vb-jugaad-announcement-be-service-${lower(var.environment)}"
      log_retention  = 30
      log_tags = {
        Purpose = "log group for service"
      }
      availability_zone_rebalancing = var.environment == "dev" ? "DISABLED" : "ENABLED"
      enable_ecs_managed_tags       = var.environment == "dev" ? false : true

    },
    # copilot-policy-service
    {
      module = "copilot"
      # identifier = "copilot-policy-service"
      count = var.copilot_resources[var.environment]
      service_name                       = "vb-jugaad-copilot-policy-service-${lower(var.environment)}"
      cluster                            = try(module.ecs_cluster["1"].cluster_arn,null)
      task_definition                    = try(module.ecs_task["6"].task_arn,null)
      desired_count                      = var.services_task_count[var.environment]["copilot-policy-service"]
      deployment_minimum_healthy_percent = 100
      deployment_maximum_percent         = 200
      launch_type                        = "FARGATE"
      scheduling_strategy                = "REPLICA"
      platform_version                   = "LATEST"
      force_new_deployment               = true
      enable_execute_command             = true
      service_tags = {
        CreatedBy = "Terraform"
      }

      sg_name     = "vb-jugaad-copilot-policy-service-sg-${lower(var.environment)}"
      description = "vb-jugaad-copilot-policy-service-sg-${lower(var.environment)}"
      vpc_id      = var.vpc_id[var.environment] ## replance with your vpc
      dev_service_ingress_sg = [
        {
          from_port       = 80,
          to_port         = 80,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [var.internal_lb_sg[var.environment]]
        },
        {
          from_port       = 80,
          to_port         = 80,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = [data.aws_vpc.vpc_cidr.cidr_block]
          security_groups = null
        },
        {
          from_port       = 3000,
          to_port         = 3000,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = [data.aws_vpc.vpc_cidr.cidr_block]
          security_groups = null
        },
        {
          from_port       = 443,
          to_port         = 443,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = [data.aws_vpc.vpc_cidr.cidr_block]
          security_groups = null
        },
        {
          from_port       = 80,
          to_port         = 80,
          description     = "traffic from external load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [module.listeners.sg_id]
        }
        # {
        #   from_port       = 6379,
        #   to_port         = 6385,
        #   description     = "traffic from sidekiq redis",
        #   protocol        = "tcp",
        #   cidr_blocks     = [data.aws_ssm_parameter.sidekiq_trusted_ip.value]
        #   security_groups = null
        # }
      ]
      service_ingress_sg = [
        {
          from_port       = 80,
          to_port         = 80,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [var.internal_lb_sg[var.environment]]
        },
        {
          from_port       = 80,
          to_port         = 80,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = [data.aws_vpc.vpc_cidr.cidr_block]
          security_groups = null
        },
        {
          from_port       = 3000,
          to_port         = 3000,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = [data.aws_vpc.vpc_cidr.cidr_block]
          security_groups = null
        },
        {
          from_port       = 443,
          to_port         = 443,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = [data.aws_vpc.vpc_cidr.cidr_block]
          security_groups = null
        },
        {
          from_port       = 80,
          to_port         = 80,
          description     = "traffic from external load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [module.listeners.sg_id]
        }
        # {
        #   from_port       = 6379,
        #   to_port         = 6385,
        #   description     = "traffic from sidekiq redis",
        #   protocol        = "tcp",
        #   cidr_blocks     = null
        #   security_groups = [data.aws_ssm_parameter.sidekiq_trusted_ip.value]
        # }
      ]
      service_egress_sg = [{
        port        = 0,
        description = "anywhere",
        protocol    = "-1",
        cidr_blocks = ["0.0.0.0/0"]
        },
        {
          port        = 0,
          description = "anywhere",
          protocol    = "-1",
          cidr_blocks = ["0.0.0.0/0"]
      }]
      sg_tags = {
        Purpose = "service SG"
      }
      subnets          = var.subnet_ids[var.environment]
      assign_public_ip = false

      # load_balancer = [{}]

      load_balancer = [{
        target_group_arn = module.target_groups.target_group_arns["vb-jugaad-cp-pol-tg-${lower(var.environment)}"]
        container_name   = "vb-jugaad-cp-policy-task-definition-${lower(var.environment)}-container"
        container_port   = 3000
      }]

      log_group_name = "/ecs/vb-jugaad-copilot-policy-service-sg-${lower(var.environment)}"
      log_retention  = 30
      log_tags = {
        Purpose = "log group for service"
      }
      availability_zone_rebalancing = var.environment == "dev" ? "DISABLED" : "ENABLED"
      enable_ecs_managed_tags       = var.environment == "dev" ? false : true

    },
    # copilot-policy-rag-service
    {
      module = "copilot"
      # identifier = "copilot-policy-rag-service"
      count = var.copilot_resources[var.environment]
      service_name                       = "vb-jugaad-copilot-policy-rag-service-${lower(var.environment)}"
      cluster                            = try(module.ecs_cluster["1"].cluster_arn,null)
      task_definition                    = try(module.ecs_task["7"].task_arn,null)
      desired_count                      = var.services_task_count[var.environment]["copilot-policy-rag-service"]
      deployment_minimum_healthy_percent = 100
      deployment_maximum_percent         = 200
      launch_type                        = "FARGATE"
      scheduling_strategy                = "REPLICA"
      platform_version                   = "LATEST"
      force_new_deployment               = true
      enable_execute_command             = true
      service_tags = {
        CreatedBy = "Terraform"
      }

      sg_name     = "vb-jugaad-copilot-policy-rag-service-sg-${lower(var.environment)}"
      description = "vb-jugaad-copilot-policy-rag-service-sg-${lower(var.environment)}"
      vpc_id      = var.vpc_id[var.environment] ## replance with your vpc
      dev_service_ingress_sg = [
        {
          from_port       = 80,
          to_port         = 80,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [var.internal_lb_sg[var.environment]]
        },
        {
          from_port       = 80,
          to_port         = 80,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = [data.aws_vpc.vpc_cidr.cidr_block]
          security_groups = null
        },
        {
          from_port       = 8000,
          to_port         = 8000,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = [data.aws_vpc.vpc_cidr.cidr_block]
          security_groups = null
        },
        {
          from_port       = 9090,
          to_port         = 9090,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = [data.aws_vpc.vpc_cidr.cidr_block]
          security_groups = null
        },
        {
          from_port       = 443,
          to_port         = 443,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = [data.aws_vpc.vpc_cidr.cidr_block]
          security_groups = null
        },
        {
          from_port       = 80,
          to_port         = 80,
          description     = "traffic from external load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [module.listeners.sg_id]
        }
        # {
        #   from_port       = 6379,
        #   to_port         = 6385,
        #   description     = "traffic from sidekiq redis",
        #   protocol        = "tcp",
        #   cidr_blocks     = [data.aws_ssm_parameter.sidekiq_trusted_ip.value]
        #   security_groups = null
        # }
      ]
      service_ingress_sg = [
        {
          from_port       = 80,
          to_port         = 80,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [var.internal_lb_sg[var.environment]]
        },
        {
          from_port       = 80,
          to_port         = 80,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = [data.aws_vpc.vpc_cidr.cidr_block]
          security_groups = null
        },
        {
          from_port       = 8000,
          to_port         = 8000,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = [data.aws_vpc.vpc_cidr.cidr_block]
          security_groups = null
        },
        {
          from_port       = 9090,
          to_port         = 9090,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = [data.aws_vpc.vpc_cidr.cidr_block]
          security_groups = null
        },
        {
          from_port       = 443,
          to_port         = 443,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = [data.aws_vpc.vpc_cidr.cidr_block]
          security_groups = null
        },
        {
          from_port       = 80,
          to_port         = 80,
          description     = "traffic from external load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [module.listeners.sg_id]
        }
        # {
        #   from_port       = 6379,
        #   to_port         = 6385,
        #   description     = "traffic from sidekiq redis",
        #   protocol        = "tcp",
        #   cidr_blocks     = null
        #   security_groups = [data.aws_ssm_parameter.sidekiq_trusted_ip.value]
        # }
      ]
      service_egress_sg = [{
        port        = 0,
        description = "anywhere",
        protocol    = "-1",
        cidr_blocks = ["0.0.0.0/0"]
        },
        {
          port        = 0,
          description = "anywhere",
          protocol    = "-1",
          cidr_blocks = ["0.0.0.0/0"]
      }]
      sg_tags = {
        Purpose = "service SG"
      }
      subnets          = var.subnet_ids[var.environment]
      assign_public_ip = false

      # load_balancer = [{}]

      load_balancer = [{
        target_group_arn = module.target_groups.target_group_arns["vb-jugaad-cp-pol-rag-tg-${lower(var.environment)}"]
        container_name   = "vb-jugaad-cp-policy-rag-task-definition-${lower(var.environment)}-container"
        container_port   = 8000
      }]

      log_group_name = "/ecs/vb-jugaad-copilot-policy-rag-service-sg-${lower(var.environment)}"
      log_retention  = 30
      log_tags = {
        Purpose = "log group for service"
      }
      availability_zone_rebalancing = var.environment == "dev" ? "DISABLED" : "ENABLED"
      enable_ecs_managed_tags       = var.environment == "dev" ? false : true

    },
    # yosan-management-service
    {
      module = "yosan"
      # identifier = "yosan-management-service"
      count = var.yosan_resources[var.environment]
      service_name                       = "vb-jugaad-yosan-management-be-service-${lower(var.environment)}"
      cluster                            = try(module.ecs_cluster["2"].cluster_arn,null)
      task_definition                    = try(module.ecs_task["8"].task_arn,null)
      desired_count                      = var.services_task_count[var.environment]["yosan-management-service"]
      deployment_minimum_healthy_percent = 100
      deployment_maximum_percent         = 200
      launch_type                        = "FARGATE"
      scheduling_strategy                = "REPLICA"
      platform_version                   = "LATEST"
      force_new_deployment               = true
      enable_execute_command             = true
      service_tags = {
        CreatedBy = "Terraform"
      }

      sg_name     = "vb-jugaad-yosan-management-be-service-sg-${lower(var.environment)}"
      description = "vb-jugaad-yosan-management-be-service-sg-${lower(var.environment)}"
      vpc_id      = var.vpc_id[var.environment] ## replance with your vpc
      dev_service_ingress_sg = [
        {
          from_port       = 80,
          to_port         = 80,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [var.internal_lb_sg[var.environment]]
        },
        {
          from_port       = 80,
          to_port         = 80,
          description     = "traffic from external load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [module.listeners.sg_id]
        },
        {
          from_port       = 80,
          to_port         = 80,
          description     = "traffic from external load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = [data.aws_vpc.vpc_cidr.cidr_block]
          security_groups = null
        },
        {
          from_port       = 443,
          to_port         = 443,
          description     = "traffic from external load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = [data.aws_vpc.vpc_cidr.cidr_block]
          security_groups = null
        }
        # {
        #   from_port       = 6379,
        #   to_port         = 6385,
        #   description     = "traffic from sidekiq redis",
        #   protocol        = "tcp",
        #   cidr_blocks     = [data.aws_ssm_parameter.sidekiq_trusted_ip.value]
        #   security_groups = null
        # }
      ]
      service_ingress_sg = [
        {
          from_port       = 80,
          to_port         = 80,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [var.internal_lb_sg[var.environment]]
        },
        {
          from_port       = 80,
          to_port         = 80,
          description     = "traffic from external load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [module.listeners.sg_id]
        },
        {
          from_port       = 80,
          to_port         = 80,
          description     = "traffic from external load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = [data.aws_vpc.vpc_cidr.cidr_block]
          security_groups = null
        },
        {
          from_port       = 443,
          to_port         = 443,
          description     = "traffic from external load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = [data.aws_vpc.vpc_cidr.cidr_block]
          security_groups = null
        }
        # {
        #   from_port       = 6379,
        #   to_port         = 6385,
        #   description     = "traffic from sidekiq redis",
        #   protocol        = "tcp",
        #   cidr_blocks     = null
        #   security_groups = [data.aws_ssm_parameter.sidekiq_trusted_ip.value]
        # }
      ]
      service_egress_sg = [{
        port        = 0,
        description = "anywhere",
        protocol    = "-1",
        cidr_blocks = ["0.0.0.0/0"]
        },
        {
          port        = 0,
          description = "anywhere",
          protocol    = "-1",
          cidr_blocks = ["0.0.0.0/0"]
      }]
      sg_tags = {
        Purpose = "service SG"
      }
      subnets          = var.subnet_ids[var.environment]
      assign_public_ip = false

      # load_balancer = [{}]

      load_balancer = [{
        target_group_arn = module.target_groups.target_group_arns["vb-jugaad-ysn-manage-tg-${lower(var.environment)}"]
        container_name   = "vb-jugaad-yosan-management-be-task-definition-${lower(var.environment)}-container"
        container_port   = 80
      }]

      log_group_name = "/ecs/vb-jugaad-yosan-management-be-service-sg-${lower(var.environment)}"
      log_retention  = 30
      log_tags = {
        Purpose = "log group for service"
      }
      availability_zone_rebalancing = var.environment == "dev" ? "DISABLED" : "ENABLED"
      enable_ecs_managed_tags       = var.environment == "dev" ? false : true

      require_service_autoscaling = true
      max_capacity = var.services_scaling_max_count["yosan-management-service"]
      min_capacity = var.services_scaling_min_count["yosan-management-service"]
      cluster_name = module.ecs_cluster["2"].cluster_name

    },
    # yosan-reporting-service
    {
      module = "yosan"
      # identifier = "yosan-reporting-service"
      count = var.yosan_resources[var.environment]
      service_name                       = "vb-jugaad-yosan-reporting-be-service-${lower(var.environment)}"
      cluster                            = try(module.ecs_cluster["2"].cluster_arn,null)
      task_definition                    = try(module.ecs_task["9"].task_arn,null)
      desired_count                      = var.services_task_count[var.environment]["yosan-reporting-service"]
      deployment_minimum_healthy_percent = 100
      deployment_maximum_percent         = 200
      launch_type                        = "FARGATE"
      scheduling_strategy                = "REPLICA"
      platform_version                   = "LATEST"
      force_new_deployment               = true
      enable_execute_command             = true
      service_tags = {
        CreatedBy = "Terraform"
      }

      sg_name     = "vb-jugaad-yosan-reporting-be-service-sg-${lower(var.environment)}"
      description = "vb-jugaad-yosan-reporting-be-service-sg-${lower(var.environment)}"
      vpc_id      = var.vpc_id[var.environment] ## replance with your vpc
      dev_service_ingress_sg = [
        {
          from_port       = 80,
          to_port         = 80,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [var.internal_lb_sg[var.environment]]
        },
        {
          from_port       = 80,
          to_port         = 80,
          description     = "traffic from external load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [module.listeners.sg_id]
        }
        # {
        #   from_port       = 6379,
        #   to_port         = 6385,
        #   description     = "traffic from sidekiq redis",
        #   protocol        = "tcp",
        #   cidr_blocks     = [data.aws_ssm_parameter.sidekiq_trusted_ip.value]
        #   security_groups = null
        # }
      ]
      service_ingress_sg = [
        {
          from_port       = 80,
          to_port         = 80,
          description     = "traffic from internal load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [var.internal_lb_sg[var.environment]]
        },
        {
          from_port       = 80,
          to_port         = 80,
          description     = "traffic from external load balancer sg",
          protocol        = "tcp",
          cidr_blocks     = null
          security_groups = [module.listeners.sg_id]
        }
        # {
        #   from_port       = 6379,
        #   to_port         = 6385,
        #   description     = "traffic from sidekiq redis",
        #   protocol        = "tcp",
        #   cidr_blocks     = null
        #   security_groups = [data.aws_ssm_parameter.sidekiq_trusted_ip.value]
        # }
      ]
      service_egress_sg = [{
        port        = 0,
        description = "anywhere",
        protocol    = "-1",
        cidr_blocks = ["0.0.0.0/0"]
        },
        {
          port        = 0,
          description = "anywhere",
          protocol    = "-1",
          cidr_blocks = ["0.0.0.0/0"]
      }]
      sg_tags = {
        Purpose = "service SG"
      }
      subnets          = var.subnet_ids[var.environment]
      assign_public_ip = false

      # load_balancer = [{}]

      load_balancer = [{
        target_group_arn = module.target_groups.target_group_arns["vb-jugaad-ysn-reporting-tg-${lower(var.environment)}"]
        container_name   = "vb-jugaad-yosan-reporting-be-task-definition-${lower(var.environment)}-container"
        container_port   = 80
      }]

      log_group_name = "/ecs/vb-jugaad-yosan-reporting-be-service-sg-${lower(var.environment)}"
      log_retention  = 30
      log_tags = {
        Purpose = "log group for service"
      }
      availability_zone_rebalancing = var.environment == "dev" ? "DISABLED" : "ENABLED"
      enable_ecs_managed_tags       = var.environment == "dev" ? false : true

    }
  ]

  service_configs_map = { for idx, config in local.service_configs : config.service_name => config }

  filtered_service_configs_map = {
    for k, v in local.service_configs_map :
    k => v if v.count > 0
  }
}

# locals {
#   service_configs_map = {
#     for svc in local.service_configs :
#     svc.identifier => svc
#     if var.ecs_services_enabled[svc.identifier] == 1
#   }
# }

module "ecs_service" {
  for_each = local.filtered_service_configs_map
  source   = "../modules/ECS/service"
  # count = each.value.count
  
  service_name                       = each.value.service_name
  cluster                            = try(each.value.cluster,null)
  task_definition                    = try(each.value.task_definition,null)
  desired_count                      = each.value.desired_count
  deployment_minimum_healthy_percent = each.value.deployment_minimum_healthy_percent
  deployment_maximum_percent         = each.value.deployment_maximum_percent
  launch_type                        = each.value.launch_type
  scheduling_strategy                = each.value.scheduling_strategy
  platform_version                   = each.value.platform_version
  force_new_deployment               = each.value.force_new_deployment
  enable_execute_command             = each.value.enable_execute_command
  service_tags                       = each.value.service_tags
  load_balancer                      = each.value.load_balancer

  sg_name            = each.value.sg_name
  description        = each.value.description
  vpc_id             = each.value.vpc_id
  service_ingress_sg = var.environment == "dev" ? each.value.dev_service_ingress_sg : each.value.service_ingress_sg
  service_egress_sg  = each.value.service_egress_sg
  sg_tags            = each.value.sg_tags
  subnets            = each.value.subnets
  assign_public_ip   = each.value.assign_public_ip

  #autoscaling.tf:
  require_service_autoscaling =  try(each.value.require_service_autoscaling,false)
  max_capacity = try(each.value.max_capacity,null)
  min_capacity = try(each.value.min_capacity,null)
  cluster_name = try(each.value.cluster_name,null)

  vendor       = var.vendor
  project_name = var.project_name
  Environment  = var.environment
  module = each.value.module



  log_group_name = each.value.log_group_name
  log_retention  = var.log_group_retention_ecs_service
  # log_retention  = each.value.log_retention
  log_tags       = each.value.log_tags
  depends_on     = [module.listeners]

  availability_zone_rebalancing = each.value.availability_zone_rebalancing

  # enable_autoscaling                 = try(each.value.enable_autoscaling,null)
  # autoscaling_min_capacity           = try(each.value.autoscaling_min_capacity,null)
  # autoscaling_max_capacity           = try(each.value.autoscaling_max_capacity,null)
  # autoscaling_target_cpu_utilization = try(each.value.autoscaling_target_cpu_utilization,null)
}
