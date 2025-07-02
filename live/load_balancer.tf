#only target groups
module "target_groups" {
  source = "../modules/load_balancer/target_group"
  target_groups = [
    {
      name                          = "vb-jugaad-apply-approve-tg-${lower(var.environment)}"
      port                          = 3000
      protocol                      = "HTTP"
      vpc_id                        = var.vpc_id[var.environment]
      name_prefix                   = "example1-"
      protocol_version              = "HTTP1"
      load_balancing_algorithm_type = "round_robin"
      target_type                   = "ip"
      health_check = {
        enabled             = true
        interval            = 60
        path                = "/up"
        port                = 3000
        protocol            = "HTTP"
        timeout             = 30
        healthy_threshold   = 5
        unhealthy_threshold = 2
        matcher             = "200"
      }
      # stickiness = {
      #   type            = "lb_cookie"
      #   cookie_duration = 3600
      # }
      # target_group_health = {
      #   dns_failover = {
      #     minimum_healthy_targets_count      = 2
      #     minimum_healthy_targets_percentage = 80
      #   }
      # }
    },
    {
      name             = "vb-jugaad-form-details-tg-${lower(var.environment)}"
      port             = 3000
      protocol         = "HTTP"
      vpc_id           = var.vpc_id[var.environment]
      protocol_version = "HTTP1"
      certificate_arn  = null
      target_type      = "ip"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/up"
        port                = 3000
        protocol            = "HTTP"
        timeout             = 5
        healthy_threshold   = 5
        unhealthy_threshold = 2
        matcher             = "200"
      }
    },
    {
      name             = "vb-jugaad-notify-tg-${lower(var.environment)}"
      port             = 3000
      protocol         = "HTTP"
      vpc_id           = var.vpc_id[var.environment]
      protocol_version = "HTTP1"
      certificate_arn  = null
      target_type      = "ip"
      health_check = {
        enabled             = true
        interval            = 15
        path                = "/up"
        port                = 3000
        protocol            = "HTTP"
        timeout             = 10
        healthy_threshold   = 5
        unhealthy_threshold = 5
        matcher             = "200"
      }
    },
    {
      name             = "vb-jugaad-pdf-tg-${lower(var.environment)}"
      port             = 3000
      protocol         = "HTTP"
      vpc_id           = var.vpc_id[var.environment]
      protocol_version = "HTTP1"
      certificate_arn  = null
      target_type      = "ip"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = 5
        healthy_threshold   = 5
        unhealthy_threshold = 2
        matcher             = "200"
      }
    },
    {
      name             = "vb-jugaad-report-tg-${lower(var.environment)}"
      port             = 3000
      protocol         = "HTTP"
      vpc_id           = var.vpc_id[var.environment]
      protocol_version = "HTTP1"
      certificate_arn  = null
      target_type      = "ip"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/up"
        port                = 3000
        protocol            = "HTTP"
        timeout             = 5
        healthy_threshold   = 5
        unhealthy_threshold = 2
        matcher             = "200"
      }
    },
    {
      name             = "vb-jugaad-cp-pol-tg-${lower(var.environment)}"
      port             = 3000
      protocol         = "HTTP"
      vpc_id           = var.vpc_id[var.environment]
      protocol_version = "HTTP1"
      certificate_arn  = null
      target_type      = "ip"
      health_check = {
        enabled             = true
        interval            = 60
        path                = "/health-check"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = 30
        healthy_threshold   = 5
        unhealthy_threshold = 2
        matcher             = "200"
      }
    },
    {
      name             = "vb-jugaad-cp-pol-rag-tg-${lower(var.environment)}"
      port             = 8000
      protocol         = "HTTP"
      vpc_id           = var.vpc_id[var.environment]
      protocol_version = "HTTP1"
      certificate_arn  = null
      target_type      = "ip"
      health_check = {
        enabled             = true
        interval            = 60
        path                = "/apistatus"
        port                = 8000
        protocol            = "HTTP"
        timeout             = 40
        healthy_threshold   = 5
        unhealthy_threshold = 2
        matcher             = "200"
      }
    },
    {
      name             = "vb-jugaad-ysn-manage-tg-${lower(var.environment)}"
      port             = 80
      protocol         = "HTTP"
      vpc_id           = var.vpc_id[var.environment]
      protocol_version = "HTTP1"
      certificate_arn  = null
      target_type      = "ip"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/health-check"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = 5
        healthy_threshold   = 5
        unhealthy_threshold = 2
        matcher             = "200"
      }
    },
    {
      name             = "vb-jugaad-ysn-reporting-tg-${lower(var.environment)}"
      port             = 80
      protocol         = "HTTP"
      vpc_id           = var.vpc_id[var.environment]
      protocol_version = "HTTP1"
      certificate_arn  = null
      target_type      = "ip"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/health-check"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = 5
        healthy_threshold   = 5
        unhealthy_threshold = 2
        matcher             = "200"
      }
    },
    {
      name             = "vb-jugaad-cp-announce-tg-${lower(var.environment)}"
      port             = 3000
      protocol         = "HTTP"
      vpc_id           = var.vpc_id[var.environment]
      protocol_version = "HTTP1"
      certificate_arn  = null
      target_type      = "ip"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = 5
        healthy_threshold   = 5
        unhealthy_threshold = 2
        matcher             = "200"
      }
    }
  ]

}

