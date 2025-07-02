variable "connection_arn" {
  type = map(string)
  default = {
    "dev"  = "arn:aws:codeconnections:ap-northeast-1:905657322432:connection/f740d302-fc87-4ea5-9be8-b2c2a3aed87c"
    "stg"  = "arn:aws:codestar-connections:ap-northeast-1:944551270832:connection/b2a99e9f-6347-48df-b96d-50ea6574141d"
    "prod" = "arn:aws:codeconnections:ap-northeast-1:194107306707:connection/5cfb93c3-cc2f-4ceb-8af7-d4a1200f4805"
    "beta" = "arn:aws:codeconnections:ap-northeast-1:194107306707:connection/5cfb93c3-cc2f-4ceb-8af7-d4a1200f4805"
  }
}

variable "vpc_id" {
  type = map(string)
  default = {
    "dev"  = "vpc-06056f3434f1083e9"
    "stg"  = "vpc-059b68ca1573ed1ee"
    "prod" = "vpc-0e809b275007781a0"
    "beta" = "vpc-0e809b275007781a0"
  }
}

variable "subnet_ids" {
  type = map(list(string))
  default = {
    dev  = ["subnet-0b62fd0a65b033ea5", "subnet-01285ca4b0cabb96c", "subnet-042e53dd293657e2a"]
    stg  = ["subnet-0558e66ba06829f40", "subnet-0781b7c8db9dc0d54", "subnet-0d1ab8c34175d9d47"]
    prod = ["subnet-00c9365ef2181ca0c", "subnet-04c23ea7770a1e686"]
    beta = ["subnet-00c9365ef2181ca0c", "subnet-04c23ea7770a1e686"]
  }
}

variable "public_subnet_ids" {
  type    = list(string)
  default = [""]
}

variable "branch_name" {
  type = map(string)
  default = {
    "dev"  = "develop"
    "stg"  = "staging"
    "prod" = "main"
    "beta" = "prod_beta"
  }
}

variable "yosan_branch_name" {
  type = map(string)
  default = {
    "dev"  = "develop"
    "stg"  = "staging"
    "prod" = "production"
    "beta" = "prod_beta"
  }
}

variable "project_name" {
  type    = string
  default = "jugaad"
}

variable "environment" {
  type = string
}

variable "vendor" {
  type    = string
  default = "vb"
}

variable "s3_prefix" {
  type    = string
  default = "s3_prefix"
}

# variable "buildspec_app_env" {
#   type = string
# }

variable "api_stage_variables" {
  type        = map(any)
  description = "Stage variables for API Gateway stage"
  default     = null
}

variable "mock_stage_variables" {
  type        = map(any)
  description = "Stage variables for API Gateway stage"
  default     = null
}

variable "test_stage_variables" {
  type        = map(any)
  description = "Stage variables for API Gateway stage"
  default     = null
}

variable "testing_stage_variables" {
  type        = map(any)
  description = "Stage variables for API Gateway stage"
  default     = null
}

variable "workflow_stage_variables" {
  type        = map(any)
  description = "Stage variables for API Gateway stage"
  default     = null
}

variable "internal_lb_sg" {
  type = map(string)
  default = {
    "dev"  = "sg-0234d228e5cd2ecfb"
    "stg"  = "sg-0d265eb6eb9c464b7"
    "prod" = "sg-0b5c2d6cdf7e94d76"
    "beta" = "sg-0a597c0f0d0343403"
  }
}

variable "apply_approve_secret_key_base" {
  type    = string
  default = null
}

variable "form_details_secret_key_base" {
  type    = string
  default = null
}

variable "notification_secret_key_base" {
  type    = string
  default = null
}

variable "report_secret_key_base" {
  type    = string
  default = null
}

variable "microservices_buildspec_filename" {
  type = string
}

variable "yosan_be_buildspec_filename" {
  type = string
}

variable "yosan_fe_buildspec_filename" {
  type = string
}

variable "copilot_be_buildspec_filename" {
  type = string
}

variable "copilot_fe_buildspec_filename" {
  type = string
}

variable "auth_lambda_buildspec_filename" {
  type = string
}

variable "copilot_rag_branch_name" {
  type = string
}

variable "copilot_resources" {
  type = map(any)
  default = {
    "dev"  = 1
    "stg"  = 1
    "prod" = 1
    "beta" = 0
  }
}

variable "yosan_resources" {
  type = map(any)
  default = {
    "dev"  = 1
    "stg"  = 1
    "prod" = 1
    "beta" = 0
  }
}

