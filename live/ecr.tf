########--------------- ECR Modlue ---------------#########
#
#  For all the required ECR parameters and their use please follow the official documentation.
#  https://docs.aws.amazon.com/AmazonECR/latest/userguide/repository-create.html
#
# ---------- Points to note ----------
# 1. Update `source` path to the actual path of your module.
# 2. The variables 'vendor', 'project_name' and 'environment' must be set in `.tfvars` if used with distributed environment structure.
# 3. All the required and optional variables will go in locals `ecr_configs` as an object.
# 4. Repository name must start with a letter and can only contain lowercase letters, numbers, hyphens, underscores, and forward slashes.
# 5. Set `scan_on_push` this true if scanning required on every push.
# 6. For `image_tag_mutability` Possible values are 'MUTABLE' or 'IMMUTABLE'.
#

locals {
  ecr_configs = [

    {
      module = "microservices"
      count = var.microservice_resources[var.environment]
      identifier           = "apply-approve-service"
      scan_on_push         = false
      image_tag_mutability = "MUTABLE"
      #---- Services specific tags must go here ----#
      tags = {
        CreatedBy = "Terraform"
      }
    },
    {
      module = "microservices"
      count = var.microservice_resources[var.environment]
      identifier           = "form-details-service"
      scan_on_push         = false
      image_tag_mutability = "MUTABLE"
      #---- Services specific tags must go here ----#
      tags = {
        CreatedBy = "Terraform"
      }
    },
    {
      module = "microservices"
      count = var.microservice_resources[var.environment]
      identifier           = "notification-service"
      scan_on_push         = false
      image_tag_mutability = "MUTABLE"
      #---- Services specific tags must go here ----#
      tags = {
        CreatedBy = "Terraform"
      }
    },
    {
      module = "microservices"
      count = var.microservice_resources[var.environment]
      identifier           = "pdf-service"
      scan_on_push         = false
      image_tag_mutability = "MUTABLE"
      #---- Services specific tags must go here ----#
      tags = {
        CreatedBy = "Terraform"
      }
    },
    {
      module = "microservices"
      count = var.microservice_resources[var.environment]
      identifier           = "report-service"
      scan_on_push         = false
      image_tag_mutability = "MUTABLE"
      #---- Services specific tags must go here ----#
      tags = {
        CreatedBy = "Terraform"
      }
    },
    {
      module = "announcement"
      count = var.announcement_resources[var.environment]
      identifier           = "announcement-be-service"
      scan_on_push         = false
      image_tag_mutability = "MUTABLE"
      #---- Services specific tags must go here ----#
      tags = {
        CreatedBy = "Terraform"
      }
    },
    {
      module = "copilot"
      count = var.copilot_resources[var.environment]
      identifier           = "copilot-policy-service"
      scan_on_push         = false
      image_tag_mutability = "MUTABLE"
      #---- Services specific tags must go here ----#
      tags = {
        CreatedBy = "Terraform"
      }
    },
    {
      module = "copilot"
      count = var.copilot_resources[var.environment]
      identifier           = "copilot-policy-rag-service"
      scan_on_push         = false
      image_tag_mutability = "MUTABLE"
      #---- Services specific tags must go here ----#
      tags = {
        CreatedBy = "Terraform"
      }
    },
    {
      module = "yosan"
      count = var.yosan_resources[var.environment]
      identifier           = "yosan-management-be-service"
      scan_on_push         = false
      image_tag_mutability = "MUTABLE"
      #---- Services specific tags must go here ----#
      tags = {
        CreatedBy = "Terraform"
      }
    },
    {
      module = "yosan"
      count = var.yosan_resources[var.environment]
      identifier           = "yosan-reporting-be-service"
      scan_on_push         = false
      image_tag_mutability = "MUTABLE"
      #---- Services specific tags must go here ----#
      tags = {
        CreatedBy = "Terraform"
      }
    },
    {
      module = "copilot"
      count = var.copilot_resources[var.environment]
      identifier           = "copilot-policy-rag-redis"
      scan_on_push         = false
      image_tag_mutability = "MUTABLE"
      #---- Services specific tags must go here ----#
      tags = {
        CreatedBy = "Terraform"
      }
    },
    {
      module = "copilot"
      count = var.copilot_resources[var.environment]
      identifier           = "copilot-policy-rag-grafana"
      scan_on_push         = false
      image_tag_mutability = "MUTABLE"
      #---- Services specific tags must go here ----#
      tags = {
        CreatedBy = "Terraform"
      }
    },
    {
      module = "copilot"
      count = var.copilot_resources[var.environment]
      identifier           = "copilot-policy-rag-prometheus"
      scan_on_push         = false
      image_tag_mutability = "MUTABLE"
      #---- Services specific tags must go here ----#
      tags = {
        CreatedBy = "Terraform"
      }
    },
    {
      module = "copilot"
      count = var.copilot_resources[var.environment]
      identifier           = "copilot-policy-rag-redis-exporter"
      scan_on_push         = false
      image_tag_mutability = "MUTABLE"
      #---- Services specific tags must go here ----#
      tags = {
        CreatedBy = "Terraform"
      }
    }
  ]

  ecr_configs_map = { for idx, config in local.ecr_configs : config.identifier => config }

  filtered_ecr_configs_map = {
    for k, v in local.ecr_configs_map :
    k => v if v.count > 0
  }
}

module "ecr" {
  for_each = local.filtered_ecr_configs_map
  source   = "../modules/ECR"

  module = each.value.module
  identifier   = each.value.identifier
  environment  = var.environment
  vendor       = var.vendor
  project_name = var.project_name
  image_preserve_count = var.image_preserve_count

  scan_on_push = each.value.scan_on_push
  tags         = each.value.tags
}

# output "url" {
#   value = module.ecr["apply-approve-service"].repository_url
# }