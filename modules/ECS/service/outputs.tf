output "service_name" {
  value = aws_ecs_service.ecs_service.name
}

# output "alb_url" {
#   value = try(aws_lb.ecs_alb[0].dns_name, null)
#   #value = aws_lb.ecs_alb[0].dns_name
# }