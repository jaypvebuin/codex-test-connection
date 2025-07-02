locals {
  image_lambda_configs = [
    {
      module = "microservices"
      identifier = "authorization"
      count = var.microservice_resources[var.environment]
      #------------- requirements --------------
      required_lambda_function            = true
      required_repo_for_image_lambda      = true
      required_function_url               = false
      required_external_invoke_permission = true
      required_sg_for_lambda              = true

      #------------- lambda.tf -----------------
      compatible_architectures = ["x86_64"]
      #   image_uri                = "351299371214.dkr.ecr.ap-northeast-1.amazonaws.com/vb-belc-ai-allergy-detection:latest"
      memory_size = 128
      timeout     = 30
      environment_variables = {
        SECRET_NAME = "vb-jugaad-authorization-lambda-secrets-${lower(var.environment)}"
      }
      vpc_subnet_ids = var.subnet_ids[var.environment]
      kms_key_arn    = data.aws_kms_key.lambda_encrypt_kms_key.arn
      description    = ""
      #   logging_enable = [
      #     log_group
      #   ]



      #---------------- ecr.tf -------------------
      image_tag_mutability = "MUTABLE"
      scan_on_push         = false

      #------------- iam.tf --------------------
      policy_arn = ["arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole", "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole", "${module.iam_policy["auth-lambda"].policy_arn}"]

      #------------- function_url.tf -----------
      authorization_type = "NONE"
      cors = [
        {
          allow_credentials = true
          allow_origins     = ["*"]
          allow_methods     = ["*"]
          allow_headers     = ["date", "keep-alive"]
          expose_headers    = ["keep-alive", "date"]
          max_age           = 86400
        }
      ]

      #------------- sg.tf ---------------------
      vpc_id = var.vpc_id[var.environment]
      dev_ingress = [
        {
          from_port          = 80,
          to_port            = 80,
          description        = "HTTPS traffic from VPC",
          protocol           = "tcp",
          cidr_blocks        = [data.aws_vpc.vpc_cidr.cidr_block]
          security_group_ids = null
        },
        {
          from_port          = 443,
          to_port            = 443,
          description        = "HTTPS traffic from VPC",
          protocol           = "tcp",
          cidr_blocks        = [data.aws_vpc.vpc_cidr.cidr_block]
          security_group_ids = null
        }
        # {
        #   from_port          = 6379,
        #   to_port            = 6385,
        #   description        = "HTTPS traffic from VPC",
        #   protocol           = "tcp",
        #   cidr_blocks        = [data.aws_ssm_parameter.sidekiq_trusted_ip.value]
        #   security_group_ids = null
        # }
      ]
      ingress = [
        {
          from_port          = 80,
          to_port            = 80,
          description        = "HTTPS traffic from VPC",
          protocol           = "tcp",
          cidr_blocks        = [data.aws_vpc.vpc_cidr.cidr_block]
          security_group_ids = null
        },
        {
          from_port          = 443,
          to_port            = 443,
          description        = "HTTPS traffic from VPC",
          protocol           = "tcp",
          cidr_blocks        = [data.aws_vpc.vpc_cidr.cidr_block]
          security_group_ids = null
        }
        # {
        #   from_port          = 6379,
        #   to_port            = 6385,
        #   description        = "HTTPS traffic from VPC",
        #   protocol           = "tcp",
        #   security_group_ids = [data.aws_ssm_parameter.sidekiq_trusted_ip.value]
        #   cidr_blocks        = null
        # }
      ]
      egress = [{
        port        = 443,
        description = "HTTPS traffic from VPC",
        protocol    = "tcp",
        cidr_blocks = ["0.0.0.0/0"]
        },
        {
          port        = 5432,
          description = "HTTPS traffic from VPC",
          protocol    = "tcp",
          cidr_blocks = [data.aws_vpc.vpc_cidr.cidr_block]
        },
        {
          port        = 80,
          description = "HTTPS traffic from VPC",
          protocol    = "tcp",
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]

      #------------- lambda_permission.tf ------
      action_on_lambda         = "lambda:InvokeFunction"
      service_accessing_lambda = "apigateway.amazonaws.com"
      #   source_arn_of_principal  = "arn:aws:execute-api:ap-northeast-1:905657322432:hrllfsuzjc/*/*/api/v1/app/{proxy+}"
      source_arn_of_principal = module.jugaad_api_gateway["microservices"].arn_value
    },
    {
      module = "copilot"
      identifier = "cp-policy-rag-processor"
      count = var.copilot_resources[var.environment]
      #------------- requirements --------------
      required_lambda_function            = true
      required_repo_for_image_lambda      = true
      required_function_url               = false
      required_external_invoke_permission = false
      required_sg_for_lambda              = true

      #------------- lambda.tf -----------------
      compatible_architectures = ["x86_64"]
      #   image_uri                = "351299371214.dkr.ecr.ap-northeast-1.amazonaws.com/vb-belc-ai-allergy-detection:latest"
      memory_size = 1024
      timeout     = 900
      environment_variables = {
        ENV    = "CENTRAL",
        VENDOR = "vb"
      }
      vpc_subnet_ids = var.subnet_ids[var.environment]
      description    = ""
      kms_key_arn    = data.aws_kms_key.lambda_encrypt_kms_key.arn
      #   logging_enable = [
      #     log_group
      #   ]



      #---------------- ecr.tf -------------------
      image_tag_mutability = "MUTABLE"
      scan_on_push         = false

      #------------- iam.tf --------------------
      policy_arn = ["arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole", "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole", "${module.iam_policy["cp-policy-rag-processor-lambda"].policy_arn}"]

      #------------- function_url.tf -----------
      authorization_type = "NONE"
      cors = [
        {
          allow_credentials = true
          allow_origins     = ["*"]
          allow_methods     = ["*"]
          allow_headers     = ["date", "keep-alive"]
          expose_headers    = ["keep-alive", "date"]
          max_age           = 86400
        }
      ]

      #------------- sg.tf ---------------------
      vpc_id = var.vpc_id[var.environment]
      ingress = [
        {
          from_port   = 80,
          to_port     = 80,
          description = "HTTPS traffic from VPC",
          protocol    = "tcp",
          cidr_blocks = [for s in data.aws_subnet.private_subnet : s.cidr_block]
        },
        {
          from_port   = 443,
          to_port     = 443,
          description = "HTTPS traffic from VPC",
          protocol    = "tcp",
          cidr_blocks = [data.aws_vpc.vpc_cidr.cidr_block]
        }
      ]
      egress = [{
        port        = 0
        description = "HTTPS traffic from VPC",
        protocol    = "-1",
        cidr_blocks = ["0.0.0.0/0"]
      }]

      #------------- lambda_permission.tf ------
      # action_on_lambda         = "lambda:InvokeFunction"
      # service_accessing_lambda = "apigateway.amazonaws.com"
      # #   source_arn_of_principal  = "arn:aws:execute-api:ap-northeast-1:905657322432:hrllfsuzjc/*/*/api/v1/app/{proxy+}"
      # source_arn_of_principal = module.jugaad_api_gateway["microservices"].arn_value
    },
    {
      module = "announcement"
      identifier = "announcement"
      count = var.announcement_resources[var.environment]
      #------------- requirements --------------
      required_lambda_function            = true
      required_repo_for_image_lambda      = true
      required_function_url               = false
      required_external_invoke_permission = false
      required_sg_for_lambda              = true

      #------------- lambda.tf -----------------
      compatible_architectures = ["x86_64"]
      #   image_uri                = "351299371214.dkr.ecr.ap-northeast-1.amazonaws.com/vb-belc-ai-allergy-detection:latest"
      memory_size = 1024
      timeout     = 900
      environment_variables = {
        ENV    = "CENTRAL",
        VENDOR = "vb"
      }
      vpc_subnet_ids = var.subnet_ids[var.environment]
      description    = ""
      kms_key_arn    = data.aws_kms_key.lambda_encrypt_kms_key.arn
      #   logging_enable = [
      #     log_group
      #   ]



      #---------------- ecr.tf -------------------
      image_tag_mutability = "MUTABLE"
      scan_on_push         = false

      #------------- iam.tf --------------------
      policy_arn = ["arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole", "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole", "${module.iam_policy["announcement-lambda"].policy_arn}"]

      #------------- function_url.tf -----------
      authorization_type = "NONE"
      cors = [
        {
          allow_credentials = true
          allow_origins     = ["*"]
          allow_methods     = ["*"]
          allow_headers     = ["date", "keep-alive"]
          expose_headers    = ["keep-alive", "date"]
          max_age           = 86400
        }
      ]

      #------------- sg.tf ---------------------
      vpc_id = var.vpc_id[var.environment]
      ingress = [
        {
          from_port   = 80,
          to_port     = 80,
          description = "HTTPS traffic from VPC",
          protocol    = "tcp",
          cidr_blocks = [for s in data.aws_subnet.private_subnet : s.cidr_block]
        },
        {
          from_port   = 443,
          to_port     = 443,
          description = "HTTPS traffic from VPC",
          protocol    = "tcp",
          cidr_blocks = [data.aws_vpc.vpc_cidr.cidr_block]
        }
      ]
      egress = [{
        port        = 0
        description = "HTTPS traffic from VPC",
        protocol    = "-1",
        cidr_blocks = ["0.0.0.0/0"]
      }]

      #------------- lambda_permission.tf ------
      # action_on_lambda         = "lambda:InvokeFunction"
      # service_accessing_lambda = "apigateway.amazonaws.com"
      # #   source_arn_of_principal  = "arn:aws:execute-api:ap-northeast-1:905657322432:hrllfsuzjc/*/*/api/v1/app/{proxy+}"
      # source_arn_of_principal = module.jugaad_api_gateway["microservices"].arn_value
    }
  ]
  image_lambda_configs_map = { for idx, config in local.image_lambda_configs : config.identifier => config }

  filtered_image_lambda_configs_map = {
    for k, v in local.image_lambda_configs_map :
    k => v if v.count > 0
  }
}


module "image_lambda" {
  for_each = local.filtered_image_lambda_configs_map
  source   = "../modules/Lambda/image"

  module = each.value.module
  identifier   = each.value.identifier
  Environment  = var.environment
  vendor       = var.vendor
  project_name = var.project_name

  #-------------- requirements ---------------
  required_lambda_function            = each.value.required_lambda_function
  required_repo_for_image_lambda      = each.value.required_repo_for_image_lambda
  required_function_url               = each.value.required_function_url
  required_external_invoke_permission = each.value.required_external_invoke_permission
  required_sg_for_lambda              = each.value.required_sg_for_lambda

  #-------------- lambda.tf ------------------
  memory_size              = each.value.memory_size
  timeout                  = each.value.timeout
  description              = each.value.description
  runtime                  = try(each.value.runtime, null)
  compatible_architectures = each.value.compatible_architectures
  vpc_subnet_ids           = each.value.vpc_subnet_ids
  environment_variables    = try(each.value.environment_variables, null)
  image_uri                = try(each.value.image_uri, null)
  kms_key_arn              = each.value.kms_key_arn

  #---------------- ecr.tf -------------------
  image_tag_mutability = each.value.image_tag_mutability
  scan_on_push         = each.value.scan_on_push

  #---------------- iam.tf -------------------
  policy_arn = each.value.policy_arn

  #------------ function_url.tf --------------
  authorization_type = each.value.authorization_type
  cors               = each.value.cors
  #   logging_enable = each.value.logging_enable

  #------------- sg.tf -----------------------
  vpc_id  = each.value.vpc_id
  ingress = var.environment == "dev" ? try(each.value.dev_ingress, each.value.ingress) : each.value.ingress
  egress  = try(each.value.egress, null)

  #------------- lambda_permission.tf --------
  action_on_lambda         = try(each.value.action_on_lambda, null)
  service_accessing_lambda = try(each.value.service_accessing_lambda, null)
  source_arn_of_principal  = try(each.value.source_arn_of_principal, null)
}