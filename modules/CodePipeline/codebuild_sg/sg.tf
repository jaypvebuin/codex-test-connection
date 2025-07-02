resource "aws_security_group" "sg" {
  count       = var.create_sg_for_codebuild == true ? 1 : 0
  name        = "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-build-sg-${lower(var.Environment)}"
  description = "Security group for codebuild."
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress
    content {
      description     = try(ingress.value.description, null)
      from_port       = try(ingress.value.port, null)
      to_port         = try(ingress.value.port, null)
      protocol        = try(ingress.value.protocol, null)
      cidr_blocks     = try(ingress.value.cidr_blocks, null)
      security_groups = try(ingress.value.security_groups, null)
    }
  }

  dynamic "egress" {
    for_each = var.egress
    content {
      description     = try(egress.value.description, null)
      from_port       = try(egress.value.port, null)
      to_port         = try(egress.value.port, null)
      protocol        = try(egress.value.protocol, null)
      cidr_blocks     = try(egress.value.cidr_blocks, null)
      security_groups = try(egress.value.security_groups, null)
    }
  }
  tags = {
    module = var.module
    purpose = "This sg is for the codebuild project of ${var.identifier}"
  }
}
