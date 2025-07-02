#---------------------- ECR Registory ----------------------#
resource "aws_ecr_repository" "this" {
  name                 = "${var.vendor}-${var.project_name}-${var.identifier}-repo-${var.environment}"
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = merge({
    Name = "${var.vendor}-${var.project_name}-${var.identifier}-${var.environment}",
    module = var.module
  }, var.tags)
}

resource "aws_ecr_lifecycle_policy" "retain_last_x_images" {
  repository = aws_ecr_repository.this.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Retain only last 10 images, delete older"
        selection = {
          tagStatus   = "any"                # applies to all images regardless of tags
          countType   = "imageCountMoreThan"
          countNumber = var.image_preserve_count                  # <<-- Keep last 10 images
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}