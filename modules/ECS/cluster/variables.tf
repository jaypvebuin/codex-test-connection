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

variable "name" {
  type    = string
  default = ""
}

variable "Environment" {
  type    = string
  default = ""
}

variable "maintainer" {
  type    = string
  default = ""
}


variable "cluster_configuration" {
  description = "configurations for the cluster"
  type        = any
  default     = {}
}

variable "tags" {
  description = "Tags to be attached to the cluster"
  type        = map(string)
  default = {
    Owner       = "vb"
    Provisioner = "Terraform"
  }
}

variable "cloud_watch_log_group_name" {
  type    = string
  default = "test-log"
}

variable "container_insights_enabled" {
  type        = bool
  default     = false
  description = "Whether to enable ECS Container Insights"
}