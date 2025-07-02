environment = "dev"
# buildspec_app_env = 
api_stage_variables = {
  allowed_realms         = "smartflow_dev,smartflow_stage_wf,dev_prosign_sso,cocoro_staging"
  auth_url               = "https://dev.stage-smartflow.com/auth"
  cache_prefix           = "dev01"
  dbname                 = "apr_30_stg_bkp"
  forward_url            = "vb-jugaad-microservices-lb-dev-791552391.ap-northeast-1.elb.amazonaws.com"
  issuer                 = "https://dev.stage-smartflow.com/auth/realms/smartflow_dev"
  lambda_authorizer_name = "vb-jugaad-authorization-lambda"
  rails_env = "production"
}
mock_stage_variables = {
  allowed_realms         = "smartflow_dev,smartflow_stage_wf,dev_prosign_sso,cocoro_staging"
  auth_url               = "https://dev.stage-smartflow.com/auth"
  cache_prefix           = "mock01"
  dbname                 = "apr_30_stg_bkp"
  forward_url            = "vb-jugaad-microservices-lb-dev-791552391.ap-northeast-1.elb.amazonaws.com/mock"
  issuer                 = "https://dev.stage-smartflow.com/auth/realms/smartflow_dev"
  lambda_authorizer_name = "TestAuthLambdaAuthorizer2"
  rails_env              = "production"
}
test_stage_variables = {
  allowed_origins = "https://ai-bi-dev.stage-smartflow.com,https://workflow-dev.stage-smartflow.com,https://policy.services-dev.stage-smartflow.com,https://yosan.services-dev.stage-smartflow.com,https://chatbot.services-dev.stage-smartflow.com"
  allowed_realms         = "smartflow_dev,smartflow_stage_wf,dev_prosign_sso,cocoro_staging"
  auth_url               = "https://dev.stage-smartflow.com/auth"
  cache_prefix           = "9994"
  dbname                 = "may_20_stg_bkp"
  forward_url            = "vb-jugaad-microservices-lb-dev-791552391.ap-northeast-1.elb.amazonaws.com"
  issuer                 = "https://dev.stage-smartflow.com/auth/realms/smartflow_dev"
  lambda_authorizer_name = "vb-jugaad-authorization-lambda"
  rails_env              = "production"
}
testing_stage_variables = {
  allowed_realms         = "smartflow_security,dev_prosign_sso,cocoro_staging"
  auth_url               = "https://dev.stage-smartflow.com/auth"
  cache_prefix           = "testing100"
  dbname                 = "development_security"
  forward_url            = "vb-jugaad-microservices-lb-dev-791552391.ap-northeast-1.elb.amazonaws.com"
  issuer                 = "https://dev.stage-smartflow.com/auth/realms/smartflow_security"
  lambda_authorizer_name = "vb-jugaad-authorization-lambda"
  rails_env = "production"
}
workflow_stage_variables = {
  allowed_origins = "https://ai-bi-dev.stage-smartflow.com,https://workflow-dev.stage-smartflow.com"
  allowed_realms         = "smartflow_dev,smartflow_stage_wf,dev_prosign_sso,cocoro_staging"
  auth_url               = "https://dev.stage-smartflow.com/auth"
  cache_prefix           = "workflow3"
  dbname                 = "may_20_stg_bkp"
  forward_url            = "vb-jugaad-microservices-lb-dev-791552391.ap-northeast-1.elb.amazonaws.com"
  issuer                 = "https://dev.stage-smartflow.com/auth/realms/smartflow_dev"
  lambda_authorizer_name = "vb-jugaad-authorization-lambdaa"
  rails_env = "production"
}
public_subnet_ids = ["subnet-0987b437a31e3bc20", "subnet-045fc53e049be32eb", "subnet-0ff282dcc1ffc7847"]
microservices_buildspec_filename = "buildspec.yaml"
yosan_be_buildspec_filename = "backend/buildspec.yaml"
yosan_fe_buildspec_filename = "buildspec.yaml"
copilot_be_buildspec_filename = "buildspec.yaml"
copilot_fe_buildspec_filename = "buildspec.yaml"
auth_lambda_buildspec_filename = "buildspec.yml"
copilot_rag_branch_name = "Development"
# ecs_services_enabled = {
#   apply-approve-service = 1,
#   form-details-service  = 1,
#   notification-service = 1,
#   pdf-service = 1,
#   report-service = 1,
#   announcement-service = 1,
#   copilot-policy-service = 1,
#   copilot-policy-rag-service = 1,
#   yosan-management-service = 1,
#   yosan-reporting-service = 1
# }

services_scaling_min_count = {
  apply-approve-service     = 1,
  form-details-service      = 1,
  notification-service      = 1,
  pdf-service               = 1,
  report-service            = 1
  # announcement-service      = 0,
  # copilot-policy-service    = 0,
  # copilot-policy-rag-service = 0,
  yosan-management-service  = 1,
  # yosan-reporting-service   = 0
}

services_scaling_max_count = {
  apply-approve-service     = 5,
  form-details-service      = 5,
  notification-service      = 5,
  pdf-service               = 5,
  report-service            = 5
  # announcement-service      = 0,
  # copilot-policy-service    = 0,
  # copilot-policy-rag-service = 0,
  yosan-management-service  = 5,
  # yosan-reporting-service   = 0
}

log_group_retention_api_gateway = 30
log_group_retention_ecs_service = 30
log_group_retention_ecs_task = 30

image_preserve_count = 5