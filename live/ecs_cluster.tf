#--------------- ECS Cluster Modlue ---------------#
#
#   For all the required ECS Cluster parameters and their use please follow the official documentation
#   Fargate: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/create-cluster-console-v2.html
#   EC2: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/create-ec2-cluster-console-v2.html
#
# ---------- Points to note ----------
# 1. Update `source` path to the actual path of your module.
# 2. The variables 'vendor', 'project_name' and 'environment' must be set in `.tfvars` if used with distributed environment structure.
# 3. All the required and optional variables will go in locals `cluster_configs` as an object.
# 4. Do not add a suffix 'cluster' in the `name` as it is injected in the resource block.
# 5. 'cluster_configuration' is an object containing all the required configs of the cluster.
# 6. Logging behaviour is set to CloudWatch log group. To change it to S3 add 'log_configuration' block inside 'execute_command_configuration' block and pass necessaey arguments.
# 7. For Loggin Valid values: `NONE`, `DEFAULT`, `OVERRIDE`
#

locals {
  cluster_configs = [
    {
      module = "microservices"
      count = var.microservice_resources[var.environment]
      identifier = "microservices"
      container_insights_enabled = true
      cluster_configuration = {
        kms_key_id = data.aws_kms_key.ecs_encrypt_kms_key.id
        execute_command_configuration = {
          logging    = "DEFAULT"
          kms_key_id = data.aws_kms_key.ecs_encrypt_kms_key.id
        }
        managed_storage_configuration = {
          kms_key_id = data.aws_kms_key.ecs_encrypt_kms_key.id
        }
      }
      tags = {
        CreatedBy = "Terraform"
      }
    },
    {
      module = "copilot"
      count = var.copilot_resources[var.environment]
      identifier = "copilot"
      container_insights_enabled = true
      cluster_configuration = {
        kms_key_id = data.aws_kms_key.ecs_encrypt_kms_key.id
        execute_command_configuration = {
          logging    = "DEFAULT"
          kms_key_id = data.aws_kms_key.ecs_encrypt_kms_key.id
        }
        managed_storage_configuration = {
          kms_key_id = data.aws_kms_key.ecs_encrypt_kms_key.id
        }
      }
      tags = {
        CreatedBy = "Terraform"
      }
    },
    {
      module = "yosan"
      count = var.yosan_resources[var.environment]
      identifier = "yosan"
      container_insights_enabled = true
      cluster_configuration = {
        execute_command_configuration = {
          logging    = "DEFAULT"
          kms_key_id = data.aws_kms_key.ecs_encrypt_kms_key.id
        }
        managed_storage_configuration = {
          kms_key_id = data.aws_kms_key.ecs_encrypt_kms_key.id
        }
      }
      tags = {
        CreatedBy = "Terraform"
      }
    },
    {
      module = "announcement"
      count = var.announcement_resources[var.environment]
      identifier = "announcement"
      container_insights_enabled = true
      cluster_configuration = {
        execute_command_configuration = {
          logging    = "DEFAULT"
          kms_key_id = data.aws_kms_key.ecs_encrypt_kms_key.id
        }
        managed_storage_configuration = {
          kms_key_id = data.aws_kms_key.ecs_encrypt_kms_key.id
        }
      }
      tags = {
        CreatedBy = "Terraform"
      }
    }
  ]

  cluster_configs_map = { for idx, config in local.cluster_configs : idx => config }

  filtered_ecs_cluster_configs_map = {
    for k, v in local.cluster_configs_map :
    k => v if v.count > 0
  }
}

module "ecs_cluster" {
  for_each = local.filtered_ecs_cluster_configs_map
  source   = "../modules/ECS/cluster"

  module = each.value.module
  identifier   = each.value.identifier
  environment  = var.environment
  vendor       = var.vendor
  project_name = var.project_name
  container_insights_enabled = each.value.container_insights_enabled
  cluster_configuration = each.value.cluster_configuration
  tags                  = each.value.tags
}

output "cluster_arn" {
  value = module.ecs_cluster["0"].cluster_arn
}