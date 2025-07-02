output "listener_arns" {
  description = "ARNs of the AWS Load Balancer Listeners"
  value       = { for idx, listener in aws_lb_listener.listeners : idx => listener.arn }
}

output "sg_id" {
  value = aws_security_group.this.id
}

output "lb_dns"{
  value = aws_lb.this.dns_name
}