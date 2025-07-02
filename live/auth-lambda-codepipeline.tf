locals {
  auth_lambda_codebuild_config = [
    {
      identifier                  = "auth-lambda-sonarqube"
      build_compute_type          = "BUILD_GENERAL1_SMALL"
      build_environment_image     = "aws/codebuild/standard:6.0"
      build_environment_type      = "LINUX_CONTAINER"
      image_pull_credentials_type = "CODEBUILD"
      privileged_mode             = "true"

      artifact_type = "CODEPIPELINE"

      source_type        = "CODEPIPELINE"
      buildspec_filename = "sonarqube-buildspec.yaml"

      codebuild_role_policy_arn = ["${module.iam_policy["sonarqube-codebuild"].policy_arn}"]

      vpc_config = [
        {
          vpc_id             = var.vpc_id[var.environment],
          subnets            = var.subnet_ids[var.environment],
          security_group_ids = try([module.auth_lambda_codebuild_sg["auth-lambda-sonarqube"].sg_id],null)
        }
      ]

      environment_variable = [
        {
          name  = "SonarQube_URL",
          value = "http://vb-jugaad-dev-sonarqube-lb-1696985177.ap-northeast-1.elb.amazonaws.com",
          type  = "PLAINTEXT"
        },
        {
          name  = "SonarQube_Access_Token",
          value = "squ_8b9790e9632c3ac7ec330bf6def03d0bed1de4eb",
          type  = "PLAINTEXT"
        },
        {
          name  = "SERVICE_NAME",
          value = "auth-lambda",
          type  = "PLAINTEXT"
        },
        {
          name  = "sonar_project_name",
          value = "vb-jugaad-authorization-lambda",
          type  = "PLAINTEXT"
        }
      ]
    },
    {
      identifier                  = "auth-lambda-app"
      build_compute_type          = "BUILD_GENERAL1_SMALL"
      build_environment_image     = "aws/codebuild/standard:7.0"
      build_environment_type      = "LINUX_CONTAINER"
      image_pull_credentials_type = "CODEBUILD"
      privileged_mode             = "true"

      artifact_type = "CODEPIPELINE"

      source_type        = "CODEPIPELINE"
      buildspec_filename = var.auth_lambda_buildspec_filename

      codebuild_role_policy_arn = ["${module.iam_policy["auth-lambda-codebuild"].policy_arn}"]

      vpc_config = [
        {
          vpc_id             = var.vpc_id[var.environment],
          subnets            = var.subnet_ids[var.environment],
          security_group_ids = [module.auth_lambda_codebuild_sg["auth-lambda-app"].sg_id]
        }
      ]

      environment_variable = [
        {
          name  = "env",
          value = var.environment
          # value = var.environment == "dev" || var.environment == "prod" || var.environment == "beta" ? var.environment : "stage"
          type  = "PLAINTEXT"
        },
        {
          name  = "AWS_DEFAULT_REGION",
          value = "/default/region"
          type  = "PARAMETER_STORE"
        },
        {
          name  = "AWS_ACCOUNT_ID",
          value = "/jugaad/account_id"
          type  = "PARAMETER_STORE"
        },
        # {
        #   name  = "container_name",
        #   value = "vb-jugaad-apply-approve-task-definition-${var.environment}-container",
        #   type  = "PLAINTEXT"
        # },
        # {
        #   name  = "ecr_repo",
        #   value = "vb-jugaad-apply-approve-service-repo-${var.environment}",
        #   type  = "PLAINTEXT"
        # },
        {
          name  = "SERVICE_NAME",
          value = "auth-lambda",
          type  = "PLAINTEXT"
        },
        {
          name  = "project_name",
          value = "auth-lambda",
          type  = "PLAINTEXT"
        },
        {
          name  = "account_id",
          value = data.aws_caller_identity.current.account_id,
          type  = "PLAINTEXT"
        }
      ]
    }
  ]
  auth_lambda_codebuild_configs_map = { for idx, config in local.auth_lambda_codebuild_config : config.identifier => config }
}

# codebuild module

