# Lambda Module

This module creates an AWS Lambda function that can be packaged either as a container image or a zip file. Optional components such as an ECR repository, S3 bucket, Lambda layer, security group, and function URL are controlled through boolean variables.

## Usage

```hcl
module "lambda" {
  source       = "../modules/lambda"
  identifier   = "example"
  project_name = var.project_name
  vendor       = var.vendor
  Environment  = var.Environment

  package_type     = "Zip"      # or "Image"
  create_lambda    = true
  create_ecr_repo  = true       # only for Image
  create_s3_bucket = true       # only for Zip
  create_layer     = false
  create_layer_bucket = false
  create_sg        = true
  attach_vpc       = true
  vpc_id           = var.vpc_id
  vpc_subnet_ids   = var.subnet_ids

  memory_size = 128
  timeout     = 300
  handler     = "index.handler"
  runtime     = "python3.12"

  environment_variables = {
    ENV = "dev"
  }

  policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  ]
}
```

Toggle the boolean flags as needed to create only the resources you require.
