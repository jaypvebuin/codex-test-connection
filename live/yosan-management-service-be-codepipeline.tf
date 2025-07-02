locals {
  yosan_management_be_codebuild_config = [
    # {
    #   identifier                  = "form-details-owasp"
    #   build_compute_type          = "BUILD_GENERAL1_SMALL"
    #   build_environment_image     = "aws/codebuild/standard:6.0"
    #   build_environment_type      = "LINUX_CONTAINER"
    #   image_pull_credentials_type = "CODEBUILD"
    #   privileged_mode             = "true"

    #   artifact_type = "CODEPIPELINE"

    #   source_type        = "CODEPIPELINE"
    #   buildspec_filename = "owasp-buildspec.yaml"

    #   codebuild_role_policy_arn = ["arn:aws:iam::aws:policy/AdministratorAccess"]

    #   vpc_config = [
    #     {
    #       vpc_id             = var.vpc_id[var.environment],
    #       subnets            = var.subnet_ids[var.environment],
    #       security_group_ids = [module.form-details-codebuild_sg["form-details-owasp"].sg_id]
    #     }
    #   ]

    #   environment_variable = [
    #     {
    #       name  = "SERVICE_NAME",
    #       value = "form-details-service",
    #       type  = "PLAINTEXT"
    #     },
    #     {
    #       name  = "project_name",
    #       value = "vb-jugaad-form-details-service",
    #       type  = "PLAINTEXT"
    #     }
    #   ]
    # },
    {
      identifier                  = "yosan-management-be-sonarqube"
      build_compute_type          = "BUILD_GENERAL1_SMALL"
      build_environment_image     = "aws/codebuild/standard:6.0"
      build_environment_type      = "LINUX_CONTAINER"
      image_pull_credentials_type = "CODEBUILD"
      privileged_mode             = "true"

      artifact_type = "CODEPIPELINE"

      source_type        = "CODEPIPELINE"
      buildspec_filename = "backend/sonarqube-buildspec.yaml"

      codebuild_role_policy_arn = ["${module.iam_policy["sonarqube-codebuild"].policy_arn}"]

      vpc_config = [
        {
          vpc_id             = var.vpc_id[var.environment],
          subnets            = var.subnet_ids[var.environment],
          security_group_ids = try([module.yosan-management-be-codebuild_sg["yosan-management-be-sonarqube"].sg_id], null)
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
          value = "yosan-management-be-service",
          type  = "PLAINTEXT"
        },
        {
          name  = "sonar_project_name",
          value = "vb-jugaad-yosan-management-be-service",
          type  = "PLAINTEXT"
        }
      ]
    },
    {
      identifier                  = "yosan-management-be-app"
      build_compute_type          = "BUILD_GENERAL1_SMALL"
      build_environment_image     = "aws/codebuild/standard:6.0"
      build_environment_type      = "LINUX_CONTAINER"
      image_pull_credentials_type = "CODEBUILD"
      privileged_mode             = "true"

      artifact_type = "CODEPIPELINE"

      source_type        = "CODEPIPELINE"
      buildspec_filename = var.yosan_be_buildspec_filename

      codebuild_role_policy_arn = ["${module.iam_policy["yosan-management-be-codebuild"].policy_arn}"]

      vpc_config = [
        {
          vpc_id             = var.vpc_id[var.environment],
          subnets            = var.subnet_ids[var.environment],
          security_group_ids = try([module.yosan-management-be-codebuild_sg["yosan-management-be-app"].sg_id], [])
        }
      ]

      environment_variable = [
        {
          name  = "env",
          value = var.environment
          type  = "PLAINTEXT"
        },
        {
          name  = "container_name",
          value = "vb-jugaad-yosan-management-be-task-definition-${var.environment}-container",
          type  = "PLAINTEXT"
        },
        {
          name  = "ecr_repo",
          value = "vb-jugaad-yosan-management-be-service-repo-${var.environment}",
          type  = "PLAINTEXT"
        },
        {
          name  = "SERVICE_NAME",
          value = "yosan-manage-be-service",
          type  = "PLAINTEXT"
        },
        {
          name  = "sonar_project_name",
          value = "vb-jugaad-yosan-management-be-service",
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
  yosan_management_be_codebuild_configs_map = { for idx, config in local.yosan_management_be_codebuild_config : config.identifier => config }
}

# codebuild module

module "yosan-management-be-codebuild" {
  # for_each = {
  #   for identifier, config in local.yosan_management_be_codebuild_configs_map :
  #   identifier => config if(
  #     (var.environment == "dev" && (identifier == "yosan-management-be-sonarqube" || identifier == "yosan-management-be-app")) ||
  #     (var.environment != "dev" && identifier == "yosan-management-be-app")
  #   )
  # }
  for_each = var.yosan_resources[var.environment] > 0 ? {
    for identifier, config in local.yosan_management_be_codebuild_configs_map :
    identifier => config if(
      (var.environment == "dev" && (identifier == "yosan-management-be-sonarqube" || identifier == "yosan-management-be-app")) ||
      (var.environment != "dev" && identifier == "yosan-management-be-app")
    )
  } : {}
  source = "../modules/CodePipeline/codebuild"

  #------------------------------------
  identifier   = each.value.identifier
  Environment  = var.environment
  vendor       = var.vendor
  project_name = var.project_name
  module       = "yosan"
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

  depends_on = [module.yosan-management-be-codebuild_sg]

}


# codepipeline variables

locals {
  yosan_management_be_pipeline_configs = [{
    identifier = "yosan-manage-be-service"
    #------------ artifact_bucket.tf ---------------
    required_artifact_bucket = true

    #------------ codepipeline_role.tf -------------
    pipeline_role_policy_arn = ["arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess", "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/vb-jugaad-pipeline-policy-${lower(var.environment)}"]

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
              FullRepositoryId = "vebuin/jugaad-yosan-be"
              BranchName       = var.yosan_branch_name[var.environment]
              # BranchName = "rk-security-test" # this is just for testing , uncomment it after its done
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
            #     ProjectName = module.form-details-codebuild["form-details-owasp"].codebuild_name
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
                ProjectName = module.yosan-management-be-codebuild["yosan-management-be-sonarqube"].codebuild_name
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
              ProjectName = try(module.yosan-management-be-codebuild["yosan-management-be-app"].codebuild_name, null)
            }
          }
        ]
      },
      {
        stage_name = "DeployStage"
        actions = [
          {
            action_name     = "Deploy"
            category        = "Deploy"
            owner           = "AWS"
            provider        = "ECS"
            input_artifacts = ["build_output"]
            configuration = {
              ClusterName = "vb-jugaad-yosan-cluster-${lower(var.environment)}"
              ServiceName = "vb-jugaad-yosan-management-be-service-${lower(var.environment)}"

            }
          }
        ]
      }
    ]
  }]

  yosan_management_be_pipeline_configs_map = { for idx, config in local.yosan_management_be_pipeline_configs : config.identifier => config }
}