module "auth_lambda_codebuild" {
  # for_each = {
  #   for identifier, config in local.auth_lambda_codebuild_configs_map :
  #   identifier => config if(
  #     (var.environment == "dev" && (identifier == "auth-lambda-sonarqube" || identifier == "auth-lambda-app")) ||
  #     (var.environment != "dev" && identifier == "auth-lambda-app")
  #   )
  # }
  for_each = var.microservice_resources[var.environment] > 0 ? {
    for identifier, config in local.auth_lambda_codebuild_configs_map :
    identifier => config if(
      (var.environment == "dev" && (identifier == "auth-lambda-sonarqube" || identifier == "auth-lambda-app")) ||
      (var.environment != "dev" && identifier == "auth-lambda-app")
    )
  } : {}
  source = "../modules/CodePipeline/codebuild"

  #------------------------------------
  identifier   = each.value.identifier
  Environment  = var.environment
  vendor       = var.vendor
  project_name = var.project_name
  module = "microservices"

  #----------- codebuild_project.tf ----------
  build_compute_type          = each.value.build_compute_type
  build_environment_image     = each.value.build_environment_image
  build_environment_type      = each.value.build_environment_type
  image_pull_credentials_type = each.value.image_pull_credentials_type
  privileged_mode             = each.value.privileged_mode
  environment_variable        = each.value.environment_variable
  artifact_type               = each.value.artifact_type
  source_type                 = each.value.source_type
  buildspec_filename          = each.value.buildspec_filename
  vpc_config                  = each.value.vpc_config

  #---------- codebuild_role.tf ---------------
  codebuild_role_policy_arn = each.value.codebuild_role_policy_arn

  depends_on = [module.auth_lambda_codebuild_sg]

}


# codepipeline variables

locals {
  auth_lambda_pipeline_configs = [{
    identifier = "auth-lambda"
    #------------ artifact_bucket.tf ---------------
    required_artifact_bucket = true

    #------------ codepipeline_role.tf -------------
    pipeline_role_policy_arn = ["arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess", "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/vb-jugaad-pipeline-policy-${lower(var.environment)}"]
    bucket_policy = jsonencode({
      Version = "2012-10-17",
      Statement =[
       {
        Sid       = "RequireHTTPSForAllRequests",
        Effect    = "Deny",
        Principal = "*",
        Action    = "s3:*",
        Resource = [
          "arn:aws:s3:::vb-jugaad-auth-lambda-pipeline-artifact-bucket-${lower(var.environment)}/*",
          "arn:aws:s3:::vb-jugaad-auth-lambda-pipeline-artifact-bucket-${lower(var.environment)}"
        ],
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
       }
      ]
    })
    #------------ codepipeline.tf ------------------
    pipeline_type  = "V1"
    execution_mode = "SUPERSEDED"
    stages = [
      {
        stage_name = "Source"
        actions = [
          {
            action_name      = "Source"
            category         = "Source"
            owner            = "AWS"
            provider         = "CodeStarSourceConnection"
            output_artifacts = ["source_output"]
            configuration = {
              ConnectionArn    = var.connection_arn[var.environment]
              FullRepositoryId = "vebuin/jugaad-authorizer"
              BranchName       = var.branch_name[var.environment]
            }
          }
        ]
      },
      var.environment == "dev" ? {
        stage_name = "Code-Security-and-Quality-tools"
        actions = [
          # {
          #   action_name      = "OWASP"
          #   category         = "Build"
          #   owner            = "AWS"
          #   provider         = "CodeBuild"
          #   input_artifacts  = ["source_output"]
          #   output_artifacts = ["owasp_output"]
          #   configuration = {
          #     ProjectName = module.codebuild["apply-approve-owasp"].codebuild_name
          #   }
          # },
          {
            action_name      = "Sonarqube"
            category         = "Build"
            owner            = "AWS"
            provider         = "CodeBuild"
            input_artifacts  = ["source_output"]
            output_artifacts = ["sonarqube_output"]
            configuration = {
              ProjectName = module.auth_lambda_codebuild["auth-lambda-sonarqube"].codebuild_name
            }
          }
        ]
      } : null,
      {
        stage_name = "Build"
        actions = [
          {
            action_name      = "Build"
            category         = "Build"
            owner            = "AWS"
            provider         = "CodeBuild"
            input_artifacts  = ["source_output"]
            output_artifacts = ["build_output"]
            configuration = {
              ProjectName = module.auth_lambda_codebuild["auth-lambda-app"].codebuild_name
            }
          }
        ]
      }
      #   {
      #     stage_name = "DeployStage"
      #     actions = [
      #       {
      #         action_name     = "Deploy"
      #         category        = "Deploy"
      #         owner           = "AWS"
      #         provider        = "ECS"
      #         input_artifacts = ["build_output"]
      #         configuration = {
      #           ClusterName = "vb-jugaad-microservices-cluster-dev"
      #           ServiceName = "vb-jugaad-apply-approve-service-dev"

      #         }
      #       }
      #     ]
      #   }
    ]
  }]

  auth_lambda_pipeline_configs_map = { for idx, config in local.auth_lambda_pipeline_configs : config.identifier => config }
}