variable "microservice_resources" {
  type = map(any)
  default = {
    "dev"  = 1
    "stg"  = 1
    "prod" = 1
    "beta" = 1
  }
}

variable "announcement_resources" {
  type = map(any)
  default = {
    "dev"  = 1
    "stg"  = 0
    "prod" = 0
    "beta" = 0
  }
}

variable "services_domain" {
  type = map(string)
  default = {
    "dev"  = "services-dev.stage-smartflow.com"
    "stg"  = "services-stage.jugaad.co.jp"
    "prod" = "services.jugaad.co.jp"
    "beta" = "services-beta.jugaad.co.jp"
  }
}


variable "services_task_count" {
  type = map(map(number))
  default = {
    dev = {
      apply-approve-service = 1,
      form-details-service  = 1,
      notification-service = 1,
      pdf-service = 1,
      report-service = 1,
      announcement-service = 1,
      copilot-policy-service = 1,
      copilot-policy-rag-service = 1,
      yosan-management-service = 1,
      yosan-reporting-service = 1
    },
    stg = {
      apply-approve-service = 1,
      form-details-service  = 1,
      notification-service = 1,
      pdf-service = 1,
      report-service = 1,
      announcement-service = 0,
      copilot-policy-service = 1,
      copilot-policy-rag-service = 1,
      yosan-management-service = 1,
      yosan-reporting-service = 0
    },
    prod = {
      apply-approve-service = 12,
      form-details-service  = 12,
      notification-service = 2,
      pdf-service = 2,
      report-service = 12,
      announcement-service = 0,
      copilot-policy-service = 0,
      copilot-policy-rag-service = 0,
      yosan-management-service = 2,
      yosan-reporting-service = 0
    },
    beta = {
      apply-approve-service = 1,
      form-details-service  = 1,
      notification-service = 1,
      pdf-service = 1,
      report-service = 1,
      announcement-service = 0,
      copilot-policy-service = 0,
      copilot-policy-rag-service = 0,
      yosan-management-service = 0,
      yosan-reporting-service = 0
    }
  }
}

variable "services_task_cpu" {
  type = map(map(number))
  default = {
    dev = {
      apply-approve-service = 512,
      form-details-service  = 512,
      notification-service = 512,
      pdf-service = 512,
      report-service = 512,
      announcement-service = 512,
      copilot-policy-service = 512,
      copilot-policy-rag-service = 2048,
      yosan-management-service = 512,
      yosan-reporting-service = 512
    },
    stg = {
      apply-approve-service = 512,
      form-details-service  = 512,
      notification-service = 512,
      pdf-service = 512,
      report-service = 512,
      announcement-service = 512,
      copilot-policy-service = 512,
      copilot-policy-rag-service = 2048,
      yosan-management-service = 512,
      yosan-reporting-service = 512
    },
    prod = {
      apply-approve-service = 1024,
      form-details-service  = 1024,
      notification-service = 2048,
      pdf-service = 2048,
      report-service = 1024,
      announcement-service = 512,
      copilot-policy-service = 512,
      copilot-policy-rag-service = 2048,
      yosan-management-service = 2048,
      yosan-reporting-service = 512
    },
    beta = {
      apply-approve-service = 512,
      form-details-service  = 512,
      notification-service = 512,
      pdf-service = 512,
      report-service = 512,
      announcement-service = 512,
      copilot-policy-service = 512,
      copilot-policy-rag-service = 2048,
      yosan-management-service = 512,
      yosan-reporting-service = 512
    }
  }
}

variable "services_task_memory" {
  type = map(map(number))
  default = {
    dev = {
      apply-approve-service = 3072,
      form-details-service  = 3072,
      notification-service = 3072,
      pdf-service = 3072,
      report-service = 3072,
      announcement-service = 3072,
      copilot-policy-service = 3072,
      copilot-policy-rag-service = 4096,
      yosan-management-service = 3072,
      yosan-reporting-service = 3072
    },
    stg = {
      apply-approve-service = 3072,
      form-details-service  = 3072,
      notification-service = 3072,
      pdf-service = 3072,
      report-service = 3072,
      announcement-service = 3072,
      copilot-policy-service = 3072,
      copilot-policy-rag-service = 4096,
      yosan-management-service = 3072,
      yosan-reporting-service = 3072
    },
    prod = {
      apply-approve-service = 2048,
      form-details-service  = 2048,
      notification-service = 4096,
      pdf-service = 4096,
      report-service = 2048,
      announcement-service = 4096,
      copilot-policy-service = 4096,
      copilot-policy-rag-service = 4096,
      yosan-management-service = 4096,
      yosan-reporting-service = 4096
    },
    beta = {
      apply-approve-service = 3072,
      form-details-service  = 3072,
      notification-service = 3072,
      pdf-service = 3072,
      report-service = 3072,
      announcement-service = 3072,
      copilot-policy-service = 3072,
      copilot-policy-rag-service = 4096,
      yosan-management-service = 3072,
      yosan-reporting-service = 3072
    }
  }
}

