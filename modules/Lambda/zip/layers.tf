resource "aws_lambda_layer_version" "this" {
  count        = var.required_lambda_layer == true ? 1 : 0
  layer_name   = "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-layer"
  skip_destroy = false
  s3_bucket    = aws_s3_bucket.layer_s3_bucket[0].bucket
  s3_key       = var.layer_s3_key
}

resource "aws_s3_bucket" "layer_s3_bucket" {
  count  = var.required_bucket_for_lambda_layer ? 1 : 0
  bucket = "${lower(var.vendor)}-${lower(var.project_name)}-${lower(var.identifier)}-layer-bucket"
}
