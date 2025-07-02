variable "listener_rules" {
  description = "A list of listener rule configurations."
  type = list(object({
    listener_arn = string # ARN of the listener
    priority     = number # Priority of the rule

    actions = list(object({
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
    }))

    conditions = list(object({
      host_header = optional(object({
        values = list(string)
      }))
      path_pattern = optional(object({
        values = list(string)
      }))
      http_header = optional(object({
        http_header_name = string
        values           = list(string)
      }))
      http_request_method = optional(object({
        values = list(string)
      }))
      query_string = optional(list(object({
        key   = optional(string)
        value = string
      })))
      source_ip = optional(object({
        values = list(string)
      }))
    }))
  }))
}

variable "module" {
  type    = string
  default = ""
}