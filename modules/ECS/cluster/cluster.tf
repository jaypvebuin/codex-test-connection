#------------------- Cluster Logging configs -------------------#
resource "aws_cloudwatch_log_group" "cluster_log" {
  count = var.cluster_configuration.execute_command_configuration.logging != "NONE" ? 1 : 0
  name  = "${var.vendor}-${var.project_name}-${var.identifier}-${var.environment}-log-group"
  tags = merge({
    Name = "${var.vendor}-${var.project_name}-${var.identifier}-${var.environment}-log-group",
    module = var.module
  }, var.tags)
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.vendor}-${var.project_name}-${var.identifier}-cluster-${var.environment}"

  # Enable Container Insights if variable is true
  setting {
    name  = "containerInsights"
    value = var.container_insights_enabled ? "enabled" : "disabled"
  }

  dynamic "configuration" {
    for_each = try([var.cluster_configuration], [])

    content {
      dynamic "execute_command_configuration" {
        for_each = try([configuration.value.execute_command_configuration], [{}])

        content {
          kms_key_id = try(execute_command_configuration.value.kms_key_id, null)
          logging    = try(execute_command_configuration.value.logging, "DEFAULT")

          dynamic "log_configuration" {
            for_each = try([execute_command_configuration.value.log_configuration], [])

            content {
              cloud_watch_encryption_enabled = try(log_configuration.value.cloud_watch_encryption_enabled, null)
              cloud_watch_log_group_name     = try(aws_cloudwatch_log_group.cluster_log[0].id, null)
              s3_bucket_name                 = try(log_configuration.value.s3_bucket_name, null)
              s3_bucket_encryption_enabled   = try(log_configuration.value.s3_bucket_encryption_enabled, null)
              s3_key_prefix                  = try(log_configuration.value.s3_key_prefix, null)
            }
          }
        }
      }
      dynamic "managed_storage_configuration" {
        for_each = try([configuration.value.managed_storage_configuration], [{}])

        content {
          kms_key_id = try(managed_storage_configuration.value.kms_key_id, null)
          fargate_ephemeral_storage_kms_key_id   = try(managed_storage_configuration.value.fargate_ephemeral_storage_kms_key_id, null)
        }
      }
    }
  }

  tags = merge({
    Name = "${var.vendor}-${var.project_name}-${var.identifier}-${var.environment}-cluster",
    module = var.module
  }, var.tags)
}