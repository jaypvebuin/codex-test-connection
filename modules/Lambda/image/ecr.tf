resource "aws_ecr_repository" "this" {
  count                = var.required_repo_for_image_lambda == true ? 1 : 0
  name                 = "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-ecr-repo"
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
  tags = {
    Name = "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-ecr-repo"
    Purpose = var.purpose
  }
}

# resource "null_resource" "docker_build_and_push" {
#   count = var.required_repo_for_image_lambda ? 1 : 0
#   provisioner "local-exec" {
#     command = <<EOT
#       # Log in to ECR
#       aws ecr get-login-password --region ${data.aws_region.current} | docker login --username AWS --password-stdin ${aws_ecr_repository.this[0].repository_url}

#       # Build Docker image
#       docker build -t my-image .

#       # Tag Docker image
#       docker tag my-image:latest ${aws_ecr_repository.this[0].repository_url}:latest

#       # Push Docker image to ECR
#       docker push ${aws_ecr_repository.this[0].repository_url}:latest
#     EOT
#   }
# }