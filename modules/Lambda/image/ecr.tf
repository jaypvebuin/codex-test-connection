resource "aws_ecr_repository" "this" {
  count                = var.required_repo_for_image_lambda == true ? 1 : 0
  name                 = var.Environment == "beta" ? "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-lambda-beta" : "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-lambda"
  # name = "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-lambda"
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
  provisioner "local-exec" {
    command = join(";", [
      "aws ecr get-login-password --region ${data.aws_region.current.name} | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com",
      "docker pull alpine",
      "docker tag alpine ${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.id}.amazonaws.com/${aws_ecr_repository.this[count.index].name}:latest",
      "docker push ${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.id}.amazonaws.com/${aws_ecr_repository.this[count.index].name}:latest",
    ])
  }
  tags = {
    Name    = "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-lambda"
    purpose = "This ECR is used for ${var.identifier} lambda.",
    module = var.module
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