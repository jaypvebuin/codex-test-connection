environment = "beta"
# buildspec_app_env = 
# "beta" stage
api_stage_variables = {
  allowed_origins = "https://beta.jugaad.co.jp,https://smartflow.vebuin.com"
  allowed_realms         = "smartflow,prosign_sso,cocoro_office,smartflow_dev,dev_prosign_sso,cocoro_staging"
  auth_url               = "https://auth-beta.jugaad.co.jp/auth"
  cache_prefix           = "beta"
  dbname                 = "smartflow_production_v1"
  forward_url            = "vb-jugaad-microservices-lb-beta-313228567.ap-northeast-1.elb.amazonaws.com"
  issuer                 = "https://auth-beta.jugaad.co.jp/auth/realms/smartflow"
  lambda_authorizer_name = "vb-jugaad-authorization-lambda-beta"
  rails_env = "production"
}

# "mock" stage
mock_stage_variables = {
  allowed_origins = "https://beta.jugaad.co.jp"
  allowed_realms         = "smartflow,prosign_sso,cocoro_office,smartflow_dev,dev_prosign_sso,cocoro_staging"
  auth_url               = "https://auth-beta.jugaad.co.jp/auth"
  cache_prefix           = "beta"
  dbname                 = "smartflow_production_v1"
  forward_url            = "vb-jugaad-microservices-lb-beta-313228567.ap-northeast-1.elb.amazonaws.com/mock"
  issuer                 = "https://auth-beta.jugaad.co.jp/auth/realms/smartflow"
  lambda_authorizer_name = "vb-jugaad-authorization-lambda-beta"
  rails_env = "production"
}

# "test" stage
test_stage_variables = {
  allowed_origins = "https://beta.jugaad.co.jp"
  allowed_realms         = "smartflow,prosign_sso,cocoro_office,smartflow_dev,dev_prosign_sso,cocoro_staging"
  auth_url               = "https://auth-beta.jugaad.co.jp/auth"
  cache_prefix           = "beta"
  dbname                 = "smartflow_production_v1"
  forward_url            = "vb-jugaad-microservices-lb-beta-313228567.ap-northeast-1.elb.amazonaws.com/smartflow"
  issuer                 = "https://auth-beta.jugaad.co.jp/auth/realms/smartflow"
  lambda_authorizer_name = "vb-jugaad-authorization-lambda-beta"
  rails_env = "production"
}
testing_stage_variables = {
  allowed_realms         = "smartflow_security,dev_prosign_sso,cocoro_staging"
  auth_url               = "https://dev.stage-smartflow.com/auth"
  cache_prefix           = "testing100"
  dbname                 = "development_security"
  forward_url            = "vb-jugaad-authorizer-test-lb-1209756894.ap-northeast-1.elb.amazonaws.com/mock"
  issuer                 = "https://dev.stage-smartflow.com/auth/realms/smartflow_security"
  lambda_authorizer_name = "TestAuthLambdaAuthorizer2"
  rails_env = "production"
}
workflow_stage_variables = {
  allowed_realms         = "smartflow_dev,dev_prosign_sso,cocoro_staging,smartflow_stage_wf"
  auth_url               = "https://dev.stage-smartflow.com/auth"
  cache_prefix           = "workflow3"
  dbname                 = "apr_30_stg_bkp"
  forward_url            = "vb-jugaad-microservice-ecs-dev-1584150580.ap-northeast-1.elb.amazonaws.com"
  issuer                 = "https://dev.stage-smartflow.com/auth/realms/smartflow_dev"
  lambda_authorizer_name = "TestAuthLambdaAuthorizer2"
  rails_env = "production"
}
public_subnet_ids = ["subnet-055b509256db7edaa", "subnet-0010da4239da3fcab"]
microservices_buildspec_filename = "buildspec-stg.yaml"
auth_lambda_buildspec_filename = "buildspec.yml"
apply_approve_secret_key_base = "arn:aws:ssm:ap-northeast-1:194107306707:parameter/apply_approve_secret_key_base_beta"
form_details_secret_key_base = "arn:aws:ssm:ap-northeast-1:194107306707:parameter/form_details_secret_key_base_beta"
notification_secret_key_base = "arn:aws:ssm:ap-northeast-1:194107306707:parameter/notification_secret_key_base_beta"
report_secret_key_base = "arn:aws:ssm:ap-northeast-1:194107306707:parameter/report_secret_key_base_beta"

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
  # announcement-service      = 0,
  # copilot-policy-service    = 0,
  # copilot-policy-rag-service = 0,
  # yosan-management-service  = 0,
  # yosan-reporting-service   = 0
}

services_scaling_max_count = {
  apply-approve-service     = 20,
  form-details-service      = 20,
  notification-service      = 20,
  pdf-service               = 20,
  report-service            = 20
  # announcement-service      = 0,
  # copilot-policy-service    = 0,
  # copilot-policy-rag-service = 0,
  # yosan-management-service  = 0,
  # yosan-reporting-service   = 0
}

log_group_retention_api_gateway = 90
log_group_retention_ecs_service = 90
log_group_retention_ecs_task = 90

image_preserve_count = 10