# variable "services_scaling_min_count" {
#   type = map(map(number))
#   default = {
#     dev = {
#       apply-approve-service = 1,
#       form-details-service  = 1,
#       notification-service = 1,
#       pdf-service = 1,
#       report-service = 1,
#       announcement-service = 1,
#       copilot-policy-service = 1,
#       copilot-policy-rag-service = 4096,
#       yosan-management-service = 1,
#       yosan-reporting-service = 1
#     },
#     stg = {
#       apply-approve-service = 1,
#       form-details-service  = 1,
#       notification-service = 1,
#       pdf-service = 1,
#       report-service = 1,
#       announcement-service = 0,
#       copilot-policy-service = 0,
#       copilot-policy-rag-service = 0,
#       yosan-management-service = 0,
#       yosan-reporting-service = 0
#     },
#     prod = {
#       apply-approve-service = 1,
#       form-details-service  = 1,
#       notification-service = 1,
#       pdf-service = 1,
#       report-service = 1,
#       announcement-service = 0,
#       copilot-policy-service = 0,
#       copilot-policy-rag-service = 0,
#       yosan-management-service = 0,
#       yosan-reporting-service = 0
#     },
#     beta = {
#       apply-approve-service = 1,
#       form-details-service  = 1,
#       notification-service = 1,
#       pdf-service = 1,
#       report-service = 1,
#       announcement-service = 0,
#       copilot-policy-service = 0,
#       copilot-policy-rag-service = 0,
#       yosan-management-service = 0,
#       yosan-reporting-service = 0
#     }
#   }
# }
variable "services_scaling_min_count" {
  type = map(number)
  description = "Minimum scaling count for each service"
}

variable "services_scaling_max_count" {
  type = map(number)
  description = "Minimum scaling count for each service"
}

variable "log_group_retention_api_gateway" {
  type = number
  # default = 30
}

variable "log_group_retention_ecs_service" {
  type = number
  # default = 30
}

variable "log_group_retention_ecs_task" {
  type = number
  # default = 30
}
# variable "lb_logging_s3_bucket" {
#   type = string
# }

variable "image_preserve_count" {
  type = number 
}

variable "cloudfront_copilot_policy_fe" {
  type = map(string)
  default = {
    "dev"  = "E353N8W0JHXX6S"
    "stg"  = "E15RAF6KOEJXOT"
    "prod" = "E2QQ63IZIQ5O53"
    "beta" = "vpc-0e809b275007781a0"
  }
}

variable "cloudfront_copilot_iframe_fe" {
  type = map(string)
  default = {
    "dev"  = "E3H4IPWEPWZ1T5"
    "stg"  = "E1Q7EDPIB56WT4"
    "prod" = "E3H34Y6ZW43AUB"
    "beta" = "vpc-0e809b275007781a0"
  }
}

variable "cloudfront_yosan_manage_fe" {
  type = map(string)
  default = {
    "dev"  = "ETF86YX1C9KD2"
    "stg"  = "EGJL61ZWUM9SC"
    "prod" = "EV1O6QDIEZ8RZ"
    "beta" = "vpc-0e809b275007781a0"
  }
}

variable "cloudfront_announcement_fe" {
  type = map(string)
  default = {
    "dev"  = "E1WAQOA99B8Y4K"
    "stg"  = "vpc-059b68ca1573ed1ee"
    "prod" = "vpc-0e809b275007781a0"
    "beta" = "vpc-0e809b275007781a0"
  }
}

variable "cloudfront_yosan_reporting_fe" {
  type = map(string)
  default = {
    "dev"  = "EVW7KWDLW2NX7"
    "stg"  = "vpc-059b68ca1573ed1ee"
    "prod" = "EO3NL8J72TBKM"
    "beta" = "vpc-0e809b275007781a0"
  }
}

variable "yosan_task_origin_domain" {
  type = map(string)
  default = {
    "dev"  = "https://yosan.services-dev.stage-smartflow.com"
    "stg"  = "https://yosan.services.stage-smartflow.com"
    "prod" = "https://yosan.smartflow.vebuin.com"
    "beta" = "vpc-0e809b275007781a0"
  }
}