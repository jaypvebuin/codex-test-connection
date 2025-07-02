# # data "aws_eip" "by_allocation_id" {
# #   id = "eipalloc-0a0ebe34b6efd8440"
# # }

# data "aws_vpc" "example" {
#   id = "vpc-0ce2d52c1b2bf4a92" # Replace with your VPC ID
# }

# data "aws_subnet" "example" {
#   id = "subnet-031cc7855be76c868" # Replace with your existing subnet ID
# }

# data "aws_subnet" "example-1" {
#   id = "subnet-00c9e068efc698da7" # Replace with your existing subnet ID
# }

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# data "aws_ssm_parameter" "sidekiq_trusted_ip" {
#   name = "vb-jugaad-redis-sidekiq-ip-parameter-${var.environment}"
# }

data "aws_ssm_parameter" "auth_header"{
  name = "vb-jugaad-auth-header-${var.environment}"
}

data "aws_ssm_parameter" "auth_header_1"{
  name = "vb-jugaad-auth-header-second-${var.environment}"
}

data "aws_ssm_parameter" "japan_office_ip"{
  name = "japan-office-ip"
}


data "aws_vpc" "vpc_cidr" {
  id = var.vpc_id[var.environment] # Replace with your actual VPC ID
}

data "aws_kms_key" "ecs_encrypt_kms_key" {
  key_id = "alias/Vb-Jugaad-ECS-kms-${var.environment}"
}

data "aws_kms_key" "lambda_encrypt_kms_key" {
  key_id = "alias/Vb-jugaad-lambda-encrypt-decrypt-${var.environment}"
}

data "aws_subnet" "private_subnet" {
  for_each = { for id in var.subnet_ids[var.environment] : id => id }

  id = each.key
}

