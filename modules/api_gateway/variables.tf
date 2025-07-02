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

# variable "vpc_id" {
#   description = "The ID of the VPC"
#   type        = string
# }

variable "service_name" {
  description = "The name of the service"
  type        = string
}

# variable "vpc_endpoint_type" {
#   description = "The type of VPC endpoint"
#   type        = string
#   default     = "Interface"
# }

# variable "security_group_ids" {
#   description = "List of security group IDs"
#   type        = list(string)
# }

# variable "subnet_ids" {
#   description = "List of subnet IDs"
#   type        = list(string)
# }

# variable "private_dns_enabled" {
#   description = "Whether private DNS is enabled"
#   type        = bool
#   default     = false
# }

variable "api_gateway_name" {
  description = "The name of the API Gateway"
  type        = string
}

variable "api_gateway_description" {
  description = "The description of the API Gateway"
  type        = string
}

variable "openapi_body" {
  description = "The OpenAPI specification for the API"
  type        = any
}

variable "stage_name" {
  description = "The name of the stage"
  type        = string
  default     = "dev"
}

variable "xray_tracing_enabled" {
  description = "Whether X-Ray tracing is enabled"
  type        = bool
  default     = true
}

variable "metrics_enabled" {
  description = "Whether metrics are enabled"
  type        = bool
  default     = true
}

variable "logging_level" {
  description = "The logging level"
  type        = string
  default     = "INFO"
}

variable "cache_data_encrypted" {
  description = "Whether cache data is encrypted"
  type        = bool
  default     = true
}

variable "log_group_name" {
  description = "The name of the CloudWatch log group"
  type        = string
}

variable "log_group_retention_in_days" {
  description = "The number of days to retain logs"
  type        = number
  default     = 365
}
variable "role_prefix" {
  type = string
}

variable "api_stage_variables" {
  type        = map(any)
  description = "Stage variables for API Gateway stage"
  default     = null
}

variable "binary_media_types" {
  description = "List of binary media types for API Gateway"
  type        = list(string)
  default     = []
}

variable "api_stages" {
  type = list(object({
    name                 = string
    variables            = map(string)
    log_group_name       = string
    retention_in_days    = number
    xray_tracing_enabled = bool
  }))
  description = "List of API Gateway stages with configurations"
}