resource "aws_rds_cluster" "postgresql" {
  cluster_identifier              = var.cluster_name
  engine                          = var.engine
  engine_mode                     = var.engine_mode
  engine_version                  = var.engine_version
  database_name                   = var.database_name
  master_username                 = jsondecode(data.aws_secretsmanager_secret_version.db_secret.secret_string)["username"]
  master_password                 = jsondecode(data.aws_secretsmanager_secret_version.db_secret.secret_string)["password"]
  port                            = var.port
  backup_retention_period         = var.backup_retention_period
  preferred_backup_window         = var.preferred_backup_window
  db_subnet_group_name            = aws_db_subnet_group.db_subnet_group.id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.rds_cluster_parameter_group.id
  deletion_protection             = var.deletion_protection
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  vpc_security_group_ids          = var.vpc_security_group_ids
  skip_final_snapshot             = var.skip_final_snapshot
  final_snapshot_identifier       = var.final_snapshot_identifier
  snapshot_identifier             = var.snapshot_identifier

  dynamic "scaling_configuration" {
    for_each = length(var.scaling_configuration) > 0 ? [var.scaling_configuration] : []

    content {
      auto_pause   = scaling_configuration.value.auto_pause
      max_capacity = scaling_configuration.value.max_capacity
      min_capacity = scaling_configuration.value.min_capacity
    }
  }

  dynamic "serverlessv2_scaling_configuration" {
    for_each = length(var.serverlessv2_scaling_configuration) > 0 ? [var.serverlessv2_scaling_configuration] : []

    content {
      max_capacity = serverlessv2_scaling_configuration.value.max_capacity
      min_capacity = serverlessv2_scaling_configuration.value.min_capacity
    }
  }

  tags = (merge(var.tags, var.common_tags))

  lifecycle {
    ignore_changes = [master_username]
  }
}

resource "aws_rds_cluster_instance" "cluster_instance" {
  count = var.instance_count

  cluster_identifier      = aws_rds_cluster.postgresql.id
  identifier              = "${var.cluster_name}-instance-${count.index}"
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.id
  db_parameter_group_name = aws_db_parameter_group.db_parameter_group.id
  # preferred_backup_window    = var.preferred_backup_window
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  tags                       = (merge(var.tags, var.common_tags))
  apply_immediately          = true
}