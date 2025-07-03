resource "aws_ecr_repository" "this" {
  count                = var.create_ecr_repo && var.package_type == "Image" ? 1 : 0
  name                 = "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-repo"
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
}
