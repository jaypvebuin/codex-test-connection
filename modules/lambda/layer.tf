resource "aws_s3_bucket" "layer" {
  count  = var.create_layer_bucket ? 1 : 0
  bucket = "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-layer"
}

resource "aws_lambda_layer_version" "this" {
  count      = var.create_layer ? 1 : 0
  layer_name = "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-layer"
  s3_bucket  = var.create_layer_bucket ? aws_s3_bucket.layer[0].id : var.s3_bucket_name
  s3_key     = var.layer_s3_key
}
