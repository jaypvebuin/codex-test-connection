resource "aws_lb" "this" {
  name               = var.name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = [aws_security_group.this.id]
  subnets            = var.subnets

  dynamic "subnet_mapping" {
    for_each = var.subnet_mapping
    content {
      subnet_id            = try(subnet_mapping.value.subnet_id, null)
      allocation_id        = lookup(subnet_mapping.value, "allocation_id", null)
      private_ipv4_address = lookup(subnet_mapping.value, "private_ipv4_address", null)
      ipv6_address         = lookup(subnet_mapping.value, "ipv6_address", null)
    }
  }
  access_logs {
    bucket  = var.lb_logging_s3_bucket
    enabled = true
  }

  enable_deletion_protection       = var.enable_deletion_protection
  idle_timeout                     = try(var.idle_timeout, 60)
  drop_invalid_header_fields       = var.drop_invalid_header_fields
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing #For network and gateway type load balancers, this feature is disabled by default (false). For application load balancer this feature is always enabled (true) and cannot be disabled.
  customer_owned_ipv4_pool         = try(var.customer_owned_ipv4_pool, null)
  ip_address_type                  = try(var.ip_address_type, null)
}
