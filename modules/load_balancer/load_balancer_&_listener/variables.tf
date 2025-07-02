variable "listeners" {
  description = "A list of objects representing the configuration for each listener."
  type = list(object({
    load_balancer_arn = optional(string)
    port              = number
    protocol          = string
    ssl_policy        = optional(string)
    certificate_arn   = optional(string)

    default_action = object({
      type             = string
      target_group_arn = optional(string)
      order            = optional(number)

      redirect = optional(object({
        protocol    = optional(string)
        port        = optional(string)
        host        = optional(string)
        path        = optional(string)
        query       = optional(string)
        status_code = string
      }))

      fixed_response = optional(object({
        content_type = string
        message_body = optional(string)
        status_code  = string
      }))

      authenticate_oidc = optional(object({
        authorization_endpoint              = string
        client_id                           = string
        client_secret                       = string
        issuer                              = string
        token_endpoint                      = string
        user_info_endpoint                  = string
        session_cookie_name                 = optional(string)
        scope                               = optional(string)
        session_timeout                     = optional(number)
        authentication_request_extra_params = optional(map(string))
        on_unauthenticated_request          = optional(string)
      }))

      authenticate_cognito = optional(object({
        user_pool_arn                       = string
        user_pool_client_id                 = string
        user_pool_domain                    = string
        session_cookie_name                 = optional(string)
        scope                               = optional(string)
        session_timeout                     = optional(number)
        authentication_request_extra_params = optional(map(string))
        on_unauthenticated_request          = optional(string)
      }))
    })

    alpn_policy = optional(string)
    tags        = optional(map(string))
  }))
}

variable "name" {
  description = "The name of the load balancer."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Creates a unique name beginning with the specified prefix. Conflicts with `name`."
  type        = string
  default     = null
}

variable "internal" {
  description = "If true, the load balancer will be internal."
  type        = bool
  default     = false
}

variable "load_balancer_type" {
  description = "The type of load balancer to create. Valid values are application, network, or gateway."
  type        = string
  default     = "application"
}

variable "security_groups" {
  description = "A list of security group IDs to assign to the load balancer."
  type        = list(string)
  default     = []
}

variable "subnets" {
  description = "A list of subnet IDs to attach to the load balancer. Required unless using `subnet_mapping`."
  type        = list(string)
  default     = []
}

variable "subnet_mapping" {
  description = "Configuration block for subnet mappings. Conflicts with `subnets`."
  type = list(object({
    subnet_id            = string
    allocation_id        = optional(string)
    private_ipv4_address = optional(string)
    ipv6_address         = optional(string)
  }))
  default = []
}

variable "enable_deletion_protection" {
  description = "If true, deletion of the load balancer will be disabled via the AWS API."
  type        = bool
  default     = false
}

variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle."
  type        = number
}

variable "drop_invalid_header_fields" {
  description = "If true, the load balancer will drop invalid HTTP headers received from clients."
  type        = bool
  default     = false
}

variable "enable_cross_zone_load_balancing" {
  description = "If true, cross-zone load balancing of the load balancer will be enabled."
  type        = bool
  default     = false
}

variable "customer_owned_ipv4_pool" {
  description = "The ID of the customer-owned IPv4 address pool to use for the load balancer."
  type        = string
  default     = null
}

variable "ip_address_type" {
  description = "The type of IP addresses used by the subnets for your load balancer."
  type        = string
  default     = "ipv4"
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "sg_name" {
  description = "The name of the security group."
  type        = string
  default     = null
}

variable "sg_description" {
  description = "The description of the security group."
  type        = string
  default     = "Managed by Terraform"
}

variable "sg_vpc_id" {
  description = "The VPC ID to associate with the security group."
  type        = string
  default     = null
}

variable "ingress_rules" {
  description = "List of ingress rules for the security group."
  type = list(object({
    description      = optional(string)
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = optional(list(string), [])
    ipv6_cidr_blocks = optional(list(string), [])
    security_groups  = optional(list(string), [])
    self             = optional(bool, false)
  }))
  default = []
}

variable "egress_rules" {
  description = "List of egress rules for the security group."
  type = list(object({
    description      = optional(string)
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = optional(list(string), [])
    ipv6_cidr_blocks = optional(list(string), [])
    security_groups  = optional(list(string), [])
    self             = optional(bool, false)
  }))
  default = []
}

variable "sg_tags" {
  description = "A map of tags to assign to the security group."
  type        = map(string)
  default     = {}
}

variable "lb_logging_s3_bucket" {
  type = string
}
