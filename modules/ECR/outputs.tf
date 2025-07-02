output "repository_url" {
  value = aws_ecr_repository.this.repository_url
  # value = {for idx, config in aws_ecr_repository.this : idx => config.repository_url}
}