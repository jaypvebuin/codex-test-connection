# Common points to consider:
#    1. The variables which are common and whose values are also same for all the file then it should be defined in tfvars.

# 1. The below code is applicable for both ZIP and Image type lambda.
# 2. In the locals variable, both type of lambdas are created, the first one is for Image type and following one is of Zip type.
# 3. Here two lambdas will be created, as two local variables are only present. It can be changed as per the requirement.
# 4. To add more lambdas, just copy and paste one of the local variable, and change the variable's value according to the requirement.
# 5. Most important: 
#    To create image type lambdas:
#       1. First create the ECR repo only... (i.e change the required variable of ECR repo to true and keep all the other required variable to false.)
#       2. Then push the image from your local computer to the repo... (inshort push the image to the newly repo created in the above step, so that it can be used by the lambda.)
#       3. Then create all the other resources.. (change the flags (required bool type variables) to true .. so that it will create all the other resources including lambda... and also do not forget to place the image uri of the newly pushed image into the code, so that it can be refernced. )
#    To create zip type lambdas:
#       1. To handle zip and layers , the code contains two separate buckets for each .. so if it needs to be created, then it should be implemented in below order.
#       2. First change the flag/required variable of bucket for zip and layer to true which will first create buckets only... 
#       3. Then upload the respective zip files in each bucket.
#       4. Then change the flags of all the other resources to true and then run the code, which will create all the other resources which were dependent to both the buckets.
#
# 6. The variables environment | project_name | vendor are being passed through variables (i.e default value or tfvars) but if you want separate value to be passed for each object, then change it to each.value.{name_of_variable} 
#
locals {
  image_lambda_configs = [
    {
      identifier = "image"
      project_name = var.project_name
      vendor = var.vendor

      #------------- requirements --------------
      required_lambda_function            = false
      required_repo_for_image_lambda = true
      required_function_url               = false
      required_external_invoke_permission = false
      required_sg_for_lambda = false

      #------------- lambda.tf -----------------
      compatible_architectures = ["x86_64"]
      image_uri                = "351299371214.dkr.ecr.ap-northeast-1.amazonaws.com/vb-belc-ai-allergy-detection:latest"
      memory_size              = 128
      timeout                  = 300
      environment_variables = {
        ENV    = "CENTRAL",
        VENDOR = "vb"
      }
      vpc_subnet_ids = null
      description = ""

      #---------------- ecr.tf -------------------
      image_tag_mutability = "MUTABLE" 
      scan_on_push = false

      #------------- iam.tf --------------------
      policy_arn = ["arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole","arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]

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
      vpc_id  = null
      ingress = [{
      port        = 443,
      description = "HTTPS traffic from VPC",
      protocol    = "tcp",
      cidr_blocks = ["11.0.0.0/16"]
      }]
      egress  = [{
      port        = 443,
      description = "HTTPS traffic from VPC",
      protocol    = "tcp",
      cidr_blocks = ["0.0.0.0/0"]
      }]

      #------------- lambda_permission.tf ------
      action_on_lambda         = "lambda:InvokeFunction"
      service_accessing_lambda = "events.amazonaws.com"
      source_arn_of_principal  = "arn:aws:events:ap-northeast-1:372296823591:rule/test"
    }
  ]
  image_lambda_configs_map = { for idx, config in local.image_lambda_configs : config.identifier => config }
}

locals {
  zip_lambda_configs = [
    {
      identifier = "zip"
      project_name = var.project_name
      vendor = var.vendor

      #------------- requirements --------------
      required_lambda_function            = true
      required_lambda_layer               = true
      required_bucket_for_lambda_layer = true
      required_function_url               = true
      required_external_invoke_permission = true
      required_s3_bucket_for_zip_code = false
      required_sg_for_lambda = true

      #------------- lambda.tf -----------------
      lambda_code_package_type = "Zip"
      compatible_architectures = ["x86_64"]
      memory_size              = 128
      timeout                  = 300
      environment_variables    = {}
      vpc_subnet_ids           = ["subnet-049d4f551025dc34b", "subnet-0aa6502955c9f9d85"]
      description = ""
      s3_bucket_name = "vbs3lambdabucket"
      s3_bucket_key = "lambda_function/index.zip"
      handler = "lambda_handler"
      runtime = "python3.12"

      #------------- iam.tf --------------------
      policy_arn = ["arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole","arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]

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

      #------------- layers.tf -----------------
      # layer_s3_bucket = "vbs3lambdabucket"
      layer_s3_key    = "goyoyaku_pg_layer.zip"

      #------------- s3_bucket.tf --------------
      lambda_code_package_type = "Zip"

      #------------- sg.tf ---------------------
      vpc_id  = "vpc-04b382fefbca5a076"
      ingress = [{
        port        = 443,
        description = "Allow all ports",
        protocol    = "tcp",
        cidr_blocks = ["0.0.0.0/0"]
      }]
      egress  = [{
        port        = 443,
        description = "Allow all ports",
        protocol    = "tcp",
        cidr_blocks = ["0.0.0.0/0"]
      }]

      #------------- lambda_permission.tf ------
      action_on_lambda         = "lambda:InvokeFunction"
      service_accessing_lambda = "events.amazonaws.com"
      source_arn_of_principal  = "arn:aws:events:ap-northeast-1:372296823591:rule/test"
    }
  ]
  zip_lambda_configs_map = {for idx, config in local.zip_lambda_configs : config.identifier => config}
}

module "image_lambda" {
  for_each = local.image_lambda_configs_map
  source   = "../modules/Lambda/image"

  identifier = each.value.identifier
  Environment = var.environment                         
  vendor = var.vendor                                   
  project_name = var.project_name                       
  
  #-------------- requirements ---------------
  required_lambda_function            = each.value.required_lambda_function
  required_repo_for_image_lambda = each.value.required_repo_for_image_lambda
  required_function_url               = each.value.required_function_url
  required_external_invoke_permission = each.value.required_external_invoke_permission
  required_sg_for_lambda = each.value.required_sg_for_lambda

  #-------------- lambda.tf ------------------
  memory_size              = each.value.memory_size
  timeout                  = each.value.timeout
  description              = each.value.description
  runtime                  = try(each.value.runtime, null)
  compatible_architectures = each.value.compatible_architectures
  vpc_subnet_ids           = each.value.vpc_subnet_ids
  environment_variables = each.value.environment_variables
  image_uri                = try(each.value.image_uri, null)

  #---------------- ecr.tf -------------------
  image_tag_mutability = each.value.image_tag_mutability
  scan_on_push = each.value.scan_on_push

  #---------------- iam.tf -------------------
  policy_arn = each.value.policy_arn

  #------------ function_url.tf --------------
  authorization_type = each.value.authorization_type
  cors               = each.value.cors

  #------------- sg.tf -----------------------
  vpc_id  = each.value.vpc_id
  ingress = try(each.value.ingress,null)
  egress  = try(each.value.egress,null)

  #------------- lambda_permission.tf --------
  action_on_lambda         = each.value.action_on_lambda
  service_accessing_lambda = each.value.service_accessing_lambda
  source_arn_of_principal  = each.value.source_arn_of_principal
}

module "zip_lambda" {
  for_each = local.zip_lambda_configs_map
  source   = "../modules/Lambda/zip"
  
  identifier = each.value.identifier
  Environment = var.environment                         
  vendor = var.vendor                                   
  project_name = var.project_name  

  #-------------- requirements ---------------
  required_lambda_function            = each.value.required_lambda_function
  required_function_url               = each.value.required_function_url
  required_external_invoke_permission = each.value.required_external_invoke_permission
  required_lambda_layer               = each.value.required_lambda_layer
  required_s3_bucket_for_zip_code     = each.value.required_s3_bucket_for_zip_code
  required_sg_for_lambda = each.value.required_sg_for_lambda
  required_bucket_for_lambda_layer = each.value.required_bucket_for_lambda_layer

  #-------------- lambda.tf ------------------
  memory_size              = each.value.memory_size
  timeout                  = each.value.timeout
  description              = each.value.description
  runtime                  = try(each.value.runtime, null)
  handler = each.value.handler
  compatible_architectures = each.value.compatible_architectures
  vpc_subnet_ids           = each.value.vpc_subnet_ids
  environment_variables = each.value.environment_variables
  s3_bucket_key            = try(each.value.s3_bucket_key, null)
  s3_bucket_name = each.value.s3_bucket_name

  #---------------- iam.tf -------------------
  policy_arn = each.value.policy_arn

  #------------ function_url.tf --------------
  authorization_type = each.value.authorization_type
  cors               = each.value.cors

  #------------- layers.tf -------------------
  layer_s3_key = each.value.layer_s3_key

  #------------- s3_bucket.tf ----------------

  #------------- sg.tf -----------------------
  vpc_id  = each.value.vpc_id
  ingress = try(each.value.ingress,null)
  egress  = try(each.value.egress,null)

  #------------- lambda_permission.tf --------
  action_on_lambda         = each.value.action_on_lambda
  service_accessing_lambda = each.value.service_accessing_lambda
  source_arn_of_principal  = each.value.source_arn_of_principal
}

