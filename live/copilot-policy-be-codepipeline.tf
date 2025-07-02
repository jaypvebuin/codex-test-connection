# There are two separate sub-modules for 'codepipeline' and 'codebuild'. So, in live folder/file it will be created and referenced separately.
# For creating pipeline, codebuild projects should be created first so that they can be referenced in the pipeline stages.
# Examples of vpc_config and environment variables in codebuild project are given in the second object of codebuild project.
# For creating stages in pipeline, there is one dynamic list(object), where each object in the list will represent the stages. mention the stages in order, in which the pipeline needs to be created.
# All the arguments inside the stage object, should be handled from your side, according to the different stages.
# The variables environment | project_name | vendor are being passed through variables (i.e default value or tfvars) but if you want separate value to be passed for each object, then change it to each.value.{name_of_variable} 

locals {
  cp_policy_codebuild_config = [
    # {
    #   identifier                  = "cp-policy-owasp"
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
    #       security_group_ids = [module.cp-policy-codebuild_sg["cp-policy-owasp"].sg_id]
    #     }
    #   ]

    #   environment_variable = [
    #     {
    #       name  = "SERVICE_NAME",
    #       value = "cp-policy-service",
    #       type  = "PLAINTEXT"
    #     },
    #     {
    #       name  = "project_name",
    #       value = "vb-jugaad-cp-policy-service",
    #       type  = "PLAINTEXT"
    #     }
    #   ]
    # },
    {
      identifier                  = "cp-policy-sonarqube"
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
          security_group_ids = try([module.cp-policy-codebuild_sg["cp-policy-sonarqube"].sg_id],[])
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
          value = "cp-policy-service",
          type  = "PLAINTEXT"
        },
        {
          name  = "sonar_project_name",
          value = "vb-jugaad-copilot-policy-service-be",
          type  = "PLAINTEXT"
        }
      ]
    },
    {
      identifier                  = "cp-policy-app"
      build_compute_type          = "BUILD_GENERAL1_SMALL"
      build_environment_image     = "aws/codebuild/standard:6.0"
      build_environment_type      = "LINUX_CONTAINER"
      image_pull_credentials_type = "CODEBUILD"
      privileged_mode             = "true"

      artifact_type = "CODEPIPELINE"

      source_type        = "CODEPIPELINE"
      buildspec_filename = var.copilot_be_buildspec_filename

      codebuild_role_policy_arn = ["${module.iam_policy["cp-policy-be-codebuild"].policy_arn}"]

      vpc_config = [
        {
          vpc_id             = var.vpc_id[var.environment],
          subnets            = var.subnet_ids[var.environment],
          security_group_ids = try([module.cp-policy-codebuild_sg["cp-policy-app"].sg_id],[])
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
          value = "vb-jugaad-cp-policy-task-definition-${var.environment}-container",
          type  = "PLAINTEXT"
        },
        {
          name  = "ecr_repo",
          value = "vb-jugaad-cp-policy-service-repo-${var.environment}",
          type  = "PLAINTEXT"
        },
        {
          name  = "SERVICE_NAME",
          value = "cp-policy-service",
          type  = "PLAINTEXT"
        },
        {
          name  = "sonar_project_name",
          value = "vb-jugaad-copilot-policy-service-be",
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
  cp_policy_codebuild_configs_map = { for idx, config in local.cp_policy_codebuild_config : config.identifier => config }
}

# codebuild module

module "cp-policy-codebuild" {
  # for_each = {
  #   for identifier, config in local.cp_policy_codebuild_configs_map :
  #   identifier => config if(
  #     (var.environment == "dev" && (identifier == "cp-policy-sonarqube" || identifier == "cp-policy-app")) ||
  #     (var.environment != "dev" && identifier == "cp-policy-app")
  #   )
  # }
  for_each = var.copilot_resources[var.environment] > 0 ? {
    for identifier, config in local.cp_policy_codebuild_configs_map :
    identifier => config if(
      (var.environment == "dev" && (identifier == "cp-policy-sonarqube" || identifier == "cp-policy-app")) ||
      (var.environment != "dev" && identifier == "cp-policy-app")
    )
  } : {}
  source = "../modules/CodePipeline/codebuild"

  #------------------------------------
  identifier   = each.value.identifier
  Environment  = var.environment
  vendor       = var.vendor
  project_name = var.project_name
  module = "copilot"

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

  depends_on = [module.cp-policy-codebuild_sg]

}


# codepipeline variables

locals {
  cp_policy_pipeline_configs = [{
    identifier = "cp-policy-service"
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
              FullRepositoryId = "vebuin/jugaad-policyservice-be"
              BranchName       = var.branch_name[var.environment]
              # BranchName = "feature/adding-buildspec-file"
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
          #     ProjectName = module.cp-policy-codebuild["cp-policy-owasp"].codebuild_name
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
              ProjectName = module.cp-policy-codebuild["cp-policy-sonarqube"].codebuild_name
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
              ProjectName = try(module.cp-policy-codebuild["cp-policy-app"].codebuild_name,null)
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
              ClusterName = "vb-jugaad-copilot-cluster-${lower(var.environment)}"
              ServiceName = "vb-jugaad-copilot-policy-service-${lower(var.environment)}"

            }
          }
        ]
      }
    ]
  }]

  cp_policy_pipeline_configs_map = { for idx, config in local.cp_policy_pipeline_configs : config.identifier => config }
}

# codepipeline module

module "cp-policy-pipeline" {
  source   = "../modules/CodePipeline/pipeline"
  # for_each = local.cp_policy_pipeline_configs_map
  for_each = var.copilot_resources[var.environment] > 0 ? local.cp_policy_pipeline_configs_map : {}
  identifier   = each.value.identifier
  Environment  = var.environment
  vendor       = var.vendor
  project_name = var.project_name
  module = "copilot"
  #------------- artifact_bucket.tf --------------
  required_artifact_bucket = each.value.required_artifact_bucket

  #------------- codepipeline_role.tf ------------
  pipeline_role_policy_arn = each.value.pipeline_role_policy_arn
  pipeline_type            = each.value.pipeline_type
  execution_mode           = each.value.execution_mode
  stages                   = [for stage in each.value.stages : stage if stage != null] # Skip null stages
}

locals {
  cp_policy_sg_configs = [
    {
      identifier              = "cp-policy-owasp"
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
      identifier              = "cp-policy-sonarqube"
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
      identifier              = "cp-policy-app"
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
  cp_policy_sg_configs_map = { for idx, config in local.cp_policy_sg_configs : config.identifier => config }
}

module "cp-policy-codebuild_sg" {
  source   = "../modules/CodePipeline/codebuild_sg"
  # for_each = local.cp_policy_sg_configs_map
  # for_each = var.copilot_resources[var.environment] > 0 ? local.cp_policy_sg_configs_map : {}
  for_each = var.copilot_resources[var.environment] > 0 ? {
    for identifier, config in local.cp_policy_sg_configs_map :
    identifier => config if(
      (var.environment == "dev" && (identifier == "cp-policy-sonarqube" || identifier == "cp-policy-app")) ||
      (var.environment != "dev" && identifier == "cp-policy-app")
    )
  } : {}

  identifier   = each.value.identifier
  Environment  = var.environment
  vendor       = var.vendor
  project_name = var.project_name
  module = "copilot"

  #---------- codebuild_sg.tf -----------------
  create_sg_for_codebuild = each.value.create_sg_for_codebuild
  vpc_id                  = each.value.vpc_id
  ingress                 = each.value.ingress
  egress                  = each.value.egress
}
