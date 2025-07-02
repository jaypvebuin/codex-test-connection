# #--------common variables----------

# variable "project_name" {
#   type    = string
#   default = "project"
# }

# variable "environment" {
#   type    = string
#   default = "test"
# }

# variable "vendor" {
#   type    = string
#   default = "vb"
# }

# variable "identifier" {
#   type = string
# }


variable "project_name" {
  type    = string
  default = ""
}

variable "family" {
  type    = string
  default = ""
}

variable "role_name" {
  type    = string
  default = ""
}

variable "log_group_name" {
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

variable "region" {
  type = string
}

# variable "service_name" {
#   type = string
# }


#-------------------- Task variables ---------------------

variable "network_mode" {
  type    = string
  default = "awsvpc"
}

variable "requires_compatibilities" {
  type    = string
  default = "FARGATE"
}

variable "cpu" {
  type    = number
  default = 512
}

variable "memory" {
  type    = number
  default = 1024
}

variable "policy_arn" {
  type = any
}

variable "module" {
  type    = string
  default = ""
}

# variable "s3_arn" {
#   type = any
# }

variable "container_environment" {

  description = "Environment variables as string"
  type        = list(any)
  default     = []
}

variable "container_secrets" {
  description = "values from secrets manager"
  type        = list(any)
  default     = []
}

variable "container_port" {
  type    = number
  default = 80
}

# variable "protocol" {
#   type    = string
#   default = "tcp"
# }

# variable "container_name" {
#   type    = string
#   default = "test"
# }

variable "container_image" {
  type = string
  default = null
}

# variable "rds_secret_arn" {
#   type = string
# }

# variable "s3_arn" {
#   type = string
# }

# variable "mq_secret_arn" {
#   type = string
# }
variable "log_retention" {
  type    = number
  default = 0
}

variable "log_tags" {
  description = "Tags to be attached to the Log group"
  type        = map(string)
  default = {
    Owner       = "vb"
    Provisioner = "Terraform"
  }
}

variable "task_tags" {
  description = "Tags to be attached to the Log group"
  type        = map(string)
  default = {
    Owner       = "vb"
    Provisioner = "Terraform"
  }
}

variable "role_tags" {
  description = "Tags to be attached to the Log group"
  type        = map(string)
  default = {
    Owner       = "vb"
    Provisioner = "Terraform"
  }
}

variable "port_name" {
  type    = string
  default = null
}

variable "app_protocol" {
  type    = string
  default = null
}

variable "container_definitions" {
  description = "List of ECS container definitions"
  type        = any
}