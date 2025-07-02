provider "aws" {
  region = "ap-northeast-1"
  default_tags {
    tags = {
      CreatedBy    = "Terraform"
      vendor       = var.vendor
      project_name = var.project_name
    }
  }
}