# codepipeline module

module "yosan-management-be-pipeline" {
  source = "../modules/CodePipeline/pipeline"
  # for_each = local.yosan_management_be_pipeline_configs_map
  for_each = var.yosan_resources[var.environment] > 0 ? local.yosan_management_be_pipeline_configs_map : {}

  identifier   = each.value.identifier
  Environment  = var.environment
  vendor       = var.vendor
  project_name = var.project_name
  module       = "yosan"
  #------------- artifact_bucket.tf --------------
  required_artifact_bucket = each.value.required_artifact_bucket

  #------------- codepipeline_role.tf ------------
  pipeline_role_policy_arn = each.value.pipeline_role_policy_arn
  pipeline_type            = each.value.pipeline_type
  execution_mode           = each.value.execution_mode
  stages                   = [for stage in each.value.stages : stage if stage != null] # Skip null stages
}

locals {
  yosan_management_be_sg_configs = [
    {
      identifier              = "yosan-management-be-owasp"
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
      identifier              = "yosan-management-be-sonarqube"
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
      identifier              = "yosan-management-be-app"
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
  yosan_management_be_sg_configs_map = { for idx, config in local.yosan_management_be_sg_configs : config.identifier => config }
}

module "yosan-management-be-codebuild_sg" {
  source = "../modules/CodePipeline/codebuild_sg"
  # for_each = local.yosan_management_be_sg_configs_map
  for_each = var.yosan_resources[var.environment] > 0 ? {
    for identifier, config in local.yosan_management_be_sg_configs_map :
    identifier => config if(
      (var.environment == "dev" && (identifier == "yosan-management-be-sonarqube" || identifier == "yosan-management-be-owasp" || identifier == "yosan-management-be-app")) ||
      (var.environment != "dev" && identifier == "yosan-management-be-app")
    )
  } : {}

  identifier   = each.value.identifier
  Environment  = var.environment
  vendor       = var.vendor
  project_name = var.project_name
  module       = "yosan"

  #---------- codebuild_sg.tf -----------------
  create_sg_for_codebuild = each.value.create_sg_for_codebuild
  vpc_id                  = each.value.vpc_id
  ingress                 = each.value.ingress
  egress                  = each.value.egress
}