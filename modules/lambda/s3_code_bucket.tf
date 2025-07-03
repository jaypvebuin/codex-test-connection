resource "aws_s3_bucket" "code" {
  count  = var.create_s3_bucket && var.package_type == "Zip" ? 1 : 0
  bucket = "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-code"
}
