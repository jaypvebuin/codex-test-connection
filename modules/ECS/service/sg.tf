resource "aws_security_group" "sg_service" {
  name        = var.sg_name
  description = var.description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.service_ingress_sg
    content {
      description     = try(ingress.value.description, null)
      from_port       = try(ingress.value.from_port, null)
      to_port         = try(ingress.value.to_port, null)
      protocol        = try(ingress.value.protocol, null)
      cidr_blocks     = try(ingress.value.cidr_blocks, null)
      security_groups = try(ingress.value.security_groups, null)
    }
  }

  dynamic "egress" {
    for_each = var.service_egress_sg
    content {
      description     = try(egress.value.description, null)
      from_port       = try(egress.value.port, null)
      to_port         = try(egress.value.port, null)
      protocol        = try(egress.value.protocol, null)
      cidr_blocks     = try(egress.value.cidr_blocks, null)
      security_groups = try(egress.value.security_groups, null)
    }

  }

  tags = merge({
    Name = var.sg_name,
    module = var.module
  }, var.sg_tags)
}

# resource "aws_security_group" "s3_prefix_service" {
#   name        = "${lower(var.maintainer)}-${lower(var.project_name)}-${lower(var.Environment)}-${var.service_name}-s3-sg"
#   description = "S3 Prefix list"
#   vpc_id      = var.vpc_id

#   egress {
#     from_port       = 443
#     to_port         = 443
#     protocol        = "tcp"
#     prefix_list_ids = [var.prefix_list_ids]

#   }

#   tags = {
#     ProjectName = var.tag-project_name
#     Purpose     = "Allow necessary traffic"
#   }
# }
