#--------common variables----------

variable "project_name" {
  type    = string
  default = "project"
}

variable "environment" {
  type    = string
  default = "test"
}

variable "vendor" {
  type    = string
  default = "vb"
}

variable "identifier" {
  type = string
}

variable "module" {
  type    = string
  default = ""
}

variable "image_preserve_count" {
  type = number 
}



# variable "name" {
#   type        = string
#   description = "Name of ECR"
#   default     = "test-ecr"
# }

variable "scan_on_push" {
  type        = any
  description = "(Required) Indicates whether images are scanned after being pushed to the repository"
  default     = false
}

variable "image_tag_mutability" {
  type        = string
  description = "Must be one of: MUTABLE or IMMUTABLE."
  default     = "MUTABLE"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the ECR."
  default = {
    Purpose = "For testing ECR module"
  }
}