variable "s3_bucket_name" {
  type = string
}

# variable "lambda_arn" {
#   type = string
#   default = ""
# }

variable "folders" {
  type    = list(string)
  default = null
}

variable "public" {
  description = "Whether the folders should be public or not"
  type        = bool
  default     = false
}

variable "module" {
  type    = string
  default = ""
}

variable "bucket_policy" {
  description = "Optional S3 bucket policy in JSON format."
  type        = string
  default     = ""
}