# load balancer (sg also) & listener
module "listeners" {
  source                           = "../modules/load_balancer/load_balancer_&_listener"
  name                             = "vb-jugaad-microservices-lb-${lower(var.environment)}"
  internal                         = false
  load_balancer_type               = "application"
  subnets                          = var.public_subnet_ids
  idle_timeout                     = 60
  drop_invalid_header_fields       = false
  enable_cross_zone_load_balancing = true
  ip_address_type                  = "ipv4"
  enable_deletion_protection       = true
  lb_logging_s3_bucket = module.lb_s3_logging_bucket.s3_bucket_name

  listeners = [
    {
      port     = 80
      protocol = "HTTP"
      # ssl_policy      = "ELBSecurityPolicy-2016-08"
      # certificate_arn = "arn:aws:acm:ap-northeast-1:372296823591:certificate/317a494d-d709-48e4-b4c7-5c5f29dc8ba5"
      # default_action = {
      #   type = "forward"
      #   # target_group_arn = module.target_groups.target_group_arns["vb-jugaad-pdf-tg-${lower(var.environment)}"]
      #   target_group_arn = module.target_groups.target_group_arns["vb-jugaad-apply-approve-tg-${lower(var.environment)}"]
      # }
      default_action = {
        type = "fixed-response"

        fixed_response = {
          content_type = "text/plain"
          message_body = "404 Not Found"
          status_code  = "200"
        }
      }
      # alpn_policy = "HTTP2Preferred"
    }
    # {
    #   port     = 80
    #   protocol = "HTTP"
    #   # ssl_policy      = "ELBSecurityPolicy-2016-08"
    #   # certificate_arn = "arn:aws:acm:ap-northeast-1:372296823591:certificate/317a494d-d709-48e4-b4c7-5c5f29dc8ba5"
    #   default_action = {
    #     type = "redirect"

    #     redirect = {
    #       port        = "443"
    #       protocol    = "HTTPS"
    #       status_code = "HTTP_301"
    #     }
    #   }
    #   # alpn_policy = "HTTP2Preferred"
    # },

  ]

  sg_name        = "vb-jugaad-microservices-lb-sg-${lower(var.environment)}"
  sg_description = "vb-jugaad-microservices-lb-sg-${lower(var.environment)}"
  sg_vpc_id      = var.vpc_id[var.environment]

  ingress_rules = [
    {
      description      = "Allow HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      security_groups  = []
      self             = false
    },
    {
      description      = "Allow HTTP"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      security_groups  = []
      self             = false
    }
    # {
    #   description      = "Allow HTTPS"
    #   from_port        = 3000
    #   to_port          = 3000
    #   protocol         = "tcp"
    #   cidr_blocks      = ["0.0.0.0/0"]
    #   ipv6_cidr_blocks = []
    #   security_groups  = []
    #   self             = false
    # },
    # {
    #   description      = "Allow HTTPS"
    #   from_port        = 8000
    #   to_port          = 8000
    #   protocol         = "tcp"
    #   cidr_blocks      = ["0.0.0.0/0"]
    #   ipv6_cidr_blocks = []
    #   security_groups  = []
    #   self             = false
    # },
    # {
    #   description      = "Allow HTTPS"
    #   from_port        = 443
    #   to_port          = 443
    #   protocol         = "tcp"
    #   cidr_blocks      = ["0.0.0.0/0"]
    #   ipv6_cidr_blocks = []
    #   security_groups  = []
    #   self             = false
    # }
  ]

