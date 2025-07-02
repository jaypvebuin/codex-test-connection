resource "aws_lb_target_group" "target_groups" {
  for_each = { for tg in var.target_groups : tg.name => tg }

  name                          = each.value.name
  port                          = each.value.port
  protocol                      = each.value.protocol
  vpc_id                        = each.value.vpc_id
  protocol_version              = lookup(each.value, "protocol_version", null)
  deregistration_delay          = lookup(each.value, "deregistration_delay", 0)
  connection_termination        = lookup(each.value, "connection_termination", false)
  slow_start                    = lookup(each.value, "slow_start", 0)
  load_balancing_algorithm_type = lookup(each.value, "load_balancing_algorithm_type", "round_robin")
  preserve_client_ip            = lookup(each.value, "preserve_client_ip", false)
  target_type                   = lookup(each.value, "target_type", "instance")

  dynamic "health_check" {
    for_each = each.value.health_check != null ? [each.value.health_check] : []
    content {
      enabled             = try(health_check.value.enabled, null)
      interval            = try(health_check.value.interval, null)
      path                = try(health_check.value.path, null)
      port                = try(health_check.value.port, null)
      protocol            = try(health_check.value.protocol, null)
      timeout             = try(health_check.value.timeout, null)
      healthy_threshold   = try(health_check.value.healthy_threshold, null)
      unhealthy_threshold = try(health_check.value.unhealthy_threshold, null)
      matcher             = try(health_check.value.matcher, null)
    }
  }

  dynamic "stickiness" {
    for_each = each.value.stickiness != null ? [each.value.stickiness] : []
    content {
      type            = try(stickiness.value.type, null)
      cookie_duration = try(stickiness.value.cookie_duration, null)
    }
  }

  dynamic "target_group_health" {
    for_each = each.value.target_group_health != null ? [each.value.target_group_health] : []
    content {
      dns_failover {
        minimum_healthy_targets_count      = try(target_group_health.value.dns_failover.minimum_healthy_targets_count, null)
        minimum_healthy_targets_percentage = try(target_group_health.value.dns_failover.minimum_healthy_targets_percentage, null)
      }
    }
  }
  tags = {
    module = var.module
  }
}



