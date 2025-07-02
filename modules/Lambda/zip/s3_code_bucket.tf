resource "aws_s3_bucket" "this" {
  count  = var.required_s3_bucket_for_zip_code ? 1 : 0
  bucket = "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-bucket"
}
