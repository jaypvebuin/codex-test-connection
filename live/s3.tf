module "copilot-announcement_s3_frontend_bucket" {
  module = "copilot"
  # count = var.copilot_resources[var.environment]
  source         = "../modules/s3_bucket"
  s3_bucket_name = "vb-jugaad-copilot-announcement-fe-bucket-${var.environment}"
  public         = true
  folders        = [""]
  bucket_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Sid       = "PublicReadGetObject",
      Effect    = "Allow",
      Principal = "*",
      Action    = "s3:GetObject",
      Resource  = "arn:aws:s3:::vb-jugaad-copilot-announcement-fe-bucket-${var.environment}/*"
      },
      {
        Sid       = "RequireHTTPSForAllRequests",
        Effect    = "Deny",
        Principal = "*",
        Action    = "s3:*",
        Resource = ["arn:aws:s3:::vb-jugaad-copilot-announcement-fe-bucket-${var.environment}/*",
        "arn:aws:s3:::vb-jugaad-copilot-announcement-fe-bucket-${var.environment}"]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
    }]
  })
}

module "copilot-policy_s3_frontend_bucket" {
  module = "copilot"
  # count = var.copilot_resources[var.environment]
  source         = "../modules/s3_bucket"
  s3_bucket_name = "vb-jugaad-copilot-policy-fe-bucket-${var.environment}"
  public         = true
  folders        = [""]
  bucket_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Sid    = "AllowCloudFrontServicePrincipal",
      Effect = "Allow",
      Principal = {
        Service = "cloudfront.amazonaws.com"
      },
      Action   = "s3:GetObject",
      Resource = "arn:aws:s3:::vb-jugaad-copilot-policy-fe-bucket-${var.environment}/*"
      Condition = {
        StringEquals = {
          "AWS:SourceArn" = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${var.cloudfront_copilot_policy_fe[var.environment]}"
        }
      }
    }]
  })
}

module "cp-policy-rag-documents_s3_frontend_bucket" {
  module = "copilot"
  # count = var.copilot_resources[var.environment]
  source         = "../modules/s3_bucket"
  s3_bucket_name = "vb-jugaad-cp-policy-rag-documents-bucket-${var.environment}"
  public         = false
  folders        = [""]
}

module "cp-policy-rag-assets_s3_bucket" {
  module = "copilot"
  # count = var.copilot_resources[var.environment]
  source         = "../modules/s3_bucket"
  s3_bucket_name = "vb-jugaad-cp-policy-rag-assets-bucket-${var.environment}"
  public         = false
  folders        = [""]
}

module "yosan-management_s3_frontend_bucket" {
  module = "yosan"
  # count = var.yosan_resources[var.environment]
  source         = "../modules/s3_bucket"
  s3_bucket_name = "vb-jugaad-yosan-management-fe-bucket-${var.environment}"
  public         = true
  folders        = [""]
  bucket_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Sid    = "AllowCloudFrontServicePrincipal",
      Effect = "Allow",
      Principal = {
        Service = "cloudfront.amazonaws.com"
      },
      Action   = "s3:GetObject",
      Resource = "arn:aws:s3:::vb-jugaad-yosan-management-fe-bucket-${var.environment}/*"
      Condition = {
        StringEquals = {
          "AWS:SourceArn" = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${var.cloudfront_yosan_manage_fe[var.environment]}"
        }
      }
    }]
  })
}

module "yosan-reporting_s3_frontend_bucket" {
  module = "yosan"
  # count = var.yosan_resources[var.environment]
  source         = "../modules/s3_bucket"
  s3_bucket_name = "vb-jugaad-yosan-reporting-fe-bucket-${var.environment}"
  public         = true
  folders        = [""]
  bucket_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Sid    = "AllowCloudFrontServicePrincipal",
      Effect = "Allow",
      Principal = {
        Service = "cloudfront.amazonaws.com"
      },
      Action   = "s3:GetObject",
      Resource = "arn:aws:s3:::vb-jugaad-yosan-reporting-fe-bucket-${var.environment}/*"
      Condition = {
        StringEquals = {
          "AWS:SourceArn" = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${var.cloudfront_yosan_reporting_fe[var.environment]}"
        }
      }
    }]
  })
}

module "copilot-iframe_s3_frontend_bucket" {
  module = "copilot"
  # count = var.copilot_resources[var.environment]
  # count =  var.environment == "beta" ? 0 : 1 # this is done because when beta env was added to name it was creating long name error.
  source         = "../modules/s3_bucket"
  s3_bucket_name = "vb-jugaad-copilot-iframe-fe-bucket-${var.environment}"
  public         = true
  folders        = [""]
  bucket_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Sid    = "AllowCloudFrontServicePrincipal",
      Effect = "Allow",
      Principal = {
        Service = "cloudfront.amazonaws.com"
      },
      Action   = "s3:GetObject",
      Resource = "arn:aws:s3:::vb-jugaad-copilot-iframe-fe-bucket-${var.environment}/*"
      Condition = {
        StringEquals = {
          "AWS:SourceArn" = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${var.cloudfront_copilot_iframe_fe[var.environment]}"
        }
      }
    }]
  })
}

module "announcement_s3_frontend_bucket" {
  module = "announcement"
  # count = var.announcement_resources[var.environment]
  # count =  var.environment == "beta" ? 0 : 1 # this is done because when beta env was added to name it was creating long name error.
  source         = "../modules/s3_bucket"
  s3_bucket_name = "vb-jugaad-announcement-fe-bucket-${var.environment}"
  public         = true
  folders        = [""]
  bucket_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Sid    = "AllowCloudFrontServicePrincipal",
      Effect = "Allow",
      Principal = {
        Service = "cloudfront.amazonaws.com"
      },
      Action   = "s3:GetObject",
      Resource = "arn:aws:s3:::vb-jugaad-announcement-fe-bucket-${var.environment}/*"
      Condition = {
        StringEquals = {
          "AWS:SourceArn" = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${var.cloudfront_announcement_fe[var.environment]}"
        }
      }
    }]
  })
}

module "announcement_s3_documents_bucket" {
  module = "announcement"
  # count = var.announcement_resources[var.environment]
  # count =  var.environment == "beta" ? 0 : 1 # this is done because when beta env was added to name it was creating long name error.
  source         = "../modules/s3_bucket"
  s3_bucket_name = "vb-jugaad-announcement-documents-bucket-${var.environment}"
  public         = false
  folders        = [""]
}

module "lb_s3_logging_bucket" {
  module = "microservices"
  # count = var.announcement_resources[var.environment]
  # count =  var.environment == "beta" ? 0 : 1 # this is done because when beta env was added to name it was creating long name error.
  source         = "../modules/s3_bucket"
  s3_bucket_name = "vb-jugaad-lb-logging-bucket-${var.environment}"
  public         = false
  folders        = [""]
  bucket_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowPutObjectFromSpecificPrincipal",
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::582318560864:root"
        },
        Action = "s3:PutObject",
        Resource = [
          "arn:aws:s3:::vb-jugaad-lb-logging-bucket-${var.environment}/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
        ]
      },
      {
        Sid       = "RequireHTTPSForAllRequests",
        Effect    = "Deny",
        Principal = "*",
        Action    = "s3:*",
        Resource = [
          "arn:aws:s3:::vb-jugaad-lb-logging-bucket-${var.environment}/*",
          "arn:aws:s3:::vb-jugaad-lb-logging-bucket-${var.environment}"
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}

