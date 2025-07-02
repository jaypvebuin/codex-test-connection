variable "target_groups" {
  description = "A list of objects representing the configuration for each target group."
  type = list(object({
    name                          = string
    port                          = number
    protocol                      = string
    vpc_id                        = string
    name_prefix                   = optional(string)
    protocol_version              = optional(string)
    deregistration_delay          = optional(number)
    connection_termination        = optional(bool)
    slow_start                    = optional(number)
    load_balancing_algorithm_type = optional(string)
    preserve_client_ip            = optional(bool)
    target_type                   = optional(string)
    health_check = optional(object({
      enabled             = bool
      interval            = number
      path                = string
      port                = string
      protocol            = string
      timeout             = number
      healthy_threshold   = number
      unhealthy_threshold = number
      matcher             = string
    }))
    stickiness = optional(object({
      type            = string
      cookie_duration = number
    }))
    target_group_health = optional(object({
      dns_failover = optional(object({
        minimum_healthy_targets_count      = number
        minimum_healthy_targets_percentage = number
      }))
    }))
  }))
}

variable "identifier" {
  type    = string
  default = null
}
variable "module" {
  type    = string
  default = ""
}