  egress_rules = [
    {
      description      = "Allow all outbound traffic"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      security_groups  = []
      self             = false
    }
  ]
}

# #only listener_rules
module "listener_rules" {
  source = "../modules/load_balancer/listener_rule"
  listener_rules = [
    {
      listener_arn = module.listeners.listener_arns["0"]
      priority     = 1
      actions = [
        {
          type = "fixed-response"
          fixed_response = {
            content_type = "application/json"
            message_body = "HEALTHY"
            status_code  = "200"
          }

          # target_group_arn = module.target_groups.target_group_arns["vb-jugaad-pdf-tg-${lower(var.environment)}"]

        }
      ]
      conditions = [
        {
          path_pattern = {
            values = ["/mock/*"]
          }
        },
        {
          host_header = {
            values = [var.services_domain[var.environment]]
          }
        },
        {
          http_header = {
            http_header_name = "x-api-gateway-session"
            values           = [data.aws_ssm_parameter.auth_header.value]
          }
        },
        {
          http_header = {
            http_header_name = "x-api-gateway-auth"
            values           = [data.aws_ssm_parameter.auth_header_1.value]
          }
        }
      ]
    },
    {
      listener_arn = module.listeners.listener_arns["0"]
      priority     = 2
      actions = [
        {
          type = "forward"
          # target_group_arn = module.target_groups.target_group_arns["vb-jugaad-pdf-tg-${lower(var.environment)}"]
          target_group_arn = module.target_groups.target_group_arns["vb-jugaad-apply-approve-tg-${lower(var.environment)}"]
        }
      ]
      conditions = [
        {
          path_pattern = {
            values = ["/api/v1/app/*"]
          }
        },
        {
          http_header = {
            http_header_name = "x-api-gateway-session"
            values           = [data.aws_ssm_parameter.auth_header.value]
          }
        },
        {
          http_header = {
            http_header_name = "x-api-gateway-auth"
            values           = [data.aws_ssm_parameter.auth_header_1.value]
          }
        }
      ]
    },
    {
      listener_arn = module.listeners.listener_arns["0"]
      priority     = 3
      actions = [
        {
          type = "forward"
          # target_group_arn = module.target_groups.target_group_arns["vb-jugaad-pdf-tg-${lower(var.environment)}"]
          target_group_arn = module.target_groups.target_group_arns["vb-jugaad-form-details-tg-${lower(var.environment)}"]
        }
      ]
      conditions = [
        {
          path_pattern = {
            values = ["/api/v1/txn/*", "/api/v1/forms/*"]
          }
        },
        {
          http_header = {
            http_header_name = "x-api-gateway-session"
            values           = [data.aws_ssm_parameter.auth_header.value]
          }
        },
        {
          http_header = {
            http_header_name = "x-api-gateway-auth"
            values           = [data.aws_ssm_parameter.auth_header_1.value]
          }
        }
      ]
    },
    {
      listener_arn = module.listeners.listener_arns["0"]
      priority     = 4
      actions = [
        {
          type             = "forward"
          target_group_arn = module.target_groups.target_group_arns["vb-jugaad-pdf-tg-${lower(var.environment)}"]
        }
      ]
      conditions = [
        {
          path_pattern = {
            values = ["/api/v1/pdf/*"]
          }
        },
        {
          http_header = {
            http_header_name = "x-api-gateway-session"
            values           = [data.aws_ssm_parameter.auth_header.value]
          }
        },
        {
          http_header = {
            http_header_name = "x-api-gateway-auth"
            values           = [data.aws_ssm_parameter.auth_header_1.value]
          }
        }
      ]
    },
    {
      listener_arn = module.listeners.listener_arns["0"]
      priority     = 6
      actions = [
        {
          type = "forward"
          # target_group_arn = module.target_groups.target_group_arns["vb-jugaad-pdf-tg-${lower(var.environment)}"]
          target_group_arn = module.target_groups.target_group_arns["vb-jugaad-notify-tg-${lower(var.environment)}"]
        }
      ]
      conditions = [
        {
          path_pattern = {
            values = ["/api/v1/notification/*"]
          }
        },
        {
          http_header = {
            http_header_name = "x-api-gateway-session"
            values           = [data.aws_ssm_parameter.auth_header.value]
          }
        },
        {
          http_header = {
            http_header_name = "x-api-gateway-auth"
            values           = [data.aws_ssm_parameter.auth_header_1.value]
          }
        }
      ]
    },
    {
      listener_arn = module.listeners.listener_arns["0"]
      priority     = 5
      actions = [
        {
          type             = "forward"
          target_group_arn = module.target_groups.target_group_arns["vb-jugaad-report-tg-${lower(var.environment)}"]
        }
      ]
      conditions = [
        {
          path_pattern = {
            values = ["/api/v1/report/*"]
          }
        },
        {
          http_header = {
            http_header_name = "x-api-gateway-session"
            values           = [data.aws_ssm_parameter.auth_header.value]
          }
        },
        {
          http_header = {
            http_header_name = "x-api-gateway-auth"
            values           = [data.aws_ssm_parameter.auth_header_1.value]
          }
        }
      ]
    },
    {
      listener_arn = module.listeners.listener_arns["0"]
      priority     = 7
      actions = [
        {
          type             = "forward"
          target_group_arn = module.target_groups.target_group_arns["vb-jugaad-cp-pol-tg-${lower(var.environment)}"]
        }
      ]
      conditions = [
        {
          path_pattern = {
            values = ["/api/v1/copilot/*"]
          }
        },
        {
          http_header = {
            http_header_name = "x-api-gateway-session"
            values           = [data.aws_ssm_parameter.auth_header.value]
          }
        },
        {
          http_header = {
            http_header_name = "x-api-gateway-auth"
            values           = [data.aws_ssm_parameter.auth_header_1.value]
          }
        }
      ]
    },
    {
      listener_arn = module.listeners.listener_arns["0"]
      priority     = 8
      actions = [
        {
          type             = "forward"
          target_group_arn = module.target_groups.target_group_arns["vb-jugaad-cp-pol-rag-tg-${lower(var.environment)}"]
        }
      ]
      conditions = [
        {
          path_pattern = {
            values = ["/copilot-policy-rag*"]
          }
        }
      ]
    },
    {
      listener_arn = module.listeners.listener_arns["0"]
      priority     = 9
      actions = [
        {
          type             = "forward"
          target_group_arn = module.target_groups.target_group_arns["vb-jugaad-ysn-manage-tg-${lower(var.environment)}"]
        }
      ]
      conditions = [
        {
          path_pattern = {
            values = ["/api/v1/yosan/*"]
          }
        },
        {
          http_header = {
            http_header_name = "x-api-gateway-session"
            values           = [data.aws_ssm_parameter.auth_header.value]
          }
        },
        {
          http_header = {
            http_header_name = "x-api-gateway-auth"
            values           = [data.aws_ssm_parameter.auth_header_1.value]
          }
        }
      ]
    },
    {
      listener_arn = module.listeners.listener_arns["0"]
      priority     = 10
      actions = [
        {
          type             = "forward"
          target_group_arn = module.target_groups.target_group_arns["vb-jugaad-ysn-reporting-tg-${lower(var.environment)}"]
        }
      ]
      conditions = [
        {
          path_pattern = {
            values = ["/api/v1/reporting/*"]
          }
        }
      ]
    },
    {
      listener_arn = module.listeners.listener_arns["0"]
      priority     = 11
      actions = [
        {
          type             = "forward"
          target_group_arn = module.target_groups.target_group_arns["vb-jugaad-apply-approve-tg-${lower(var.environment)}"]
        }
      ]
      conditions = [
        {
          path_pattern = {
            values = ["/api/v1/app/sidekiq*"]
          }
        },
        {
          source_ip = {
            values = [data.aws_ssm_parameter.japan_office_ip.value] # Add CIDRs or individual IPs
          }
        }
      ]
    }
  ]
}

