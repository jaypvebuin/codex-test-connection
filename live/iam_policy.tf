########--------------- IAM Policy Modlue ---------------#########
#
#  For all the required IAM Policy parameters and their use please follow the official documentation.
#  https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_manage.html
#

locals {
  policy_configs = [
    #apply-approve-task
    {
      identifier             = "apply-approve-task"
      iam_policy_description = "apply-approve-task"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "secretsmanager:BatchGetSecretValue",
            "secretsmanager:ListSecrets",
            "secretsmanager:GetSecretValue",
            "secretsmanager:UpdateSecretVersionStage",
            "secretsmanager:TagResource",
            "ecr:BatchCheckLayerAvailability",
            "ecr:BatchGetImage",
            "ecr:GetDownloadUrlForLayer",
            "ecr:GetAuthorizationToken",
            "ecr:PutImageTagMutability",
            "logs:CreateLogDelivery",
            "logs:CreateLogStream",
            "logs:DeleteAccountPolicy",
            "logs:DeleteIndexPolicy",
            "logs:DeleteIntegration",
            "logs:DeleteLogDelivery",
            "logs:DeleteTransformer",
            "logs:DescribeFieldIndexes",
            "logs:DescribeIndexPolicies",
            "logs:FilterLogEvents",
            "logs:GetIntegration",
            "logs:GetLogDelivery",
            "logs:GetLogEvents",
            "logs:GetTransformer",
            "logs:Link",
            "logs:ListEntitiesForLogGroup",
            "logs:ListIntegrations",
            "logs:ListLogDeliveries",
            "logs:ListLogGroups*",
            "logs:ListTags*",
            "logs:PutAccountPolicy",
            "logs:PutIndexPolicy",
            "logs:PutIntegration",
            "logs:PutLogEvents",
            "logs:PutTransformer",
            "logs:StopLiveTail",
            "logs:Tag*",
            "logs:TestTransformer",
            "logs:Unmask",
            "logs:Untag*",
            "logs:UpdateLogDelivery",
            "secretsmanager:BatchGetSecretValue",
            "secretsmanager:GetSecretValue",
            "secretsmanager:ListSecrets",
            "secretsmanager:TagResource",
            "secretsmanager:UntagResource",
            "secretsmanager:UpdateSecretVersionStage",
            "ecr:BatchCheckLayerAvailability",
            "ecr:BatchGetImage",
            "ecr:BatchImportUpstreamImage",
            "ecr:CreateRepository",
            "ecr:GetAuthorizationToken",
            "ecr:GetDownloadUrlForLayer",
            "ecr:ListTagsForResource",
            "ecr:PutImageTagMutability",
            "ecr:PutLifecyclePolicy",
            "ecr:ReplicateImage",
            "ecr:SetRepositoryPolicy",
            "ecr:TagResource",
            "ecr:UntagResource",
            "ssmmessages:CreateControlChannel",
            "ssmmessages:CreateDataChannel",
            "ssmmessages:OpenControlChannel",
            "ssmmessages:OpenDataChannel",
            "s3:AbortMultipartUpload",
            "s3:BypassGovernanceRetention",
            "s3:CreateBucketMetadataTableConfiguration",
            "s3:CreateStorageLensGroup",
            "s3:DeleteBucketMetadataTableConfiguration",
            "s3:DeleteJobTagging",
            "s3:DeleteObject*",
            "s3:DeleteStorageLensConfigurationTagging",
            "s3:DeleteStorageLensGroup",
            "s3:GetBucketMetadataTableConfiguration",
            "s3:GetBucketTagging",
            "s3:GetJobTagging",
            "s3:GetObject",
            "s3:GetObjectAcl",
            "s3:GetObjectLegalHold",
            "s3:GetObjectRetention",
            "s3:GetObjectTagging",
            "s3:GetObjectTorrent",
            "s3:GetObjectVersion*",
            "s3:GetStorageLensConfigurationTagging",
            "s3:GetStorageLensGroup",
            "s3:InitiateReplication",
            "s3:ListAllMyBuckets",
            "s3:ListBucket",
            "s3:ListBucketVersions",
            "s3:ListCallerAccessGrants",
            "s3:ListMultipartUploadParts",
            "s3:ListStorageLensGroups",
            "s3:ListTagsForResource",
            "s3:ObjectOwnerOverrideToBucketOwner",
            "s3:PauseReplication",
            "s3:PutAccessPointPublicAccessBlock",
            "s3:PutBucketTagging",
            "s3:PutJobTagging",
            "s3:PutObject*",
            "s3:PutStorageLensConfigurationTagging",
            "s3:Replicate*",
            "s3:RestoreObject",
            "s3:TagResource",
            "s3:UntagResource",
            "s3:UpdateStorageLensGroup",
            "dynamodb:PartiQLUpdate",
            "dynamodb:UntagResource",
            "kms:Decrypt",
            "ssm:GetParameter",
            "ssm:GetParameters",
            "ssm:GetParametersByPath",
            "ssm:GetParameterHistory",
            "ssm:DescribeParameters",
            "ssm:DescribeDocumentParameters",
            "ssm:PutParameter"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "apply-approve-task"
      }
    },
    #apply-approve-task-second
    {
      identifier             = "apply-approve-task-second"
      iam_policy_description = "apply-approve-task-second"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "rds:DescribeAccountAttributes",
            "rds:DescribeBlueGreenDeployments",
            "rds:DescribeCertificates",
            "rds:DescribeDBClusterAutomatedBackups",
            "rds:DescribeDBClusterBacktracks",
            "rds:DescribeDBClusterEndpoints",
            "rds:DescribeDBClusterParameterGroups",
            "rds:DescribeDBClusterParameters",
            "rds:DescribeDBClusters",
            "rds:DescribeDBClusterSnapshotAttributes",
            "rds:DescribeDBClusterSnapshots",
            "rds:DescribeDBEngineVersions",
            "rds:DescribeDBInstances",
            "rds:DescribeDBLogFiles",
            "rds:DescribeDBParameterGroups",
            "rds:DescribeDBParameters",
            "rds:DescribeDBProxyEndpoints",
            "rds:DescribeDBProxies",
            "rds:DescribeDBProxyTargetGroups",
            "rds:DescribeDBProxyTargets",
            "rds:DescribeDBRecommendations",
            "rds:DescribeDBSecurityGroups",
            "rds:DescribeDBShardGroups",
            "rds:DescribeDBSnapshotAttributes",
            "rds:DescribeDBSnapshots",
            "rds:DescribeDBSnapshotTenantDatabases",
            "rds:DescribeDBSubnetGroups",
            "rds:DescribeEngineDefaultClusterParameters",
            "rds:DescribeEngineDefaultParameters",
            "rds:DescribeEventCategories",
            "rds:DescribeEvents",
            "rds:DescribeEventSubscriptions",
            "rds:DescribeExportTasks",
            "rds:DescribeGlobalClusters",
            "rds:DescribeIntegrations",
            "rds:DescribeOptionGroupOptions",
            "rds:DescribeOptionGroups",
            "rds:DescribeOrderableDBInstanceOptions",
            "rds:DescribePendingMaintenanceActions",
            "rds:DescribeReservedDBInstances",
            "rds:DescribeReservedDBInstancesOfferings",
            "rds:DescribeSourceRegions",
            "rds:DescribeValidDBInstanceModifications",
            "rds:DescribeTenantDatabases",
            "rds:DescribeRecommendationGroups",
            "rds:DescribeRecommendations",
            "rds:DownloadCompleteDBLogFile",
            "rds:DownloadDBLogFilePortion",
            "rds:ListTagsForResource",
            "rds:AddRoleToDBCluster",
            "rds:AddRoleToDBInstance",
            "rds:AddSourceIdentifierToSubscription",
            "rds:ApplyPendingMaintenanceAction",
            "rds:BacktrackDBCluster",
            "rds:CancelExportTask",
            "rds:CopyCustomDBEngineVersion",
            "rds:CopyDBClusterParameterGroup",
            "rds:CopyDBClusterSnapshot",
            "rds:CopyDBParameterGroup",
            "rds:CopyDBSnapshot",
            "rds:CopyOptionGroup",
            "rds:CreateBlueGreenDeployment",
            "rds:CreateCustomDBEngineVersion",
            "rds:CreateDBCluster",
            "rds:CreateDBClusterSnapshot",
            "rds:CreateDBClusterParameterGroup",
            "rds:CreateDBClusterEndpoint",
            "rds:CreateDBInstanceReadReplica",
            "rds:CreateDBParameterGroup",
            "rds:CreateDBProxy",
            "rds:CreateDBProxyEndpoint",
            "rds:CreateDBSecurityGroup",
            "rds:CreateDBShardGroup",
            "rds:CreateEventSubscription",
            "rds:CreateIntegration",
            "rds:CreateTenantDatabase",
            "rds:CreateOptionGroup",
            "rds:CrossRegionCommunication",
            "rds:EnableHttpEndpoint",
            "rds:FailoverDBCluster",
            "rds:FailoverGlobalCluster",
            "rds:ModifyActivityStream",
            "rds:ModifyCertificates",
            "rds:ModifyDBParameterGroup",
            "rds:PromoteReadReplica",
            "rds:AuthorizeDBSecurityGroupIngress",
            "vpce:AllowMultiRegion",
            "lambda:ListFunctions",
            "lambda:ListAliases",
            "lambda:ListCodeSigningConfigs",
            "lambda:ListEventSourceMappings",
            "lambda:ListFunctionEventInvokeConfigs",
            "lambda:ListFunctionsByCodeSigningConfig",
            "lambda:ListFunctionUrlConfigs",
            "lambda:ListLayers",
            "lambda:ListLayerVersions",
            "lambda:ListProvisionedConcurrencyConfigs",
            "lambda:ListVersionsByFunction",
            "lambda:GetAccountSettings",
            "lambda:GetAlias",
            "lambda:GetCodeSigningConfig",
            "lambda:GetEventSourceMapping",
            "lambda:GetFunction",
            "lambda:GetFunctionCodeSigningConfig",
            "lambda:GetFunctionConcurrency",
            "lambda:GetFunctionConfiguration",
            "lambda:GetFunctionEventInvokeConfig",
            "lambda:GetFunctionRecursionConfig",
            "lambda:GetFunctionUrlConfig",
            "lambda:GetLayerVersion",
            "lambda:GetLayerVersionPolicy",
            "lambda:GetPolicy",
            "lambda:GetProvisionedConcurrencyConfig",
            "lambda:GetRuntimeManagementConfig",
            "lambda:ListTags",
            "lambda:TagResource"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "apply-approve-task"
      }
    },
    #mongo-role-assume
    {
      identifier             = "mongo-role-assume"
      iam_policy_description = "mongo-role-assume"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "sts:AssumeRole"
          ]
          resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/vb-jugaad-mongo-ecs-role"]
        }
      ]
      tags = {
        Purpose = "mongo-role-assume"
      }
    },
    #form-details-task
    {
      identifier             = "form-details-task"
      iam_policy_description = "form-details-task"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "secretsmanager:BatchGetSecretValue",
            "secretsmanager:ListSecrets",
            "secretsmanager:GetSecretValue",
            "secretsmanager:UpdateSecretVersionStage",
            "secretsmanager:TagResource",
            "ecr:BatchCheckLayerAvailability",
            "ecr:BatchGetImage",
            "ecr:GetDownloadUrlForLayer",
            "ecr:GetAuthorizationToken",
            "ecr:PutImageTagMutability",
            "logs:CreateLogDelivery",
            "logs:CreateLogStream",
            "logs:DeleteAccountPolicy",
            "logs:DeleteIndexPolicy",
            "logs:DeleteIntegration",
            "logs:DeleteLogDelivery",
            "logs:DeleteTransformer",
            "logs:DescribeFieldIndexes",
            "logs:DescribeIndexPolicies",
            "logs:FilterLogEvents",
            "logs:GetIntegration",
            "logs:GetLogDelivery",
            "logs:GetLogEvents",
            "logs:GetTransformer",
            "logs:Link",
            "logs:ListEntitiesForLogGroup",
            "logs:ListIntegrations",
            "logs:ListLogDeliveries",
            "logs:ListLogGroups*",
            "logs:ListTags*",
            "logs:PutAccountPolicy",
            "logs:PutIndexPolicy",
            "logs:PutIntegration",
            "logs:PutLogEvents",
            "logs:PutTransformer",
            "logs:StopLiveTail",
            "logs:Tag*",
            "logs:TestTransformer",
            "logs:Unmask",
            "logs:Untag*",
            "logs:UpdateLogDelivery",
            "secretsmanager:BatchGetSecretValue",
            "secretsmanager:GetSecretValue",
            "secretsmanager:ListSecrets",
            "secretsmanager:TagResource",
            "secretsmanager:UntagResource",
            "secretsmanager:UpdateSecretVersionStage",
            "ecr:BatchCheckLayerAvailability",
            "ecr:BatchGetImage",
            "ecr:BatchImportUpstreamImage",
            "ecr:CreateRepository",
            "ecr:GetAuthorizationToken",
            "ecr:GetDownloadUrlForLayer",
            "ecr:ListTagsForResource",
            "ecr:PutImageTagMutability",
            "ecr:PutLifecyclePolicy",
            "ecr:ReplicateImage",
            "ecr:SetRepositoryPolicy",
            "ecr:TagResource",
            "ecr:UntagResource",
            "ssmmessages:CreateControlChannel",
            "ssmmessages:CreateDataChannel",
            "ssmmessages:OpenControlChannel",
            "ssmmessages:OpenDataChannel",
            "s3:AbortMultipartUpload",
            "s3:BypassGovernanceRetention",
            "s3:CreateBucketMetadataTableConfiguration",
            "s3:CreateStorageLensGroup",
            "s3:DeleteBucketMetadataTableConfiguration",
            "s3:DeleteJobTagging",
            "s3:DeleteObject*",
            "s3:DeleteStorageLensConfigurationTagging",
            "s3:DeleteStorageLensGroup",
            "s3:GetBucketMetadataTableConfiguration",
            "s3:GetBucketTagging",
            "s3:GetJobTagging",
            "s3:GetObject",
            "s3:GetObjectAcl",
            "s3:GetObjectLegalHold",
            "s3:GetObjectRetention",
            "s3:GetObjectTagging",
            "s3:GetObjectTorrent",
            "s3:GetObjectVersion*",
            "s3:GetStorageLensConfigurationTagging",
            "s3:GetStorageLensGroup",
            "s3:InitiateReplication",
            "s3:ListAllMyBuckets",
            "s3:ListBucket",
            "s3:ListBucketVersions",
            "s3:ListCallerAccessGrants",
            "s3:ListMultipartUploadParts",
            "s3:ListStorageLensGroups",
            "s3:ListTagsForResource",
            "s3:ObjectOwnerOverrideToBucketOwner",
            "s3:PauseReplication",
            "s3:PutAccessPointPublicAccessBlock",
            "s3:PutBucketTagging",
            "s3:PutJobTagging",
            "s3:PutObject*",
            "s3:PutStorageLensConfigurationTagging",
            "s3:Replicate*",
            "s3:RestoreObject",
            "s3:TagResource",
            "s3:UntagResource",
            "s3:UpdateStorageLensGroup",
            "dynamodb:PartiQLUpdate",
            "dynamodb:UntagResource",
            "kms:Decrypt",
            "ssm:GetParameter",
            "ssm:GetParameters",
            "ssm:GetParametersByPath",
            "ssm:GetParameterHistory",
            "ssm:DescribeParameters",
            "ssm:DescribeDocumentParameters",
            "ssm:PutParameter"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "apply-approve-task"
      }
    },
    #form-details-task-second
    {
      identifier             = "form-details-task-second"
      iam_policy_description = "form-details-task-second"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "rds:DescribeAccountAttributes",
            "rds:DescribeBlueGreenDeployments",
            "rds:DescribeCertificates",
            "rds:DescribeDBClusterAutomatedBackups",
            "rds:DescribeDBClusterBacktracks",
            "rds:DescribeDBClusterEndpoints",
            "rds:DescribeDBClusterParameterGroups",
            "rds:DescribeDBClusterParameters",
            "rds:DescribeDBClusters",
            "rds:DescribeDBClusterSnapshotAttributes",
            "rds:DescribeDBClusterSnapshots",
            "rds:DescribeDBEngineVersions",
            "rds:DescribeDBInstances",
            "rds:DescribeDBLogFiles",
            "rds:DescribeDBParameterGroups",
            "rds:DescribeDBParameters",
            "rds:DescribeDBProxyEndpoints",
            "rds:DescribeDBProxies",
            "rds:DescribeDBProxyTargetGroups",
            "rds:DescribeDBProxyTargets",
            "rds:DescribeDBRecommendations",
            "rds:DescribeDBSecurityGroups",
            "rds:DescribeDBShardGroups",
            "rds:DescribeDBSnapshotAttributes",
            "rds:DescribeDBSnapshots",
            "rds:DescribeDBSnapshotTenantDatabases",
            "rds:DescribeDBSubnetGroups",
            "rds:DescribeEngineDefaultClusterParameters",
            "rds:DescribeEngineDefaultParameters",
            "rds:DescribeEventCategories",
            "rds:DescribeEvents",
            "rds:DescribeEventSubscriptions",
            "rds:DescribeExportTasks",
            "rds:DescribeGlobalClusters",
            "rds:DescribeIntegrations",
            "rds:DescribeOptionGroupOptions",
            "rds:DescribeOptionGroups",
            "rds:DescribeOrderableDBInstanceOptions",
            "rds:DescribePendingMaintenanceActions",
            "rds:DescribeReservedDBInstances",
            "rds:DescribeReservedDBInstancesOfferings",
            "rds:DescribeSourceRegions",
            "rds:DescribeValidDBInstanceModifications",
            "rds:DescribeTenantDatabases",
            "rds:DescribeRecommendationGroups",
            "rds:DescribeRecommendations",
            "rds:DownloadCompleteDBLogFile",
            "rds:DownloadDBLogFilePortion",
            "rds:ListTagsForResource",
            "rds:AddRoleToDBCluster",
            "rds:AddRoleToDBInstance",
            "rds:AddSourceIdentifierToSubscription",
            "rds:ApplyPendingMaintenanceAction",
            "rds:BacktrackDBCluster",
            "rds:CancelExportTask",
            "rds:CopyCustomDBEngineVersion",
            "rds:CopyDBClusterParameterGroup",
            "rds:CopyDBClusterSnapshot",
            "rds:CopyDBParameterGroup",
            "rds:CopyDBSnapshot",
            "rds:CopyOptionGroup",
            "rds:CreateBlueGreenDeployment",
            "rds:CreateCustomDBEngineVersion",
            "rds:CreateDBCluster",
            "rds:CreateDBClusterSnapshot",
            "rds:CreateDBClusterParameterGroup",
            "rds:CreateDBClusterEndpoint",
            "rds:CreateDBInstanceReadReplica",
            "rds:CreateDBParameterGroup",
            "rds:CreateDBProxy",
            "rds:CreateDBProxyEndpoint",
            "rds:CreateDBSecurityGroup",
            "rds:CreateDBShardGroup",
            "rds:CreateEventSubscription",
            "rds:CreateIntegration",
            "rds:CreateTenantDatabase",
            "rds:CreateOptionGroup",
            "rds:CrossRegionCommunication",
            "rds:EnableHttpEndpoint",
            "rds:FailoverDBCluster",
            "rds:FailoverGlobalCluster",
            "rds:ModifyActivityStream",
            "rds:ModifyCertificates",
            "rds:ModifyDBParameterGroup",
            "rds:PromoteReadReplica",
            "rds:AuthorizeDBSecurityGroupIngress",
            "vpce:AllowMultiRegion",
            "lambda:ListFunctions",
            "lambda:ListAliases",
            "lambda:ListCodeSigningConfigs",
            "lambda:ListEventSourceMappings",
            "lambda:ListFunctionEventInvokeConfigs",
            "lambda:ListFunctionsByCodeSigningConfig",
            "lambda:ListFunctionUrlConfigs",
            "lambda:ListLayers",
            "lambda:ListLayerVersions",
            "lambda:ListProvisionedConcurrencyConfigs",
            "lambda:ListVersionsByFunction",
            "lambda:GetAccountSettings",
            "lambda:GetAlias",
            "lambda:GetCodeSigningConfig",
            "lambda:GetEventSourceMapping",
            "lambda:GetFunction",
            "lambda:GetFunctionCodeSigningConfig",
            "lambda:GetFunctionConcurrency",
            "lambda:GetFunctionConfiguration",
            "lambda:GetFunctionEventInvokeConfig",
            "lambda:GetFunctionRecursionConfig",
            "lambda:GetFunctionUrlConfig",
            "lambda:GetLayerVersion",
            "lambda:GetLayerVersionPolicy",
            "lambda:GetPolicy",
            "lambda:GetProvisionedConcurrencyConfig",
            "lambda:GetRuntimeManagementConfig",
            "lambda:ListTags",
            "lambda:TagResource"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "apply-approve-task"
      }
    },
    #notification-task
    {
      identifier             = "notification-task"
      iam_policy_description = "notification-task"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "secretsmanager:BatchGetSecretValue",
            "secretsmanager:ListSecrets",
            "secretsmanager:GetSecretValue",
            "secretsmanager:UpdateSecretVersionStage",
            "secretsmanager:TagResource",
            "ecr:BatchCheckLayerAvailability",
            "ecr:BatchGetImage",
            "ecr:GetDownloadUrlForLayer",
            "ecr:GetAuthorizationToken",
            "ecr:PutImageTagMutability",
            "logs:CreateLogDelivery",
            "logs:CreateLogStream",
            "logs:DeleteAccountPolicy",
            "logs:DeleteIndexPolicy",
            "logs:DeleteIntegration",
            "logs:DeleteLogDelivery",
            "logs:DeleteTransformer",
            "logs:DescribeFieldIndexes",
            "logs:DescribeIndexPolicies",
            "logs:FilterLogEvents",
            "logs:GetIntegration",
            "logs:GetLogDelivery",
            "logs:GetLogEvents",
            "logs:GetTransformer",
            "logs:Link",
            "logs:ListEntitiesForLogGroup",
            "logs:ListIntegrations",
            "logs:ListLogDeliveries",
            "logs:ListLogGroups*",
            "logs:ListTags*",
            "logs:PutAccountPolicy",
            "logs:PutIndexPolicy",
            "logs:PutIntegration",
            "logs:PutLogEvents",
            "logs:PutTransformer",
            "logs:StopLiveTail",
            "logs:Tag*",
            "logs:TestTransformer",
            "logs:Unmask",
            "logs:Untag*",
            "logs:UpdateLogDelivery",
            "secretsmanager:BatchGetSecretValue",
            "secretsmanager:GetSecretValue",
            "secretsmanager:ListSecrets",
            "secretsmanager:TagResource",
            "secretsmanager:UntagResource",
            "secretsmanager:UpdateSecretVersionStage",
            "ecr:BatchCheckLayerAvailability",
            "ecr:BatchGetImage",
            "ecr:BatchImportUpstreamImage",
            "ecr:CreateRepository",
            "ecr:GetAuthorizationToken",
            "ecr:GetDownloadUrlForLayer",
            "ecr:ListTagsForResource",
            "ecr:PutImageTagMutability",
            "ecr:PutLifecyclePolicy",
            "ecr:ReplicateImage",
            "ecr:SetRepositoryPolicy",
            "ecr:TagResource",
            "ecr:UntagResource",
            "ssmmessages:CreateControlChannel",
            "ssmmessages:CreateDataChannel",
            "ssmmessages:OpenControlChannel",
            "ssmmessages:OpenDataChannel",
            "s3:AbortMultipartUpload",
            "s3:BypassGovernanceRetention",
            "s3:CreateBucketMetadataTableConfiguration",
            "s3:CreateStorageLensGroup",
            "s3:DeleteBucketMetadataTableConfiguration",
            "s3:DeleteJobTagging",
            "s3:DeleteObject*",
            "s3:DeleteStorageLensConfigurationTagging",
            "s3:DeleteStorageLensGroup",
            "s3:GetBucketMetadataTableConfiguration",
            "s3:GetBucketTagging",
            "s3:GetJobTagging",
            "s3:GetObject",
            "s3:GetObjectAcl",
            "s3:GetObjectLegalHold",
            "s3:GetObjectRetention",
            "s3:GetObjectTagging",
            "s3:GetObjectTorrent",
            "s3:GetObjectVersion*",
            "s3:GetStorageLensConfigurationTagging",
            "s3:GetStorageLensGroup",
            "s3:InitiateReplication",
            "s3:ListAllMyBuckets",
            "s3:ListBucket",
            "s3:ListBucketVersions",
            "s3:ListCallerAccessGrants",
            "s3:ListMultipartUploadParts",
            "s3:ListStorageLensGroups",
            "s3:ListTagsForResource",
            "s3:ObjectOwnerOverrideToBucketOwner",
            "s3:PauseReplication",
            "s3:PutAccessPointPublicAccessBlock",
            "s3:PutBucketTagging",
            "s3:PutJobTagging",
            "s3:PutObject*",
            "s3:PutStorageLensConfigurationTagging",
            "s3:Replicate*",
            "s3:RestoreObject",
            "s3:TagResource",
            "s3:UntagResource",
            "s3:UpdateStorageLensGroup",
            "dynamodb:PartiQLUpdate",
            "dynamodb:UntagResource",
            "kms:Decrypt",
            "ssm:GetParameter",
            "ssm:GetParameters",
            "ssm:GetParametersByPath",
            "ssm:GetParameterHistory",
            "ssm:DescribeParameters",
            "ssm:DescribeDocumentParameters",
            "ssm:PutParameter"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "apply-approve-task"
      }
    },
    #notification-task-second
    {
      identifier             = "notification-task-second"
      iam_policy_description = "notification-task-second"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "rds:DescribeAccountAttributes",
            "rds:DescribeBlueGreenDeployments",
            "rds:DescribeCertificates",
            "rds:DescribeDBClusterAutomatedBackups",
            "rds:DescribeDBClusterBacktracks",
            "rds:DescribeDBClusterEndpoints",
            "rds:DescribeDBClusterParameterGroups",
            "rds:DescribeDBClusterParameters",
            "rds:DescribeDBClusters",
            "rds:DescribeDBClusterSnapshotAttributes",
            "rds:DescribeDBClusterSnapshots",
            "rds:DescribeDBEngineVersions",
            "rds:DescribeDBInstances",
            "rds:DescribeDBLogFiles",
            "rds:DescribeDBParameterGroups",
            "rds:DescribeDBParameters",
            "rds:DescribeDBProxyEndpoints",
            "rds:DescribeDBProxies",
            "rds:DescribeDBProxyTargetGroups",
            "rds:DescribeDBProxyTargets",
            "rds:DescribeDBRecommendations",
            "rds:DescribeDBSecurityGroups",
            "rds:DescribeDBShardGroups",
            "rds:DescribeDBSnapshotAttributes",
            "rds:DescribeDBSnapshots",
            "rds:DescribeDBSnapshotTenantDatabases",
            "rds:DescribeDBSubnetGroups",
            "rds:DescribeEngineDefaultClusterParameters",
            "rds:DescribeEngineDefaultParameters",
            "rds:DescribeEventCategories",
            "rds:DescribeEvents",
            "rds:DescribeEventSubscriptions",
            "rds:DescribeExportTasks",
            "rds:DescribeGlobalClusters",
            "rds:DescribeIntegrations",
            "rds:DescribeOptionGroupOptions",
            "rds:DescribeOptionGroups",
            "rds:DescribeOrderableDBInstanceOptions",
            "rds:DescribePendingMaintenanceActions",
            "rds:DescribeReservedDBInstances",
            "rds:DescribeReservedDBInstancesOfferings",
            "rds:DescribeSourceRegions",
            "rds:DescribeValidDBInstanceModifications",
            "rds:DescribeTenantDatabases",
            "rds:DescribeRecommendationGroups",
            "rds:DescribeRecommendations",
            "rds:DownloadCompleteDBLogFile",
            "rds:DownloadDBLogFilePortion",
            "rds:ListTagsForResource",
            "rds:AddRoleToDBCluster",
            "rds:AddRoleToDBInstance",
            "rds:AddSourceIdentifierToSubscription",
            "rds:ApplyPendingMaintenanceAction",
            "rds:BacktrackDBCluster",
            "rds:CancelExportTask",
            "rds:CopyCustomDBEngineVersion",
            "rds:CopyDBClusterParameterGroup",
            "rds:CopyDBClusterSnapshot",
            "rds:CopyDBParameterGroup",
            "rds:CopyDBSnapshot",
            "rds:CopyOptionGroup",
            "rds:CreateBlueGreenDeployment",
            "rds:CreateCustomDBEngineVersion",
            "rds:CreateDBCluster",
            "rds:CreateDBClusterSnapshot",
            "rds:CreateDBClusterParameterGroup",
            "rds:CreateDBClusterEndpoint",
            "rds:CreateDBInstanceReadReplica",
            "rds:CreateDBParameterGroup",
            "rds:CreateDBProxy",
            "rds:CreateDBProxyEndpoint",
            "rds:CreateDBSecurityGroup",
            "rds:CreateDBShardGroup",
            "rds:CreateEventSubscription",
            "rds:CreateIntegration",
            "rds:CreateTenantDatabase",
            "rds:CreateOptionGroup",
            "rds:CrossRegionCommunication",
            "rds:EnableHttpEndpoint",
            "rds:FailoverDBCluster",
            "rds:FailoverGlobalCluster",
            "rds:ModifyActivityStream",
            "rds:ModifyCertificates",
            "rds:ModifyDBParameterGroup",
            "rds:PromoteReadReplica",
            "rds:AuthorizeDBSecurityGroupIngress",
            "vpce:AllowMultiRegion",
            "lambda:ListFunctions",
            "lambda:ListAliases",
            "lambda:ListCodeSigningConfigs",
            "lambda:ListEventSourceMappings",
            "lambda:ListFunctionEventInvokeConfigs",
            "lambda:ListFunctionsByCodeSigningConfig",
            "lambda:ListFunctionUrlConfigs",
            "lambda:ListLayers",
            "lambda:ListLayerVersions",
            "lambda:ListProvisionedConcurrencyConfigs",
            "lambda:ListVersionsByFunction",
            "lambda:GetAccountSettings",
            "lambda:InvokeFunction",
            "lambda:GetAlias",
            "lambda:GetCodeSigningConfig",
            "lambda:GetEventSourceMapping",
            "lambda:GetFunction",
            "lambda:GetFunctionCodeSigningConfig",
            "lambda:GetFunctionConcurrency",
            "lambda:GetFunctionConfiguration",
            "lambda:GetFunctionEventInvokeConfig",
            "lambda:GetFunctionRecursionConfig",
            "lambda:GetFunctionUrlConfig",
            "lambda:GetLayerVersion",
            "lambda:GetLayerVersionPolicy",
            "lambda:GetPolicy",
            "lambda:GetProvisionedConcurrencyConfig",
            "lambda:GetRuntimeManagementConfig",
            "lambda:ListTags",
            "lambda:TagResource"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "apply-approve-task"
      }
    },
    #pdf-task
    {
      identifier             = "pdf-task"
      iam_policy_description = "pdf-task"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "secretsmanager:BatchGetSecretValue",
            "secretsmanager:ListSecrets",
            "secretsmanager:GetSecretValue",
            "secretsmanager:UpdateSecretVersionStage",
            "secretsmanager:TagResource",
            "ecr:BatchCheckLayerAvailability",
            "ecr:BatchGetImage",
            "ecr:GetDownloadUrlForLayer",
            "ecr:GetAuthorizationToken",
            "ecr:PutImageTagMutability",
            "logs:CreateLogDelivery",
            "logs:CreateLogStream",
            "logs:DeleteAccountPolicy",
            "logs:DeleteIndexPolicy",
            "logs:DeleteIntegration",
            "logs:DeleteLogDelivery",
            "logs:DeleteTransformer",
            "logs:DescribeFieldIndexes",
            "logs:DescribeIndexPolicies",
            "logs:FilterLogEvents",
            "logs:GetIntegration",
            "logs:GetLogDelivery",
            "logs:GetLogEvents",
            "logs:GetTransformer",
            "logs:Link",
            "logs:ListEntitiesForLogGroup",
            "logs:ListIntegrations",
            "logs:ListLogDeliveries",
            "logs:ListLogGroups*",
            "logs:ListTags*",
            "logs:PutAccountPolicy",
            "logs:PutIndexPolicy",
            "logs:PutIntegration",
            "logs:PutLogEvents",
            "logs:PutTransformer",
            "logs:StopLiveTail",
            "logs:Tag*",
            "logs:TestTransformer",
            "logs:Unmask",
            "logs:Untag*",
            "logs:UpdateLogDelivery",
            "secretsmanager:BatchGetSecretValue",
            "secretsmanager:GetSecretValue",
            "secretsmanager:ListSecrets",
            "secretsmanager:TagResource",
            "secretsmanager:UntagResource",
            "secretsmanager:UpdateSecretVersionStage",
            "ecr:BatchCheckLayerAvailability",
            "ecr:BatchGetImage",
            "ecr:BatchImportUpstreamImage",
            "ecr:CreateRepository",
            "ecr:GetAuthorizationToken",
            "ecr:GetDownloadUrlForLayer",
            "ecr:ListTagsForResource",
            "ecr:PutImageTagMutability",
            "ecr:PutLifecyclePolicy",
            "ecr:ReplicateImage",
            "ecr:SetRepositoryPolicy",
            "ecr:TagResource",
            "ecr:UntagResource",
            "ssmmessages:CreateControlChannel",
            "ssmmessages:CreateDataChannel",
            "ssmmessages:OpenControlChannel",
            "ssmmessages:OpenDataChannel",
            "s3:AbortMultipartUpload",
            "s3:BypassGovernanceRetention",
            "s3:CreateBucketMetadataTableConfiguration",
            "s3:CreateStorageLensGroup",
            "s3:DeleteBucketMetadataTableConfiguration",
            "s3:DeleteJobTagging",
            "s3:DeleteObject*",
            "s3:DeleteStorageLensConfigurationTagging",
            "s3:DeleteStorageLensGroup",
            "s3:GetBucketMetadataTableConfiguration",
            "s3:GetBucketTagging",
            "s3:GetJobTagging",
            "s3:GetObject",
            "s3:GetObjectAcl",
            "s3:GetObjectLegalHold",
            "s3:GetObjectRetention",
            "s3:GetObjectTagging",
            "s3:GetObjectTorrent",
            "s3:GetObjectVersion*",
            "s3:GetStorageLensConfigurationTagging",
            "s3:GetStorageLensGroup",
            "s3:InitiateReplication",
            "s3:ListAllMyBuckets",
            "s3:ListBucket",
            "s3:ListBucketVersions",
            "s3:ListCallerAccessGrants",
            "s3:ListMultipartUploadParts",
            "s3:ListStorageLensGroups",
            "s3:ListTagsForResource",
            "s3:ObjectOwnerOverrideToBucketOwner",
            "s3:PauseReplication",
            "s3:PutAccessPointPublicAccessBlock",
            "s3:PutBucketTagging",
            "s3:PutJobTagging",
            "s3:PutObject*",
            "s3:PutStorageLensConfigurationTagging",
            "s3:Replicate*",
            "s3:RestoreObject",
            "s3:TagResource",
            "s3:UntagResource",
            "s3:UpdateStorageLensGroup",
            "dynamodb:PartiQLUpdate",
            "dynamodb:UpdateItem",
            "dynamodb:Scan",
            "dynamodb:UntagResource",
            "kms:Decrypt",
            "ssm:GetParameter",
            "ssm:GetParameters",
            "ssm:GetParametersByPath",
            "ssm:GetParameterHistory",
            "ssm:DescribeParameters",
            "ssm:DescribeDocumentParameters",
            "ssm:PutParameter"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "apply-approve-task"
      }
    },
    #pdf-task-second
    {
      identifier             = "pdf-task-second"
      iam_policy_description = "pdf-task-second"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "rds:DescribeAccountAttributes",
            "rds:DescribeBlueGreenDeployments",
            "rds:DescribeCertificates",
            "rds:DescribeDBClusterAutomatedBackups",
            "rds:DescribeDBClusterBacktracks",
            "rds:DescribeDBClusterEndpoints",
            "rds:DescribeDBClusterParameterGroups",
            "rds:DescribeDBClusterParameters",
            "rds:DescribeDBClusters",
            "rds:DescribeDBClusterSnapshotAttributes",
            "rds:DescribeDBClusterSnapshots",
            "rds:DescribeDBEngineVersions",
            "rds:DescribeDBInstances",
            "rds:DescribeDBLogFiles",
            "rds:DescribeDBParameterGroups",
            "rds:DescribeDBParameters",
            "rds:DescribeDBProxyEndpoints",
            "rds:DescribeDBProxies",
            "rds:DescribeDBProxyTargetGroups",
            "rds:DescribeDBProxyTargets",
            "rds:DescribeDBRecommendations",
            "rds:DescribeDBSecurityGroups",
            "rds:DescribeDBShardGroups",
            "rds:DescribeDBSnapshotAttributes",
            "rds:DescribeDBSnapshots",
            "rds:DescribeDBSnapshotTenantDatabases",
            "rds:DescribeDBSubnetGroups",
            "rds:DescribeEngineDefaultClusterParameters",
            "rds:DescribeEngineDefaultParameters",
            "rds:DescribeEventCategories",
            "rds:DescribeEvents",
            "rds:DescribeEventSubscriptions",
            "rds:DescribeExportTasks",
            "rds:DescribeGlobalClusters",
            "rds:DescribeIntegrations",
            "rds:DescribeOptionGroupOptions",
            "rds:DescribeOptionGroups",
            "rds:DescribeOrderableDBInstanceOptions",
            "rds:DescribePendingMaintenanceActions",
            "rds:DescribeReservedDBInstances",
            "rds:DescribeReservedDBInstancesOfferings",
            "rds:DescribeSourceRegions",
            "rds:DescribeValidDBInstanceModifications",
            "rds:DescribeTenantDatabases",
            "rds:DescribeRecommendationGroups",
            "rds:DescribeRecommendations",
            "rds:DownloadCompleteDBLogFile",
            "rds:DownloadDBLogFilePortion",
            "rds:ListTagsForResource",
            "rds:AddRoleToDBCluster",
            "rds:AddRoleToDBInstance",
            "rds:AddSourceIdentifierToSubscription",
            "rds:ApplyPendingMaintenanceAction",
            "rds:BacktrackDBCluster",
            "rds:CancelExportTask",
            "rds:CopyCustomDBEngineVersion",
            "rds:CopyDBClusterParameterGroup",
            "rds:CopyDBClusterSnapshot",
            "rds:CopyDBParameterGroup",
            "rds:CopyDBSnapshot",
            "rds:CopyOptionGroup",
            "rds:CreateBlueGreenDeployment",
            "rds:CreateCustomDBEngineVersion",
            "rds:CreateDBCluster",
            "rds:CreateDBClusterSnapshot",
            "rds:CreateDBClusterParameterGroup",
            "rds:CreateDBClusterEndpoint",
            "rds:CreateDBInstanceReadReplica",
            "rds:CreateDBParameterGroup",
            "rds:CreateDBProxy",
            "rds:CreateDBProxyEndpoint",
            "rds:CreateDBSecurityGroup",
            "rds:CreateDBShardGroup",
            "rds:CreateEventSubscription",
            "rds:CreateIntegration",
            "rds:CreateTenantDatabase",
            "rds:CreateOptionGroup",
            "rds:CrossRegionCommunication",
            "rds:EnableHttpEndpoint",
            "rds:FailoverDBCluster",
            "rds:FailoverGlobalCluster",
            "rds:ModifyActivityStream",
            "rds:ModifyCertificates",
            "rds:ModifyDBParameterGroup",
            "rds:PromoteReadReplica",
            "rds:AuthorizeDBSecurityGroupIngress",
            "vpce:AllowMultiRegion",
            "lambda:ListFunctions",
            "lambda:ListAliases",
            "lambda:ListCodeSigningConfigs",
            "lambda:ListEventSourceMappings",
            "lambda:ListFunctionEventInvokeConfigs",
            "lambda:ListFunctionsByCodeSigningConfig",
            "lambda:ListFunctionUrlConfigs",
            "lambda:ListLayers",
            "lambda:ListLayerVersions",
            "lambda:ListProvisionedConcurrencyConfigs",
            "lambda:ListVersionsByFunction",
            "lambda:GetAccountSettings",
            "lambda:InvokeFunction",
            "lambda:GetAlias",
            "lambda:GetCodeSigningConfig",
            "lambda:GetEventSourceMapping",
            "lambda:GetFunction",
            "lambda:GetFunctionCodeSigningConfig",
            "lambda:GetFunctionConcurrency",
            "lambda:GetFunctionConfiguration",
            "lambda:GetFunctionEventInvokeConfig",
            "lambda:GetFunctionRecursionConfig",
            "lambda:GetFunctionUrlConfig",
            "lambda:GetLayerVersion",
            "lambda:GetLayerVersionPolicy",
            "lambda:GetPolicy",
            "lambda:GetProvisionedConcurrencyConfig",
            "lambda:GetRuntimeManagementConfig",
            "lambda:ListTags",
            "lambda:TagResource",
            "dynamodb:GetItem",
            "dynamodb:PutItem"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "apply-approve-task"
      }
    },
    #report-task
    {
      identifier             = "report-task"
      iam_policy_description = "report-task"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "secretsmanager:BatchGetSecretValue",
            "secretsmanager:ListSecrets",
            "secretsmanager:GetSecretValue",
            "secretsmanager:UpdateSecretVersionStage",
            "secretsmanager:TagResource",
            "ecr:BatchCheckLayerAvailability",
            "ecr:BatchGetImage",
            "ecr:GetDownloadUrlForLayer",
            "ecr:GetAuthorizationToken",
            "ecr:PutImageTagMutability",
            "logs:CreateLogDelivery",
            "logs:CreateLogStream",
            "logs:DeleteAccountPolicy",
            "logs:DeleteIndexPolicy",
            "logs:DeleteIntegration",
            "logs:DeleteLogDelivery",
            "logs:DeleteTransformer",
            "logs:DescribeFieldIndexes",
            "logs:DescribeIndexPolicies",
            "logs:FilterLogEvents",
            "logs:GetIntegration",
            "logs:GetLogDelivery",
            "logs:GetLogEvents",
            "logs:GetTransformer",
            "logs:Link",
            "logs:ListEntitiesForLogGroup",
            "logs:ListIntegrations",
            "logs:ListLogDeliveries",
            "logs:ListLogGroups*",
            "logs:ListTags*",
            "logs:PutAccountPolicy",
            "logs:PutIndexPolicy",
            "logs:PutIntegration",
            "logs:PutLogEvents",
            "logs:PutTransformer",
            "logs:StopLiveTail",
            "logs:Tag*",
            "logs:TestTransformer",
            "logs:Unmask",
            "logs:Untag*",
            "logs:UpdateLogDelivery",
            "secretsmanager:BatchGetSecretValue",
            "secretsmanager:GetSecretValue",
            "secretsmanager:ListSecrets",
            "secretsmanager:TagResource",
            "secretsmanager:UntagResource",
            "secretsmanager:UpdateSecretVersionStage",
            "ecr:BatchCheckLayerAvailability",
            "ecr:BatchGetImage",
            "ecr:BatchImportUpstreamImage",
            "ecr:CreateRepository",
            "ecr:GetAuthorizationToken",
            "ecr:GetDownloadUrlForLayer",
            "ecr:ListTagsForResource",
            "ecr:PutImageTagMutability",
            "ecr:PutLifecyclePolicy",
            "ecr:ReplicateImage",
            "ecr:SetRepositoryPolicy",
            "ecr:TagResource",
            "ecr:UntagResource",
            "ssmmessages:CreateControlChannel",
            "ssmmessages:CreateDataChannel",
            "ssmmessages:OpenControlChannel",
            "ssmmessages:OpenDataChannel",
            "s3:AbortMultipartUpload",
            "s3:BypassGovernanceRetention",
            "s3:CreateBucketMetadataTableConfiguration",
            "s3:CreateStorageLensGroup",
            "s3:DeleteBucketMetadataTableConfiguration",
            "s3:DeleteJobTagging",
            "s3:DeleteObject*",
            "s3:DeleteStorageLensConfigurationTagging",
            "s3:DeleteStorageLensGroup",
            "s3:GetBucketMetadataTableConfiguration",
            "s3:GetBucketTagging",
            "s3:GetJobTagging",
            "s3:GetObject",
            "s3:GetObjectAcl",
            "s3:GetObjectLegalHold",
            "s3:GetObjectRetention",
            "s3:GetObjectTagging",
            "s3:GetObjectTorrent",
            "s3:GetObjectVersion*",
            "s3:GetStorageLensConfigurationTagging",
            "s3:GetStorageLensGroup",
            "s3:InitiateReplication",
            "s3:ListAllMyBuckets",
            "s3:ListBucket",
            "s3:ListBucketVersions",
            "s3:ListCallerAccessGrants",
            "s3:ListMultipartUploadParts",
            "s3:ListStorageLensGroups",
            "s3:ListTagsForResource",
            "s3:ObjectOwnerOverrideToBucketOwner",
            "s3:PauseReplication",
            "s3:PutAccessPointPublicAccessBlock",
            "s3:PutBucketTagging",
            "s3:PutJobTagging",
            "s3:PutObject*",
            "s3:PutStorageLensConfigurationTagging",
            "s3:Replicate*",
            "s3:RestoreObject",
            "s3:TagResource",
            "s3:UntagResource",
            "s3:UpdateStorageLensGroup",
            "dynamodb:PartiQLUpdate",
            "dynamodb:UntagResource",
            "kms:Decrypt",
            "ssm:GetParameter",
            "ssm:GetParameters",
            "ssm:GetParametersByPath",
            "ssm:GetParameterHistory",
            "ssm:DescribeParameters",
            "ssm:DescribeDocumentParameters",
            "ssm:PutParameter"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "report-task"
      }
    },
    #report-task-second
    {
      identifier             = "report-task-second"
      iam_policy_description = "report-task-second"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "rds:DescribeAccountAttributes",
            "rds:DescribeBlueGreenDeployments",
            "rds:DescribeCertificates",
            "rds:DescribeDBClusterAutomatedBackups",
            "rds:DescribeDBClusterBacktracks",
            "rds:DescribeDBClusterEndpoints",
            "rds:DescribeDBClusterParameterGroups",
            "rds:DescribeDBClusterParameters",
            "rds:DescribeDBClusters",
            "rds:DescribeDBClusterSnapshotAttributes",
            "rds:DescribeDBClusterSnapshots",
            "rds:DescribeDBEngineVersions",
            "rds:DescribeDBInstances",
            "rds:DescribeDBLogFiles",
            "rds:DescribeDBParameterGroups",
            "rds:DescribeDBParameters",
            "rds:DescribeDBProxyEndpoints",
            "rds:DescribeDBProxies",
            "rds:DescribeDBProxyTargetGroups",
            "rds:DescribeDBProxyTargets",
            "rds:DescribeDBRecommendations",
            "rds:DescribeDBSecurityGroups",
            "rds:DescribeDBShardGroups",
            "rds:DescribeDBSnapshotAttributes",
            "rds:DescribeDBSnapshots",
            "rds:DescribeDBSnapshotTenantDatabases",
            "rds:DescribeDBSubnetGroups",
            "rds:DescribeEngineDefaultClusterParameters",
            "rds:DescribeEngineDefaultParameters",
            "rds:DescribeEventCategories",
            "rds:DescribeEvents",
            "rds:DescribeEventSubscriptions",
            "rds:DescribeExportTasks",
            "rds:DescribeGlobalClusters",
            "rds:DescribeIntegrations",
            "rds:DescribeOptionGroupOptions",
            "rds:DescribeOptionGroups",
            "rds:DescribeOrderableDBInstanceOptions",
            "rds:DescribePendingMaintenanceActions",
            "rds:DescribeReservedDBInstances",
            "rds:DescribeReservedDBInstancesOfferings",
            "rds:DescribeSourceRegions",
            "rds:DescribeValidDBInstanceModifications",
            "rds:DescribeTenantDatabases",
            "rds:DescribeRecommendationGroups",
            "rds:DescribeRecommendations",
            "rds:DownloadCompleteDBLogFile",
            "rds:DownloadDBLogFilePortion",
            "rds:ListTagsForResource",
            "rds:AddRoleToDBCluster",
            "rds:AddRoleToDBInstance",
            "rds:AddSourceIdentifierToSubscription",
            "rds:ApplyPendingMaintenanceAction",
            "rds:BacktrackDBCluster",
            "rds:CancelExportTask",
            "rds:CopyCustomDBEngineVersion",
            "rds:CopyDBClusterParameterGroup",
            "rds:CopyDBClusterSnapshot",
            "rds:CopyDBParameterGroup",
            "rds:CopyDBSnapshot",
            "rds:CopyOptionGroup",
            "rds:CreateBlueGreenDeployment",
            "rds:CreateCustomDBEngineVersion",
            "rds:CreateDBCluster",
            "rds:CreateDBClusterSnapshot",
            "rds:CreateDBClusterParameterGroup",
            "rds:CreateDBClusterEndpoint",
            "rds:CreateDBInstanceReadReplica",
            "rds:CreateDBParameterGroup",
            "rds:CreateDBProxy",
            "rds:CreateDBProxyEndpoint",
            "rds:CreateDBSecurityGroup",
            "rds:CreateDBShardGroup",
            "rds:CreateEventSubscription",
            "rds:CreateIntegration",
            "rds:CreateTenantDatabase",
            "rds:CreateOptionGroup",
            "rds:CrossRegionCommunication",
            "rds:EnableHttpEndpoint",
            "rds:FailoverDBCluster",
            "rds:FailoverGlobalCluster",
            "rds:ModifyActivityStream",
            "rds:ModifyCertificates",
            "rds:ModifyDBParameterGroup",
            "rds:PromoteReadReplica",
            "rds:AuthorizeDBSecurityGroupIngress",
            "vpce:AllowMultiRegion",
            "lambda:ListFunctions",
            "lambda:ListAliases",
            "lambda:ListCodeSigningConfigs",
            "lambda:ListEventSourceMappings",
            "lambda:ListFunctionEventInvokeConfigs",
            "lambda:ListFunctionsByCodeSigningConfig",
            "lambda:ListFunctionUrlConfigs",
            "lambda:ListLayers",
            "lambda:ListLayerVersions",
            "lambda:ListProvisionedConcurrencyConfigs",
            "lambda:ListVersionsByFunction",
            "lambda:GetAccountSettings",
            "lambda:InvokeFunction",
            "lambda:GetAlias",
            "lambda:GetCodeSigningConfig",
            "lambda:GetEventSourceMapping",
            "lambda:GetFunction",
            "lambda:GetFunctionCodeSigningConfig",
            "lambda:GetFunctionConcurrency",
            "lambda:GetFunctionConfiguration",
            "lambda:GetFunctionEventInvokeConfig",
            "lambda:GetFunctionRecursionConfig",
            "lambda:GetFunctionUrlConfig",
            "lambda:GetLayerVersion",
            "lambda:GetLayerVersionPolicy",
            "lambda:GetPolicy",
            "lambda:GetProvisionedConcurrencyConfig",
            "lambda:GetRuntimeManagementConfig",
            "lambda:ListTags",
            "lambda:TagResource"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "report-task"
      }
    },
    #announcement-task
    {
      identifier             = "announcement-task"
      iam_policy_description = "announcement-task"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "secretsmanager:BatchGetSecretValue",
            "secretsmanager:ListSecrets",
            "secretsmanager:GetSecretValue",
            "secretsmanager:UpdateSecretVersionStage",
            "secretsmanager:TagResource",
            "ecr:BatchCheckLayerAvailability",
            "ecr:BatchGetImage",
            "ecr:GetDownloadUrlForLayer",
            "ecr:GetAuthorizationToken",
            "ecr:PutImageTagMutability",
            "logs:CreateLogDelivery",
            "logs:CreateLogStream",
            "logs:DeleteAccountPolicy",
            "logs:DeleteIndexPolicy",
            "logs:DeleteIntegration",
            "logs:DeleteLogDelivery",
            "logs:DeleteTransformer",
            "logs:DescribeFieldIndexes",
            "logs:DescribeIndexPolicies",
            "logs:FilterLogEvents",
            "logs:GetIntegration",
            "logs:GetLogDelivery",
            "logs:GetLogEvents",
            "logs:GetTransformer",
            "logs:Link",
            "logs:ListEntitiesForLogGroup",
            "logs:ListIntegrations",
            "logs:ListLogDeliveries",
            "logs:ListLogGroups*",
            "logs:ListTags*",
            "logs:PutAccountPolicy",
            "logs:PutIndexPolicy",
            "logs:PutIntegration",
            "logs:PutLogEvents",
            "logs:PutTransformer",
            "logs:StopLiveTail",
            "logs:Tag*",
            "logs:TestTransformer",
            "logs:Unmask",
            "logs:Untag*",
            "logs:UpdateLogDelivery",
            "secretsmanager:BatchGetSecretValue",
            "secretsmanager:GetSecretValue",
            "secretsmanager:ListSecrets",
            "secretsmanager:TagResource",
            "secretsmanager:UntagResource",
            "secretsmanager:UpdateSecretVersionStage",
            "ecr:BatchCheckLayerAvailability",
            "ecr:BatchGetImage",
            "ecr:BatchImportUpstreamImage",
            "ecr:CreateRepository",
            "ecr:GetAuthorizationToken",
            "ecr:GetDownloadUrlForLayer",
            "ecr:ListTagsForResource",
            "ecr:PutImageTagMutability",
            "ecr:PutLifecyclePolicy",
            "ecr:ReplicateImage",
            "ecr:SetRepositoryPolicy",
            "ecr:TagResource",
            "ecr:UntagResource",
            "ssmmessages:CreateControlChannel",
            "ssmmessages:CreateDataChannel",
            "ssmmessages:OpenControlChannel",
            "ssmmessages:OpenDataChannel",
            "s3:AbortMultipartUpload",
            "s3:BypassGovernanceRetention",
            "s3:CreateBucketMetadataTableConfiguration",
            "s3:CreateStorageLensGroup",
            "s3:DeleteBucketMetadataTableConfiguration",
            "s3:DeleteJobTagging",
            "s3:DeleteObject*",
            "s3:DeleteStorageLensConfigurationTagging",
            "s3:DeleteStorageLensGroup",
            "s3:GetBucketMetadataTableConfiguration",
            "s3:GetBucketTagging",
            "s3:GetJobTagging",
            "s3:GetObject",
            "s3:GetObjectAcl",
            "s3:GetObjectLegalHold",
            "s3:GetObjectRetention",
            "s3:GetObjectTagging",
            "s3:GetObjectTorrent",
            "s3:GetObjectVersion*",
            "s3:GetStorageLensConfigurationTagging",
            "s3:GetStorageLensGroup",
            "s3:InitiateReplication",
            "s3:ListAllMyBuckets",
            "s3:ListBucket",
            "s3:ListBucketVersions",
            "s3:ListCallerAccessGrants",
            "s3:ListMultipartUploadParts",
            "s3:ListStorageLensGroups",
            "s3:ListTagsForResource",
            "s3:ObjectOwnerOverrideToBucketOwner",
            "s3:PauseReplication",
            "s3:PutAccessPointPublicAccessBlock",
            "s3:PutBucketTagging",
            "s3:PutJobTagging",
            "s3:PutObject*",
            "s3:PutStorageLensConfigurationTagging",
            "s3:Replicate*",
            "s3:RestoreObject",
            "s3:TagResource",
            "s3:UntagResource",
            "s3:UpdateStorageLensGroup",
            "dynamodb:PartiQLUpdate",
            "dynamodb:UntagResource",
            "kms:Decrypt",
            "ssm:GetParameter",
            "ssm:GetParameters",
            "ssm:GetParametersByPath",
            "ssm:GetParameterHistory",
            "ssm:DescribeParameters",
            "ssm:DescribeDocumentParameters",
            "ssm:PutParameter"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "announcement-task"
      }
    },
    #announcement-task-second
    {
      identifier             = "announcement-task-second"
      iam_policy_description = "announcement-task-second"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "rds:DescribeAccountAttributes",
            "rds:DescribeBlueGreenDeployments",
            "rds:DescribeCertificates",
            "rds:DescribeDBClusterAutomatedBackups",
            "rds:DescribeDBClusterBacktracks",
            "rds:DescribeDBClusterEndpoints",
            "rds:DescribeDBClusterParameterGroups",
            "rds:DescribeDBClusterParameters",
            "rds:DescribeDBClusters",
            "rds:DescribeDBClusterSnapshotAttributes",
            "rds:DescribeDBClusterSnapshots",
            "rds:DescribeDBEngineVersions",
            "rds:DescribeDBInstances",
            "rds:DescribeDBLogFiles",
            "rds:DescribeDBParameterGroups",
            "rds:DescribeDBParameters",
            "rds:DescribeDBProxyEndpoints",
            "rds:DescribeDBProxies",
            "rds:DescribeDBProxyTargetGroups",
            "rds:DescribeDBProxyTargets",
            "rds:DescribeDBRecommendations",
            "rds:DescribeDBSecurityGroups",
            "rds:DescribeDBShardGroups",
            "rds:DescribeDBSnapshotAttributes",
            "rds:DescribeDBSnapshots",
            "rds:DescribeDBSnapshotTenantDatabases",
            "rds:DescribeDBSubnetGroups",
            "rds:DescribeEngineDefaultClusterParameters",
            "rds:DescribeEngineDefaultParameters",
            "rds:DescribeEventCategories",
            "rds:DescribeEvents",
            "rds:DescribeEventSubscriptions",
            "rds:DescribeExportTasks",
            "rds:DescribeGlobalClusters",
            "rds:DescribeIntegrations",
            "rds:DescribeOptionGroupOptions",
            "rds:DescribeOptionGroups",
            "rds:DescribeOrderableDBInstanceOptions",
            "rds:DescribePendingMaintenanceActions",
            "rds:DescribeReservedDBInstances",
            "rds:DescribeReservedDBInstancesOfferings",
            "rds:DescribeSourceRegions",
            "rds:DescribeValidDBInstanceModifications",
            "rds:DescribeTenantDatabases",
            "rds:DescribeRecommendationGroups",
            "rds:DescribeRecommendations",
            "rds:DownloadCompleteDBLogFile",
            "rds:DownloadDBLogFilePortion",
            "rds:ListTagsForResource",
            "rds:AddRoleToDBCluster",
            "rds:AddRoleToDBInstance",
            "rds:AddSourceIdentifierToSubscription",
            "rds:ApplyPendingMaintenanceAction",
            "rds:BacktrackDBCluster",
            "rds:CancelExportTask",
            "rds:CopyCustomDBEngineVersion",
            "rds:CopyDBClusterParameterGroup",
            "rds:CopyDBClusterSnapshot",
            "rds:CopyDBParameterGroup",
            "rds:CopyDBSnapshot",
            "rds:CopyOptionGroup",
            "rds:CreateBlueGreenDeployment",
            "rds:CreateCustomDBEngineVersion",
            "rds:CreateDBCluster",
            "rds:CreateDBClusterSnapshot",
            "rds:CreateDBClusterParameterGroup",
            "rds:CreateDBClusterEndpoint",
            "rds:CreateDBInstanceReadReplica",
            "rds:CreateDBParameterGroup",
            "rds:CreateDBProxy",
            "rds:CreateDBProxyEndpoint",
            "rds:CreateDBSecurityGroup",
            "rds:CreateDBShardGroup",
            "rds:CreateEventSubscription",
            "rds:CreateIntegration",
            "rds:CreateTenantDatabase",
            "rds:CreateOptionGroup",
            "rds:CrossRegionCommunication",
            "rds:EnableHttpEndpoint",
            "rds:FailoverDBCluster",
            "rds:FailoverGlobalCluster",
            "rds:ModifyActivityStream",
            "rds:ModifyCertificates",
            "rds:ModifyDBParameterGroup",
            "rds:PromoteReadReplica",
            "rds:AuthorizeDBSecurityGroupIngress",
            "vpce:AllowMultiRegion",
            "lambda:ListFunctions",
            "lambda:ListAliases",
            "lambda:ListCodeSigningConfigs",
            "lambda:ListEventSourceMappings",
            "lambda:ListFunctionEventInvokeConfigs",
            "lambda:ListFunctionsByCodeSigningConfig",
            "lambda:ListFunctionUrlConfigs",
            "lambda:ListLayers",
            "lambda:ListLayerVersions",
            "lambda:ListProvisionedConcurrencyConfigs",
            "lambda:ListVersionsByFunction",
            "lambda:GetAccountSettings",
            "lambda:InvokeFunction",
            "lambda:GetAlias",
            "lambda:GetCodeSigningConfig",
            "lambda:GetEventSourceMapping",
            "lambda:GetFunction",
            "lambda:GetFunctionCodeSigningConfig",
            "lambda:GetFunctionConcurrency",
            "lambda:GetFunctionConfiguration",
            "lambda:GetFunctionEventInvokeConfig",
            "lambda:GetFunctionRecursionConfig",
            "lambda:GetFunctionUrlConfig",
            "lambda:GetLayerVersion",
            "lambda:GetLayerVersionPolicy",
            "lambda:GetPolicy",
            "lambda:GetProvisionedConcurrencyConfig",
            "lambda:GetRuntimeManagementConfig",
            "lambda:ListTags",
            "lambda:TagResource"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "announcement-task"
      }
    },
    #auth-lambda
    {
      identifier             = "auth-lambda"
      iam_policy_description = "auth-lambda"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents",
            "logs:CreateLogStream",
            "ecs:RunTask",
            "ec2:CreateNetworkInterface",
            "ec2:DescribeNetworkInterfaces",
            "ec2:DeleteNetworkInterface",
            "ec2:DescribeSubnets",
            "logs:CreateLogStream",
            "logs:PutLogEvents",
            "kms:Decrypt",
            "iam:PassRole",
            "s3:ListBucket",
            "s3:GetObject",
            "s3:*",
            "secretsmanager:BatchGetSecretValue",
            "secretsmanager:ListSecrets",
            "secretsmanager:DescribeSecret",
            "secretsmanager:GetRandomPassword",
            "secretsmanager:GetResourcePolicy",
            "secretsmanager:GetSecretValue",
            "secretsmanager:ListSecretVersionIds",
            "secretsmanager:CreateSecret",
            "secretsmanager:CancelRotateSecret",
            "secretsmanager:PutSecretValue",
            "secretsmanager:ReplicateSecretToRegions",
            "secretsmanager:RestoreSecret",
            "secretsmanager:RotateSecret",
            "secretsmanager:UpdateSecret",
            "secretsmanager:UpdateSecretVersionStage",
            "secretsmanager:PutResourcePolicy",
            "secretsmanager:ValidateResourcePolicy",
            "secretsmanager:TagResource",
            "secretsmanager:UntagResource"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "auth-lambda-policy"
      }
    },
    #auth-lambda-codebuild
    {
      identifier             = "auth-lambda-codebuild"
      iam_policy_description = "auth-lambda-codebuild"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "ecr:*",
            "cloudwatch:*",
            "s3:*",
            "logs:*",
            "codebuild:*",
            "ec2:*",
            "sns:*",
            "ssm:*",
            "lambda:*",
            "kms:*"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "apply-approve-codebuild"
      }
    },
    #sonarqube-codebuild
    {
      identifier             = "sonarqube-codebuild"
      iam_policy_description = "sonarqube-codebuild"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "s3:*",
            "sns:*",
            "cloudwatch:*",
            "logs:*",
            "ec2:*"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "apply-approve-codebuild"
      }
    },
    #apply-approve-codebuild
    {
      identifier             = "apply-approve-codebuild"
      iam_policy_description = "apply-approve-codebuild"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "ecr:*",
            "cloudwatch:*",
            "s3:*",
            "logs:*",
            "codebuild:*",
            "ec2:*",
            "sns:*"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "apply-approve-codebuild"
      }
    },
    #form-details-codebuild
    {
      identifier             = "form-details-codebuild"
      iam_policy_description = "form-details-codebuild"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "ecr:*",
            "cloudwatch:*",
            "s3:*",
            "logs:*",
            "codebuild:*",
            "ec2:*",
            "sns:*"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "form-details-codebuild"
      }
    },
    #notification-codebuild
    {
      identifier             = "notification-codebuild"
      iam_policy_description = "notification-codebuild"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "ecr:*",
            "cloudwatch:*",
            "s3:*",
            "logs:*",
            "codebuild:*",
            "ec2:*",
            "sns:*"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "notification-codebuild"
      }
    },
    #pdf-codebuild
    {
      identifier             = "pdf-codebuild"
      iam_policy_description = "pdf-codebuild"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "ecr:*",
            "cloudwatch:*",
            "s3:*",
            "logs:*",
            "codebuild:*",
            "ec2:*",
            "sns:*",
            "ssm:*"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "pdf-codebuild"
      }
    },
    #report-codebuild
    {
      identifier             = "report-codebuild"
      iam_policy_description = "report-codebuild"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "ecr:*",
            "cloudwatch:*",
            "s3:*",
            "logs:*",
            "codebuild:*",
            "ec2:*",
            "sns:*"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "report-codebuild"
      }
    },
    #announcement-be-codebuild
    {
      identifier             = "announcement-be-codebuild"
      iam_policy_description = "announcement-be-codebuild"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "ecr:*",
            "cloudwatch:*",
            "s3:*",
            "logs:*",
            "ec2:*"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "announcement-codebuild"
      }
    },
    #cp-policy-be-codebuild
    {
      identifier             = "cp-policy-be-codebuild"
      iam_policy_description = "cp-policy-be-codebuild"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "ecr:*",
            "cloudwatch:*",
            "s3:*",
            "logs:*",
            "ec2:*",
            "sns:*"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "report-codebuild"
      }
    },
    #announcement-fe-codebuild
    {
      identifier             = "announcement-fe-codebuild"
      iam_policy_description = "announcement-fe-codebuild"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "ecr:*",
            "cloudwatch:*",
            "s3:*",
            "logs:*",
            "codebuild:*",
            "ec2:*",
            "sns:*",
            "ssm:GetParameters"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "announcement-codebuild"
      }
    },
    #cp-policy-fe-codebuild
    {
      identifier             = "cp-policy-fe-codebuild"
      iam_policy_description = "cp-policy-fe-codebuild"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "ecr:*",
            "cloudwatch:*",
            "s3:*",
            "logs:*",
            "ec2:*",
            "sns:*",
            "ssm:GetParameters"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "report-codebuild"
      }
    },
    #cp-policy-rag-codebuild
    {
      identifier             = "cp-policy-rag-codebuild"
      iam_policy_description = "cp-policy-rag-codebuild"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "ecr:*",
            "cloudwatch:*",
            "s3:*",
            "logs:*",
            "ec2:*"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "report-codebuild"
      }
    },
    #cp-policy-rag-processor-lambda
    {
      identifier             = "cp-policy-rag-processor-lambda"
      iam_policy_description = "cp-policy-rag-processor-lambda"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "s3:ListAllMyBuckets",
            "s3:ListBucket",
            "s3:GetObject",
            "s3:PutObject",
            "kms:Decrypt"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "cp-policy-rag-processor-lambda"
      }
    },
    #announcement-lambda
    {
      identifier             = "announcement-lambda"
      iam_policy_description = "announcement-lambda"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "s3:ListAllMyBuckets",
            "s3:ListBucket",
            "s3:GetObject",
            "s3:PutObject",
            "kms:Decrypt"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "cp-policy-rag-processor-lambda"
      }
    },
    #yosan-management-be-codebuild
    {
      identifier             = "yosan-management-be-codebuild"
      iam_policy_description = "yosan-management-be-codebuild"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "ecr:*",
            "cloudwatch:*",
            "s3:*",
            "logs:*",
            "codebuild:*",
            "ec2:*",
            "sns:*"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "apply-approve-codebuild"
      }
    },
    #yosan-reporting-be-codebuild
    {
      identifier             = "yosan-reporting-be-codebuild"
      iam_policy_description = "yosan-reporting-be-codebuild"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "ecr:*",
            "cloudwatch:*",
            "s3:*",
            "logs:*",
            "codebuild:*",
            "ec2:*",
            "sns:*"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "yosan-reporting-codebuild"
      }
    },
    #yosan-management-fe-codebuild
    {
      identifier             = "yosan-management-fe-codebuild"
      iam_policy_description = "yosan-management-fe-codebuild"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "ecr:*",
            "cloudwatch:*",
            "s3:*",
            "logs:*",
            "codebuild:*",
            "ec2:*",
            "sns:*",
            "ssm:*"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "apply-approve-codebuild"
      }
    },
    #yosan-management-task
    {
      identifier             = "yosan-management-task"
      iam_policy_description = "yosan-management-task"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "secretsmanager:BatchGetSecretValue",
            "secretsmanager:ListSecrets",
            "secretsmanager:GetSecretValue",
            "secretsmanager:UpdateSecretVersionStage",
            "secretsmanager:TagResource",
            "ecr:BatchCheckLayerAvailability",
            "ecr:BatchGetImage",
            "ecr:GetDownloadUrlForLayer",
            "ecr:GetAuthorizationToken",
            "ecr:PutImageTagMutability",
            "logs:CreateLogDelivery",
            "logs:CreateLogStream",
            "logs:DeleteAccountPolicy",
            "logs:DeleteIndexPolicy",
            "logs:DeleteIntegration",
            "logs:DeleteLogDelivery",
            "logs:DeleteTransformer",
            "logs:DescribeFieldIndexes",
            "logs:DescribeIndexPolicies",
            "logs:FilterLogEvents",
            "logs:GetIntegration",
            "logs:GetLogDelivery",
            "logs:GetLogEvents",
            "logs:GetTransformer",
            "logs:Link",
            "logs:ListEntitiesForLogGroup",
            "logs:ListIntegrations",
            "logs:ListLogDeliveries",
            "logs:ListLogGroups*",
            "logs:ListTags*",
            "logs:PutAccountPolicy",
            "logs:PutIndexPolicy",
            "logs:PutIntegration",
            "logs:PutLogEvents",
            "logs:PutTransformer",
            "logs:StopLiveTail",
            "logs:Tag*",
            "logs:TestTransformer",
            "logs:Unmask",
            "logs:Untag*",
            "logs:UpdateLogDelivery",
            "secretsmanager:BatchGetSecretValue",
            "secretsmanager:GetSecretValue",
            "secretsmanager:ListSecrets",
            "secretsmanager:TagResource",
            "secretsmanager:UntagResource",
            "secretsmanager:UpdateSecretVersionStage",
            "ecr:BatchCheckLayerAvailability",
            "ecr:BatchGetImage",
            "ecr:BatchImportUpstreamImage",
            "ecr:CreateRepository",
            "ecr:GetAuthorizationToken",
            "ecr:GetDownloadUrlForLayer",
            "ecr:ListTagsForResource",
            "ecr:PutImageTagMutability",
            "ecr:PutLifecyclePolicy",
            "ecr:ReplicateImage",
            "ecr:SetRepositoryPolicy",
            "ecr:TagResource",
            "ecr:UntagResource",
            "ssmmessages:CreateControlChannel",
            "ssmmessages:CreateDataChannel",
            "ssmmessages:OpenControlChannel",
            "ssmmessages:OpenDataChannel",
            "s3:AbortMultipartUpload",
            "s3:BypassGovernanceRetention",
            "s3:CreateBucketMetadataTableConfiguration",
            "s3:CreateStorageLensGroup",
            "s3:DeleteBucketMetadataTableConfiguration",
            "s3:DeleteJobTagging",
            "s3:DeleteObject*",
            "s3:DeleteStorageLensConfigurationTagging",
            "s3:DeleteStorageLensGroup",
            "s3:GetBucketMetadataTableConfiguration",
            "s3:GetBucketTagging",
            "s3:GetJobTagging",
            "s3:GetObject",
            "s3:GetObjectAcl",
            "s3:GetObjectLegalHold",
            "s3:GetObjectRetention",
            "s3:GetObjectTagging",
            "s3:GetObjectTorrent",
            "s3:GetObjectVersion*",
            "s3:GetStorageLensConfigurationTagging",
            "s3:GetStorageLensGroup",
            "s3:InitiateReplication",
            "s3:ListAllMyBuckets",
            "s3:ListBucket",
            "s3:ListBucketVersions",
            "s3:ListCallerAccessGrants",
            "s3:ListMultipartUploadParts",
            "s3:ListStorageLensGroups",
            "s3:ListTagsForResource",
            "s3:ObjectOwnerOverrideToBucketOwner",
            "s3:PauseReplication",
            "s3:PutAccessPointPublicAccessBlock",
            "s3:PutBucketTagging",
            "s3:PutJobTagging",
            "s3:PutObject*",
            "s3:PutStorageLensConfigurationTagging",
            "s3:Replicate*",
            "s3:RestoreObject",
            "s3:TagResource",
            "s3:UntagResource",
            "s3:UpdateStorageLensGroup",
            "dynamodb:PartiQLUpdate",
            "dynamodb:UntagResource",
            "kms:Decrypt",
            "ssm:GetParameter",
            "ssm:GetParameters",
            "ssm:GetParametersByPath",
            "ssm:GetParameterHistory",
            "ssm:DescribeParameters",
            "ssm:DescribeDocumentParameters",
            "ssm:PutParameter"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "yosan-management-task"
      }
    },
    #yosan-management-task-second
    {
      identifier             = "yosan-management-task-second"
      iam_policy_description = "yosan-management-task-second"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "rds:DescribeAccountAttributes",
            "rds:DescribeBlueGreenDeployments",
            "rds:DescribeCertificates",
            "rds:DescribeDBClusterAutomatedBackups",
            "rds:DescribeDBClusterBacktracks",
            "rds:DescribeDBClusterEndpoints",
            "rds:DescribeDBClusterParameterGroups",
            "rds:DescribeDBClusterParameters",
            "rds:DescribeDBClusters",
            "rds:DescribeDBClusterSnapshotAttributes",
            "rds:DescribeDBClusterSnapshots",
            "rds:DescribeDBEngineVersions",
            "rds:DescribeDBInstances",
            "rds:DescribeDBLogFiles",
            "rds:DescribeDBParameterGroups",
            "rds:DescribeDBParameters",
            "rds:DescribeDBProxyEndpoints",
            "rds:DescribeDBProxies",
            "rds:DescribeDBProxyTargetGroups",
            "rds:DescribeDBProxyTargets",
            "rds:DescribeDBRecommendations",
            "rds:DescribeDBSecurityGroups",
            "rds:DescribeDBShardGroups",
            "rds:DescribeDBSnapshotAttributes",
            "rds:DescribeDBSnapshots",
            "rds:DescribeDBSnapshotTenantDatabases",
            "rds:DescribeDBSubnetGroups",
            "rds:DescribeEngineDefaultClusterParameters",
            "rds:DescribeEngineDefaultParameters",
            "rds:DescribeEventCategories",
            "rds:DescribeEvents",
            "rds:DescribeEventSubscriptions",
            "rds:DescribeExportTasks",
            "rds:DescribeGlobalClusters",
            "rds:DescribeIntegrations",
            "rds:DescribeOptionGroupOptions",
            "rds:DescribeOptionGroups",
            "rds:DescribeOrderableDBInstanceOptions",
            "rds:DescribePendingMaintenanceActions",
            "rds:DescribeReservedDBInstances",
            "rds:DescribeReservedDBInstancesOfferings",
            "rds:DescribeSourceRegions",
            "rds:DescribeValidDBInstanceModifications",
            "rds:DescribeTenantDatabases",
            "rds:DescribeRecommendationGroups",
            "rds:DescribeRecommendations",
            "rds:DownloadCompleteDBLogFile",
            "rds:DownloadDBLogFilePortion",
            "rds:ListTagsForResource",
            "rds:AddRoleToDBCluster",
            "rds:AddRoleToDBInstance",
            "rds:AddSourceIdentifierToSubscription",
            "rds:ApplyPendingMaintenanceAction",
            "rds:BacktrackDBCluster",
            "rds:CancelExportTask",
            "rds:CopyCustomDBEngineVersion",
            "rds:CopyDBClusterParameterGroup",
            "rds:CopyDBClusterSnapshot",
            "rds:CopyDBParameterGroup",
            "rds:CopyDBSnapshot",
            "rds:CopyOptionGroup",
            "rds:CreateBlueGreenDeployment",
            "rds:CreateCustomDBEngineVersion",
            "rds:CreateDBCluster",
            "rds:CreateDBClusterSnapshot",
            "rds:CreateDBClusterParameterGroup",
            "rds:CreateDBClusterEndpoint",
            "rds:CreateDBInstanceReadReplica",
            "rds:CreateDBParameterGroup",
            "rds:CreateDBProxy",
            "rds:CreateDBProxyEndpoint",
            "rds:CreateDBSecurityGroup",
            "rds:CreateDBShardGroup",
            "rds:CreateEventSubscription",
            "rds:CreateIntegration",
            "rds:CreateTenantDatabase",
            "rds:CreateOptionGroup",
            "rds:CrossRegionCommunication",
            "rds:EnableHttpEndpoint",
            "rds:FailoverDBCluster",
            "rds:FailoverGlobalCluster",
            "rds:ModifyActivityStream",
            "rds:ModifyCertificates",
            "rds:ModifyDBParameterGroup",
            "rds:PromoteReadReplica",
            "rds:AuthorizeDBSecurityGroupIngress",
            "vpce:AllowMultiRegion",
            "lambda:ListFunctions",
            "lambda:ListAliases",
            "lambda:ListCodeSigningConfigs",
            "lambda:ListEventSourceMappings",
            "lambda:ListFunctionEventInvokeConfigs",
            "lambda:ListFunctionsByCodeSigningConfig",
            "lambda:ListFunctionUrlConfigs",
            "lambda:ListLayers",
            "lambda:ListLayerVersions",
            "lambda:ListProvisionedConcurrencyConfigs",
            "lambda:ListVersionsByFunction",
            "lambda:GetAccountSettings",
            "lambda:GetAlias",
            "lambda:GetCodeSigningConfig",
            "lambda:GetEventSourceMapping",
            "lambda:GetFunction",
            "lambda:GetFunctionCodeSigningConfig",
            "lambda:GetFunctionConcurrency",
            "lambda:GetFunctionConfiguration",
            "lambda:GetFunctionEventInvokeConfig",
            "lambda:GetFunctionRecursionConfig",
            "lambda:GetFunctionUrlConfig",
            "lambda:GetLayerVersion",
            "lambda:GetLayerVersionPolicy",
            "lambda:GetPolicy",
            "lambda:GetProvisionedConcurrencyConfig",
            "lambda:GetRuntimeManagementConfig",
            "lambda:ListTags",
            "lambda:TagResource"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "yosan-management-task"
      }
    },
    #yosan-reporting-task
    {
      identifier             = "yosan-reporting-task"
      iam_policy_description = "yosan-reporting-task"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "secretsmanager:BatchGetSecretValue",
            "secretsmanager:ListSecrets",
            "secretsmanager:GetSecretValue",
            "secretsmanager:UpdateSecretVersionStage",
            "secretsmanager:TagResource",
            "ecr:BatchCheckLayerAvailability",
            "ecr:BatchGetImage",
            "ecr:GetDownloadUrlForLayer",
            "ecr:GetAuthorizationToken",
            "ecr:PutImageTagMutability",
            "logs:CreateLogDelivery",
            "logs:CreateLogStream",
            "logs:DeleteAccountPolicy",
            "logs:DeleteIndexPolicy",
            "logs:DeleteIntegration",
            "logs:DeleteLogDelivery",
            "logs:DeleteTransformer",
            "logs:DescribeFieldIndexes",
            "logs:DescribeIndexPolicies",
            "logs:FilterLogEvents",
            "logs:GetIntegration",
            "logs:GetLogDelivery",
            "logs:GetLogEvents",
            "logs:GetTransformer",
            "logs:Link",
            "logs:ListEntitiesForLogGroup",
            "logs:ListIntegrations",
            "logs:ListLogDeliveries",
            "logs:ListLogGroups*",
            "logs:ListTags*",
            "logs:PutAccountPolicy",
            "logs:PutIndexPolicy",
            "logs:PutIntegration",
            "logs:PutLogEvents",
            "logs:PutTransformer",
            "logs:StopLiveTail",
            "logs:Tag*",
            "logs:TestTransformer",
            "logs:Unmask",
            "logs:Untag*",
            "logs:UpdateLogDelivery",
            "secretsmanager:BatchGetSecretValue",
            "secretsmanager:GetSecretValue",
            "secretsmanager:ListSecrets",
            "secretsmanager:TagResource",
            "secretsmanager:UntagResource",
            "secretsmanager:UpdateSecretVersionStage",
            "ecr:BatchCheckLayerAvailability",
            "ecr:BatchGetImage",
            "ecr:BatchImportUpstreamImage",
            "ecr:CreateRepository",
            "ecr:GetAuthorizationToken",
            "ecr:GetDownloadUrlForLayer",
            "ecr:ListTagsForResource",
            "ecr:PutImageTagMutability",
            "ecr:PutLifecyclePolicy",
            "ecr:ReplicateImage",
            "ecr:SetRepositoryPolicy",
            "ecr:TagResource",
            "ecr:UntagResource",
            "ssmmessages:CreateControlChannel",
            "ssmmessages:CreateDataChannel",
            "ssmmessages:OpenControlChannel",
            "ssmmessages:OpenDataChannel",
            "s3:AbortMultipartUpload",
            "s3:BypassGovernanceRetention",
            "s3:CreateBucketMetadataTableConfiguration",
            "s3:CreateStorageLensGroup",
            "s3:DeleteBucketMetadataTableConfiguration",
            "s3:DeleteJobTagging",
            "s3:DeleteObject*",
            "s3:DeleteStorageLensConfigurationTagging",
            "s3:DeleteStorageLensGroup",
            "s3:GetBucketMetadataTableConfiguration",
            "s3:GetBucketTagging",
            "s3:GetJobTagging",
            "s3:GetObject",
            "s3:GetObjectAcl",
            "s3:GetObjectLegalHold",
            "s3:GetObjectRetention",
            "s3:GetObjectTagging",
            "s3:GetObjectTorrent",
            "s3:GetObjectVersion*",
            "s3:GetStorageLensConfigurationTagging",
            "s3:GetStorageLensGroup",
            "s3:InitiateReplication",
            "s3:ListAllMyBuckets",
            "s3:ListBucket",
            "s3:ListBucketVersions",
            "s3:ListCallerAccessGrants",
            "s3:ListMultipartUploadParts",
            "s3:ListStorageLensGroups",
            "s3:ListTagsForResource",
            "s3:ObjectOwnerOverrideToBucketOwner",
            "s3:PauseReplication",
            "s3:PutAccessPointPublicAccessBlock",
            "s3:PutBucketTagging",
            "s3:PutJobTagging",
            "s3:PutObject*",
            "s3:PutStorageLensConfigurationTagging",
            "s3:Replicate*",
            "s3:RestoreObject",
            "s3:TagResource",
            "s3:UntagResource",
            "s3:UpdateStorageLensGroup",
            "dynamodb:PartiQLUpdate",
            "dynamodb:UntagResource",
            "kms:Decrypt",
            "ssm:GetParameter",
            "ssm:GetParameters",
            "ssm:GetParametersByPath",
            "ssm:GetParameterHistory",
            "ssm:DescribeParameters",
            "ssm:DescribeDocumentParameters",
            "ssm:PutParameter"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "yosan-reporting-task"
      }
    },
    #yosan-reporting-task-second
    {
      identifier             = "yosan-reporting-task-second"
      iam_policy_description = "yosan-reporting-task-second"
      iam_policy_statements = [
        {
          effect = "Allow"
          actions = [
            "rds:DescribeAccountAttributes",
            "rds:DescribeBlueGreenDeployments",
            "rds:DescribeCertificates",
            "rds:DescribeDBClusterAutomatedBackups",
            "rds:DescribeDBClusterBacktracks",
            "rds:DescribeDBClusterEndpoints",
            "rds:DescribeDBClusterParameterGroups",
            "rds:DescribeDBClusterParameters",
            "rds:DescribeDBClusters",
            "rds:DescribeDBClusterSnapshotAttributes",
            "rds:DescribeDBClusterSnapshots",
            "rds:DescribeDBEngineVersions",
            "rds:DescribeDBInstances",
            "rds:DescribeDBLogFiles",
            "rds:DescribeDBParameterGroups",
            "rds:DescribeDBParameters",
            "rds:DescribeDBProxyEndpoints",
            "rds:DescribeDBProxies",
            "rds:DescribeDBProxyTargetGroups",
            "rds:DescribeDBProxyTargets",
            "rds:DescribeDBRecommendations",
            "rds:DescribeDBSecurityGroups",
            "rds:DescribeDBShardGroups",
            "rds:DescribeDBSnapshotAttributes",
            "rds:DescribeDBSnapshots",
            "rds:DescribeDBSnapshotTenantDatabases",
            "rds:DescribeDBSubnetGroups",
            "rds:DescribeEngineDefaultClusterParameters",
            "rds:DescribeEngineDefaultParameters",
            "rds:DescribeEventCategories",
            "rds:DescribeEvents",
            "rds:DescribeEventSubscriptions",
            "rds:DescribeExportTasks",
            "rds:DescribeGlobalClusters",
            "rds:DescribeIntegrations",
            "rds:DescribeOptionGroupOptions",
            "rds:DescribeOptionGroups",
            "rds:DescribeOrderableDBInstanceOptions",
            "rds:DescribePendingMaintenanceActions",
            "rds:DescribeReservedDBInstances",
            "rds:DescribeReservedDBInstancesOfferings",
            "rds:DescribeSourceRegions",
            "rds:DescribeValidDBInstanceModifications",
            "rds:DescribeTenantDatabases",
            "rds:DescribeRecommendationGroups",
            "rds:DescribeRecommendations",
            "rds:DownloadCompleteDBLogFile",
            "rds:DownloadDBLogFilePortion",
            "rds:ListTagsForResource",
            "rds:AddRoleToDBCluster",
            "rds:AddRoleToDBInstance",
            "rds:AddSourceIdentifierToSubscription",
            "rds:ApplyPendingMaintenanceAction",
            "rds:BacktrackDBCluster",
            "rds:CancelExportTask",
            "rds:CopyCustomDBEngineVersion",
            "rds:CopyDBClusterParameterGroup",
            "rds:CopyDBClusterSnapshot",
            "rds:CopyDBParameterGroup",
            "rds:CopyDBSnapshot",
            "rds:CopyOptionGroup",
            "rds:CreateBlueGreenDeployment",
            "rds:CreateCustomDBEngineVersion",
            "rds:CreateDBCluster",
            "rds:CreateDBClusterSnapshot",
            "rds:CreateDBClusterParameterGroup",
            "rds:CreateDBClusterEndpoint",
            "rds:CreateDBInstanceReadReplica",
            "rds:CreateDBParameterGroup",
            "rds:CreateDBProxy",
            "rds:CreateDBProxyEndpoint",
            "rds:CreateDBSecurityGroup",
            "rds:CreateDBShardGroup",
            "rds:CreateEventSubscription",
            "rds:CreateIntegration",
            "rds:CreateTenantDatabase",
            "rds:CreateOptionGroup",
            "rds:CrossRegionCommunication",
            "rds:EnableHttpEndpoint",
            "rds:FailoverDBCluster",
            "rds:FailoverGlobalCluster",
            "rds:ModifyActivityStream",
            "rds:ModifyCertificates",
            "rds:ModifyDBParameterGroup",
            "rds:PromoteReadReplica",
            "rds:AuthorizeDBSecurityGroupIngress",
            "vpce:AllowMultiRegion",
            "lambda:ListFunctions",
            "lambda:ListAliases",
            "lambda:ListCodeSigningConfigs",
            "lambda:ListEventSourceMappings",
            "lambda:ListFunctionEventInvokeConfigs",
            "lambda:ListFunctionsByCodeSigningConfig",
            "lambda:ListFunctionUrlConfigs",
            "lambda:ListLayers",
            "lambda:ListLayerVersions",
            "lambda:ListProvisionedConcurrencyConfigs",
            "lambda:ListVersionsByFunction",
            "lambda:GetAccountSettings",
            "lambda:GetAlias",
            "lambda:GetCodeSigningConfig",
            "lambda:GetEventSourceMapping",
            "lambda:GetFunction",
            "lambda:GetFunctionCodeSigningConfig",
            "lambda:GetFunctionConcurrency",
            "lambda:GetFunctionConfiguration",
            "lambda:GetFunctionEventInvokeConfig",
            "lambda:GetFunctionRecursionConfig",
            "lambda:GetFunctionUrlConfig",
            "lambda:GetLayerVersion",
            "lambda:GetLayerVersionPolicy",
            "lambda:GetPolicy",
            "lambda:GetProvisionedConcurrencyConfig",
            "lambda:GetRuntimeManagementConfig",
            "lambda:ListTags",
            "lambda:TagResource"
          ]
          resources = ["*"]
        }
      ]
      tags = {
        Purpose = "yosan-reporting-task"
      }
    }
  ]

  policy_configs_map = { for idx, config in local.policy_configs : config.identifier => config }
}

module "iam_policy" {
  for_each     = local.policy_configs_map
  source       = "../modules/IAM_Policy"
  identifier   = each.value.identifier
  environment  = var.environment
  vendor       = var.vendor
  project_name = var.project_name

  #   iam_policy_name        = each.value.iam_policy_name
  iam_policy_statements  = each.value.iam_policy_statements
  iam_policy_description = try(each.value.iam_policy_description, null)
  tags                   = each.value.tags
}

###-------------- Module outputs --------------###
# Example
# module.iam_policy["name-key"].policy_arn

# output "policy_name" {
#   value = module.iam_policy[local.policy_configs[0].iam_policy_name].policy_name
# }

# output "policy_arn" {
#   value = module.iam_policy[local.policy_configs[0].iam_policy_name].policy_arn
# }