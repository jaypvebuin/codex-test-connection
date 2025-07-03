# Common identifiers
variable "project_name" { type = string }
variable "Environment" { type = string }
variable "vendor" { type = string }
variable "identifier" { type = string }

# Lambda configuration
variable "package_type" {
  type        = string
  description = "Package type: Zip or Image"
  default     = "Zip"
}
variable "create_lambda" { type = bool, default = true }
variable "architectures" { type = list(string), default = ["x86_64"] }
variable "memory_size" { type = number, default = 256 }
variable "timeout" { type = number, default = 900 }
variable "handler" { type = string, default = null }
variable "runtime" { type = string, default = null }
variable "description" { type = string, default = "" }
variable "environment_variables" { type = map(string), default = {} }

# Package sources
variable "image_uri" { type = string, default = null }
variable "s3_bucket_name" { type = string, default = null }
variable "s3_key" { type = string, default = null }

# Optional resources
variable "create_ecr_repo" { type = bool, default = false }
variable "image_tag_mutability" { type = string, default = "MUTABLE" }
variable "scan_on_push" { type = bool, default = false }

variable "create_s3_bucket" { type = bool, default = false }

variable "create_layer" { type = bool, default = false }
variable "create_layer_bucket" { type = bool, default = false }
variable "layer_s3_key" { type = string, default = null }

variable "create_function_url" { type = bool, default = false }
variable "authorization_type" { type = string, default = "NONE" }
variable "cors" { type = any, default = [{}] }

variable "create_permission" { type = bool, default = false }
variable "action_on_lambda" { type = string, default = "lambda:InvokeFunction" }
variable "service_accessing_lambda" { type = string, default = "" }
variable "source_arn_of_principal" { type = string, default = "" }

variable "create_sg" { type = bool, default = false }
variable "attach_vpc" { type = bool, default = false }
variable "vpc_subnet_ids" { type = list(string), default = null }
variable "vpc_id" { type = string, default = "" }
variable "ingress" { type = any, default = [{}] }
variable "egress" { type = any, default = [{}] }

variable "policy_arns" { type = list(string), default = [] }

# Logging
variable "logging_enable" { type = bool, default = false }
variable "logging_log_group" { type = string, default = "" }
variable "logging_log_format" { type = string, default = "" }
variable "logging_application_log_level" { type = string, default = "" }
variable "logging_system_log_level" { type = string, default = "" }
