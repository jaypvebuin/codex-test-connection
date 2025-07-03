locals {
  lambda_configs = [
    {
      identifier        = "image"
      package_type      = "Image"
      create_lambda     = true
      create_ecr_repo   = true
      create_function_url = false
      create_permission = false
      create_sg         = false
      attach_vpc        = false
      architectures     = ["x86_64"]
      image_uri         = "351299371214.dkr.ecr.ap-northeast-1.amazonaws.com/vb-belc-ai-allergy-detection:latest"
      memory_size       = 128
      timeout           = 300
      environment_variables = { ENV = "CENTRAL" }
    },
    {
      identifier           = "zip"
      package_type         = "Zip"
      create_lambda        = true
      create_function_url  = true
      create_permission    = true
      create_layer         = true
      create_layer_bucket  = true
      create_sg            = true
      attach_vpc           = true
      vpc_id               = "vpc-04b382fefbca5a076"
      vpc_subnet_ids       = ["subnet-049d4f551025dc34b", "subnet-0aa6502955c9f9d85"]
      architectures        = ["x86_64"]
      memory_size          = 128
      timeout              = 300
      s3_bucket_name       = "vbs3lambdabucket"
      s3_key               = "lambda_function/index.zip"
      handler              = "lambda_handler"
      runtime              = "python3.12"
      layer_s3_key         = "goyoyaku_pg_layer.zip"
      ingress = [{
        port        = 443
        description = "Allow all"
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }]
      egress = [{
        port        = 443
        description = "Allow all"
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }]
    }
  ]

  lambda_configs_map = { for cfg in local.lambda_configs : cfg.identifier => cfg }
}

module "lambda" {
  for_each   = local.lambda_configs_map
  source     = "../modules/lambda"

  identifier   = each.value.identifier
  project_name = var.project_name
  vendor       = var.vendor
  Environment  = var.Environment

  package_type         = each.value.package_type
  create_lambda        = each.value.create_lambda
  create_ecr_repo      = try(each.value.create_ecr_repo, false)
  create_s3_bucket     = try(each.value.create_s3_bucket, false)
  create_layer         = try(each.value.create_layer, false)
  create_layer_bucket  = try(each.value.create_layer_bucket, false)
  create_function_url  = try(each.value.create_function_url, false)
  create_permission    = try(each.value.create_permission, false)
  create_sg            = try(each.value.create_sg, false)
  attach_vpc           = try(each.value.attach_vpc, false)

  architectures        = each.value.architectures
  memory_size          = each.value.memory_size
  timeout              = each.value.timeout
  environment_variables = try(each.value.environment_variables, {})
  description          = try(each.value.description, "")
  image_uri            = try(each.value.image_uri, null)
  s3_bucket_name       = try(each.value.s3_bucket_name, null)
  s3_key               = try(each.value.s3_key, null)
  handler              = try(each.value.handler, null)
  runtime              = try(each.value.runtime, null)
  vpc_subnet_ids       = try(each.value.vpc_subnet_ids, null)
  vpc_id               = try(each.value.vpc_id, "")
  ingress              = try(each.value.ingress, [{}])
  egress               = try(each.value.egress, [{}])
  layer_s3_key         = try(each.value.layer_s3_key, null)

  policy_arns          = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]

  authorization_type   = try(each.value.authorization_type, "NONE")
  cors                 = try(each.value.cors, null)

  action_on_lambda         = try(each.value.action_on_lambda, "lambda:InvokeFunction")
  service_accessing_lambda = try(each.value.service_accessing_lambda, "")
  source_arn_of_principal  = try(each.value.source_arn_of_principal, "")
}
