variable "project_name" {
  type    = string
  default = ""
}

variable "Environment" {
  type    = string
  default = ""
}

variable "vendor" {
  type    = string
  default = ""
}

variable "module" {
  type    = string
  default = ""
}

variable "launch_type" {
  type    = string
  default = "FARGATE"
}


variable "desired_count" {
  type    = number
  default = 1
}

variable "deployment_minimum_healthy_percent" {
  type    = number
  default = 100
}

variable "deployment_maximum_percent" {
  type    = number
  default = 200
}

variable "tg_port" {
  type    = number
  default = 80
}

variable "listener_port" {
  type    = number
  default = 80
}

variable "tg_protocol" {
  type    = string
  default = "TCP"
}

variable "listener_protocol" {
  type    = string
  default = "TCP"
}


variable "scheduling_strategy" {
  type    = string
  default = "REPLICA"
}

variable "security_groups" {
  type    = list(string)
  default = [""]

}

variable "subnets" {
  type    = list(string)
  default = [""]
}

# variable "tags" {
#   type    = map(string)
#   default = {}
# }

variable "cluster" {
  type = string
}

variable "task_definition" {
  type    = string
  default = ""
}

variable "assign_public_ip" {
  type    = bool
  default = false
}

variable "platform_version" {
  type    = string
  default = ""
}

variable "force_new_deployment" {
  type    = bool
  default = false
}

variable "service_name" {
  type = string
}

# ------------- Load Balancer -----------------#
# variable "create_nlb" {
#   type    = bool
#   default = true
# }

variable "create_alb" {
  type    = bool
  default = true
}

variable "create_tg" {
  type    = bool
  default = true
}

variable "create_listener" {
  type    = bool
  default = true
}

variable "lb_name" {
  type    = string
  default = "belc_LB"
}

variable "internal" {
  type    = bool
  default = false
}

variable "container_port" {
  type    = number
  default = 80
}

variable "log_prefix" {
  type    = string
  default = ""
}

variable "subnet_ids" {
  type    = list(string)
  default = []
}

variable "expose_to_public_internet" {
  type    = bool
  default = true
}

variable "enable_cross_zone_load_balancing" {
  type    = bool
  default = true
}

variable "lb_sg_name" {
  type    = string
  default = "belc_lb_sg"
}

variable "description" {
  type    = string
  default = "belc_lb_sg"
}

variable "vpc_id" {
  type    = string
  default = null
}

variable "lb_ingress_sg" {
  default = [{}]
  type    = any
}

variable "lb_ingress_sg_https" {
  default = [{}]
  type    = any
}

variable "lb_egress_sg" {
  default = [{}]
  type    = any
}

variable "lb_tags" {
  type = map(string)
  default = {
    Name = "belc_LB"
  }
}

variable "vpc_cidr" {
  type    = any
  default = ""
}

variable "service_ingress_sg" {
  default = [{}]
  type    = any
}

variable "service_egress_sg" {
  default = [{}]
  type    = any
}

# variable "prefix_list_ids" {
#   type = string
# }

variable "certificate_arn" {
  type        = string
  description = "ACM SSL certrificate ARN"
  default     = null
}


variable "max_capacity" {
  type        = number
  description = "autoscaling maximum capacity"
  default     = null
}


variable "min_capacity" {
  type        = number
  description = "autoscaling maximum capacity"
  default     = null
}

variable "cluster_name" {
  type        = string
  description = "cluster name"
  default     = null
}

variable "name" {
  type        = string
  description = "service name"
  default     = null
}

variable "sg_name" {
  type        = string
  description = "SG name"
  default     = null
}

variable "log_group_name" {
  type        = string
  description = "Log group name"
  default     = null
}

variable "enable_execute_command" {
  type    = bool
  default = true
}

variable "load_balancer" {
  default = []
  type = list(object({
    target_group_arn = string
    container_name   = string
    container_port   = number
  }))
}

variable "target_group_arn" {
  type    = string
  default = null
}

# variable "tag-project_name"{
#    type = string
#  }

variable "log_retention" {
  type    = number
  default = 0
}

variable "service_tags" {
  description = "Tags to be attached to the service"
  type        = map(string)
  default = {
    Owner       = "vb"
    Provisioner = "Terraform"
  }
}

variable "sg_tags" {
  description = "Tags to be attached to the Sg"
  type        = map(string)
  default = {
    Owner       = "vb"
    Provisioner = "Terraform"
  }
}

variable "log_tags" {
  description = "Tags to be attached to the Log group"
  type        = map(string)
  default = {
    Owner       = "vb"
    Provisioner = "Terraform"
  }
}

variable "enable_ecs_managed_tags" {
  type    = bool
  default = true
}

variable "availability_zone_rebalancing" {
  type    = string
  default = "DISABLED"
}

# variable "container_name" {
#   type = string
# }


# --------------- autoscaling.tf -------------------

variable "require_service_autoscaling" {
  type        = bool
  default     = false
}

variable "enable_autoscaling" {
  description = "Enable auto scaling for the ECS service"
  type        = bool
  default     = false
}

variable "autoscaling_min_capacity" {
  description = "Minimum number of tasks for the service"
  type        = number
  default     = 1
}

variable "autoscaling_max_capacity" {
  description = "Maximum number of tasks for the service"
  type        = number
  default     = 3
}

variable "autoscaling_target_cpu_utilization" {
  description = "Target CPU utilization percentage"
  type        = number
  default     = 70
}

variable "auto_scaling_cpu_target_value" {
  type = number
  default = 50
}