# codepipeline module

module "auth_lambda_pipeline" {
  source   = "../modules/CodePipeline/pipeline"
  # for_each = local.auth_lambda_pipeline_configs_map
  for_each = var.microservice_resources[var.environment] > 0 ? local.auth_lambda_pipeline_configs_map : {}
  identifier   = each.value.identifier
  Environment  = var.environment
  vendor       = var.vendor
  project_name = var.project_name
  module = "microservices"
  #------------- artifact_bucket.tf --------------
  required_artifact_bucket = each.value.required_artifact_bucket
  bucket_policy = each.value.bucket_policy

  #------------- codepipeline_role.tf ------------
  pipeline_role_policy_arn = each.value.pipeline_role_policy_arn
  pipeline_type            = each.value.pipeline_type
  execution_mode           = each.value.execution_mode
  stages                   = [for stage in each.value.stages : stage if stage != null] # Skip null stages
}

locals {
  auth_lambda_sg_configs = [
    # {
    #   identifier              = "apply-approve-owasp"
    #   create_sg_for_codebuild = true
    #   vpc_id                  = var.vpc_id[var.environment]
    #   ingress = [{
    #     port        = 443,
    #     description = "HTTPS traffic from VPC",
    #     protocol    = "tcp",
    #     cidr_blocks = [data.aws_vpc.vpc_cidr.cidr_block]
    #   }]
    #   egress = [{
    #     port        = 0,
    #     description = "anywhere",
    #     protocol    = "-1",
    #     cidr_blocks = ["0.0.0.0/0"]
    #   }]
    # },
    {
      identifier              = "auth-lambda-sonarqube"
      create_sg_for_codebuild = true
      vpc_id                  = var.vpc_id[var.environment]
      ingress = [{
        port        = 443,
        description = "HTTPS traffic from VPC",
        protocol    = "tcp",
        cidr_blocks = [data.aws_vpc.vpc_cidr.cidr_block]
      }]
      egress = [{
        port        = 0,
        description = "anywhere",
        protocol    = "-1",
        cidr_blocks = ["0.0.0.0/0"]
      }]
    },
    {
      identifier              = "auth-lambda-app"
      create_sg_for_codebuild = true
      vpc_id                  = var.vpc_id[var.environment]
      ingress = [{
        port        = 443,
        description = "HTTPS traffic from VPC",
        protocol    = "tcp",
        cidr_blocks = [data.aws_vpc.vpc_cidr.cidr_block]
      }]
      egress = [{
        port        = 0,
        description = "anywhere",
        protocol    = "-1",
        cidr_blocks = ["0.0.0.0/0"]
      }]
    }
  ]
  auth_lambda_sg_configs_map = { for idx, config in local.auth_lambda_sg_configs : config.identifier => config }
}

module "auth_lambda_codebuild_sg" {
  source   = "../modules/CodePipeline/codebuild_sg"
  # for_each = local.auth_lambda_sg_configs_map
  # for_each = var.microservice_resources[var.environment] > 0 ? local.auth_lambda_sg_configs_map : {}
  for_each = var.microservice_resources[var.environment] > 0 ? {
    for identifier, config in local.auth_lambda_sg_configs_map :
    identifier => config if(
      (var.environment == "dev" && (identifier == "auth-lambda-sonarqube" || identifier == "auth-lambda-app")) ||
      (var.environment != "dev" && identifier == "auth-lambda-app")
    )
  } : {}

  identifier   = each.value.identifier
  Environment  = var.environment
  vendor       = var.vendor
  project_name = var.project_name
  module = "microservices"

  #---------- codebuild_sg.tf -----------------
  create_sg_for_codebuild = each.value.create_sg_for_codebuild
  vpc_id                  = each.value.vpc_id
  ingress                 = each.value.ingress
  egress                  = each.value.egress
}