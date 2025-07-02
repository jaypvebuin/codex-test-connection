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

# variable "module" {
#   type    = string
#   default = ""
# }



variable "role_name" {
  type        = string
  description = "Name of role"
  default     = "test-role"
}

variable "iam_policy_name" {
  type        = string
  description = "Name of the IAM policy."
  default     = "Vb-test-custom-policy"
}

variable "iam_policy_description" {
  type        = string
  description = "description for the IAM policy."
  default     = "Vb-test-custom-policy"
}

variable "iam_policy_statements" {
  type        = any
  description = "Custom policy for IAM role to attach."
  default     = {}
}

variable "assume_role_principals" {
  type = list(object({
    type        = string
    identifiers = list(string)
  }))
  description = "A mapping of principals to allow to the Assume role policy."
  default = [
    {
      type        = "*"
      identifiers = ["*"]
    }
  ]
}

variable "role_policy_principals" {
  type = list(object({
    type        = string
    identifiers = list(string)
  }))
  description = "A mapping of principals to allow to the role policy."
  default = [
    {
      type        = "*"
      identifiers = ["*"]
    }
  ]
}

variable "role_policy_actions" {
  type        = list(string)
  description = "A list of policy actions to allow to the IAM role."
  default     = ["s3:*"]
}

variable "role_policy_resources" {
  type        = list(string)
  description = "A list of policy resources to allow to the IAM role."
  default     = ["*"]
}

variable "role_policy_arns" {
  type        = set(string)
  description = "A list of policy ARNs to Attach to the IAM role."
  default     = [""]
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the IAM role."
  default = {
    Purpose = "IAM Role testing"
  }
}