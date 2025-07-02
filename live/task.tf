locals {
  task_configs = [
    # apply-approve-task-definition
    {
      module = "microservices"
      count = var.microservice_resources[var.environment]
      log_retention = 30
      log_tags = {
        Purpose = "ECS example task logs"
      }

      family                   = "vb-jugaad-apply-approve-task-definition-${lower(var.environment)}"
      network_mode             = "awsvpc"
      requires_compatibilities = "FARGATE"
      cpu                      = var.services_task_cpu[var.environment]["apply-approve-service"]
      memory                   = var.services_task_memory[var.environment]["apply-approve-service"]
      # container_image          = "${module.ecr["apply-approve-service"].repository_url}:latest"
      # container_port           = 3000
      # port_name                = "vb-jugaad-apply-approve-80-tcp-${lower(var.environment)}"
      # app_protocol             = "http"
      # container_environment = [
      #   {
      #     name  = "AWS_REGION"
      #     value = "ap-northeast-1"
      #   },
      #   {
      #     name  = "AWS_SECRET_NAME"
      #     value = "Vb-Jugaad-ecs-apply-approve-${lower(var.environment)}"
      #   },
      #   {
      #     name  = "LOCAL_ENV"
      #     value = "false"
      #   }
      # ]
      # container_secrets = [
      #   {
      #     name = "SECRET_KEY_BASE"
      #     valueFrom = var.apply_approve_secret_key_base
      #   }
      # ]
      container_definitions = [
        {
          name      = "vb-jugaad-apply-approve-task-definition-${lower(var.environment)}-container"
          image     = "${module.ecr["apply-approve-service"].repository_url}:latest"
          essential = true

          portMappings = [
            {
              protocol      = "tcp"
              containerPort = 3000
              hostPort      = 3000
              name          = "web"
              appProtocol   = "http"
            }
          ]

          environment = [
            { name = "AWS_REGION", value = "ap-northeast-1" },
            { name = "AWS_SECRET_NAME", value = "Vb-Jugaad-ecs-apply-approve-${lower(var.environment)}" },
            { name = "LOCAL_ENV", value = "false" }
          ]
          secrets = var.environment != "dev" ? [
            {
              name      = "SECRET_KEY_BASE"
              valueFrom = var.apply_approve_secret_key_base
            }
          ] : null

          logConfiguration = {
            logDriver = "awslogs"
            options = {
              awslogs-group         = "/ecs/task/vb-jugaad-apply-approve-task-definition-${lower(var.environment)}-logs"
              awslogs-region        = "ap-northeast-1"
              awslogs-stream-prefix = "ecs"
              max-buffer-size       = "25m"
              mode                  = "non-blocking"
              awslogs-create-group  = "true"
            }
          }
        }
      ]
      region = "ap-northeast-1"
      task_tags = {
        CreatedBy = "Terraform"
      }

      role_name  = "vb-jugaad-apply-approve-task-role-${lower(var.environment)}"
      policy_arn = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy", "arn:aws:iam::aws:policy/SecretsManagerReadWrite", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", "${module.iam_policy["apply-approve-task"].policy_arn}", "${module.iam_policy["apply-approve-task-second"].policy_arn}", "${module.iam_policy["mongo-role-assume"].policy_arn}"]
      # policy_arn = var.environment == "prod" ? ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy", "arn:aws:iam::aws:policy/SecretsManagerReadWrite", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"] : ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy", "arn:aws:iam::aws:policy/SecretsManagerReadWrite", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", "${module.iam_policy["apply-approve-task"].policy_arn}", "${module.iam_policy["apply-approve-task-second"].policy_arn}", "${module.iam_policy["mongo-role-assume"].policy_arn}"]      
    },
    # form-details-task-definition
    {
      module = "microservices"
      count = var.microservice_resources[var.environment]
      log_retention = 30
      log_tags = {
        Purpose = "ECS example task logs"
      }

      family                   = "vb-jugaad-form-details-task-definition-${lower(var.environment)}"
      network_mode             = "awsvpc"
      requires_compatibilities = "FARGATE"
      cpu                      = var.services_task_cpu[var.environment]["form-details-service"]
      memory                   = var.services_task_memory[var.environment]["form-details-service"]
      # container_image          = "${module.ecr["form-details-service"].repository_url}:latest"
      # container_port           = 3000
      # port_name                = "vb-jugaad-form-details-80-tcp-${lower(var.environment)}"
      # app_protocol             = "http"
      # container_environment = [
      #   {
      #     name  = "AWS_REGION"
      #     value = "ap-northeast-1"
      #   },
      #   {
      #     name  = "AWS_SECRET_NAME"
      #     value = "Vb-Jugaad-ecs-form-details-${lower(var.environment)}"
      #   },
      #   {
      #     name  = "LOCAL_ENV"
      #     value = "false"
      #   }
      # ]
      # container_secrets = [
      #   {
      #     name = "SECRET_KEY_BASE"
      #     valueFrom = var.form_details_secret_key_base
      #   }
      # ]
      container_definitions = [
        {
          name      = "vb-jugaad-form-details-task-definition-${lower(var.environment)}-container"
          image     = "${module.ecr["form-details-service"].repository_url}:latest"
          essential = true

          portMappings = [
            {
              protocol      = "tcp"
              containerPort = 3000
              hostPort      = 3000
              name          = "web"
              appProtocol   = "http"
            }
          ]

          environment = [
            { name = "AWS_REGION", value = "ap-northeast-1" },
            { name = "AWS_SECRET_NAME", value = "Vb-Jugaad-ecs-form-details-${lower(var.environment)}" },
            { name = "LOCAL_ENV", value = "false" }
          ]
          secrets = var.environment != "dev" ? [
            {
              name      = "SECRET_KEY_BASE"
              valueFrom = var.form_details_secret_key_base
            }
          ] : null

          logConfiguration = {
            logDriver = "awslogs"
            options = {
              awslogs-group         = "/ecs/task/vb-jugaad-form-details-task-definition-${lower(var.environment)}-logs"
              awslogs-region        = "ap-northeast-1"
              awslogs-stream-prefix = "ecs"
              max-buffer-size       = "25m"
              mode                  = "non-blocking"
              awslogs-create-group  = "true"
            }
          }
        }
      ]
      region = "ap-northeast-1"
      task_tags = {
        CreatedBy = "Terraform"
      }

      role_name  = "vb-jugaad-form-details-task-role-${lower(var.environment)}"
      policy_arn = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy", "arn:aws:iam::aws:policy/SecretsManagerReadWrite", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", "${module.iam_policy["form-details-task"].policy_arn}", "${module.iam_policy["form-details-task-second"].policy_arn}", "${module.iam_policy["mongo-role-assume"].policy_arn}"]
      # policy_arn = var.environment == "prod" ? ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy", "arn:aws:iam::aws:policy/SecretsManagerReadWrite", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"] : ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy", "arn:aws:iam::aws:policy/SecretsManagerReadWrite", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", "${module.iam_policy["form-details-task"].policy_arn}", "${module.iam_policy["form-details-task-second"].policy_arn}", "${module.iam_policy["mongo-role-assume"].policy_arn}"]
    },
    # notification-task-definition
    {
      module = "microservices"
      count = var.microservice_resources[var.environment]
      log_retention = 30
      log_tags = {
        Purpose = "ECS example task logs"
      }

      family                   = "vb-jugaad-notification-task-definition-${lower(var.environment)}"
      network_mode             = "awsvpc"
      requires_compatibilities = "FARGATE"
      cpu                      = var.services_task_cpu[var.environment]["notification-service"]
      memory                   = var.services_task_memory[var.environment]["notification-service"]
      # container_image          = "${module.ecr["notification-service"].repository_url}:latest"
      # container_port           = 3000
      # container_environment = [
      #   {
      #     name  = "AWS_REGION"
      #     value = "ap-northeast-1"
      #   },
      #   {
      #     name  = "AWS_SECRET_NAME"
      #     value = "Vb-Jugaad-ecs-notification-${lower(var.environment)}"
      #   },
      #   {
      #     name  = "LOCAL_ENV"
      #     value = "false"
      #   }
      # ]
      # container_secrets = [
      #   {
      #     name = "SECRET_KEY_BASE"
      #     valueFrom = var.notification_secret_key_base
      #   }
      # ]
      container_definitions = [
        {
          name      = "vb-jugaad-notification-task-definition-${lower(var.environment)}-container"
          image     = "${module.ecr["notification-service"].repository_url}:latest"
          essential = true

          portMappings = [
            {
              protocol      = "tcp"
              containerPort = 3000
              hostPort      = 3000
              name          = "web"
              appProtocol   = "http"
            }
          ]

          environment = [
            { name = "AWS_REGION", value = "ap-northeast-1" },
            { name = "AWS_SECRET_NAME", value = "Vb-Jugaad-ecs-notification-${lower(var.environment)}" },
            { name = "LOCAL_ENV", value = "false" }
          ]
          secrets = var.environment != "dev" ? [
            {
              name      = "SECRET_KEY_BASE"
              valueFrom = var.notification_secret_key_base
            }
          ] : null

          logConfiguration = {
            logDriver = "awslogs"
            options = {
              awslogs-group         = "/ecs/task/vb-jugaad-notification-task-definition-${lower(var.environment)}-logs"
              awslogs-region        = "ap-northeast-1"
              awslogs-stream-prefix = "ecs"
              max-buffer-size       = "25m"
              mode                  = "non-blocking"
              awslogs-create-group  = "true"
            }
          }
        }
      ]
      region = "ap-northeast-1"
      task_tags = {
        CreatedBy = "Terraform"
      }

      role_name  = "vb-jugaad-notification-task-role-${lower(var.environment)}"
      policy_arn = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy", "arn:aws:iam::aws:policy/SecretsManagerReadWrite", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", "${module.iam_policy["notification-task"].policy_arn}", "${module.iam_policy["notification-task-second"].policy_arn}", "${module.iam_policy["mongo-role-assume"].policy_arn}"]
      # policy_arn = var.environment == "prod" ? ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy", "arn:aws:iam::aws:policy/SecretsManagerReadWrite", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"] : ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy", "arn:aws:iam::aws:policy/SecretsManagerReadWrite", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", "${module.iam_policy["notification-task"].policy_arn}", "${module.iam_policy["notification-task-second"].policy_arn}", "${module.iam_policy["mongo-role-assume"].policy_arn}"]   
    },
    # pdf-task-definition
    {
      module = "microservices"
      count = var.microservice_resources[var.environment]
      log_retention = 30
      log_tags = {
        Purpose = "ECS example task logs"
      }

      family                   = "vb-jugaad-pdf-task-definition-${lower(var.environment)}"
      network_mode             = "awsvpc"
      requires_compatibilities = "FARGATE"
      cpu                      = var.services_task_cpu[var.environment]["pdf-service"]
      memory                   = var.services_task_memory[var.environment]["pdf-service"]
      # container_image          = "${module.ecr["pdf-service"].repository_url}:latest"
      # container_port           = 3000
      # container_environment = [
      #   {
      #     name  = "AWS_REGION"
      #     value = "ap-northeast-1"
      #   },
      #   {
      #     name  = "AWS_SECRET_NAME"
      #     value = "Vb-Jugaad-ecs-pdf-${lower(var.environment)}"
      #   },
      #   {
      #     name  = "LOCAL_ENV"
      #     value = "false"
      #   }
      # ]
      container_definitions = [
        {
          name      = "vb-jugaad-pdf-task-definition-${lower(var.environment)}-container"
          image     = "${module.ecr["pdf-service"].repository_url}:latest"
          essential = true

          portMappings = [
            {
              protocol      = "tcp"
              containerPort = 3000
              hostPort      = 3000
              name          = "web"
              appProtocol   = "http"
            }
          ]

          environment = [
            { name = "AWS_REGION", value = "ap-northeast-1" },
            { name = "AWS_SECRET_NAME", value = "Vb-Jugaad-ecs-pdf-${lower(var.environment)}" },
            { name = "LOCAL_ENV", value = "false" }
          ]
          # secrets = [
          #   {
          #     name = "SECRET_KEY_BASE"
          #     valueFrom = var.pdf_secret_key_base
          #   }
          # ] 

          logConfiguration = {
            logDriver = "awslogs"
            options = {
              awslogs-group         = "/ecs/task/vb-jugaad-pdf-task-definition-${lower(var.environment)}-logs"
              awslogs-region        = "ap-northeast-1"
              awslogs-stream-prefix = "ecs"
              max-buffer-size       = "25m"
              mode                  = "non-blocking"
              awslogs-create-group  = "true"
            }
          }
        }
      ]
      region = "ap-northeast-1"
      task_tags = {
        CreatedBy = "Terraform"
      }

      role_name  = "vb-jugaad-pdf-task-role-${lower(var.environment)}"
      policy_arn = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy", "arn:aws:iam::aws:policy/SecretsManagerReadWrite", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", "${module.iam_policy["pdf-task"].policy_arn}", "${module.iam_policy["pdf-task-second"].policy_arn}", "${module.iam_policy["mongo-role-assume"].policy_arn}"]
      # policy_arn = var.environment == "prod" ? ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy", "arn:aws:iam::aws:policy/SecretsManagerReadWrite", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"] : ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy", "arn:aws:iam::aws:policy/SecretsManagerReadWrite", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", "${module.iam_policy["pdf-task"].policy_arn}", "${module.iam_policy["pdf-task-second"].policy_arn}", "${module.iam_policy["mongo-role-assume"].policy_arn}"]
    },
    # report-task-definition
    {
      module = "microservices"
      count = var.microservice_resources[var.environment]
      log_retention = 30
      log_tags = {
        Purpose = "ECS example task logs"
      }

      family                   = "vb-jugaad-report-task-definition-${lower(var.environment)}"
      network_mode             = "awsvpc"
      requires_compatibilities = "FARGATE"
      cpu                      = var.services_task_cpu[var.environment]["report-service"]
      memory                   = var.services_task_memory[var.environment]["report-service"]
      # container_image          = "${module.ecr["report-service"].repository_url}:latest"
      # container_port           = 3000
      # container_environment = [
      #   {
      #     name  = "AWS_REGION"
      #     value = "ap-northeast-1"
      #   },
      #   {
      #     name  = "AWS_SECRET_NAME"
      #     value = "Vb-Jugaad-ecs-report-${lower(var.environment)}"
      #   },
      #   {
      #     name  = "LOCAL_ENV"
      #     value = "false"
      #   }
      # ]
      # container_secrets = [
      #   {
      #     name = "SECRET_KEY_BASE"
      #     valueFrom = var.report_secret_key_base
      #   }
      # ]
      container_definitions = [
        {
          name      = "vb-jugaad-report-task-definition-${lower(var.environment)}-container"
          image     = "${module.ecr["report-service"].repository_url}:latest"
          essential = true

          portMappings = [
            {
              protocol      = "tcp"
              containerPort = 3000
              hostPort      = 3000
              name          = "web"
              appProtocol   = "http"
            }
          ]

          environment = [
            { name = "AWS_REGION", value = "ap-northeast-1" },
            { name = "AWS_SECRET_NAME", value = "Vb-Jugaad-ecs-report-${lower(var.environment)}" },
            { name = "LOCAL_ENV", value = "false" }
          ]
          secrets = var.environment != "dev" ? [
            {
              name      = "SECRET_KEY_BASE"
              valueFrom = var.report_secret_key_base
            }
          ] : null

          logConfiguration = {
            logDriver = "awslogs"
            options = {
              awslogs-group         = "/ecs/task/vb-jugaad-report-task-definition-${lower(var.environment)}-logs"
              awslogs-region        = "ap-northeast-1"
              awslogs-stream-prefix = "ecs"
              max-buffer-size       = "25m"
              mode                  = "non-blocking"
              awslogs-create-group  = "true"
            }
          }
        }
      ]
      region = "ap-northeast-1"
      task_tags = {
        CreatedBy = "Terraform"
      }

      role_name  = "vb-jugaad-report-task-role-${lower(var.environment)}"
      policy_arn = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy", "arn:aws:iam::aws:policy/SecretsManagerReadWrite", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", "${module.iam_policy["pdf-task"].policy_arn}", "${module.iam_policy["pdf-task-second"].policy_arn}", "${module.iam_policy["mongo-role-assume"].policy_arn}"]
      # policy_arn = var.environment == "prod" ? ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy", "arn:aws:iam::aws:policy/SecretsManagerReadWrite", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"] : ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy", "arn:aws:iam::aws:policy/SecretsManagerReadWrite", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", "${module.iam_policy["pdf-task"].policy_arn}", "${module.iam_policy["pdf-task-second"].policy_arn}", "${module.iam_policy["mongo-role-assume"].policy_arn}"]
    },
    # announcement-task-definition
    {
      module = "announcement"
      count = var.announcement_resources[var.environment]
      log_retention = 30
      log_tags = {
        Purpose = "ECS example task logs"
      }

      family                   = "vb-jugaad-announcement-be-task-definition-${lower(var.environment)}"
      network_mode             = "awsvpc"
      requires_compatibilities = "FARGATE"
      cpu                      = var.services_task_cpu[var.environment]["announcement-service"]
      memory                   = var.services_task_memory[var.environment]["announcement-service"]
      # container_image          = "${module.ecr["yosan-reporting-be-service"].repository_url}:latest"
      # container_port           = 80
      # container_environment = [
      #   {
      #     name  = "AWS_REGION"
      #     value = "ap-northeast-1"
      #   },
      #   {
      #     name  = "AWS_SECRET_NAME"
      #     value = "jugaad_dev_report"
      #   },
      #   {
      #     name  = "LOCAL_ENV"
      #     value = "false"
      #   }
      # ]
      container_definitions = [
        {
          name      = "vb-jugaad-announcement-be-task-definition-${lower(var.environment)}-container"
          image     = try("${module.ecr["announcement-be-service"].repository_url}:latest",null)
          essential = true

          portMappings = [
            {
              protocol      = "tcp"
              containerPort = 80
              hostPort      = 80
              name          = "web"
              appProtocol   = "http"
            }
          ]

          environment = [
            { name = "AWS_REGION", value = "ap-northeast-1" },
            { name = "AWS_SECRET_NAME", value = "vb-jugaad-announcement-ecs-secrets-${lower(var.environment)}" },
            { name = "LOCAL_ENV", value = "false" }
          ]
          # secrets = [
          #   {
          #     name = "SECRET_KEY_BASE"
          #     valueFrom = var.apply_approve_secret_key_base
          #   }
          # ] 

          logConfiguration = {
            logDriver = "awslogs"
            options = {
              awslogs-group         = "/ecs/task/vb-jugaad-announcement-be-task-definition-${lower(var.environment)}-logs"
              awslogs-region        = "ap-northeast-1"
              awslogs-stream-prefix = "ecs"
              max-buffer-size       = "25m"
              mode                  = "non-blocking"
              awslogs-create-group  = "true"
            }
          }
        }
      ]
      region = "ap-northeast-1"
      task_tags = {
        CreatedBy = "Terraform"
      }

      role_name  = "vb-jugaad-announcement-be-task-role-${lower(var.environment)}"
      policy_arn = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy", "arn:aws:iam::aws:policy/SecretsManagerReadWrite", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", "${module.iam_policy["pdf-task"].policy_arn}", "${module.iam_policy["pdf-task-second"].policy_arn}", "${module.iam_policy["mongo-role-assume"].policy_arn}"]
      # policy_arn = var.environment == "prod" ? ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy", "arn:aws:iam::aws:policy/SecretsManagerReadWrite", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"] : ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy", "arn:aws:iam::aws:policy/SecretsManagerReadWrite", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", "${module.iam_policy["pdf-task"].policy_arn}", "${module.iam_policy["pdf-task-second"].policy_arn}", "${module.iam_policy["mongo-role-assume"].policy_arn}"]
    },
    # cp-policy-task-definition
    {
      module = "copilot"
      count = var.copilot_resources[var.environment]
      log_retention = 30
      log_tags = {
        Purpose = "ECS example task logs"
      }

      family                   = "vb-jugaad-cp-policy-task-definition-${lower(var.environment)}"
      network_mode             = "awsvpc"
      requires_compatibilities = "FARGATE"
      cpu                      = var.services_task_cpu[var.environment]["copilot-policy-service"]
      memory                   = var.services_task_memory[var.environment]["copilot-policy-service"]
      # container_image          = "${module.ecr["copilot-policy-service"].repository_url}:latest"
      # container_port           = 3000
      # container_environment = [
      #   {
      #     name  = "AWS_REGION"
      #     value = "ap-northeast-1"
      #   },
      #   {
      #     name  = "AWS_SECRET_NAME"
      #     value = "jugaad_dev_report"
      #   },
      #   {
      #     name  = "LOCAL_ENV"
      #     value = "false"
      #   }
      # ]
      container_definitions = [
        {
          name      = "vb-jugaad-cp-policy-task-definition-${lower(var.environment)}-container"
          image     = try("${module.ecr["copilot-policy-service"].repository_url}:latest",null)
          essential = true

          portMappings = [
            {
              protocol      = "tcp"
              containerPort = 3000
              hostPort      = 3000
              name          = "web"
              appProtocol   = "http"
            }
          ]

          environment = [
            { name = "AWS_REGION", value = "ap-northeast-1" },
            { name = "AWS_SECRET_NAME", value = "vb-jugaad-copilot-policy-service-${lower(var.environment)}" },
            { name = "LOCAL_ENV", value = "false" }
          ]
          # secrets = [
          #   {
          #     name = "SECRET_KEY_BASE"
          #     valueFrom = var.apply_approve_secret_key_base
          #   }
          # ] 

          logConfiguration = {
            logDriver = "awslogs"
            options = {
              awslogs-group         = "/ecs/task/vb-jugaad-cp-policy-task-definition-${lower(var.environment)}-logs"
              awslogs-region        = "ap-northeast-1"
              awslogs-stream-prefix = "ecs"
              max-buffer-size       = "25m"
              mode                  = "non-blocking"
              awslogs-create-group  = "true"
            }
          }
        }
      ]
      region = "ap-northeast-1"
      task_tags = {
        CreatedBy = "Terraform"
      }

      role_name  = "vb-jugaad-cp-policy-task-role-${lower(var.environment)}"
      policy_arn = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy", "arn:aws:iam::aws:policy/SecretsManagerReadWrite", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", "${module.iam_policy["pdf-task"].policy_arn}", "${module.iam_policy["pdf-task-second"].policy_arn}", "${module.iam_policy["mongo-role-assume"].policy_arn}"]
      # policy_arn = var.environment == "prod" ? ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy", "arn:aws:iam::aws:policy/SecretsManagerReadWrite", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"] : ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy", "arn:aws:iam::aws:policy/SecretsManagerReadWrite", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", "${module.iam_policy["pdf-task"].policy_arn}", "${module.iam_policy["pdf-task-second"].policy_arn}", "${module.iam_policy["mongo-role-assume"].policy_arn}"]
    },
    # cp-policy-rag-task-definition
    {
      module = "copilot"
      count = var.copilot_resources[var.environment]
      log_retention = 30
      log_tags = {
        Purpose = "ECS example task logs"
      }

      family                   = "vb-jugaad-cp-policy-rag-task-definition-${lower(var.environment)}"
      network_mode             = "awsvpc"
      requires_compatibilities = "FARGATE"
      cpu                      = var.services_task_cpu[var.environment]["copilot-policy-rag-service"]
      memory                   = var.services_task_memory[var.environment]["copilot-policy-rag-service"]
      # container_image          = "${module.ecr["copilot-policy-rag-service"].repository_url}:latest"
      # container_port           = 8000
      # container_environment = [
      #   {
      #     name  = "AWS_REGION"
      #     value = "ap-northeast-1"
      #   },
      #   {
      #     name  = "AWS_SECRET_NAME"
      #     value = "jugaad_dev_report"
      #   },
      #   {
      #     name  = "LOCAL_ENV"
      #     value = "false"
      #   }
      # ]
      container_definitions = [
        {
          name      = "vb-jugaad-cp-policy-rag-task-definition-${lower(var.environment)}-container"
          image     = try("${module.ecr["copilot-policy-rag-service"].repository_url}:latest",null)
          essential = true

          portMappings = [
            {
              protocol      = "tcp"
              containerPort = 8000
              hostPort      = 8000
              name          = "vb-jugaad-apply-approve-8000-tcp-${lower(var.environment)}"
              appProtocol   = "http"
            }
          ]

          environment = [
            { name = "AWS_REGION", value = "ap-northeast-1" },
            { name = "AWS_SECRET_NAME", value = "vb-jugaad-copilot-policy-rag-service-${lower(var.environment)}" },
            { name = "ENVIRONMENT", value = var.environment == "dev" ? "development" : var.environment }
          ]
          # secrets = [
          #   {
          #     name = "SECRET_KEY_BASE"
          #     valueFrom = var.apply_approve_secret_key_base
          #   }
          # ] 

          logConfiguration = {
            logDriver = "awslogs"
            options = {
              awslogs-group         = "/ecs/task/vb-jugaad-cp-policy-rag-task-definition-${lower(var.environment)}-logs"
              awslogs-region        = "ap-northeast-1"
              awslogs-stream-prefix = "ecs"
              max-buffer-size       = "25m"
              mode                  = "non-blocking"
              awslogs-create-group  = "true"
            }
          }
        },
        {
          name      = "prometheus"
          image     = try("${module.ecr["copilot-policy-rag-prometheus"].repository_url}:latest",null)
          essential = true

          # portMappings = [
          #   {
          #     protocol      = "tcp"
          #     containerPort = 8000
          #     hostPort      = 8000
          #     name          = "web"
          #     appProtocol   = "http"
          #   }
          # ]

          # environment = [
          #   { name = "AWS_REGION", value = "ap-northeast-1" },
          #   { name = "AWS_SECRET_NAME", value = "vb-jugaad-copilot-policy-rag-service-${lower(var.environment)}" },
          #   { name = "LOCAL_ENV", value = "false" }
          # ]
          # secrets = [
          #   {
          #     name = "SECRET_KEY_BASE"
          #     valueFrom = var.apply_approve_secret_key_base
          #   }
          # ] 

          # logConfiguration = {
          #   logDriver = "awslogs"
          #   options = {
          #     awslogs-group         = "/ecs/task/vb-jugaad-cp-policy-rag-prometheus-task-definition-${lower(var.environment)}-logs"
          #     awslogs-region        = "ap-northeast-1"
          #     awslogs-stream-prefix = "ecs"
          #     max-buffer-size       = "25m"
          #     mode                  = "non-blocking"
          #     awslogs-create-group  = "true"
          #   }
          # }
        },
        {
          name      = "grafana"
          image     = try("${module.ecr["copilot-policy-rag-grafana"].repository_url}:latest",null)
          essential = true

          # portMappings = [
          #   {
          #     protocol      = "tcp"
          #     containerPort = 8000
          #     hostPort      = 8000
          #     name          = "web"
          #     appProtocol   = "http"
          #   }
          # ]

          # environment = [
          #   { name = "AWS_REGION", value = "ap-northeast-1" },
          #   { name = "AWS_SECRET_NAME", value = "vb-jugaad-copilot-policy-rag-service-${lower(var.environment)}" },
          #   { name = "LOCAL_ENV", value = "false" }
          # ]
          # secrets = [
          #   {
          #     name = "SECRET_KEY_BASE"
          #     valueFrom = var.apply_approve_secret_key_base
          #   }
          # ] 

          # logConfiguration = {
          #   logDriver = "awslogs"
          #   options = {
          #     awslogs-group         = "/ecs/task/vb-jugaad-cp-policy-rag-grafana-task-definition-${lower(var.environment)}-logs"
          #     awslogs-region        = "ap-northeast-1"
          #     awslogs-stream-prefix = "ecs"
          #     max-buffer-size       = "25m"
          #     mode                  = "non-blocking"
          #     awslogs-create-group  = "true"
          #   }
          # }
        }
        # {
        #   name      = "vb-jugaad-cp-policy-rag-prometheus-task-definition-${lower(var.environment)}-container"
        #   image     = "${module.ecr["copilot-policy-rag-prometheus"].repository_url}:latest"
        #   essential = false

        #   portMappings = [
        #     {
        #       protocol      = "tcp"
        #       containerPort = 9090
        #       hostPort = 9090
        #       name          = "web"
        #     }
        #   ]
        #   mountPoints = [
        #     {
        #       sourceVolume  = "prometheus-config",
        #       containerPath = "/etc/prometheus/prometheus.yml"
        #     }
        #   ]

        #   environment = [
        #     { name = "AWS_REGION", value = "ap-northeast-1" },
        #     { name = "AWS_SECRET_NAME", value = "vb-jugaad-copilot-policy-rag-${lower(var.environment)}" },
        #     { name = "LOCAL_ENV", value = "false" }
        #   ]
        #   # secrets = [
        #   #   {
        #   #     name = "SECRET_KEY_BASE"
        #   #     valueFrom = var.apply_approve_secret_key_base
        #   #   }
        #   # ] 

        #   logConfiguration = {
        #     logDriver = "awslogs"
        #     options = {
        #       awslogs-group         = "/ecs/task/vb-jugaad-cp-policy-rag-task-definition-${lower(var.environment)}-logs"
        #       awslogs-region        = "ap-northeast-1"
        #       awslogs-stream-prefix = "ecs"
        #       max-buffer-size = "25m"
        #       mode = "non-blocking"
        #       awslogs-create-group  = "true"
        #     }
        #   }
        # }
      ]
      region = "ap-northeast-1"
      task_tags = {
        CreatedBy = "Terraform"
      }

      role_name  = "vb-jugaad-cp-policy-rag-task-role-${lower(var.environment)}"
      policy_arn = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy", "arn:aws:iam::aws:policy/SecretsManagerReadWrite", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", "${module.iam_policy["pdf-task"].policy_arn}", "${module.iam_policy["pdf-task-second"].policy_arn}", "${module.iam_policy["mongo-role-assume"].policy_arn}"]
      # policy_arn = var.environment == "prod" ? ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy", "arn:aws:iam::aws:policy/SecretsManagerReadWrite", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"] : ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy", "arn:aws:iam::aws:policy/SecretsManagerReadWrite", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", "${module.iam_policy["pdf-task"].policy_arn}", "${module.iam_policy["pdf-task-second"].policy_arn}", "${module.iam_policy["mongo-role-assume"].policy_arn}"]
    },
    # yosan-management-task-definition
    {
      module = "yosan"
      count = var.yosan_resources[var.environment]
      log_retention = 30
      log_tags = {
        Purpose = "ECS example task logs"
      }

      family                   = "vb-jugaad-yosan-management-be-task-definition-${lower(var.environment)}"
      network_mode             = "awsvpc"
      requires_compatibilities = "FARGATE"
      cpu                      = var.services_task_cpu[var.environment]["yosan-management-service"]
      memory                   = var.services_task_memory[var.environment]["yosan-management-service"]
      # container_image          = "${module.ecr["yosan-management-be-service"].repository_url}:latest"
      # container_port           = 80
      # container_environment = [
      #   {
      #     name  = "AWS_REGION"
      #     value = "ap-northeast-1"
      #   },
      #   {
      #     name  = "AWS_SECRET_NAME"
      #     value = "jugaad_dev_report"
      #   },
      #   {
      #     name  = "LOCAL_ENV"
      #     value = "false"
      #   },
      #   {
      #     name  = "AWS_S3_BUCKET"
      #     value = "vb-jugaad-budget-files-dev"
      #   },
      #   {
      #     name  = "ENVIRONMENT"
      #     value = "Dev"
      #   },
      #   {
      #     name  = "RDS_CLUSTER_MASTER_SECRET_ARN"
      #     value = "arn:aws:secretsmanager:ap-northeast-1:905657322432:secret:vb-jugaad-yosan-management-ecs-secrets-dev-tz23FB"
      #   },
      # ]
      container_definitions = [
        {
          name      = "vb-jugaad-yosan-management-be-task-definition-${lower(var.environment)}-container"
          image     = try("${module.ecr["yosan-management-be-service"].repository_url}:latest",null)
          essential = true

          portMappings = [
            {
              protocol      = "tcp"
              containerPort = 80
              hostPort      = 80
              name          = "web"
              appProtocol   = "http"
            }
          ]

          environment = [
            { name = "AWS_REGION", value = "ap-northeast-1" },
            { name = "RDS_CLUSTER_MASTER_SECRET_ARN", value = "vb-jugaad-yosan-management-ecs-secrets-${lower(var.environment)}" },
            { name = "LOCAL_ENV", value = "false" },
            { name = "AWS_S3_BUCKET", value = "vb-jugaad-budget-files-${lower(var.environment)}" },
            { name = "ENVIRONMENT", value = var.environment == "prod" ? "Prod" : var.environment == "dev" ? "Dev" : var.environment == "stg" ? "Stg" : var.environment },
            { name = "PORT", value = "80" },
            { name = "ORIGIN_URL", value = var.yosan_task_origin_domain[var.environment] }
          ]
          # secrets = [
          #   {
          #     name = "SECRET_KEY_BASE"
          #     valueFrom = var.apply_approve_secret_key_base
          #   }
          # ] 

          logConfiguration = {
            logDriver = "awslogs"
            options = {
              awslogs-group         = "/ecs/task/vb-jugaad-yosan-management-be-task-definition-${lower(var.environment)}-logs"
              awslogs-region        = "ap-northeast-1"
              awslogs-stream-prefix = "ecs"
              max-buffer-size       = "25m"
              mode                  = "non-blocking"
              awslogs-create-group  = "true"
            }
          }
        }
      ]
      region = "ap-northeast-1"
      task_tags = {
        CreatedBy = "Terraform"
      }

      role_name  = "vb-jugaad-yosan-management-be-task-role-${lower(var.environment)}"
      policy_arn = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy", "arn:aws:iam::aws:policy/SecretsManagerReadWrite", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", "${module.iam_policy["pdf-task"].policy_arn}", "${module.iam_policy["pdf-task-second"].policy_arn}", "${module.iam_policy["mongo-role-assume"].policy_arn}"]
      # policy_arn = var.environment == "prod" ? ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy", "arn:aws:iam::aws:policy/SecretsManagerReadWrite", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"] : ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy", "arn:aws:iam::aws:policy/SecretsManagerReadWrite", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", "${module.iam_policy["pdf-task"].policy_arn}", "${module.iam_policy["pdf-task-second"].policy_arn}", "${module.iam_policy["mongo-role-assume"].policy_arn}"]
    },
    # reporting-task-definition
    {
      module = "yosan"
      count = var.yosan_resources[var.environment]
      log_retention = 30
      log_tags = {
        Purpose = "ECS example task logs"
      }

      family                   = "vb-jugaad-yosan-reporting-be-task-definition-${lower(var.environment)}"
      network_mode             = "awsvpc"
      requires_compatibilities = "FARGATE"
      cpu                      = var.services_task_cpu[var.environment]["yosan-reporting-service"]
      memory                   = var.services_task_memory[var.environment]["yosan-reporting-service"]
      # container_image          = "${module.ecr["yosan-reporting-be-service"].repository_url}:latest"
      # container_port           = 80
      # container_environment = [
      #   {
      #     name  = "AWS_REGION"
      #     value = "ap-northeast-1"
      #   },
      #   {
      #     name  = "AWS_SECRET_NAME"
      #     value = "jugaad_dev_report"
      #   },
      #   {
      #     name  = "LOCAL_ENV"
      #     value = "false"
      #   }
      # ]
      container_definitions = [
        {
          name      = "vb-jugaad-yosan-reporting-be-task-definition-${lower(var.environment)}-container"
          image     = try("${module.ecr["yosan-reporting-be-service"].repository_url}:latest",null)
          essential = true

          portMappings = [
            {
              protocol      = "tcp"
              containerPort = 80
              hostPort      = 80
              name          = "web"
              appProtocol   = "http"
            }
          ]

          environment = [
            { name = "REGION", value = "ap-northeast-1" },
            { name = "SECRET_NAME", value = "Vb-jugaad-yosan-reporting-ecs-secrets-${lower(var.environment)}" },
            { name = "ENVIORNMENT", value = "Dev" },
            {name = "APPSERVER_PORT", value = "80"}
          ]
          # secrets = [
          #   {
          #     name = "SECRET_KEY_BASE"
          #     valueFrom = var.apply_approve_secret_key_base
          #   }
          # ] 

          logConfiguration = {
            logDriver = "awslogs"
            options = {
              awslogs-group         = "/ecs/task/vb-jugaad-yosan-reporting-be-task-definition-${lower(var.environment)}-logs"
              awslogs-region        = "ap-northeast-1"
              awslogs-stream-prefix = "ecs"
              max-buffer-size       = "25m"
              mode                  = "non-blocking"
              awslogs-create-group  = "true"
            }
          }
        }
      ]
      region = "ap-northeast-1"
      task_tags = {
        CreatedBy = "Terraform"
      }

      role_name  = "vb-jugaad-yosan-reporting-be-task-role-${lower(var.environment)}"
      policy_arn = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy", "arn:aws:iam::aws:policy/SecretsManagerReadWrite", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", "${module.iam_policy["pdf-task"].policy_arn}", "${module.iam_policy["pdf-task-second"].policy_arn}", "${module.iam_policy["mongo-role-assume"].policy_arn}"]
      # policy_arn = var.environment == "prod" ? ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy", "arn:aws:iam::aws:policy/SecretsManagerReadWrite", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"] : ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy", "arn:aws:iam::aws:policy/SecretsManagerReadWrite", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", "${module.iam_policy["pdf-task"].policy_arn}", "${module.iam_policy["pdf-task-second"].policy_arn}", "${module.iam_policy["mongo-role-assume"].policy_arn}"]
    }
  ]

  task_configs_map = { for idx, config in local.task_configs : idx => config }

  filtered_task_configs_map = {
    for k, v in local.task_configs_map :
    k => v if v.count > 0
  }
}

module "ecs_task" {
  for_each = local.filtered_task_configs_map
  source   = "../modules/ECS/task"
  module = each.value.module
  # log_retention = each.value.log_retention
  log_retention = var.log_group_retention_ecs_task
  log_tags      = each.value.log_tags

  family                   = each.value.family
  network_mode             = each.value.network_mode
  requires_compatibilities = each.value.requires_compatibilities
  cpu                      = each.value.cpu
  memory                   = each.value.memory
  # container_image          = each.value.container_image
  # container_port           = each.value.container_port
  # container_environment    = each.value.container_environment
  # container_secrets        = var.environment != "dev" ? each.value.container_secrets : null  #try(each.value.container_secrets, null)
  region                = each.value.region
  task_tags             = each.value.task_tags
  container_definitions = each.value.container_definitions

  role_name  = each.value.role_name
  policy_arn = each.value.policy_arn
  depends_on = [module.iam_policy]
}

output "task_arns" {
  value = { for k, v in module.ecs_task : k => v.task_arn }
}