#----------------------------- copilot resources -----------------------------

# # load balancer (sg also) & listener
# module "copilot_listeners" {
#   # count = var.environment == "beta" ? 0 : 1
#   source                           = "../modules/load_balancer/load_balancer_&_listener"
#   name                             = "vb-jugaad-ai-copilot-lb-${lower(var.environment)}"
#   internal                         = false
#   load_balancer_type               = "application"
#   subnets                          = var.public_subnet_ids
#   idle_timeout                     = 60
#   drop_invalid_header_fields       = false
#   enable_cross_zone_load_balancing = true
#   ip_address_type                  = "ipv4"
#   enable_deletion_protection       = true

#   listeners = [
#     {
#       port     = 80
#       protocol = "HTTP"
#       # ssl_policy      = "ELBSecurityPolicy-2016-08"
#       # certificate_arn = "arn:aws:acm:ap-northeast-1:372296823591:certificate/317a494d-d709-48e4-b4c7-5c5f29dc8ba5"
#       default_action = {
#         type             = "forward"
#         target_group_arn = var.environment != "beta" ? module.copilot_target_groups.target_group_arns["vb-jugaad-cp-announcement-tg-${lower(var.environment)}"] : module.copilot_target_groups.target_group_arns["vb-jugaad-cp-annou-tg-${lower(var.environment)}"]
#       }
#       # alpn_policy = "HTTP2Preferred"
#     }
#     # {
#     #   port     = 80
#     #   protocol = "HTTP"
#     #   # ssl_policy      = "ELBSecurityPolicy-2016-08"
#     #   # certificate_arn = "arn:aws:acm:ap-northeast-1:372296823591:certificate/317a494d-d709-48e4-b4c7-5c5f29dc8ba5"
#     #   default_action = {
#     #     type = "redirect"

