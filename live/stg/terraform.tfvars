environment = "stg"
# buildspec_app_env = 
api_stage_variables = {
  allowed_origins = "https://stage.jugaad.co.jp,https://main.stage-smartflow.com,https://policy.services.stage-smartflow.com,https://chatbot.services.stage-smartflow.com,https://yosan.services.stage-smartflow.com"
  allowed_realms         = "smartflow_dev,dev_prosign_sso,cocoro_staging,smartflow_security"
  auth_url               = "https://auth-stage.jugaad.co.jp/auth"
  cache_prefix           = "dev02"
  dbname                 = "smartflow_staging"
  forward_url            = "vb-jugaad-microservices-lb-stg-587860001.ap-northeast-1.elb.amazonaws.com"
  issuer                 = "https://auth-stage.jugaad.co.jp/auth/realms/smartflow_dev"
  lambda_authorizer_name = "vb-jugaad-authorization-lambda"
  rails_env = "production"
}
mock_stage_variables = {
  allowed_origins = "https://stage.jugaad.co.jp"
  allowed_realms         = "smartflow_dev,dev_prosign_sso,cocoro_staging,smartflow_security"
  auth_url               = "https://auth-stage.jugaad.co.jp/auth"
  cache_prefix           = "mock"
  dbname                 = "smartflow_staging"
  forward_url            = "vb-jugaad-microservices-lb-stg-587860001.ap-northeast-1.elb.amazonaws.com/mock"
  issuer                 = "https://auth-stage.jugaad.co.jp/auth/realms/smartflow_dev"
  lambda_authorizer_name = "vb-jugaad-authorization-lambda"
  rails_env = "production"
}
test_stage_variables = {
  allowed_origins = "https://stage.jugaad.co.jp"
  allowed_realms         = "smartflow_dev,dev_prosign_sso,cocoro_staging,smartflow_security"
  auth_url               = "https://auth-stage.jugaad.co.jp/auth"
  cache_prefix           = "test"
  dbname                 = "smartflow_security"
  forward_url            = "vb-jugaad-microservices-lb-stg-587860001.ap-northeast-1.elb.amazonaws.com"
  issuer                 = "https://auth-stage.jugaad.co.jp/auth/realms/smartflow_security"
  lambda_authorizer_name = "vb-jugaad-authorization-lambda"
  rails_env = "production"
}
testing_stage_variables = {
  allowed_realms         = "smartflow_security,dev_prosign_sso,cocoro_staging"
  auth_url               = "https://dev.stage-smartflow.com/auth"
  cache_prefix           = "testing100"
  dbname                 = "development_security"
  forward_url            = "vb-jugaad-microservices-lb-stg-587860001.ap-northeast-1.elb.amazonaws.com"
  issuer                 = "https://dev.stage-smartflow.com/auth/realms/smartflow_security"
  lambda_authorizer_name = "vb-jugaad-authorization-lambda"
  rails_env = "production"
}
workflow_stage_variables = {
  allowed_realms         = "smartflow_dev,dev_prosign_sso,cocoro_staging,smartflow_stage_wf"
  auth_url               = "https://dev.stage-smartflow.com/auth"
  cache_prefix           = "workflow3"
  dbname                 = "apr_30_stg_bkp"
  forward_url            = "vb-jugaad-microservices-lb-stg-587860001.ap-northeast-1.elb.amazonaws.com"
  issuer                 = "https://dev.stage-smartflow.com/auth/realms/smartflow_dev"
  lambda_authorizer_name = "vb-jugaad-authorization-lambda"
  rails_env = "production"
}
public_subnet_ids = ["subnet-088191a4acf72ac46", "subnet-0b8e4b5b5422f4433", "subnet-0fb825940e817a882"]
apply_approve_secret_key_base = "arn:aws:ssm:ap-northeast-1:944551270832:parameter/apply_approve_secret_key_base_betastage"
form_details_secret_key_base = "arn:aws:ssm:ap-northeast-1:944551270832:parameter/form_details_secret_key_base_betastage"
notification_secret_key_base = "arn:aws:ssm:ap-northeast-1:944551270832:parameter/notification_secret_key_base_betastage"
report_secret_key_base = "arn:aws:ssm:ap-northeast-1:944551270832:parameter/report_secret_key_base_betastage"
microservices_buildspec_filename = "buildspec-stg.yaml"
yosan_be_buildspec_filename = "backend/buildspec-stg.yaml"
yosan_fe_buildspec_filename = "buildspec-stg.yaml"
copilot_be_buildspec_filename = "buildspec-stg.yaml"
copilot_fe_buildspec_filename = "buildspec-stg.yaml"
auth_lambda_buildspec_filename = "buildspec.yml"
copilot_rag_branch_name = "Stagging"
# ecs_services_enabled = {
#   apply-approve-service = 1,
#   form-details-service  = 1,
#   notification-service = 1,
#   pdf-service = 1,
#   report-service = 1,
#   announcement-service = 0,
#   copilot-policy-service = 0,
#   copilot-policy-rag-service = 0,
#   yosan-management-service = 0,
#   yosan-reporting-service = 0
# }
services_scaling_min_count = {
  apply-approve-service     = 1,
  form-details-service      = 1,
  notification-service      = 1,
  pdf-service               = 1,
  report-service            = 1
  announcement-service      = 1,
  copilot-policy-service    = 1,
  copilot-policy-rag-service = 1,
  yosan-management-service  = 1,
  yosan-reporting-service   = 1
}

services_scaling_max_count = {
  apply-approve-service     = 10,
  form-details-service      = 10,
  notification-service      = 10,
  pdf-service               = 10,
  report-service            = 10
  announcement-service      = 10,
  copilot-policy-service    = 10,
  copilot-policy-rag-service = 10,
  yosan-management-service  = 10,
  yosan-reporting-service   = 10
}

log_group_retention_api_gateway = 60
log_group_retention_ecs_service = 60
log_group_retention_ecs_task = 60

image_preserve_count = 5