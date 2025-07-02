#--------common variables----------

variable "project_name" {
  type    = string
  default = "project"
}

variable "Environment" {
  type    = string
  default = "test"
}

variable "vendor" {
  type    = string
  default = "vb"
}

variable "identifier" {
  type    = string
  default = ""
}

#------------ lambda.tf ---------------

variable "required_lambda_function" {
  type    = bool
  default = false
}

# variable "lambda_code_package_type" {
#   type = string
#   default = "Zip"
# }

variable "compatible_architectures" {
  type    = list(string)
  default = ["x86_64"]
}

variable "s3_bucket_name" {

}
variable "s3_bucket_key" {
  type    = string
  default = null
}

variable "memory_size" {
  type        = string
  description = "Memory Lambda in MB"
  default     = "256"
}

variable "timeout" {
  type        = string
  description = "Timeout Lambda in Seconds"
  default     = "900"
}

variable "environment_variables" {
  description = "A map that defines environment variables for the Lambda Function."
  type        = map(string)
  default     = {}
}

variable "vpc_subnet_ids" {
  description = "List of subnet ids when Lambda Function should run in the VPC. Usually private or intra subnets."
  type        = list(string)
  default     = null
}

variable "logging_enable" {
  type        = bool
  description = "is advanced logging required"
  default     = false
}

# variable "image_uri" {
#   type    = string
#   default = null
# }

variable "logging_log_group" {
  type    = string
  default = ""
}

variable "logging_log_format" {
  type    = string
  default = ""
}

variable "logging_application_log_level" {
  type    = string
  default = ""
}

variable "logging_system_log_level" {
  type    = string
  default = ""
}

variable "description" {
  type    = string
  default = ""
}

variable "handler" {
  type    = string
  default = null
}

variable "runtime" {
  type    = string
  default = null
}

variable "required_vpc_config" {
  type    = bool
  default = false
}
#------------ iam.tf ------------------

variable "policy_arn" {
  type = list(any)
}

#------------ layers.tf ---------------

variable "required_lambda_layer" {
  type        = bool
  description = "is lambda layer required"
  default     = false
}

variable "required_bucket_for_lambda_layer" {
  type    = bool
  default = false
}

variable "layer_s3_key" {
  type    = string
  default = null
}

# variable "layer_s3_bucket" {
#   type = string
#   default = null
# }

#------------ function_url.tf ---------

variable "required_function_url" {
  type    = bool
  default = false
}

variable "authorization_type" {
  type    = string
  default = "NONE"
}

variable "cors" {
  description = "CORS settings for the lambda function URL"
  default     = [{}]
  type        = any
}

#--------- lambda_permission.tf -------

variable "required_external_invoke_permission" {
  type    = bool
  default = false
}

variable "action_on_lambda" {
  type = string
}

variable "service_accessing_lambda" {
  type = string
}

variable "source_arn_of_principal" {
  type = string
}

#------------ s3_bucket.tf ------------

variable "required_s3_bucket_for_zip_code" {
  type    = bool
  default = false
}

#------------ sg.tf -------------------

variable "required_sg_for_lambda" {
  type    = bool
  default = false
}

variable "vpc_id" {
  type    = string
  default = ""
}

variable "ingress" {
  description = "Ingress rules for the ECS security group."
  default     = [{}]
  type        = any
}

variable "egress" {
  description = "Egress rules for the ECS security group."
  default     = [{}]
  type        = any
}



# ---------------- ecr.tf ------------------

# variable "required_repo_for_image_lambda" {
#   type    = bool
#   default = false
# }

# variable "image_tag_mutability" {
#   type        = string
#   description = "Must be one of: MUTABLE or IMMUTABLE."
#   default     = "MUTABLE"
# }

# variable "scan_on_push" {
#   type        = any
#   description = "(Required) Indicates whether images are scanned after being pushed to the repository"
#   default     = false
# }