#     #     redirect = {
#     #       port        = "443"
#     #       protocol    = "HTTPS"
#     #       status_code = "HTTP_301"
#     #     }
#     #   }
#     #   # alpn_policy = "HTTP2Preferred"
#     # },

#   ]

#   sg_name        = "vb-jugaad-ai-copilot-lb-sg-${lower(var.environment)}"
#   sg_description = "vb-jugaad-ai-copilot-lb-sg-${lower(var.environment)}"
#   sg_vpc_id      = var.vpc_id[var.environment]

#   ingress_rules = [
#     {
#       description      = "Allow HTTP"
#       from_port        = 80
#       to_port          = 80
#       protocol         = "tcp"
#       cidr_blocks      = ["0.0.0.0/0"]
#       ipv6_cidr_blocks = ["::/0"]
#       security_groups  = []
#       self             = false
#     },
#     {
#       description      = "Allow HTTPS"
#       from_port        = 3000
#       to_port          = 3000
#       protocol         = "tcp"
#       cidr_blocks      = ["0.0.0.0/0"]
#       ipv6_cidr_blocks = []
#       security_groups  = []
#       self             = false
#     }
#   ]

#   egress_rules = [
#     {
#       description      = "Allow all outbound traffic"
#       from_port        = 0
#       to_port          = 0
#       protocol         = "-1"
#       cidr_blocks      = ["0.0.0.0/0"]
#       ipv6_cidr_blocks = ["::/0"]
#       security_groups  = []
#       self             = false
#     }
#   ]
# }

