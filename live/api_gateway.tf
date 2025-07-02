locals {
  auth_lambda_name = var.environment == "beta" ? "vb-jugaad-authorization-lambda-beta" : "vb-jugaad-authorization-lambda"
}

locals {
  api_gateway_configs = [
    {
      identifier                  = "microservices"
      api_gateway_name            = "${lower(var.vendor)}-${lower(var.project_name)}-identifier-api-gateway-${lower(var.environment)}"
      service_name                = "com.amazonaws.${data.aws_region.current.id}.execute-api"
      api_gateway_description     = "Rest API Gateway"
      role_prefix                 = "vb-jugaad-api-gateway-role-${lower(var.environment)}"
      stage_name                  = "${lower(var.environment)}"
      xray_tracing_enabled        = true
      metrics_enabled             = true
      logging_level               = "INFO"
      cache_data_encrypted        = true
      log_group_name              = "${lower(var.vendor)}-${lower(var.project_name)}-api-log-group-${lower(var.environment)}"
      log_group_retention_in_days = var.log_group_retention_api_gateway
      binary_media_types  = ["multipart/form-data", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "application/octet-stream", "application/zip"]
      dev_api_stages = [
        {
          name                 = "dev"
          variables            = var.api_stage_variables
          log_group_name       = "${lower(var.vendor)}-${lower(var.project_name)}-api-log-group-stage-${lower(var.environment)}"
          retention_in_days    = var.log_group_retention_api_gateway
          xray_tracing_enabled = true
        },
        {
          name                 = "mock"
          variables            = var.mock_stage_variables
          log_group_name       = "${lower(var.vendor)}-${lower(var.project_name)}-api-log-group-stage-mock"
          retention_in_days    = var.log_group_retention_api_gateway
          xray_tracing_enabled = true
        },
        {
          name                 = "test"
          variables            = var.test_stage_variables
          log_group_name       = "${lower(var.vendor)}-${lower(var.project_name)}-api-log-group-stage-test"
          retention_in_days    = var.log_group_retention_api_gateway
          xray_tracing_enabled = true
        },
        {
          name                 = "testing"
          variables            = var.testing_stage_variables
          log_group_name       = "${lower(var.vendor)}-${lower(var.project_name)}-api-log-group-stage-testing"
          retention_in_days    = var.log_group_retention_api_gateway
          xray_tracing_enabled = true
        },
        {
          name                 = "workflow"
          variables            = var.workflow_stage_variables
          log_group_name       = "${lower(var.vendor)}-${lower(var.project_name)}-api-log-group-stage-workflow"
          retention_in_days    = var.log_group_retention_api_gateway
          xray_tracing_enabled = true
        }
      ]
      stg_api_stages = [
        {
          name                 = "stg"
          variables            = var.api_stage_variables
          log_group_name       = "${lower(var.vendor)}-${lower(var.project_name)}-api-log-group-stage-${lower(var.environment)}"
          retention_in_days    = var.log_group_retention_api_gateway
          xray_tracing_enabled = true
        },
        {
          name                 = "mock"
          variables            = var.mock_stage_variables
          log_group_name       = "${lower(var.vendor)}-${lower(var.project_name)}-api-log-group-stage-mock"
          retention_in_days    = var.log_group_retention_api_gateway
          xray_tracing_enabled = true
        },
        {
          name                 = "test"
          variables            = var.test_stage_variables
          log_group_name       = "${lower(var.vendor)}-${lower(var.project_name)}-api-log-group-stage-test"
          retention_in_days    = var.log_group_retention_api_gateway
          xray_tracing_enabled = true
        }
      ]
      beta_api_stages = [
        {
          name                 = "beta"
          variables            = var.api_stage_variables
          log_group_name       = "${lower(var.vendor)}-${lower(var.project_name)}-api-log-group-stage-${lower(var.environment)}"
          retention_in_days    = var.log_group_retention_api_gateway
          xray_tracing_enabled = true
        },
        {
          name                 = "mock"
          variables            = var.mock_stage_variables
          log_group_name       = "${lower(var.vendor)}-${lower(var.project_name)}-api-log-group-stage-mock"
          retention_in_days    = var.log_group_retention_api_gateway
          xray_tracing_enabled = true
        },
        {
          name                 = "test"
          variables            = var.test_stage_variables
          log_group_name       = "${lower(var.vendor)}-${lower(var.project_name)}-api-log-group-stage-test"
          retention_in_days    = var.log_group_retention_api_gateway
          xray_tracing_enabled = true
        }
      ]
      prod_api_stages = [
        {
          name                 = "prod"
          variables            = var.api_stage_variables
          log_group_name       = "${lower(var.vendor)}-${lower(var.project_name)}-api-log-group-stage-${lower(var.environment)}"
          retention_in_days    = var.log_group_retention_api_gateway
          xray_tracing_enabled = true
        }
      ]
      openapi_body = {
        "openapi" : "3.0.2",
        "info" : {
          "title" : "JUGAAD Application",
          "version" : "1.0"
        },
        "paths" : {
          "/api/v1/app/{proxy+}" : {
            "x-amazon-apigateway-any-method" : {
              #start
              "parameters" : [
                {
                  "name" : "proxy",
                  "in" : "path",
                  "required" : true,
                  "schema" : {
                    "type" : "string"
                  }
                },
                {
                  "name" : "Authorization",
                  "in" : "header",
                  "required" : false,
                  "schema" : {
                    "type" : "string"
                  }
                }
              ],
              #end
              "x-amazon-apigateway-integration" : {
                "type" : "http_proxy",
                "httpMethod" : "ANY",
                "uri" : "http://$$${stageVariables.forward_url}/api/v1/app/{proxy}"
                "requestParameters" : {
                  "integration.request.path.proxy" : "method.request.path.proxy",
                  "integration.request.header.Authorization" : "method.request.header.Authorization",
                  "integration.request.header.x-api-gateway-session" : "'${data.aws_ssm_parameter.auth_header.value}'",
                  "integration.request.header.x-api-gateway-auth" : "'${data.aws_ssm_parameter.auth_header_1.value}'",
                  "integration.request.header.x-company-id" : "context.authorizer.company_id",
                  "integration.request.header.x-request-path" : "context.authorizer.resource_path",
                  "integration.request.header.x-stage-name" : "context.authorizer.stage_name",
                  "integration.request.header.x-user-id" : "context.authorizer.user_id"
                }
                "payloadFormatVersion" : "1.0",
              }
              "responses" : {
                "200" : {
                  "description" : "200 response",
                  "content" : {
                    "application/json" : {
                      "schema" : {
                        "$ref" : "#/components/schemas/Empty"
                      }
                    }
                  }
                }
              }
              security = [
                {
                  auth_lambda_authorizer_no_caching = []
                }
              ]
            },
            options = {
              responses = {
                "200" = {
                  description = "CORS OK"
                  headers = {
                    "Access-Control-Allow-Origin" = {
                    }
                    "Access-Control-Allow-Methods" = {
                    }
                    "Access-Control-Allow-Headers" = {
                    }
                  }
                }
              }
              x-amazon-apigateway-integration = {
                "type" : "AWS_PROXY",
                "httpMethod" : "POST",
                "uri" : "arn:aws:apigateway:${data.aws_region.current.id}:lambda:path/2015-03-31/functions/arn:aws:lambda:ap-northeast-1:${data.aws_caller_identity.current.account_id}:function:${local.auth_lambda_name}/invocations"
                "payloadFormatVersion" : "1.0",
                requestTemplates = {
                  "application/json" = "{\"statusCode\": 200}"
                }
                responses = {
                  "default" = {
                    statusCode = "200"
                    responseParameters = {
                      "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS,GET,POST,PUT,DELETE,PATCH'"
                      "method.response.header.Access-Control-Allow-Headers" = "'*'"
                      "method.response.header.Access-Control-Allow-Origin"  = "'*'"
                    }
                  }
                }
              }
            }
          },
          "/api/v1/forms/{proxy+}" : {
            "x-amazon-apigateway-any-method" : {
              "parameters" : [
                {
                  "name" : "proxy",
                  "in" : "path",
                  "required" : true,
                  "schema" : {
                    "type" : "string"
                  }
                }
              ],
              "x-amazon-apigateway-integration" : {
                "type" : "http_proxy",
                "httpMethod" : "ANY",
                "uri" : "http://$${stageVariables.forward_url}/api/v1/forms/{proxy}"
                "requestParameters" : {
                  "integration.request.path.proxy" : "method.request.path.proxy",
                  # "integration.request.header.Authorization" : "method.request.header.Authorization",
                  "integration.request.header.x-company-id" : "context.authorizer.company_id",
                  "integration.request.header.x-api-gateway-session" : "'${data.aws_ssm_parameter.auth_header.value}'",
                  "integration.request.header.x-api-gateway-auth" : "'${data.aws_ssm_parameter.auth_header_1.value}'",
                  "integration.request.header.x-request-path" : "context.authorizer.resource_path",
                  "integration.request.header.x-stage-name" : "context.authorizer.stage_name",
                  "integration.request.header.x-user-id" : "context.authorizer.user_id"
                }
                "payloadFormatVersion" : "1.0",
              }
              "responses" : {
                "200" : {
                  "description" : "200 response",
                  "content" : {
                    "application/json" : {
                      "schema" : {
                        "$ref" : "#/components/schemas/Empty"
                      }
                    }
                  }
                }
              }
              security = [
                {
                  auth_lambda_authorizer_no_caching = []
                }
              ]
            }
            options = {
              responses = {
                "200" = {
                  description = "CORS OK"
                  headers = {
                    "Access-Control-Allow-Origin" = {
                    }
                    "Access-Control-Allow-Methods" = {
                    }
                    "Access-Control-Allow-Headers" = {
                    }
                  }
                }
              }
              x-amazon-apigateway-integration = {
                "type" : "AWS_PROXY",
                "httpMethod" : "POST",
                "uri" : "arn:aws:apigateway:${data.aws_region.current.id}:lambda:path/2015-03-31/functions/arn:aws:lambda:ap-northeast-1:${data.aws_caller_identity.current.account_id}:function:${local.auth_lambda_name}/invocations"
                "payloadFormatVersion" : "1.0",
                requestTemplates = {
                  "application/json" = "{\"statusCode\": 200}"
                }
                responses = {
                  "default" = {
                    statusCode = "200"
                    responseParameters = {
                      "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS,GET,POST,PUT,DELETE,PATCH'"
                      "method.response.header.Access-Control-Allow-Headers" = "'*'"
                      "method.response.header.Access-Control-Allow-Origin"  = "'*'"
                    }
                  }
                }
              }
            }
          },
          "/api/v1/pdf/{proxy+}" : {
            "x-amazon-apigateway-any-method" : {
              "parameters" : [
                {
                  "name" : "proxy",
                  "in" : "path",
                  "required" : true,
                  "schema" : {
                    "type" : "string"
                  }
                },
                {
                  "name" : "Authorization",
                  "in" : "header",
                  "required" : false,
                  "schema" : {
                    "type" : "string"
                  }
                }
              ],
              "x-amazon-apigateway-integration" : {
                "type" : "http_proxy",
                "httpMethod" : "ANY",
                "uri" : "http://$${stageVariables.forward_url}/api/v1/pdf/{proxy}"
                "requestParameters" : {
                  "integration.request.path.proxy" : "method.request.path.proxy",
                  "integration.request.header.Authorization" : "method.request.header.Authorization",
                  "integration.request.header.x-api-gateway-session" : "'${data.aws_ssm_parameter.auth_header.value}'",
                  "integration.request.header.x-api-gateway-auth" : "'${data.aws_ssm_parameter.auth_header_1.value}'",
                  "integration.request.header.x-company-id" : "context.authorizer.company_id",
                  "integration.request.header.x-request-path" : "context.authorizer.resource_path",
                  "integration.request.header.x-stage-name" : "context.authorizer.stage_name",
                  "integration.request.header.x-user-id" : "context.authorizer.user_id"
                }
                "payloadFormatVersion" : "1.0",
              }
              "responses" : {
                "200" : {
                  "description" : "200 response",
                  "content" : {
                    "application/json" : {
                      "schema" : {
                        "$ref" : "#/components/schemas/Empty"
                      }
                    }
                  }
                }
              }
              security = [
                {
                  auth_lambda_authorizer_no_caching = []
                }
              ]
            }
            options = {
              responses = {
                "200" = {
                  description = "CORS OK"
                  headers = {
                    "Access-Control-Allow-Origin" = {
                    }
                    "Access-Control-Allow-Methods" = {
                    }
                    "Access-Control-Allow-Headers" = {
                    }
                  }
                }
              }
              x-amazon-apigateway-integration = {
                "type" : "AWS_PROXY",
                "httpMethod" : "POST",
                "uri" : "arn:aws:apigateway:${data.aws_region.current.id}:lambda:path/2015-03-31/functions/arn:aws:lambda:ap-northeast-1:${data.aws_caller_identity.current.account_id}:function:${local.auth_lambda_name}/invocations"
                "payloadFormatVersion" : "1.0",
                requestTemplates = {
                  "application/json" = "{\"statusCode\": 200}"
                }
                responses = {
                  "default" = {
                    statusCode = "200"
                    responseParameters = {
                      "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS,GET,POST,PUT,DELETE,PATCH'"
                      "method.response.header.Access-Control-Allow-Headers" = "'*'"
                      "method.response.header.Access-Control-Allow-Origin"  = "'*'"
                    }
                  }
                }
              }
            }
          },
          "/api/v1/report/{proxy+}" : {
            "x-amazon-apigateway-any-method" : {
              "parameters" : [
                {
                  "name" : "proxy",
                  "in" : "path",
                  "required" : true,
                  "schema" : {
                    "type" : "string"
                  }
                },
                {
                  "name" : "Authorization",
                  "in" : "header",
                  "required" : false,
                  "schema" : {
                    "type" : "string"
                  }
                }
              ],
              "x-amazon-apigateway-integration" : {
                "type" : "http_proxy",
                "httpMethod" : "ANY",
                "uri" : "http://$${stageVariables.forward_url}/api/v1/report/{proxy}"
                "requestParameters" : {
                  "integration.request.path.proxy" : "method.request.path.proxy",
                  "integration.request.header.Authorization" : "method.request.header.Authorization",
                  "integration.request.header.x-company-id" : "context.authorizer.company_id",
                  "integration.request.header.x-api-gateway-session" : "'${data.aws_ssm_parameter.auth_header.value}'",
                  "integration.request.header.x-api-gateway-auth" : "'${data.aws_ssm_parameter.auth_header_1.value}'",
                  "integration.request.header.x-request-path" : "context.authorizer.resource_path",
                  "integration.request.header.x-stage-name" : "context.authorizer.stage_name",
                  "integration.request.header.x-user-id" : "context.authorizer.user_id"
                }
                "payloadFormatVersion" : "1.0",
              }
              "responses" : {
                "200" : {
                  "description" : "200 response",
                  "content" : {
                    "application/json" : {
                      "schema" : {
                        "$ref" : "#/components/schemas/Empty"
                      }
                    }
                  }
                }
              }
              security = [
                {
                  auth_lambda_authorizer_no_caching = []
                }
              ]
            }
            options = {
              responses = {
                "200" = {
                  description = "CORS OK"
                  headers = {
                    "Access-Control-Allow-Origin" = {
                    }
                    "Access-Control-Allow-Methods" = {
                    }
                    "Access-Control-Allow-Headers" = {
                    }
                  }
                }
              }
              x-amazon-apigateway-integration = {
                "type" : "AWS_PROXY",
                "httpMethod" : "POST",
                "uri" : "arn:aws:apigateway:${data.aws_region.current.id}:lambda:path/2015-03-31/functions/arn:aws:lambda:ap-northeast-1:${data.aws_caller_identity.current.account_id}:function:${local.auth_lambda_name}/invocations"
                "payloadFormatVersion" : "1.0",
                requestTemplates = {
                  "application/json" = "{\"statusCode\": 200}"
                }
                responses = {
                  "default" = {
                    statusCode = "200"
                    responseParameters = {
                      "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS,GET,POST,PUT,DELETE,PATCH'"
                      "method.response.header.Access-Control-Allow-Headers" = "'*'"
                      "method.response.header.Access-Control-Allow-Origin"  = "'*'"
                    }
                  }
                }
              }
            }
          },
          "/api/v1/txn/{proxy+}" : {
            "x-amazon-apigateway-any-method" : {
              "parameters" : [
                {
                  "name" : "proxy",
                  "in" : "path",
                  "required" : true,
                  "schema" : {
                    "type" : "string"
                  }
                },
                {
                  "name" : "Authorization",
                  "in" : "header",
                  "required" : false,
                  "schema" : {
                    "type" : "string"
                  }
                }
              ],
              "x-amazon-apigateway-integration" : {
                "type" : "http_proxy",
                "httpMethod" : "ANY",
                "uri" : "http://$${stageVariables.forward_url}/api/v1/txn/{proxy}"
                "requestParameters" : {
                  "integration.request.path.proxy" : "method.request.path.proxy",
                  "integration.request.header.Authorization" : "method.request.header.Authorization",
                  "integration.request.header.x-api-gateway-session" : "'${data.aws_ssm_parameter.auth_header.value}'",
                  "integration.request.header.x-api-gateway-auth" : "'${data.aws_ssm_parameter.auth_header_1.value}'",
                  "integration.request.header.x-company-id" : "context.authorizer.company_id",
                  "integration.request.header.x-request-path" : "context.authorizer.resource_path",
                  "integration.request.header.x-stage-name" : "context.authorizer.stage_name",
                  "integration.request.header.x-user-id" : "context.authorizer.user_id"
                }
                "payloadFormatVersion" : "1.0",
              }
              "responses" : {
                "200" : {
                  "description" : "200 response",
                  "content" : {
                    "application/json" : {
                      "schema" : {
                        "$ref" : "#/components/schemas/Empty"
                      }
                    }
                  }
                }
              }
              security = [
                {
                  auth_lambda_authorizer_no_caching = []
                }
              ]
            }
            options = {
              responses = {
                "200" = {
                  description = "CORS OK"
                  headers = {
                    "Access-Control-Allow-Origin" = {
                    }
                    "Access-Control-Allow-Methods" = {
                    }
                    "Access-Control-Allow-Headers" = {
                    }
                  }
                }
              }
              x-amazon-apigateway-integration = {
                "type" : "AWS_PROXY",
                "httpMethod" : "POST",
                "uri" : "arn:aws:apigateway:${data.aws_region.current.id}:lambda:path/2015-03-31/functions/arn:aws:lambda:ap-northeast-1:${data.aws_caller_identity.current.account_id}:function:${local.auth_lambda_name}/invocations"
                "payloadFormatVersion" : "1.0",
                requestTemplates = {
                  "application/json" = "{\"statusCode\": 200}"
                }
                responses = {
                  "default" = {
                    statusCode = "200"
                    responseParameters = {
                      "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS,GET,POST,PUT,DELETE,PATCH'"
                      "method.response.header.Access-Control-Allow-Headers" = "'*'"
                      "method.response.header.Access-Control-Allow-Origin"  = "'*'"
                    }
                  }
                }
              }
            }
          },
          "/api/v1/txn/graphql" : {
            "post" : {
              "parameters" : [
                {
                  "name" : "proxy",
                  "in" : "path",
                  "required" : true,
                  "schema" : {
                    "type" : "string"
                  }
                },
                {
                  "name" : "Authorization",
                  "in" : "header",
                  "required" : false,
                  "schema" : {
                    "type" : "string"
                  }
                }
              ],
              "x-amazon-apigateway-integration" : {
                "type" : "http_proxy",
                "httpMethod" : "ANY",
                "uri" : "http://$${stageVariables.forward_url}/api/v1/txn/graphql"
                "requestParameters" : {
                  "integration.request.path.proxy" : "method.request.path.proxy",
                  "integration.request.header.Authorization" : "method.request.header.Authorization",
                  "integration.request.header.x-api-gateway-session" : "'${data.aws_ssm_parameter.auth_header.value}'",
                  "integration.request.header.x-api-gateway-auth" : "'${data.aws_ssm_parameter.auth_header_1.value}'",
                  "integration.request.header.x-company-id" : "context.authorizer.company_id",
                  "integration.request.header.x-request-path" : "context.authorizer.resource_path",
                  "integration.request.header.x-stage-name" : "context.authorizer.stage_name",
                  "integration.request.header.x-user-id" : "context.authorizer.user_id"
                }
                "payloadFormatVersion" : "1.0",
              }
              "responses" : {
                "200" : {
                  "description" : "200 response",
                  "content" : {
                    "application/json" : {
                      "schema" : {
                        "$ref" : "#/components/schemas/Empty"
                      }
                    }
                  }
                }
              }
              security = [
                {
                  auth_lambda_authorizer_no_caching = []
                }
              ]
            }
            options = {
              responses = {
                "200" = {
                  description = "CORS OK"
                  headers = {
                    "Access-Control-Allow-Origin" = {
                    }
                    "Access-Control-Allow-Methods" = {
                    }
                    "Access-Control-Allow-Headers" = {
                    }
                  }
                }
              }
              x-amazon-apigateway-integration = {
                "type" : "AWS_PROXY",
                "httpMethod" : "POST",
                "uri" : "arn:aws:apigateway:${data.aws_region.current.id}:lambda:path/2015-03-31/functions/arn:aws:lambda:ap-northeast-1:${data.aws_caller_identity.current.account_id}:function:${local.auth_lambda_name}/invocations"
                "payloadFormatVersion" : "1.0",
                requestTemplates = {
                  "application/json" = "{\"statusCode\": 200}"
                }
                responses = {
                  "default" = {
                    statusCode = "200"
                    responseParameters = {
                      "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS,GET,POST,PUT,DELETE,PATCH'"
                      "method.response.header.Access-Control-Allow-Headers" = "'*'"
                      "method.response.header.Access-Control-Allow-Origin"  = "'*'"
                    }
                  }
                }
              }
            }
          },
          "/api/v1/yosan/{proxy+}" : {
            "x-amazon-apigateway-any-method" : {
              "parameters" : [
                {
                  "name" : "proxy",
                  "in" : "path",
                  "required" : true,
                  "schema" : {
                    "type" : "string"
                  }
                },
                {
                  "name" : "Authorization",
                  "in" : "header",
                  "required" : false,
                  "schema" : {
                    "type" : "string"
                  }
                },
                {
                  "name" : "Content-Type",
                  "in" : "header",
                  "required" : false,
                  "schema" : {
                    "type" : "string"
                  }
                }
              ],
              "x-amazon-apigateway-integration" : {
                "type" : "http_proxy",
                "httpMethod" : "ANY",
                "uri" : "http://$${stageVariables.forward_url}/api/v1/yosan/{proxy}"
                "requestParameters" : {
                  "integration.request.path.proxy" : "method.request.path.proxy",
                  # "integration.request.header.Content-Type" : "method.request.header.Content-Type",
                  "integration.request.header.Authorization" : "method.request.header.Authorization",
                  "integration.request.header.x-api-gateway-auth" : "'${data.aws_ssm_parameter.auth_header_1.value}'",
                  "integration.request.header.x-api-gateway-session" : "'${data.aws_ssm_parameter.auth_header.value}'",
                  "integration.request.header.x-company-id" : "context.authorizer.company_id",
                  "integration.request.header.x-request-path" : "context.authorizer.resource_path",
                  "integration.request.header.x-stage-name" : "context.authorizer.stage_name",
                  "integration.request.header.x-user-id" : "context.authorizer.user_id"
                }
                "payloadFormatVersion" : "1.0",
              }
              "responses" : {
                "200" : {
                  "description" : "200 response",
                  "content" : {
                    "application/json" : {
                      "schema" : {
                        "$ref" : "#/components/schemas/Empty"
                      }
                    }
                  }
                }
              }
              security = [
                {
                  auth_lambda_authorizer_no_caching = []
                }
              ]
            }
            options = {
              responses = {
                "200" = {
                  description = "CORS OK"
                  headers = {
                    "Access-Control-Allow-Origin" = {
                    }
                    "Access-Control-Allow-Methods" = {
                    }
                    "Access-Control-Allow-Headers" = {
                    }
                  }
                }
              }
              x-amazon-apigateway-integration = {
                "type" : "AWS_PROXY",
                "httpMethod" : "POST",
                "uri" : "arn:aws:apigateway:${data.aws_region.current.id}:lambda:path/2015-03-31/functions/arn:aws:lambda:ap-northeast-1:${data.aws_caller_identity.current.account_id}:function:${local.auth_lambda_name}/invocations"
                "payloadFormatVersion" : "1.0",
                requestTemplates = {
                  "application/json" = "{\"statusCode\": 200}"
                }
                responses = {
                  "default" = {
                    statusCode = "200"
                    responseParameters = {
                      "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS,GET,POST,PUT,DELETE,PATCH'"
                      "method.response.header.Access-Control-Allow-Headers" = "'*'"
                      "method.response.header.Access-Control-Allow-Origin"  = "'*'"
                    }
                  }
                }
              }
            }
          },
          "/api/v1/copilot/{proxy+}" : {
            "x-amazon-apigateway-any-method" : {
              "parameters" : [
                {
                  "name" : "proxy",
                  "in" : "path",
                  "required" : true,
                  "schema" : {
                    "type" : "string"
                  }
                },
                {
                  "name" : "Authorization",
                  "in" : "header",
                  "required" : false,
                  "schema" : {
                    "type" : "string"
                  }
                },
                {
                  "name" : "Content-Type",
                  "in" : "header",
                  "required" : false,
                  "schema" : {
                    "type" : "string"
                  }
                }
              ],
              "x-amazon-apigateway-integration" : {
                "type" : "http_proxy",
                "httpMethod" : "ANY",
                "uri" : "http://$${stageVariables.forward_url}/api/v1/copilot/{proxy}"
                "requestParameters" : {
                  "integration.request.path.proxy" : "method.request.path.proxy",
                  # "integration.request.header.Content-Type" : "method.request.header.Content-Type",
                  "integration.request.header.Authorization" : "method.request.header.Authorization",
                  "integration.request.header.x-api-gateway-auth" : "'${data.aws_ssm_parameter.auth_header_1.value}'",
                  "integration.request.header.x-api-gateway-session" : "'${data.aws_ssm_parameter.auth_header.value}'",
                  "integration.request.header.x-company-id" : "context.authorizer.company_id",
                  "integration.request.header.x-request-path" : "context.authorizer.resource_path",
                  "integration.request.header.x-stage-name" : "context.authorizer.stage_name",
                  "integration.request.header.x-user-id" : "context.authorizer.user_id"
                }
                "payloadFormatVersion" : "1.0",
              }
              "responses" : {
                "200" : {
                  "description" : "200 response",
                  "content" : {
                    "application/json" : {
                      "schema" : {
                        "$ref" : "#/components/schemas/Empty"
                      }
                    }
                  }
                }
              }
              security = [
                {
                  auth_lambda_authorizer_no_caching = []
                }
              ]
            }
            options = {
              responses = {
                "200" = {
                  description = "CORS OK"
                  headers = {
                    "Access-Control-Allow-Origin" = {
                    }
                    "Access-Control-Allow-Methods" = {
                    }
                    "Access-Control-Allow-Headers" = {
                    }
                  }
                }
              }
              x-amazon-apigateway-integration = {
                "type" : "AWS_PROXY",
                "httpMethod" : "POST",
                "uri" : "arn:aws:apigateway:${data.aws_region.current.id}:lambda:path/2015-03-31/functions/arn:aws:lambda:ap-northeast-1:${data.aws_caller_identity.current.account_id}:function:${local.auth_lambda_name}/invocations"
                "payloadFormatVersion" : "1.0",
                requestTemplates = {
                  "application/json" = "{\"statusCode\": 200}"
                }
                responses = {
                  "default" = {
                    statusCode = "200"
                    responseParameters = {
                      "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS,GET,POST,PUT,DELETE,PATCH'"
                      "method.response.header.Access-Control-Allow-Headers" = "'*'"
                      "method.response.header.Access-Control-Allow-Origin"  = "'*'"
                    }
                  }
                }
              }
            }
          }
        }
        "x-amazon-apigateway-gateway-responses" : {
          "ACCESS_DENIED" : {
            "statusCode" : "403",
            "responseTemplates" : {
              "application/json" : "{\n   \"message\": \"Unauthorized\",\n   \"error_code\": \"$context.authorizer.error_code\",\n   \"error_code_str\": \"$context.authorizer.error_code_str\",\n  \"error_message\": \"$context.authorizer.error_message\",\n  \"exception\": \"$context.authorizer.exception\",\n  \"details\": $context.error.messageString\n}"
            },
            "responseParameters" : {
              "gatewayresponse.header.Access-Control-Allow-Credentials" : "'true'",
              "gatewayresponse.header.Access-Control-Allow-Origin" : "method.request.header.Origin"
            }
          },
          "API_CONFIGURATION_ERROR" : {
            "statusCode" : "500",
            "responseTemplates" : {
              "application/json" : "{\n   \"message\": $context.error.messageString,\n   \"error_code\": \"Exception\",\n   \"error_code_str\": \"APIConfigurationError. Please contact Administrator\",\n  \"details\": \"Please check RDS connectivity, Lambda Timeout, IAM permissions etc \"\n}"
            }
            "responseParameters" : {
              "gatewayresponse.header.Access-Control-Allow-Origin" : "method.request.header.Origin"
            }
          },
          "AUTHORIZER_CONFIGURATION_ERROR" : {
            "statusCode" : "500",
            "responseTemplates" : {
              "application/json" : "{\n   \"message\": $context.error.messageString,\n   \"error_code\": \"Exception\",\n   \"error_code_str\": \"APIConfigurationError. Please contact Administrator\",\n  \"details\": \"Please check RDS connectivity, Lambda Timeout, IAM permissions etc \"\n}"
            }
            "responseParameters" : {
              "gatewayresponse.header.Access-Control-Allow-Origin" : "method.request.header.Origin"
            }
          },
          "AUTHORIZER_FAILURE" : {
            "statusCode" : "500",
            "responseTemplates" : {
              "application/json" : "{\n   \"message\": $context.error.messageString,\n   \"error_code\": \"Exception\",\n   \"error_code_str\": \"APIConfigurationError. Please contact Administrator\",\n  \"details\": \"Please check RDS connectivity, Lambda Timeout, IAM permissions etc \"\n}"
            }
            "responseParameters" : {
              "gatewayresponse.header.Access-Control-Allow-Origin" : "method.request.header.Origin"
            }
          },
          "EXPIRED_TOKEN" : {
            "statusCode" : "403",
            "responseTemplates" : {
              "application/json" : "{\n   \"message\": \"Unauthorized\",\n   \"details\": $context.error.messageString\n}"
            }
            // "responseParameters" : {
            //   "gatewayresponse.header.Access-Control-Allow-Headers" : "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
            // }
          },
          "INVALID_API_KEY" : {
            "statusCode" : "403",
            "responseTemplates" : {
              "application/json" : "{\n   \"message\": $context.error.messageString,\n   \"error_code\": \"123456\"\n }"
            }
            // "responseParameters" : {
            //   "gatewayresponse.header.Access-Control-Allow-Headers" : "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
            // }
          },
          "INVALID_SIGNATURE" : {
            "statusCode" : "403",
            "responseTemplates" : {
              "application/json" : "{\n   \"message\": \"Unauthorized\",\n   \"details\": $context.error.messageString\n}"
            }
            // "responseParameters" : {
            //   "gatewayresponse.header.Access-Control-Allow-Headers" : "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
            // }
          },
          "MISSING_AUTHENTICATION_TOKEN" : {
            "statusCode" : "403",
            "responseTemplates" : {
              "application/json" : "{\n   \"message\": \"Unauthorized\",\n   \"details\": $context.error.messageString\n}"
            }
            // "responseParameters" : {
            //   "gatewayresponse.header.Access-Control-Allow-Headers" : "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
            // }
          },
          "UNAUTHORIZED" : {
            "statusCode" : "401",
            "responseTemplates" : {
              "application/json" : "{\n   \"message\": $context.error.messageString\n}"
            }
            // "responseParameters" : {
            //   "gatewayresponse.header.Access-Control-Allow-Headers" : "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
            // }
          },
          "REQUEST_TOO_LARGE" : {
            "statusCode" : "413",
            "responseTemplates" : {
              "application/json" : "{\n   \"message\": $context.error.messageString\n}"
            }
            "responseParameters" : {
              "gatewayresponse.header.Access-Control-Allow-Origin" : "method.request.header.Origin"
            }
          },
          "QUOTA_EXCEEDED" : {
            "statusCode" : "429",
            "responseTemplates" : {
              "application/json" : "{\n   \"message\": $context.error.messageString\n}"
            }
            "responseParameters" : {
              "gatewayresponse.header.Access-Control-Allow-Origin" : "method.request.header.Origin"
            }
          },
          "INTEGRATION_TIMEOUT" : {
            "statusCode" : "504",
            "responseTemplates" : {
              "application/json" : "{\n   \"message\": $context.error.messageString\n}"
            }
            "responseParameters" : {
              "gatewayresponse.header.Access-Control-Allow-Origin" : "method.request.header.Origin"
            }
          },
          "INTEGRATION_FAILURE" : {
            "statusCode" : "504",
            "responseTemplates" : {
              "application/json" : "{\n   \"message\": $context.error.messageString\n}"
            }
            "responseParameters" : {
              "gatewayresponse.header.Access-Control-Allow-Origin" : "method.request.header.Origin"
            }
          },
          "WAF_FILTERED" : {
            "statusCode" : "504",
            "responseTemplates" : {
              "application/json" : "{\n   \"message\": $context.error.messageString\n}"
            }
            "responseParameters" : {
              "gatewayresponse.header.Access-Control-Allow-Origin" : "method.request.header.Origin"
            }
          }
        }
        components = {
          securitySchemes = {
            auth_lambda_authorizer_no_caching = {
              type = "apiKey"
              # name                         = "Authorization"
              in                           = "header"
              x-amazon-apigateway-authtype = "custom"
              x-amazon-apigateway-authorizer = {
                type          = "request"
                authorizerUri = "arn:aws:apigateway:${data.aws_region.current.id}:lambda:path/2015-03-31/functions/arn:aws:lambda:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:function:${local.auth_lambda_name}/invocations"
                # identitySource = "method.request.header.Authorization" # just change for trigger
                authorizerResultTtlInSeconds = 0
              }
            }
          }
          "schemas" : {
            "Empty" : {
              "title" : "Empty Schema",
              "type" : "object"
            }
          }
        }
      }
    }
  ]
}
module "jugaad_api_gateway" {
  source                      = "../modules/api_gateway"
  for_each                    = { for idx, api in local.api_gateway_configs : api.identifier => api }
  identifier                  = each.value.identifier
  Environment                 = var.environment
  vendor                      = var.vendor
  project_name                = var.project_name
  service_name                = each.value.service_name
  api_gateway_name            = each.value.api_gateway_name
  api_gateway_description     = each.value.api_gateway_description
  openapi_body                = each.value.openapi_body
  role_prefix                 = each.value.role_prefix
  stage_name                  = each.value.stage_name
  api_stage_variables         = var.api_stage_variables
  xray_tracing_enabled        = each.value.xray_tracing_enabled
  metrics_enabled             = each.value.metrics_enabled
  logging_level               = each.value.logging_level
  cache_data_encrypted        = each.value.cache_data_encrypted
  log_group_name              = each.value.log_group_name
  log_group_retention_in_days = each.value.log_group_retention_in_days
  binary_media_types = each.value.binary_media_types
  api_stages = lookup({ dev  = each.value.dev_api_stages, stg  = each.value.stg_api_stages, beta  = each.value.beta_api_stages, prod = each.value.prod_api_stages  }, var.environment, each.value.dev_api_stages)
}