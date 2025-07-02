# variable "project_name" {
#   type    = string
#   default = ""
# }

# variable "Environment" {
#   type    = string
#   default = ""
# }

variable "maintainer" {
  type    = string
  default = ""
}

variable "stage" {
  description = "CICD stage configuration"
  type        = any
  default     = [{}]
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "sns_arn" {
  type        = string
  default     = ""
  description = "sns arn for sending notifications"
}

variable "service_name" {
  type    = string
  default = ""
}

variable "build_timeout" {
  type    = string
  default = "60"
}

variable "buildspec_app" {
  type    = string
  default = "buildspec.yaml"
}

variable "buildspec_sonar" {
  type    = string
  default = "buildspec.yaml"
}

variable "buildspec_zap" {
  type    = string
  default = "buildspec.yaml"
}

variable "buildspec_dependency_check" {
  type    = string
  default = "buildspec.yaml"
}

variable "vpc_id" {
  type    = string
  default = ""
}

variable "sonar_environment_variable" {
  type    = any
  default = [{}]
}

variable "zap_environment_variable" {
  type    = any
  default = [{}]
}

variable "vpc_config" {
  type    = any
  default = [{}]
}

variable "codebuild_ingress" {
  type    = any
  default = [{}]
}

variable "codebuild_egress" {
  type    = any
  default = [{}]
}

variable "connection_arn" {
  type    = string
  default = ""
}

variable "repository" {
  type    = string
  default = ""
}

variable "branch_name" {
  type    = string
  default = ""
}

variable "cluster_name" {
  type    = string
  default = ""
}

variable "codepipeline_role" {
  type    = string
  default = ""
}

variable "codebuild_role" {
  type    = string
  default = ""
}

# Codepipeline conditional vars
variable "required_sast" {
  type    = bool
  default = false
}

variable "required_dast" {
  type    = bool
  default = false
}

variable "required_build" {
  type    = bool
  default = false
}

variable "required_deploy" {
  type    = bool
  default = false
}

variable "required_cicd" {
  type    = bool
  default = false
}

#--------common variables----------

variable "project_name" {
  type    = string
  default = "project"
}

variable "Environment" {
  type    = string
  default = "test"
}

variable "vendor" {
  type    = string
  default = "vb"
}

variable "identifier" {
  type    = string
  default = "central"
}

variable "module" {
  type    = string
  default = ""
}

variable "required_artifact_bucket" {
  type    = bool
  default = false
}

variable "pipeline_role_policy_arn" {
  type    = list(any)
  default = []
}

variable "required_source_stage" {
  type    = bool
  default = false
}

variable "required_build_stage" {
  type    = bool
  default = false
}

variable "required_deploy_stage" {
  type    = bool
  default = false
}

# variable "required_codestar_connection" {
#   type = bool
#   default = false
# }

variable "pipeline_type" {
  type    = string
  default = "V1"
}

variable "execution_mode" {
  type    = string
  default = "SUPERSEDED"
}

# # Unified stages object containing Source, Build, and Deploy stages
# variable "stages" {
#   type = object({
#     source_stages = list(object({
#       stage_name      = string
#       name            = string
#       connection_arn  = string
#       repository_id   = string
#       branch_name     = string
#       output_artifacts = string
#     }))
#     build_stages = list(object({
#       stage_name      = string
#       name            = string
#       project_name    = string
#       input_artifacts = string
#       output_artifacts = string
#     }))
#     deploy_stages = list(object({
#       stage_name      = string
#       name            = string
#       input_artifacts = string
#       action_mode     = string
#       capabilities    = string
#       stack_name      = string
#       template_path   = string
#     }))
#   })
# }

# Unified stages object for any type of stage

# This variable was working recently, uncomment it to revert back

# variable "stages" {
#   type = list(object({
#     stage_name      = string            # Name of the stage
#     action_name     = string            # Name of the action within the stage
#     category        = string            # Stage type (e.g., "Source", "Build", "Deploy", "Approval")
#     owner           = string            # Owner (usually "AWS")
#     provider        = string            # Provider (e.g., "CodeBuild", "CloudFormation", "Manual")
#     input_artifacts  = optional(list(string)) # Input artifacts (optional for stages like Approval)
#     output_artifacts = optional(list(string)) # Output artifacts (optional for stages like Approval)
#     configuration   = map(string)       # Configuration specific to the action (e.g., ConnectionArn, ProjectName, StackName)
#   }))
# }

variable "stages" {
  type = list(object({
    stage_name = string
    actions = list(object({
      action_name      = string
      category         = string
      owner            = string
      provider         = string
      input_artifacts  = optional(list(string)) # Optional list of input artifacts
      output_artifacts = optional(list(string)) # Optional list of output artifacts
      configuration    = map(string)            # Configuration specific to the action
    }))
  }))
}

# variable "provider_type" {
#   type = string
#   default = "Bitbucket"
# }
# variable "codebuild_role_policy_arn" {
#   type = list(string)
# }

variable "bucket_policy" {
  description = "Optional S3 bucket policy in JSON format."
  type        = string
  default     = ""
}