# # #only target groups
# module "copilot_target_groups" {
#   # count = var.environment == "beta" ? 0 : 1
#   source = "../modules/load_balancer/target_group"
#   target_groups = [
#     {
#       name             = var.environment != "beta" ? "vb-jugaad-cp-announcement-tg-${lower(var.environment)}" : "vb-jugaad-cp-annou-tg-${lower(var.environment)}"
#       port             = 80
#       protocol         = "HTTP"
#       vpc_id           = var.vpc_id[var.environment]
#       protocol_version = "HTTP1"
#       certificate_arn  = null
#       target_type      = "ip"
#       health_check = {
#         enabled             = true
#         interval            = 30
#         path                = "/"
#         port                = "traffic-port"
#         protocol            = "HTTP"
#         timeout             = 5
#         healthy_threshold   = 5
#         unhealthy_threshold = 2
#         matcher             = "200"
#       }
#     },
#     {
#       name             = "vb-jugaad-cp-policy-tg-${lower(var.environment)}"
#       port             = 80
#       protocol         = "HTTPS"
#       vpc_id           = var.vpc_id[var.environment]
#       protocol_version = "HTTP1"
#       certificate_arn  = null
#       target_type      = "ip"
#       health_check = {
#         enabled             = true
#         interval            = 30
#         path                = "/"
#         port                = "traffic-port"
#         protocol            = "HTTP"
#         timeout             = 5
#         healthy_threshold   = 5
#         unhealthy_threshold = 2
#         matcher             = "200"
#       }
#     },
#     {
#       name             = "vb-jugaad-cp-policy-rag-tg-${lower(var.environment)}"
#       port             = 80
#       protocol         = "HTTPS"
#       vpc_id           = var.vpc_id[var.environment]
#       protocol_version = "HTTP1"
#       certificate_arn  = null
#       target_type      = "ip"
#       health_check = {
#         enabled             = true
#         interval            = 30
#         path                = "/"
#         port                = "traffic-port"
#         protocol            = "HTTP"
#         timeout             = 5
#         healthy_threshold   = 5
#         unhealthy_threshold = 2
#         matcher             = "200"
#       }
#     }
#   ]
# }

# # # # #only listener_rules
# module "copilot_listener_rules" {
#   # count = var.environment == "beta" ? 0 : 1
#   source = "../modules/load_balancer/listener_rule"
#   listener_rules = [
#     {
#       listener_arn = module.copilot_listeners.listener_arns["0"]
#       priority     = 1
#       actions = [
#         {
#           type             = "forward"
#           target_group_arn = var.environment != "beta" ? module.copilot_target_groups.target_group_arns["vb-jugaad-cp-announcement-tg-${lower(var.environment)}"] : module.copilot_target_groups.target_group_arns["vb-jugaad-cp-annou-tg-${lower(var.environment)}"]
#         }
#       ]
#       conditions = [
#         {
#           path_pattern = {
#             values = ["/announcement"]
#           }
#         }
#       ]
#     },
#     {
#       listener_arn = module.copilot_listeners.listener_arns["0"]
#       priority     = 2
#       actions = [
#         {
#           type             = "forward"
#           target_group_arn = module.copilot_target_groups.target_group_arns["vb-jugaad-cp-policy-tg-${lower(var.environment)}"]
#         }
#       ]
#       conditions = [
#         {
#           path_pattern = {
#             values = ["/policy", "policyy"]
#           }
#         }
#       ]
#     },
#     {
#       listener_arn = module.copilot_listeners.listener_arns["0"]
#       priority     = 3
#       actions = [
#         {
#           type             = "forward"
#           target_group_arn = module.copilot_target_groups.target_group_arns["vb-jugaad-cp-policy-rag-tg-${lower(var.environment)}"]
#         }
#       ]
#       conditions = [
#         {
#           path_pattern = {
#             values = ["/policyrag"]
#           }
#         }
#       ]
#     }
#   ]
# }

#----------------------------- yosan resources -----------------------------

# # load balancer (sg also) & listener
# module "yosan_listeners" {
#   source                           = "../modules/load_balancer/load_balancer_&_listener"
#   name                             = "vb-jugaad-yosan-lb-${lower(var.environment)}"
#   internal                         = false
#   load_balancer_type               = "application"
#   subnets                          = var.public_subnet_ids
#   idle_timeout                     = 60
#   drop_invalid_header_fields       = false
#   enable_cross_zone_load_balancing = true
#   ip_address_type                  = "ipv4"
#   enable_deletion_protection       = true

#   listeners = [
#     {
#       port     = 80
#       protocol = "HTTP"
#       # ssl_policy      = "ELBSecurityPolicy-2016-08"
#       # certificate_arn = "arn:aws:acm:ap-northeast-1:372296823591:certificate/317a494d-d709-48e4-b4c7-5c5f29dc8ba5"
#       default_action = {
#         type             = "forward"
#         target_group_arn = module.yosan_target_groups.target_group_arns["vb-jugaad-yosan-manage-tg-${lower(var.environment)}"]
#       }
#       # alpn_policy = "HTTP2Preferred"
#     }
#     # {
#     #   port     = 80
#     #   protocol = "HTTP"
#     #   # ssl_policy      = "ELBSecurityPolicy-2016-08"
#     #   # certificate_arn = "arn:aws:acm:ap-northeast-1:372296823591:certificate/317a494d-d709-48e4-b4c7-5c5f29dc8ba5"
#     #   default_action = {
#     #     type = "redirect"

