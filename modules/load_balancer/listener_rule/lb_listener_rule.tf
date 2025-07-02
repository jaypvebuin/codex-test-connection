resource "aws_lb_listener_rule" "this" {
  for_each = { for idx, rule in var.listener_rules : idx => rule }

  listener_arn = each.value.listener_arn
  priority     = each.value.priority

  dynamic "action" {
    for_each = each.value.actions
    content {
      type             = action.value.type
      target_group_arn = lookup(action.value, "target_group_arn", null)
      order            = lookup(action.value, "order", null)

      dynamic "redirect" {
        for_each = action.value.redirect != null ? [action.value.redirect] : []
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
        for_each = action.value.fixed_response != null ? [action.value.fixed_response] : []
        content {
          content_type = try(fixed_response.value.content_type, null)
          message_body = lookup(fixed_response.value, "message_body", null)
          status_code  = try(fixed_response.value.status_code, null)
        }
      }

      dynamic "authenticate_cognito" {
        for_each = action.value.authenticate_cognito != null ? [action.value.authenticate_cognito] : []
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

      dynamic "authenticate_oidc" {
        for_each = action.value.authenticate_oidc != null ? [action.value.authenticate_oidc] : []
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
    }
  }

  dynamic "condition" {
    for_each = each.value.conditions
    content {
      dynamic "host_header" {
        for_each = lookup(condition.value, "host_header", []) != null ? [condition.value.host_header] : []
        content {
          values = try(host_header.value.values, null)
        }
      }

      dynamic "path_pattern" {
        for_each = lookup(condition.value, "path_pattern", []) != null ? [condition.value.path_pattern] : []
        content {
          values = try(path_pattern.value.values, null)
        }
      }

      dynamic "http_header" {
        for_each = lookup(condition.value, "http_header", []) != null ? [condition.value.http_header] : []
        content {
          http_header_name = try(http_header.value.http_header_name, null)
          values           = try(http_header.value.values, null)
        }
      }

      dynamic "http_request_method" {
        for_each = lookup(condition.value, "http_request_method", []) != null ? [condition.value.http_request_method] : []
        content {
          values = try(http_request_method.value.values, null)
        }
      }

      dynamic "query_string" {
        for_each = lookup(condition.value, "query_string", []) != null ? condition.value.query_string : []
        content {
          key   = lookup(query_string.value, "key", null)
          value = try(query_string.value.value, null)
        }
      }

      dynamic "source_ip" {
        for_each = lookup(condition.value, "source_ip", []) != null ? [condition.value.source_ip] : []
        content {
          values = try(source_ip.value.values, null)
        }
      }
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}