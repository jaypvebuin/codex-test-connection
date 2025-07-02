resource "aws_lb_listener" "listeners" {
  for_each = { for idx, listener in var.listeners : idx => listener }

  load_balancer_arn = try(aws_lb.this.arn, null)
  port              = try(each.value.port, null)
  protocol          = try(each.value.protocol, null)
  ssl_policy        = lookup(each.value, "ssl_policy", null)
  certificate_arn   = lookup(each.value, "certificate_arn", null)

  default_action {
    type             = try(each.value.default_action.type, null)
    target_group_arn = lookup(each.value.default_action, "target_group_arn", null)
    order            = lookup(each.value.default_action, "order", null)

    dynamic "redirect" {
      for_each = each.value.default_action.redirect != null ? [each.value.default_action.redirect] : []
      content {
        protocol    = lookup(redirect.value, "protocol", null)
        port        = lookup(redirect.value, "port", null)
        host        = lookup(redirect.value, "host", null)
        path        = lookup(redirect.value, "path", null)
        query       = lookup(redirect.value, "query", null)
        status_code = try(redirect.value.status_code, null)
      }
    }

    dynamic "fixed_response" {
      for_each = each.value.default_action.fixed_response != null ? [each.value.default_action.fixed_response] : []
      content {
        content_type = try(fixed_response.value.content_type, null)
        message_body = lookup(fixed_response.value, "message_body", null)
        status_code  = try(fixed_response.value.status_code, null)
      }
    }

    dynamic "authenticate_oidc" {
      for_each = each.value.default_action.authenticate_oidc != null ? [each.value.default_action.authenticate_oidc] : []
      content {
        authorization_endpoint              = try(authenticate_oidc.value.authorization_endpoint, null)
        client_id                           = try(authenticate_oidc.value.client_id, null)
        client_secret                       = try(authenticate_oidc.value.client_secret, null)
        issuer                              = try(authenticate_oidc.value.issuer, null)
        token_endpoint                      = try(authenticate_oidc.value.token_endpoint, null)
        user_info_endpoint                  = try(authenticate_oidc.value.user_info_endpoint, null)
        session_cookie_name                 = lookup(authenticate_oidc.value, "session_cookie_name", null)
        scope                               = lookup(authenticate_oidc.value, "scope", null)
        session_timeout                     = lookup(authenticate_oidc.value, "session_timeout", null)
        authentication_request_extra_params = lookup(authenticate_oidc.value, "authentication_request_extra_params", null)
        on_unauthenticated_request          = lookup(authenticate_oidc.value, "on_unauthenticated_request", null)
      }
    }

    dynamic "authenticate_cognito" {
      for_each = each.value.default_action.authenticate_cognito != null ? [each.value.default_action.authenticate_cognito] : []
      content {
        user_pool_arn                       = try(authenticate_cognito.value.user_pool_arn, null)
        user_pool_client_id                 = try(authenticate_cognito.value.user_pool_client_id, null)
        user_pool_domain                    = try(authenticate_cognito.value.user_pool_domain, null)
        session_cookie_name                 = lookup(authenticate_cognito.value, "session_cookie_name", null)
        scope                               = lookup(authenticate_cognito.value, "scope", null)
        session_timeout                     = lookup(authenticate_cognito.value, "session_timeout", null)
        authentication_request_extra_params = lookup(authenticate_cognito.value, "authentication_request_extra_params", null)
        on_unauthenticated_request          = lookup(authenticate_cognito.value, "on_unauthenticated_request", null)
      }
    }
  }
  alpn_policy = lookup(each.value, "alpn_policy", null)
}