#     #     redirect = {
#     #       port        = "443"
#     #       protocol    = "HTTPS"
#     #       status_code = "HTTP_301"
#     #     }
#     #   }
#     #   # alpn_policy = "HTTP2Preferred"
#     # },

#   ]

#   sg_name        = "vb-jugaad-yosan-lb-sg-${lower(var.environment)}"
#   sg_description = "vb-jugaad-yosan-lb-sg-${lower(var.environment)}"
#   sg_vpc_id      = var.vpc_id[var.environment]

#   ingress_rules = [
#     {
#       description      = "Allow HTTP"
#       from_port        = 80
#       to_port          = 80
#       protocol         = "tcp"
#       cidr_blocks      = ["0.0.0.0/0"]
#       ipv6_cidr_blocks = ["::/0"]
#       security_groups  = []
#       self             = false
#     },
#     {
#       description      = "Allow HTTPS"
#       from_port        = 3000
#       to_port          = 3000
#       protocol         = "tcp"
#       cidr_blocks      = ["0.0.0.0/0"]
#       ipv6_cidr_blocks = []
#       security_groups  = []
#       self             = false
#     }
#   ]

#   egress_rules = [
#     {
#       description      = "Allow all outbound traffic"
#       from_port        = 0
#       to_port          = 0
#       protocol         = "-1"
#       cidr_blocks      = ["0.0.0.0/0"]
#       ipv6_cidr_blocks = ["::/0"]
#       security_groups  = []
#       self             = false
#     }
#   ]
# }

# #only target groups
# module "yosan_target_groups" {
#   source = "../modules/load_balancer/target_group"
#   target_groups = [
#     {
#       name             = "vb-jugaad-yosan-manage-tg-${lower(var.environment)}"
#       port             = 80
#       protocol         = "HTTP"
#       vpc_id           = var.vpc_id[var.environment]
#       protocol_version = "HTTP1"
#       certificate_arn  = null
#       target_type      = "ip"
#       health_check = {
#         enabled             = true
#         interval            = 30
#         path                = "/health-check"
#         port                = "traffic-port"
#         protocol            = "HTTP"
#         timeout             = 5
#         healthy_threshold   = 5
#         unhealthy_threshold = 2
#         matcher             = "200"
#       }
#     },
#     {
#       name             = "vb-jugaad-yosan-report-tg-${lower(var.environment)}"
#       port             = 80
#       protocol         = "HTTPS"
#       vpc_id           = var.vpc_id[var.environment]
#       protocol_version = "HTTP1"
#       certificate_arn  = null
#       target_type      = "ip"
#       health_check = {
#         enabled             = true
#         interval            = 30
#         path                = "/"
#         port                = "traffic-port"
#         protocol            = "HTTP"
#         timeout             = 5
#         healthy_threshold   = 5
#         unhealthy_threshold = 2
#         matcher             = "200"
#       }
#     }
#   ]
# }

# # # #only listener_rules
# module "yosan_listener_rules" {
#   source = "../modules/load_balancer/listener_rule"
#   listener_rules = [
#     {
#       listener_arn = module.yosan_listeners.listener_arns["0"]
#       priority     = 1
#       actions = [
#         {
#           type             = "forward"
#           target_group_arn = module.yosan_target_groups.target_group_arns["vb-jugaad-yosan-manage-tg-${lower(var.environment)}"]
#         }
#       ]
#       conditions = [
#         {
#           path_pattern = {
#             values = ["/announcement"]
#           }
#         }
#       ]
#     },
#     {
#       listener_arn = module.yosan_listeners.listener_arns["0"]
#       priority     = 2
#       actions = [
#         {
#           type             = "forward"
#           target_group_arn = module.yosan_target_groups.target_group_arns["vb-jugaad-yosan-report-tg-${lower(var.environment)}"]
#         }
#       ]
#       conditions = [
#         {
#           path_pattern = {
#             values = ["/policy", "policyy"]
#           }
#         }
#       ]
#     }
#   ]
# }