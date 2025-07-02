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

variable "create_sg_for_codebuild" {
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