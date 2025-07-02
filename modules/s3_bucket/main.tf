resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.s3_bucket_name
  tags = {
    module = var.module
  }
}
resource "aws_s3_object" "s3_folders" {
  for_each = { for folder in var.folders : folder => folder if folder != "" } # Only create resources for non-empty folder keys
  bucket   = var.s3_bucket_name
  key      = each.value # Create folder based on each value in the list
  content  = ""
}

# Disable Block Public Access to allow public ACLs
resource "aws_s3_bucket_public_access_block" "this" {
  count                   = var.public ? 1 : 0
  bucket                  = aws_s3_bucket.s3_bucket.id
  block_public_acls       = false # Allow public ACLs
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
  lifecycle {
    ignore_changes = [
      block_public_acls,
      block_public_policy,
      ignore_public_acls,
      restrict_public_buckets
    ]
  }
}

resource "aws_s3_bucket_public_access_block" "block_access" {
  count                   = var.public ? 0 : 1
  bucket                  = aws_s3_bucket.s3_bucket.id
  block_public_acls       = true # Allow public ACLs
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  lifecycle {
    ignore_changes = [
      block_public_acls,
      block_public_policy,
      ignore_public_acls,
      restrict_public_buckets
    ]
  }
}

# resource "aws_s3_bucket_notification" "s3_trigger" {
#   count  = var.lambda_arn != "" ? 1 : 0  # Create resource only if lambda_arn is not empty
#   bucket = aws_s3_bucket.s3_bucket.id

#   lambda_function {
#     lambda_function_arn = var.lambda_arn
#     events              = ["s3:ObjectCreated:*"]
#   }
# }

# resource "aws_lambda_permission" "allow_s3" {
#   count         = var.lambda_arn != "" ? 1 : 0  # Create resource only if lambda_arn is not empty
#   statement_id  = "AllowExecutionFromS3"
#   action        = "lambda:InvokeFunction"
#   function_name = var.lambda_arn
#   principal     = "s3.amazonaws.com"
#   source_arn    = aws_s3_bucket.s3_bucket.id
# }


# resource "aws_s3_bucket_policy" "public_access_policy" {
#   count = var.public ? 1 : 0 # Create the policy only if public is true

#   bucket = aws_s3_bucket.s3_bucket.id

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Sid       = "PublicReadGetObject",
#         Effect    = "Allow",
#         Principal = "*", # Allow public access
#         Action    = "s3:GetObject",
#         Resource  = "arn:aws:s3:::${aws_s3_bucket.s3_bucket.id}/*"
#       }
#     ]
#   })
#   lifecycle {
#     ignore_changes = [
#       policy
#       # desired_count,
#       #task_definition
#       # load_balancer
#     ]
#   }
# }

resource "aws_s3_bucket_policy" "public_access_policy" {
  count  = var.bucket_policy != "" ? 1 : 0
  bucket = aws_s3_bucket.s3_bucket.id
  policy = var.bucket_policy

  # lifecycle {
  #   ignore_changes = [policy]
  # }
}