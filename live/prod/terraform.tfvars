environment = "prod"
# buildspec_app_env = 
# "beta" stage
api_stage_variables = {
  allowed_origins = "https://smartflow.vebuin.com,https://www.smartflow.vebuin.com,https://api-smartflow.vebuin.com,https://beta.jugaad.co.jp,https://yosan.smartflow.vebuin.com,https://policy.smartflow.vebuin.com,https://chatbot.smartflow.vebuin.com"
  allowed_realms         = "smartflow,prosign_sso,cocoro_office"
  auth_url               = "https://auth.vebuin.com/auth"
  cache_prefix           = "prod01"
  dbname                 = "smartflow_production_v1"
  forward_url            = "vb-jugaad-microservices-lb-prod-435441065.ap-northeast-1.elb.amazonaws.com"
  issuer                 = "https://auth.vebuin.com/auth/realms/smartflow"
  lambda_authorizer_name = "vb-jugaad-authorization-lambda"
  rails_env = "production"
}
services_scaling_min_count = {
  apply-approve-service     = 12,
  form-details-service      = 12,
  notification-service      = 2,
  pdf-service               = 2,
  report-service            = 12
  # announcement-service      = 0,
  copilot-policy-service    = 2,
  copilot-policy-rag-service = 2,
  yosan-management-service  = 2,
  yosan-reporting-service   = 2
}

services_scaling_max_count = {
  apply-approve-service     = 20,
  form-details-service      = 20,
  notification-service      = 20,
  pdf-service               = 20,
  report-service            = 20
  # announcement-service      = 0,
  copilot-policy-service    = 20,
  copilot-policy-rag-service = 20,
  yosan-management-service  = 20,
  yosan-reporting-service   = 20
}

public_subnet_ids = ["subnet-055b509256db7edaa", "subnet-0010da4239da3fcab"]
microservices_buildspec_filename = "buildspec-stg.yaml"
auth_lambda_buildspec_filename = "buildspec.yml"
yosan_be_buildspec_filename = "backend/buildspec-stg.yaml"
yosan_fe_buildspec_filename = "buildspec-stg.yaml"
copilot_be_buildspec_filename = "buildspec-stg.yaml"
copilot_fe_buildspec_filename = "buildspec-stg.yaml"
copilot_rag_branch_name = "main"

apply_approve_secret_key_base = "arn:aws:ssm:ap-northeast-1:194107306707:parameter/vb_jugaad_apply_approve_secret_key_base_prod"
form_details_secret_key_base = "arn:aws:ssm:ap-northeast-1:194107306707:parameter/vb_jugaad_form_details_secret_key_base_prod"
notification_secret_key_base = "arn:aws:ssm:ap-northeast-1:194107306707:parameter/vb_jugaad_notification_secret_key_base_prod"
report_secret_key_base = "arn:aws:ssm:ap-northeast-1:194107306707:parameter/vb_jugaad_report_secret_key_base_prod"

log_group_retention_api_gateway = 90
log_group_retention_ecs_service = 90
log_group_retention_ecs_task = 90

image_preserve_count = 10