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

variable "module" {
  type    = string
  default = ""
}

variable "codebuild_role_policy_arn" {
  type    = list(any)
  default = []
}



variable "build_compute_type" {
  type    = string
  default = null
}

variable "build_environment_image" {
  type    = string
  default = null
}

variable "build_environment_type" {
  type    = string
  default = null
}

variable "image_pull_credentials_type" {
  type    = string
  default = null
}

variable "privileged_mode" {
  type    = string
  default = null
}

variable "artifact_type" {
  type    = string
  default = null
}

variable "source_type" {
  type    = string
  default = null
}

variable "buildspec_filename" {
  type    = string
  default = null
}

variable "vpc_config" {
  type    = any
  default = [{}]
}

variable "environment_variable" {
  type    = any
  default = [{}]
}

